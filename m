Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id B000E67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Jul 2006 07:20:20 +1000 (EST)
Message-ID: <44A6E57A.3080302@qstreams.com>
Date: Sat, 01 Jul 2006 17:13:30 -0400
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: JFFS2 FS is read-only (not what I want)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

When I boot from a JFFS2 file system on my eval board, the file system 
is effectively read-only, and I can't figure out why.  I'm pretty sure 
the kernel's configured for R/W MTD block access.  Any help is greatly 
appreciated.

The hardware in use is:

Freescale MPC8349EMDS eval board.
8MB Q-flash with 64 uniform 128k sectors

Here are the symptoms:

# du -s
265492  .                                    <-- only 265k of data
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/mtdblock4            2048      2048         0 100% /
# mount
/dev/mtdblock4 on / type jffs2 (rw)
/proc on /proc type proc (rw)

Here's what the kernel spits out at boot-up:

***
physmap flash device: 800000 at fe000000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
Command set type 1
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition definition
Creating 6 MTD partitions on "phys_mapped_flash":
0x00000000-0x00040000 : "u-boot"
0x00040000-0x00080000 : "env"
0x00080000-0x00280000 : "kernel"                       <-- kernel boots 
from here
0x00280000-0x00480000 : "initrd"                         <-- no initrd, 
this is empty
0x00480000-0x00680000 : "jffs2"                          <-- 2MB partition
0x00680000-0x00800000 : "user"                          <-- empty
***

I created the MTD partitions in a u-boot image that was pulled from the 
GIT tree about a week ago, and my kernel is 2.6.17-based.  I wrote some 
board init code that sets the MTD physical mappings. 

Here are the MTD and JFFS2 parts of my .config file:

***
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set
#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0xFE000000
CONFIG_MTD_PHYSMAP_LEN=0x800000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PLATRAM is not set

# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
***

The file system is the SELF that is included with DENX's ELDK, and built 
as at:
http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding

I used the following command to create the file system image, that was 
then loaded at address 0xfe480000 via U-boot:

 > mkfs.jffs2 -U -d rootfs -D rootfs_device.tab -b -e 0x20000 -o jffs2.img

I modified the table to name my serial devices /dev/ttyS0 and /dev/ttyS1

thanks for the help.  Sorry if this is too verbose or includes the wrong 
information.

regards,
Ben
