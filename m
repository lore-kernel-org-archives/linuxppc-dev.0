Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id 63EC1B7221
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 18:26:14 +1000 (EST)
Received: from mail20-va3 (localhost.localdomain [127.0.0.1])	by
	mail20-va3-R.bigfish.com (Postfix) with ESMTP id 57970B78362	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:11 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.249])	by
	mail20-va3.bigfish.com (Postfix) with ESMTP id 04C73122804D	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:08 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8U8Q0fV023976	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 01:26:00 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8U8fXH8017737	for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Sep 2010 03:41:42 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Subject: [PATCH v3 2/7] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
Date: Thu, 30 Sep 2010 16:00:41 +0800
Message-ID: <1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactor the common code in file spi_fsl_spi.c to spi_fsl_lib.c used
by SPI/eSPI controller driver as a library, and leave the QE/CPM SPI
controller code in the SPI controller driver spi_fsl_spi.c.

Because the register map of the SPI controller and eSPI controller
is so different, also leave the code operated the register to the
driver code, not the common code.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---

v3:
 - Update to the latest kernel base.
 - Add a void *reg_base to compatible for SPI and eSPI register base.

 drivers/spi/Kconfig       |    5 +
 drivers/spi/Makefile      |    1 +
 drivers/spi/spi_fsl_lib.c |  237 +++++++++++++++++++
 drivers/spi/spi_fsl_lib.h |  119 ++++++++++
 drivers/spi/spi_fsl_spi.c |  552 +++++++++++++--------------------------------
 5 files changed, 522 insertions(+), 392 deletions(-)
 create mode 100644 drivers/spi/spi_fsl_lib.c
 create mode 100644 drivers/spi/spi_fsl_lib.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6af34c6..79ad06f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -182,9 +182,14 @@ config SPI_MPC512x_PSC
 	  This enables using the Freescale MPC5121 Programmable Serial
 	  Controller in SPI master mode.
 
+config SPI_FSL_LIB
+	tristate
+	depends on FSL_SOC
+
 config SPI_FSL_SPI
 	tristate "Freescale SPI controller"
 	depends on FSL_SOC
+	select SPI_FSL_LIB
 	help
 	  This enables using the Freescale SPI controllers in master mode.
 	  MPC83xx platform uses the controller in cpu mode or CPM/QE mode.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 770817c..7974c21 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SPI_PL022)			+= amba-pl022.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= mpc512x_psc_spi.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52xx_psc_spi.o
 obj-$(CONFIG_SPI_MPC52xx)		+= mpc52xx_spi.o
+obj-$(CONFIG_SPI_FSL_LIB)		+= spi_fsl_lib.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi_fsl_spi.o
 obj-$(CONFIG_SPI_PPC4xx)		+= spi_ppc4xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
