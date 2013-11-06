Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F0292C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 06:57:23 +1100 (EST)
Message-ID: <1383767820.4776.124.camel@pasglop>
Subject: Re: [RFC PATCH] ehci-platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Thu, 07 Nov 2013 06:57:00 +1100
In-Reply-To: <1690980.YlPWToa1rW@mexican>
References: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
 <2440701.siW6M1PPWz@mexican> <1383710296.4776.119.camel@pasglop>
 <1690980.YlPWToa1rW@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-06 at 18:39 +1100, Alistair Popple wrote:

> diff --git a/arch/powerpc/boot/dts/sequoia.dts 
> b/arch/powerpc/boot/dts/sequoia.dts
> index b1d3292..e28371e 100644
> --- a/arch/powerpc/boot/dts/sequoia.dts
> +++ b/arch/powerpc/boot/dts/sequoia.dts
> @@ -153,7 +153,7 @@
>  		};
>  
>  		USB0: ehci@e0000300 {
> -			compatible = "ibm,usb-ehci-440epx", "usb-ehci";
> +			compatible = "ibm,usb-ehci-440epx";

Compatible properties are string lists so it *should* be ok to have all
of them in the list. However I do remember Russell mentioning a problem
with the current matching code so adding him on CC for comments.


> +/*
> + * 440EPx Errata USBH_3
> + * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
> + */
> +#define PPC440EPX_EHCI0_INSREG_BMT	(0x1 << 0)
> +static int
> +ppc44x_enable_bmt(struct device_node *dn)
> +{
> +	__iomem u32 *insreg_virt;
> +
> +	insreg_virt = of_iomap(dn, 1);
> +	if (!insreg_virt)
> +		return  -EINVAL;
> +
> +	out_be32(insreg_virt + 3, PPC440EPX_EHCI0_INSREG_BMT);
> +
> +	iounmap(insreg_virt);
> +	return 0;
> +}
> +

I would go even further and add the 44x workarounds to the normal
platform device, with a compatible check in there. That isn't the
first time we add quirks to an existing driver.

> +	/* Initialise platform data from device tree if available. */
> +	if (!dn) {

That was supposed to be if (dn) no ?

> +		if (of_get_property(dn, "big-endian", NULL)) {
> +			pdata->big_endian_mmio = 1;
> +			pdata->big_endian_desc = 1;
> +		}
> +		if (of_get_property(dn, "big-endian-regs", NULL))
> +			pdata->big_endian_mmio = 1;
> +		if (of_get_property(dn, "big-endian-desc", NULL))
> +			pdata->big_endian_desc = 1;
> +	}
> +
>  	irq = platform_get_irq(dev, 0);
>  	if (irq < 0) {
>  		dev_err(&dev->dev, "no irq provided");
> @@ -203,9 +216,10 @@ static int ehci_platform_resume(struct device *dev)
>  #define ehci_platform_resume	NULL
>  #endif /* CONFIG_PM */
>  
> -static const struct of_device_id vt8500_ehci_ids[] = {
> +static const struct of_device_id ehci_platform_ids[] = {
>  	{ .compatible = "via,vt8500-ehci", },
>  	{ .compatible = "wm,prizm-ehci", },
> +	{ .compatible = "usb-ehci", },
>  	{}
>  };

Cheers,
Ben.
