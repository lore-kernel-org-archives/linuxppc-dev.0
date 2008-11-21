Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id 75377DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 14:40:05 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [spi-devel-general] [PATCH v4] spi: Add PPC4xx SPI driver
Date: Thu, 20 Nov 2008 19:40:01 -0800
References: <1225451266-23740-1-git-send-email-sr@denx.de>
In-Reply-To: <1225451266-23740-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811201940.02277.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 31 October 2008, Stefan Roese wrote:
> +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
> +{
> 		...
>
> +       if (in_8(&hw->regs->cdm) != cdm)
> +               out_8(&hw->regs->cdm, cdm);

... writes to hardware, updating SPI the clock rate ...


> +static int spi_ppc4xx_setup(struct spi_device *spi)
> +{
> 	...
> +
> +       ret = spi_ppc4xx_setupxfer(spi, NULL);

... hence this also writes to the hardware.

Except ... the setup() method may be called for one SPI device
in the middle of a transfer for another device.  This might for
example cause the clock rate to speed up so it's too fast, thus
corrupting a transfer for that other device.  So you should NOT
be calling setupxfer() here.



> +       /* write new configration */
> +       out_8(&hw->regs->mode, mode);

Or here:  changing from a device using MSB-first mode 3 to
one using LSB-first mode 1.  This could also corrupt a transfer.


It might be better to have the setup() validate its inputs
and store them in the spi->controller_state, and then have
the setup_transfer() pull values from there ... but not make
setup() call setupxfer().  The best model would be that each
chipselect has its own set of speed/mode registers; if the
hardware doesn't work that way, then it can be emulated.


> +static int __init spi_ppc4xx_init(void)
> +{
> +       return of_register_platform_driver(&spi_ppc4xx_of_driver);
> +}
> +
> +static void __exit spi_ppc4xx_exit(void)
> +{
> +       of_unregister_platform_driver(&spi_ppc4xx_of_driver);
> +}
> +
> +module_init(spi_ppc4xx_init);
> +module_exit(spi_ppc4xx_exit);

I prefer to see module_{init,exit} annotations snugged up next
to the functions to which they apply ... just like EXPORT_SYMBOL
annotations, and for the same reasons.

- Dave
