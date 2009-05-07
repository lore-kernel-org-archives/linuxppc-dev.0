Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 9E741DDDA1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 18:07:54 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
Date: Thu, 7 May 2009 10:08:12 +0200
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-7-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-7-git-send-email-wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905071008.13039.david.jander@protonic.nl>
Cc: linux-mtd@lists.infradead.org, Wolfgang Denk <wd@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 May 2009 22:15:13 Wolfgang Denk wrote:
> --- /dev/null
> +++ b/drivers/mtd/nand/mpc5121_nfc.c
>[...]
> +/* Init external chip select logic on ADS5121 board */
> +static int ads5121_chipselect_init(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct mpc5121_nfc_prv *prv = chip->priv;
> +	struct device_node *dn;
> +
> +	dn = of_find_compatible_node(NULL, NULL, "fsl,mpc5121ads-cpld");
> +	if (dn) {
> +		prv->csreg = of_iomap(dn, 0);
> +		of_node_put(dn);
> +		if (!prv->csreg)
> +			return -ENOMEM;
> +
> +		/* CPLD Register 9 controls NAND /CE Lines */
> +		prv->csreg += 9;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/* Control chips select signal on ADS5121 board */
> +static void ads5121_select_chip(struct mtd_info *mtd, int chip)
> +{
> +	struct nand_chip *nand = mtd->priv;
> +	struct mpc5121_nfc_prv *prv = nand->priv;
> +	u8 v;
> +
> +	v = in_8(prv->csreg);
> +	v |= 0x0F;
> +
> +	if (chip >= 0) {
> +		mpc5121_nfc_select_chip(mtd, 0);
> +		v &= ~(1 << chip);
> +	} else
> +		mpc5121_nfc_select_chip(mtd, -1);
> +
> +	out_8(prv->csreg, v);
> +}

I am just a humble beginner, but isn't this platform dependend code supposed 
to be in /arch/powerpc/platforms/.... ?

>[...]
> +static int __init mpc5121_nfc_probe(struct of_device *op,
> +					const struct of_device_id *match)
> +{
> +	struct device_node *rootnode, *dn = op->node;
> +	struct device *dev = &op->dev;
> +	struct mpc5121_nfc_prv *prv;
> +	struct resource res;
> +	struct mtd_info *mtd;
> +#ifdef CONFIG_MTD_PARTITIONS
> +	struct mtd_partition *parts;
> +#endif
> +	struct nand_chip *chip;
> +	unsigned long regs_paddr, regs_size;
> +	const uint *chips_no;
> +	int resettime = 0;
> +	int retval = 0;
> +	int rev, len;
> +
> +	/*
> +	 * Check SoC revision. This driver supports only NFC
> +	 * in MPC5121 revision 2.
> +	 */
> +	rev = (mfspr(SPRN_SVR) >> 4) & 0xF;
> +	if (rev != 2) {
> +		printk(KERN_ERR DRV_NAME
> +				": SoC revision %u is not supported!\n", rev);
> +		return -ENXIO;
> +	}
> +
> +	prv = devm_kzalloc(dev, sizeof(*prv), GFP_KERNEL);
> +	if (!prv) {
> +		printk(KERN_ERR DRV_NAME ": Memory exhausted!\n");
> +		return -ENOMEM;
> +	}
> +
> +	mtd = &prv->mtd;
> +	chip = &prv->chip;
> +
> +	mtd->priv = chip;
> +	chip->priv = prv;
> +
> +	/* Read NFC configuration from Reset Config Word */
> +	retval = mpc5121_nfc_read_hw_config(mtd);
> +	if (retval) {
> +		printk(KERN_ERR DRV_NAME ": Unable to read NFC config!\n");
> +		return retval;
> +	}
> +
> +	prv->irq = irq_of_parse_and_map(dn, 0);
> +	if (prv->irq == NO_IRQ) {
> +		printk(KERN_ERR DRV_NAME ": Error mapping IRQ!\n");
> +		return -EINVAL;
> +	}
> +
> +	retval = of_address_to_resource(dn, 0, &res);
> +	if (retval) {
> +		printk(KERN_ERR DRV_NAME ": Error parsing memory region!\n");
> +		return retval;
> +	}
> +
> +	chips_no = of_get_property(dn, "chips", &len);
> +	if (!chips_no || len != sizeof(*chips_no)) {
> +		printk(KERN_ERR DRV_NAME ": Invalid/missing 'chips' "
> +								"property!\n");
> +		return -EINVAL;
> +	}
> +
> +	regs_paddr = res.start;
> +	regs_size = res.end - res.start + 1;
> +
> +	if (!devm_request_mem_region(dev, regs_paddr, regs_size, DRV_NAME)) {
> +		printk(KERN_ERR DRV_NAME ": Error requesting memory region!\n");
> +		return -EBUSY;
> +	}
> +
> +	prv->regs = devm_ioremap(dev, regs_paddr, regs_size);
> +	if (!prv->regs) {
> +		printk(KERN_ERR DRV_NAME ": Error mapping memory region!\n");
> +		return -ENOMEM;
> +	}
> +
> +	mtd->name = "MPC5121 NAND";
> +	chip->dev_ready = mpc5121_nfc_dev_ready;
> +	chip->cmdfunc = mpc5121_nfc_command;
> +	chip->read_byte = mpc5121_nfc_read_byte;
> +	chip->read_word = mpc5121_nfc_read_word;
> +	chip->read_buf = mpc5121_nfc_read_buf;
> +	chip->write_buf = mpc5121_nfc_write_buf;
> +	chip->verify_buf = mpc5121_nfc_verify_buf;
> +	chip->select_chip = mpc5121_nfc_select_chip;
> +	chip->options = NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT;
> +	chip->ecc.mode = NAND_ECC_SOFT;
> +
> +	/* Support external chip-select logic on ADS5121 board */
> +	rootnode = of_find_node_by_path("/");
> +	if (of_device_is_compatible(rootnode, "fsl,mpc5121ads")) {
> +		retval = ads5121_chipselect_init(mtd);
> +		if (retval) {
> +			printk(KERN_ERR DRV_NAME ": Chipselect init error!\n");
> +			of_node_put(rootnode);
> +			return retval;
> +		}
> +
> +		chip->select_chip = ads5121_select_chip;
> +	}

Hmmm, I guess it would be overkill to build some sort of generic framework for 
providing special chip-select functions here.... but it just doesn't look 
clean like this.... oh well.

Best regards,

-- 
David Jander
Protonic Holland.
