Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C17921D.C4C57329@cambridgebroadband.com>
Date: Wed, 12 Dec 2001 17:21:33 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: ramdisk problems: No init found
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I'm trying to get my MPC860 based board to boot using a ramdisk.  I build the root filesystem using
busybox.  I then load the image into flash using PPCBoot.  When the kernel boots it sees the ramdisk
and decompresses it.  It then initialises the RAMDISK driver.  It even manages to mount the root
filesystem.  However, it then panics with the message "No init found".

I don't understand why the kernel cannot find /sbin/init - it is definitely being built.  (In fact
busybox builds only one executable /bin/busybox; other executables such as /sbin/init are actually
links to /bin/busybox).

Has anyone else had this problem?

Thanks, Alex

PS Here's the kernel output:


Hit any key to stop autoboot:  0
## Booting image at 40000000 ...
   Image Name:   Linux-2.4.4
   Created:      2001-12-10  16:18:51 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    631277 Bytes = 616 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 40100000 ...
   Image Name:   ramdisk image
   Created:      2001-12-12  17:01:04 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    100316 Bytes = 97 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 01f62000, end 01f7a7dc ... OK
Linux version 2.4.4 (ajz@zambia) (gcc version 2.95.3 20010315 (release/MontaVista)) #3 Mon Dec 10
16:17:53 GMT 2001
On node 0 totalpages:
8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram ip=10.0.0.83:10.0.0.2:10.0.0.1:255.0.0.0:fast::off
Decrementer Frequency: 3000000
Calibrating delay loop... 47.82 BogoMIPS
Memory: 30260k available (1208k kernel code, 552k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SMC2 at 0x0380, BRG2
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20034kB/6678kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
No card in slot B: PIPR=00003900
eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:cb:bd:00:00:13
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194301k freed
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
 Amd/Fujitsu Extended Query Table v1.1 at 0x0040
number of JEDEC chips: 1
ICU862 flash bank 0: Using static image partition definition
Creating 8 MTD partitions on "ICU862 Bank 0":
0x00000000-0x00100000 : "kernel"
0x00100000-0x00400000 : "initrd"
0x00400000-0x00800000 : "jffs"
0x00800000-0x00c00000 : "cramfs"
0x00c00000-0x00f00000 : "jffs2"
0x00f00000-0x00f40000 : "ppcboot"
0x00f40000-0x00f80000 : "environment"
0x00f80000-0x01000000 : "spare"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 52k iné
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