diff --git a/drivers/spi/spi_fsl_lib.c b/drivers/spi/spi_fsl_lib.c
new file mode 100644
index 0000000..5cd741f
--- /dev/null
+++ b/drivers/spi/spi_fsl_lib.c
@@ -0,0 +1,237 @@
+/*
+ * Freescale SPI/eSPI controller driver library.
+ *
+ * Maintainer: Kumar Gala
+ *
+ * Copyright (C) 2006 Polycom, Inc.
+ *
+ * CPM SPI and QE buffer descriptors mode support:
+ * Copyright (c) 2009  MontaVista Software, Inc.
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/of_platform.h>
+#include <linux/of_spi.h>
+#include <sysdev/fsl_soc.h>
+
+#include "spi_fsl_lib.h"
+
+#define MPC8XXX_SPI_RX_BUF(type) 					  \
+void mpc8xxx_spi_rx_buf_##type(u32 data, struct mpc8xxx_spi *mpc8xxx_spi) \
+{									  \
+	type *rx = mpc8xxx_spi->rx;					  \
+	*rx++ = (type)(data >> mpc8xxx_spi->rx_shift);			  \
+	mpc8xxx_spi->rx = rx;						  \
+}
+
+#define MPC8XXX_SPI_TX_BUF(type)				\
+u32 mpc8xxx_spi_tx_buf_##type(struct mpc8xxx_spi *mpc8xxx_spi)	\
+{								\
+	u32 data;						\
+	const type *tx = mpc8xxx_spi->tx;			\
+	if (!tx)						\
+		return 0;					\
+	data = *tx++ << mpc8xxx_spi->tx_shift;			\
+	mpc8xxx_spi->tx = tx;					\
+	return data;						\
+}
+
+MPC8XXX_SPI_RX_BUF(u8)
+MPC8XXX_SPI_RX_BUF(u16)
+MPC8XXX_SPI_RX_BUF(u32)
+MPC8XXX_SPI_TX_BUF(u8)
+MPC8XXX_SPI_TX_BUF(u16)
+MPC8XXX_SPI_TX_BUF(u32)
+
+struct mpc8xxx_spi_probe_info *to_of_pinfo(struct fsl_spi_platform_data *pdata)
+{
+	return container_of(pdata, struct mpc8xxx_spi_probe_info, pdata);
+}
+
+void mpc8xxx_spi_work(struct work_struct *work)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi = container_of(work, struct mpc8xxx_spi,
+						       work);
+
+	spin_lock_irq(&mpc8xxx_spi->lock);
+	while (!list_empty(&mpc8xxx_spi->queue)) {
+		struct spi_message *m = container_of(mpc8xxx_spi->queue.next,
+						   struct spi_message, queue);
+
+		list_del_init(&m->queue);
+		spin_unlock_irq(&mpc8xxx_spi->lock);
+
+		if (mpc8xxx_spi->spi_do_one_msg)
+			mpc8xxx_spi->spi_do_one_msg(m);
+
+		spin_lock_irq(&mpc8xxx_spi->lock);
+	}
+	spin_unlock_irq(&mpc8xxx_spi->lock);
+}
+
+int mpc8xxx_spi_transfer(struct spi_device *spi,
+				struct spi_message *m)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+
+	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
+	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
+	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
+	spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
+
+	return 0;
+}
+
+void mpc8xxx_spi_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+const char *mpc8xxx_spi_strmode(unsigned int flags)
+{
+	if (flags & SPI_QE_CPU_MODE) {
+		return "QE CPU";
+	} else if (flags & SPI_CPM_MODE) {
+		if (flags & SPI_QE)
+			return "QE";
+		else if (flags & SPI_CPM2)
+			return "CPM2";
+		else
+			return "CPM1";
+	}
+	return "CPU";
+}
+
+int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
+			unsigned int irq)
+{
+	struct fsl_spi_platform_data *pdata = dev->platform_data;
+	struct spi_master *master;
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	int ret = 0;
+
+	master = dev_get_drvdata(dev);
+
+	/* the spi->mode bits understood by this driver: */
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
+			| SPI_LSB_FIRST | SPI_LOOP;
+
+	master->transfer = mpc8xxx_spi_transfer;
+	master->cleanup = mpc8xxx_spi_cleanup;
+	master->dev.of_node = dev->of_node;
+
+	mpc8xxx_spi = spi_master_get_devdata(master);
+	mpc8xxx_spi->dev = dev;
+	mpc8xxx_spi->get_rx = mpc8xxx_spi_rx_buf_u8;
+	mpc8xxx_spi->get_tx = mpc8xxx_spi_tx_buf_u8;
+	mpc8xxx_spi->flags = pdata->flags;
+	mpc8xxx_spi->spibrg = pdata->sysclk;
+	mpc8xxx_spi->irq = irq;
+
+	mpc8xxx_spi->rx_shift = 0;
+	mpc8xxx_spi->tx_shift = 0;
+
+	init_completion(&mpc8xxx_spi->done);
+
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->max_chipselect;
+
+	spin_lock_init(&mpc8xxx_spi->lock);
+	init_completion(&mpc8xxx_spi->done);
+	INIT_WORK(&mpc8xxx_spi->work, mpc8xxx_spi_work);
+	INIT_LIST_HEAD(&mpc8xxx_spi->queue);
+
+	mpc8xxx_spi->workqueue = create_singlethread_workqueue(
+		dev_name(master->dev.parent));
+	if (mpc8xxx_spi->workqueue == NULL) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+
+int __devexit mpc8xxx_spi_remove(struct device *dev)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct spi_master *master;
+
+	master = dev_get_drvdata(dev);
+	mpc8xxx_spi = spi_master_get_devdata(master);
+
+	flush_workqueue(mpc8xxx_spi->workqueue);
+	destroy_workqueue(mpc8xxx_spi->workqueue);
+	spi_unregister_master(master);
+
+	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
+
+	if (mpc8xxx_spi->spi_remove)
+		mpc8xxx_spi->spi_remove(mpc8xxx_spi);
+
+	return 0;
+}
+
+int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev,
+					const struct of_device_id *ofid)
+{
+	struct device *dev = &ofdev->dev;
+	struct device_node *np = ofdev->dev.of_node;
+	struct mpc8xxx_spi_probe_info *pinfo;
+	struct fsl_spi_platform_data *pdata;
+	const void *prop;
+	int ret = -ENOMEM;
+
+	pinfo = kzalloc(sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	pdata = &pinfo->pdata;
+	dev->platform_data = pdata;
+
+	/* Allocate bus num dynamically. */
+	pdata->bus_num = -1;
+
+	/* SPI controller is either clocked from QE or SoC clock. */
+	pdata->sysclk = get_brgfreq();
+	if (pdata->sysclk == -1) {
+		pdata->sysclk = fsl_get_sys_freq();
+		if (pdata->sysclk == -1) {
+			ret = -ENODEV;
+			goto err;
+		}
+	}
+
+	prop = of_get_property(np, "mode", NULL);
+	if (prop && !strcmp(prop, "cpu-qe"))
+		pdata->flags = SPI_QE_CPU_MODE;
+	else if (prop && !strcmp(prop, "qe"))
+		pdata->flags = SPI_CPM_MODE | SPI_QE;
+	else if (of_device_is_compatible(np, "fsl,cpm2-spi"))
+		pdata->flags = SPI_CPM_MODE | SPI_CPM2;
+	else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
+		pdata->flags = SPI_CPM_MODE | SPI_CPM1;
+
+	return 0;
+
+err:
+	kfree(pinfo);
+	return ret;
+}
diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
new file mode 100644
index 0000000..6ae8949
--- /dev/null
+++ b/drivers/spi/spi_fsl_lib.h
@@ -0,0 +1,119 @@
+/*
+ * Freescale SPI/eSPI controller driver library.
+ *
+ * Maintainer: Kumar Gala
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ * Copyright (C) 2006 Polycom, Inc.
+ *
+ * CPM SPI and QE buffer descriptors mode support:
+ * Copyright (c) 2009  MontaVista Software, Inc.
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __SPI_FSL_LIB_H__
+#define __SPI_FSL_LIB_H__
+
+/* SPI/eSPI Controller driver's private data. */
+struct mpc8xxx_spi {
+	struct device *dev;
+	void *reg_base;
+
+	/* rx & tx bufs from the spi_transfer */
+	const void *tx;
+	void *rx;
+
+	int subblock;
+	struct spi_pram __iomem *pram;
+	struct cpm_buf_desc __iomem *tx_bd;
+	struct cpm_buf_desc __iomem *rx_bd;
+
+	struct spi_transfer *xfer_in_progress;
+
+	/* dma addresses for CPM transfers */
+	dma_addr_t tx_dma;
+	dma_addr_t rx_dma;
+	bool map_tx_dma;
+	bool map_rx_dma;
+
+	dma_addr_t dma_dummy_tx;
+	dma_addr_t dma_dummy_rx;
+
+	/* functions to deal with different sized buffers */
+	void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
+	u32(*get_tx) (struct mpc8xxx_spi *);
+
+	/* hooks for different controller driver */
+	void (*spi_do_one_msg) (struct spi_message *m);
+	void (*spi_remove) (struct mpc8xxx_spi *mspi);
+
+	unsigned int count;
+	unsigned int irq;
+
+	unsigned nsecs;		/* (clock cycle time)/2 */
+
+	u32 spibrg;		/* SPIBRG input clock */
+	u32 rx_shift;		/* RX data reg shift when in qe mode */
+	u32 tx_shift;		/* TX data reg shift when in qe mode */
+
+	unsigned int flags;
+
+	struct workqueue_struct *workqueue;
+	struct work_struct work;
+
+	struct list_head queue;
+	spinlock_t lock;
+
+	struct completion done;
+};
+
+struct spi_mpc8xxx_cs {
+	/* functions to deal with different sized buffers */
+	void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
+	u32 (*get_tx) (struct mpc8xxx_spi *);
+	u32 rx_shift;		/* RX data reg shift when in qe mode */
+	u32 tx_shift;		/* TX data reg shift when in qe mode */
+	u32 hw_mode;		/* Holds HW mode register settings */
+};
+
+static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
+{
+	out_be32(reg, val);
+}
+
+static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *reg)
+{
+	return in_be32(reg);
+}
+
+struct mpc8xxx_spi_probe_info {
+	struct fsl_spi_platform_data pdata;
+	int *gpios;
+	bool *alow_flags;
+};
+
+extern u32 mpc8xxx_spi_tx_buf_u8(struct mpc8xxx_spi *mpc8xxx_spi);
+extern u32 mpc8xxx_spi_tx_buf_u16(struct mpc8xxx_spi *mpc8xxx_spi);
+extern u32 mpc8xxx_spi_tx_buf_u32(struct mpc8xxx_spi *mpc8xxx_spi);
+extern void mpc8xxx_spi_rx_buf_u8(u32 data, struct mpc8xxx_spi *mpc8xxx_spi);
+extern void mpc8xxx_spi_rx_buf_u16(u32 data, struct mpc8xxx_spi *mpc8xxx_spi);
+extern void mpc8xxx_spi_rx_buf_u32(u32 data, struct mpc8xxx_spi *mpc8xxx_spi);
+
+extern struct mpc8xxx_spi_probe_info *to_of_pinfo(
+		struct fsl_spi_platform_data *pdata);
+extern int mpc8xxx_spi_bufs(struct mpc8xxx_spi *mspi,
+		struct spi_transfer *t, unsigned int len);
+extern int mpc8xxx_spi_transfer(struct spi_device *spi, struct spi_message *m);
+extern void mpc8xxx_spi_cleanup(struct spi_device *spi);
+extern const char *mpc8xxx_spi_strmode(unsigned int flags);
+extern int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
+		unsigned int irq);
+extern int mpc8xxx_spi_remove(struct device *dev);
+extern int of_mpc8xxx_spi_probe(struct platform_device *ofdev,
+				const struct of_device_id *ofid);
+
+#endif /* __SPI_FSL_LIB_H__ */
diff --git a/drivers/spi/spi_fsl_spi.c b/drivers/spi/spi_fsl_spi.c
index d31b57f..c662e7e 100644
--- a/drivers/spi/spi_fsl_spi.c
+++ b/drivers/spi/spi_fsl_spi.c
@@ -1,9 +1,10 @@
 /*
- * MPC8xxx SPI controller driver.
+ * Freescale SPI controller driver.
  *
  * Maintainer: Kumar Gala
  *
  * Copyright (C) 2006 Polycom, Inc.
+ * Copyright 2010 Freescale Semiconductor, Inc.
  *
  * CPM SPI and QE buffer descriptors mode support:
  * Copyright (c) 2009  MontaVista Software, Inc.
@@ -15,18 +16,11 @@
  * option) any later version.
  */
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/bug.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/platform_device.h>
@@ -38,12 +32,12 @@
 #include <linux/of_platform.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
