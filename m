Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 057B4DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 21:16:44 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HKB04-0004US-Ed
	for linuxppc-embedded@ozlabs.org; Thu, 22 Feb 2007 02:16:32 -0800
Message-ID: <9097247.post@talk.nabble.com>
Date: Thu, 22 Feb 2007 02:16:32 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: jffs2 file system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



hi,
 I m using PQ2FADS-ZU board and montavista kernel 2.6.10.
u-boot is u-boot-1.1.1

Kernel configuration for MTD and JFFS2 support...

CONFIG_MTD=3Dy
CONFIG_MTD_DEBUG=3Dy
CONFIG_MTD_DEBUG_VERBOSE=3D0
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=3Dy
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=3Dy

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dy
CONFIG_MTD_BLOCK=3Dy
CONFIG_FTL=3Dy
#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
CONFIG_MTD_JEDECPROBE=3Dy
CONFIG_MTD_GEN_PROBE=3Dy
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
CONFIG_MTD_CFI_NOSWAP=3Dy
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=3Dy
CONFIG_MTD_CFI_INTELEXT=3Dy
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=3Dy
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_XIP is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=3Dy
CONFIG_MTD_PHYSMAP_START=3D0x8000000
CONFIG_MTD_PHYSMAP_LEN=3D0x4000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2
# CONFIG_MTD_MULTI_PHYSMAP is not set
# CONFIG_MTD_SBC8240 is not set
CONFIG_MTD_PQ2FADS=3Dy
        =20

JFFS2........
----------------
CONFIG_JFFS_FS=3Dy
CONFIG_JFFS_FS_VERBOSE=3D0
CONFIG_JFFS_PROC_FS=3Dy
CONFIG_JFFS2_FS=3Dy
CONFIG_JFFS2_FS_DEBUG=3D0
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_RTIME=3Dy
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=3Dy

created  jffs2 image using mkfs.jffs2 on host
----------------------------------------------------
mkfs.jffs2 -r /mnt/tmp -e 0x10000 -o image.jffs2 -b


on evaluation (PQ2FADS-ZU) board....
--------------------------------------------
setenv ipaddr 192.168.178.234
setenv serverip 192.168.178.110
setenv ethaddr 00:99:23:44:ad:de
setenv bootcmd 'tftpboot 0x1000000 jffsenabled\;bootm 0x1000000\;'
setenv bootargs root=3D/dev/mtdblock0 rootfstype=3Djffs2
ip=3D192.168.174.231:192.168.178.110:192.168.174.47:255.255.255.0:cashel:et=
h1:off=20


steps fallowed are....

erase  FF800000 FFDFFFFF
tftpboot 0x100000 image.jffs2=20
cp.b 100000 FF800000 4dc874
run bootcmd

linux does not bootup...

what is the problem ?=20

I m also trying to mount jffs2 after nfs mounting.....
-------------------------------------------------------------

cat /proc/mtd and cat /proc/partitions are working fine.

steps fallowed are...

1. mkfs.jffs2 =E2=88=92=E2=88=92pad=3D3145728 =E2=88=92=E2=88=92eraseblock=
=3D262144 =E2=88=92=E2=88=92root=3D/mnt =E2=88=92=E2=88=92output
image.jffs2
2. flash_erase /dev/mtd0
3. cp /var/tm/image.jffs2 /dev/mtd0
4. mount  -t jffs2 /dev/mtdblock0 /mnt

it is not working?

thanks in advance.

best wishes,
Nethra



--=20
View this message in context: http://www.nabble.com/jffs2-file-system-tf327=
1928.html#a9097247
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
