Message-ID: <003f01c3bd59$d75e8220$4844900a@hydingnb1>
From: "hyding" <nari_dhy@nari-china.com>
To: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
Subject: root over NFS
Date: Mon, 8 Dec 2003 15:06:45 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
    I am trying to mount the root fs on NFS.The target is the ML300
demo board and mvl pro3.0. In target kernel,i configure File systems
--->Network File Systems ---> NFS file system support (Provide NFSv3
client support; Root file system on NFS).The bootargs are "console=ttyS0
9600 root=/dev/nfs rw".
    In host RedHat 7.3,i configure the kernel as the following:File
systems --->Network File Systems ---> NFS server support(
Provide NFSv3 server support;Provide NFS server over TCP support
(EXPERIMENTAL)),Networking options --->Packet socket and Socket
Filtering. I install nfs-utils-0.3.3-5 and portmap-4.0-41.It displays
the following info after restarting the two daemon:

[root linux-2.4.22]# /etc/rc.d/init.d/nfs restart
Stopping NFS mountd:                                       [  OK  ]
Stopping NFS daemon:                                       [  OK  ]
Stopping NFS services:                                     [  OK  ]
Stopping NFS quotas:                                       [  OK  ]
Starting NFS services:                                     [  OK  ]
Starting NFS quotas:                                       [  OK  ]
Starting NFS mountd:                                       [  OK  ]
Starting NFS daemon:                                       [  OK  ]
[root linux-2.4.22]# /etc/rc.d/init.d/portmap restart
Stopping portmapper:                                       [  OK  ]
Starting portmapper:                                       [  OK  ]

However the target fails after it mount NFS.The errors are,
...
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.144.68.74, my address is 10.144.68.73
IP-Config: Complete:
      device=eth0, addr=10.144.68.73, mask=255.255.255.0, gw=10.144.68.254,
     host=hyding-ml300, domain=naridomain, nis-domain=(none),
     bootserver=10.144.68.74, rootserver=10.144.68.74, rootpath=/opt/hardhat/dev
kit/ppc/405/target
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.144.68.74
Looking up port of RPC 100005/1 on 10.144.68.74
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
nfs: server 10.144.68.74 not responding, still trying
nfs: server 10.144.68.74 not responding, still trying
nfs: task 19 can't get a request slot
nfs: task 20 can't get a request slot
nfs: task 21 can't get a request slot
nfs: task 22 can't get a request slot
nfs: task 23 can't get a request sl
nfs: task 23 can't get a request sl

Will someone give me any hints?
Thanks!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