-#include <linux/slab.h>
 
 #include <sysdev/fsl_soc.h>
 #include <asm/cpm.h>
 #include <asm/qe.h>
-#include <asm/irq.h>
+
+#include "spi_fsl_lib.h"
 
 /* CPM1 and CPM2 are mutually exclusive. */
 #ifdef CONFIG_CPM1
@@ -55,7 +49,7 @@
 #endif
 
 /* SPI Controller registers */
-struct mpc8xxx_spi_reg {
+struct fsl_spi_reg {
 	u8 res1[0x20];
 	__be32 mode;
 	__be32 event;
@@ -80,7 +74,7 @@ struct mpc8xxx_spi_reg {
 
 /*
  * Default for SPI Mode:
- * 	SPI MODE 0 (inactive low, phase middle, MSB, 8-bit length, slow clk
+ *	SPI MODE 0 (inactive low, phase middle, MSB, 8-bit length, slow clk
  */
 #define	SPMODE_INIT_VAL (SPMODE_CI_INACTIVEHIGH | SPMODE_DIV16 | SPMODE_REV | \
 			 SPMODE_MS | SPMODE_LEN(7) | SPMODE_PM(0xf))
@@ -102,112 +96,16 @@ struct mpc8xxx_spi_reg {
 #define	SPI_PRAM_SIZE	0x100
 #define	SPI_MRBLR	((unsigned int)PAGE_SIZE)
 
-/* SPI Controller driver's private data. */
-struct mpc8xxx_spi {
-	struct device *dev;
-	struct mpc8xxx_spi_reg __iomem *base;
-
-	/* rx & tx bufs from the spi_transfer */
-	const void *tx;
-	void *rx;
-
-	int subblock;
-	struct spi_pram __iomem *pram;
-	struct cpm_buf_desc __iomem *tx_bd;
-	struct cpm_buf_desc __iomem *rx_bd;
-
-	struct spi_transfer *xfer_in_progress;
-
-	/* dma addresses for CPM transfers */
-	dma_addr_t tx_dma;
-	dma_addr_t rx_dma;
-	bool map_tx_dma;
-	bool map_rx_dma;
-
-	dma_addr_t dma_dummy_tx;
-	dma_addr_t dma_dummy_rx;
-
-	/* functions to deal with different sized buffers */
-	void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
-	u32(*get_tx) (struct mpc8xxx_spi *);
-
-	unsigned int count;
-	unsigned int irq;
-
-	unsigned nsecs;		/* (clock cycle time)/2 */
-
-	u32 spibrg;		/* SPIBRG input clock */
-	u32 rx_shift;		/* RX data reg shift when in qe mode */
-	u32 tx_shift;		/* TX data reg shift when in qe mode */
-
-	unsigned int flags;
-
-	struct workqueue_struct *workqueue;
-	struct work_struct work;
-
-	struct list_head queue;
-	spinlock_t lock;
-
-	struct completion done;
-};
-
-static void *mpc8xxx_dummy_rx;
-static DEFINE_MUTEX(mpc8xxx_dummy_rx_lock);
-static int mpc8xxx_dummy_rx_refcnt;
-
-struct spi_mpc8xxx_cs {
-	/* functions to deal with different sized buffers */
-	void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
-	u32 (*get_tx) (struct mpc8xxx_spi *);
-	u32 rx_shift;		/* RX data reg shift when in qe mode */
-	u32 tx_shift;		/* TX data reg shift when in qe mode */
-	u32 hw_mode;		/* Holds HW mode register settings */
-};
-
-static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
-{
-	out_be32(reg, val);
-}
-
-static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *reg)
-{
-	return in_be32(reg);
-}
-
-#define MPC83XX_SPI_RX_BUF(type) 					  \
-static									  \
-void mpc8xxx_spi_rx_buf_##type(u32 data, struct mpc8xxx_spi *mpc8xxx_spi) \
-{									  \
-	type *rx = mpc8xxx_spi->rx;					  \
-	*rx++ = (type)(data >> mpc8xxx_spi->rx_shift);			  \
-	mpc8xxx_spi->rx = rx;						  \
-}
-
-#define MPC83XX_SPI_TX_BUF(type)				\
-static								\
-u32 mpc8xxx_spi_tx_buf_##type(struct mpc8xxx_spi *mpc8xxx_spi)	\
-{								\
-	u32 data;						\
-	const type *tx = mpc8xxx_spi->tx;			\
-	if (!tx)						\
-		return 0;					\
-	data = *tx++ << mpc8xxx_spi->tx_shift;			\
-	mpc8xxx_spi->tx = tx;					\
-	return data;						\
-}
+static void *fsl_dummy_rx;
+static DEFINE_MUTEX(fsl_dummy_rx_lock);
+static int fsl_dummy_rx_refcnt;
 
-MPC83XX_SPI_RX_BUF(u8)
-MPC83XX_SPI_RX_BUF(u16)
-MPC83XX_SPI_RX_BUF(u32)
-MPC83XX_SPI_TX_BUF(u8)
-MPC83XX_SPI_TX_BUF(u16)
-MPC83XX_SPI_TX_BUF(u32)
-
-static void mpc8xxx_spi_change_mode(struct spi_device *spi)
+static void fsl_spi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
-	__be32 __iomem *mode = &mspi->base->mode;
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
+	__be32 __iomem *mode = &reg_base->mode;
 	unsigned long flags;
 
 	if (cs->hw_mode == mpc8xxx_spi_read_reg(mode))
@@ -238,7 +136,7 @@ static void mpc8xxx_spi_change_mode(struct spi_device *spi)
 	local_irq_restore(flags);
 }
 
-static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
+static void fsl_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	struct fsl_spi_platform_data *pdata = spi->dev.parent->platform_data;
@@ -256,18 +154,17 @@ static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 		mpc8xxx_spi->get_rx = cs->get_rx;
 		mpc8xxx_spi->get_tx = cs->get_tx;
 
-		mpc8xxx_spi_change_mode(spi);
+		fsl_spi_change_mode(spi);
 
 		if (pdata->cs_control)
 			pdata->cs_control(spi, pol);
 	}
 }
 
