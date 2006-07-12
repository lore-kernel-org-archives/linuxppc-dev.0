Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 87ABB67B63
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 15:39:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k6C5dPWl024755 for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 22:39:25 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6C5dNWB002662
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 00:39:24 -0500 (CDT)
Subject: RE: weird behavior for jffs2 on PQ2FADS-VR board
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Wed, 12 Jul 2006 13:41:46 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0300BA@zch01exm20.fsl.freescale.net>
In-Reply-To: <f9a7e7a80607112123t7e93221fx37d83245622d4368@mail.gmail.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Lei Sun" <leisun124@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is the kernel config we used, you can have a try.


# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dy
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=3Dy
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dy
CONFIG_MTD_BLOCK=3Dy
# CONFIG_FTL is not set
# CONFIG_NFTL is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=3Dy
CONFIG_MTD_GEN_PROBE=3Dy
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=3Dy
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_CFI_INTELEXT=3Dy
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf
> Of Lei Sun
> Sent: Wednesday, July 12, 2006 12:23 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: weird behavior for jffs2 on PQ2FADS-VR board
>=20
> Hi all:
>     I brought up linux-2.4.30 on PQ2FADS-VR board, everything was fine
> untill i try to mount the jffs2.  My mtd partition looks like this:
>=20
> dev:    size   erasesize  name
> mtd0: 00800000 00040000 "Flash SIMM"
> mtd1: 00080000 00040000 "u-boot"
> mtd2: 00100000 00040000 "Kernel"
> mtd3: 00580000 00040000 "Rootfs"
> mtd4: 00080000 00040000 "u-boot env"
> mtd5: 00080000 00040000 "unused"
>=20
> Basically, I tried
> "eraseall /dev/mtd3", and then
> "mount -t jffs2 /dev/mtdblock3 /mnt", it showed as mounted, then I
> issued "echo "hello,world" > test.txt" to create a file,
> a warning was printed out
> "Node totlen on flash (0x44000000) !=3D totlen in node ref =
(0x00000044)"
> , but subsequent
> "cat test.txt " still showed the correct string from that newly
created file".
> However, after I umount the  file and remount it again, it give me
> lots of errors"
> Magic bitmask 0x1985 not found at 0x00240004: 0x0c00 instead"
> Then the moutn operation failed.
>     I am suspecting it is mtd driver problem (the board use
> LH28F016SCT-L95 from sharp). But don't know how to proceed , e.g. how
> to verify the content was written into flash in a mounted jffs2 file
> system?
>     Has anybody experienced similar issue? Any suggestion?
>     Forgive me if this is wrong list to post, and very appreciate if
> anybody can direct me to the right place.
>=20
> Thanks!
> lei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
