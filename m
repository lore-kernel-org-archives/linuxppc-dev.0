Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 336B9679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 14:57:04 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k6C4v2s5029293 for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 21:57:02 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6C4v0Q8025172
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 23:57:01 -0500 (CDT)
Subject: RE: weird behavior for jffs2 on PQ2FADS-VR board
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 12 Jul 2006 12:56:59 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635018C58@zch01exm21.fsl.freescale.net>
In-Reply-To: <f9a7e7a80607112123t7e93221fx37d83245622d4368@mail.gmail.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
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

Sun,

You are using SIMM LH28F016SCT-L95, that is an old chipset,
the driver for this is under drivers/mtd/chips/sharp.c.  Maybe
this is endian issue, you need to remove the cpu_to_le32(datum) swap in
the driver  of line 360
And with map->write32(map, datum, adr) instead.

Best Regards,
Dave

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs
> .org] On Behalf Of Lei Sun
> Sent: Wednesday, July 12, 2006 12:23 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: weird behavior for jffs2 on PQ2FADS-VR board
>=20
>=20
> Hi all:
>     I brought up linux-2.4.30 on PQ2FADS-VR board, everything=20
> was fine untill i try to mount the jffs2.  My mtd partition=20
> looks like this:
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
> "mount -t jffs2 /dev/mtdblock3 /mnt", it showed as mounted,=20
> then I issued "echo "hello,world" > test.txt" to create a=20
> file, a warning was printed out "Node totlen on flash=20
> (0x44000000) !=3D totlen in node ref (0x00000044)" , but=20
> subsequent "cat test.txt " still showed the correct string=20
> from that newly created file". However, after I umount the =20
> file and remount it again, it give me lots of errors" Magic=20
> bitmask 0x1985 not found at 0x00240004: 0x0c00 instead" Then=20
> the moutn operation failed.
>     I am suspecting it is mtd driver problem (the board use=20
> LH28F016SCT-L95 from sharp). But don't know how to proceed ,=20
> e.g. how to verify the content was written into flash in a=20
> mounted jffs2 file system?
>     Has anybody experienced similar issue? Any suggestion?
>     Forgive me if this is wrong list to post, and very=20
> appreciate if anybody can direct me to the right place.
>=20
> Thanks!
> lei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org=20
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
