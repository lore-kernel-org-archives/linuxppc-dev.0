Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 66DFADE40F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 01:22:32 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2750524wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 07:22:31 -0700 (PDT)
Date: Wed, 15 Oct 2008 08:22:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH] powerpc: SPI: specify chip select active high
Message-ID: <20081015142228.GD16262@secretlab.ca>
References: <1224075647.4022.33.camel@galileo.recco.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224075647.4022.33.camel@galileo.recco.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2008 at 03:00:47PM +0200, Wolfgang Ocker wrote:
> The patch allows to specify that an SPI device needs an active high chip
> select.

This look reasonable to me.  Anyone else have comments on this binding?

g.

> 
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> ---
> 
> --- linux-2.6.27-rc7/drivers/of/of_spi.c.of_spi_cshigh	2008-09-22 00:29:55.000000000 +0200
> +++ linux-2.6.27-rc7/drivers/of/of_spi.c	2008-09-29 13:43:06.000000000 +0200
> @@ -61,6 +61,8 @@
>  			spi->mode |= SPI_CPHA;
>  		if (of_find_property(nc, "spi-cpol", NULL))
>  			spi->mode |= SPI_CPOL;
> +		if (of_find_property(nc, "spi-cs-high", NULL))
> +			spi->mode |= SPI_CS_HIGH;
>  
>  		/* Device speed */
>  		prop = of_get_property(nc, "spi-max-frequency", &len);
> --- linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt.of_spi_cshigh	2008-09-29 14:14:08.000000000 +0200
> +++ linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt	2008-09-29 14:24:26.000000000 +0200
> @@ -1917,6 +1917,8 @@
>  			inverse clock polarity (CPOL) mode
>      - spi-cpha        - (optional) Empty property indicating device requires
>  			shifted clock phase (CPHA) mode
> +    - spi-cs-high     - (optional) Empty property indicating device requires
> +			chip select active high
>  
>      SPI example for an MPC5200 SPI bus:
>  		spi@f00 {
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
