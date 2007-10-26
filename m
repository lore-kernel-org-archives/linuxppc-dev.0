Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFD4ADDECB
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 02:42:26 +1000 (EST)
Date: Fri, 26 Oct 2007 20:39:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] PowerPC: Add 44x NDFC device-tree aware support
Message-ID: <20071026163958.GA11784@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071026163058.GA11354@ru.mvista.com>
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds device-tree aware PowerPC 44x NDFC (NAND Flash Controller) driver.
The code is based on the original ndfc.c driver by Thomas Gleixner.
The major difference is that here we try to handle all chips found as one mtd
device instead of having a separate one on each chip.
The partition handling code is based on the physmap_of one.
The the first 4 bits of the "bank-mask" property show which of the 4 NDFC
banks have chips attached. The "bank-width" property is 1 for 8-bit flash
and 2 for a 16-bit one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/mtd/nand/Kconfig   |    7 
 drivers/mtd/nand/Makefile  |    1 
 drivers/mtd/nand/ndfc_of.c |  449 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/ndfc.h   |    4 
 4 files changed, 461 insertions(+)

diff -pruN linux-2.6.orig/drivers/mtd/nand/Kconfig linux-2.6/drivers/mtd/nand/Kconfig
--- linux-2.6.orig/drivers/mtd/nand/Kconfig	2007-10-25 19:20:05.000000000 +0400
+++ linux-2.6/drivers/mtd/nand/Kconfig	2007-10-26 16:16:20.000000000 +0400
@@ -158,6 +158,13 @@ config MTD_NAND_NDFC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
 
+config MTD_NAND_NDFC_OF
+	tristate "NDFC OF Nand Flash Controller"
+	depends on 44x
+	select MTD_NAND_ECC_SMC
+	help
+	 NDFC OF Nand Flash Controllers are integrated in PowerPC44x SoCs
+
 config MTD_NAND_S3C2410_CLKSTOP
 	bool "S3C2410 NAND IDLE clock stop"
 	depends on MTD_NAND_S3C2410
diff -pruN linux-2.6.orig/drivers/mtd/nand/Makefile linux-2.6/drivers/mtd/nand/Makefile
--- linux-2.6.orig/drivers/mtd/nand/Makefile	2007-10-25 19:20:05.000000000 +0400
+++ linux-2.6/drivers/mtd/nand/Makefile	2007-10-26 16:16:20.000000000 +0400
@@ -24,6 +24,7 @@ obj-$(CONFIG_MTD_NAND_TS7250)		+= ts7250
 obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
 obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
+obj-$(CONFIG_MTD_NAND_NDFC_OF)		+= ndfc_of.o
 obj-$(CONFIG_MTD_NAND_AT91)		+= at91_nand.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)	+= excite_nandflash.o
