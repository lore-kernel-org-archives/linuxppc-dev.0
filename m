Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FCE5347.2070808@catapult.com>
Date: Wed, 03 Dec 2003 16:19:03 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RAMDISK Segv
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using the RAM disk supplied by DENX on
an 8275 FADS board.  The kernel boots and
the RAM disk is loaded.  busybox starts
and then I get segv's.  Any idea as to
what is happening ?

Thanks
Kevin


=> tftpboot 100000 kernram
TFTP from server 192.168.90.13; our IP address is 192.168.90.3
Filename 'kernram'.
Load address: 0x100000
Loading: #################################################################
###################################
done
Bytes transferred = 511193 (7ccd9 hex)
=> tftpboot 300000 pRamdisk
TFTP from server 192.168.90.13; our IP address is 192.168.90.3
Filename 'pRamdisk'.
Load address: 0x300000
Loading: #################################################################
#################################################################
#################################################################
#################################################################
##############
done
Bytes transferred = 1400262 (155dc6 hex)
=> setenv bootargs root=/dev/ram
=> setenv bootargs root=/dev/ram rw
=> bootm 100000 300000
## Booting image at 00100000 ...
Image Name: Linux-2.4.20
Image Type: PowerPC Linux Kernel Image (gzip compressed)
Data Size: 511129 Bytes = 499.1 kB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00300000 ...
Image Name: Simple Embedded Linux Framework
Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
Data Size: 1400198 Bytes = 1.3 MB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
Loading Ramdisk to 01a38000, end 01b8dd86 ... OK
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Total memory = 32MB; using 64kB for hash table (at c0140000)
Linux version 2.4.20 (kevin@linux4) (gcc version 3.2.1) #89 Wed Dec 3
13:20:42 EST 2003
ADS setup arch
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw nobats ip=192.168.90.3
ADS init IRQ. NR_IRQS=256
ADS time init
ADS calibrate decrementer. FREQ=66000000, tb_ticks_per_jiffy=165000
Calibrating delay loop... 131.07 BogoMIPS
Memory: 29696k available (868k kernel code, 336k data, 48k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
ADS init
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
MTD Sharp chip driver <ds@lineo.com>
MPC8260ADS flash SIMM: 8192KB at FF800000
Looks like sharp flash
Creating 1 MTD partitions on "Flash SIMM":
0x00040000-0x00700000 : "JFFS2"
MPC8260 FCC Ethernet driver
BD rings initialised, RBASE=1A18160, TBASE=1A18360
Created eth0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: OPEN
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
device=eth0, addr=192.168.90.3, mask=255.255.255.0, gw=255.255.255.255,
host=192.168.90.3, domain=, nis-domain=(none),
bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1367k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 48k init
000 init/main.c:590-init-Starting execs
000 init/main.c:597-init-Exec /sbin/init done
SIGSEGV


BusyBox v0.60.1 (2002.10.24-02:29+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# ls /
SIGSEGV
#


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
