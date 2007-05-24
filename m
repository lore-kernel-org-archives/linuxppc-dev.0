Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BC02DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 17:31:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4O7Vfgp020171
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 00:31:42 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4O7VexW019255
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:31:41 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support
	ofMPC8641D
Date: Thu, 24 May 2007 15:31:39 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C307048@zch01exm26.fsl.freescale.net>
In-Reply-To: <1179934657.11247.14.camel@pterry-fc6.micromemory.com>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<1179934657.11247.14.camel@pterry-fc6.micromemory.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: <pterry@micromemory.com>, <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > >                 interrupts =3D <30 1 31 1 32 1 35 1 36 1=20
> 37 1 38 1>;
> > > >               };
> > > >
> > > Do you really use all of this interrupts? In my test,=20
> three <32 2 35 2
> > > 36 2> are okay, and the sense is 2.
> >=20
> > I think we need to list all the interrupts possible from=20
> RIO, not just the
> > ones the driver happens to use.
> Sorry about the senses, again I just threw that in the email as a
> strawman to kick off discussion (which now seems moot as Wei has the
> patches (yippee)). The second set of interrupts 37 and 38 are for the
> second message unit which I want to use (see above). 30 is for
> port-write/error which I will be using to get interrupts from my
> switches for topology changes. 31 is the out doorbell done which the
> driver doesn't use cos of the synchronous nature of the out doorbell I
> suppose.

About this interrupts, I suggest to put the BELL, Tx, Rx to the front of
others. These three is already be used in ppc rio codes.
For example:
	/* bell_irq tx_irq rx_irq */
	interrupts =3D <32 2 35 2 36 2>;

Thanks!
Wei.
