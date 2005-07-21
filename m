Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 7ABA767CDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 17:32:32 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000058399.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Jul 2005 09:32:31 +0200
From: "David Grab" <d.grab@hima.com>
To: "'T Ziomek'" <ctz001@email.mot.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Thu, 21 Jul 2005 09:30:56 +0200
Message-ID: <000501c58dc6$22246a20$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <Pine.WNT.4.61.0507201702510.2672@holyoke.labs.mot.com>
Subject: AW: AW: AW: initrd rootfs ramdisk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> i solved my problem with u-boot and linux. Now i have my rootfs ramdisk
>> mounted and functioning. But one output is weird.

>Can I ask what what you had to change to get your initrd RAM disk working?
>I'm having a very similar problem.

Sure! :)

1. I used the ramdisk provided by ELDK from www.denx.de. A good description
is here
http://www.denx.de/twiki/bin/view/DULG/RootFileSystemDesignAndBuilding

2. Write ramdisk into flash at any address.

3. Configuring u-boot for command line parameters in
/u-boot/include/configs/<board.h>. These definitions i have made. BOOTARGS
are the command line parameters which u-boot passes to linux. BOOTCOMMAND is
not really necessary, but you only type bootd and not "bootm
<linux_flash_address> <ramdisk_flash_address>". So you don?t spend much time
for typing. ;) BOOTDELAY is disabled, because i actually don?t want an
autoboot of the linux kernel.

#define CONFIG_BOOTARGS		"console=ttyS1,115200 root=/dev/ram rw"
#define CONFIG_BOOTCOMMAND	"bootm ff000000 ff800000"    /* autoboot command
*/
#define CONFIG_BOOTDELAY	-1	 /* disable autoboot??     */

4. Now configuring linux kernel for ramdisk support. Following options are
needed.

CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""

Enables command line parameters in linux kernel.

I also set following options to enable ramdisk support. Maybe there are some
more options which don?t concerns to ramdisk support.

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y


That?s all i think.

Best regards,

David
