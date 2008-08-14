Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 26582DE015
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 09:10:40 +1000 (EST)
Date: Thu, 14 Aug 2008 19:10:41 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Message-ID: <20080814191041.60ffed5c@lappy.seanm.ca>
In-Reply-To: <20080814165422.62339a5f@lappy.seanm.ca>
References: <20080801233000.3574434f@lappy.seanm.ca>
	<200808141153.07983.arnd@arndb.de>
	<20080814120829.1ad4ed74@lappy.seanm.ca>
	<200808142216.45763.arnd@arndb.de>
	<20080814165422.62339a5f@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Port the ndfc driver to an OF platform driver.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 41f361c..ab0d77e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -165,7 +165,7 @@ config MTD_NAND_S3C2410_HWECC
 
 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
-	depends on 4xx && !PPC_MERGE
+	depends on 4xx
 	select MTD_NAND_ECC_SMC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 955959e..75a3bf0 100644
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
@@ -21,27 +25,17 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/ndfc.h>
 #include <linux/mtd/mtd.h>
-#include <linux/platform_device.h>
-
+#include <linux/of_platform.h>
 #include <asm/io.h>
-#ifdef CONFIG_40x
-#include <asm/ibm405.h>
-#else
-#include <asm/ibm44x.h>
-#endif
-
-struct ndfc_nand_mtd {
-	struct mtd_info			mtd;
-	struct nand_chip		chip;
-	struct platform_nand_chip	*pl_chip;
-};
 
-static struct ndfc_nand_mtd ndfc_mtd[NDFC_MAX_BANKS];
 
 struct ndfc_controller {
-	void __iomem		*ndfcbase;
-	struct nand_hw_control	ndfc_control;
-	atomic_t		childs_active;
+	struct of_device *ofdev;
+	void __iomem *ndfcbase;
+	struct mtd_info mtd;
+	struct nand_chip chip;
+	int chip_select;
+	struct nand_hw_control ndfc_control;
 };
 
 static struct ndfc_controller ndfc_ctrl;
@@ -50,17 +44,14 @@ static void ndfc_select_chip(struct mtd_info *mtd, int chip)
 {
 	uint32_t ccr;
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	struct nand_chip *nandchip = mtd->priv;
-	struct ndfc_nand_mtd *nandmtd = nandchip->priv;
-	struct platform_nand_chip *pchip = nandmtd->pl_chip;
 
-	ccr = __raw_readl(ndfc->ndfcbase + NDFC_CCR);
+	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
 	if (chip >= 0) {
 		ccr &= ~NDFC_CCR_BS_MASK;
-		ccr |= NDFC_CCR_BS(chip + pchip->chip_offset);
+		ccr |= NDFC_CCR_BS(chip + ndfc->chip_select);
 	} else
 		ccr |= NDFC_CCR_RESET_CE;
-	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
+	out_be32(ndfc->ndfcbase + NDFC_CCR, ccr);
 }
 
 static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
@@ -80,7 +71,7 @@ static int ndfc_ready(struct mtd_info *mtd)
 {
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
 
-	return __raw_readl(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
+	return in_be32(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
 }
 
 static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
@@ -88,9 +79,9 @@ static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
 	uint32_t ccr;
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
 
-	ccr = __raw_readl(ndfc->ndfcbase + NDFC_CCR);
+	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
 	ccr |= NDFC_CCR_RESET_ECC;
-	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
+	out_be32(ndfc->ndfcbase + NDFC_CCR, ccr);
 	wmb();
 }
 
@@ -102,9 +93,10 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 	uint8_t *p = (uint8_t *)&ecc;
 
 	wmb();
-	ecc = __raw_readl(ndfc->ndfcbase + NDFC_ECC);
-	ecc_code[0] = p[1];
-	ecc_code[1] = p[2];
+	ecc = in_be32(ndfc->ndfcbase + NDFC_ECC);
+	/* The NDFC uses Smart Media (SMC) bytes order */
+	ecc_code[0] = p[2];
+	ecc_code[1] = p[1];
 	ecc_code[2] = p[3];
 
 	return 0;
@@ -123,7 +115,7 @@ static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
-		*p++ = __raw_readl(ndfc->ndfcbase + NDFC_DATA);
+		*p++ = in_be32(ndfc->ndfcbase + NDFC_DATA);
 }
 
 static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
