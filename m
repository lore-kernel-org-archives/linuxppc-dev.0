Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60FE4DDEE8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:45:17 +1000 (EST)
Date: Thu, 26 Jul 2007 11:45:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC][PATCH] fsl_soc: add support for fsl_spi
Message-ID: <20070726164508.GB28491@ld0162-tx32.am.freescale.net>
References: <20070726135655.GA5643@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726135655.GA5643@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 05:56:55PM +0400, Anton Vorontsov wrote:
> +void (*fsl_spi_activate_cs)(u8 cs, u8 polarity) = NULL;
> +EXPORT_SYMBOL(fsl_spi_activate_cs);
> +void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity) = NULL;
> +EXPORT_SYMBOL(fsl_spi_deactivate_cs);

What are these for?  It looks like you're using them to set pins,
but that should be done in the firmware (and if the firmware sucks, then
do it in the platform code at bootup).

> +static int __init fsl_spi_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i;
> +
> +	for (np = NULL, i = 1;
> +	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
> +	     i++) {

s/fsl_spi/fsl,mpc8323-spi/, please.

Why not make the fsl spi driver an of_platform device?

-Scott
