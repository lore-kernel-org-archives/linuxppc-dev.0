From: "aa aaa" <linux_powerpc@hotmail.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: also the problem of creating jffs2
Date: Fri, 14 May 2004 10:19:39 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY13-F40ODt9Cz93Mg00011534@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


root@172.16.115.7:/# more /proc/mtd
dev:    size   erasesize  name
mtd0: 01000000 00040000 "RPX"
mtd1: 00080000 00040000 "UBOOT partition"
mtd2: 00180000 00040000 "KERNEL partition"
mtd3: 00e00000 00040000 "JFFS2  partition"
but I run the command:
root@172.16.115.7:/# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root             10346120   6484925   3431619  66% /
root@172.16.115.7:/# eraseall /dev/mtd3
eraseall: /dev/mtd3: No such device
what is wrong ?
following is the kernel runnig message:
 ## Booting image at 00200000 ...
   Image Name:   Linux-2.4.18_mvl30-rpxlite
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    715001 Bytes = 698.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.18_mvl30-rpxlite (root@localhost.localdomain) (gcc
version 3.2.1 20020930 (MontaVista)) #1  ËÄ 5ÔÂ 13 22:57:01 CST 2004
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/nfs rw
nfsroot=172.16.115.2:/workspace/myfilesystem/target
ip=172.16.115.7:172.16.115.2:0.0.0.172:255.255.255.0::eth0:off panic=1
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 62828k available (1240k kernel code, 368k data, 56k init, 0k
highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
Journalled Block Device driver loaded
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications AB.
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:37:5b
loop: loaded (max 8 devices)
RPX Lite or CLLF flash device: 4000000 at ff000000
 Amd/Fujitsu Extended Query Table v1.2 at 0x0040
number of CFI chips: 1
Creating 3 MTD partitions on "RPX":
0x00000000-0x00080000 : "UBOOT partition"
0x00080000-0x00200000 : "KERNEL partition"
0x00200000-0x01000000 : "JFFS2  partition"
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
IP-Config: Gateway not on directly connected network.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.115.2
Looking up port of RPC 100005/1 on 172.16.115.2
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.22 (22-Jun-2001)
Calculating module dependencies... depmod: *** Unresolved symbols in
/lib/modules/2.4.18_mvl30-rpxlite/kernel/drivers/ide/ide-cs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18_mvl30-rpxlite/kernel/fs/nfsd/nfsd.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18_mvl30-rpxlite/kernel/fs/smbfs/smbfs.o
done.
Loading modules:
mkdir: cannot create directory `/dev/pts': File exists
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 3
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.

MontaVista Linux 3.0, Professional Edition

I just modify the /drive/mtd/maps/rpxlite.c ,this is the place i modify
/*#define WINDOW_ADDR 0xfe000000
#define WINDOW_SIZE 0x800000
-----------*/

#define WINDOW_ADDR 0xff000000
#define WINDOW_SIZE 0x1000000
/* Flash / Partition sizing */
/*#define MAX_SIZE_KiB              8192
#define BOOT_PARTITION_SIZE_KiB    512
#define KERNEL_PARTITION_SIZE_KiB 1536
#define APP_PARTITION_SIZE_KiB    6144
*/

#define MAX_SIZE_KiB              16384
#define BOOT_PARTITION_SIZE_KiB    512
#define KERNEL_PARTITION_SIZE_KiB 1536
#define APP_PARTITION_SIZE_KiB    14236

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
