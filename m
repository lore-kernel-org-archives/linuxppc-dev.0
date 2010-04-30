Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 54A0AB7D43
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 23:21:31 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] spi: Add SPI master driver for MPC5121 PSC
Date: Fri, 30 Apr 2010 15:21:27 +0200
Message-Id: <1272633687-6935-3-git-send-email-agust@denx.de>
In-Reply-To: <1272633687-6935-2-git-send-email-agust@denx.de>
References: <1272633687-6935-1-git-send-email-agust@denx.de>
	<1272633687-6935-2-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detelv Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: John Rigby <jcrigby@gmail.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |    1 +
 drivers/spi/Kconfig                    |    7 +
 drivers/spi/Makefile                   |    1 +
 drivers/spi/mpc512x_psc_spi.c          |  576 ++++++++++++++++++++++++++++++++
 4 files changed, 585 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/mpc512x_psc_spi.c

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index 42561f4..ecc4fc6 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -248,6 +248,7 @@ struct mpc52xx_psc_fifo {
 	u16		tflwfptr;	/* PSC + 0x9e */
 };
 
+#define MPC512x_PSC_FIFO_EOF		0x100
 #define MPC512x_PSC_FIFO_RESET_SLICE	0x80
 #define MPC512x_PSC_FIFO_ENABLE_SLICE	0x01
 #define MPC512x_PSC_FIFO_ENABLE_DMA	0x04
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a191fa2..317bb01 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -165,6 +165,13 @@ config SPI_MPC52xx_PSC
 	  This enables using the Freescale MPC52xx Programmable Serial
 	  Controller in master SPI mode.
 
+config SPI_MPC512x_PSC
+	tristate "Freescale MPC512x PSC SPI controller"
+	depends on SPI_MASTER && PPC_MPC512x
+	help
+	  This enables using the Freescale MPC5121 Programmable Serial
+	  Controller in SPI master mode.
+
 config SPI_MPC8xxx
 	tristate "Freescale MPC8xxx SPI controller"
 	depends on FSL_SOC
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d7d0f89..b989ffb 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
 obj-$(CONFIG_SPI_OMAP_100K)		+= omap_spi_100k.o
 obj-$(CONFIG_SPI_ORION)			+= orion_spi.o
 obj-$(CONFIG_SPI_PL022)			+= amba-pl022.o
+obj-$(CONFIG_SPI_MPC512x_PSC)		+= mpc512x_psc_spi.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52xx_psc_spi.o
 obj-$(CONFIG_SPI_MPC52xx)		+= mpc52xx_spi.o
 obj-$(CONFIG_SPI_MPC8xxx)		+= spi_mpc8xxx.o
diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
new file mode 100644
index 0000000..28a126d
--- /dev/null
+++ b/drivers/spi/mpc512x_psc_spi.c
@@ -0,0 +1,576 @@
+/*
+ * MPC512x PSC in SPI mode driver.
+ *
+ * Copyright (C) 2007,2008 Freescale Semiconductor Inc.
+ * Original port from 52xx driver:
+ *	Hongjun Chen <hong-jun.chen@freescale.com>
+ *
+ * Fork of mpc52xx_psc_spi.c:
+ *	Copyright (C) 2006 TOPTICA Photonics AG., Dragos Carp
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/spi/spi.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc52xx_psc.h>
+
+struct mpc512x_psc_spi {
+	void (*cs_control)(struct spi_device *spi, bool on);
+	u32 sysclk;
+
+	/* driver internal data */
+	struct mpc52xx_psc __iomem *psc;
+	struct mpc512x_psc_fifo __iomem *fifo;
+	unsigned int irq;
+	u8 bits_per_word;
+	u8 busy;
+	u32 mclk;
+	u8 eofbyte;
+
+	struct workqueue_struct *workqueue;
+	struct work_struct work;
+
+	struct list_head queue;
+	spinlock_t lock;	/* Message queue lock */
+
+	struct completion done;
+};
+
+/* controller state */
+struct mpc512x_psc_spi_cs {
+	int bits_per_word;
+	int speed_hz;
+};
+
+/* set clock freq, clock ramp, bits per work
+ * if t is NULL then reset the values to the default values
+ */
+static int mpc512x_psc_spi_transfer_setup(struct spi_device *spi,
+					  struct spi_transfer *t)
+{
+	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
+
+	cs->speed_hz = (t && t->speed_hz)
+	    ? t->speed_hz : spi->max_speed_hz;
+	cs->bits_per_word = (t && t->bits_per_word)
+	    ? t->bits_per_word : spi->bits_per_word;
+	cs->bits_per_word = ((cs->bits_per_word + 7) / 8) * 8;
+	return 0;
+}
+
+static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
+{
+	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc52xx_psc __iomem *psc = mps->psc;
+	u32 sicr;
+	u32 ccr;
+	u16 bclkdiv;
+
+	sicr = in_be32(&psc->sicr);
+
+	/* Set clock phase and polarity */
+	if (spi->mode & SPI_CPHA)
+		sicr |= 0x00001000;
+	else
+		sicr &= ~0x00001000;
+
+	if (spi->mode & SPI_CPOL)
+		sicr |= 0x00002000;
+	else
+		sicr &= ~0x00002000;
+
+	if (spi->mode & SPI_LSB_FIRST)
+		sicr |= 0x10000000;
+	else
+		sicr &= ~0x10000000;
+	out_be32(&psc->sicr, sicr);
+
+	ccr = in_be32(&psc->ccr);
+	ccr &= 0xFF000000;
+	if (cs->speed_hz)
+		bclkdiv = (mps->mclk / cs->speed_hz) - 1;
+	else
+		bclkdiv = (mps->mclk / 1000000) - 1;	/* default 1MHz */
+
+	ccr |= (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
+	out_be32(&psc->ccr, ccr);
+	mps->bits_per_word = cs->bits_per_word;
+
+	if (mps->cs_control)
+		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
+}
+
+static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
+{
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+
+	if (mps->cs_control)
+		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+
+}
+
+/* extract and scale size field in txsz or rxsz */
+#define MPC512x_PSC_FIFO_SZ(sz) ((sz & 0x7ff) << 2);
+
+#define EOFBYTE 1
+
+static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
+					 struct spi_transfer *t)
+{
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
+	size_t len = t->len;
+	u8 *tx_buf = (u8 *)t->tx_buf;
+	u8 *rx_buf = (u8 *)t->rx_buf;
+
+	if (!tx_buf && !rx_buf && t->len)
+		return -EINVAL;
+
+	/* Zero MR2 */
+	in_8(&psc->mode);
+	out_8(&psc->mode, 0x0);
+
+	while (len) {
+		int count;
+		int i;
+		u8 data;
+		size_t fifosz;
+		int rxcount;
+
+		/*
+		 * The number of bytes that can be sent at a time
+		 * depends on the fifo size.
+		 */
+		fifosz = MPC512x_PSC_FIFO_SZ(in_be32(&fifo->txsz));
+		count = min(fifosz, len);
+
+		for (i = count; i > 0; i--) {
+			data = tx_buf ? *tx_buf++ : 0;
+			if (len == EOFBYTE)
+				setbits32(&fifo->txcmd, MPC512x_PSC_FIFO_EOF);
+			out_8(&fifo->txdata_8, data);
+			len--;
+		}
+
+		INIT_COMPLETION(mps->done);
+
+		/* interrupt on tx fifo empty */
+		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
+		out_be32(&fifo->tximr, MPC512x_PSC_FIFO_EMPTY);
+
+		/* enable transmiter/receiver */
+		out_8(&psc->command,
+		      MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+
+		wait_for_completion(&mps->done);
+
+		mdelay(1);
+
+		/* rx fifo should have count bytes in it */
+		rxcount = in_be32(&fifo->rxcnt);
+		if (rxcount != count)
+			mdelay(1);
+
+		rxcount = in_be32(&fifo->rxcnt);
+		if (rxcount != count) {
+			dev_warn(&spi->dev, "expected %d bytes in rx fifo "
+				 "but got %d\n", count, rxcount);
+		}
+
+		rxcount = min(rxcount, count);
+		for (i = rxcount; i > 0; i--) {
+			data = in_8(&fifo->rxdata_8);
+			if (rx_buf)
+				*rx_buf++ = data;
+		}
+		while (in_be32(&fifo->rxcnt)) {
+			in_8(&fifo->rxdata_8);
+		}
+
+		out_8(&psc->command,
+		      MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+	}
+	/* disable transmiter/receiver and fifo interrupt */
+	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+	out_be32(&fifo->tximr, 0);
+	return 0;
+}
+
+static void mpc512x_psc_spi_work(struct work_struct *work)
+{
+	struct mpc512x_psc_spi *mps = container_of(work,
+						   struct mpc512x_psc_spi,
+						   work);
+
+	spin_lock_irq(&mps->lock);
+	mps->busy = 1;
+	while (!list_empty(&mps->queue)) {
+		struct spi_message *m;
+		struct spi_device *spi;
+		struct spi_transfer *t = NULL;
+		unsigned cs_change;
+		int status;
+
+		m = container_of(mps->queue.next, struct spi_message, queue);
+		list_del_init(&m->queue);
+		spin_unlock_irq(&mps->lock);
+
+		spi = m->spi;
+		cs_change = 1;
+		status = 0;
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->bits_per_word || t->speed_hz) {
+				status = mpc512x_psc_spi_transfer_setup(spi, t);
+				if (status < 0)
+					break;
+			}
+
+			if (cs_change)
+				mpc512x_psc_spi_activate_cs(spi);
+			cs_change = t->cs_change;
+
+			status = mpc512x_psc_spi_transfer_rxtx(spi, t);
+			if (status)
+				break;
+			m->actual_length += t->len;
+
+			if (t->delay_usecs)
+				udelay(t->delay_usecs);
+
+			if (cs_change)
+				mpc512x_psc_spi_deactivate_cs(spi);
+		}
+
+		m->status = status;
+		m->complete(m->context);
+
+		if (status || !cs_change)
+			mpc512x_psc_spi_deactivate_cs(spi);
+
+		mpc512x_psc_spi_transfer_setup(spi, NULL);
+
+		spin_lock_irq(&mps->lock);
+	}
+	mps->busy = 0;
+	spin_unlock_irq(&mps->lock);
+}
+
+static int mpc512x_psc_spi_setup(struct spi_device *spi)
+{
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
+	unsigned long flags;
+
+	if (spi->bits_per_word % 8)
+		return -EINVAL;
+
+	if (!cs) {
+		cs = kzalloc(sizeof *cs, GFP_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+
+	cs->bits_per_word = spi->bits_per_word;
+	cs->speed_hz = spi->max_speed_hz;
+
+	spin_lock_irqsave(&mps->lock, flags);
+	if (!mps->busy)
+		mpc512x_psc_spi_deactivate_cs(spi);
+	spin_unlock_irqrestore(&mps->lock, flags);
+
+	return 0;
+}
+
+static int mpc512x_psc_spi_transfer(struct spi_device *spi,
+				    struct spi_message *m)
+{
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+
+	spin_lock_irqsave(&mps->lock, flags);
+	list_add_tail(&m->queue, &mps->queue);
+	queue_work(mps->workqueue, &mps->work);
+	spin_unlock_irqrestore(&mps->lock, flags);
+
+	return 0;
+}
+
+static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+static int mpc512x_psc_spi_port_config(struct spi_master *master,
+				       struct mpc512x_psc_spi *mps)
+{
+	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
+	struct clk *spiclk;
+	int ret = 0;
+	char name[32];
+	u32 sicr;
+	u32 ccr;
+	u16 bclkdiv;
+
+	sprintf(name, "psc%d_mclk", master->bus_num);
+	spiclk = clk_get(&master->dev, name);
+	clk_enable(spiclk);
+	mps->mclk = clk_get_rate(spiclk);
+	clk_put(spiclk);
+
+	/* Reset the PSC into a known state */
+	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	out_8(&psc->command, MPC52xx_PSC_RST_TX);
+	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
+
+	/* Disable psc interrupts all useful interrupts are in fifo */
+	out_be16(&psc->isr_imr.imr, 0);
+
+	/* Disable fifo interrupts, will be enabled later */
+	out_be32(&fifo->tximr, 0);
+	out_be32(&fifo->rximr, 0);
+
+	/* Setup fifo slice address and size */
+	/*out_be32(&fifo->txsz, 0x0fe00004);*/
+	/*out_be32(&fifo->rxsz, 0x0ff00004);*/
+
+	sicr =	0x01000000 |	/* SIM = 0001 -- 8 bit */
+		0x00800000 |	/* GenClk = 1 -- internal clk */
+		0x00008000 |	/* SPI = 1 */
+		0x00004000 |	/* MSTR = 1   -- SPI master */
+		0x00000800;	/* UseEOF = 1 -- SS low until EOF */
+
+	out_be32(&psc->sicr, sicr);
+
+	ccr = in_be32(&psc->ccr);
+	ccr &= 0xFF000000;
+	bclkdiv = (mps->mclk / 1000000) - 1;	/* default 1MHz */
+	ccr |= (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
+	out_be32(&psc->ccr, ccr);
+
+	/* Set 2ms DTL delay */
+	out_8(&psc->ctur, 0x00);
+	out_8(&psc->ctlr, 0x82);
+
+	/* we don't use the alarms */
+	out_be32(&fifo->rxalarm, 0xfff);
+	out_be32(&fifo->txalarm, 0);
+
+	/* Enable FIFO slices for Rx/Tx */
+	out_be32(&fifo->rxcmd,
+		 MPC512x_PSC_FIFO_ENABLE_SLICE | MPC512x_PSC_FIFO_ENABLE_DMA);
+	out_be32(&fifo->txcmd,
+		 MPC512x_PSC_FIFO_ENABLE_SLICE | MPC512x_PSC_FIFO_ENABLE_DMA);
+
+	mps->bits_per_word = 8;
+
+	return ret;
+}
+
+static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
+{
+	struct mpc512x_psc_spi *mps = (struct mpc512x_psc_spi *)dev_id;
+	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
+
+	/* clear interrupt and wake up the work queue */
+	if (in_be32(&fifo->txisr) &
+	    in_be32(&fifo->tximr) & MPC512x_PSC_FIFO_EMPTY) {
+		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
+		out_be32(&fifo->tximr, 0);
+		complete(&mps->done);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+/* bus_num is used only for the case dev->platform_data == NULL */
+static int __init mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
+					   u32 size, unsigned int irq,
+					   s16 bus_num)
+{
+	struct fsl_spi_platform_data *pdata = dev->platform_data;
+	struct mpc512x_psc_spi *mps;
+	struct spi_master *master;
+	int ret;
+	void *tempp;
+
+	master = spi_alloc_master(dev, sizeof *mps);
+	if (master == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, master);
+	mps = spi_master_get_devdata(master);
+	mps->irq = irq;
+
+	if (pdata == NULL) {
+		dev_err(dev, "probe called without platform data, no "
+			"cs_control function will be called\n");
+		mps->cs_control = NULL;
+		mps->sysclk = 0;
+		master->bus_num = bus_num;
+		master->num_chipselect = 255;
+	} else {
+		mps->cs_control = pdata->cs_control;
+		mps->sysclk = pdata->sysclk;
+		master->bus_num = pdata->bus_num;
+		master->num_chipselect = pdata->max_chipselect;
+	}
+
+	master->setup = mpc512x_psc_spi_setup;
+	master->transfer = mpc512x_psc_spi_transfer;
+	master->cleanup = mpc512x_psc_spi_cleanup;
+
+	tempp = ioremap(regaddr, size);
+	if (!tempp) {
+		dev_err(dev, "could not ioremap I/O port range\n");
+		ret = -EFAULT;
+		goto free_master;
+	}
+	mps->psc = tempp;
+	mps->fifo =
+		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
+
+	ret = request_irq(mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
+			  "mpc512x-psc-spi", mps);
+	if (ret)
+		goto free_master;
+
+	ret = mpc512x_psc_spi_port_config(master, mps);
+	if (ret < 0)
+		goto free_irq;
+
+	spin_lock_init(&mps->lock);
+	init_completion(&mps->done);
+	INIT_WORK(&mps->work, mpc512x_psc_spi_work);
+	INIT_LIST_HEAD(&mps->queue);
+
+	mps->workqueue =
+		create_singlethread_workqueue(dev_name(master->dev.parent));
+	if (mps->workqueue == NULL) {
+		ret = -EBUSY;
+		goto free_irq;
+	}
+
+	ret = spi_register_master(master);
+	if (ret < 0)
+		goto unreg_master;
+
+	return ret;
+
+unreg_master:
+	destroy_workqueue(mps->workqueue);
+free_irq:
+	free_irq(mps->irq, mps);
+free_master:
+	if (mps->psc)
+		iounmap(mps->psc);
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int __exit mpc512x_psc_spi_do_remove(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
+
+	flush_workqueue(mps->workqueue);
+	destroy_workqueue(mps->workqueue);
+	spi_unregister_master(master);
+	free_irq(mps->irq, mps);
+	if (mps->psc)
+		iounmap(mps->psc);
+
+	return 0;
+}
+
+static int __init mpc512x_psc_spi_of_probe(struct of_device *op,
+					   const struct of_device_id *match)
+{
+	const u32 *regaddr_p;
+	u64 regaddr64, size64;
+	s16 id = -1;
+
+	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
+	if (!regaddr_p) {
+		dev_err(&op->dev, "Invalid PSC address\n");
+		return -EINVAL;
+	}
+	regaddr64 = of_translate_address(op->node, regaddr_p);
+
+	/* get PSC id (0..11, used by port_config) */
+	if (op->dev.platform_data == NULL) {
+		const u32 *psc_nump;
+
+		psc_nump = of_get_property(op->node, "cell-index", NULL);
+		if (!psc_nump || *psc_nump > 11) {
+			dev_err(&op->dev, "mpc512x_psc_spi: Device node %s "
+				"has invalid cell-index property\n",
+				op->node->full_name);
+			return -EINVAL;
+		}
+		id = *psc_nump;
+	}
+
+	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
+					irq_of_parse_and_map(op->node, 0), id);
+}
+
+static int __exit mpc512x_psc_spi_of_remove(struct of_device *op)
+{
+	return mpc512x_psc_spi_do_remove(&op->dev);
+}
+
+static struct of_device_id mpc512x_psc_spi_of_match[] = {
+	{ .compatible = "fsl,mpc5121-psc-spi", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
+
+static struct of_platform_driver mpc512x_psc_spi_of_driver = {
+	.match_table = mpc512x_psc_spi_of_match,
+	.probe = mpc512x_psc_spi_of_probe,
+	.remove = __exit_p(mpc512x_psc_spi_of_remove),
+	.driver = {
+		.name = "mpc512x-psc-spi",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init mpc512x_psc_spi_init(void)
+{
+	return of_register_platform_driver(&mpc512x_psc_spi_of_driver);
+}
+module_init(mpc512x_psc_spi_init);
+
+static void __exit mpc512x_psc_spi_exit(void)
+{
+	of_unregister_platform_driver(&mpc512x_psc_spi_of_driver);
+}
+module_exit(mpc512x_psc_spi_exit);
+
+MODULE_AUTHOR("John Rigby");
+MODULE_DESCRIPTION("MPC512x PSC SPI Driver");
+MODULE_LICENSE("GPL");
-- 
1.6.3.3
