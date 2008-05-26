Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 48320DE07B
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 21:58:28 +1000 (EST)
Date: Mon, 26 May 2008 15:58:26 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
Message-ID: <20080526115826.GB26288@polina.dev.rtsoft.ru>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<20080523182842.GB469@polina.dev.rtsoft.ru>
	<20080524123527.04794974.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080524123527.04794974.sfr@canb.auug.org.au>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 24, 2008 at 12:35:27PM +1000, Stephen Rothwell wrote:
> Hi Anton,
> 
> On Fri, 23 May 2008 22:28:42 +0400 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +++ b/drivers/mmc/host/of_mmc_spi.c
> 
> > +static int of_mmc_spi_probe(struct spi_device *spi)
> 
> > +	/*
> > +	 * mmc_spi_probe will use drvdata, so we can't use it. Use node's
> > +	 * data instead.
> > +	 */
> > +	spi->dev.archdata.of_node->data = oms;
> 
> If you delay this assignment, you may not have to clean it up in the
> error path.

No, if I delay it I'll have to clean it up anyway, just a bit later
(after mmc_spi_probe() fail).

> > +	ocr_mask = of_get_property(np, "linux,mmc-ocr-mask", &size);
> 
> You should really explicitly include linux/of.h to use of_get_property etc

Thanks, will do.

> > +int __devexit of_mmc_spi_remove(struct spi_device *spi)
> > +{
> > +	struct of_mmc_spi *oms = spi->dev.archdata.of_node->data;
> > +	int ret;
> > +
> > +	ret = mmc_spi_remove(spi);
> > +	if (ret)
> > +		return ret;
> 
> Maybe you should do this last so that you don't leak more than necessary
> if mmc_spi_remove fails. (I don't know what state mmc_spi_remove leaves
> stuff in if it fails ...)

If I do this last, then of_mmc_spi_remove() would be not safe to call
multiple times on non-fatal errors (e.g. when mmc_spi_remove() returns
-EBUSY (despite that currently mmc_spi_remove can't fail)).

Also, if I do this last, then there will be a potential use-after-free
in the mmc_spi driver.

> > +static struct spi_driver of_mmc_spi_driver = {
> > +	.driver = {
> > +		.name = "of_mmc_spi",
> > +		.bus = &spi_bus_type,
> 
> This is initialised by spi_register_driver().

This was straight copy from the mmc_spi.c. Will fix.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
