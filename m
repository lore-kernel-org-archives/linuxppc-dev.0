Return-Path: <tnt@246tNt.com>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 628A1DDE47
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 00:18:13 +1100 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0BDHwGt002007
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 14:17:59 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A63883.2070800@246tNt.com>
Date: Thu, 11 Jan 2007 14:15:47 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add restart function for mpc52xx
References: <20070111122855.GF11226@localhost.localdomain>
In-Reply-To: <20070111122855.GF11226@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sascha Hauer wrote:
> This patch adds restart support for mpx52xx systems.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>   
Thanks, I'll test and include this to my 2.6.21 patch set.
> ---
>  arch/powerpc/platforms/52xx/lite5200.c       |    1 +
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   15 +++++++++++++++
>  include/asm-powerpc/mpc52xx.h                |    2 ++
>  3 files changed, 18 insertions(+)
>
> Index: linux-2.6/arch/powerpc/platforms/52xx/lite5200.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/52xx/lite5200.c
> +++ linux-2.6/arch/powerpc/platforms/52xx/lite5200.c
> @@ -153,6 +153,7 @@ define_machine(lite52xx) {
>  	.name 		= "lite52xx",
>  	.probe 		= lite52xx_probe,
>  	.setup_arch 	= lite52xx_setup_arch,
> +	.restart	= mpc52xx_restart,
>  	.init		= mpc52xx_declare_of_platform_devices,
>  	.init_IRQ 	= mpc52xx_init_irq,
>  	.get_irq 	= mpc52xx_get_irq,
> Index: linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -75,6 +75,21 @@ mpc52xx_find_ipb_freq(struct device_node
>  }
>  EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
>  
> +void
> +mpc52xx_restart(char *cmd)
> +{
> +	struct mpc52xx_gpt *gpt = mpc52xx_find_and_map("mpc52xx-gpt");
>   
missing __iomem here, will most trigger a sparse warning.
It's ok I'll fix that up when applying to my internal tree and before fw
this upstream.
> +
> +	local_irq_disable();
> +
> +	/* Turn on the watchdog and wait for it to expire. It effectively
> +	  does a reset */
> +	out_be32(&gpt->mode, 0x00000000);
> +	out_be32(&gpt->count, 0x0000000ff);
> +	out_be32(&gpt->mode, 0x00009004);
> +
> +	while (1);
> +}
>  
>  void __init
>  mpc52xx_setup_cpu(void)
> Index: linux-2.6/include/asm-powerpc/mpc52xx.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/mpc52xx.h
> +++ linux-2.6/include/asm-powerpc/mpc52xx.h
> @@ -249,6 +249,8 @@ extern void mpc52xx_declare_of_platform_
>  extern void mpc52xx_init_irq(void);
>  extern unsigned int mpc52xx_get_irq(void);
>  
> +extern void mpc52xx_restart(char *cmd);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __ASM_POWERPC_MPC52xx_H__ */
>
>
>   
