Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.dulles19-verio.com
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id 2800A67C90
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 14:48:03 +1000 (EST)
Received: from mx16.stngva01.us.mxservers.net (204.202.242.6)
	by mail19d.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	1-0425454866 for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 00:41:22 -0400 (EDT)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 5 Jul 2005 21:41:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050706020002.F244267CA0@ozlabs.org>
Message-ID: <20050706004122.GA42545@mail19d.g19.rapidsite.net>
Subject: Linux 2.4.25 problems after initrd detected
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I am running ELDK 3.1.1, Linux version 2.4.25, on a MPC8280 CPU, U-boot
1.1.2 to load linux.

This is a new prototype board we are developing; I can include the .config
information in a later post, if anyone needs to know something from it.

I am using the uRamdisk image, from the denx ftp for the initRd image.

I have added a couple lines to the cpuc.c file to add support for the
MPC8280 CPU, I think its only that one file, so perhaps linux is not
detecting the CPU correctly.

Two questions: 
1) Does the "Warning: Real time clock stuck" pose any problem to getting the
initrd loaded? Or perhaps interrupts?

2) Does the MTD physical mapping driver have to be enabled for the initrd to
work, I haven't been able to get my driver to successfully complete a
ioremap if I enable it. I am using AMD 32MB flash mapped physically at
0xE0000000 at least in Uboot.


I know the kernel is still marginally alive as I can step into the kernel
debugger over the serial port at this point, if I press control C, its in
the interrupt routines waiting for UART interrupts.

I apologize in advance if I have not provided enough info, as its my first
post.

Russell McGuire

Here is the output, from Uboot.

## Booting image at e0080000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    661411 Bytes = 645.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x021339A0 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF10
bd address  = 0x02133FB4
memstart    = 0x00000000
memsize     = 0x02200000
flashstart  = 0xE0000000
flashsize   = 0x04000000
flashoffset = 0x00036000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xF0000000
bootflags   = 0x00000001
vco         =    528 MHz
sccfreq     =    132 MHz
brgfreq     =     33 MHz
intfreq     =    396 MHz
cpmfreq     =    264 MHz
busfreq     =     66 MHz
ethaddr     = EA:53:0E:4B:8A:46
IP addr     = 192.168.5.50
baudrate    = 115200 bps
## Loading RAMDisk Image at e0200000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1400198 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0xE0200040 ... 0xE0355DC5 (len=1400198=0x155D86)
   Loading Ramdisk to 01fdd000, end 02132d86 ... OK
## Transferring control to Linux (at address 00000000) ...
Memory BAT mapping: BAT2=32Mb, BAT3=2Mb, residual: 0Mb
Linux version 2.4.25 (root@FedoraCore2) (gcc version 3.3.3 (DENX ELDK 3.1
3.3.3-8)) #94 Tue Jul 5 18:59:08 PDT 2005
On node 0 totalpages: 8704
zone(0): 8704 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Warning: real time clock seems stuck!
Calibrating delay loop... 263.78 BogoMIPS
Memory: 31472k available (1128k kernel code, 372k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG7
ttyS1 on SMC2 at 0x0040, BRG8
ttyS2 on SCC1 at 0x8000, BRG1
ttyS3 on SCC2 at 0x8100, BRG2
eth0: FCC2 ENET Version 0.4, EA:53:0E:4B:8A:47
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1367k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 56k init

<-- No more output, unless control C is pressed and "sometimes" it will
enter into the KGDB.