-static int
-mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
-			   struct spi_device *spi,
-			   struct mpc8xxx_spi *mpc8xxx_spi,
-			   int bits_per_word)
+static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
+				struct spi_device *spi,
+				struct mpc8xxx_spi *mpc8xxx_spi,
+				int bits_per_word)
 {
 	cs->rx_shift = 0;
 	cs->tx_shift = 0;
@@ -307,10 +204,9 @@ mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static int
-mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-			  struct spi_device *spi,
-			  int bits_per_word)
+static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
+				struct spi_device *spi,
+				int bits_per_word)
 {
 	/* QE uses Little Endian for words > 8
 	 * so transform all words > 8 into 8 bits
@@ -326,13 +222,13 @@ mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static
-int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+static int fsl_spi_setup_transfer(struct spi_device *spi,
+					struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	int bits_per_word;
+	int bits_per_word = 0;
 	u8 pm;
-	u32 hz;
+	u32 hz = 0;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
 
 	mpc8xxx_spi = spi_master_get_devdata(spi->master);
@@ -340,9 +236,6 @@ int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (t) {
 		bits_per_word = t->bits_per_word;
 		hz = t->speed_hz;
-	} else {
-		bits_per_word = 0;
-		hz = 0;
 	}
 
 	/* spi_transfer level calls that work per-word */
@@ -388,23 +281,25 @@ int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 			  hz, mpc8xxx_spi->spibrg / 1024);
 		if (pm > 16)
 			pm = 16;
-	} else
+	} else {
 		pm = (mpc8xxx_spi->spibrg - 1) / (hz * 4) + 1;
+	}
 	if (pm)
 		pm--;
 
 	cs->hw_mode |= SPMODE_PM(pm);
 
-	mpc8xxx_spi_change_mode(spi);
+	fsl_spi_change_mode(spi);
 	return 0;
 }
 
-static void mpc8xxx_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
+static void fsl_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
 {
 	struct cpm_buf_desc __iomem *tx_bd = mspi->tx_bd;
 	struct cpm_buf_desc __iomem *rx_bd = mspi->rx_bd;
 	unsigned int xfer_len = min(mspi->count, SPI_MRBLR);
 	unsigned int xfer_ofs;
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
 
 	xfer_ofs = mspi->xfer_in_progress->len - mspi->count;
 
@@ -418,13 +313,14 @@ static void mpc8xxx_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
 				 BD_SC_LAST);
 
 	/* start transfer */
-	mpc8xxx_spi_write_reg(&mspi->base->command, SPCOM_STR);
+	mpc8xxx_spi_write_reg(&reg_base->command, SPCOM_STR);
 }
 
-static int mpc8xxx_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
+static int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 				struct spi_transfer *t, bool is_dma_mapped)
 {
 	struct device *dev = mspi->dev;
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
 
 	if (is_dma_mapped) {
 		mspi->map_tx_dma = 0;
@@ -469,13 +365,13 @@ static int mpc8xxx_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 	}
 
 	/* enable rx ints */
-	mpc8xxx_spi_write_reg(&mspi->base->mask, SPIE_RXB);
+	mpc8xxx_spi_write_reg(&reg_base->mask, SPIE_RXB);
 
 	mspi->xfer_in_progress = t;
 	mspi->count = t->len;
 
 	/* start CPM transfers */
-	mpc8xxx_spi_cpm_bufs_start(mspi);
+	fsl_spi_cpm_bufs_start(mspi);
 
 	return 0;
 
@@ -485,7 +381,7 @@ err_rx_dma:
 	return -ENOMEM;
 }
 
-static void mpc8xxx_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
+static void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 {
 	struct device *dev = mspi->dev;
 	struct spi_transfer *t = mspi->xfer_in_progress;
@@ -497,31 +393,34 @@ static void mpc8xxx_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 	mspi->xfer_in_progress = NULL;
 }
 
-static int mpc8xxx_spi_cpu_bufs(struct mpc8xxx_spi *mspi,
+static int fsl_spi_cpu_bufs(struct mpc8xxx_spi *mspi,
 				struct spi_transfer *t, unsigned int len)
 {
 	u32 word;
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
 
 	mspi->count = len;
 
 	/* enable rx ints */
-	mpc8xxx_spi_write_reg(&mspi->base->mask, SPIM_NE);
+	mpc8xxx_spi_write_reg(&reg_base->mask, SPIM_NE);
 
 	/* transmit word */
 	word = mspi->get_tx(mspi);
-	mpc8xxx_spi_write_reg(&mspi->base->transmit, word);
+	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
 
 	return 0;
 }
 
-static int mpc8xxx_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
+static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 			    bool is_dma_mapped)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct fsl_spi_reg *reg_base;
 	unsigned int len = t->len;
 	u8 bits_per_word;
 	int ret;
 
+	reg_base = (struct fsl_spi_reg *)&mpc8xxx_spi->reg_base;
 	bits_per_word = spi->bits_per_word;
 	if (t->bits_per_word)
 		bits_per_word = t->bits_per_word;
