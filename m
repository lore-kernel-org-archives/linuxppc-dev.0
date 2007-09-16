Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ED8ADDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 02:27:59 +1000 (EST)
Date: Sun, 16 Sep 2007 18:27:47 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Stefan Roese <sr@denx.de>
Message-ID: <20070916162747.GV23573@pengutronix.de>
References: <200709161352.03459.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200709161352.03459.sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 16, 2007 at 01:52:02PM +0200, Stefan Roese wrote:
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 9f3a4cd..12453e2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -220,7 +220,17 @@ config I2C_PIIX4
>  
>  config I2C_IBM_IIC
>  	tristate "IBM PPC 4xx on-chip I2C interface"
> -	depends on IBM_OCP
> +	depends on !PPC_MERGE
> +	help
> +	  Say Y here if you want to use IIC peripheral found on 
> +	  embedded IBM PPC 4xx based systems. 

Can we agree on one nomenclature - either i2c or iic?

> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-ibm_iic.

Are these drivers the same functionality (host i2c driver for 4xx)? If
yes, shouldn't all in-tree users be migrated over and the old style
driver be removed (with deprecation period)?

> +#define DBG_LEVEL 0
> +
> +#ifdef DBG
> +#undef DBG
> +#endif
> +
> +#ifdef DBG2
> +#undef DBG2
> +#endif
> +
> +#if DBG_LEVEL > 0
> +#  define DBG(f,x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
> +#else
> +#  define DBG(f,x...)	((void)0)
> +#endif
> +#if DBG_LEVEL > 1
> +#  define DBG2(f,x...) 	DBG(f, ##x)
> +#else
> +#  define DBG2(f,x...) 	((void)0)
> +#endif

Any reason why you can't use pr_debug?

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
