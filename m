Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 35E2AB6F69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 08:37:06 +1100 (EST)
Received: by laam7 with SMTP id m7so1190697laa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 13:36:59 -0800 (PST)
Subject: Re: [PATCH v2] Integrated Flash Controller support
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Tue, 29 Nov 2011 23:36:52 +0200
In-Reply-To: <1320053901-23801-1-git-send-email-b35362@freescale.com>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1322602615.2150.7.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, r58472@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, scottwood@freescale.com,
 akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-10-31 at 17:38 +0800, b35362@freescale.com wrote:
> +/*
> + * fsl_ifc_ctrl_probe
> + *
> + * called by device layer when it finds a device matching
> + * one our driver can handled. This code allocates all of
> + * the resources needed for the controller only.  The
> + * resources for the NAND banks themselves are allocated
> + * in the chip probe function.
> +*/
> +static int __devinit fsl_ifc_ctrl_probe(struct platform_device *dev)
> +{
> +	int ret = 0;
> +
> +

... snip ...

I am concerned about the error path in this function

> +	init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
> +
> +	ret = request_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_irq, IRQF_SHARED,
> +			  "fsl-ifc", fsl_ifc_ctrl_dev);
> +	if (ret != 0) {
> +		dev_err(&dev->dev, "failed to install irq (%d)\n",
> +			fsl_ifc_ctrl_dev->irq);
> +		goto err;
> +	}

irq_dispose_mapping() on error path?

> +
> +	ret = request_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_nand_irq, 0,
> +			  "fsl-ifc-nand", fsl_ifc_ctrl_dev);
> +	if (ret != 0) {
> +		dev_err(&dev->dev, "failed to install irq (%d)\n",
> +			fsl_ifc_ctrl_dev->nand_irq);
> +		goto err;

free_irq() on error path?
> +	}
> +
> +	return 0;
> +
> +err:
> +	return ret;
> +}


> +static __init int fsl_ifc_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&fsl_ifc_ctrl_driver);
> +	if (ret)
> +		printk(KERN_ERR "fsl-ifc: Failed to register platform"
> +				"driver\n");
> +
> +	return ret;
> +}
> +
> +static void __exit fsl_ifc_exit(void)
> +{
> +	platform_driver_unregister(&fsl_ifc_ctrl_driver);
> +}
> +
> +module_init(fsl_ifc_init);
> +module_exit(fsl_ifc_exit);

How about using module_platform_driver() instead?
