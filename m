Return-Path: <MBenedict@twacs.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E806DDDF0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 02:23:22 +1000 (EST)
Received: from outbound2-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-blu-R.bigfish.com (Postfix) with ESMTP id 8EEC513B1D1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 16:23:15 +0000 (UTC)
Received: from mail107-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound2-blu.bigfish.com (Postfix) with ESMTP id D690B30080
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 16:23:10 +0000 (UTC)
Received: from mail107-blu (localhost.localdomain [127.0.0.1])
	by mail107-blu-R.bigfish.com (Postfix) with ESMTP id A3CEE1940221
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 16:23:08 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail107-blu.bigfish.com (Postfix) with ESMTP id 70298B200CF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 16:23:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC 8349e-mITX and MTD/Flash
Date: Tue, 10 Apr 2007 11:22:48 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795D3@twx-exch01.twacs.local>
In-Reply-To: <461BB1DB.9050503@freescale.com>
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>
	<CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
	<461BB1DB.9050503@freescale.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: "Timur Tabi" <timur@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Your settings for CONFIG_MTD_PHYSMAP_START and=20
>CONFIG_MTD_PHYSMAP_LEN are wrong.  And=20
>frankly, I can't understand where you got those values from,=20
>unless you created your=20
>.config from scratch.  The defconfig that's in the kernel is=20
>specifically intended for the=20
>Freescale MPC8349E-mITX.  I should know, because I wrote the=20
>code and the defconfig.

I didn't even know about the defconfig until I started looking into this
issue.  I tried to "upgrade" the .config that came with the CD but I
can't tell you how I introduced these values.  That said, I was able to
change my configuration to the values in the defconfig and...

# mtd_debug info /dev/mtd0
mtd.type =3D MTD_NORFLASH
mtd.flags =3D
mtd.size =3D 16777216 (16M)
mtd.erasesize =3D 65536 (64K)
mtd.oobblock =3D 1
mtd.oobsize =3D 0
mtd.ecctype =3D MTD_ECC_NONE
regions =3D 4

region[0].offset =3D 0x00000000
region[0].erasesize =3D 65536 (64K)
region[0].numblocks =3D 127
region[0].regionindex =3D 0
region[1].offset =3D 0x007f0000
region[1].erasesize =3D 8192 (8K)
region[1].numblocks =3D 8
region[1].regionindex =3D 1
region[2].offset =3D 0x00800000
region[2].erasesize =3D 65536 (64K)
region[2].numblocks =3D 127
region[2].regionindex =3D 2
region[3].offset =3D 0x00ff0000
region[3].erasesize =3D 8192 (8K)
region[3].numblocks =3D 8
region[3].regionindex =3D 3

Its working!  Thank you everyone for helping me figure this out.

>
>Having said that, it seems that the kernel now supports=20
>defining the physmap via the OF=20
>tree.  Is that true?


Initially I was going to try and define this via the OF tree.  However,
the documentation indicated that the only supported device_type was
"rom" so I did not persue that route.
	-Michael
