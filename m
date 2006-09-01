Return-Path: <aleck@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id F3FBC679FD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 12:54:59 +1000 (EST)
Received: from [192.168.200.117] (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix-out) with ESMTP id 3335A8BC0F6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 19:29:02 -0700 (PDT)
Received: from sierra.gdatech.com (sierra.gdatech.com [192.168.200.112])
	by kings.gdatech.com (Postfix-out) with ESMTP id BB3918BC087
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 19:28:59 -0700 (PDT)
Received: from monstertop ([192.168.10.149]) (authenticated)
	by sierra.gdatech.com (8.11.6/8.11.6) with ESMTP id k812TPP06672
	for <linuxppc-embedded@ozlabs.org>; Thu, 31 Aug 2006 19:29:25 -0700
From: "Aleck Lin" <aleck@gdatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Unable to boot kernel 2.6 from u-boot 1.1.4 in Xilinx ML403
Date: Thu, 31 Aug 2006 19:28:32 -0700
Message-ID: <000a01c6cd6e$5e1970a0$800101df@monstertop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.5.1157076003.7568.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm working on booting kernel 2.6 on Xilinx. And I'm encountering a few
problems.=20

1. When I directly download zImage.elf to the RAM and boot from there, I =
see
the kernel starts booting, but it complains about not being able to =
mount
/dev/sysace/disc0/part2 and thus kernel panic happens.

The following is the output
---------------------------------------------------------------
loaded at:     00400000 004D313C
board data at: 004D1124 004D113C
relocated to:  004050F8 00405110
zimage at:     0040580D 004D0AA8
avail ram:     004D4000 04000000

Linux/PPC load: console=3DttyS0,9600 ip=3Doff =
root=3D/dev/xsysace/disc0/part2 rw
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.17.8 (aleck@sac.gdatech.com) (gcc =
version
4.0.0 (DENX ELDK 4.0 4.0.0)) #2 Thu Aug 31 11:49:40 PDT 2006
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=3DttyS0,9600 ip=3Doff
root=3D/dev/xsysace/disc0/part2 rw
[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000176] Console: colour dummy device 80x25
[    0.000676] Dentry cache hash table entries: 8192 (order: 3, 32768 =
bytes)
[    0.001452] Inode-cache hash table entries: 4096 (order: 2, 16384 =
bytes)
[    0.015453] Memory: 63104k available (1268k kernel code, 468k data, =
80k
init, 0k highmem)
[    0.204374] Mount-cache hash table entries: 512
[    0.209943] NET: Registered protocol family 16
[    0.218843] NET: Registered protocol family 2
[    0.264481] IP route cache hash table entries: 512 (order: -1, 2048
bytes)
[    0.265267] TCP established hash table entries: 2048 (order: 1, 8192
bytes)
[    0.265465] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.265569] TCP: Hash tables configured (established 2048 bind 1024)
[    0.265599] TCP reno registered
[    0.272471] io scheduler noop registered
[    0.272558] io scheduler anticipatory registered (default)
[    0.272626] io scheduler deadline registered
[    0.272759] io scheduler cfq registered
[    0.318755] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    0.323749] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq =3D 9) is a =
16450
[    2.026296] RAMDISK driver initialized: 16 RAM disks of 65536K size =
1024
blocksize
[    2.117598] tun: Universal TUN/TAP device driver, 1.6
[    2.177338] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.252474] mice: PS/2 mouse device common for all mice
[    2.314381] TCP bic registered
[    2.350802] NET: Registered protocol family 1
[    2.402825] NET: Registered protocol family 17
[    2.458051] VFS: Cannot open root device "xsysace/disc0/part2" or
unknown-block(0,0)
[    2.549979] Please append a correct "root=3D" boot option
[    2.612426] Kernel panic - not syncing: VFS: Unable to mount root fs =
on
unknown-block(0,0)
[    2.711373]  <0>Rebooting in 180 seconds..<NULL>
-----------------------------------------------------------


2. When I tried to boot the zImage (sitting in the flash) from u-boot =
file
(generated from the same source code as uImage.elf), as soon as it gives =
the
control to the kernel, no messages would come. I checked to make sure =
that I
had the right serial port setting (console=3DttyS0,9600), but still =
nothing
shows up.

Here's the output of what I had (I turned on some extra debug msg in =
u-boot)

-------------------------------------------
### No HW ID - assuming ML403
DRAM:  64 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  5 =08=08=08 4 =08=08=08 3 =08=08=08 2 =
=08=08=08 0=20
=3D> bootm 0xffa00000
## Booting image at ffa00000 ...
   Image Name:   Linux-2.6.17.8
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    832155 Bytes =3D 812.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03E62B70 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF3A
memstart    =3D 0x00000000
memsize     =3D 0x04000000
flashstart  =3D 0xFF800000
flashsize   =3D 0x00800000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x40401003
procfreq    =3D    300 MHz
plb_busfreq =3D    100 MHz
ethaddr     =3D 00:0A:35:00:22:01
IP addr     =3D 192.168.10.111
baudrate    =3D   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
------------------------------------------------------------

3. Lastly, whenever I issue a reset command in u-boot, it just locks up =
and
hangs. I have to do a hardware reset every time. I'm wondering if the =
reset
vector is going to a wrong place. How would I check that?


I'm fairly new to the whole embedded domain. Please feel free to help. =
It
would be much appreciated! Thanks.

Aleck
