Message-ID: <000901c2596f$b28b49f0$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel panic: No init found.  Try passing init= option to kernel
Date: Wed, 11 Sep 2002 16:46:18 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
    I want to use ramdisk instead of NFS for my linux on FADS860T which has 2M flash and 8M ram.I want to use eldk pakages to make ramdisk. but when i use it to boot linux ,it print the following message:

IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
enter ic_enable!
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 735k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 56k init
Kernel panic: No init found.  Try passing init= option to kernel.


I am sure that /bin/sh exist.why linux can not execute it successfully? but when I use the simple-ramdisk.PPCBoot which i download frow file://ftp.denx.de:/pub/LinuxPPC/usr/src,it run well like following:


=>bootm 400000 500000
## Booting image at 00400000 ...
   Image Name:   linux-2.4.18
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    525046 Bytes = 512 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00500000 ...
   Image Name:   myramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    572675 Bytes = 559 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 006cf000, end 0075ad03 ... OK
Linux version 2.4.18 (root@localhost.localdomain) (gcc version 2.95.3 20010111 (
prerelease/franzo/20010111)) #2 Wed Sep 11 15:10:46 CST 2002
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 6132k available (948k kernel code, 348k data, 56k init, 0k highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
eth1: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:d0:93:80:12:34
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
enter ic_enable!
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 559k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 56k init
bash# ls
bin         dev         etc         lib         linuxrc     lost+found
bash# cd bin
bash# ls
date  ls    sh
bash# date
Thu Jan  1 02:47:51 UTC 1970
bash# ls
date  ls    sh
bash# cd lib
init: lib: No such file or directory
bash# cd ..
bash# ls
bin         dev         etc         lib         linuxrc     lost+found
bash# cd lib
bash# ls
ld.so.1              libcrypt.so.1        libtermcap.so.2.0.8
libc-1.99.so         libproc.so.1.2.6
libc.so.6            libtermcap.so.2
bash# cd ..
bash# ls
bin         dev         etc         lib         linuxrc     lost+found
bash#



    Why Simple-ramdisk.PPCBoot is ok but My ramdisk.image is not ok,i cant find the diffrent from this two, ths sh program need libray all exist,why linux cant excute successfully?
    Can someone give me help ? thank you in advanced!
    Hope to get your help!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
