Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67716DE0F9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:23:24 +1100 (EST)
Date: Mon, 29 Oct 2007 23:21:09 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] PowerPC: Add device-tree aware PowerPC 44x NDFC driver
Message-ID: <20071029202109.GA2123@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029201738.GA2022@ru.mvista.com>
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support of the built-in PowerPC 44x NanD Flash Controller (NDFC)
based on the OF description. This version supports both separate mtd devices on
each NDFC bank and mtd devices spread across identical chips attached to NDFC
banks depending on the device tree settings. This is based on the original NDFC
driver by Thomas Gleixner, but since a lot of things have been reworked it's
been put to a separate ndfc_of file.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/mtd/nand/Kconfig   |    7 
 drivers/mtd/nand/Makefile  |    1 
 drivers/mtd/nand/ndfc_of.c |  599 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/ndfc.h   |    4 
 4 files changed, 611 insertions(+)

diff -pruN linux-2.6.orig/drivers/mtd/nand/Kconfig linux-2.6/drivers/mtd/nand/Kconfig
--- linux-2.6.orig/drivers/mtd/nand/Kconfig	2007-10-29 16:02:37.000000000 +0300
+++ linux-2.6/drivers/mtd/nand/Kconfig	2007-10-29 19:02:13.000000000 +0300
@@ -158,6 +158,13 @@ config MTD_NAND_NDFC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
 
+config MTD_NAND_NDFC_OF
+	tristate "NDFC NanD Flash Controller based on OF"
+	depends on 44x && PPC_MERGE
+	select MTD_NAND_ECC_SMC
+	help
+	 NDFC Nand Flash Controllers are integrated in EP44x SoCs
+
 config MTD_NAND_S3C2410_CLKSTOP
 	bool "S3C2410 NAND IDLE clock stop"
 	depends on MTD_NAND_S3C2410
