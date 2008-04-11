Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B4D1DDFE3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 00:10:02 +1000 (EST)
Message-Id: <EE642BFC-4262-44E8-BD48-E76E5418C276@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311172408.GB7727@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/8] [POWERPC] fsl_lbc: implement few routines to manage
	FSL UPMs
Date: Fri, 11 Apr 2008 09:09:57 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172408.GB7727@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
> These will be used by the FSL UPM NAND driver.

can this be a bit more descriptive.  What exactly are these functions  
trying to accomplish.

>
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/Kconfig          |    5 ++
> arch/powerpc/sysdev/Makefile  |    1 +
> arch/powerpc/sysdev/fsl_lbc.c |   99 ++++++++++++++++++++++++++++++++ 
> +++++++++
> include/asm-powerpc/fsl_lbc.h |   63 ++++++++++++++++++++++++++
> 4 files changed, 168 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_lbc.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index ef12db0..9c68592 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -491,6 +491,11 @@ config FSL_PCI
>  	bool
> 	select PPC_INDIRECT_PCI
>
> +config FSL_LBC
> +	bool
> +	help
> +	  Freescale Localbus support
> +
> # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
> config MCA
> 	bool
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/ 
> Makefile
> index 15f3e85..62b6ef0 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
> obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
> obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
> obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
> +obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
> obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
> obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
> obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/ 
> fsl_lbc.c
> new file mode 100644
> index 0000000..b59f2f4
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -0,0 +1,99 @@
> +/*
> + * Freescale UPM routines.
> + *
> + * Copyright (c) 2007-2008  MontaVista Software, Inc.
> + *
> + * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or  
> modify
> + * it under the terms of the GNU General Public License as  
> published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <asm/fsl_lbc.h>
> +
> +spinlock_t fsl_lbc_lock = __SPIN_LOCK_UNLOCKED(fsl_lbc_lock);
> +
> +struct fsl_lbc_regs __iomem *fsl_lbc_regs;
> +EXPORT_SYMBOL(fsl_lbc_regs);
> +
> +static char __initdata *compat_lbc[] = {
> +	"fsl,pq2-localbus",
> +	"fsl,pq2pro-localbus",
> +	"fsl,pq3-localbus",
> +	"fsl,elbc",
> +};
> +
> +static int __init fsl_lbc_init(void)
> +{
> +	struct device_node *lbus;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(compat_lbc); i++) {
> +		lbus = of_find_compatible_node(NULL, NULL, compat_lbc[i]);
> +		if (lbus)
> +			goto found;
> +	}
> +	return -ENODEV;
> +
> +found:
> +	fsl_lbc_regs = of_iomap(lbus, 0);
> +	of_node_put(lbus);
> +	if (!fsl_lbc_regs)
> +		return -ENOMEM;
> +	return 0;
> +}
> +arch_initcall(fsl_lbc_init);
> +
> +int fsl_upm_find(u32 base, struct fsl_upm *upm)

what is base?

>
> +{
> +	int i;
> +	__be32 br;
> +	__be32 or;
> +
> +	if (!fsl_lbc_regs)
> +		return -ENODEV;
> +
> +	for (i = 0; i < ARRAY_SIZE(fsl_lbc_regs->bank); i++) {
> +		br = in_be32(&fsl_lbc_regs->bank[i].br);
> +		or = in_be32(&fsl_lbc_regs->bank[i].or);
> +
> +		if (br & BR_V && (br & or & BR_BA) == base)
> +			goto found;
> +	}
> +
> +	return -ENOENT;
> +found:
> +	switch (br & BR_MSEL) {
> +	case BR_MS_UPMA:
> +		upm->mxmr = &fsl_lbc_regs->mamr;
> +		break;
> +	case BR_MS_UPMB:
> +		upm->mxmr = &fsl_lbc_regs->mbmr;
> +		break;
> +	case BR_MS_UPMC:
> +		upm->mxmr = &fsl_lbc_regs->mcmr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (br & BR_PS) {
> +	case BR_PS_8:
> +		upm->width = 8;
> +		break;
> +	case BR_PS_16:
> +		upm->width = 16;
> +		break;
> +	case BR_PS_32:
> +		upm->width = 32;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
