Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 9A5FEDE00C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:53:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Date: Thu, 14 Aug 2008 11:53:07 +0200
References: <20080801233000.3574434f@lappy.seanm.ca>
	<20080804132459.3fc12f59@lappy.seanm.ca>
	<20080813173629.32ec73ee@lappy.seanm.ca>
In-Reply-To: <20080813173629.32ec73ee@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808141153.07983.arnd@arndb.de>
Cc: dwmw2@infradead.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 August 2008, Sean MacLennan wrote:
> Port of the ndfc driver to an of platform driver.

Look good overall, thanks for following up on this.

> +struct ndfc_ctrl {
> +	struct device *dev;
> +	void __iomem *ndfcbase;
> +	struct mtd_info mtd;
> +	struct nand_chip chip;
> +	int chip_select;
> +	struct nand_hw_control ndfc_control;
>  };

conceptually, I would lint to the ofdev, not the dev, even if you
don't need the extra information.

>  static void ndfc_select_chip(struct mtd_info *mtd, int chip)
>  {
>  	uint32_t ccr;
> -	struct ndfc_controller *ndfc = &ndfc_ctrl;
> -	struct nand_chip *nandchip = mtd->priv;
> -	struct ndfc_nand_mtd *nandmtd = nandchip->priv;
> -	struct platform_nand_chip *pchip = nandmtd->pl_chip;
> +	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
>  
>  	ccr = __raw_readl(ndfc->ndfcbase + NDFC_CCR);

This already exists, but I noticed it now: device drivers should
not user __raw_readl/__raw_writel for accessing ioremapped storage.
Instead, you should use ioread32_be or in_be32.

> @@ -83,7 +79,7 @@ static int ndfc_ready(struct mtd_info *mtd)
>  static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
>  {
>  	uint32_t ccr;
> -	struct ndfc_controller *ndfc = &ndfc_ctrl;
> +	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
>  
>  	ccr = __raw_readl(ndfc->ndfcbase + NDFC_CCR);
>  	ccr |= NDFC_CCR_RESET_ECC;

You have lots of these changes, which do not appear necessary -- if you
just keep the struct ndfc_controller name, your patch will be a lot
smaller.

> -static int ndfc_nand_probe(struct platform_device *pdev)
> -{
> -	struct platform_nand_ctrl *nc = pdev->dev.platform_data;
> -	struct ndfc_controller_settings *settings = nc->priv;
> -	struct resource *res = pdev->resource;
> -	struct ndfc_controller *ndfc = &ndfc_ctrl;
> -	unsigned long long phys = settings->ndfc_erpn | res->start;
> +	spin_lock_init(&ndfc->ndfc_control.lock);
> +	init_waitqueue_head(&ndfc->ndfc_control.wq);
> +	ndfc->dev = &ofdev->dev;
> +	dev_set_drvdata(&ofdev->dev, ndfc);
> +
> +	/* Read the reg property to get the chip select */
> +	reg = of_get_property(ofdev->node, "reg", &len);
> +	if (reg == NULL || len != 12) {
> +		dev_err(&ofdev->dev, "unable read reg property (%d)\n", len);
> +		return -ENOENT;
> +	}
> +	ndfc->chip_select = *reg;
>  
> -	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
> +	ndfc->ndfcbase = ioremap(reg[1], reg[2]);

This could be better expressed as of_iomap().

> -	platform_set_drvdata(pdev, ndfc);
> +	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
>  
> -	printk("NDFC NAND Driver initialized. Chip-Rev: 0x%08x\n",
> -	       __raw_readl(ndfc->ndfcbase + NDFC_REVID));
> +	/* Set the bank settings */
> +	reg = of_get_property(ofdev->node, "bank_settings", NULL);
> +	bank_settings = reg ? *reg : 0x80002222;

Your device tree does have a bank_setting, so why not assume that
all others will have it as well? I would remove the default.

	Arnd <><
