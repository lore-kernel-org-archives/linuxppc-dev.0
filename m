Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CF605B70F9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 20:44:51 +1100 (EST)
Message-ID: <4CBC1775.6000706@windriver.com>
Date: Mon, 18 Oct 2010 17:46:29 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common
	to	elbc	devices
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>	<4CBC0B95.9010300@windriver.com>	<3850A844E6A3854C827AC5C0BEC7B60A2B0708@zch01exm23.fsl.freescale.net>
	<4CBC16FD.6030507@windriver.com>
In-Reply-To: <4CBC16FD.6030507@windriver.com>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Zang Roy-R61911 <r61911@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tiejun.chen wrote:
> Zang Roy-R61911 wrote:
>>> -----Original Message-----
>>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>>> Sent: Monday, October 18, 2010 16:56 PM
>>> To: Zang Roy-R61911
>>> Cc: linux-mtd@lists.infradead.org; Wood Scott-B07421; dedekind1@gmail.com; Lan
>>> Chunhe-B25806; linuxppc-dev@ozlabs.org; akpm@linux-foundation.org;
>>> dwmw2@infradead.org; Gala Kumar-B11780
>>> Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common to
>>> elbc devices
>>>
>>> Roy Zang wrote:
>>>> Move Freescale elbc interrupt from nand dirver to elbc driver.
>>>> Then all elbc devices can use the interrupt instead of ONLY nand.
>>>>
>>>> For former nand driver, it had the two functions:
>>>>
>>>> 1. detecting nand flash partitions;
>>>> 2. registering elbc interrupt.
>>>>
>>>> Now, second function is removed to fsl_lbc.c.
>>>>
>>>> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
>>>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>>>> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
>>>> Cc: Wood Scott-B07421 <B07421@freescale.com>
>>>> ---
>>>>
>>>> These two patches are based on the following commits:
>>>> 1.	http://lists.infradead.org/pipermail/linux-mtd/2010-
>>> September/032112.html
>>>> 2.	http://lists.infradead.org/pipermail/linux-mtd/2010-
>>> September/032110.html
>>>> 3.	http://lists.infradead.org/pipermail/linux-mtd/2010-
>>> September/032111.html
>>>> According to Anton's comment, I merge 1 & 2 together and start a new thread.
>>>> Comparing the provided link:
>>>> 1.	Merge 1 & 2 together.
>>>> 2.	Some code style updates
>>>> 3.	Add counter protect for elbc driver remove
>>>> 4.	Rebase to 2.6.36-rc7
>>>>
>>>> Other histories from the links:
>>>> V2: Comparing with v1, according to the feedback, add some decorations.
>>>>
>>>> V3: Comparing with v2:
>>>> 1.	according to the feedback, add some decorations.
>>>> 2.	change of_platform_driver to platform_driver
>>>> 3.	rebase to 2.6.36-rc4
>>>>
>>>> V4: Comparing with v3
>>>> 1.	minor fix from type unsigned int to u32
>>>> 2.	fix platform_driver issue.
>>>> 3.	add mutex for nand probe
>>>>
>>>>  arch/powerpc/Kconfig               |    7 +-
>>>>  arch/powerpc/include/asm/fsl_lbc.h |   33 +++-
>>>>  arch/powerpc/sysdev/fsl_lbc.c      |  229 ++++++++++++++---
>>>>  drivers/mtd/nand/Kconfig           |    1 +
>>>>  drivers/mtd/nand/fsl_elbc_nand.c   |  482 +++++++++++++++------------------
>>> ---
>>>>  5 files changed, 425 insertions(+), 327 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>>> index 631e5a0..44df1ba 100644
>>>> --- a/arch/powerpc/Kconfig
>>>> +++ b/arch/powerpc/Kconfig
>>>> @@ -687,9 +687,12 @@ config 4xx_SOC
>>>>  	bool
>>>>
>>>>  config FSL_LBC
>>>> -	bool
>>>> +	bool "Freescale Local Bus support"
>>>> +	depends on FSL_SOC
>>>>  	help
>>>> -	  Freescale Localbus support
>>>> +	  Enables reporting of errors from the Freescale local bus
>>>> +	  controller.  Also contains some common code used by
>>>> +	  drivers for specific local bus peripherals.
>>>>
>>>>  config FSL_GTM
>>>>  	bool
>>>> diff --git a/arch/powerpc/include/asm/fsl_lbc.h
>>> b/arch/powerpc/include/asm/fsl_lbc.h
>>>> index 1b5a210..0c40c05 100644
>>>> --- a/arch/powerpc/include/asm/fsl_lbc.h
>>>> +++ b/arch/powerpc/include/asm/fsl_lbc.h
>>>> @@ -1,9 +1,10 @@
>>>>  /* Freescale Local Bus Controller
>>>>   *
>>>> - * Copyright (c) 2006-2007 Freescale Semiconductor
>>>> + * Copyright (c) 2006-2007, 2010 Freescale Semiconductor
>>>>   *
>>>>   * Authors: Nick Spence <nick.spence@freescale.com>,
>>>>   *          Scott Wood <scottwood@freescale.com>
>>>> + *          Jack Lan <jack.lan@freescale.com>
>>>>   *
>>>>   * This program is free software; you can redistribute it and/or modify
>>>>   * it under the terms of the GNU General Public License as published by
>>>> @@ -26,6 +27,8 @@
>>>>  #include <linux/compiler.h>
>>>>  #include <linux/types.h>
>>>>  #include <linux/io.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/spinlock.h>
>>>>
>>>>  struct fsl_lbc_bank {
>>>>  	__be32 br;             /**< Base Register  */
>>>> @@ -125,13 +128,23 @@ struct fsl_lbc_regs {
>>>>  #define LTESR_ATMW 0x00800000
>>>>  #define LTESR_ATMR 0x00400000
>>>>  #define LTESR_CS   0x00080000
>>>> +#define LTESR_UPM  0x00000002
>>>>  #define LTESR_CC   0x00000001
>>>>  #define LTESR_NAND_MASK (LTESR_FCT | LTESR_PAR | LTESR_CC)
>>>> +#define LTESR_MASK      (LTESR_BM | LTESR_FCT | LTESR_PAR | LTESR_WP \
>>>> +			 | LTESR_ATMW | LTESR_ATMR | LTESR_CS | LTESR_UPM \
>>>> +			 | LTESR_CC)
>>>> +#define LTESR_CLEAR	0xFFFFFFFF
>>>> +#define LTECCR_CLEAR	0xFFFFFFFF
>>>> +#define LTESR_STATUS	LTESR_MASK
>>>> +#define LTEIR_ENABLE	LTESR_MASK
>>>> +#define LTEDR_ENABLE	0x00000000
>>>>  	__be32 ltedr;           /**< Transfer Error Disable Register */
>>>>  	__be32 lteir;           /**< Transfer Error Interrupt Register */
>>>>  	__be32 lteatr;          /**< Transfer Error Attributes Register */
>>>>  	__be32 ltear;           /**< Transfer Error Address Register */
>>>> -	u8 res6[0xC];
>>>> +	__be32 lteccr;          /**< Transfer Error ECC Register */
>>>> +	u8 res6[0x8];
>>>>  	__be32 lbcr;            /**< Configuration Register */
>>>>  #define LBCR_LDIS  0x80000000
>>>>  #define LBCR_LDIS_SHIFT    31
>>>> @@ -265,7 +278,23 @@ static inline void fsl_upm_end_pattern(struct fsl_upm
>>> *upm)
>>>>  		cpu_relax();
>>>>  }
>>>>
>>>> +/* overview of the fsl lbc controller */
>>>> +
>>>> +struct fsl_lbc_ctrl {
>>>> +	/* device info */
>>>> +	struct device			*dev;
>>>> +	struct fsl_lbc_regs __iomem	*regs;
>>>> +	int				irq;
>>>> +	wait_queue_head_t		irq_wait;
>>>> +	spinlock_t			lock;
>>>> +	void				*nand;
>>>> +
>>>> +	/* status read from LTESR by irq handler */
>>>> +	unsigned int			irq_status;
>>>> +};
>>>> +
>>>>  extern int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base,
>>>>  			       u32 mar);
>>>> +extern struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
>>>>
>>>>  #endif /* __ASM_FSL_LBC_H */
>>>> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
>>>> index dceb8d1..4bb0336 100644
>>>> --- a/arch/powerpc/sysdev/fsl_lbc.c
>>>> +++ b/arch/powerpc/sysdev/fsl_lbc.c
>>>> @@ -2,8 +2,11 @@
>>>>   * Freescale LBC and UPM routines.
>>>>   *
>>>>   * Copyright (c) 2007-2008  MontaVista Software, Inc.
>>>> + * Copyright (c) 2010 Freescale Semiconductor
>>>>   *
>>>>   * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
>>>> + * Author: Jack Lan <Jack.Lan@freescale.com>
>>>> + * Author: Roy Zang <tie-fei.zang@freescale.com>
>>>>   *
>>>>   * This program is free software; you can redistribute it and/or modify
>>>>   * it under the terms of the GNU General Public License as published by
>>>> @@ -19,39 +22,16 @@
>>>>  #include <linux/types.h>
>>>>  #include <linux/io.h>
>>>>  #include <linux/of.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/mod_devicetable.h>
>>>>  #include <asm/prom.h>
>>>>  #include <asm/fsl_lbc.h>
>>>>
>>>>  static spinlock_t fsl_lbc_lock = __SPIN_LOCK_UNLOCKED(fsl_lbc_lock);
>>>> -static struct fsl_lbc_regs __iomem *fsl_lbc_regs;
>>>> -
>>>> -static char __initdata *compat_lbc[] = {
>>>> -	"fsl,pq2-localbus",
>>>> -	"fsl,pq2pro-localbus",
>>>> -	"fsl,pq3-localbus",
>>>> -	"fsl,elbc",
>>>> -};
>>>> -
>>>> -static int __init fsl_lbc_init(void)
>>>> -{
>>>> -	struct device_node *lbus;
>>>> -	int i;
>>>> -
>>>> -	for (i = 0; i < ARRAY_SIZE(compat_lbc); i++) {
>>>> -		lbus = of_find_compatible_node(NULL, NULL, compat_lbc[i]);
>>>> -		if (lbus)
>>>> -			goto found;
>>>> -	}
>>>> -	return -ENODEV;
>>>> -
>>>> -found:
>>>> -	fsl_lbc_regs = of_iomap(lbus, 0);
>>>> -	of_node_put(lbus);
>>>> -	if (!fsl_lbc_regs)
>>>> -		return -ENOMEM;
>>>> -	return 0;
>>>> -}
>>>> -arch_initcall(fsl_lbc_init);
>>>> +struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
>>>> +EXPORT_SYMBOL(fsl_lbc_ctrl_dev);
>>>>
>>>>  /**
>>>>   * fsl_lbc_find - find Localbus bank
>>>> @@ -65,13 +45,15 @@ arch_initcall(fsl_lbc_init);
>>>>  int fsl_lbc_find(phys_addr_t addr_base)
>>>>  {
>>>>  	int i;
>>>> +	struct fsl_lbc_regs __iomem *lbc;
>>>>
>>>> -	if (!fsl_lbc_regs)
>>>> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
>>>>  		return -ENODEV;
>>>>
>>>> -	for (i = 0; i < ARRAY_SIZE(fsl_lbc_regs->bank); i++) {
>>>> -		__be32 br = in_be32(&fsl_lbc_regs->bank[i].br);
>>>> -		__be32 or = in_be32(&fsl_lbc_regs->bank[i].or);
>>>> +	lbc = fsl_lbc_ctrl_dev->regs;
>>>> +	for (i = 0; i < ARRAY_SIZE(lbc->bank); i++) {
>>>> +		__be32 br = in_be32(&lbc->bank[i].br);
>>>> +		__be32 or = in_be32(&lbc->bank[i].or);
>>>>
>>>>  		if (br & BR_V && (br & or & BR_BA) == addr_base)
>>>>  			return i;
>>>> @@ -94,22 +76,27 @@ int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm
>>> *upm)
>>>>  {
>>>>  	int bank;
>>>>  	__be32 br;
>>>> +	struct fsl_lbc_regs __iomem *lbc;
>>>>
>>>>  	bank = fsl_lbc_find(addr_base);
>>>>  	if (bank < 0)
>>>>  		return bank;
>>>>
>>>> -	br = in_be32(&fsl_lbc_regs->bank[bank].br);
>>>> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
>>>> +		return -ENODEV;
>>>> +
>>>> +	lbc = fsl_lbc_ctrl_dev->regs;
>>>> +	br = in_be32(&lbc->bank[bank].br);
>>>>
>>>>  	switch (br & BR_MSEL) {
>>>>  	case BR_MS_UPMA:
>>>> -		upm->mxmr = &fsl_lbc_regs->mamr;
>>>> +		upm->mxmr = &lbc->mamr;
>>>>  		break;
>>>>  	case BR_MS_UPMB:
>>>> -		upm->mxmr = &fsl_lbc_regs->mbmr;
>>>> +		upm->mxmr = &lbc->mbmr;
>>>>  		break;
>>>>  	case BR_MS_UPMC:
>>>> -		upm->mxmr = &fsl_lbc_regs->mcmr;
>>>> +		upm->mxmr = &lbc->mcmr;
>>>>  		break;
>>>>  	default:
>>>>  		return -EINVAL;
>>>> @@ -148,9 +135,12 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void
>>> __iomem *io_base, u32 mar)
>>>>  	int ret = 0;
>>>>  	unsigned long flags;
>>>>
>>>> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
>>>> +		return -ENODEV;
>>>> +
>>>>  	spin_lock_irqsave(&fsl_lbc_lock, flags);
>>>>
>>>> -	out_be32(&fsl_lbc_regs->mar, mar);
>>>> +	out_be32(&fsl_lbc_ctrl_dev->regs->mar, mar);
>>>>
>>>>  	switch (upm->width) {
>>>>  	case 8:
>>>> @@ -172,3 +162,166 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void
>>> __iomem *io_base, u32 mar)
>>>>  	return ret;
>>>>  }
>>>>  EXPORT_SYMBOL(fsl_upm_run_pattern);
>>>> +
>>>> +static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl)
>>>> +{
>>>> +	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
>>>> +
>>>> +	/* clear event registers */
>>>> +	setbits32(&lbc->ltesr, LTESR_CLEAR);
>>>> +	out_be32(&lbc->lteatr, 0);
>>>> +	out_be32(&lbc->ltear, 0);
>>>> +	out_be32(&lbc->lteccr, LTECCR_CLEAR);
>>>> +	out_be32(&lbc->ltedr, LTEDR_ENABLE);
>>>> +
>>>> +	/* Enable interrupts for any detected events */
>>>> +	out_be32(&lbc->lteir, LTEIR_ENABLE);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * NOTE: This interrupt is used to report localbus events of various kinds,
>>>> + * such as transaction errors on the chipselects.
>>>> + */
>>>> +
>>>> +static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
>>>> +{
>>>> +	struct fsl_lbc_ctrl *ctrl = data;
>>>> +	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
>>>> +	u32 status;
>>>> +
>>>> +	status = in_be32(&lbc->ltesr);
>>>> +	if (!status)
>>>> +		return IRQ_NONE;
>>>> +
>>>> +	out_be32(&lbc->ltesr, LTESR_CLEAR);
>>>> +	out_be32(&lbc->lteatr, 0);
>>>> +	out_be32(&lbc->ltear, 0);
>>>> +	ctrl->irq_status = status;
>>>> +
>>>> +	if (status & LTESR_BM)
>>>> +		dev_err(ctrl->dev, "Local bus monitor time-out: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +	if (status & LTESR_WP)
>>>> +		dev_err(ctrl->dev, "Write protect error: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +	if (status & LTESR_ATMW)
>>>> +		dev_err(ctrl->dev, "Atomic write error: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +	if (status & LTESR_ATMR)
>>>> +		dev_err(ctrl->dev, "Atomic read error: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +	if (status & LTESR_CS)
>>>> +		dev_err(ctrl->dev, "Chip select error: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +	if (status & LTESR_UPM)
>>>> +		;
>>>> +	if (status & LTESR_FCT) {
>>>> +		dev_err(ctrl->dev, "FCM command time-out: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +		smp_wmb();
>>>> +		wake_up(&ctrl->irq_wait);
>>>> +	}
>>>> +	if (status & LTESR_PAR) {
>>>> +		dev_err(ctrl->dev, "Parity or Uncorrectable ECC error: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +		smp_wmb();
>>>> +		wake_up(&ctrl->irq_wait);
>>>> +	}
>>>> +	if (status & LTESR_CC) {
>>>> +		smp_wmb();
>>>> +		wake_up(&ctrl->irq_wait);
>>>> +	}
>>>> +	if (status & ~LTESR_MASK)
>>>> +		dev_err(ctrl->dev, "Unknown error: "
>>>> +			"LTESR 0x%08X\n", status);
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +/*
>>>> + * fsl_lbc_ctrl_probe
>>>> + *
>>>> + * called by device layer when it finds a device matching
>>>> + * one our driver can handled. This code allocates all of
>>>> + * the resources needed for the controller only.  The
>>>> + * resources for the NAND banks themselves are allocated
>>>> + * in the chip probe function.
>>>> +*/
>>>> +
>>>> +static int __devinit fsl_lbc_ctrl_probe(struct platform_device *dev)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (!dev->dev.of_node) {
>>>> +		dev_err(&dev->dev, "Device OF-Node is NULL");
>>>> +		return -EFAULT;
>>>> +	}
>>>> +
>>>> +	fsl_lbc_ctrl_dev = kzalloc(sizeof(*fsl_lbc_ctrl_dev), GFP_KERNEL);
>>>> +	if (!fsl_lbc_ctrl_dev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dev_set_drvdata(&dev->dev, fsl_lbc_ctrl_dev);
>>>> +
>>>> +	spin_lock_init(&fsl_lbc_ctrl_dev->lock);
>>>> +	init_waitqueue_head(&fsl_lbc_ctrl_dev->irq_wait);
>>>> +
>>>> +	fsl_lbc_ctrl_dev->regs = of_iomap(dev->dev.of_node, 0);
>>>> +	if (!fsl_lbc_ctrl_dev->regs) {
>>>> +		dev_err(&dev->dev, "failed to get memory region\n");
>>>> +		ret = -ENODEV;
>>>> +		goto err;
>>> Looks you always iounmap(fsl_lbc_ctrl_dev->regs) on position 'err' but here
>>> of_iomap() is already failed you should skip iounmap() fsl_lbc_ctrl_dev->regs
>>> again. So you should improve that as the following on 'err', or layout 'err'
>>> in
>>> gain.
>>> ------
>>> 	if(fsl_lbc_ctrl_dev->regs)
>>> 		iounmap(fsl_lbc_ctrl_dev->regs);
>>>
>>> Tiejun
>> You are right!
>> How about
>>  
>>         if (!fsl_lbc_ctrl_dev->regs) {
>>                 dev_err(&dev->dev, "failed to get memory region\n");
>>                 kfree(fsl_lbc_ctrl_dev);
>>                 return -ENOMEM;
>>         }
> 
> Although this is a big problem, I prefer to return 'ENXIO' :)
		^
		Typo: is not a ......

Tiejun

> 
> Others are fine to me.
> 
> Tiejun
> 
>> ...
>>
>> Thanks.
>> Roy
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