@@ -545,24 +444,24 @@ static int mpc8xxx_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 	INIT_COMPLETION(mpc8xxx_spi->done);
 
 	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
-		ret = mpc8xxx_spi_cpm_bufs(mpc8xxx_spi, t, is_dma_mapped);
+		ret = fsl_spi_cpm_bufs(mpc8xxx_spi, t, is_dma_mapped);
 	else
-		ret = mpc8xxx_spi_cpu_bufs(mpc8xxx_spi, t, len);
+		ret = fsl_spi_cpu_bufs(mpc8xxx_spi, t, len);
 	if (ret)
 		return ret;
 
 	wait_for_completion(&mpc8xxx_spi->done);
 
 	/* disable rx ints */
-	mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mask, 0);
+	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
 
 	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
-		mpc8xxx_spi_cpm_bufs_complete(mpc8xxx_spi);
+		fsl_spi_cpm_bufs_complete(mpc8xxx_spi);
 
 	return mpc8xxx_spi->count;
 }
 
-static void mpc8xxx_spi_do_one_msg(struct spi_message *m)
+static void fsl_spi_do_one_msg(struct spi_message *m)
 {
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
@@ -578,18 +477,18 @@ static void mpc8xxx_spi_do_one_msg(struct spi_message *m)
 			status = -EINVAL;
 
 			if (cs_change)
-				status = mpc8xxx_spi_setup_transfer(spi, t);
+				status = fsl_spi_setup_transfer(spi, t);
 			if (status < 0)
 				break;
 		}
 
 		if (cs_change) {
-			mpc8xxx_spi_chipselect(spi, BITBANG_CS_ACTIVE);
+			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
 			ndelay(nsecs);
 		}
 		cs_change = t->cs_change;
 		if (t->len)
-			status = mpc8xxx_spi_bufs(spi, t, m->is_dma_mapped);
+			status = fsl_spi_bufs(spi, t, m->is_dma_mapped);
 		if (status) {
 			status = -EMSGSIZE;
 			break;
@@ -601,7 +500,7 @@ static void mpc8xxx_spi_do_one_msg(struct spi_message *m)
 
 		if (cs_change) {
 			ndelay(nsecs);
-			mpc8xxx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+			fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
 			ndelay(nsecs);
 		}
 	}
@@ -611,35 +510,16 @@ static void mpc8xxx_spi_do_one_msg(struct spi_message *m)
 
 	if (status || !cs_change) {
 		ndelay(nsecs);
-		mpc8xxx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
+		fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
 	}
 
-	mpc8xxx_spi_setup_transfer(spi, NULL);
-}
-
-static void mpc8xxx_spi_work(struct work_struct *work)
-{
-	struct mpc8xxx_spi *mpc8xxx_spi = container_of(work, struct mpc8xxx_spi,
-						       work);
-
-	spin_lock_irq(&mpc8xxx_spi->lock);
-	while (!list_empty(&mpc8xxx_spi->queue)) {
-		struct spi_message *m = container_of(mpc8xxx_spi->queue.next,
-						   struct spi_message, queue);
-
-		list_del_init(&m->queue);
-		spin_unlock_irq(&mpc8xxx_spi->lock);
-
-		mpc8xxx_spi_do_one_msg(m);
-
-		spin_lock_irq(&mpc8xxx_spi->lock);
-	}
-	spin_unlock_irq(&mpc8xxx_spi->lock);
+	fsl_spi_setup_transfer(spi, NULL);
 }
 
-static int mpc8xxx_spi_setup(struct spi_device *spi)
+static int fsl_spi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_spi_reg *reg_base;
 	int retval;
 	u32 hw_mode;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
@@ -655,8 +535,10 @@ static int mpc8xxx_spi_setup(struct spi_device *spi)
 	}
 	mpc8xxx_spi = spi_master_get_devdata(spi->master);
 
+	reg_base = (struct fsl_spi_reg *)&mpc8xxx_spi->reg_base;
+
 	hw_mode = cs->hw_mode; /* Save original settings */
-	cs->hw_mode = mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->mode);
+	cs->hw_mode = mpc8xxx_spi_read_reg(&reg_base->mode);
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INACTIVEHIGH
 			 | SPMODE_REV | SPMODE_LOOP);
@@ -670,7 +552,7 @@ static int mpc8xxx_spi_setup(struct spi_device *spi)
 	if (spi->mode & SPI_LOOP)
 		cs->hw_mode |= SPMODE_LOOP;
 
-	retval = mpc8xxx_spi_setup_transfer(spi, NULL);
+	retval = fsl_spi_setup_transfer(spi, NULL);
 	if (retval < 0) {
 		cs->hw_mode = hw_mode; /* Restore settings */
 		return retval;
@@ -678,9 +560,10 @@ static int mpc8xxx_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void mpc8xxx_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events)
+static void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
 	u16 len;
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
 
 	dev_dbg(mspi->dev, "%s: bd datlen %d, count %d\n", __func__,
 		in_be16(&mspi->rx_bd->cbd_datlen), mspi->count);
@@ -692,20 +575,22 @@ static void mpc8xxx_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events)
 	}
 
 	/* Clear the events */
-	mpc8xxx_spi_write_reg(&mspi->base->event, events);
+	mpc8xxx_spi_write_reg(&reg_base->event, events);
 
 	mspi->count -= len;
 	if (mspi->count)
-		mpc8xxx_spi_cpm_bufs_start(mspi);
+		fsl_spi_cpm_bufs_start(mspi);
 	else
 		complete(&mspi->done);
 }
 
-static void mpc8xxx_spi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
+static void fsl_spi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
+
 	/* We need handle RX first */
 	if (events & SPIE_NE) {
-		u32 rx_data = mpc8xxx_spi_read_reg(&mspi->base->receive);
+		u32 rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
 
 		if (mspi->rx)
 			mspi->get_rx(rx_data, mspi);
@@ -714,102 +599,80 @@ static void mpc8xxx_spi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if ((events & SPIE_NF) == 0)
 		/* spin until TX is done */
 		while (((events =
-			mpc8xxx_spi_read_reg(&mspi->base->event)) &
+			mpc8xxx_spi_read_reg(&reg_base->event)) &
 						SPIE_NF) == 0)
 			cpu_relax();
 
 	/* Clear the events */
-	mpc8xxx_spi_write_reg(&mspi->base->event, events);
+	mpc8xxx_spi_write_reg(&reg_base->event, events);
 
 	mspi->count -= 1;
 	if (mspi->count) {
 		u32 word = mspi->get_tx(mspi);
 
-		mpc8xxx_spi_write_reg(&mspi->base->transmit, word);
+		mpc8xxx_spi_write_reg(&reg_base->transmit, word);
 	} else {
 		complete(&mspi->done);
 	}
 }
 
