Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB821DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 16:48:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4O6mJCc000768
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 23:48:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4O6mIT7006454
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 01:48:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support
	ofMPC8641D
Date: Thu, 24 May 2007 14:48:16 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C307037@zch01exm26.fsl.freescale.net>
In-Reply-To: <200705230105.53013.arnd@arndb.de>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<200705230105.53013.arnd@arndb.de>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>, <linuxppc-dev@ozlabs.org>,
	<pterry@micromemory.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Arnd,

> >=20
> > Then I should pass np into the various setup routines as=20
> above so that
> > they can find the interrupts, etc.
> >=20
> > Is this the right kind of flavor or have I misunderstood how the dtb
> > stuff is supposed to integrate with the susbsys_initcall stuff.
>=20
> the thing you are missing is probably the of_platform_driver. Your
> driver should have something like
>=20
> static struct of_device_id mpc85xx_rio_ids[] =3D {
> 	{ .compatible =3D "fsl,8641d-rapidio", .data =3D RIO_8641 },
> 	{ .compatible =3D "fsl,8540-rapidio", .data =3D RIO_8540 },
> 	{ },
> };
> static struct of_platform_driver mpc85xx_rio_driver =3D {
> 	.name =3D "mpc85xx_rio",
> 	.match_table =3D &mpc85xx_rio_ids,
> 	.probe =3D mpc85xx_rio_probe,
> };
> static int __init mpc85xx_rio_init(void)
> {
> 	return of_register_platform_driver(&mpc85xx_rio_driver);
> }
> subsys_initcall(mpc85xx_rio_init);
>=20
> > I'm assuming we are supposed to do away with all the CONFIG_RAPIDIO,
> > CONFIG_MPCxyz etc so that the kernel is driven by the dtb?
>=20


I'm not agree with you.

Of_platform_driver is a good framework. But this RapidIO driver is not a
device driver. It's a _bus_ driver very similar to PCI bus. So,
of_platform_driver is not fit here.

Thanks!
Wei.
