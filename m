Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEA68DDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 18:53:51 +1000 (EST)
In-Reply-To: <20070726135655.GA5643@localhost.localdomain>
References: <20070726135655.GA5643@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2D3B9342-F5A2-47EB-A153-F47BBD2DEB32@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] fsl_soc: add support for fsl_spi
Date: Fri, 27 Jul 2007 03:54:46 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2007, at 8:56 AM, Anton Vorontsov wrote:

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   76 ++++++++++++++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/sysdev/fsl_soc.h |    3 ++
>  2 files changed, 79 insertions(+), 0 deletions(-)

There should be 2nd patch with updates to documentation for the SPI  
device node.

>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index 3289fab..0599851 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1125,3 +1125,79 @@ err:
>  arch_initcall(cpm_smc_uart_of_init);
>
>  #endif /* CONFIG_8xx */
> +
> +void (*fsl_spi_activate_cs)(u8 cs, u8 polarity) = NULL;
> +EXPORT_SYMBOL(fsl_spi_activate_cs);
> +void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity) = NULL;
> +EXPORT_SYMBOL(fsl_spi_deactivate_cs);
> +

I don't think we should do it this way.  We shouldn't arch_initcall()  
scan for fsl_spi, but have the board code call a function and pass  
some things into it.

> +static int __init fsl_spi_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i;
> +
> +	for (np = NULL, i = 1;
> +	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
> +	     i++) {
> +		int ret = 0;
> +		const char *devid, *sysclk, *mode, *max_cs;
> +		struct resource res[2];
> +		struct platform_device *pdev = NULL;
> +		struct fsl_spi_platform_data pdata = {
> +			.activate_cs = fsl_spi_activate_cs,
> +			.deactivate_cs = fsl_spi_deactivate_cs,
> +		};
> +
> +		memset(res, 0, sizeof(res));
> +
> +		devid = of_get_property(np, "device-id", NULL);
> +		sysclk = of_get_property(np, "sysclk", NULL);
> +		mode = of_get_property(np, "mode", NULL);
> +		max_cs = of_get_property(np, "max-chipselect", NULL);
> +		if (!devid || !sysclk || !mode || !max_cs)
> +			goto err;
> +
> +		pdata.bus_num = *(u32 *)devid;
> +		pdata.sysclk = *(u32 *)sysclk;
> +		pdata.max_chipselect = *(u32 *)max_cs;
> +		if (!strcmp(mode, "qe"))
> +			pdata.qe_mode = 1;
> +
> +		ret = of_address_to_resource(np, 0, &res[0]);
> +		if (ret)
> +			goto err;
> +
> +		res[1].start = res[2].end = irq_of_parse_and_map(np, 0);
> +		if (res[1].start == NO_IRQ)
> +			goto err;
> +
> +		res[1].name = "mpc83xx_spi";
> +		res[1].flags = IORESOURCE_IRQ;;
> +
> +		pdev = platform_device_alloc("mpc83xx_spi", i);
> +		if (!pdev)
> +			goto err;
> +
> +		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
> +		if (ret)
> +			goto unreg;
> +
> +		ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
> +		if (ret)
> +			goto unreg;
> +
> +		ret = platform_device_register(pdev);
> +		if (ret)
> +			goto unreg;
> +
> +		continue;
> +unreg:
> +		platform_device_del(pdev);
> +err:
> +		continue;
> +	}
> +
> +	return 0;
> +}
> +
> +arch_initcall(fsl_spi_of_init);
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/ 
> fsl_soc.h
> index 04e145b..c9de2a2 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -8,5 +8,8 @@ extern phys_addr_t get_immrbase(void);
>  extern u32 get_brgfreq(void);
>  extern u32 get_baudrate(void);
>
> +extern void (*fsl_spi_activate_cs)(u8 cs, u8 polarity);
> +extern void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity);
> +
>  #endif
>  #endif
> -- 
> 1.5.0.6
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
