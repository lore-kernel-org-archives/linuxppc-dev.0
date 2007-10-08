Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C37D3DDF69
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:55:49 +1000 (EST)
In-Reply-To: <4708C3B2.1050103@semihalf.com>
References: <47075FA7.3030108@semihalf.com> <4708C3B2.1050103@semihalf.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E000945-34FF-476F-8F20-5F0EA10D00D2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/15] [POWERPC] Add mpc52xx_restart(), mpc52xx_halt(),
	mpc52xx_power_off().
Date: Mon, 8 Oct 2007 08:56:05 -0500
To: Marian Balakowicz <m8@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2007, at 6:32 AM, Marian Balakowicz wrote:

>
> Add common MPC5200 helper routines: mpc52xx_restart(), mpc52xx_halt(),
> mpc52xx_power_off().
>
> This patch relies on Sascha Hauer's patch published in:
> http://patchwork.ozlabs.org/linuxppc/patch?id=8910.
>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   45 +++++++++++++++ 
> ++++++++++++
>  include/asm-powerpc/mpc52xx.h                |    7 ++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/ 
> powerpc/platforms/52xx/mpc52xx_common.c
> index b1cd7b0..e7087d7 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -88,6 +88,14 @@ mpc52xx_find_ipb_freq(struct device_node *node)
>  }
>  EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
>
> +/*
> + * This variable is mapped in mpc52xx_setup_cpu() by a call to
> + * mpc52xx_find_and_map(), and used in mpc52xx_restart(). This is  
> because
> + * mpc52xx_restart() can be called from interrupt context (e.g.,  
> watchdog
> + * interrupt handler), and mpc52xx_find_and_map() (ioremap() to be  
> exact)
> + * can't be called from interrupt context.
> + */
> +volatile struct mpc52xx_gpt *mpc52xx_gpt0 = NULL;
>
>  void __init
>  mpc52xx_setup_cpu(void)
> @@ -95,6 +103,9 @@ mpc52xx_setup_cpu(void)
>  	struct mpc52xx_cdm  __iomem *cdm;
>  	struct mpc52xx_xlb  __iomem *xlb;
>
> +	/* mpc52xx_gpt0 is mapped here and used in mpc52xx_restart */
> +	mpc52xx_gpt0 = mpc52xx_find_and_map("mpc5200-gpt");
> +
>  	/* Map zones */
>  	cdm = mpc52xx_find_and_map("mpc5200-cdm");
>  	xlb = mpc52xx_find_and_map("mpc5200-xlb");
> @@ -138,3 +149,37 @@ mpc52xx_declare_of_platform_devices(void)
>  			"Error while probing of_platform bus\n");
>  }
>
> +void
> +mpc52xx_restart(char *cmd)
> +{
> +	local_irq_disable();
> +
> +	/* Turn on the watchdog and wait for it to expire. It effectively
> +	  does a reset */
> +	if (mpc52xx_gpt0) {
> +		out_be32(&mpc52xx_gpt0->mode, 0x00000000);
> +		out_be32(&mpc52xx_gpt0->count, 0x000000ff);
> +		out_be32(&mpc52xx_gpt0->mode, 0x00009004);
> +	} else
> +		printk("mpc52xx_restart: Can't access gpt. "
> +			"Restart impossible, system halted\n");
> +
> +	while (1);
> +}
> +
> +void
> +mpc52xx_halt(void)
> +{
> +	local_irq_disable();
> +
> +	while (1);
> +}
> +
> +void
> +mpc52xx_power_off(void)
> +{
> +	/* By default we don't have any way of shut down.
> +	   If a specific board wants to, it can set the power down
> +	   code to any hardware implementation dependent code */
> +	mpc52xx_halt();
> +}

If you are just going to spin don't bother implementing these.  The  
generic routines will do the same.

- k
