Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0144.outbound.protection.outlook.com [65.55.169.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC9691A040C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 10:01:12 +1100 (AEDT)
Message-ID: <1446505257.22185.43.camel@freescale.com>
Subject: Re: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
From: Scott Wood <scottwood@freescale.com>
To: Dogra Raghav-B46184 <raghav@freescale.com>
CC: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 2 Nov 2015 17:00:57 -0600
In-Reply-To: <BY2PR0301MB0775A3A01F8585352ED5EFADD22C0@BY2PR0301MB0775.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
 <BY2PR0301MB0775A3A01F8585352ED5EFADD22C0@BY2PR0301MB0775.namprd03.prod.outlook.com>
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

On Mon, 2015-11-02 at 00:12 -0600, Dogra Raghav-B46184 wrote:
> -----Original Message-----
> From: Raghav Dogra [mailto:raghav@freescale.com] 
> Sent: Friday, October 30, 2015 11:55 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Wood Scott-B07421 <scottwood@freescale.com>; Kushwaha Prabhakar-B32579 <
> prabhakar@freescale.com>; Dogra Raghav-B46184 <raghav@freescale.com>
> Subject: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
> 
> Modify platform driver suspend/resume to syscore suspend/resume. This is 
> because p1022ds needs to use localbus when entering the PCIE resume.
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
> @@ -18,9 +18,9 @@ obj-$(CONFIG_PPC_PMI)               += pmi.o
>  obj-$(CONFIG_U3_DART)                += dart_iommu.o
>  obj-$(CONFIG_MMIO_NVRAM)     += mmio_nvram.o
>  obj-$(CONFIG_FSL_SOC)                += fsl_soc.o fsl_mpic_err.o
> +obj-$(CONFIG_FSL_LBC)                += fsl_lbc.o
>  obj-$(CONFIG_FSL_PCI)                += fsl_pci.o $(fsl-msi-obj-y)
>  obj-$(CONFIG_FSL_PMC)                += fsl_pmc.o
> -obj-$(CONFIG_FSL_LBC)                += fsl_lbc.o
>  obj-$(CONFIG_FSL_GTM)                += fsl_gtm.o
>  obj-$(CONFIG_FSL_85XX_CACHE_SRAM)    += fsl_85xx_l2ctlr.o 
> fsl_85xx_cache_sram.o
>  obj-$(CONFIG_SIMPLE_GPIO)    += simple_gpio.o
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
> -     struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
> -     struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +     struct fsl_lbc_ctrl *ctrl;
> +     struct fsl_lbc_regs __iomem *lbc;
> +
> +     ctrl = fsl_lbc_ctrl_dev;
> +     if (!ctrl)
> +             goto out;
> +
> +     lbc = ctrl->regs;
> +     if (!lbc)
> +             goto out;
>  
>       ctrl->saved_regs = kmalloc(sizeof(struct fsl_lbc_regs), GFP_KERNEL);
>       if (!ctrl->saved_regs)
>               return -ENOMEM;
> [Dogra Raghav-B46184] This is the existing upstream code. Are you 
> suggesting to modify the upstream code to take care of individual registers?

What specifically do you mean by "the upstream code"?  What other tree are we 
talking about here?

-Scott
