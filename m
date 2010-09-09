Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id C3C28B70D2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 21:53:44 +1000 (EST)
Received: by eyg24 with SMTP id 24so909167eyg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Sep 2010 04:53:43 -0700 (PDT)
Date: Thu, 9 Sep 2010 15:53:38 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 1/3 v2][MTD] P4080/eLBC: Make Freescale elbc interrupt
	common to elbc devices
Message-ID: <20100909115338.GA12320@oksana.dev.rtsoft.ru>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just a few cosmetic nits for this patch...

On Thu, Sep 09, 2010 at 06:20:30PM +0800, Roy Zang wrote:
[...]
> @@ -94,22 +73,26 @@ int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm)
>  {
>  	int bank;
>  	__be32 br;
> +	struct fsl_lbc_regs __iomem *lbc;
>  
>  	bank = fsl_lbc_find(addr_base);
>  	if (bank < 0)
>  		return bank;
>  
> -	br = in_be32(&fsl_lbc_regs->bank[bank].br);
> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
> +		return -ENODEV;

I'd add an empty line here.

> +	lbc = fsl_lbc_ctrl_dev->regs;
> +	br = in_be32(&lbc->bank[bank].br);
>  
>  	switch (br & BR_MSEL) {
>  	case BR_MS_UPMA:
> -		upm->mxmr = &fsl_lbc_regs->mamr;
> +		upm->mxmr = &lbc->mamr;
>  		break;
>  	case BR_MS_UPMB:
> -		upm->mxmr = &fsl_lbc_regs->mbmr;
> +		upm->mxmr = &lbc->mbmr;
>  		break;
>  	case BR_MS_UPMC:
> -		upm->mxmr = &fsl_lbc_regs->mcmr;
> +		upm->mxmr = &lbc->mcmr;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -143,14 +126,18 @@ EXPORT_SYMBOL(fsl_upm_find);
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
> @@ -172,3 +159,188 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
>  	return ret;
>  }
>  EXPORT_SYMBOL(fsl_upm_run_pattern);
> +
> +static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl)
> +{
> +	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
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
> +static int __devexit fsl_lbc_ctrl_remove(struct platform_device *ofdev)
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
> +
> +	kfree(ctrl);
> +
> +	return 0;
> +}
> +
> +/*
> + * NOTE: This interrupt is used to report localbus events of various kinds,
> + * such as transaction errors on the chipselects.
> + */
> +
> +static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
> +{
> +	struct fsl_lbc_ctrl *ctrl = data;
> +	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +	u32 status;
> +
> +	status = in_be32(&lbc->ltesr);
> +
> +	if (status) {

You could save indentation and improve readability by writing

status = in_be32(&lbc->ltesr);
if (!status)
	return IRQ_NONE;

...the rest of the function...

I understand that you just move the code around though.

> +		out_be32(&lbc->ltesr, LTESR_CLEAR);
> +		out_be32(&lbc->lteatr, 0);
> +		out_be32(&lbc->ltear, 0);
> +		ctrl->irq_status = status;
> +
> +		if (status & LTESR_BM)
> +			dev_err(ctrl->dev, "Local bus monitor time-out: "
> +				"LTESR 0x%08X\n", status);
> +		if (status & LTESR_WP)
> +			dev_err(ctrl->dev, "Write protect error: "
> +				"LTESR 0x%08X\n", status);
> +		if (status & LTESR_ATMW)
> +			dev_err(ctrl->dev, "Atomic write error: "
> +				"LTESR 0x%08X\n", status);
> +		if (status & LTESR_ATMR)
> +			dev_err(ctrl->dev, "Atomic read error: "
> +				"LTESR 0x%08X\n", status);
> +		if (status & LTESR_CS)
> +			dev_err(ctrl->dev, "Chip select error: "
> +				"LTESR 0x%08X\n", status);
> +		if (status & LTESR_UPM)
> +			;
> +		if (status & LTESR_FCT) {
> +			dev_err(ctrl->dev, "FCM command time-out: "
> +				"LTESR 0x%08X\n", status);
> +			smp_wmb();
> +			wake_up(&ctrl->irq_wait);
> +		}
> +		if (status & LTESR_PAR) {
> +			dev_err(ctrl->dev, "Parity or Uncorrectable ECC error: "
> +				"LTESR 0x%08X\n", status);
> +			smp_wmb();
> +			wake_up(&ctrl->irq_wait);
> +		}
> +		if (status & LTESR_CC) {
> +			smp_wmb();
> +			wake_up(&ctrl->irq_wait);
> +		}
> +		if (status & ~LTESR_MASK)
> +			dev_err(ctrl->dev, "Unknown error: "
> +				"LTESR 0x%08X\n", status);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +/*
> + * fsl_lbc_ctrl_probe
> + *
> + * called by device layer when it finds a device matching
> + * one our driver can handled. This code allocates all of
> + * the resources needed for the controller only.  The
> + * resources for the NAND banks themselves are allocated
> + * in the chip probe function.
> +*/
> +
> +static int __devinit fsl_lbc_ctrl_probe(struct platform_device *ofdev,
> +					 const struct of_device_id *match)
> +{
> +	int ret;
> +
> +	if (!ofdev->dev.of_node) {
> +		dev_err(&ofdev->dev, "Device OF-Node is NULL");
> +		return -EFAULT;
> +	}
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
> +	fsl_lbc_ctrl_dev->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
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
> +	iounmap(fsl_lbc_ctrl_dev->regs);
> +	kfree(fsl_lbc_ctrl_dev);
> +	return ret;
> +}
> +
> +static const struct of_device_id fsl_lbc_match[] = {
> +	{ .compatible = "fsl,elbc", },
> +	{ .compatible = "fsl,pq3-localbus", },
> +	{ .compatible = "fsl,pq2-localbus", },
> +	{ .compatible = "fsl,pq2pro-localbus", },
> +	{},
> +};

You need linux/mod_devicetable.h for this.

> +
> +static struct of_platform_driver fsl_lbc_ctrl_driver = {

Need linux/of_platform.h for this.

But you actually don't need of_platform_driver, as for the
new code you can use platform_driver (and thus
linux/platform_device.h).

> +	.driver = {
> +		.name = "fsl-lbc",
> +		.of_match_table = fsl_lbc_match,
> +	},
> +	.probe = fsl_lbc_ctrl_probe,
> +};
> +
> +static int __init fsl_lbc_init(void)
> +{
> +	return of_register_platform_driver(&fsl_lbc_ctrl_driver);
> +}
> +

No need for this empty line.

> +module_init(fsl_lbc_init);

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
