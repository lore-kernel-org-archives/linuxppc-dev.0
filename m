Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by ozlabs.org (Postfix) with ESMTP id C85ABDED43
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:32:28 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so2915207fkz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:32:26 -0700 (PDT)
Date: Wed, 16 Apr 2008 01:32:22 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and
	spi inits.
Message-ID: <20080415213221.GA2646@zarina>
References: <20080415185234.GA10579@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080415185234.GA10579@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2008 at 01:52:34PM -0500, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   70 ++++++++++++++++++----------------------
>  arch/powerpc/sysdev/fsl_soc.h |    1 +
>  2 files changed, 33 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 642e45e..b6d6bda 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -75,6 +75,33 @@ phys_addr_t get_immrbase(void)
>  
>  EXPORT_SYMBOL(get_immrbase);
>  
> +static u32 sysfreq = -1;
> +
> +u32 fsl_get_sys_freq(void)
> +{
> +	struct device_node *soc;
> +	const u32 *prop;
> +	int size;
> +
> +	if (sysfreq != -1)
> +		return sysfreq;
> +
> +	soc = of_find_node_by_type(NULL, "soc");
> +	if (!soc)
> +		return -1;

Um.. can we finally decide on compatible for the soc nodes,
and add there compatible matching from the start?

> +
> +	prop = of_get_property(soc, "clock-frequency", &size);
> +	if (!prop || size != sizeof(*prop) || *prop == 0)
> +		prop = of_get_property(soc, "bus-frequency", &size);
> +
> +	if (prop && size == sizeof(*prop))
> +		sysfreq = *prop;
> +
> +	of_node_put(soc);
> +	return sysfreq;
> +}
> +EXPORT_SYMBOL(fsl_get_sys_freq);
> +
>  #if defined(CONFIG_CPM2) || defined(CONFIG_QUICC_ENGINE) || defined(CONFIG_8xx)
>  
>  static u32 brgfreq = -1;
> @@ -516,9 +543,9 @@ arch_initcall(fsl_i2c_of_init);
>  static int __init mpc83xx_wdt_init(void)
>  {
>  	struct resource r;
> -	struct device_node *soc, *np;
> +	struct device_node *np;
>  	struct platform_device *dev;
> -	const unsigned int *freq;
> +	u32 freq = fsl_get_sys_freq();
>  	int ret;
>  
>  	np = of_find_compatible_node(NULL, "watchdog", "mpc83xx_wdt");
> @@ -528,19 +555,6 @@ static int __init mpc83xx_wdt_init(void)
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
> @@ -553,20 +567,16 @@ static int __init mpc83xx_wdt_init(void)
>  		goto err;
>  	}
>  
> -	ret = platform_device_add_data(dev, freq, sizeof(int));
> +	ret = platform_device_add_data(dev, &freq, sizeof(freq));
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
> @@ -830,25 +840,9 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
>  	sysclk = get_brgfreq();
>  #endif
>  	if (sysclk == -1) {
> -		struct device_node *np;
> -		const u32 *freq;
> -		int size;
> -
> -		np = of_find_node_by_type(NULL, "soc");
> -		if (!np)
> +		sysclk = fsl_get_sys_freq();
> +		if (sysclk == -1)
>  			return -ENODEV;
> -
> -		freq = of_get_property(np, "clock-frequency", &size);
> -		if (!freq || size != sizeof(*freq) || *freq == 0) {
> -			freq = of_get_property(np, "bus-frequency", &size);
> -			if (!freq || size != sizeof(*freq) || *freq == 0) {
> -				of_node_put(np);
> -				return -ENODEV;
> -			}
> -		}
> -
> -		sysclk = *freq;
> -		of_node_put(np);
>  	}
>  
>  	ret = of_fsl_spi_probe(NULL, "fsl,spi", sysclk, board_infos,
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
> index 63e7db3..74c4a96 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -7,6 +7,7 @@
>  extern phys_addr_t get_immrbase(void);
>  extern u32 get_brgfreq(void);
>  extern u32 get_baudrate(void);
> +extern u32 fsl_get_sys_freq(void);
>  
>  struct spi_board_info;

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