@@ -132,7 +124,7 @@ static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
-		__raw_writel(*p++, ndfc->ndfcbase + NDFC_DATA);
+		out_be32(ndfc->ndfcbase + NDFC_DATA, *p++);
 }
 
 static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
@@ -141,7 +133,7 @@ static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	uint32_t *p = (uint32_t *) buf;
 
 	for(;len > 0; len -= 4)
-		if (*p++ != __raw_readl(ndfc->ndfcbase + NDFC_DATA))
+		if (*p++ != in_be32(ndfc->ndfcbase + NDFC_DATA))
 			return -EFAULT;
 	return 0;
 }
@@ -149,10 +141,19 @@ static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 /*
  * Initialize chip structure
  */
-static void ndfc_chip_init(struct ndfc_nand_mtd *mtd)
+static int ndfc_chip_init(struct ndfc_controller *ndfc,
+			  struct device_node *node)
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
@@ -160,8 +161,6 @@ static void ndfc_chip_init(struct ndfc_nand_mtd *mtd)
 	chip->dev_ready = ndfc_ready;
 	chip->select_chip = ndfc_select_chip;
 	chip->chip_delay = 50;
-	chip->priv = mtd;
-	chip->options = mtd->pl_chip->options;
 	chip->controller = &ndfc->ndfc_control;
 	chip->read_buf = ndfc_read_buf;
 	chip->write_buf = ndfc_write_buf;
@@ -172,143 +171,120 @@ static void ndfc_chip_init(struct ndfc_nand_mtd *mtd)
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.size = 256;
 	chip->ecc.bytes = 3;
-	chip->ecclayout = chip->ecc.layout = mtd->pl_chip->ecclayout;
-	mtd->mtd.priv = chip;
-	mtd->mtd.owner = THIS_MODULE;
-}
-
-static int ndfc_chip_probe(struct platform_device *pdev)
-{
-	struct platform_nand_chip *nc = pdev->dev.platform_data;
-	struct ndfc_chip_settings *settings = nc->priv;
-	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	struct ndfc_nand_mtd *nandmtd;
-
-	if (nc->chip_offset >= NDFC_MAX_BANKS || nc->nr_chips > NDFC_MAX_BANKS)
-		return -EINVAL;
 
-	/* Set the bank settings */
-	__raw_writel(settings->bank_settings,
-		     ndfc->ndfcbase + NDFC_BCFG0 + (nc->chip_offset << 2));
+	ndfc->mtd.priv = chip;
+	ndfc->mtd.owner = THIS_MODULE;
 
-	nandmtd = &ndfc_mtd[pdev->id];
-	if (nandmtd->pl_chip)
-		return -EBUSY;
+	ret = nand_scan(&ndfc->mtd, 1);
+	if (ret)
+		return ret;
 
-	nandmtd->pl_chip = nc;
-	ndfc_chip_init(nandmtd);
-
-	/* Scan for chips */
-	if (nand_scan(&nandmtd->mtd, nc->nr_chips)) {
-		nandmtd->pl_chip = NULL;
-		return -ENODEV;
-	}
+	ndfc->mtd.name = ndfc->ofdev->dev.bus_id;
 
 #ifdef CONFIG_MTD_PARTITIONS
-	printk("Number of partitions %d\n", nc->nr_partitions);
-	if (nc->nr_partitions) {
-		/* Add the full device, so complete dumps can be made */
-		add_mtd_device(&nandmtd->mtd);
-		add_mtd_partitions(&nandmtd->mtd, nc->partitions,
-				   nc->nr_partitions);
-
-	} else
-#else
-		add_mtd_device(&nandmtd->mtd);
+	ret = parse_mtd_partitions(&ndfc->mtd, part_types, &parts, 0);
+	if (ret < 0)
+		return ret;
+
+#ifdef CONFIG_MTD_OF_PARTS
+	if (ret == 0) {
+		ret = of_mtd_parse_partitions(&ndfc->ofdev->dev, &ndfc->mtd,
+					      node, &parts);
+		if (ret < 0)
+			return ret;
+	}
 #endif
 
-	atomic_inc(&ndfc->childs_active);
-	return 0;
-}
+	if (ret > 0)
+		return add_mtd_partitions(&ndfc->mtd, parts, ret);
+#endif
 
