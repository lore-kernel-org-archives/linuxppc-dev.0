Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B80152C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 11:00:39 +1100 (EST)
Message-ID: <1394582427.13761.74.camel@snotra.buserror.net>
Subject: Re: [PATCH 6/9] powerpc/85xx: support sleep feature on QorIQ SoCs
 with RCPM
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Tue, 11 Mar 2014 19:00:27 -0500
In-Reply-To: <1394168285-32275-6-git-send-email-chenhui.zhao@freescale.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-6-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> In sleep mode, the clocks of e500 cores and unused IP blocks is
> turned off. The IP blocks which are allowed to wake up the processor
> are still running.
> 
> The sleep mode is equal to the Standby state in Linux. Use the
> command to enter sleep mode:
>   echo standby > /sys/power/state
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/Kconfig                   |    4 +-
>  arch/powerpc/platforms/85xx/Makefile   |    3 +
>  arch/powerpc/platforms/85xx/qoriq_pm.c |   78 ++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 05f6323..e1d6510 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -222,7 +222,7 @@ config ARCH_HIBERNATION_POSSIBLE
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
>  	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
> -		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
> +		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
>  		   || 44x || 40x
>  
>  config PPC_DCR_NATIVE
> @@ -709,7 +709,7 @@ config FSL_PCI
>  config FSL_PMC
>  	bool
>  	default y
> -	depends on SUSPEND && (PPC_85xx || PPC_86xx)
> +	depends on SUSPEND && (PPC_85xx && !PPC_E500MC || PPC_86xx)

Don't mix && and || without parentheses.

Maybe convert this into being selected (similar to FSL_RCPM), rather
than default y?

> diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
> index 25cebe7..7fae817 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -2,6 +2,9 @@
>  # Makefile for the PowerPC 85xx linux kernel.
>  #
>  obj-$(CONFIG_SMP) += smp.o
> +ifeq ($(CONFIG_FSL_CORENET_RCPM), y)
> +obj-$(CONFIG_SUSPEND)	+= qoriq_pm.o
> +endif

There should probably be a kconfig symbol for this.

> diff --git a/arch/powerpc/platforms/85xx/qoriq_pm.c b/arch/powerpc/platforms/85xx/qoriq_pm.c
> new file mode 100644
> index 0000000..915b13b
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/qoriq_pm.c
> @@ -0,0 +1,78 @@
> +/*
> + * Support Power Management feature
> + *
> + * Copyright 2014 Freescale Semiconductor Inc.
> + *
> + * Author: Chenhui Zhao <chenhui.zhao@freescale.com>
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +#include <linux/of_platform.h>
> +
> +#include <sysdev/fsl_soc.h>
> +
> +#define FSL_SLEEP		0x1
> +#define FSL_DEEP_SLEEP		0x2

FSL_DEEP_SLEEP is unused.

> +
> +/* specify the sleep state of the present platform */
> +int sleep_pm_state;
> +/* supported sleep modes by the present platform */
> +static unsigned int sleep_modes;

Why is one signed and the other unsigned?

> +
> +static int qoriq_suspend_enter(suspend_state_t state)
> +{
> +	int ret = 0;
> +
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +
> +		if (cur_cpu_spec->cpu_flush_caches)
> +			cur_cpu_spec->cpu_flush_caches();
> +
> +		ret = qoriq_pm_ops->plat_enter_state(sleep_pm_state);
> +
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +
> +	}
> +
> +	return ret;
> +}
> +
> +static int qoriq_suspend_valid(suspend_state_t state)
> +{
> +	if (state == PM_SUSPEND_STANDBY && (sleep_modes & FSL_SLEEP))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static const struct platform_suspend_ops qoriq_suspend_ops = {
> +	.valid = qoriq_suspend_valid,
> +	.enter = qoriq_suspend_enter,
> +};
> +
> +static int __init qoriq_suspend_init(void)
> +{
> +	struct device_node *np;
> +
> +	sleep_modes = FSL_SLEEP;
> +	sleep_pm_state = PLAT_PM_SLEEP;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-2.0");
> +	if (np)
> +		sleep_pm_state = PLAT_PM_LPM20;
> +
> +	suspend_set_ops(&qoriq_suspend_ops);
> +
> +	return 0;
> +}
> +arch_initcall(qoriq_suspend_init);

Why is this not a platform driver?  If fsl_pmc can do it...

-Scott
