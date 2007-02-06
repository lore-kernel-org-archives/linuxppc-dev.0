Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92BC6DDEC0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 03:50:08 +1100 (EST)
In-Reply-To: <20070205204337.GA3683@ld0162-tx32.am.freescale.net>
References: <20070205204337.GA3683@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D26B7BE4-CE6E-48FC-B702-07CDA093FB7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] 83xx: ioremap() the entire IMMR for misc register
	blocks.
Date: Tue, 6 Feb 2007 10:49:10 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 2:43 PM, Scott Wood wrote:

> Rather than add each component of the IMMR to the device tree as a
> separate device, the entire IMMR is made available for code which
> wants to access registers at known locations.
>
> This is intended to be used for simple things are very unlikely to be
> moved or duplicated, such as reset registers.

I'd prefer to leave this as it is until we have multiple cases that  
need a long lived immr pointer.  Also, if you notice in the .dts the  
register space in the 'soc' node only covers the system config space  
and not all immr space, this was intentional when we setup the 'soc'  
nodes.

> To avoid accidentally touching another soc family in the event that
> support for multiple families is built into the kernel (at some future
> date where that is supported), a compatible property is added to the
> device tree soc node.

I'm ok with this, see comments below.  Feel free to split this part  
out into a separate patch.

>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8349emds.dts  |    1 +
>  arch/powerpc/boot/dts/mpc8349emitx.dts |    1 +
>  arch/powerpc/boot/dts/mpc8360emds.dts  |    1 +
>  arch/powerpc/sysdev/fsl_soc.c          |   29 +++++++++++++++++++++ 
> ++++++++
>  arch/powerpc/sysdev/fsl_soc.h          |    3 +++
>  5 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/ 
> boot/dts/mpc8349emds.dts
> index efceb34..c7ff2f1 100644
> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
> @@ -47,6 +47,7 @@
>  		ranges = <0 e0000000 00100000>;
>  		reg = <e0000000 00000200>;
>  		bus-frequency = <0>;
> +		compatible = "mpc8349\0mpc834x\0mpc83xx";

I'm ok with mpc8349, and mpc834x, but mpc83xx is too much of stretch.

>
>  		wdt@200 {
>  			device_type = "watchdog";
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/ 
> boot/dts/mpc8349emitx.dts
> index 27807fc..0a3dde8 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -46,6 +46,7 @@
>  		ranges = <0 e0000000 00100000>;
>  		reg = <e0000000 00000200>;
>  		bus-frequency = <0>;                    // from bootloader
> +		compatible = "mpc8349\0mpc834x\0mpc83xx";
>
>  		wdt@200 {
>  			device_type = "watchdog";
> diff --git a/arch/powerpc/boot/dts/mpc8360emds.dts b/arch/powerpc/ 
> boot/dts/mpc8360emds.dts
> index 9022192..6e3f708 100644
> --- a/arch/powerpc/boot/dts/mpc8360emds.dts
> +++ b/arch/powerpc/boot/dts/mpc8360emds.dts
> @@ -62,6 +62,7 @@
>  		ranges = <0 e0000000 00100000>;
>  		reg = <e0000000 00000200>;
>  		bus-frequency = <FBC5200>;
> +		compatible = "mpc8360\0mpc836x\0mpc83xx";
>
>  		wdt@200 {
>  			device_type = "watchdog";
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index ad31e56..e395936 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -63,6 +63,35 @@ phys_addr_t get_immrbase(void)
>
>  EXPORT_SYMBOL(get_immrbase);
>
> +#ifdef CONFIG_83xx
> +void __iomem *mpc83xx_immr;
> +#endif
> +
> +static int __init map_immr(void)
> +{
> +	struct device_node *soc;
> +
> +	soc = of_find_node_by_type(NULL, "soc");
> +	if (soc) {
> +		struct resource res;
> +		int ret = of_address_to_resource(soc, 0, &res);
> +		if (ret)
> +			return ret;
> +
> +#ifdef CONFIG_83xx
> +		if (device_is_compatible(soc, "mpc83xx"))
> +			mpc83xx_immr = ioremap(res.start,
> +			                       res.end - res.start + 1);
> +#endif
> +
> +		of_node_put(soc);
> +	};
> +
> +	return 0;
> +}
> +
> +arch_initcall(map_immr);
> +
>  #ifdef CONFIG_CPM2
>
>  static u32 brgfreq = -1;
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/ 
> fsl_soc.h
> index 04e145b..a02978e 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -2,11 +2,14 @@
>  #define __PPC_FSL_SOC_H
>  #ifdef __KERNEL__
>
> +#include <linux/compiler.h>
>  #include <asm/mmu.h>
>
>  extern phys_addr_t get_immrbase(void);
>  extern u32 get_brgfreq(void);
>  extern u32 get_baudrate(void);
>
> +extern void __iomem *mpc83xx_immr;
> +
>  #endif
>  #endif
> -- 
> 1.4.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
