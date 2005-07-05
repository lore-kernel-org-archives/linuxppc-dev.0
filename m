Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with ESMTP id 2450267C71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 21:20:25 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000032377.msg
	for <linuxppc-embedded@ozlabs.org>; Tue, 05 Jul 2005 13:20:35 +0200
From: "David Grab" <d.grab@hima.com>
To: <wd@denx.de>
Date: Tue, 5 Jul 2005 13:18:54 +0200
Message-ID: <000801c58153$54af2400$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20050705081854.8096B353A4A@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: initrd rootfs ramdisk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>> i solved my problem last problem and now i get console output. :) So next
>> step is to setup the root file system. I want to use an image loaded into
>> ramdisk, but seems i´m missing something. I´m using u-boot to load the
>> ramdisk and linux kernel. Actually i don´t know how the kernel gets the
>> location of the loaded ramdisk. I only added the support (see Kernel

>It gets passed in registers r4 (start address) and r5 (end address).

>> configuration) and the command line parameter root=/dev/ram rw. But the
boot
>> command arguments from u-boot seems not recognized from the linux kernel.

>But the kernel prints the boot parameters just fine.

Maybe because i defined it in kernel configuration! But from u-boot i don´t
get any arguments.

CONFIG_CMDLINE="initrd=0x1fe0f000 root=/dev/ram rw ip=on
console=ttyS1,115200"

I thougt i can give the linux kernel position from u-boot where initrd is
located, but i have the same problem.

u-boot starts well, and the declarations for boot arguments are defined:

#define CONFIG_BOOTARGS		"root=/dev/ram rw"
#define CONFIG_BOOTCOMMAND	"bootm ff000000 ff800000"    /* autoboot command
*/

But the linux kernel seems not get them. With CONFIG_CMDLINE="ip=on
console=ttyS1,115200" in the kernel settings to see if the kernel gets the
command line parameters from u-boot as mentioned above, i got this error:

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
VFS: Cannot open root device "<NULL>" or unknown-block(3,1)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(3,1)

I also read the FAQ
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel,
but there are even no CFG_IMMR declaration for any ppc440 board. And i also
don´t know what address to define there to hit my board, so i left them out.
The bd_info strucure in linux-2.6.11.6\include\asm-ppc\ppcboot.h and
u-boot-1.1.2\include\asm-ppc\u-boot.h is the same.

>> Should the option CONFIG_BOOT_LOAD point on the address of the ramdisk? I

>No.

ok

>> hope someone could help me to trigger out my problem.

>Are you sure that you have ext2 filesystem support  enabled  in  your
>kernel configuration?

Yes it´s selected as mentioned in kernel configuration parameters in my
first mail.

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y

also declared:

#
# Block devices
#
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

and:

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_RAMFS=y
