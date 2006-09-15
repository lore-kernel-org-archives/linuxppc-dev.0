Return-Path: <aleck@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id A0EB967A5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 13:24:47 +1000 (EST)
Received: from spamcheck.gdatech.com (localhost.localdomain [127.0.0.1])
	by spamcheck.gdatech.com (Postfix-out) with ESMTP id D5F386AC060
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 20:24:45 -0700 (PDT)
Received: from sierra.gdatech.com (sierra.gdatech.com [192.168.200.112])
	by spamcheck.gdatech.com (Postfix-out) with ESMTP id 9C9636AC05C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 20:24:45 -0700 (PDT)
Received: from monstertop (wireless.gdatech.com [192.168.200.122])
	(authenticated)
	by sierra.gdatech.com (8.11.6/8.11.6) with ESMTP id k8F3PEn18579
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 20:25:14 -0700
From: "Aleck Lin" <aleck@gdatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: ethernet patch for kernel 2.6 for ml403
Date: Thu, 14 Sep 2006 20:24:33 -0700
Message-ID: <003101c6d876$79f99c60$800101df@monstertop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.270.1158283233.2423.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I found this patch that was posted back in January
(http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021574.html).

As I was trying it, there were some warnings and errors. When I fixed them
as much as I could to the point of a successful compilation, I tried to boot
this kernel image on ml403. However, it still complains that no network
devices available. 

TWO questions.
1. Has anyone ever tried with the patch and been successful with it?
2. Why does it still complain no network devices found even though I thot I
added the correct ethernet driver? 

Thanks for any help as I'm still relatively new to this.

Aleck


Here's my booting message.

---------------------------------------------------
## Booting image at 00800000 ...
   Image Name:   Linux-2.6.17.8
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    854118 Bytes = 834.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## cmdline at 0x007FFF00 ... 0x007FFF37
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFF800000
flashsize   = 0x00800000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x0000012A
procfreq    =    300 MHz
plb_busfreq =    100 MHz
ethaddr     = 00:11:22:33:44:55
IP addr     = 192.168.200.230
baudrate    =   9600 bps
## Loading RAMDisk Image at 01000000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1437217 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03d03000, end 03e61e21 ... OK
[    0.000000] Linux version 2.6.17.8 (aleck@sac.gdatech.com) (gcc version
4.0.0 (DENX ELDK 4.0 4.0.0)) #87 Thu Sep 14 20:06:23 PDT 2006
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=ttyS0,9600 ip=192.168.200.230
root=/dev/ram0 rw
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000151] Console: colour dummy device 80x25
[    0.000567] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.001213] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.013282] Memory: 61632k available (1308k kernel code, 476k data, 84k
init, 0k highmem)
[    0.200420] Mount-cache hash table entries: 512
[    0.202863] checking if image is initramfs...it isn't (no cpio magic);
looks like an initrd
[    0.863139] Freeing initrd memory: 1403k freed
[    0.866364] NET: Registered protocol family 16
[    0.869487] Generic PHY: Registered new driver
[    0.874412] NET: Registered protocol family 2
[    0.912357] IP route cache hash table entries: 512 (order: -1, 2048
bytes)
[    0.913062] TCP established hash table entries: 2048 (order: 1, 8192
bytes)
[    0.913241] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.913339] TCP: Hash tables configured (established 2048 bind 1024)
[    0.913368] TCP reno registered
[    0.920012] io scheduler noop registered
[    0.920111] io scheduler anticipatory registered (default)
[    0.920187] io scheduler deadline registered
[    0.920346] io scheduler cfq registered
[    0.958113] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    0.962450] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a 16550A
[    2.871187] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024
blocksize
[    2.961972] allocating ethernet device...
[    3.010204] eth%d: using fifo mode.
[    3.052064] eth%d: Xilinx EMAC #0 at 0x80400000 mapped to 0xC5000000,
irq=31
[    3.136606] eth%d: id 2.0a; block id 0, type 8
[    3.190431] Marvell 88E1101: Registered new driver
[    3.250101] tun: Universal TUN/TAP device driver, 1.6
[    3.310712] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.385845] mice: PS/2 mouse device common for all mice
[    3.448583] TCP bic registered
[    3.485307] NET: Registered protocol family 1
[    3.537610] NET: Registered protocol family 17
[    4.096219] IP-Config: No network devices available.
[    4.156871] RAMDISK: Compressed image found at block 0
[    5.002841] VFS: Mounted root (ext2 filesystem).
[    5.058432] Freeing unused kernel memory: 84k init
### Application running ...


BusyBox v(null) ((null)) Built-in shell (msh)
#
------------------------------------------------------------------
