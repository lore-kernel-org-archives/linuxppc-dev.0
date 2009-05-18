Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 94B04DE0D2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 04:48:06 +1000 (EST)
Date: Mon, 18 May 2009 20:47:52 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Subject: Re: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090518184752.GA12972@iram.es>
References: <20090518173756.GA11805@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
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

On Mon, May 18, 2009 at 10:48:58AM -0700, Medve Emilian-EMMEDVE1 wrote:
> > -----Original Message-----
> > From: linuxppc-dev-bounces+emilian.medve=freescale.com@ozlabs.org
> [mailto:linuxppc-dev-
> > bounces+emilian.medve=freescale.com@ozlabs.org] On Behalf Of Gabriel
> Paubert
> > Sent: Monday, May 18, 2009 12:38 PM
> > To: Lennert Buytenhek
> > Cc: tbm@cyrius.com; LinuxPPC; pacman@kosh.dhis.org;
> netdev@vger.kernel.org; David Miller
> > Subject: [PATCH] Allow selecting mv643xx_eth on Pegasos again
> > 
> > Since PPC_MUTIPLATFORM was removed, it was impossible to select the
> > driver for mv643xx_eth on the Pegasos. Fix by allowing to select
> > the driver on CHRP platforms; Pegasos is a CHRP platform and the
> driver
> > will not work without arch/powerpc/platforms/chrp/pegasos_eth.
> > 
> > Signed-off-by: Gabriel Paubert <paubert@iram.es>
> > 
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index 214a92d..6fc0ff4 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -2351,7 +2351,7 @@ config UGETH_TX_ON_DEMAND
> > 
> >  config MV643XX_ETH
> >  	tristate "Marvell Discovery (643XX) and Orion ethernet support"
> > -	depends on MV64360 || MV64X60 || (PPC_MULTIPLATFORM && PPC32) ||
> PLAT_ORION
> > +	depends on MV64X60 || PPC_CHRP || PLAT_ORION
> >  	select INET_LRO
> >  	select PHYLIB
> >  	help
> 
> This got fixed here:
> http://git.kernel.org/?p=linux/kernel/git/davem/net-next-2.6.git;a=commi
> tdiff;h=952ee9df26c487f2d73b2dced58ec904f19ea0f8

Ok, I was not aware of it, but the fact is that MV64360 no more exists
and the only non MV64X60 platform that may need it is the Pegasos (to my
knowledge) and it relies on some platform specific code enabled
by PPC_CHRP.

	Regards,
	Gabriel
