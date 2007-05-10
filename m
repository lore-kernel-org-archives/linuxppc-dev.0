Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 903AADDD09
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:40:58 +1000 (EST)
Date: Wed, 9 May 2007 22:36:33 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 09/13] fsl_soc: Factor fsl_get_bus_freq() out of the wdt
	init.
In-Reply-To: <20070507182953.GH26920@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0705092233070.29512@localhost.localdomain>
References: <20070507182953.GH26920@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 7 May 2007, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   44 ++++++++++++++++++++++------------------
>  arch/powerpc/sysdev/fsl_soc.h |    1 +
>  2 files changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 8a123c7..3b99433 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -64,6 +64,27 @@ phys_addr_t get_immrbase(void)
>
>  EXPORT_SYMBOL(get_immrbase);
>
> +u32 fsl_get_bus_freq(void)

Can we call this something more explicit, like fsl_get_sys_freq().
Otherwise this looks fine.

> +{
> +	struct device_node *soc = of_find_node_by_type(NULL, "soc");
> +	const u32 *freq;
> +	u32 ret = 0;
> +
> +	if (!soc)
> +		goto err;
> +
> +	freq = of_get_property(soc, "bus-frequency", NULL);
> +	if (!freq)
> +		goto err;
> +
> +	ret = *freq;
> +
> +err:
> +	of_node_put(soc);
> +	return ret;
> +}
> +EXPORT_SYMBOL(fsl_get_bus_freq);
> +
>  #if defined(CONFIG_CPM2) || defined(CONFIG_8xx)
>
>  static u32 brgfreq = -1;
> @@ -356,9 +377,9 @@ arch_initcall(fsl_i2c_of_init);
>  static int __init mpc83xx_wdt_init(void)
>  {
>  	struct resource r;
> -	struct device_node *soc, *np;
> +	struct device_node *np;
>  	struct platform_device *dev;
> -	const unsigned int *freq;
> +	u32 freq = fsl_get_bus_freq();
>  	int ret;
>
>  	np = of_find_compatible_node(NULL, "watchdog", "mpc83xx_wdt");
> @@ -368,19 +389,6 @@ static int __init mpc83xx_wdt_init(void)
>  		goto nodev;
>  	}
>
> -	soc = of_find_node_by_type(NULL, "soc");
> -
> -	if (!soc) {
> -		ret = -ENODEV;
> -		goto nosoc;
> -	}
> -
> -	freq = of_get_property(soc, "bus-frequency", NULL);
> -	if (!freq) {
> -		ret = -ENODEV;
> -		goto err;
> -	}
> -
>  	memset(&r, 0, sizeof(r));
>
>  	ret = of_address_to_resource(np, 0, &r);
> @@ -393,20 +401,16 @@ static int __init mpc83xx_wdt_init(void)
>  		goto err;
>  	}
>
> -	ret = platform_device_add_data(dev, freq, sizeof(int));
> +	ret = platform_device_add_data(dev, &freq, sizeof(int));
>  	if (ret)
>  		goto unreg;
>
> -	of_node_put(soc);
>  	of_node_put(np);
> -
>  	return 0;
>
>  unreg:
>  	platform_device_unregister(dev);
>  err:
> -	of_node_put(soc);
> -nosoc:
>  	of_node_put(np);
>  nodev:
>  	return ret;
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
> index 04e145b..7a9502d 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -7,6 +7,7 @@
>  extern phys_addr_t get_immrbase(void);
>  extern u32 get_brgfreq(void);
>  extern u32 get_baudrate(void);
> +extern u32 fsl_get_bus_freq(void);
>
>  #endif
>  #endif
>
