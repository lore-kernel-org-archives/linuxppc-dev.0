Return-Path: <Emilian.Medve@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B81EEDE09B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 06:15:17 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4IKFDtv004498
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:15:13 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4IKFDhf022053
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 15:15:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Date: Mon, 18 May 2009 13:15:12 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2702C2D3A5@az33exm24.fsl.freescale.net>
In-Reply-To: <20090518184752.GA12972@iram.es>
References: <20090518173756.GA11805@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
	<20090518184752.GA12972@iram.es>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: netdev@vger.kernel.org, tbm@cyrius.com, LinuxPPC <linuxppc-dev@ozlabs.org>,
	pacman@kosh.dhis.org, David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Gabriel,


> -----Original Message-----
> From: Gabriel Paubert [mailto:paubert@iram.es]
> Sent: Monday, May 18, 2009 1:48 PM
> To: Medve Emilian-EMMEDVE1
> Cc: Lennert Buytenhek; tbm@cyrius.com; LinuxPPC; pacman@kosh.dhis.org;
netdev@vger.kernel.org; David
> Miller
> Subject: Re: [PATCH] Allow selecting mv643xx_eth on Pegasos again
>=20
> On Mon, May 18, 2009 at 10:48:58AM -0700, Medve Emilian-EMMEDVE1
wrote:
> > > -----Original Message-----
> > > From: =
linuxppc-dev-bounces+emilian.medve=3Dfreescale.com@ozlabs.org
> > [mailto:linuxppc-dev-
> > > bounces+emilian.medve=3Dfreescale.com@ozlabs.org] On Behalf Of
Gabriel
> > Paubert
> > > Sent: Monday, May 18, 2009 12:38 PM
> > > To: Lennert Buytenhek
> > > Cc: tbm@cyrius.com; LinuxPPC; pacman@kosh.dhis.org;
> > netdev@vger.kernel.org; David Miller
> > > Subject: [PATCH] Allow selecting mv643xx_eth on Pegasos again
> > >
> > > Since PPC_MUTIPLATFORM was removed, it was impossible to select
the
> > > driver for mv643xx_eth on the Pegasos. Fix by allowing to select
> > > the driver on CHRP platforms; Pegasos is a CHRP platform and the
> > driver
> > > will not work without arch/powerpc/platforms/chrp/pegasos_eth.
> > >
> > > Signed-off-by: Gabriel Paubert <paubert@iram.es>
> > >
> > > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > > index 214a92d..6fc0ff4 100644
> > > --- a/drivers/net/Kconfig
> > > +++ b/drivers/net/Kconfig
> > > @@ -2351,7 +2351,7 @@ config UGETH_TX_ON_DEMAND
> > >
> > >  config MV643XX_ETH
> > >  	tristate "Marvell Discovery (643XX) and Orion ethernet support"
> > > -	depends on MV64360 || MV64X60 || (PPC_MULTIPLATFORM && PPC32) ||
> > PLAT_ORION
> > > +	depends on MV64X60 || PPC_CHRP || PLAT_ORION
> > >  	select INET_LRO
> > >  	select PHYLIB
> > >  	help
> >
> > This got fixed here:
> >
http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-next-2.6.git;a=3Dco=
mmi
> > tdiff;h=3D952ee9df26c487f2d73b2dced58ec904f19ea0f8
>=20
> Ok, I was not aware of it, but the fact is that MV64360 no more exists
> and the only non MV64X60 platform that may need it is the Pegasos (to
my
> knowledge) and it relies on some platform specific code enabled
> by PPC_CHRP.

You're correct. MV64360 seems to be stale. Do you want to re-spin your
patch to get rid of it?

(I wouldn't create a dependency between MV643XX_ETH and PPC_CHRP.)
=20

Cheers,
Emil.
