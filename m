Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <EA78B62757AF1E4799828249310AC4CA04E09F03@stca206a.bus.sc.rolm.com>
From: "Smith, Craig" <Craig.Smith@icn.siemens.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Dynamic lib loading & memory question
Date: Thu, 24 Jun 2004 14:58:55 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I have a simple hello world program I'm trying to compile and run on a
custom PPC(855T) board. It will work fine if I statically link the
executable with the necessary libs. However if I don't statically link
(relying on ld.so etc.), the program will core dump. My system has 16M of
SDRAM (I just upgraded it from 8M and I believe it's configured right).
Anyway, here's the output and other info that might help someone tell me
what I'm doing wrong...thanks so much!

Also, please see a question at the very bottom about memory...

########################################
### The "good" version:
########################################
root@raptorlinux->~ [9] ./hw_ppc-static
Hello world 1 times!
Hello world 2 times!
Hello world 3 times!
Hello world 4 times!
Hello world 5 times!
Hello world 6 times!
Hello world 7 times!
Hello world 8 times!
Hello world 9 times!

########################################
### strace of the "good" version:
########################################
root@raptorlinux->~ [13] strace hw_ppc-static
execve("./hw_ppc-static", ["hw_ppc-static"], [/* 9 vars */]) = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
geteuid()                               = 0
getuid()                                = 0
getegid()                               = 0
getgid()                                = 0
brk(0)                                  = 0x1007d574
brk(0x1007e574)                         = 0x1007e574
brk(0x1007f000)                         = 0x1007f000
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(3, 0), ...}) = 0
ioctl(1, TCGETS or TCGETS, {B38400 opost isig icanon echo ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30000000
write(1, "Hello world 1 times!\n", 21Hello world 1 times!)  = 21
write(1, "Hello world 2 times!\n", 21Hello world 2 times!)  = 21
write(1, "Hello world 3 times!\n", 21Hello world 3 times!)  = 21
write(1, "Hello world 4 times!\n", 21Hello world 4 times!)  = 21
write(1, "Hello world 5 times!\n", 21Hello world 5 times!)  = 21
write(1, "Hello world 6 times!\n", 21Hello world 6 times!)  = 21
write(1, "Hello world 7 times!\n", 21Hello world 7 times!)  = 21
write(1, "Hello world 8 times!\n", 21Hello world 8 times!)  = 21
write(1, "Hello world 9 times!\n", 21Hello world 9 times!)  = 21
munmap(0x30000000, 4096)                = 0
exit(0)                                 = ?

########################################
### The "bad" version:
########################################
root@raptorlinux->~ [10] ./hw_ppc
Segmentation fault (core dumped)

########################################
### strace of the "bad" version:
########################################
root@raptorlinux->~ [11] strace ./hw_ppc
execve("./hw_ppc", ["./hw_ppc"], [/* 9 vars */]) = 0
brk(0)                                  = 0x10010898
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\317"..., 1024)
= 1024
fstat64(3, {st_mode=S_IFREG|0777, st_size=1295844, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV (core dumped) +++

########################################
### Here's my lib directory:
########################################
root@raptorlinux->~ [12] ls -l /lib
-rwxrwxrwx    1 root     root         1272 Jun  8  2003 Mcrt1.o
-rwxrwxrwx    1 root     root         8596 Jun  8  2003 crt1.o
-rwxrwxrwx    1 root     root         2344 Jun  8  2003 crti.o
-rwxrwxrwx    1 root     root         1956 Jun  8  2003 crtn.o
drwxrwxrwx    3 root     root          512 Jan 12 18:32 gcc-lib
drwxrwxrwx    2 root     root         4096 Jan 12 18:32 gconv
-rwxrwxrwx    1 root     root        28977 Jun  8  2003 gcrt1.o
-rwxrwxrwx    1 root     root        97916 Jun 21 13:48 ld-2.3.1.so
lrwxrwxrwx    1 root     root           11 Jun 18 20:47 ld.so.1 ->
ld-2.3.1.so
drwxrwxrwx    2 root     root         1024 Jan 12 18:32 ldscripts
-rwxrwxrwx    1 root     root         5040 Jun 21 13:48
libBrokenLocale-2.3.1.so
-rwxrwxrwx    1 root     root        30066 Jun  8  2003 libBrokenLocale.a
lrwxrwxrwx    1 root     root           20 Jun 18 20:47 libBrokenLocale.so
-> libBrokenLocale.so.1
lrwxrwxrwx    1 root     root           24 Jun 18 20:47 libBrokenLocale.so.1
-> libBrokenLocale-2.3.1.so
-rwxrwxrwx    1 root     root        15100 Jun 21 13:48 libSegFault.so
-rwxrwxrwx    1 root     root        11340 Jun 21 13:48 libanl-2.3.1.so
-rwxrwxrwx    1 root     root       181068 Jun  8  2003 libanl.a
lrwxrwxrwx    1 root     root           11 Jun 18 20:47 libanl.so ->
libanl.so.1
lrwxrwxrwx    1 root     root           15 Jun 18 20:47 libanl.so.1 ->
libanl-2.3.1.so
-rwxrwxrwx    1 root     root         2014 Jun  8  2003 libbsd-compat.a
-rwxrwxrwx    1 root     root      1295844 Jun 21 13:48 libc-2.3.1.so
-rwxrwxrwx    1 root     root     27451288 Jun  8  2003 libc.a
-rwxrwxrwx    1 root     root          198 Jun  8  2003 libc.so
lrwxrwxrwx    1 root     root           13 Jun 18 20:47 libc.so.6 ->
libc-2.3.1.so
-rwxrwxrwx    1 root     root        58444 Jun  8  2003 libc_nonshared.a
-rwxrwxrwx    1 root     root        21460 Jun 21 13:48 libcrypt-2.3.1.so
-rwxrwxrwx    1 root     root       101658 Jun  8  2003 libcrypt.a
lrwxrwxrwx    1 root     root           13 Jun 18 20:47 libcrypt.so ->
libcrypt.so.1
lrwxrwxrwx    1 root     root           17 Jun 18 20:47 libcrypt.so.1 ->
libcrypt-2.3.1.so
-rwxrwxrwx    1 root     root        10616 Jun 21 13:48 libdl-2.3.1.so
-rwxrwxrwx    1 root     root        43032 Jun  8  2003 libdl.a
lrwxrwxrwx    1 root     root           10 Jun 18 20:47 libdl.so ->
libdl.so.2
lrwxrwxrwx    1 root     root           14 Jun 18 20:47 libdl.so.2 ->
libdl-2.3.1.so
-rwxrwxrwx    1 root     root        19230 Oct 19  2003 libfrtbegin.a
-rwxrwxrwx    1 root     root         2014 Jun  8  2003 libg.a
lrwxrwxrwx    1 root     root           13 Jun 18 20:47 libgcc_s.so ->
libgcc_s.so.1
-rwxrwxrwx    1 root     root        52796 Jun 21 13:48 libgcc_s.so.1
lrwxrwxrwx    1 root     root           17 Jun 18 20:47 libgcc_s_nof.so ->
libgcc_s_nof.so.1
-rwxrwxrwx    1 root     root        51768 Jun 21 13:48 libgcc_s_nof.so.1
-rwxrwxrwx    1 root     root       854630 Oct 19  2003 libiberty.a
-rwxrwxrwx    1 root     root         2412 Jun  8  2003 libieee.a
-rwxrwxrwx    1 root     root       485568 Jun 21 13:48 libm-2.3.1.so
-rwxrwxrwx    1 root     root      3031178 Jun  8  2003 libm.a
lrwxrwxrwx    1 root     root            9 Jun 18 20:47 libm.so -> libm.so.6
lrwxrwxrwx    1 root     root           13 Jun 18 20:47 libm.so.6 ->
libm-2.3.1.so
-rwxrwxrwx    1 root     root         3268 Jun  8  2003 libmcheck.a
-rwxrwxrwx    1 root     root        18820 Jun 21 13:48 libmemusage.so
-rwxrwxrwx    1 root     root        79408 Jun 21 13:48 libnsl-2.3.1.so
-rwxrwxrwx    1 root     root      1936802 Jun  8  2003 libnsl.a
lrwxrwxrwx    1 root     root           11 Jun 18 20:47 libnsl.so ->
libnsl.so.1
lrwxrwxrwx    1 root     root           15 Jun 18 20:47 libnsl.so.1 ->
libnsl-2.3.1.so
-rwxrwxrwx    1 root     root        46708 Jun 21 13:48
libnss_compat-2.3.1.so
lrwxrwxrwx    1 root     root           18 Jun 18 20:47 libnss_compat.so ->
libnss_compat.so.2
lrwxrwxrwx    1 root     root           22 Jun 18 20:47 libnss_compat.so.2
-> libnss_compat-2.3.1.so
-rwxrwxrwx    1 root     root        14832 Jun 21 13:48 libnss_dns-2.3.1.so
lrwxrwxrwx    1 root     root           15 Jun 18 20:47 libnss_dns.so ->
libnss_dns.so.2
lrwxrwxrwx    1 root     root           19 Jun 18 20:47 libnss_dns.so.2 ->
libnss_dns-2.3.1.so
-rwxrwxrwx    1 root     root        43852 Jun 21 13:48
libnss_files-2.3.1.so
lrwxrwxrwx    1 root     root           17 Jun 18 20:47 libnss_files.so ->
libnss_files.so.2
lrwxrwxrwx    1 root     root           21 Jun 18 20:47 libnss_files.so.2 ->
libnss_files-2.3.1.so
-rwxrwxrwx    1 root     root        17504 Jun 21 13:48
libnss_hesiod-2.3.1.so
lrwxrwxrwx    1 root     root           18 Jun 18 20:47 libnss_hesiod.so ->
libnss_hesiod.so.2
lrwxrwxrwx    1 root     root           22 Jun 18 20:47 libnss_hesiod.so.2
-> libnss_hesiod-2.3.1.so
-rwxrwxrwx    1 root     root        40416 Jun 21 13:48 libnss_nis-2.3.1.so
lrwxrwxrwx    1 root     root           15 Jun 18 20:47 libnss_nis.so ->
libnss_nis.so.2
lrwxrwxrwx    1 root     root           19 Jun 18 20:47 libnss_nis.so.2 ->
libnss_nis-2.3.1.so
-rwxrwxrwx    1 root     root        49148 Jun 21 13:48
libnss_nisplus-2.3.1.so
lrwxrwxrwx    1 root     root           19 Jun 18 20:47 libnss_nisplus.so ->
libnss_nisplus.so.2
lrwxrwxrwx    1 root     root           23 Jun 18 20:47 libnss_nisplus.so.2
-> libnss_nisplus-2.3.1.so
-rwxrwxrwx    1 root     root        10504 Jun 21 13:48 libpcprofile.so
-rwxrwxrwx    1 root     root        72808 Jun 21 13:48 libpthread-0.10.so
-rwxrwxrwx    1 root     root      1529406 Jun  8  2003 libpthread.a
lrwxrwxrwx    1 root     root           15 Jun 18 20:47 libpthread.so ->
libpthread.so.0
lrwxrwxrwx    1 root     root           18 Jun 18 20:47 libpthread.so.0 ->
libpthread-0.10.so
-rwxrwxrwx    1 root     root        64700 Jun 21 13:48 libresolv-2.3.1.so
-rwxrwxrwx    1 root     root       685912 Jun  8  2003 libresolv.a
lrwxrwxrwx    1 root     root           14 Jun 18 20:47 libresolv.so ->
libresolv.so.2
lrwxrwxrwx    1 root     root           18 Jun 18 20:47 libresolv.so.2 ->
libresolv-2.3.1.so
-rwxrwxrwx    1 root     root        27224 Jun 21 13:48 librt-2.3.1.so
-rwxrwxrwx    1 root     root       643756 Jun  8  2003 librt.a
lrwxrwxrwx    1 root     root           10 Jun 18 20:47 librt.so ->
librt.so.1
lrwxrwxrwx    1 root     root           14 Jun 18 20:47 librt.so.1 ->
librt-2.3.1.so
-rwxrwxrwx    1 root     root      4335778 Oct 19  2003 libstdc++.so.5.0.5
-rwxrwxrwx    1 root     root        20336 Jun 21 13:48 libthread_db-1.0.so
lrwxrwxrwx    1 root     root           17 Jun 18 20:47 libthread_db.so ->
libthread_db.so.1
lrwxrwxrwx    1 root     root           19 Jun 18 20:47 libthread_db.so.1 ->
libthread_db-1.0.so
-rwxrwxrwx    1 root     root         8964 Jun 21 13:48 libutil-2.3.1.so
-rwxrwxrwx    1 root     root       127788 Jun  8  2003 libutil.a
lrwxrwxrwx    1 root     root           12 Jun 18 20:47 libutil.so ->
libutil.so.1
lrwxrwxrwx    1 root     root           16 Jun 18 20:47 libutil.so.1 ->
libutil-2.3.1.so
drwxrwxrwx    2 root     root          512 Jun 18 20:47 nof

########################################
### Here's my startup info:
########################################
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.27-pre2
   Created:      2004-06-24  20:24:39 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    877125 Bytes = 856.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.27-pre2 (csmith@loch) (gcc version 3.3.2 (Debian)) #60 Thu
Jun 24 15:17:24 CDT 2004
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS root=/dev/nfs
nfsroot=192.168.1.99:/LinuxPPC,v3,tcp ip=192.168.1.13:192.168.1.99
init=/sbin/init rw
Decrementer Frequency = 150000000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 39.83 BogoMIPS
Memory: 14112k available (1564k kernel code, 436k data, 68k init, 0k
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG}pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:20:6f:0f:c1:d2
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
CPM ATM Found SAR
Trying to free free IRQ46
CPM ATM(serial) driver Version 2.1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.1.13, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.1.13, domain=, nis-domain=(none),
     bootserver=192.168.1.99, rootserver=192.168.1.99, rootpath=
ip_conntrack version 2.1 (128 buckets, 1024 max) - 288 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
lec.c: Jun 24 2004 15:22:10 initialized
mpoa: /proc/mpoa initialized
mpc.c: Jun 24 2004 15:22:13 initialized
Looking up port of RPC 100003/3 on 192.168.1.99
Looking up port of RPC 100005/3 on 192.168.1.99
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 68k init
init started:  BusyBox v1.00-pre10 (2004.06.18-16:33+0000) multi-Thu Jun 24
21:17:24 2004
Mounting local filesystems...
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting system log daemon: syslogd.

########################################
### More info (and question) about memory:
########################################
root@raptorlinux->~ [2] cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  14520320  4505600 10014720        0        0  2531328
Swap:        0        0        0
MemTotal:        14180 kB
MemFree:          9780 kB
MemShared:           0 kB
Buffers:             0 kB
Cached:           2472 kB
SwapCached:          0 kB
Active:           1088 kB
Inactive:         1792 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14180 kB
LowFree:          9780 kB
SwapTotal:           0 kB
SwapFree:            0 kB

Question: Why the total (and "available" value at startup) indicates
~14M...why doesn't it say 16M (and what is the ~2.5M "cached" value). Thanks
again in advance.

Regards,
-Craig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