-static irqreturn_t mpc8xxx_spi_irq(s32 irq, void *context_data)
+static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 {
 	struct mpc8xxx_spi *mspi = context_data;
 	irqreturn_t ret = IRQ_NONE;
 	u32 events;
+	struct fsl_spi_reg *reg_base = (struct fsl_spi_reg *)mspi->reg_base;
 
 	/* Get interrupt events(tx/rx) */
-	events = mpc8xxx_spi_read_reg(&mspi->base->event);
+	events = mpc8xxx_spi_read_reg(&reg_base->event);
 	if (events)
 		ret = IRQ_HANDLED;
 
 	dev_dbg(mspi->dev, "%s: events %x\n", __func__, events);
 
 	if (mspi->flags & SPI_CPM_MODE)
-		mpc8xxx_spi_cpm_irq(mspi, events);
+		fsl_spi_cpm_irq(mspi, events);
 	else
-		mpc8xxx_spi_cpu_irq(mspi, events);
+		fsl_spi_cpu_irq(mspi, events);
 
 	return ret;
 }
 
-static int mpc8xxx_spi_transfer(struct spi_device *spi,
-				struct spi_message *m)
+static void *fsl_spi_alloc_dummy_rx(void)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	unsigned long flags;
+	mutex_lock(&fsl_dummy_rx_lock);
 
-	m->actual_length = 0;
-	m->status = -EINPROGRESS;
+	if (!fsl_dummy_rx)
+		fsl_dummy_rx = kmalloc(SPI_MRBLR, GFP_KERNEL);
+	if (fsl_dummy_rx)
+		fsl_dummy_rx_refcnt++;
 
-	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
-	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
-	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
-	spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
+	mutex_unlock(&fsl_dummy_rx_lock);
 
-	return 0;
+	return fsl_dummy_rx;
 }
 
-
-static void mpc8xxx_spi_cleanup(struct spi_device *spi)
+static void fsl_spi_free_dummy_rx(void)
 {
-	kfree(spi->controller_state);
-}
+	mutex_lock(&fsl_dummy_rx_lock);
 
-static void *mpc8xxx_spi_alloc_dummy_rx(void)
-{
-	mutex_lock(&mpc8xxx_dummy_rx_lock);
-
-	if (!mpc8xxx_dummy_rx)
-		mpc8xxx_dummy_rx = kmalloc(SPI_MRBLR, GFP_KERNEL);
-	if (mpc8xxx_dummy_rx)
-		mpc8xxx_dummy_rx_refcnt++;
-
-	mutex_unlock(&mpc8xxx_dummy_rx_lock);
-
-	return mpc8xxx_dummy_rx;
-}
-
-static void mpc8xxx_spi_free_dummy_rx(void)
-{
-	mutex_lock(&mpc8xxx_dummy_rx_lock);
-
-	switch (mpc8xxx_dummy_rx_refcnt) {
+	switch (fsl_dummy_rx_refcnt) {
 	case 0:
 		WARN_ON(1);
 		break;
 	case 1:
-		kfree(mpc8xxx_dummy_rx);
-		mpc8xxx_dummy_rx = NULL;
+		kfree(fsl_dummy_rx);
+		fsl_dummy_rx = NULL;
 		/* fall through */
 	default:
-		mpc8xxx_dummy_rx_refcnt--;
+		fsl_dummy_rx_refcnt--;
 		break;
 	}
 
-	mutex_unlock(&mpc8xxx_dummy_rx_lock);
+	mutex_unlock(&fsl_dummy_rx_lock);
 }
 
-static unsigned long mpc8xxx_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
+static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 {
 	struct device *dev = mspi->dev;
 	struct device_node *np = dev->of_node;
@@ -863,7 +726,7 @@ static unsigned long mpc8xxx_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 	return pram_ofs;
 }
 
-static int mpc8xxx_spi_cpm_init(struct mpc8xxx_spi *mspi)
+static int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 {
 	struct device *dev = mspi->dev;
 	struct device_node *np = dev->of_node;
@@ -875,7 +738,7 @@ static int mpc8xxx_spi_cpm_init(struct mpc8xxx_spi *mspi)
 	if (!(mspi->flags & SPI_CPM_MODE))
 		return 0;
 
-	if (!mpc8xxx_spi_alloc_dummy_rx())
+	if (!fsl_spi_alloc_dummy_rx())
 		return -ENOMEM;
 
 	if (mspi->flags & SPI_QE) {
@@ -896,7 +759,7 @@ static int mpc8xxx_spi_cpm_init(struct mpc8xxx_spi *mspi)
 		}
 	}
 
-	pram_ofs = mpc8xxx_spi_cpm_get_pram(mspi);
+	pram_ofs = fsl_spi_cpm_get_pram(mspi);
 	if (IS_ERR_VALUE(pram_ofs)) {
 		dev_err(dev, "can't allocate spi parameter ram\n");
 		goto err_pram;
@@ -916,7 +779,7 @@ static int mpc8xxx_spi_cpm_init(struct mpc8xxx_spi *mspi)
 		goto err_dummy_tx;
 	}
 
-	mspi->dma_dummy_rx = dma_map_single(dev, mpc8xxx_dummy_rx, SPI_MRBLR,
+	mspi->dma_dummy_rx = dma_map_single(dev, fsl_dummy_rx, SPI_MRBLR,
 					    DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, mspi->dma_dummy_rx)) {
 		dev_err(dev, "unable to map dummy rx buffer\n");
@@ -954,11 +817,11 @@ err_dummy_tx:
 err_bds:
 	cpm_muram_free(pram_ofs);
 err_pram:
-	mpc8xxx_spi_free_dummy_rx();
+	fsl_spi_free_dummy_rx();
 	return -ENOMEM;
 }
 
-static void mpc8xxx_spi_cpm_free(struct mpc8xxx_spi *mspi)
+static void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
 {
 	struct device *dev = mspi->dev;
 
@@ -966,30 +829,22 @@ static void mpc8xxx_spi_cpm_free(struct mpc8xxx_spi *mspi)
 	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
 	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
 	cpm_muram_free(cpm_muram_offset(mspi->pram));
-	mpc8xxx_spi_free_dummy_rx();
+	fsl_spi_free_dummy_rx();
 }
 
-static const char *mpc8xxx_spi_strmode(unsigned int flags)
+static void fsl_spi_remove(struct mpc8xxx_spi *mspi)
 {
-	if (flags & SPI_QE_CPU_MODE) {
-		return "QE CPU";
-	} else if (flags & SPI_CPM_MODE) {
-		if (flags & SPI_QE)
-			return "QE";
-		else if (flags & SPI_CPM2)
-			return "CPM2";
-		else
-			return "CPM1";
-	}
-	return "CPU";
+	iounmap(mspi->reg_base);
+	fsl_spi_cpm_free(mspi);
 }
 
-static struct spi_master * __devinit
-mpc8xxx_spi_probe(struct device *dev, struct resource *mem, unsigned int irq)
+static struct spi_master * __devinit fsl_spi_probe(struct device *dev,
+		struct resource *mem, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_spi_reg *reg_base;
 	u32 regval;
 	int ret = 0;
 
@@ -1001,132 +856,77 @@ mpc8xxx_spi_probe(struct device *dev, struct resource *mem, unsigned int irq)
 
 	dev_set_drvdata(dev, master);
 
-	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
-			| SPI_LSB_FIRST | SPI_LOOP;
+	ret = mpc8xxx_spi_probe(dev, mem, irq);
+	if (ret)
+		goto err_probe;
 
-	master->setup = mpc8xxx_spi_setup;
-	master->transfer = mpc8xxx_spi_transfer;
-	master->cleanup = mpc8xxx_spi_cleanup;
-	master->dev.of_node = dev->of_node;
+	master->setup = fsl_spi_setup;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	mpc8xxx_spi->dev = dev;
-	mpc8xxx_spi->get_rx = mpc8xxx_spi_rx_buf_u8;
-	mpc8xxx_spi->get_tx = mpc8xxx_spi_tx_buf_u8;
-	mpc8xxx_spi->flags = pdata->flags;
-	mpc8xxx_spi->spibrg = pdata->sysclk;
+	mpc8xxx_spi->spi_do_one_msg = fsl_spi_do_one_msg;
+	mpc8xxx_spi->spi_remove = fsl_spi_remove;
+
 
-	ret = mpc8xxx_spi_cpm_init(mpc8xxx_spi);
+	ret = fsl_spi_cpm_init(mpc8xxx_spi);
 	if (ret)
 		goto err_cpm_init;
 
-	mpc8xxx_spi->rx_shift = 0;
-	mpc8xxx_spi->tx_shift = 0;
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
 		mpc8xxx_spi->rx_shift = 16;
 		mpc8xxx_spi->tx_shift = 24;
 	}
 
-	init_completion(&mpc8xxx_spi->done);
-
-	mpc8xxx_spi->base = ioremap(mem->start, resource_size(mem));
-	if (mpc8xxx_spi->base == NULL) {
+	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
+	if (mpc8xxx_spi->reg_base == NULL) {
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
-	mpc8xxx_spi->irq = irq;
-
 	/* Register for SPI Interrupt */
-	ret = request_irq(mpc8xxx_spi->irq, mpc8xxx_spi_irq,
-			  0, "mpc8xxx_spi", mpc8xxx_spi);
+	ret = request_irq(mpc8xxx_spi->irq, fsl_spi_irq,
+			  0, "fsl_spi", mpc8xxx_spi);
 
 	if (ret != 0)
-		goto unmap_io;
+		goto free_irq;
 
-	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->max_chipselect;
+	reg_base = (struct fsl_spi_reg *)mpc8xxx_spi->reg_base;
 
 	/* SPI controller initializations */
-	mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mode, 0);
-	mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mask, 0);
-	mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->command, 0);
-	mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->event, 0xffffffff);
+	mpc8xxx_spi_write_reg(&reg_base->mode, 0);
+	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
+	mpc8xxx_spi_write_reg(&reg_base->command, 0);
+	mpc8xxx_spi_write_reg(&reg_base->event, 0xffffffff);
 
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
 		regval |= SPMODE_OP;
 