diff -pruN linux-2.6.orig/drivers/mtd/nand/Makefile linux-2.6/drivers/mtd/nand/Makefile
--- linux-2.6.orig/drivers/mtd/nand/Makefile	2007-10-29 16:02:37.000000000 +0300
+++ linux-2.6/drivers/mtd/nand/Makefile	2007-10-29 18:59:11.000000000 +0300
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
+++ linux-2.6/drivers/mtd/nand/ndfc_of.c	2007-10-29 22:07:45.000000000 +0300
@@ -0,0 +1,598 @@
+/*
+ *  Overview:
+ *   Platform independend driver for NDFC (NanD Flash Controller)
+ *   integrated into EP440 cores with OF device tree support
+ *
+ *  Based on the original ndfc driver by Thomas Gleixner
+ *
+ *  Copyright 2006 IBM
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
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
+	uint32_t		bank_mask;
+	struct nand_hw_control	control;
+	struct list_head	list;
+};
+
+struct of_ndfc_mtd {
+	struct list_head	list;
+	struct of_ndfc		*ndfc;
+	unsigned char		banks[NDFC_MAX_BANKS];
+	unsigned 		chip_cnt;
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
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	uint32_t ccr;
+
+	ccr = ndfc_raw_readl(ndfc, NDFC_CCR);
+	if ((chip >= 0) && (chip < ndfc_mtd->chip_cnt))  {
+		ccr &= ~NDFC_CCR_BS_MASK;
+		ccr |= NDFC_CCR_BS(ndfc_mtd->banks[chip]);
+	} else
+		ccr |= NDFC_CCR_RESET_CE;
+	ndfc_raw_writel(ndfc, NDFC_CCR, ccr);
+}
+
+static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
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
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+
+	return ndfc_raw_readl(ndfc, NDFC_STAT) & NDFC_STAT_IS_READY;
+}
+
+static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	uint32_t ccr;
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
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	uint32_t ecc;
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
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	uint32_t *p = (uint32_t *) buf;
+
+	for(;len > 0; len -= 4)
+		*p++ = ndfc_raw_readl(ndfc, NDFC_DATA);
+}
+
+static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	uint32_t *p = (uint32_t *) buf;
+
+	for(;len > 0; len -= 4)
+		ndfc_raw_writel(ndfc, NDFC_DATA, *p++);
+}
+
+static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip *this = mtd->priv;
+	struct of_ndfc_mtd *ndfc_mtd = this->priv;
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	uint32_t *p = (uint32_t *) buf;
+
+	for(;len > 0; len -= 4)
+		if (*p++ != ndfc_raw_readl(ndfc, NDFC_DATA))
+			return -EFAULT;
+	return 0;
+}
+
+
+#ifdef CONFIG_MTD_PARTITIONS
+#define OF_FLASH_PARTS(ndfc_mtd)	((ndfc_mtd)->parts)
+static int __devinit parse_partitions(struct of_ndfc_mtd *ndfc_mtd,
+				      struct device_node *dp)
+{
+	const char *partname;
+	static const char *part_probe_types[]
+		= { "cmdlinepart", "RedBoot", NULL };
+	struct device_node *pp;
+	int nr_parts, i;
+
+	/* First look for RedBoot table or partitions on the command
+	 * line, these take precedence over device tree information */
+	nr_parts = parse_mtd_partitions(&ndfc_mtd->mtd, part_probe_types,
+					&ndfc_mtd->parts, 0);
+	if (nr_parts > 0)
+		return nr_parts;
+
+	/* First count the subnodes */
+	nr_parts = 0;
+	for (pp = of_get_next_child(dp, NULL); pp;
+	     pp = of_get_next_child(dp, pp))
+		nr_parts++;
+
+	if (nr_parts == 0)
+		return 0;
+
+	ndfc_mtd->parts = kzalloc(nr_parts * sizeof(*ndfc_mtd->parts),
+					GFP_KERNEL);
+	if (!ndfc_mtd->parts)
+		return -ENOMEM;
+
+	for (pp = of_get_next_child(dp, NULL), i = 0; pp;
+	     pp = of_get_next_child(dp, pp), i++) {
+		const u32 *reg;
+		int len;
+
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg || (len != 2*sizeof(u32))) {
+			of_node_put(pp);
+			printk(KERN_ERR "%s: Invalid 'reg'\n",
+				dp->full_name);
+			kfree(ndfc_mtd->parts);
+			ndfc_mtd->parts = NULL;
+			return -EINVAL;
+		}
+		ndfc_mtd->parts[i].offset = reg[0];
+		ndfc_mtd->parts[i].size = reg[1];
+
+		partname = of_get_property(pp, "label", &len);
+		if (!partname)
+			partname = of_get_property(pp, "name", &len);
+		ndfc_mtd->parts[i].name = (char *)partname;
+
+		if (of_get_property(pp, "read-only", &len))
+			ndfc_mtd->parts[i].mask_flags = MTD_WRITEABLE;
+	}
+
+	return nr_parts;
+}
+#else /* MTD_PARTITIONS */
+#define	OF_FLASH_PARTS(ndfc_mtd)		(0)
+static inline int parse_partitions(struct of_ndfc *ndfc, struct of_device *dev)
+{
+	return 0;
+}
+#endif /* MTD_PARTITIONS */
+
+
+static inline uint32_t ndfc_mtd_bank_mask(struct of_ndfc_mtd *ndfc_mtd)
+{
+	unsigned i;
+	uint32_t mask = 0;
+
+	for (i = 0; i < ndfc_mtd->chip_cnt; i++)
+		mask |= 1 << ndfc_mtd->banks[i];
+
+	return mask;
+}
+
+
+static inline void ndfc_del_mtd(struct of_ndfc *ndfc, struct of_ndfc_mtd *ndfc_mtd)
+{
+	uint32_t busy;
+
+	list_del(&ndfc_mtd->list);
+	busy = ndfc_mtd_bank_mask(ndfc_mtd);
+	ndfc->bank_mask &= ~busy;
+}
+
+
+static inline void ndfc_add_mtd(struct of_ndfc *ndfc, struct of_ndfc_mtd *ndfc_mtd)
+{
+	uint32_t busy;
+
+	busy = ndfc_mtd_bank_mask(ndfc_mtd);
+	ndfc->bank_mask |= busy;
+	list_add(&ndfc_mtd->list, &ndfc->list);
+}
+
+
+static int of_ndfc_remove(struct of_device *dev)
+{
+	struct of_ndfc_mtd *ndfc_mtd, *ndfc_mtd_next;
+	struct of_ndfc *ndfc;
+
+	ndfc = dev_get_drvdata(&dev->dev);
+	if (!ndfc)
+		return 0;
+
+	/* remove all mtd devices first*/
+	list_for_each_entry_safe(ndfc_mtd, ndfc_mtd_next,
+				&ndfc->list, list) {
+		if (OF_FLASH_PARTS(ndfc_mtd)) {
+			del_mtd_partitions(&ndfc_mtd->mtd);
+			kfree(OF_FLASH_PARTS(ndfc_mtd));
+		} else {
+			del_mtd_device(&ndfc_mtd->mtd);
+		}
+		nand_release(&ndfc_mtd->mtd);
+
+		ndfc_del_mtd(ndfc, ndfc_mtd);
+		kfree(ndfc_mtd);
+	}
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
+	return 0;
+}
+
+
+static int __devinit ndfc_get_bank_map_prop(struct device_node *dp,
+					    unsigned char *map,
+					    uint32_t busy)
+{
+	const u32 *prop;
+	u32 val, len, mask;
+	int i;
+
+	prop = of_get_property(dp, "bank-map", &len);
+	if (!prop || (len < sizeof(u32)))
+		return -EFAULT;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		val = prop[i];
+		if (val > NDFC_MAX_BANKS) {
+			printk(KERN_ERR "%s: Invalid bank (%i)\n",
+				dp->full_name, val);
+			return -EINVAL;
+		}
+
+		mask = 1 << val;
+		if (busy & mask) {
+			printk(KERN_ERR "%s: Busy bank (%i)\n",
+				dp->full_name, val);
+			return -EBUSY;
+		}
+
+		busy |= mask;
+		map[i] = (unsigned char)val;
+	}
+	return i;
+}
+
+
+static __devinit void ndfc_mtd_chip_init(struct of_ndfc_mtd *ndfc_mtd,
+					 struct device_node *dp)
+{
+	struct of_ndfc *ndfc = ndfc_mtd->ndfc;
+	struct nand_chip *chip = &ndfc_mtd->chip;
+	const u32 *prop;
+
+	chip->IO_ADDR_R = ndfc->base + NDFC_DATA;
+	chip->IO_ADDR_W = ndfc->base + NDFC_DATA;
+	chip->cmd_ctrl = ndfc_hwcontrol;
+	chip->dev_ready = ndfc_ready;
+	chip->select_chip = ndfc_select_chip;
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
+
+	/* look for chip options */
+	prop = of_get_property(dp, "chip-options", NULL);
+	if (prop)
+		ndfc_mtd->chip.options = *prop;
+
+	/* look for chip delay */
+	prop = of_get_property(dp, "chip-delay", NULL);
+	if (prop)
+		chip->chip_delay = *prop;
+	else
+		chip->chip_delay = 50;
+	chip->priv = ndfc_mtd;
+}
+
+
+static int __devinit ndfc_init_mtd(struct of_ndfc *ndfc, struct device_node *dp)
+{
+	const u32 *prop;
+	uint32_t bcr;
+	struct of_ndfc_mtd *ndfc_mtd;
+	int i, err;
+
+	if (!ndfc || !dp)
+		return -EINVAL;
+
+	ndfc_mtd = kzalloc(sizeof(struct of_ndfc_mtd), GFP_KERNEL);
+	if (!ndfc_mtd)
+		return -ENOMEM;
+
+	ndfc_mtd->ndfc = ndfc;
+
+	/* look for a bank-map */
+	err = ndfc_get_bank_map_prop(dp, ndfc_mtd->banks, ndfc->bank_mask);
+	if (err < 0)
+		goto err_out;
+
+	if (err == 0) {
+		err = -ENODEV;
+		goto err_out;
+	}
+	ndfc_mtd->chip_cnt = err;
+
+	/* look for bank settings */
+	prop = of_get_property(dp, "bank-settings", NULL);
+	if (prop) {
+		bcr = *prop | NDFC_BxCFG_EN;
+	} else {
+		bcr = NDFC_BxCFG_RR(2) | NDFC_BxCFG_RWH(2) |
+			NDFC_BxCFG_RWP(2) | NDFC_BxCFG_CRW(2);
+	}
+
+	/* look for bank width */
+	prop = of_get_property(dp, "bank-width", NULL);
+	if (prop && (*prop == 2))
+		bcr |= NDFC_BxCFG_SZ_16BIT;
+
+	/* setup banks for this mtd device */
+	for (i = 0; i < ndfc_mtd->chip_cnt; i++) {
+		ndfc_raw_writel(ndfc,
+				NDFC_BCFG0 + (ndfc_mtd->banks[i] << 2), bcr);
+	}
+
+	ndfc_mtd_chip_init(ndfc_mtd, dp);
+
+	if (bcr & NDFC_BxCFG_SZ_16BIT)
+		ndfc_mtd->chip.options |= NAND_BUSWIDTH_16;
+
+	ndfc_mtd->mtd.priv = &ndfc_mtd->chip;
+	ndfc_mtd->mtd.owner = THIS_MODULE;
+
+	/* scan for known chips */
+	err = nand_scan(&ndfc_mtd->mtd, ndfc_mtd->chip_cnt);
+	if (err)
+		goto err_out;
+
+	/* get partitions */
+	err = parse_partitions(ndfc_mtd, dp);
+	if (err < 0)
+		goto err_out;
+
+	/* attach mtd device to ndfc */
+	ndfc_add_mtd(ndfc, ndfc_mtd);
+
+	if (err > 0) {
+		add_mtd_partitions(&ndfc_mtd->mtd,
+					OF_FLASH_PARTS(ndfc_mtd), err);
+	} else {
+		add_mtd_device(&ndfc_mtd->mtd);
+	}
+
+	return 0;
+err_out:
+	kfree(ndfc_mtd);
+	return err;
+}
+
+
+static int __devinit ndfc_map_banks(struct of_ndfc *ndfc,
+				    struct of_device *dev)
+{
+	int i, err;
+	struct device_node *dp = dev->node, *pp;
+
+	if (!ndfc || !dev)
+		return -EINVAL;
+
+	/* Disable all banks */
+	for (i = 0; i < NDFC_MAX_BANKS; i++)
+		ndfc_raw_writel(ndfc, NDFC_BCFG0 + (i << 2), 0);
+
+	/* Scan device tree for nand devices attached and init them */
+	i = 0;
+	for (pp = of_get_next_child(dp, NULL); pp;
+	     pp = of_get_next_child(dp, pp)) {
+		err = ndfc_init_mtd(ndfc, pp);
+		if (err) {
+			printk(KERN_ERR "%s: Failed to map\n",
+				pp->full_name);
+			continue;
+		}
+		i++;
+	}
+	return i;
+}
+
+
+static int __devinit of_ndfc_probe(struct of_device *dev,
+				   const struct of_device_id *match)
+{
+	struct device_node *dp = dev->node;
+	struct resource res;
+	struct of_ndfc *ndfc;
+	resource_size_t rlen;
+	int err;
+
+	err = -ENXIO;
+	if (of_address_to_resource(dp, 0, &res)) {
+		dev_err(&dev->dev, "Can't get IO address from device tree\n");
+		goto err_out;
+	}
+
+	dev_dbg(&dev->dev, "of_nand device: %.8llx-%.8llx\n",
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
+	INIT_LIST_HEAD(&ndfc->list);
+
+	err = ndfc_map_banks(ndfc, dev);
+	if (err <= 0) {
+		printk(KERN_ERR "NDFC NAND: (%s) no banks set up\n",
+			dp->full_name);
+		err = -ENODEV;
+		goto err_unmap_out;
+	}
+
+	dev_set_drvdata(&dev->dev, ndfc);
+	printk(KERN_INFO "NDFC NAND Driver initialized. "
+			"Chip-Rev: 0x%08x\n", ndfc_raw_readl(ndfc, NDFC_REVID));
+
+	return 0;
+
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
+MODULE_DESCRIPTION("Platform driver for NDFC");
diff -pruN linux-2.6.orig/include/linux/mtd/ndfc.h linux-2.6/include/linux/mtd/ndfc.h
--- linux-2.6.orig/include/linux/mtd/ndfc.h	2007-10-29 16:03:16.000000000 +0300
+++ linux-2.6/include/linux/mtd/ndfc.h	2007-10-29 18:59:11.000000000 +0300
@@ -52,6 +52,10 @@
 #define NDFC_BxCFG_SZ_MASK	0x08000000 /* Bank Size */
 #define NDFC_BxCFG_SZ_8BIT	0x00000000 /* 8bit */
 #define NDFC_BxCFG_SZ_16BIT	0x08000000 /* 16bit */
+#define NDFC_BxCFG_RR(x)	((x) & 0x3 << 0)
+#define NDFC_BxCFG_RWH(x)	((x) & 0x3 << 4)
+#define NDFC_BxCFG_RWP(x)	((x) & 0x3 << 8)
+#define NDFC_BxCFG_CRW(x)	((x) & 0x3 << 12)
 
 #define NDFC_MAX_BANKS		4
 
