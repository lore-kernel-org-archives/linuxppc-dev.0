Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id E0EE1B7178
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 21:28:02 +1000 (EST)
Received: by ewy2 with SMTP id 2so1169954ewy.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Sep 2010 04:28:00 -0700 (PDT)
Date: Fri, 3 Sep 2010 15:27:55 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt
	common to elbc devices
Message-ID: <20100903112755.GA11847@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
Cc: B25806@freescale.com, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mtd@lists.infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 06, 2010 at 10:51:34AM +0800, Roy Zang wrote:
> From: Lan Chunhe-B25806 <b25806@freescale.com>
> 
> Move Freescale elbc interrupt from nand dirver to elbc driver.
> Then all elbc devices can use the interrupt instead of ONLY nand.
> 
> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> send the patch to linux-mtd@lists.infradead.org
> it has been posted to linuxppc-dev@ozlabs.org and do not get any comment.
> 
>  arch/powerpc/Kconfig               |    7 +-
>  arch/powerpc/include/asm/fsl_lbc.h |   34 +++++-
>  arch/powerpc/sysdev/fsl_lbc.c      |  254 ++++++++++++++++++++++++++++++------
>  3 files changed, 253 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2031a28..5155b53 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -703,9 +703,12 @@ config 4xx_SOC
>  	bool
>  
>  config FSL_LBC
> -	bool
> +	bool "Freescale Local Bus support"
> +	depends on FSL_SOC
>  	help
> -	  Freescale Localbus support
> +	  Enables reporting of errors from the Freescale local bus
> +	  controller.  Also contains some common code used by
> +	  drivers for specific local bus peripherals.
>  
>  config FSL_GTM
>  	bool
[...]
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
> index dceb8d1..9c9e44f 100644
> --- a/arch/powerpc/sysdev/fsl_lbc.c
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -5,6 +5,10 @@
>   *
>   * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
>   *
> + * Copyright (c) 2010 Freescale Semiconductor
> + *
> + * Authors: Jack Lan <Jack.Lan@freescale.com>

Would be prettier if you'd group copyright and authorship notices.
I.e.

Copyright 2008 MV
Copyright 2010 FSL

Authors: Anton
         Jack

> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -23,35 +27,8 @@
>  #include <asm/fsl_lbc.h>
>  
>  static spinlock_t fsl_lbc_lock = __SPIN_LOCK_UNLOCKED(fsl_lbc_lock);
> -static struct fsl_lbc_regs __iomem *fsl_lbc_regs;
> -
> -static char __initdata *compat_lbc[] = {
> -	"fsl,pq2-localbus",
> -	"fsl,pq2pro-localbus",
> -	"fsl,pq3-localbus",
> -	"fsl,elbc",
> -};
> -
> -static int __init fsl_lbc_init(void)
> -{
> -	struct device_node *lbus;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(compat_lbc); i++) {
> -		lbus = of_find_compatible_node(NULL, NULL, compat_lbc[i]);
> -		if (lbus)
> -			goto found;
> -	}
> -	return -ENODEV;
> -
> -found:
> -	fsl_lbc_regs = of_iomap(lbus, 0);
> -	of_node_put(lbus);
> -	if (!fsl_lbc_regs)
> -		return -ENOMEM;
> -	return 0;
> -}
> -arch_initcall(fsl_lbc_init);
> +struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
> +EXPORT_SYMBOL(fsl_lbc_ctrl_dev);
>  
>  /**
>   * fsl_lbc_find - find Localbus bank
> @@ -66,12 +43,12 @@ int fsl_lbc_find(phys_addr_t addr_base)
>  {
>  	int i;
>  
> -	if (!fsl_lbc_regs)
> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
>  		return -ENODEV;
>  
> -	for (i = 0; i < ARRAY_SIZE(fsl_lbc_regs->bank); i++) {
> -		__be32 br = in_be32(&fsl_lbc_regs->bank[i].br);
> -		__be32 or = in_be32(&fsl_lbc_regs->bank[i].or);
> +	for (i = 0; i < ARRAY_SIZE(fsl_lbc_ctrl_dev->regs->bank); i++) {
> +		__be32 br = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].br);
> +		__be32 or = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].or);

A dedicated variable for regs would make this much more readable?

>  
>  		if (br & BR_V && (br & or & BR_BA) == addr_base)
>  			return i;
> @@ -99,17 +76,20 @@ int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm)
>  	if (bank < 0)
>  		return bank;
>  
> -	br = in_be32(&fsl_lbc_regs->bank[bank].br);
> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
> +		return -ENODEV;
> +
> +	br = in_be32(&fsl_lbc_ctrl_dev->regs->bank[bank].br);
>  
>  	switch (br & BR_MSEL) {
>  	case BR_MS_UPMA:
> -		upm->mxmr = &fsl_lbc_regs->mamr;
> +		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mamr;

Ditto, a very repetitive stuff, desires a variable for regs?

>  		break;
>  	case BR_MS_UPMB:
> -		upm->mxmr = &fsl_lbc_regs->mbmr;
> +		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mbmr;
>  		break;
>  	case BR_MS_UPMC:
> -		upm->mxmr = &fsl_lbc_regs->mcmr;
> +		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mcmr;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -143,14 +123,18 @@ EXPORT_SYMBOL(fsl_upm_find);
>   * thus UPM pattern actually executed. Note that mar usage depends on the
>   * pre-programmed AMX bits in the UPM RAM.
>   */
> +
>  int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
>  {
>  	int ret = 0;
>  	unsigned long flags;
>  
> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
> +		return -ENODEV;
> +
>  	spin_lock_irqsave(&fsl_lbc_lock, flags);
>  
> -	out_be32(&fsl_lbc_regs->mar, mar);
> +	out_be32(&fsl_lbc_ctrl_dev->regs->mar, mar);
>  
>  	switch (upm->width) {
>  	case 8:
> @@ -172,3 +156,197 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
>  	return ret;
>  }
>  EXPORT_SYMBOL(fsl_upm_run_pattern);
> +
> +static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl)
> +{
> +	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;

Yep, something like this for the functions above.

> +
> +	/* clear event registers */
> +	setbits32(&lbc->ltesr, LTESR_CLEAR);
> +	out_be32(&lbc->lteatr, 0);
> +	out_be32(&lbc->ltear, 0);
> +	out_be32(&lbc->lteccr, LTECCR_CLEAR);
> +	out_be32(&lbc->ltedr, LTEDR_ENABLE);
> +
> +	/* Enable interrupts for any detected events */
> +	out_be32(&lbc->lteir, LTEIR_ENABLE);
> +
> +	return 0;
> +}
> +
> +static int __devexit fsl_lbc_ctrl_remove(struct of_device *ofdev)
> +{
> +	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&ofdev->dev);
> +
> +	if (ctrl->irq)
> +		free_irq(ctrl->irq, ctrl);
> +
> +	if (ctrl->regs)
> +		iounmap(ctrl->regs);
> +
> +	dev_set_drvdata(&ofdev->dev, NULL);
> +	kfree(ctrl);
> +
> +	return 0;
> +}
> +
> +/* NOTE: This interrupt is used to report localbus events of various kinds,
> + * such as transaction errors on the chipselects.
> + */

