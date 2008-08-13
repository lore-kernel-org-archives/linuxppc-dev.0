Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5042BDDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 07:36:29 +1000 (EST)
Date: Wed, 13 Aug 2008 17:36:29 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <linuxppc-dev@ozlabs.org>, dwmw2@infradead.org
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Message-ID: <20080813173629.32ec73ee@lappy.seanm.ca>
In-Reply-To: <20080804132459.3fc12f59@lappy.seanm.ca>
References: <20080801233000.3574434f@lappy.seanm.ca>
	<200808041825.02314.arnd@arndb.de>
	<20080804132459.3fc12f59@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Port of the ndfc driver to an of platform driver.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index efb1ab6..55aec25 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -5,9 +5,13 @@
  *   Platform independend driver for NDFC (NanD Flash Controller)
  *   integrated into EP440 cores
  *
+ *   Ported to an OF platform driver by Sean MacLennan
+ *
  *  Author: Thomas Gleixner
  *
  *  Copyright 2006 IBM
+ *  Copyright 2008 PIKA Technologies
+ *    Sean MacLennan <smaclennan@pikatech.com>
  *
  *  This program is free software; you can redistribute	 it and/or modify it
  *  under  the terms of	 the GNU General  Public License as published by the
@@ -23,38 +27,30 @@
 #include <linux/mtd/mtd.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/platform_device.h>
-
+#include <linux/of_platform.h>
 #include <asm/io.h>
 
-struct ndfc_nand_mtd {
-	struct mtd_info			mtd;
-	struct nand_chip		chip;
-	struct platform_nand_chip	*pl_chip;
-};
-
-static struct ndfc_nand_mtd ndfc_mtd[NDFC_MAX_BANKS];
 
