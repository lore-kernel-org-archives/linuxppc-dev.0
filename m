Return-Path: <nd@bplan-gmbh.de>
Date: Sun, 5 Nov 2006 12:57:06 +0100 (MET)
From: Nicolas DET <nd@bplan-gmbh.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add MPC52xx PIO/ATA support for arch/powerpc
Message-Id: <20061105105325.44e7287f.nd@bplan-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org,
	sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds ATA/PIO support for Freescale MPC5200 plaforms.

It's based on a previous patch:
http://patchwork.ozlabs.org/linuxppc/patch?id=4364

But, it now uses of_platform and a of_device_id to match the appropriate devices.

Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
---
diff -uprN a/drivers/ide/ppc/mpc52xx_ide.c b/drivers/ide/ppc/mpc52xx_ide.c
--- a/drivers/ide/ppc/mpc52xx_ide.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/ide/ppc/mpc52xx_ide.c	2006-11-05 10:40:49.000000000 +0100
@@ -0,0 +1,428 @@
+/*
+ * drivers/ide/ppc/mpc52xx_ide.h
+ *
+ * Driver for the Freescale MPC52xx on-chip IDE interface
+ *
+ *
+ * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#undef REALLY_SLOW_IO	/* most systems can safely undef this */
+
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/of_device.h>
+#include <asm/ppcboot.h>
+#include <asm/mpc52xx.h>
+
+#include "mpc52xx_ide.h"
+
+/* Private structures used by the driver */
+struct mpc52xx_ata_timings {
+	u32 pio1;
+	u32 pio2;
+	u32 mdma1;
+	u32 mdma2;
+	u32 udma1;
+	u32 udma2;
+	u32 udma3;
+	u32 udma4;
+	u32 udma5;
+	int using_udma;
+};
+
+struct mpc52xx_ide_priv {
+	unsigned int ipb_period;	/* in ps */
+	struct mpc52xx_ata __iomem *ata_regs;
+	struct mpc52xx_ata_timings  timings[2];
+	resource_size_t resmem_start;
+	size_t resmem_size;
+};
+
+/* ATAPI-4 PIO specs (arranged for the 5200, cfr User Manual) */
+/* numbers in ns, extrapolation done by code */
+static int ataspec_t0[5]    = {600, 383, 240, 180, 120};
+static int ataspec_t1[5]    = { 70,  50,  30,  30,  25};
+static int ataspec_t2_8[5]  = {290, 290, 290,  80,  70};
+static int ataspec_t2_16[5] = {165, 125, 100,  80,  70};
+static int ataspec_t2i[5]   = {  0,   0,   0,  70,  25};
+static int ataspec_t4[5]    = { 30,  20,  15,  10,  10};
+static int ataspec_ta[5]    = { 35,  35,  35,  35,  35};
+
+/* Helpers to compute timing parameters */
+#define CALC_CLK_VALUE_UP(c,v) (((v) + c - 1) / c)
+
+
+/* ======================================================================== */
+/* IDE Driver & Aux functions                                               */
+/* ======================================================================== */
+
+static void
+mpc52xx_ide_apply_timing(
+	struct mpc52xx_ata __iomem *regs, struct mpc52xx_ata_timings *timing)
+{
+	out_be32(&regs->pio1,  timing->pio1);
+	out_be32(&regs->pio2,  timing->pio2);
+	out_be32(&regs->mdma1, timing->mdma1);
+	out_be32(&regs->mdma2, timing->mdma2);
+	out_be32(&regs->udma1, timing->udma1);
+	out_be32(&regs->udma2, timing->udma2);
+	out_be32(&regs->udma3, timing->udma3);
+	out_be32(&regs->udma4, timing->udma4);
+	out_be32(&regs->udma5, timing->udma5);
+}
+
+static void
+mpc52xx_ide_compute_pio_timing(
+	struct mpc52xx_ata_timings *timing, unsigned int ipb_period, u8 pio)
+{
+	u32 t0, t2_8, t2_16, t2i, t4, t1, ta;
+
+		/* We add 1 as a 'margin' */
+	t0    = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_t0[pio]);
+	t2_8  = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_t2_8[pio]);
+	t2_16 = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_t2_16[pio]);
+	t2i   = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_t2i[pio]);
+	t4    = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_t4[pio]);
+	t1    = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_t1[pio]);
+	ta    = 1 + CALC_CLK_VALUE_UP(ipb_period, 1000*ataspec_ta[pio]);
+
+	timing->pio1 = (t0 << 24) | (t2_8 << 16) | (t2_16 << 8) | (t2i);
+	timing->pio2 = (t4 << 24) | (t1 << 16) | (ta << 8);
+}
+
+
+static void
+mpc52xx_ide_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+	int w = drive->select.b.unit & 0x01;
+
+	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+
+	printk("%s: Setting PIO %d timings\n", drive->name, pio);
+
+	mpc52xx_ide_compute_pio_timing(&priv->timings[w], priv->ipb_period, pio);
+
+	if (drive->select.all == HWIF(drive)->INB(IDE_SELECT_REG))
+		mpc52xx_ide_apply_timing(regs, &priv->timings[w]);
+
+		/* Should we do it here or only in speedproc ? */
+	ide_config_drive_speed(drive, pio + XFER_PIO_0);
+}
+
+static int
+mpc52xx_ide_speedproc(ide_drive_t *drive, u8 speed)
+{
+	/* Configure PIO Mode */
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		mpc52xx_ide_tuneproc(drive, speed - XFER_PIO_0);
+		return 0;
+	}
+
+	/* DMA settings currently unsupported */
+	printk(KERN_ERR
+		"mpc52xx-ide: speedproc called with unsupported mode %d\n",
+		speed);
+
+	return 1;
+}
+
+static void
+mpc52xx_ide_selectproc(ide_drive_t *drive)
+{
+	/* Change the PIO timings to the ones of the
+	   currently selected drive */
+	struct mpc52xx_ide_priv *priv = drive->hwif->hwif_data;
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+
+	mpc52xx_ide_apply_timing(regs,
+		&priv->timings[drive->select.b.unit & 0x01]);
+}
+
+
+static int
+mpc52xx_ide_setup(
+	struct mpc52xx_ata __iomem *regs, struct mpc52xx_ide_priv *priv)
+{
+	/* Vars */
+	//extern bd_t __res;
+	//bd_t *bd = (bd_t *)&__res;
+	unsigned long ipb_freq = 133 *1000 *1000;
+	int tslot;
+
+	/* All sample code do this */
+	out_be32(&regs->share_cnt, 0);
+
+	/* Configure & Reset host */
+	out_be32(&regs->config,
+		MPC52xx_ATA_HOSTCONF_IE |
+		MPC52xx_ATA_HOSTCONF_IORDY |
+		MPC52xx_ATA_HOSTCONF_SMR |
+		MPC52xx_ATA_HOSTCONF_FR);
+	udelay(10);
+	out_be32(&regs->config,
+		MPC52xx_ATA_HOSTCONF_IE |
+		MPC52xx_ATA_HOSTCONF_IORDY);
+
+	/* Get IPB bus period */
+	priv->ipb_period = 1000000000 / (ipb_freq /1000);
+
+	/* Try to set the time slot to around 1us = 1000000 ps */
+	tslot = CALC_CLK_VALUE_UP(priv->ipb_period, 1000000);
+	out_be32(&regs->share_cnt, tslot << 16);
+
+	/* Init imings to PIO0 (safest) */
+	memset(priv->timings, 0x00, 2*sizeof(struct mpc52xx_ata_timings));
+
+	mpc52xx_ide_compute_pio_timing(&priv->timings[0], priv->ipb_period, 0);
+	mpc52xx_ide_compute_pio_timing(&priv->timings[1], priv->ipb_period, 0);
+
+	mpc52xx_ide_apply_timing(regs, &priv->timings[0]);
+
+	return 0;
+}
+
+static void
+mpc52xx_ide_setup_hwif_ports(hw_regs_t *hw, struct mpc52xx_ata __iomem *regs)
+{
+	/* It's MMIO and we handle all the io ops ourself, */
+	/* so theses address are really virtual addresses  */
+	hw->io_ports[IDE_DATA_OFFSET]    = (unsigned long) &regs->tf_data;
+	hw->io_ports[IDE_ERROR_OFFSET]   = (unsigned long) &regs->tf_features;
+	hw->io_ports[IDE_NSECTOR_OFFSET] = (unsigned long) &regs->tf_sec_count;
+	hw->io_ports[IDE_SECTOR_OFFSET]  = (unsigned long) &regs->tf_sec_num;
+	hw->io_ports[IDE_LCYL_OFFSET]    = (unsigned long) &regs->tf_cyl_low;
+	hw->io_ports[IDE_HCYL_OFFSET]    = (unsigned long) &regs->tf_cyl_high;
+	hw->io_ports[IDE_SELECT_OFFSET]  = (unsigned long) &regs->tf_dev_head;
+	hw->io_ports[IDE_STATUS_OFFSET]  = (unsigned long) &regs->tf_command;
+	hw->io_ports[IDE_CONTROL_OFFSET] = (unsigned long) &regs->tf_control;
+}
+
+
+/* ======================================================================== */
+/* OF Platform Driver                                                          */
+/* ======================================================================== */
+
+static int __devinit
+mpc52xx_ide_probe(struct of_device *op, const struct of_device_id *match)
+{
+	/* Vars */
+	ide_hwif_t *hwif;
+	int ret;
+	struct mpc52xx_ide_priv *priv;
+	struct mpc52xx_ata __iomem *ata_regs = NULL;
+	int ata_irq;
+	struct resource res_mem;
+	size_t res_mem_size;
+	int i, rv;
+
+	/* Get an empty slot */
+	for (i=0; i<MAX_HWIFS && ide_hwifs[i].io_ports[IDE_DATA_OFFSET]; i++);
+	if (i >= MAX_HWIFS) {
+		printk(KERN_ERR "mpc52xx-ide: No free hwif slot !\n");
+		return -ENOMEM;
+	}
+
+	hwif = &ide_hwifs[i];
+
+	/* Get the resources of this device */
+	ata_irq = irq_of_parse_and_map(op->node, 0);
+	if (ata_irq == NO_IRQ) {
+		printk(KERN_ERR "mpc52xx-ide: Invalid IRQ!\n");
+		return -EINVAL;
+	}
+	//res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if ((ret = of_address_to_resource(op->node, 0, &res_mem)) != 0)
+	{
+		printk(KERN_ERR "mpc52xx-ide: Can not find IO mem!\n");
+		return ret;
+	}
+
+	res_mem_size = res_mem.end - res_mem.start + 1;
+
+	if (!request_mem_region(res_mem.start, res_mem_size,
+				"mpc52xx-ide")) {
+		printk(KERN_ERR "mpc52xx-ide: Memory zone unavailable !\n");
+		return -EBUSY;
+	}
+
+	ata_regs = ioremap(res_mem.start, res_mem_size);
+	if (!ata_regs) {
+		printk(KERN_ERR
+			"mpc52xx-ide: Unable to ioremap ATA registers\n");
+		rv = -ENOMEM;
+		goto error;
+	}
+
+	/* Setup private structure */
+	priv = kmalloc(sizeof(struct mpc52xx_ide_priv), GFP_ATOMIC);
+	if (!priv) {
+		printk(KERN_ERR
+			"mpc52xx-ide: Can't allocate private structure !\n");
+		rv = -ENOMEM;
+		goto error;
+	}
+
+	priv->resmem_size = res_mem_size;
+	priv->resmem_start = res_mem.start;
+	priv->ata_regs = ata_regs;
+
+	/* Setup the ATA controller */
+	rv = mpc52xx_ide_setup(ata_regs, priv);
+	if (rv) {
+		printk(KERN_ERR "mpc52xx-ide: Controller setup failed !\n");
+		goto error;
+	}
+
+	/* Setup the hwif structure */
+	hwif->irq = ata_irq;
+	hwif->mmio = 2;
+	mpc52xx_ide_setup_hwif_iops(hwif);
+	mpc52xx_ide_setup_hwif_ports(&hwif->hw, ata_regs);
+	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
+
+	hwif->atapi_dma = 0;
+	hwif->ultra_mask = 0x00;
+	hwif->mwdma_mask = 0x00;
+	hwif->swdma_mask = 0x00;
+	hwif->chipset = ide_forced;
+	hwif->tuneproc = mpc52xx_ide_tuneproc;
+	hwif->speedproc = mpc52xx_ide_speedproc;
+	hwif->selectproc = mpc52xx_ide_selectproc;
+	hwif->noprobe = 0;
+	hwif->hold = 1;
+	hwif->autodma = 0;
+	hwif->udma_four = 0;
+	hwif->no_lba48 = 1;	/* FIXME ? Did some one test that ? */
+	hwif->no_lba48_dma = 1;
+
+	hwif->drives[0].unmask = 1;
+	hwif->drives[0].autotune = 0; /* default */
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[0].no_io_32bit = 1;	/* Anyone tried ? */
+
+	hwif->drives[1].unmask = 1;
+	hwif->drives[1].autotune = 0; /* default */
+	hwif->drives[1].autodma = hwif->autodma;
+	hwif->drives[1].no_io_32bit = 1;	/* Anyone tried ? */
+
+	hwif->hwif_data = priv;
+	dev_set_drvdata(&op->dev, hwif);
+
+	/* Lauch probe */
+	probe_hwif_init(hwif);
+
+	/* We're good ! */
+	printk(KERN_INFO
+	  "mpc52xx-ide: Setup successful for %s (mem=%08lx-%08lx irq=%d)\n",
+	  hwif->name, (unsigned long) res_mem.start, (unsigned long) res_mem.end, ata_irq);
+
+	return 0;
+
+
+	/* Error path */
+error:
+	if (ata_regs)
+		iounmap(ata_regs);
+
+	release_mem_region(res_mem.start, res_mem_size);
+
+	return rv;
+}
+
+static int
+mpc52xx_ide_remove(struct of_device *op)
+{
+	ide_hwif_t *hwif = dev_get_drvdata(&op->dev);
+	struct mpc52xx_ide_priv *priv = hwif->hwif_data;
+
+	ide_unregister(hwif - ide_hwifs);
+
+	iounmap(priv->ata_regs);
+
+	release_mem_region(priv->resmem_start, priv->resmem_size);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int
+mpc52xx_ide_suspend(struct of_device *op, pm_message_t state)
+{
+	return 0;	/* FIXME : What to do here ? */
+}
+
+static int
+mpc52xx_ide_resume(struct of_device *op)
+{
+	return 0;	/* FIXME : What to do here ? */
+}
+#endif
+
+
+static struct of_device_id mpc52xx_ide_of_match[] = {
+	{
+		.name = "ata",
+		.compatible = "mpc5200-ata",
+	},
+	{
+		.name = "ata",
+		.compatible = "mpc52xx-ata",
+	},
+	{},
+};
+
+
+static struct of_platform_driver mpc52xx_ide_of_platform_driver = {
+	.name	= "mpc52xx-ata",
+	.match_table    = mpc52xx_ide_of_match,
+	.probe		= mpc52xx_ide_probe,
+	.remove		= mpc52xx_ide_remove,
+#ifdef CONFIG_PM
+	.suspend	= mpc52xx_ide_suspend,
+	.resume		= mpc52xx_ide_resume,
+#endif
+	.driver		= {
+		.name	= "mpc52xx-ata",
+		.owner	= THIS_MODULE,
+	},
+};
+
+
+/* ======================================================================== */
+/* Module                                                                   */
+/* ======================================================================== */
+
+static int __init
+mpc52xx_ide_init(void)
+{
+	printk(KERN_INFO "ide: MPC52xx IDE/ATA driver\n");
+	return of_register_driver(&mpc52xx_ide_of_platform_driver);
+}
+
+static void __exit
+mpc52xx_ide_exit(void)
+{
+	of_unregister_driver(&mpc52xx_ide_of_platform_driver);
+}
+
+module_init(mpc52xx_ide_init);
+module_exit(mpc52xx_ide_exit);
+
+MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
+MODULE_DESCRIPTION("Freescale MPC52xx IDE/ATA driver");
+MODULE_LICENSE("GPL");
+
diff -uprN a/drivers/ide/ppc/mpc52xx_ide.h b/drivers/ide/ppc/mpc52xx_ide.h
--- a/drivers/ide/ppc/mpc52xx_ide.h	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/ide/ppc/mpc52xx_ide.h	2006-11-05 10:40:49.000000000 +0100
@@ -0,0 +1,127 @@
+/*
+ * drivers/ide/ppc/mpc52xx_ide.h
+ *
+ * Definitions for the Freescale MPC52xx on-chip IDE interface
+ *
+ *
+ * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __MPC52xx_IDE_H__
+#define __MPC52xx_IDE_H__
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <asm/types.h>
+#include <asm/io.h>
+
+
+
+/* Bit definitions inside the registers */
+
+#define MPC52xx_ATA_HOSTCONF_SMR	0x80000000UL /* State machine reset */
+#define MPC52xx_ATA_HOSTCONF_FR		0x40000000UL /* FIFO Reset */
+#define MPC52xx_ATA_HOSTCONF_IE		0x02000000UL /* Enable interrupt in PIO */
+#define MPC52xx_ATA_HOSTCONF_IORDY	0x01000000UL /* Drive supports IORDY protocol */
+
+#define MPC52xx_ATA_HOSTSTAT_TIP	0x80000000UL /* Transaction in progress */
+#define MPC52xx_ATA_HOSTSTAT_UREP	0x40000000UL /* UDMA Read Extended Pause */
+#define MPC52xx_ATA_HOSTSTAT_RERR	0x02000000UL /* Read Error */
+#define MPC52xx_ATA_HOSTSTAT_WERR	0x01000000UL /* Write Error */
+
+#define MPC52xx_ATA_FIFOSTAT_EMPTY	0x01 /* FIFO Empty */
+
+#define MPC52xx_ATA_DMAMODE_WRITE	0x01 /* Write DMA */
+#define MPC52xx_ATA_DMAMODE_READ	0x02 /* Read DMA */
+#define MPC52xx_ATA_DMAMODE_UDMA	0x04 /* UDMA enabled */
+#define MPC52xx_ATA_DMAMODE_IE		0x08 /* Enable drive interrupt to CPU in DMA mode */
+#define MPC52xx_ATA_DMAMODE_FE		0x10 /* FIFO Flush enable in Rx mode */
+#define MPC52xx_ATA_DMAMODE_FR		0x20 /* FIFO Reset */
+#define MPC52xx_ATA_DMAMODE_HUT		0x40 /* Host UDMA burst terminate */
+
+
+/* Structure of the hardware registers */
+struct mpc52xx_ata {
+
+	/* Host interface registers */
+	u32 config;		/* ATA + 0x00 Host configuration */
+	u32 host_status;	/* ATA + 0x04 Host controller status */
+	u32 pio1;		/* ATA + 0x08 PIO Timing 1 */
+	u32 pio2;		/* ATA + 0x0c PIO Timing 2 */
+	u32 mdma1;		/* ATA + 0x10 MDMA Timing 1 */
+	u32 mdma2;		/* ATA + 0x14 MDMA Timing 2 */
+	u32 udma1;		/* ATA + 0x18 UDMA Timing 1 */
+	u32 udma2;		/* ATA + 0x1c UDMA Timing 2 */
+	u32 udma3;		/* ATA + 0x20 UDMA Timing 3 */
+	u32 udma4;		/* ATA + 0x24 UDMA Timing 4 */
+	u32 udma5;		/* ATA + 0x28 UDMA Timing 5 */
+	u32 share_cnt;		/* ATA + 0x2c ATA share counter */
+	u32 reserved0[3];
+
+	/* FIFO registers */
+	u32 fifo_data;		/* ATA + 0x3c */
+	u8  fifo_status_frame;	/* ATA + 0x40 */
+	u8  fifo_status;	/* ATA + 0x41 */
+	u16 reserved7[1];
+	u8  fifo_control;	/* ATA + 0x44 */
+	u8  reserved8[5];
+	u16 fifo_alarm;		/* ATA + 0x4a */
+	u16 reserved9;
+	u16 fifo_rdp;		/* ATA + 0x4e */
+	u16 reserved10;
+	u16 fifo_wrp;		/* ATA + 0x52 */
+	u16 reserved11;
+	u16 fifo_lfrdp;		/* ATA + 0x56 */
+	u16 reserved12;
+	u16 fifo_lfwrp;		/* ATA + 0x5a */
+
+	/* Drive TaskFile registers */
+	u8  tf_control;		/* ATA + 0x5c TASKFILE Control/Alt Status */
+	u8  reserved13[3];
+	u16 tf_data;		/* ATA + 0x60 TASKFILE Data */
+	u16 reserved14;
+	u8  tf_features;	/* ATA + 0x64 TASKFILE Features/Error */
+	u8  reserved15[3];
+	u8  tf_sec_count;	/* ATA + 0x68 TASKFILE Sector Count */
+	u8  reserved16[3];
+	u8  tf_sec_num;		/* ATA + 0x6c TASKFILE Sector Number */
+	u8  reserved17[3];
+	u8  tf_cyl_low;		/* ATA + 0x70 TASKFILE Cylinder Low */
+	u8  reserved18[3];
+	u8  tf_cyl_high;	/* ATA + 0x74 TASKFILE Cylinder High */
+	u8  reserved19[3];
+	u8  tf_dev_head;	/* ATA + 0x78 TASKFILE Device/Head */
+	u8  reserved20[3];
+	u8  tf_command;		/* ATA + 0x7c TASKFILE Command/Status */
+	u8  dma_mode;		/* ATA + 0x7d ATA Host DMA Mode configuration */
+	u8  reserved21[2];
+};
+
+
+/* Function definition */
+
+static inline void
+mpc52xx_ide_wait_tip_bit_clear(struct mpc52xx_ata __iomem *regs)
+{
+	int timeout = 1000;
+
+	while (in_be32(&regs->host_status) & MPC52xx_ATA_HOSTSTAT_TIP)
+		if (timeout-- == 0) {
+			printk(KERN_ERR
+				"mpc52xx-ide: Timeout waiting for TIP clear\n");
+			break;
+		}
+	udelay(10);	/* FIXME: Necessary ??? */
+}
+
+extern void mpc52xx_ide_setup_hwif_iops(ide_hwif_t *hwif);
+
+
+#endif /* __MPC52xx_IDE_H__ */
+
diff -uprN a/drivers/ide/ppc/mpc52xx_ide_iops.c b/drivers/ide/ppc/mpc52xx_ide_iops.c
--- a/drivers/ide/ppc/mpc52xx_ide_iops.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/ide/ppc/mpc52xx_ide_iops.c	2006-11-05 10:40:49.000000000 +0100
@@ -0,0 +1,150 @@
+/*
+ * drivers/ide/ppc/mpc52xx_ide_iops.c
+ *
+ * Utility functions for MPC52xx on-chip IDE interface
+ *
+ *
+ * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ide.h>
+#include <asm/io.h>
+
+#include "mpc52xx_ide.h"
+
+
+
+static u8
+mpc52xx_ide_inb(unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	return (u8) readb((void __iomem *) port);
+}
+
+static u16
+mpc52xx_ide_inw(unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	return (u16) readw((void __iomem *) port);
+}
+
+static void
+mpc52xx_ide_insw(unsigned long port, void *addr, u32 count)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	__ide_mm_insw((void __iomem *) port, addr, count);
+}
+
+static u32
+mpc52xx_ide_inl(unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	return (u32) readl((void __iomem *) port);
+}
+
+static void
+mpc52xx_ide_insl(unsigned long port, void *addr, u32 count)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	__ide_mm_insl((void __iomem *) port, addr, count);
+}
+
+static void
+mpc52xx_ide_outb(u8 value, unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	writeb(value, (void __iomem *) port);
+}
+
+static void
+mpc52xx_ide_outbsync(ide_drive_t *drive, u8 value, unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	writeb(value, (void __iomem *) port);
+}
+
+
+static void
+mpc52xx_ide_outw(u16 value, unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	writew(value, (void __iomem *) port);
+}
+
+static void
+mpc52xx_ide_outsw(unsigned long port, void *addr, u32 count)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	__ide_mm_outsw((void __iomem *) port, addr, count);
+}
+
+static void
+mpc52xx_ide_outl(u32 value, unsigned long port)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	writel(value, (void __iomem *) port);
+}
+
+static void
+mpc52xx_ide_outsl(unsigned long port, void *addr, u32 count)
+{
+	struct mpc52xx_ata __iomem *ata_regs =
+		(struct mpc52xx_ata __iomem *)(port & ~0xfful);
+
+	mpc52xx_ide_wait_tip_bit_clear(ata_regs);
+	__ide_mm_outsl((void __iomem *) port, addr, count);
+}
+
+
+void
+mpc52xx_ide_setup_hwif_iops(ide_hwif_t *hwif)
+{
+	hwif->OUTB	= mpc52xx_ide_outb;
+	hwif->OUTBSYNC	= mpc52xx_ide_outbsync;
+	hwif->OUTW	= mpc52xx_ide_outw;
+	hwif->OUTL	= mpc52xx_ide_outl;
+	hwif->OUTSW	= mpc52xx_ide_outsw;
+	hwif->OUTSL	= mpc52xx_ide_outsl;
+	hwif->INB	= mpc52xx_ide_inb;
+	hwif->INW	= mpc52xx_ide_inw;
+	hwif->INL	= mpc52xx_ide_inl;
+	hwif->INSW	= mpc52xx_ide_insw;
+	hwif->INSL	= mpc52xx_ide_insl;
+}
+
--- a/drivers/ide/Kconfig	2006-11-04 15:29:27.000000000 +0100
+++ b/drivers/ide/Kconfig	2006-11-05 10:40:49.000000000 +0100
@@ -955,6 +955,10 @@ config IDE_EXT_DIRECT
 
 endchoice
 
+config BLK_DEV_MPC52xx_IDE
+        tristate "MPC52xx Builtin IDE support"
+        depends on PPC_MPC52xx && IDE=y
+
 # no isa -> no vlb
 config IDE_CHIPSETS
 	bool "Other IDE chipset support"
--- a/drivers/ide/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ b/drivers/ide/Makefile	2006-11-05 10:40:49.000000000 +0100
@@ -36,6 +36,7 @@ ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= leg
 # built-in only drivers from ppc/
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
 ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
+ide-core-$(CONFIG_BLK_DEV_MPC52xx_IDE)  += ppc/mpc52xx_ide.o ppc/mpc52xx_ide_iops.o
 
 # built-in only drivers from h8300/
 ide-core-$(CONFIG_H8300)		+= h8300/ide-h8300.o
