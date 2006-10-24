Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 85F5167A3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 17:19:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9O7JodE029901 for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 00:19:50 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9O7JiDG022685
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 02:19:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: ARCH=powerpc: IRQ numbers change mysteriously
Date: Tue, 24 Oct 2006 15:20:30 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D2071C7@zch01exm20.fsl.freescale.net>
In-Reply-To: <20061023164116.GC15953@igloo.df.lth.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Fredrik Roubert" <fredrik.roubert@barco.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The irq number on powerpc ARCH is now a virtual number.  This change was
introduced by Ben's irq mapping change in early 2.6.18-rc.

- Leo

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> Fredrik Roubert
> Sent: Tuesday, October 24, 2006 12:41 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: ARCH=3Dpowerpc: IRQ numbers change mysteriously
>=20
> Hi!
>=20
> On my MPC8439 based board, running Linux 2.6.18 with ARCH=3Dpowerpc, =
the
> IRQ's for the I2C behave in a for me mysterious way.
>=20
> In my DTS file, I have the following:
>=20
>=20
> i2c@3000 {
> 	device_type =3D "i2c";
> 	compatible =3D "fsl-i2c";
> 	reg =3D <3000 100>;
> 	interrupts =3D <e 8>;
> 	interrupt-parent =3D <&/soc8349@ff400000/pic@700>;
> 	dfsrr;
> };
>=20
> i2c@3100 {
> 	device_type =3D "i2c";
> 	compatible =3D "fsl-i2c";
> 	reg =3D <3000 100>;
> 	interrupts =3D <f 8>;
> 	interrupt-parent =3D <&/soc8349@ff400000/pic@700>;
> 	dfsrr;
> };
>=20
>=20
> But when I boot the system and cat /proc/interrupts, the output says:
>=20
>=20
> 18:         61   IPIC   Level     i2c-mpc
> 19:          0   IPIC   Level     i2c-mpc
>=20
>=20
> This doesn't make sense to me. Why are the IRQ numbers changed? They
are
> still adjacent, so it seems to be some logic to the change. Does
anyone
> know what this is?
>=20
> Cheers // Fredrik Roubert
>=20
> --
> Barco Medical Imaging          |  +32 56 233549
> http://www.barco.com/medical/  |  fredrik.roubert@barco.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
