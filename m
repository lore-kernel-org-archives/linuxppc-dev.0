Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr3.xs4all.nl (smtp-vbr3.xs4all.nl [194.109.24.23])
	by ozlabs.org (Postfix) with ESMTP id 4E6C4DDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 00:10:07 +1100 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id n0JD1TSZ048888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 14:01:31 +0100 (CET)
	(envelope-from nvbolhuis@aimvalley.nl)
Message-ID: <497479A9.302@aimvalley.nl>
Date: Mon, 19 Jan 2009 14:01:29 +0100
From: "N. van Bolhuis" <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: u-boot fails to uncompress a "gzip'ed -9" kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


A certain powerpc 2.6.28 kernel (which is by default compressed with
gzip -9) fails to load with u-boot v2008.10. It results in a machine
check stop. I'm testing on a MPC8313-RDB.

Btw. the linux-2.6.28/arch/powerpc/boot/wrapper script takes care of
compressing with "gzip -9".
On my host linux pc I'm using gzip 1.3.5 (2002-09-30).

If I manually compress that same kernel with "gzip -8" and generate a
uImage, it *does* work.

If I mask the MPC8313 machine checkstop (RMR[CSRE]=0) u-boot hangs
forever.

As far as I know my start/load memory addresses are ok.

If anybody has any clues, please let me know.

more details follow.
Here's the full output of when the problem occurs:

U-Boot 2008.10 (Jan 19 2009 - 12:21:43) MPC83XX

Reset Status: Software Hard, External/Internal Soft, External/Internal Hard

CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.667 MHz
Board: Freescale MPC8313ERDB
I2C:   ready
DRAM:  128 MB
Top of RAM usable for U-Boot at: 08000000
Reserving 307k for U-Boot at: 07fb3000
Reserving 520k for malloc() at: 07f31000
Reserving 68 Bytes for Board Info at: 07f30fbc
Reserving 104 Bytes for Global Data at: 07f30f54
Stack Pointer at: 07f30f38
New Stack Pointer is: 07f30f38
Now running in RAM - U-Boot at: 07fb3000
FLASH:  8 MB
NAND:  32 MiB
In:    serial
Out:   serial
Err:   serial
U-Boot relocated to 07fb3000
Net:   TSEC0, TSEC1 [PRIME]
=> run tird
Speed: 100, full duplex
Using TSEC1 device
TFTP from server 10.10.4.142; our IP address is 10.10.77.77
Filename 'uImage'.
Load address: 0x2000000
Loading: #################################################################
           #####################################################
done
Bytes transferred = 1717604 (1a3564 hex)
Speed: 100, full duplex
Using TSEC1 device
TFTP from server 10.10.4.142; our IP address is 10.10.77.77
Filename 'initramfs.igz.uboot'.
Load address: 0x1000000
Loading: #################################################################
           #################################################################
           ##########
done
Bytes transferred = 2051722 (1f4e8a hex)
Speed: 100, full duplex
Using TSEC1 device
TFTP from server 10.10.4.142; our IP address is 10.10.77.77
Filename 'mpc8313erdb.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 11130 (2b7a hex)
## Current stack ends at 0x07f30c00
*  kernel: cmdline image address = 0x02000000
## Booting kernel from Legacy Image at 02000000 ...
     Image Name:   Linux-2.6.28wa2
     Created:      2009-01-19  11:36:09 UTC
     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
     Data Size:    1717540 Bytes =  1.6 MB
     Load Address: 00000000
     Entry Point:  00000000
     Verifying Checksum ... OK
     kernel data at 0x02000040, len = 0x001a3524 (1717540)
*  ramdisk: cmdline image address = 0x01000000
## Loading init Ramdisk from Legacy Image at 01000000 ...
     Image Name:   uboot initramfs
     Created:      2009-01-12  14:56:02 UTC
     Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
     Data Size:    2051658 Bytes =  2 MB
     Load Address: 00000000
     Entry Point:  00000000
     Verifying Checksum ... OK
     ramdisk start = 0x01000040, ramdisk end = 0x011f4e8a
*  fdt: cmdline image address = 0x00400000
## Checking for 'FDT'/'FDT Image' at 00400000
*  fdt: raw FDT blob
## Flattened Device Tree blob at 00400000
     Booting using the fdt blob at 0x400000
     of_flat_tree at 0x00400000 size 0x00002b7a
     Uncompressing Kernel Image ...

U-Boot 2008.10 (Jan 19 2009 - 12:21:43) MPC83XX

Reset Status: Check Stop, External/Internal Soft, External/Internal Hard



I already applied this patch:
http://www.mail-archive.com/u-boot@lists.denx.de/msg06709.html
it makes no difference.

I also applied this patch:
http://www.mail-archive.com/u-boot@lists.denx.de/msg04544.html
it makes no difference either.

Using "bzip2 --best" gives:
     Uncompressing Kernel Image ... BUNZIP2: uncompress or overwrite
error -3 - must RESET board to recover

Using "bzip2 --fast" works, but it takes a long time for u-boot to
uncompress the kernel.

What's also strange is that some other 2.6.28 kernels (compressed with
gzip -9) do work.

I probably have some kind of memory error, I don't see it though.

Unfortunately the problem doesn't occur when I start debugging it with a
jtag debugger (lauterbach).

again, if anybody has any clues, please let me know.