-static int ndfc_chip_remove(struct platform_device *pdev)
-{
-	return 0;
+	return add_mtd_device(&ndfc->mtd);
 }
 
-static int ndfc_nand_probe(struct platform_device *pdev)
+static int __devinit ndfc_probe(struct of_device *ofdev,
+				const struct of_device_id *match)
 {
-	struct platform_nand_ctrl *nc = pdev->dev.platform_data;
-	struct ndfc_controller_settings *settings = nc->priv;
-	struct resource *res = pdev->resource;
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	unsigned long long phys = settings->ndfc_erpn | res->start;
+	const u32 *reg;
+	u32 ccr;
+	int err, len;
 
-#ifndef CONFIG_PHYS_64BIT
-	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
-#else
-	ndfc->ndfcbase = ioremap64(phys, res->end - res->start + 1);
-#endif
+	spin_lock_init(&ndfc->ndfc_control.lock);
+	init_waitqueue_head(&ndfc->ndfc_control.wq);
+	ndfc->ofdev = ofdev;
+	dev_set_drvdata(&ofdev->dev, ndfc);
+
+	/* Read the reg property to get the chip select */
+	reg = of_get_property(ofdev->node, "reg", &len);
+	if (reg == NULL || len != 12) {
+		dev_err(&ofdev->dev, "unable read reg property (%d)\n", len);
+		return -ENOENT;
+	}
+	ndfc->chip_select = reg[0];
+
+	ndfc->ndfcbase = of_iomap(ofdev->node, 0);
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
+
+	out_be32(ndfc->ndfcbase + NDFC_CCR, ccr);
 
-	platform_set_drvdata(pdev, ndfc);
+	/* Set the bank settings if given */
+	reg = of_get_property(ofdev->node, "bank-settings", NULL);
+	if (reg) {
+		int offset = NDFC_BCFG0 + (ndfc->chip_select << 2);
+		out_be32(ndfc->ndfcbase + offset, *reg);
+	}
 
-	printk("NDFC NAND Driver initialized. Chip-Rev: 0x%08x\n",
-	       __raw_readl(ndfc->ndfcbase + NDFC_REVID));
+	err = ndfc_chip_init(ndfc, ofdev->node);
+	if (err) {
+		iounmap(ndfc->ndfcbase);
+		return err;
+	}
 
 	return 0;
 }
 
-static int ndfc_nand_remove(struct platform_device *pdev)
+static int __devexit ndfc_remove(struct of_device *ofdev)
 {
-	struct ndfc_controller *ndfc = platform_get_drvdata(pdev);
+	struct ndfc_controller *ndfc = dev_get_drvdata(&ofdev->dev);
 
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
-	if (!ret)
-		ret = platform_driver_register(&ndfc_chip_driver);
-	return ret;
+	return of_register_platform_driver(&ndfc_driver);
 }
 
 static void __exit ndfc_nand_exit(void)
 {
-	platform_driver_unregister(&ndfc_chip_driver);
-	platform_driver_unregister(&ndfc_nand_driver);
+	of_unregister_platform_driver(&ndfc_driver);
 }
 
 module_init(ndfc_nand_init);
@@ -316,6 +292,4 @@ module_exit(ndfc_nand_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Thomas Gleixner <tglx@linutronix.de>");
-MODULE_DESCRIPTION("Platform driver for NDFC");
-MODULE_ALIAS("platform:ndfc-chip");
-MODULE_ALIAS("platform:ndfc-nand");
+MODULE_DESCRIPTION("OF Platform driver for NDFC");
