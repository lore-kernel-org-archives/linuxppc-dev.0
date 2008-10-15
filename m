Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 52FA7DE35D
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 02:51:43 +1100 (EST)
Date: Wed, 15 Oct 2008 19:51:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: SPI: specify chip select active high
Message-ID: <20081015155140.GA29309@oksana.dev.rtsoft.ru>
References: <1224075647.4022.33.camel@galileo.recco.de>
	<20081015142228.GD16262@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081015142228.GD16262@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Ocker <weo@reccoware.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2008 at 08:22:28AM -0600, Grant Likely wrote:
> On Wed, Oct 15, 2008 at 03:00:47PM +0200, Wolfgang Ocker wrote:
> > The patch allows to specify that an SPI device needs an active high chip
> > select.
> 
> This look reasonable to me.  Anyone else have comments on this binding?

Looks good. I'm assuming that a spi controller has its own chip select
machine, since for GPIO chip-select we can pass active-high/low stuff
via gpios = <> property. But well, we can support both ways even for
GPIO chip-selects, I see no problem.

> g.
> 
> > 
> > Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> > ---
> > 
> > --- linux-2.6.27-rc7/drivers/of/of_spi.c.of_spi_cshigh	2008-09-22 00:29:55.000000000 +0200
> > +++ linux-2.6.27-rc7/drivers/of/of_spi.c	2008-09-29 13:43:06.000000000 +0200
> > @@ -61,6 +61,8 @@
> >  			spi->mode |= SPI_CPHA;
> >  		if (of_find_property(nc, "spi-cpol", NULL))
> >  			spi->mode |= SPI_CPOL;
> > +		if (of_find_property(nc, "spi-cs-high", NULL))
> > +			spi->mode |= SPI_CS_HIGH;
> >  
> >  		/* Device speed */
> >  		prop = of_get_property(nc, "spi-max-frequency", &len);
> > --- linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt.of_spi_cshigh	2008-09-29 14:14:08.000000000 +0200
> > +++ linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt	2008-09-29 14:24:26.000000000 +0200
> > @@ -1917,6 +1917,8 @@
> >  			inverse clock polarity (CPOL) mode
> >      - spi-cpha        - (optional) Empty property indicating device requires
> >  			shifted clock phase (CPHA) mode
> > +    - spi-cs-high     - (optional) Empty property indicating device requires
> > +			chip select active high
> >  
> >      SPI example for an MPC5200 SPI bus:
> >  		spi@f00 {
> > 
> > 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