-	mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mode, regval);
-	spin_lock_init(&mpc8xxx_spi->lock);
-	init_completion(&mpc8xxx_spi->done);
-	INIT_WORK(&mpc8xxx_spi->work, mpc8xxx_spi_work);
-	INIT_LIST_HEAD(&mpc8xxx_spi->queue);
-
-	mpc8xxx_spi->workqueue = create_singlethread_workqueue(
-		dev_name(master->dev.parent));
-	if (mpc8xxx_spi->workqueue == NULL) {
-		ret = -EBUSY;
-		goto free_irq;
-	}
+	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
 	ret = spi_register_master(master);
 	if (ret < 0)
 		goto unreg_master;
 
-	dev_info(dev, "at 0x%p (irq = %d), %s mode\n", mpc8xxx_spi->base,
+	dev_info(dev, "at 0x%p (irq = %d), %s mode\n", reg_base,
 		 mpc8xxx_spi->irq, mpc8xxx_spi_strmode(mpc8xxx_spi->flags));
 
 	return master;
 
 unreg_master:
-	destroy_workqueue(mpc8xxx_spi->workqueue);
-free_irq:
 	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
-unmap_io:
-	iounmap(mpc8xxx_spi->base);
+free_irq:
+	iounmap(mpc8xxx_spi->reg_base);
 err_ioremap:
-	mpc8xxx_spi_cpm_free(mpc8xxx_spi);
+	fsl_spi_cpm_free(mpc8xxx_spi);
 err_cpm_init:
+err_probe:
 	spi_master_put(master);
 err:
 	return ERR_PTR(ret);
 }
 
-static int __devexit mpc8xxx_spi_remove(struct device *dev)
-{
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct spi_master *master;
-
-	master = dev_get_drvdata(dev);
-	mpc8xxx_spi = spi_master_get_devdata(master);
-
-	flush_workqueue(mpc8xxx_spi->workqueue);
-	destroy_workqueue(mpc8xxx_spi->workqueue);
-	spi_unregister_master(master);
-
-	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
-	iounmap(mpc8xxx_spi->base);
-	mpc8xxx_spi_cpm_free(mpc8xxx_spi);
-
-	return 0;
-}
-
-struct mpc8xxx_spi_probe_info {
-	struct fsl_spi_platform_data pdata;
-	int *gpios;
-	bool *alow_flags;
-};
-
-static struct mpc8xxx_spi_probe_info *
-to_of_pinfo(struct fsl_spi_platform_data *pdata)
-{
-	return container_of(pdata, struct mpc8xxx_spi_probe_info, pdata);
-}
-
-static void mpc8xxx_spi_cs_control(struct spi_device *spi, bool on)
+static void fsl_spi_cs_control(struct spi_device *spi, bool on)
 {
 	struct device *dev = spi->dev.parent;
 	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
@@ -1137,7 +937,7 @@ static void mpc8xxx_spi_cs_control(struct spi_device *spi, bool on)
 	gpio_set_value(gpio, on ^ alow);
 }
 
