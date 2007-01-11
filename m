Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com (unknown [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2B3DDDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 01:00:00 +1100 (EST)
In-Reply-To: <20070111122855.GF11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Date: Thu, 11 Jan 2007 07:59:12 -0600
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2007, at 6:28 AM, Sascha Hauer wrote:

> This patch adds restart support for mpx52xx systems.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
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
> +

This suffers from the same bug mpc83xx_restart has.  We can NOT do an  
ioremap inside the restart function.  We may get called from  
interrupt context on a panic and will not be able to do the ioremap 
().  The simplest thing is to do the mapping earlier in an init call  
and save the pointer, its not perfect, but better.

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