/*
 * multi line comments
 * should be like this
 */

[...]
> +/* fsl_lbc_ctrl_probe
> + *
> + * called by device layer when it finds a device matching
> + * one our driver can handled. This code allocates all of
> + * the resources needed for the controller only.  The
> + * resources for the NAND banks themselves are allocated
> + * in the chip probe function.
> +*/

ditto.

> +static int __devinit fsl_lbc_ctrl_probe(struct of_device *ofdev,
> +					 const struct of_device_id *match)
> +{
> +	int ret = 0;

no need for the initial value here.

> +
> +	fsl_lbc_ctrl_dev = kzalloc(sizeof(*fsl_lbc_ctrl_dev), GFP_KERNEL);
> +	if (!fsl_lbc_ctrl_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&ofdev->dev, fsl_lbc_ctrl_dev);
> +
> +	spin_lock_init(&fsl_lbc_ctrl_dev->lock);
> +	init_waitqueue_head(&fsl_lbc_ctrl_dev->irq_wait);
> +
> +	fsl_lbc_ctrl_dev->regs = of_iomap(ofdev->dev.of_node, 0);
> +	if (!fsl_lbc_ctrl_dev->regs) {
> +		dev_err(&ofdev->dev, "failed to get memory region\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	fsl_lbc_ctrl_dev->irq = of_irq_to_resource(ofdev->dev.of_node, 0, NULL);
> +	if (fsl_lbc_ctrl_dev->irq == NO_IRQ) {
> +		dev_err(&ofdev->dev, "failed to get irq resource\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	fsl_lbc_ctrl_dev->dev = &ofdev->dev;
> +
> +	ret = fsl_lbc_ctrl_init(fsl_lbc_ctrl_dev);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = request_irq(fsl_lbc_ctrl_dev->irq, fsl_lbc_ctrl_irq, 0,
> +				"fsl-lbc", fsl_lbc_ctrl_dev);
> +	if (ret != 0) {
> +		dev_err(&ofdev->dev, "failed to install irq (%d)\n",
> +			fsl_lbc_ctrl_dev->irq);
> +		ret = fsl_lbc_ctrl_dev->irq;
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:

fsl_lbc_ctrl_dev leaked. Plus, after freeing it, you should
NULLify it as well, as other functions checks it for !NULL.

fsl_lbc_ctrl_dev->regs leaks too.

> +	return ret;
> +}
> +
> +static const struct of_device_id fsl_lbc_match[] = {
> +	{
> +		.compatible = "fsl,elbc",
> +	},
> +	{
> +		.compatible = "fsl,pq3-localbus",
> +	},
> +	{
> +		.compatible = "fsl,pq2-localbus",
> +	},
> +	{
> +		.compatible = "fsl,pq2pro-localbus",
> +	},
> +	{},

Could save 8 lines by writing "{ .compatible = "...", },".

> +};
> +
> +static struct of_platform_driver fsl_lbc_ctrl_driver = {

I think you shouldn't use of_platform for new code. just platform
will work (there's platform_driver.driver.of_match_table nowadays).

> +	.driver = {
> +		.name = "fsl-lbc",
> +		.of_match_table = fsl_lbc_match,
> +	},
> +	.probe = fsl_lbc_ctrl_probe,
> +	.remove = __devexit_p(fsl_lbc_ctrl_remove),

The device is not removable, I think you don't need this.

> +};
> +
> +static int __init fsl_lbc_init(void)
> +{
> +	return of_register_platform_driver(&fsl_lbc_ctrl_driver);
> +}
> +
> +static void __exit fsl_lbc_exit(void)
> +{
> +	of_unregister_platform_driver(&fsl_lbc_ctrl_driver);
> +}
> +
> +module_init(fsl_lbc_init);
> +module_exit(fsl_lbc_exit);

fsl_lbc is not a module, so you don't need _exit().

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("Freescale Enhanced Local Bus Controller driver");

ditto, no need for this.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
