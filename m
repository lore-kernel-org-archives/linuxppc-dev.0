Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6048ADDF78
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 05:36:07 +1000 (EST)
Date: Fri, 6 Jun 2008 23:36:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [POWERPC] 86xx: suspend support
Message-ID: <20080606193605.GA22197@polina.dev.rtsoft.ru>
References: <20080606192443.GA20132@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080606192443.GA20132@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Jason Jin <Jason.jin@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ugh...

This should be From: Jason Jin <Jason.jin@freescale.com>, since
I've made only few small cleanups, the code itself is almost intact.

On Fri, Jun 06, 2008 at 11:24:43PM +0400, Anton Vorontsov wrote:
> This patch adds suspend (standby, not suspend-to-ram) support for MPC86xx
> processors.
> 
> In standby mode MPC86xx is able to wakeup only upon external interrupts
> (including sreset).
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/Kconfig                          |    2 +-
>  arch/powerpc/platforms/86xx/Makefile          |    1 +
>  arch/powerpc/platforms/86xx/mpc86xx_suspend.c |   92 +++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/platforms/86xx/mpc86xx_suspend.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2cde4e3..c45c71e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -192,7 +192,7 @@ config ARCH_HIBERNATION_POSSIBLE
>  
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
> -	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200
> +	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_86xx
>  
>  config PPC_DCR_NATIVE
>  	bool
> diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
> index 1b9b4a9..a8557df 100644
> --- a/arch/powerpc/platforms/86xx/Makefile
> +++ b/arch/powerpc/platforms/86xx/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
> +obj-$(CONFIG_SUSPEND)		+= mpc86xx_suspend.o
>  obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
>  obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
>  obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_suspend.c b/arch/powerpc/platforms/86xx/mpc86xx_suspend.c
> new file mode 100644
> index 0000000..ce13e4c
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_suspend.c
> @@ -0,0 +1,92 @@
> +/*
> + * MPC86xx suspend (standby) support
> + *
> + * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Author: Jason Jin <jason.jin@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/suspend.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <asm/prom.h>
> +#include <asm/reg.h>
> +#include <asm/mpc6xx.h>
> +
> +#define PMCSR_DEVSLEEP	0x00020000
> +
> +struct mpc86xx_pmc {
> +	__be32 devdisr;
> +	__be32 devdisr2;
> +	__be32 reserve1;
> +	__be32 reserve2;
> +	__be32 powmgtcsr;
> +};
> +
> +static struct mpc86xx_pmc __iomem *pmc_regs_86xx;
> +
> +static int mpc86xx_suspend_enter(suspend_state_t state)
> +{
> +	u32 tmp;
> +
> +	/* Disable power management. */
> +	tmp = mfmsr();
> +	mtmsr(tmp & ~MSR_POW);
> +
> +	/* Enable sleep mode, disable others. */
> +	tmp = mfspr(SPRN_HID0);
> +	mtspr(SPRN_HID0, (tmp & ~(HID0_DOZE | HID0_NAP)) | HID0_SLEEP);
> +	asm("sync");
> +
> +	/* Device power down. */
> +	setbits32(&pmc_regs_86xx->powmgtcsr, PMCSR_DEVSLEEP);
> +
> +	/* 86xx did not support deep sleep, let it enter standby mode. */
> +	mpc6xx_enter_standby();
> +
> +	clrbits32(&pmc_regs_86xx->powmgtcsr, PMCSR_DEVSLEEP);
> +
> +	return 0;
> +}
> +
> +static int mpc86xx_suspend_valid(suspend_state_t state)
> +{
> +	if (state == PM_SUSPEND_STANDBY)
> +		return 1;
> +	return 0;
> +}
> +
> +static struct platform_suspend_ops mpc86xx_suspend_ops = {
> +	.valid = mpc86xx_suspend_valid,
> +	.enter = mpc86xx_suspend_enter,
> +};
> +
> +static int __init mpc86xx_pmc_init(void)
> +{
> +	void __iomem *guts;
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
> +	if (!np) {
> +		np = of_find_compatible_node(NULL, NULL, "fsl,mpc8641-guts");
> +		if (!np)
> +			return -ENODEV;
> +	}
> +
> +	guts = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!guts)
> +		return -ENOMEM;
> +
> +	pmc_regs_86xx = guts + 0x70;
> +
> +	suspend_set_ops(&mpc86xx_suspend_ops);
> +	return 0;
> +}
> +module_init(mpc86xx_pmc_init);
> -- 
> 1.5.5.1

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