-static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
+static int of_fsl_spi_get_chipselects(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
@@ -1198,7 +998,7 @@ static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
 	}
 
 	pdata->max_chipselect = ngpios;
-	pdata->cs_control = mpc8xxx_spi_cs_control;
+	pdata->cs_control = fsl_spi_cs_control;
 
 	return 0;
 
@@ -1217,7 +1017,7 @@ err_alloc_flags:
 	return ret;
 }
 
-static int of_mpc8xxx_spi_free_chipselects(struct device *dev)
+static int of_fsl_spi_free_chipselects(struct device *dev)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
 	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
@@ -1236,50 +1036,21 @@ static int of_mpc8xxx_spi_free_chipselects(struct device *dev)
 	return 0;
 }
 
-static int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev,
-					  const struct of_device_id *ofid)
+static int __devinit of_fsl_spi_probe(struct platform_device *ofdev,
+					const struct of_device_id *ofid)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
-	struct mpc8xxx_spi_probe_info *pinfo;
-	struct fsl_spi_platform_data *pdata;
 	struct spi_master *master;
 	struct resource mem;
 	struct resource irq;
-	const void *prop;
 	int ret = -ENOMEM;
 
-	pinfo = kzalloc(sizeof(*pinfo), GFP_KERNEL);
-	if (!pinfo)
-		return -ENOMEM;
-
-	pdata = &pinfo->pdata;
-	dev->platform_data = pdata;
-
-	/* Allocate bus num dynamically. */
-	pdata->bus_num = -1;
-
-	/* SPI controller is either clocked from QE or SoC clock. */
-	pdata->sysclk = get_brgfreq();
-	if (pdata->sysclk == -1) {
-		pdata->sysclk = fsl_get_sys_freq();
-		if (pdata->sysclk == -1) {
-			ret = -ENODEV;
-			goto err_clk;
-		}
-	}
+	ret = of_mpc8xxx_spi_probe(ofdev, ofid);
+	if (ret)
+		return ret;
 
-	prop = of_get_property(np, "mode", NULL);
-	if (prop && !strcmp(prop, "cpu-qe"))
-		pdata->flags = SPI_QE_CPU_MODE;
-	else if (prop && !strcmp(prop, "qe"))
-		pdata->flags = SPI_CPM_MODE | SPI_QE;
-	else if (of_device_is_compatible(np, "fsl,cpm2-spi"))
-		pdata->flags = SPI_CPM_MODE | SPI_CPM2;
-	else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
-		pdata->flags = SPI_CPM_MODE | SPI_CPM1;
-
-	ret = of_mpc8xxx_spi_get_chipselects(dev);
+	ret = of_fsl_spi_get_chipselects(dev);
 	if (ret)
 		goto err;
 
@@ -1293,7 +1064,7 @@ static int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev,
 		goto err;
 	}
 
-	master = mpc8xxx_spi_probe(dev, &mem, irq.start);
+	master = fsl_spi_probe(dev, &mem, irq.start);
 	if (IS_ERR(master)) {
 		ret = PTR_ERR(master);
 		goto err;
@@ -1302,42 +1073,40 @@ static int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev,
 	return 0;
 
 err:
-	of_mpc8xxx_spi_free_chipselects(dev);
-err_clk:
-	kfree(pinfo);
+	of_fsl_spi_free_chipselects(dev);
 	return ret;
 }
 
-static int __devexit of_mpc8xxx_spi_remove(struct platform_device *ofdev)
+static int __devexit of_fsl_spi_remove(struct platform_device *ofdev)
 {
 	int ret;
 
 	ret = mpc8xxx_spi_remove(&ofdev->dev);
 	if (ret)
 		return ret;
-	of_mpc8xxx_spi_free_chipselects(&ofdev->dev);
+	of_fsl_spi_free_chipselects(&ofdev->dev);
 	return 0;
 }
 
-static const struct of_device_id of_mpc8xxx_spi_match[] = {
+static const struct of_device_id of_fsl_spi_match[] = {
 	{ .compatible = "fsl,spi" },
-	{},
+	{}
 };
-MODULE_DEVICE_TABLE(of, of_mpc8xxx_spi_match);
+MODULE_DEVICE_TABLE(of, of_fsl_spi_match);
 
-static struct of_platform_driver of_mpc8xxx_spi_driver = {
+static struct of_platform_driver of_fsl_spi_driver = {
 	.driver = {
-		.name = "mpc8xxx_spi",
+		.name = "fsl_spi",
 		.owner = THIS_MODULE,
-		.of_match_table = of_mpc8xxx_spi_match,
+		.of_match_table = of_fsl_spi_match,
 	},
-	.probe		= of_mpc8xxx_spi_probe,
-	.remove		= __devexit_p(of_mpc8xxx_spi_remove),
+	.probe		= of_fsl_spi_probe,
+	.remove		= __devexit_p(of_fsl_spi_remove),
 };
 
 #ifdef CONFIG_MPC832x_RDB
 /*
- * 				XXX XXX XXX
+ * XXX XXX XXX
  * This is "legacy" platform driver, was used by the MPC8323E-RDB boards
  * only. The driver should go away soon, since newer MPC8323E-RDB's device
  * tree can work with OpenFirmware driver. But for now we support old trees
@@ -1360,7 +1129,7 @@ static int __devinit plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -EINVAL;
 
-	master = mpc8xxx_spi_probe(&pdev->dev, mem, irq);
+	master = fsl_spi_probe(&pdev->dev, mem, irq);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
 	return 0;
@@ -1399,21 +1168,20 @@ static void __init legacy_driver_register(void) {}
 static void __exit legacy_driver_unregister(void) {}
 #endif /* CONFIG_MPC832x_RDB */
 
-static int __init mpc8xxx_spi_init(void)
+static int __init fsl_spi_init(void)
 {
 	legacy_driver_register();
-	return of_register_platform_driver(&of_mpc8xxx_spi_driver);
+	return of_register_platform_driver(&of_fsl_spi_driver);
 }
+module_init(fsl_spi_init);
 
-static void __exit mpc8xxx_spi_exit(void)
+static void __exit fsl_spi_exit(void)
 {
-	of_unregister_platform_driver(&of_mpc8xxx_spi_driver);
+	of_unregister_platform_driver(&of_fsl_spi_driver);
 	legacy_driver_unregister();
 }
-
-module_init(mpc8xxx_spi_init);
-module_exit(mpc8xxx_spi_exit);
+module_exit(fsl_spi_exit);
 
 MODULE_AUTHOR("Kumar Gala");
-MODULE_DESCRIPTION("Simple MPC8xxx SPI Driver");
+MODULE_DESCRIPTION("Simple Freescale SPI Driver");
 MODULE_LICENSE("GPL");
-- 
1.6.4