diff -pruN linux-2.6.orig/drivers/mtd/nand/ndfc_of.c linux-2.6/drivers/mtd/nand/ndfc_of.c
--- linux-2.6.orig/drivers/mtd/nand/ndfc_of.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/mtd/nand/ndfc_of.c	2007-10-26 17:28:57.000000000 +0400
@@ -0,0 +1,449 @@
+/*
+ *  PowerPC 44x NDFC (NanD Flash Controller) driver
+ *  with OF device tree support.
+ *
+ *  Based on the original ndfc driver by Thomas Gleixner
+ *
+ *  Copyright 2006 IBM
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ */
+#include <linux/module.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/ndfc.h>
+#include <linux/mtd/mtd.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/io.h>
+
+
+struct of_ndfc {
+	__iomem void		*base;
+	struct resource		*res;
+	unsigned		bank_width;
+	unsigned 		chip_cnt;
+	unsigned char		chip_map[NDFC_MAX_BANKS];
+	struct nand_hw_control	control;
+	struct nand_chip	chip;
+	struct mtd_info		mtd;
+#ifdef CONFIG_MTD_PARTITIONS
+	struct mtd_partition	*parts;
+#endif
+};
+
+static inline u32 ndfc_raw_readl(struct of_ndfc *ndfc, u32 off)
+{
+	return __raw_readl(ndfc->base + off);
+}
+
+static inline void ndfc_raw_writel(struct of_ndfc *ndfc, u32 off, u32 val)
+{
+	__raw_writel(val, ndfc->base + off);
+}
+
+static inline void ndfc_writel(struct of_ndfc *ndfc, u32 off, u32 val)
+{
+	writel(val, ndfc->base + off);
+}
+
+static void ndfc_select_chip(struct mtd_info *mtd, int chip)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+	uint32_t ccr;
+
+	ccr = ndfc_raw_readl(ndfc, NDFC_CCR);
+	if ((chip >= 0) && (chip < ndfc->chip_cnt))  {
+		ccr &= ~NDFC_CCR_BS_MASK;
+		ccr |= NDFC_CCR_BS(ndfc->chip_map[chip]);
+	} else
+		ccr |= NDFC_CCR_RESET_CE;
+	ndfc_raw_writel(ndfc, NDFC_CCR, ccr);
+}
+
+static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	if (ctrl & NAND_CLE)
+		ndfc_writel(ndfc, NDFC_CMD, cmd & 0xff);
+	else
+		ndfc_writel(ndfc, NDFC_ALE, cmd & 0xff);
+}
+
+static int ndfc_ready(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+
+	return ndfc_raw_readl(ndfc, NDFC_STAT) & NDFC_STAT_IS_READY;
+}
+
+static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	uint32_t ccr;
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+
+	ccr = ndfc_raw_readl(ndfc, NDFC_CCR);
+	ccr |= NDFC_CCR_RESET_ECC;
+	ndfc_raw_writel(ndfc, NDFC_CCR, ccr);
+	wmb();
+}
+
+
+static int ndfc_calculate_ecc(struct mtd_info *mtd,
+			      const u_char *dat, u_char *ecc_code)
+{
+	uint32_t ecc;
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+	uint8_t *p = (uint8_t *)&ecc;
+
+	wmb();
+	ecc = ndfc_raw_readl(ndfc, NDFC_ECC);
+	ecc_code[0] = p[1];
+	ecc_code[1] = p[2];
+	ecc_code[2] = p[3];
+
+	return 0;
+}
+
+
+/*
+ * Speedups for buffer read/write/verify
+ *
+ * NDFC allows 32bit read/write of data. So we can speed up the buffer
+ * functions. No further checking, as nand_base will always read/write
+ * page aligned.
+ */
+static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+	uint32_t *p = (uint32_t *) buf;
+
+	for(;len > 0; len -= 4)
+		*p++ = ndfc_raw_readl(ndfc, NDFC_DATA);
+}
+
+static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+	uint32_t *p = (uint32_t *) buf;
+
+	for(;len > 0; len -= 4)
+		ndfc_raw_writel(ndfc, NDFC_DATA, *p++);
+}
+
+static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc *ndfc = this->priv;
+	uint32_t *p = (uint32_t *) buf;
+
+	for(;len > 0; len -= 4)
+		if (*p++ != ndfc_raw_readl(ndfc, NDFC_DATA))
+			return -EFAULT;
+	return 0;
+}
+
+
+
+static void ndfc_chip_init(struct nand_chip *chip, 
+				struct of_ndfc *ndfc)
+{
+	chip->IO_ADDR_R = ndfc->base + NDFC_DATA;
+	chip->IO_ADDR_W = ndfc->base + NDFC_DATA;
+	chip->cmd_ctrl = ndfc_hwcontrol;
+	chip->dev_ready = ndfc_ready;
+	chip->select_chip = ndfc_select_chip;
+	chip->chip_delay = 50;
+	chip->priv = ndfc;
+	if (ndfc->bank_width == 2)
+		chip->options |= NAND_BUSWIDTH_16;
+	chip->controller = &ndfc->control;
+	chip->read_buf = ndfc_read_buf;
+	chip->write_buf = ndfc_write_buf;
+	chip->verify_buf = ndfc_verify_buf;
+	chip->ecc.correct = nand_correct_data;
+	chip->ecc.hwctl = ndfc_enable_hwecc;
+	chip->ecc.calculate = ndfc_calculate_ecc;
+	chip->ecc.mode = NAND_ECC_HW;
+	chip->ecc.size = 256;
+	chip->ecc.bytes = 3;
+	ndfc->mtd.priv = chip;
+	ndfc->mtd.owner = THIS_MODULE;
+}
+
+
+#ifdef CONFIG_MTD_PARTITIONS
+#define OF_FLASH_PARTS(ndfc)	((ndfc)->parts)
+
+static int __devinit parse_partitions(struct of_ndfc *ndfc,
+				      struct of_device *dev)
+{
+	const char *partname;
+	static const char *part_probe_types[]
+		= { "cmdlinepart", "RedBoot", NULL };
+	struct device_node *dp = dev->node, *pp;
+	int nr_parts, i;
+
+	/* First look for RedBoot table or partitions on the command
+	 * line, these take precedence over device tree information */
+	nr_parts = parse_mtd_partitions(&ndfc->mtd, part_probe_types,
+					&ndfc->parts, 0);
+	if (nr_parts > 0) {
+		add_mtd_partitions(&ndfc->mtd, ndfc->parts, nr_parts);
+		return 0;
+	}
+
+	/* First count the subnodes */
+	nr_parts = 0;
+	for (pp = dp->child; pp; pp = pp->sibling)
+		nr_parts++;
+
+	if (nr_parts == 0)
+		return 0;
+
+	ndfc->parts = kzalloc(nr_parts * sizeof(*ndfc->parts),
+			      GFP_KERNEL);
+	if (!ndfc->parts)
+		return -ENOMEM;
+
+	for (pp = dp->child, i = 0; pp; pp = pp->sibling, i++) {
+		const u32 *reg;
+		int len;
+
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg || (len != 2*sizeof(u32))) {
+			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
+				dp->full_name);
+			kfree(ndfc->parts);
+			ndfc->parts = NULL;
+			return -EINVAL;
+		}
+		ndfc->parts[i].offset = reg[0];
+		ndfc->parts[i].size = reg[1];
+
+		partname = of_get_property(pp, "label", &len);
+		if (!partname)
+			partname = of_get_property(pp, "name", &len);
+		ndfc->parts[i].name = (char *)partname;
+
+		if (of_get_property(pp, "read-only", &len))
+			ndfc->parts[i].mask_flags = MTD_WRITEABLE;
+	}
+
+	return nr_parts;
+}
+#else /* MTD_PARTITIONS */
+#define	OF_FLASH_PARTS(ndfc)		(0)
+#define parse_partitions(ndfc, dev)	(0)
+#endif /* MTD_PARTITIONS */
+
+
+static int of_ndfc_remove(struct of_device *dev)
+{
+	struct of_ndfc *ndfc;
+
+	ndfc = dev_get_drvdata(&dev->dev);
+	if (!ndfc)
+		return 0;
+
+	if (OF_FLASH_PARTS(ndfc)) {
+		del_mtd_partitions(&ndfc->mtd);
+		kfree(OF_FLASH_PARTS(ndfc));
+	} else {
+		del_mtd_device(&ndfc->mtd);
+	}
+	nand_release(&ndfc->mtd);
+
+	dev_set_drvdata(&dev->dev, NULL);
+
+	if (ndfc->base)
+		iounmap(ndfc->base);
+
+	if (ndfc->res) {
+		release_resource(ndfc->res);
+		kfree(ndfc->res);
+	}
+
+	kfree(ndfc);
+
+	return 0;
+}
+
+
+static int __devinit ndfc_map_banks(struct of_ndfc *ndfc, const u32 *mask)
+{
+	unsigned cnt, i, tmp;
+	uint32_t bcr;
+
+	if (!ndfc || !mask)
+		return -EINVAL;
+
+	/* Disable all banks */
+	for (cnt = 0; cnt < NDFC_MAX_BANKS; cnt++) {
+		ndfc_raw_writel(ndfc, NDFC_BCFG0 + (cnt << 2), 0);
+	}
+
+	/* Enable bank and set default RE/WE/CE timings */
+	bcr = NDFC_BxCFG_EN | NDFC_BxCFG_RR(2) | NDFC_BxCFG_RWH(2) |
+				NDFC_BxCFG_RWP(2) | NDFC_BxCFG_CRW(2);
+	if (ndfc->bank_width == 2)
+		bcr |= NDFC_BxCFG_SZ_16BIT;
+
+	cnt = 0;
+	tmp = *mask;
+	while ((i = ffs(tmp)) && (cnt < NDFC_MAX_BANKS)) {
+		i--;
+		tmp &= ~(1 << i);
+		ndfc->chip_map[cnt++] = i;
+		ndfc_raw_writel(ndfc, NDFC_BCFG0 + (i << 2), bcr);
+	}
+	ndfc->chip_cnt = cnt;
+	return cnt;
+}
+
+
+static int __devinit of_ndfc_probe(struct of_device *dev,
+				    const struct of_device_id *match)
+{
+	struct device_node *dp = dev->node;
+	struct resource res;
+	struct of_ndfc *ndfc;
+	const u32 *prop;
+	resource_size_t rlen;
+	int err;
+
+	err = -ENXIO;
+	if (of_address_to_resource(dp, 0, &res)) {
+		dev_err(&dev->dev, "can't get IO address from device tree\n");
+		goto err_out;
+	}
+
+       	dev_dbg(&dev->dev, "regs: %.8llx-%.8llx\n",
+		(unsigned long long)res.start, (unsigned long long)res.end);
+
+	ndfc = kzalloc(sizeof(struct of_ndfc), GFP_KERNEL);
+	if (!ndfc) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	rlen = res.end - res.start + 1;
+	ndfc->res = request_mem_region(res.start, rlen, dev->dev.bus_id);
+	if (!ndfc->res) {
+		err = -EBUSY;
+		goto err_free_out;
+	}
+
+	ndfc->base = ioremap(res.start, rlen);
+	if (!ndfc->base) {
+		err = -ENXIO;
+		goto err_rel_out;
+	}
+
+	spin_lock_init(&ndfc->control.lock);
+	init_waitqueue_head(&ndfc->control.wq);
+
+	prop = of_get_property(dp, "bank-width", NULL);
+	ndfc->bank_width = ((prop) && (*prop) == 2) ? 2 : 1;
+
+	prop = of_get_property(dp, "bank-mask", NULL);
+	err = ndfc_map_banks(ndfc, prop);
+	if (err <= 0) {
+		dev_err(&dev->dev, "no banks found\n");
+		err = -ENODEV;
+		goto err_unmap_out;
+	}
+
+	ndfc_chip_init(&ndfc->chip, ndfc);
+	dev_set_drvdata(&dev->dev, ndfc);
+
+	dev_info(&dev->dev, "NDFC driver initialized. Chip-Rev: 0x%08x\n",
+			ndfc_raw_readl(ndfc, NDFC_REVID));
+
+	err = nand_scan_ident(&ndfc->mtd, ndfc->chip_cnt);
+	if (err)
+		goto err_dat_out;
+
+	if ((ndfc->mtd.writesize != 2048) && (ndfc->mtd.writesize != 512)) {
+		dev_err(&dev->dev, "unexpected NAND flash writesize %d",
+			ndfc->mtd.writesize);
+		goto err_dat_out;
+	}
+
+	err = nand_scan_tail(&ndfc->mtd);
+	if (err)
+		goto err_dat_out;
+
+	err = parse_partitions(ndfc, dev);
+	if (err < 0)
+		goto err_dat_out;
+
+	if (err > 0)
+		add_mtd_partitions(&ndfc->mtd, OF_FLASH_PARTS(ndfc), err);
+	else
+		add_mtd_device(&ndfc->mtd);
+
+	return 0;
+
+err_dat_out:
+	dev_set_drvdata(&dev->dev, NULL);
+err_unmap_out:
+	iounmap(ndfc->base);
+err_rel_out:
+	release_resource(ndfc->res);
+	kfree(ndfc->res);
+err_free_out:
+	kfree(ndfc);
+err_out:
+	return err;
+}
+
+static struct of_device_id of_ndfc_match[] = {
+	{
+		.compatible	= "ibm,ndfc",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_ndfc_match);
+
+static struct of_platform_driver of_ndfc_driver = {
+	.name		= "of-ndfc",
+	.match_table	= of_ndfc_match,
+	.probe		= of_ndfc_probe,
+	.remove		= of_ndfc_remove,
+};
+
+static int __init of_ndfc_init(void)
+{
+	return of_register_platform_driver(&of_ndfc_driver);
+}
+
+static void __exit of_ndfc_exit(void)
+{
+	of_unregister_platform_driver(&of_ndfc_driver);
+}
+
+module_init(of_ndfc_init);
+module_exit(of_ndfc_exit);
+
+MODULE_LICENSE("GPL");
+
+
+MODULE_DESCRIPTION("OF driver for NDFC");
diff -pruN linux-2.6.orig/include/linux/mtd/ndfc.h linux-2.6/include/linux/mtd/ndfc.h
--- linux-2.6.orig/include/linux/mtd/ndfc.h	2007-10-25 19:20:42.000000000 +0400
+++ linux-2.6/include/linux/mtd/ndfc.h	2007-10-26 16:19:42.000000000 +0400
@@ -52,6 +52,10 @@
 #define NDFC_BxCFG_SZ_MASK	0x08000000 /* Bank Size */
 #define NDFC_BxCFG_SZ_8BIT	0x00000000 /* 8bit */
 #define NDFC_BxCFG_SZ_16BIT	0x08000000 /* 16bit */
+#define NDFC_BxCFG_RR(x)	(((x) & 0x7) << 0)
+#define NDFC_BxCFG_RWH(x)	(((x) & 0x7) << 4)
+#define NDFC_BxCFG_RWP(x)	(((x) & 0x7) << 8)
+#define NDFC_BxCFG_CRW(x)	(((x) & 0x7) << 12)
 
 #define NDFC_MAX_BANKS		4
 
