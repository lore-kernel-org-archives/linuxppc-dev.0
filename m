Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5BE82DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 21:13:10 +1000 (EST)
Date: Fri, 27 Jul 2007 15:12:42 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][PATCH] fsl_soc: add support for fsl_spi
Message-ID: <20070727111242.GA11463@localhost.localdomain>
References: <20070726135655.GA5643@localhost.localdomain>
	<20070726164508.GB28491@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070726164508.GB28491@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 11:45:08AM -0500, Scott Wood wrote:
> On Thu, Jul 26, 2007 at 05:56:55PM +0400, Anton Vorontsov wrote:
> > +void (*fsl_spi_activate_cs)(u8 cs, u8 polarity) = NULL;
> > +EXPORT_SYMBOL(fsl_spi_activate_cs);
> > +void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity) = NULL;
> > +EXPORT_SYMBOL(fsl_spi_deactivate_cs);
> 
> What are these for?  It looks like you're using them to set pins,
> but that should be done in the firmware (and if the firmware sucks, then
> do it in the platform code at bootup).

Nope, this is not to set [initial state of] pins. SPI layer needs
this to trigger MMC's chipselect, it's wired as usual GPIO pin, which
should be asserted (and then deasserted) by software at proper time.

Every board may have different implementation of
activate_cs/deactivate_cs, in mpc8323_rdb case it's implemented using
par_io_data_set().

(1)
Kumar Gala suggested to not use arch_initcall, but call fsl_spi_init()
explicitly by board file. So these global *_cs functions will go away.

> > +static int __init fsl_spi_of_init(void)
> > +{
> > +	struct device_node *np;
> > +	unsigned int i;
> > +
> > +	for (np = NULL, i = 1;
> > +	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
> > +	     i++) {
> 
> s/fsl_spi/fsl,mpc8323-spi/, please.

Will do for mpc832x_rdb. Should I also prepare patch to change all
instances of "fsl_spi" in the arch/powerpc/boot/dts/*?

> Why not make the fsl spi driver an of_platform device?

Well, I guess this is rhetoric question. Is fsl_soc.c's
OF<->platform_devices bindings officially deprecated?

If they're, I'll surely volunteer to convert it to of_platform.
But then (1) should be solved another way, yet don't know how.

> -Scott

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
