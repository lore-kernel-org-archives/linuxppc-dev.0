Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6441F1A0907
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 08:11:14 +1100 (AEDT)
Message-ID: <1450905053.18314.108.camel@freescale.com>
Subject: Re: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
From: Scott Wood <scottwood@freescale.com>
To: Raghav Dogra <raghav@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
CC: <prabhakar@freescale.com>
Date: Wed, 23 Dec 2015 15:10:53 -0600
In-Reply-To: <1446186299-2921-1-git-send-email-raghav@freescale.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-30 at 11:54 +0530, Raghav Dogra wrote:
> Modify platform driver suspend/resume to syscore
> suspend/resume. This is because p1022ds needs to use
> localbus when entering the PCIE resume.
> 
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> ---
>  arch/powerpc/sysdev/Makefile  |  2 +-
>  arch/powerpc/sysdev/fsl_lbc.c | 51 +++++++++++++++++++++++++++++++++-------
> ---
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index f7cb2a1..4c19e614 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -18,9 +18,9 @@ obj-$(CONFIG_PPC_PMI)		+= pmi.o
>  obj-$(CONFIG_U3_DART)		+= dart_iommu.o
>  obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
>  obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o fsl_mpic_err.o
> +obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
>  obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
>  obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
> -obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
>  obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
>  obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o
> fsl_85xx_cache_sram.o
>  obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
> index d631022..332d700 100644
> --- a/arch/powerpc/sysdev/fsl_lbc.c
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -27,6 +27,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/syscore_ops.h>
>  #include <asm/prom.h>
>  #include <asm/fsl_lbc.h>
>  
> @@ -354,24 +355,42 @@ err:
>  #ifdef CONFIG_SUSPEND
>  
>  /* save lbc registers */
> -static int fsl_lbc_suspend(struct platform_device *pdev, pm_message_t
> state)
> +static int fsl_lbc_syscore_suspend(void)
>  {
> -	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
> -	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +	struct fsl_lbc_ctrl *ctrl;
> +	struct fsl_lbc_regs __iomem *lbc;
> +
> +	ctrl = fsl_lbc_ctrl_dev;
> +	if (!ctrl)
> +		goto out;
> +
> +	lbc = ctrl->regs;
> +	if (!lbc)
> +		goto out;
>  
>  	ctrl->saved_regs = kmalloc(sizeof(struct fsl_lbc_regs),
> GFP_KERNEL);
>  	if (!ctrl->saved_regs)
>  		return -ENOMEM;
>  
>  	_memcpy_fromio(ctrl->saved_regs, lbc, sizeof(struct fsl_lbc_regs));
> +
> +out:
>  	return 0;
>  }
>  
>  /* restore lbc registers */
> -static int fsl_lbc_resume(struct platform_device *pdev)
> +static int fsl_lbc_syscore_resume(void)
>  {
> -	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
> -	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +	struct fsl_lbc_ctrl *ctrl;
> +	struct fsl_lbc_regs __iomem *lbc;
> +
> +	ctrl = fsl_lbc_ctrl_dev;
> +	if (!ctrl)
> +		goto out;
> +
> +	lbc = ctrl->regs;
> +	if (!lbc)
> +		goto out;
>  
>  	if (ctrl->saved_regs) {
>  		_memcpy_toio(lbc, ctrl->saved_regs,
> @@ -379,7 +398,9 @@ static int fsl_lbc_resume(struct platform_device *pdev)
>  		kfree(ctrl->saved_regs);
>  		ctrl->saved_regs = NULL;
>  	}
> -	return 0;
> +
> +out:
> +	return;
>  }
>  #endif /* CONFIG_SUSPEND */
>  
> @@ -391,20 +412,26 @@ static const struct of_device_id fsl_lbc_match[] = {
>  	{},
>  };
>  
> +#ifdef CONFIG_SUSPEND
> +static struct syscore_ops lbc_syscore_pm_ops = {
> +	.suspend = fsl_lbc_syscore_suspend,
> +	.resume = fsl_lbc_syscore_resume,
> +};
> +#endif
> +
>  static struct platform_driver fsl_lbc_ctrl_driver = {
>  	.driver = {
>  		.name = "fsl-lbc",
>  		.of_match_table = fsl_lbc_match,
>  	},
>  	.probe = fsl_lbc_ctrl_probe,
> -#ifdef CONFIG_SUSPEND
> -	.suspend     = fsl_lbc_suspend,
> -	.resume      = fsl_lbc_resume,
> -#endif
>  };
>  
>  static int __init fsl_lbc_init(void)
>  {
> +#ifdef CONFIG_SUSPEND
> +	register_syscore_ops(&lbc_syscore_pm_ops);
> +#endif
>  	return platform_driver_register(&fsl_lbc_ctrl_driver);
>  }
> -module_init(fsl_lbc_init);
> +arch_initcall(fsl_lbc_init);

This was changed to subsys_initcall as of v4.2...  What tree did you use to
generate this patch?  I'll fix the conflict this time, but please always base
patches against the latest code -- and test them in that context.

-Scott
