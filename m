From: okorpil@fh-landshut.de
Date: Wed, 21 Apr 2004 15:16:09 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: Initrd and PPCbug, can it work?
Message-ID: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

Target hardware: MVME2100, MPC8240 microcontroller - PowerPC 603e CPU

I've successfully booted the Linux kernel via the netboot (NBO in PPCbug),
with a NFS root filesystem. I successfully booted the kernel from memory
(after NIOP) and from flash (RB, after I flashed it in the 4MB flash
bank with PFLASH).

All this was relying on NFS to give me the root filesystem, which worked
fine, but will not suffice in the long run, because the goal is to have it
boot as a standalone without a NFS root filesystem.

Yet I do not know how to accomplish that. I created both ext2 and cramfs
initial ramdisks (that mounted fine on the host), copied them into
arch/ppc/boot/images/ramdisk.image.gz, made make zImage.initrd and used
the images created by that.

Kernel bootup tells me, that it loaded the kernel and ramdisk and
relocated both, yet after the kernel boot finishes it fails (I guess when
it tries to mount a root filesystem). Bootlog is attached.

I've tried several variations of the kernel command line, but I am
stumped.

I thought I could use that zImage.initrd and keep the initial ram disk as
root filesystem, yet I do not know what the error in my config is.

Is this even possible with the PPCbug, or do I need a Linux-friendly
bootloader? I initially guessed, that if at bootup everything is
relocated, that would actually suffice, and no additional information from
the bootloader is required??

Thanks in advance,
Oliver Korpilla

My bootup output:

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1436351, Bytes Loaded =&1436351
Bytes/Second   =&718175, Elapsed Time =2 Second(s)

Residual-Data Located at: $01F5511C
loaded at:     00005400 001655BC
relocated to:  00800000 009601BC
zimage at:     008058B0 008C16FA
initrd at:     008C2000 0095D000
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 init=/linuxrc
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (korpo@ppcproject1) (gcc version 2.95.3 20010315
(release)) #6 Wed Apr 21 14:44:36 CEST 2004
Platform: Motorola MVME2100
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/ram0 init=/linuxrc rw
OpenPIC Version 1.2 (1 CPUs and 16 IRQ sources) at f7fd0000
OpenPIC timer frequency is 8.333344 MHz
time_init: decrementer frequency = 16.666748 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 30392k available (1256k kernel code, 472k data, 252k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xffe10000 (irq = 25) is a 16550A
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3)
block.
tulip0:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xbfffec00, 00:01:AF:02:93:8C, IRQ
16.
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cramfs: wrong magic
Kernel panic: VFS: Unable to mount root fs on 01:00

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
