Message-ID: <3B337C7B.1040309@noos.fr>
Date: Fri, 22 Jun 2001 19:12:27 +0200
From: Guillaume =?ISO-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: getting the 8600 to boot 2.4.5
References: <3B2E747A.6090607@noos.fr> <01061823464800.00690@reality.internal> <3B2F0871.2070304@noos.fr> <0106192003070C.00609@reality.internal>
Content-Type: multipart/mixed;
 boundary="------------050309090802070200010002"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050309090802070200010002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hollis wrote:

> In your patch you hardcode opening the 2nd display device. Maybe it would be
> better to keep trying to open a display until one succeeds? That way it would
> work for everyone. :)
>
> -Hollis


Hi all,

I've managed to get a powermac 8600 boot linux 2.4 ('s been long since I
didn't try).
The trick is that in 2.4 kernel, linux tries to open the first frame
buffer, and on machines of the 8x00 class this mean opening the sixty
convoluer, a frame buffer that allows the use of the video output (Y/C
and composite).
Unfortunately, linux has not a driver for it so the opening always
fails, and the machine goes back to OF with a DEFAULT CATCH something.

In 2.2, the behaviour was different in that it tried to open every
framebuffer, or every frame buffer up to succes, I don't know, so this
machine was used to work well.

Now, the question is wether we should hardcode opening the second
display on thoses machines, or go back to the previous behaviour, I
don't knwo why it couls have been removed.

Or someone writes a driver for the sixty ;-P

Here is a console log with the patch applied (yes, I made it netboot,
plain boot is just so boring...):

file: 192.168.77.10,vmlinux.coffloading XCOFF
tsize=5FC0 dsize=FAB70 bsize=215E0 entry=500000

SECTIONS:

.text    00500000 00500000 00005FC0 000000E0

.data    00510000 00510000 000FAB70 000060A0

.bss     0060AB70 0060AB70 000215E0 00000000

loading .text, done..

loading .data, done..

clearing .bss, done..

coffboot starting: loaded at 0x500000

heap at 0x60c150

gunzipping (0xc0000000 <- 0x5102c8:0x60aa58)...done 2438856 bytes

46896 bytes of heap consumed, max in use 40816

start address = 0xc0000000

opening display /chaos@F0000000/control@B... ok

copying OF device tree...done

Initializing fake screen: control
Calling quiesce ...

Total memory = 192MB; using 1024kB for hash table (at c0300000)

Linux version 2.4.5-pre1_0c (root@pmg4) (gcc version 2.95.3 20010111
(prereleas1
Cache coherency enabled for bandit/PSX at 00000000

Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->1

Found Chaos PCI host bridge at 0xf0000000. Firmware bus number: 2->2

On node 0 totalpages: 49152

zone(0): 49152 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=ttyS0 video=controlfb:vmode:6,cmode:8

System has 32 possible interrupts

GMT Delta read from XPRAM: 0 minutes, DST: off

via_calibrate_decr: ticks per jiffy = 124992 (749957 ticks)

Console: colour dummy device 80x25

Calibrating delay loop... 699.59 BogoMIPS

Memory: 189416k available (1644k kernel code, 776k data, 224k init, 0k
highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)

Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)

Page-cache hash table entries: 65536 (order: 6, 262144 bytes)

Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)

POSIX conformance testing by UNIFIX

PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent

PCI:0:10:0: Resource f3000000-f301ffff (f=200)

PCI:1:8:0: Resource 84110000-8411007f (f=200)

PCI:1:8:0: Resource 00001000-0000107f (f=101)

PCI:1:8:0: Resource 82000000-83ffffff (f=1208)

PCI:1:9:0: Resource 84100000-8410ffff (f=200)

Macintosh CUDA driver v0.5 for Unified ADB.

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Starting kswapd v1.8

controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB


On a side note, this is wrong, I have the 2 banks filled, but I'll check
this later

Monitor sense value = 0x623, using video mode 6 and color mode 0.

Console: switching to colour frame buffer device 80x30

fb0: control display adapter

no framebuffer address found for /bandit@F2000000/gc@10/sixty6@1C000

This is the first display device without a driver

input0: Macintosh mouse button emulation

PowerMac Z8530 serial driver version 2.0

tty00 at 0xfcfa6020 (irq = 15) is a Z8530 ESCC, port = modem

tty01 at 0xfcfa3000 (irq = 16) is a Z8530 ESCC, port = printer

pty: 256 Unix98 ptys configured

block: queued sectors max/low 125642kB/41880kB, 384 slots per queue

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

fd0: SWIM3 floppy controller

PCI: Enabling device 01:08.0 (0014 -> 0017)

DAC960: ***** DAC960 RAID Driver Version 2.4.10 of 1 February 2001 *****

DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>

And here it becomes bad, and currently my goal in life is getting the
mylex driver to work.

BTW, can anybody tell me if something like this can lead to endianness
problems ?:

InboundDoorBellRegister.All =
   readb(ControllerBaseAddress + DAC960_LA_InboundDoorBellRegisterOffset);

Thanks for the good work and keep on

GoM


--------------050309090802070200010002
Content-Type: text/plain;
 name="promc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="promc.diff"

--- arch/ppc/kernel/prom.c.orig	Mon Jun 18 23:01:49 2001
+++ arch/ppc/kernel/prom.c	Mon Jun 18 23:29:56 2001
@@ -963,17 +963,17 @@
 					= RELOC(prom_display_paths[i-1]);
 		}
 		RELOC(prom_display_paths[i]) = PTRUNRELOC(path);
-		if (i == 0)
+		if (i == 1)
 			RELOC(prom_disp_node) = node;
 		if (RELOC(prom_num_displays) >= FB_MAX)
 			break;
 	}

 	/*
-	 * Open the first display and set its colormap.
+	 * Open the second display and set its colormap.
 	 */
 	if (RELOC(prom_num_displays) > 0) {
-		path = PTRRELOC(RELOC(prom_display_paths[0]));
+		path = PTRRELOC(RELOC(prom_display_paths[1]));
 		prom_print(RELOC("opening display "));
 		prom_print(path);
 		ih = call_prom(RELOC("open"), 1, 1, path);

--------------050309090802070200010002--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
