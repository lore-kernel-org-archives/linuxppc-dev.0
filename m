Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001001c25e1e$c9c33ac0$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Wolfgang Denk" <wd@denx.de>
Subject: Why FEC and SCC1 can not work at the same time?
Date: Tue, 17 Sep 2002 15:49:44 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,every one
    Hello Wolf gang thank you for help!my ramdisk problem has passed!I use linux-2.4.4-2002-02-14 kernel and all is ok!but I dont understand why linux-2.4.18 is not ok.


Now I meet a new problem! it is very strange!
I want to use FEC(100M) and SCC1(10M) interface,but they can not work together.
     When I use ppcboot with CONFIG_SCC1_ENET defined , boot linux ,then SCC1 is ok,when I ping FEC (I config it ip address is 192.168.2.221) it displayed messaged "time out".
     When I use ppcboot with CONFIG_FEC_ENET  defined,  boot linux ,then FEC is ok, when I
ping SCC( I config it ip address is 192.168.1.198) it displayed messaged also "time out".

Can you someone give help?thank you in advanced! the following is the linux output:

>bootm 400000 500000
## Booting image at 00400000 ...
   Image Name:   kernel
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    484192 Bytes = 472 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00500000 ...
   Image Name:   ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    933860 Bytes = 911 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00677000, end 0075afe4 ... OK
Linux version 2.4.4-rthal5 (root@localhost.localdomain) (gcc version 2.95.2 1999
1024 (release)) #1 Tue Sep 17 09:45:41 CST 2002
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Decrementer Frequency: 3000000
Calibrating delay loop... 47.71 BogoMIPS
Memory: 5784k available (900k kernel code, 388k data, 40k init, 0k highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SCC2 at 0x0100, BRG2
block: queued sectors max/low 3725kB/1241kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
eth1: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:d0:93:80:12:34
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 911k freed
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 40k init
init started:  BusyBox v0.60.2 (2002.07.18-17:16+0000) multi-call SIOCADDRT: Net
work is unreachable

    ******(What reason ? when this message output?)


BusyBox v0.60.2 (2002.07.18-17:16+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:D0:93:00:12:34
          inet addr:192.168.2.221  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:64 (64.0 b)  TX bytes:0 (0.0 b)
          Base address:0x3c00

eth1      Link encap:Ethernet  HWaddr 00:D0:93:80:12:34
          inet addr:192.168.1.198  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0xe00

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

#

Current config is PPCboot with SCC1 ,the result is eth0 can work but eth1 is bad!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
