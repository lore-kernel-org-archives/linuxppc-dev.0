Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 176D2DDF8F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 13:29:31 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4L3TNJd010538
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 20:29:23 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4L3TLS2020831
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:29:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
Date: Wed, 21 May 2008 11:29:19 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A91586D@zch01exm27.fsl.freescale.net>
In-Reply-To: <177599B6-6236-4292-A69B-CA13617A6576@kernel.crashing.org>
References: <1211270856-26579-1-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-2-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-3-git-send-email-Jason.jin@freescale.com>
	<177599B6-6236-4292-A69B-CA13617A6576@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Tuesday, May 20, 2008 9:24 PM
> To: Jin Zhengxiong
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
>=20
> > diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/=20
> > powerpc/platforms/86xx/mpc8610_hpcd.c
> > index dea1320..290d717 100644
> > --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> > +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> > @@ -71,9 +71,13 @@ static void __init mpc86xx_hpcd_init_irq(void)
> > 	/* Alloc mpic structure and per isu has 16 INT entries. */
> > 	mpic1 =3D mpic_alloc(np, res.start,
> > 			MPIC_PRIMARY | MPIC_WANTS_RESET |=20
> MPIC_BIG_ENDIAN,
> > -			0, 256, " MPIC     ");
> > +			64, 256, " MPIC     ");
> > 	BUG_ON(mpic1 =3D=3D NULL);
> >
> > +	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
> > +	mpic_assign_isu(mpic1, 1, res.start + 0x10800);
> > +	mpic_assign_isu(mpic1, 2, res.start + 0x11600);
> > +
>=20
> I don't understand why you are breaking the interrupts up like this.
>=20
> If you leave as it was, the MSIs would start at hw irq 176

If the ISU size is 0, mpic will only initialize the interrupt source num
reading from
Feature Reporting Register(FRR), For 8610 it's 104, for 8572 it is 108,
As the address
space of the interrupt source configuration register is not
continuous(between 0xa00-0x1600),
 with ISU=3D0, actually only the 16 externel interrupts and 64 internal
interrupts were initialized.
the Messaging interrupts and MSI interrupts were not intialized.=20

With the original code. the Messaging interrupts would start at hwirq
176 and the MSIs would=20
start at hwirq 224.=20
By setting the ISU=3D64, the Messaging interrupts would start at 128 and
the MSIs start at 176.=20
And all the interrupt sources will be initialized.

Jason =20