-struct ndfc_controller {
-	void __iomem		*ndfcbase;
-	struct nand_hw_control	ndfc_control;
-	atomic_t		childs_active;
+struct ndfc_ctrl {
+	struct device *dev;
+	void __iomem *ndfcbase;
+	struct mtd_info mtd;
+	struct nand_chip chip;
+	int chip_select;
+	struct nand_hw_control ndfc_control;
 };
 
-static struct ndfc_controller ndfc_ctrl;
+static struct ndfc_ctrl ndfc_ctrl;
 
 static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 {
 	uint32_t ccr;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	struct nand_chip *nandchip = mtd->priv;
-	struct ndfc_nand_mtd *nandmtd = nandchip->priv;
-	struct platform_nand_chip *pchip = nandmtd->pl_chip;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 
 	ccr = __raw_readl(ndfc->ndfcbase + NDFC_CCR);
 	if (chip >= 0) {
 		ccr &= ~NDFC_CCR_BS_MASK;
-		ccr |= NDFC_CCR_BS(chip + pchip->chip_offset);
+		ccr |= NDFC_CCR_BS(chip + ndfc->chip_select);
 	} else
 		ccr |= NDFC_CCR_RESET_CE;
 	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
@@ -62,7 +58,7 @@ static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 
 static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 
 	if (cmd == NAND_CMD_NONE)
 		return;
@@ -75,7 +71,7 @@ static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 static int ndfc_ready(struct mtd_info *mtd)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 
 	return __raw_readl(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
 }
@@ -83,7 +79,7 @@ static int ndfc_ready(struct mtd_info *mtd)
 static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
 {
 	uint32_t ccr;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 
 	ccr = __raw_readl(ndfc->ndfcbase + NDFC_CCR);
 	ccr |= NDFC_CCR_RESET_ECC;
@@ -94,7 +90,7 @@ static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
 static int ndfc_calculate_ecc(struct mtd_info *mtd,
 			      const u_char *dat, u_char *ecc_code)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 	uint32_t ecc;
 	uint8_t *p = (uint8_t *)&ecc;
 
@@ -117,7 +113,7 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
  */
 static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -126,7 +122,7 @@ static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 
 static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -135,7 +131,7 @@ static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
 static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
@@ -147,10 +143,18 @@ static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 /*
  * Initialize chip structure
  */
-static void ndfc_chip_init(struct ndfc_nand_mtd *mtd)
+static int ndfc_chip_init(struct ndfc_ctrl *ndfc, struct device_node *node)
 {
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	struct nand_chip *chip = &mtd->chip;
+#ifdef CONFIG_MTD_PARTITIONS
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+	static const char *part_types[] = { "cmdlinepart", NULL };
+#else
+	static const char *part_types[] = { NULL };
+#endif
+	struct mtd_partition *parts;
+#endif
+	struct nand_chip *chip = &ndfc->chip;
+	int ret;
 
 	chip->IO_ADDR_R = ndfc->ndfcbase + NDFC_DATA;
 	chip->IO_ADDR_W = ndfc->ndfcbase + NDFC_DATA;
@@ -158,8 +162,6 @@ static void ndfc_chip_init(struct ndfc_nand_mtd *mtd)
 	chip->dev_ready = ndfc_ready;
 	chip->select_chip = ndfc_select_chip;
 	chip->chip_delay = 50;
-	chip->priv = mtd;
-	chip->options = mtd->pl_chip->options;
 	chip->controller = &ndfc->ndfc_control;
 	chip->read_buf = ndfc_read_buf;
 	chip->write_buf = ndfc_write_buf;
@@ -170,153 +172,125 @@ static void ndfc_chip_init(struct ndfc_nand_mtd *mtd)
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.size = 256;
 	chip->ecc.bytes = 3;
-	chip->ecclayout = chip->ecc.layout = mtd->pl_chip->ecclayout;
-	mtd->mtd.priv = chip;
-	mtd->mtd.owner = THIS_MODULE;
-}
 
-static int ndfc_chip_probe(struct platform_device *pdev)
-{
-	struct platform_nand_chip *nc = pdev->dev.platform_data;
-	struct ndfc_chip_settings *settings = nc->priv;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	struct ndfc_nand_mtd *nandmtd;
-
-	if (nc->chip_offset >= NDFC_MAX_BANKS || nc->nr_chips > NDFC_MAX_BANKS)
-		return -EINVAL;
-
-	/* Set the bank settings */
-	__raw_writel(settings->bank_settings,
-		     ndfc->ndfcbase + NDFC_BCFG0 + (nc->chip_offset << 2));
+	ndfc->mtd.priv = chip;
+	ndfc->mtd.owner = THIS_MODULE;
 
-	nandmtd = &ndfc_mtd[pdev->id];
-	if (nandmtd->pl_chip)
-		return -EBUSY;
-
-	nandmtd->pl_chip = nc;
-	ndfc_chip_init(nandmtd);
+	ret = nand_scan(&ndfc->mtd, 1);
+	if (ret)
+		return ret;
 
-	/* Scan for chips */
-	if (nand_scan(&nandmtd->mtd, nc->nr_chips)) {
-		nandmtd->pl_chip = NULL;
-		return -ENODEV;
-	}
+	ndfc->mtd.name = ndfc->dev->bus_id;
 
 #ifdef CONFIG_MTD_PARTITIONS
-	printk("Number of partitions %d\n", nc->nr_partitions);
-	if (nc->nr_partitions) {
-		/* Add the full device, so complete dumps can be made */
-		add_mtd_device(&nandmtd->mtd);
-		add_mtd_partitions(&nandmtd->mtd, nc->partitions,
-				   nc->nr_partitions);
+	ret = parse_mtd_partitions(&ndfc->mtd, part_types, &parts, 0);
+	if (ret < 0)
+		return ret;
 
-	} else
-#else
-		add_mtd_device(&nandmtd->mtd);
+#ifdef CONFIG_MTD_OF_PARTS
+	if (ret == 0) {
+		ret = of_mtd_parse_partitions(ndfc->dev, &ndfc->mtd,
+					      node, &parts);
+		if (ret < 0)
+			return ret;
+	}
 #endif
 
-	atomic_inc(&ndfc->childs_active);
-	return 0;
+	if (ret > 0)
+		return add_mtd_partitions(&ndfc->mtd, parts, ret);
+#endif
+	return add_mtd_device(&ndfc->mtd);
 }
 
-static int ndfc_chip_remove(struct platform_device *pdev)
+static int __devinit ndfc_probe(struct of_device *ofdev,
+				const struct of_device_id *match)
 {
-	return 0;
-}
+	struct ndfc_ctrl *ndfc = &ndfc_ctrl;
+	const u32 *reg;
+	u32 ccr, bank_settings;
+	int err, len;
 
-static int ndfc_nand_probe(struct platform_device *pdev)
-{
-	struct platform_nand_ctrl *nc = pdev->dev.platform_data;
-	struct ndfc_controller_settings *settings = nc->priv;
-	struct resource *res = pdev->resource;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	unsigned long long phys = settings->ndfc_erpn | res->start;
+	spin_lock_init(&ndfc->ndfc_control.lock);
+	init_waitqueue_head(&ndfc->ndfc_control.wq);
+	ndfc->dev = &ofdev->dev;
+	dev_set_drvdata(&ofdev->dev, ndfc);
+
+	/* Read the reg property to get the chip select */
+	reg = of_get_property(ofdev->node, "reg", &len);
+	if (reg == NULL || len != 12) {
+		dev_err(&ofdev->dev, "unable read reg property (%d)\n", len);
+		return -ENOENT;
+	}
+	ndfc->chip_select = *reg;
 
-	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
+	ndfc->ndfcbase = ioremap(reg[1], reg[2]);
 	if (!ndfc->ndfcbase) {
-		printk(KERN_ERR "NDFC: ioremap failed\n");
+		dev_err(&ofdev->dev, "failed to get memory\n");
 		return -EIO;
 	}
 
-	__raw_writel(settings->ccr_settings, ndfc->ndfcbase + NDFC_CCR);
+	ccr = NDFC_CCR_BS(ndfc->chip_select);
 
-	spin_lock_init(&ndfc->ndfc_control.lock);
-	init_waitqueue_head(&ndfc->ndfc_control.wq);
+	/* It is ok if ccr does not exist - just default to 0 */
+	reg = of_get_property(ofdev->node, "ccr", NULL);
+	if (reg)
+		ccr |= *reg;
 
-	platform_set_drvdata(pdev, ndfc);
+	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
 
-	printk("NDFC NAND Driver initialized. Chip-Rev: 0x%08x\n",
-	       __raw_readl(ndfc->ndfcbase + NDFC_REVID));
+	/* Set the bank settings */
+	reg = of_get_property(ofdev->node, "bank_settings", NULL);
+	bank_settings = reg ? *reg : 0x80002222;
+
+	__raw_writel(bank_settings,
+		     ndfc->ndfcbase + NDFC_BCFG0 + (ndfc->chip_select << 2));
+
+	err = ndfc_chip_init(ndfc, ofdev->node);
+	if (err)
+		goto error_cleanup;
 
 	return 0;
+
+error_cleanup:
+	iounmap(ndfc->ndfcbase);
+	return err;
 }
 
-static int ndfc_nand_remove(struct platform_device *pdev)
+static int __devexit ndfc_remove(struct of_device *ofdev)
 {
-	struct ndfc_controller *ndfc = platform_get_drvdata(pdev);
+	struct ndfc_ctrl *ndfc = dev_get_drvdata(&ofdev->dev);
 
-	if (atomic_read(&ndfc->childs_active))
-		return -EBUSY;
+	nand_release(&ndfc->mtd);
 
-	if (ndfc) {
-		platform_set_drvdata(pdev, NULL);
-		iounmap(ndfc_ctrl.ndfcbase);
-		ndfc_ctrl.ndfcbase = NULL;
-	}
 	return 0;
 }
 
-/* driver device registration */
-
-static struct platform_driver ndfc_chip_driver = {
-	.probe		= ndfc_chip_probe,
-	.remove		= ndfc_chip_remove,
-	.driver		= {
-		.name	= "ndfc-chip",
-		.owner	= THIS_MODULE,
-	},
+static const struct of_device_id ndfc_match[] = {
+	{ .compatible = "amcc,ndfc", },
+	{}
 };
 
-static struct platform_driver ndfc_nand_driver = {
-	.probe		= ndfc_nand_probe,
-	.remove		= ndfc_nand_remove,
-	.driver		= {
-		.name	= "ndfc-nand",
-		.owner	= THIS_MODULE,
+static struct of_platform_driver ndfc_driver = {
+	.driver = {
+		.name	= "ndfc",
 	},
+	.match_table = ndfc_match,
+	.probe = ndfc_probe,
+	.remove = __devexit_p(ndfc_remove),
 };
 
 static int __init ndfc_nand_init(void)
 {
-	int ret;
-
-	spin_lock_init(&ndfc_ctrl.ndfc_control.lock);
-	init_waitqueue_head(&ndfc_ctrl.ndfc_control.wq);
-
-	ret = platform_driver_register(&ndfc_nand_driver);
-	if (ret)
-		return ret;
-
-	ret = platform_driver_register(&ndfc_chip_driver);
-	if (ret) {
-		platform_driver_unregister(&ndfc_nand_driver);
-		return ret;
-	}
-
-	return 0;
+	return of_register_platform_driver(&ndfc_driver);
 }
+module_init(ndfc_nand_init);
 
 static void __exit ndfc_nand_exit(void)
 {
-	platform_driver_unregister(&ndfc_chip_driver);
-	platform_driver_unregister(&ndfc_nand_driver);
+	of_unregister_platform_driver(&ndfc_driver);
 }
-
-module_init(ndfc_nand_init);
 module_exit(ndfc_nand_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Thomas Gleixner <tglx@linutronix.de>");
-MODULE_DESCRIPTION("Platform driver for NDFC");
-MODULE_ALIAS("platform:ndfc-chip");
-MODULE_ALIAS("platform:ndfc-nand");
+MODULE_DESCRIPTION("OF Platform driver for NDFC");
