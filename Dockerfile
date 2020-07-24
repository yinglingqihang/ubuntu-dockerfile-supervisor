FROM ubuntu:16.04


MAINTAINER zzling(13720016210@163.com)

RUN apt-get update && apt-get -y install \
    gcc \
    make \
    zlib1g-dev \
    redis-server \
    supervisor && rm -rf /var/lib/apt/lists/*

COPY Python-3.6.5.tgz /home

RUN tar -xf /home/Python-3.6.5.tgz && cd /Python-3.6.5 && ./configure && make && make install && rm -rf /home/Python-3.6.5.tgz 

RUN pip3 install numpy \
    pandas \
    sqlalchemy \
    celery \
    pymysql \
    aliyun-mns -i http://pypi.douban.com/simple --trusted-host pypi.douban.com


COPY redis.conf /etc/redis/
COPY supervisor.conf /etc/supervisor/conf.d/

COPY start.sh /home/

VOLUME ["/data","/data"]
ENTRYPOINT ["/bin/bash","/home/start.sh" ]
