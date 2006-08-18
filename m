Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx027.isp.belgacom.be (outmx027.isp.belgacom.be
	[195.238.4.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E81367B6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 22:50:26 +1000 (EST)
Received: from outmx027.isp.belgacom.be (localhost [127.0.0.1])
	by outmx027.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k7ICoEmS028608
	for <linuxppc-embedded@ozlabs.org>; Fri, 18 Aug 2006 14:50:15 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org, spi-devel-general@lists.sourceforge.net
Subject: [RFC] MPC8260 SPI driver
Date: Fri, 18 Aug 2006 14:52:52 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kgb5EHx5l0Ky99Z"
Message-Id: <200608181452.52901.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_kgb5EHx5l0Ky99Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody,

here's a preliminary version of the MPC8260 SPI driver I'm working on. The 
driver supports master mode only, and has been tested with an MMC device in 
SPI mode.

The driver doesn't support the following features:

- >1024 byte transfers. Those should be easy to support by splitting data 
buffers in <=1024 bytes chunks.
- transfer->delay_usecs
- MPC8260 SPI controller error reporting (BSY and TXE interrupts)
- probably other (hopefully minor) things.

Please test the code and report bugs (patches are welcome :-)).

Laurent Pinchart

--Boundary-00=_kgb5EHx5l0Ky99Z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mpc8260-spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpc8260-spi.patch"

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 23334c8..bd7040e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -75,6 +75,13 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_MPC8260
+	tristate "Freescale MPC8260 SPI controller"
+	depends on SPI_MASTER && 8260 && EXPERIMENTAL
+	help
+	  This enables using the Freescale MPC8260 SPI controller in master
+	  mode.
+
 config SPI_MPC83xx
 	tristate "Freescale MPC83xx SPI controller"
 	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8f4cb67..00a7345 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -14,6 +14,7 @@ # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
+obj-$(CONFIG_SPI_MPC8260)		+= spi_mpc8260.o
 obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
diff --git a/drivers/spi/spi_mpc8260.c b/drivers/spi/spi_mpc8260.c
new file mode 100644
index 0000000..ee6c55b
--- /dev/null
+++ b/drivers/spi/spi_mpc8260.c
@@ -0,0 +1,725 @@
+/*
+ * MPC8260 SPI controller driver.
+ *
+ * Author: Laurent Pinchart <laurent.pinchart@technotrade.biz>
+ *
+ * Based on spi_mpc83xx.c by Kumar Gala
+ *      and pxa2xx_spi.c  by Stephen Street
+ *
+ * Copyright (C) 2006 Technotrade S.A.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_device.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/cpm2.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+/* The MPC8260 SPI controller is a CPM-driven, DMA-based SPI master.
+ *
+ * SPI transfers are submitted to the CPM through buffer descriptors. Each CPM
+ * transfer sends and receives the same amount of data, which can span one or
+ * more Tx buffers and one or more Rx buffers.
+ *
+ * Linux supports three kind of transfers:
+ *
+ * IN     Incomming data are stored directly in the user-supplied Rx buffer by
+ *        the CPM. Outgoing data are don't-care, the Tx buffer will use a
+ *        dedicated scratch pad.
+ * OUT    Incomming data are don't-care, the Rx buffer will use a dedicated
+ *        scratch pad. Outgoing data are sent directly from the user-supplied
+ *        Tx buffer by the CPM.
+ * IN-OUT Incomming data are stored directly in the user-supplied Rx buffer by
+ *        the CPM. Outgoing data are sent directly from the user-supplied Tx
+ *        buffer by the CPM.
+ *
+ * The Rx buffers maximum size has been fixed to 1024 bytes which should be
+ * enough for most applications (the maximum MMC transfer size is 515 bytes).
+ * Transfers larger than 1024 bytes must be split. This is currently not
+ * implemented.
+ *
+ * Linux groups SPI transfers in SPI messages. An SPI message contains one or
+ * more transfers with a given peripheral. Transfers can all share the same
+ * set of parameters (bits per word, speed) or use different parameters.
+ * Transfers sharing the same set of parameters are said to be compatible.
+ * When processing an SPI message, the driver will queue as much transfers as
+ * possible in CPM buffers until it either finds an uncompatible transfer or
+ * it rans out of buffers.
+ */
+
+#define MPC8260_SPI_RX_BUFS	4
+#define MPC8260_SPI_TX_BUFS	4
+#define MPC8260_SPI_RX_SIZE	1024
+
+#define MPC8260_SPI_RX_DONE	(1 << 0)
+#define MPC8260_SPI_TX_DONE	(1 << 1)
+
+/* SPI Controller driver's private data. */
+struct mpc8260_spi {
+	struct completion done;
+
+	/* Registers, parameter RAM and IRQ. */
+	volatile __u16 *pram_base;
+	volatile spi_t __iomem *pram;
+	volatile spictl_cpm2_t __iomem *regs;
+	uint dpram;
+	u32 irq;
+
+	/* Buffer descriptors. */
+	cbd_t *rx_base;
+	cbd_t *rx_head;
+	cbd_t *rx_tail;
+	cbd_t *tx_base;
+	cbd_t *tx_head;
+	cbd_t *tx_tail;
+	void *scratch;
+
+	/* Messages and transfers. */
+	struct list_head messages;
+	struct spi_message *cur_message;
+	struct spi_transfer *cur_transfer;
+	unsigned int cur_length;
+	unsigned int cur_status;
+	unsigned int chip_select;
+	spinlock_t lock;
+
+	/* Platform data. */
+	u32 sysclk;
+	void (*activate_cs) (u8 cs, u8 polarity);
+	void (*deactivate_cs) (u8 cs, u8 polarity);
+};
+
+/* FCC access macros */
+
+#define __spi_out32(addr, x)    out_be32((unsigned *)addr, x)
+#define __spi_out16(addr, x)    out_be16((unsigned short *)addr, x)
+#define __spi_out8(addr, x)     out_8((unsigned char *)addr, x)
+#define __spi_in32(addr)        in_be32((unsigned *)addr)
+#define __spi_in16(addr)        in_be16((unsigned short *)addr)
+#define __spi_in8(addr)         in_8((unsigned char *)addr)
+
+/* parameter space */
+
+/* write, read, set bits, clear bits */
+#define W32(_p, _m, _v) __spi_out32(&(_p)->_m, (_v))
+#define R32(_p, _m)     __spi_in32(&(_p)->_m)
+#define S32(_p, _m, _v) W32(_p, _m, R32(_p, _m) | (_v))
+#define C32(_p, _m, _v) W32(_p, _m, R32(_p, _m) & ~(_v))
+
+#define W16(_p, _m, _v) __spi_out16(&(_p)->_m, (_v))
+#define R16(_p, _m)     __spi_in16(&(_p)->_m)
+#define S16(_p, _m, _v) W16(_p, _m, R16(_p, _m) | (_v))
+#define C16(_p, _m, _v) W16(_p, _m, R16(_p, _m) & ~(_v))
+
+#define W8(_p, _m, _v)  __spi_out8(&(_p)->_m, (_v))
+#define R8(_p, _m)      __spi_in8(&(_p)->_m)
+#define S8(_p, _m, _v)  W8(_p, _m, R8(_p, _m) | (_v))
+#define C8(_p, _m, _v)  W8(_p, _m, R8(_p, _m) & ~(_v))
+
+/*
+ * mpc8260_spi_pump - Pump SPI transfers into the buffer descriptors
+ *
+ * This function fills the empty SPI buffer descriptors with SPI frames from
+ * message/transfer queues.
+ *
+ * The caller must hold the lock spinlock and the spi->message queue must
+ * not be empty.
+ */
+static void mpc8260_spi_pump(struct mpc8260_spi *spi)
+{
+	volatile cbd_t *tx_bd, *rx_bd;
+	void *rx_buf, *tx_buf;
+	struct spi_message *message = spi->cur_message;
+	struct spi_transfer *transfer = spi->cur_transfer;
+	struct spi_device *dev;
+	int bpp, speed;
+	__u16 mode;
+	__u8 pm;
+
+/*
+	printk(KERN_INFO "mpc8260_spi_pump: 1. message %p transfer %p\n",
+		message, transfer);
+*/
+	/* Move to the next message if we are done with the current one. */
+	if (spi->cur_message == NULL) {
+		message = list_entry(spi->messages.next,
+				struct spi_message, queue);
+		transfer = list_entry(message->transfers.next,
+				struct spi_transfer, transfer_list);
+
+		spi->cur_message = message;
+		spi->cur_transfer = transfer;
+	}
+
+/*
+	printk(KERN_INFO "mpc8260_spi_pump: 2. message %p transfer %p\n",
+		message, transfer);
+*/
+	rx_bd = spi->rx_head;
+	tx_bd = spi->tx_head;
+
+	if (!(rx_bd->cbd_sc & BD_SC_EMPTY) &&
+		!(tx_bd->cbd_sc & BD_SC_READY)) {
+
+		/* Disable the SPI controller */
+		W16(spi->regs, spi_spmode, 0x0000);
+
+		/* Select SPI mode based on device settings. */
+		dev = message->spi;
+		bpp = transfer->bits_per_word ? transfer->bits_per_word
+		    : dev->bits_per_word;
+		speed = transfer->speed_hz ? transfer->speed_hz
+		      : dev->max_speed_hz;
+
+		mode = ((dev->mode & SPI_CPOL) ? SPMODE_CI : 0)
+		     | ((dev->mode & SPI_CPHA) ? SPMODE_CP : 0)
+		     | ((dev->mode & SPI_LSB_FIRST) ? 0 : SPMODE_REV)
+		     | SPMODE_LEN(bpp) | SPMODE_EN | SPMODE_MSTR;
+
+		if (spi->sysclk / speed >= 64) {
+			pm = spi->sysclk / (speed * 64);
+			mode |= SPMODE_PM(pm) | SPMODE_DIV16;
+		} else {
+			pm = spi->sysclk / (speed * 4);
+			mode |= SPMODE_PM(pm);
+		}
+
+/*
+		printk(KERN_INFO "mpc8260_spi_pump: setting mode to 0x%04x (%u Hz)\n",
+			 mode, speed);
+*/
+		W16(spi->regs, spi_spmode, mode);
+
+		if (spi->activate_cs)
+			spi->activate_cs(dev->chip_select,
+				dev->mode & SPI_CS_HIGH);
+
+		if (message->is_dma_mapped) {
+/*
+			printk(KERN_INFO "message is DMA-mapped - rx_dma: %p, tx_dma: %p, %u bytes\n",
+				(void*)transfer->rx_dma, (void*)transfer->tx_dma, transfer->len);
+*/
+			rx_bd->cbd_bufaddr = transfer->rx_dma;
+			tx_bd->cbd_bufaddr = transfer->tx_dma;
+		}
+		else {
+			/* DMA-map buffers, use the scratch pad if
+			 * necessary.
+			 */
+/*
+				printk(KERN_INFO "rx_buf: %p, tx_buf: %p, %u bytes\n",
+					transfer->rx_buf, transfer->tx_buf, transfer->len);
+*/
+			rx_buf = transfer->rx_buf ? transfer->rx_buf
+			       : spi->scratch;
+			tx_buf = transfer->tx_buf ? (void*)transfer->tx_buf
+			       : spi->scratch;
+
+			rx_bd->cbd_bufaddr = dma_map_single(
+				&message->spi->dev, rx_buf, transfer->len,
+				DMA_FROM_DEVICE);
+			tx_bd->cbd_bufaddr = dma_map_single(
+				&message->spi->dev, tx_buf, transfer->len,
+				DMA_TO_DEVICE);
+/*
+			printk(KERN_INFO "rx_bd: %p(%p), tx_bd: %p(%p)\n",
+				rx_bd, (void*)rx_bd->cbd_bufaddr,
+				tx_bd, (void*)tx_bd->cbd_bufaddr);
+*/
+		}
+
+		tx_bd->cbd_datlen = transfer->len;
+
+		/* Mark buffers as ready and start the transfer. */
+		rx_bd->cbd_sc = BD_SC_EMPTY | (rx_bd->cbd_sc & BD_SC_WRAP)
+			      | BD_SC_INTRPT;
+		tx_bd->cbd_sc = BD_SC_READY | (tx_bd->cbd_sc & BD_SC_WRAP)
+			      | BD_SC_INTRPT | BD_SC_LAST;
+		wmb();
+		W8(spi->regs, spi_spcom, SPCOM_STR);
+
+		rx_bd = (rx_bd->cbd_sc & BD_SC_WRAP)
+		      ? spi->rx_base : (rx_bd + 1);
+		tx_bd = (tx_bd->cbd_sc & BD_SC_WRAP)
+		      ? spi->tx_base : (tx_bd + 1);
+	}
+	else
+		printk(KERN_INFO "mpc8260_spi_pump: no empty buffer ?\n");
+
+	spi->rx_head = (cbd_t*)rx_bd;
+	spi->tx_head = (cbd_t*)tx_bd;
+}
+
+/*
+ * mpc8260_spi_done - Process finished tranfers
+ *
+ * This function walks the receive and transmit buffer descriptors and updates
+ * all finished transfers accordingly.
+ *
+ * Context: interrupt. The caller must not hold the lock spinlock.
+ */
+static void mpc8260_spi_done(struct mpc8260_spi *spi)
+{
+	volatile cbd_t *tx_bd, *rx_bd;
+	struct spi_message *message = spi->cur_message;
+	struct spi_transfer *transfer = spi->cur_transfer;
+	struct spi_device *dev = message->spi;
+
+/*
+	printk(KERN_INFO "mpc8260_spi_done: message %p transfer %p\n",
+		message, transfer);
+*/
+
+	rx_bd = spi->rx_tail;
+	tx_bd = spi->tx_tail;
+
+	if (!(rx_bd->cbd_sc & BD_SC_EMPTY) &&
+		!(tx_bd->cbd_sc & BD_SC_READY)) {
+
+		if (!message->is_dma_mapped) {
+			dma_unmap_single(&message->spi->dev, rx_buf,
+				transfer->len, DMA_FROM_DEVICE);
+			dma_unmap_single(&message->spi->dev, tx_buf,
+				transfer->len, DMA_TO_DEVICE);
+		}
+
+		spi->cur_length += transfer->len;
+
+		rx_bd = (rx_bd->cbd_sc & BD_SC_WRAP)
+		      ? spi->rx_base : (rx_bd + 1);
+		tx_bd = (tx_bd->cbd_sc & BD_SC_WRAP)
+		      ? spi->tx_base : (tx_bd + 1);
+
+		if (transfer->transfer_list.next == &message->transfers) {
+			message->status = 0;
+			message->actual_length = spi->cur_length;
+
+			spi->cur_message = NULL;
+			spi->cur_transfer = NULL;
+			spi->cur_length = 0;
+
+			message->complete(message->context);
+//			spi->deactivate_cs(dev->chip_select,
+//				dev->mode & SPI_CS_HIGH);
+		}
+		else {
+			spi->cur_transfer = list_entry(
+				transfer->transfer_list.next,
+				struct spi_transfer, transfer_list);
+
+			if (transfer->cs_change) {
+				printk(KERN_INFO "cs_change set\n");
+				spi->deactivate_cs(dev->chip_select,
+					dev->mode & SPI_CS_HIGH);
+			}
+		}
+
+		if (transfer->delay_usecs)
+			printk(KERN_INFO "transfer requested %uus delay\n",
+				transfer->delay_usecs);
+	}
+	else
+		printk(KERN_INFO "mpc8260_spi_done: no buffers ?\n");
+
+	spi->rx_tail = (cbd_t*)rx_bd;
+	spi->tx_tail = (cbd_t*)tx_bd;
+}
+
+/*
+ * SPI message/transfer queues behaviour
+ * -------------------------------------
+ *
+ * Messages are stored in the mpc8260_spi->messages list, with new messages
+ * added at the tail.
+ *
+ * Even though the SPI controller has the ability to handle several queued
+ * buffer descriptors, hardware limitations prevents the driver from handling
+ * more than a single transfer at a given time. When a new transfer is pumped
+ * into the buffer descriptors, cur_message and cur_transfer are updated to
+ * point to the current message and current transfer respectively.
+ *
+ * Once a transfer is finished (both the TXB and RXB have been received),
+ * the next transfer is pumped to the hardware. If the transfer was the last
+ * one in the current message, the message completion handler is called
+ * synchronously. The message is then removed from the message queue and the
+ * cur_message and cur_transfer pointers are set to NULL before pumping the
+ * next transfer.
+ */
+static irqreturn_t mpc8260_spi_irq(s32 irq, void *context_data,
+		struct pt_regs *ptregs)
+{
+	struct mpc8260_spi *spi = context_data;
+	unsigned long flags;
+	__u8 events;
+
+	events = R8(spi->regs, spi_spie);
+
+	if (events & SPIM_BSY) {
+		printk(KERN_INFO "-- SPI --: BSY\n");
+	}
+
+	if (events & SPIM_TXE) {
+		printk(KERN_INFO "-- SPI --: TXE\n");
+	}
+
+	if (events & SPIM_RXB) {
+		spi->cur_status |= MPC8260_SPI_RX_DONE;
+	}
+
+	if (events & SPIM_TXB) {
+		spi->cur_status |= MPC8260_SPI_TX_DONE;
+	}
+
+	if (spi->cur_status == (MPC8260_SPI_TX_DONE | MPC8260_SPI_RX_DONE)) {
+		mpc8260_spi_done(spi);
+		spi->cur_status = 0;
+
+		spin_lock_irqsave(&spi->lock, flags);
+		if (spi->cur_message == NULL)
+			list_del(spi->messages.next);
+		if (!list_empty(&spi->messages))
+			mpc8260_spi_pump(spi);
+		spin_unlock_irqrestore(&spi->lock, flags);
+	}
+
+	/* Clear the events */
+	W8(spi->regs, spi_spie, events);
+
+	return (events & (SPIM_TXE | SPIM_BSY | SPIM_TXB | SPIM_RXB))
+		? IRQ_HANDLED : IRQ_NONE;
+}
+
+/* --------------------------------------------------------------------------
+ * SPI master kernel API
+ */
+
+/* Called by spi_new_device() when a device is created. Initialize device
+ * fields, deassert chip select, ...
+ */
+static int mpc8260_spi_setup(struct spi_device *spi)
+{
+//	struct spi_mpc8260_cs *cs = spi->controller_state;
+//	struct mpc8260_spi *mpc8260_spi = spi_master_get_devdata(spi->master);
+//	int retval;
+
+//	printk(KERN_INFO "mpc8260_spi: setup()\n");
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w\n",
+		__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
+		spi->bits_per_word);
+
+	return 0;
+}
+
+static int mpc8260_spi_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct mpc8260_spi *mpc8260_spi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+	int trigger;
+
+/*
+	printk(KERN_INFO "mpc8260_spi: transfer(msg = %p)\n", msg);
+*/
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+
+	spin_lock_irqsave(&mpc8260_spi->lock, flags);
+	trigger = list_empty(&mpc8260_spi->messages);
+	list_add_tail(&msg->queue, &mpc8260_spi->messages);
+	if (trigger)
+		mpc8260_spi_pump(mpc8260_spi);
+	spin_unlock_irqrestore(&mpc8260_spi->lock, flags);
+
+	return 0;
+}
+
+static void mpc8260_spi_cleanup(const struct spi_device *spi)
+{
+	printk(KERN_INFO "mpc8260_spi: cleanup()\n");
+}
+
+/* --------------------------------------------------------------------------
+ * CPM specific initialization and cleanup
+ */
+static int mpc8260_spi_alloc_bufs(struct mpc8260_spi *mpc8260_spi)
+{
+	cbd_t *bd;
+	int i, size, ret;
+
+	/* Allocate memory for discarded incoming data. */
+	mpc8260_spi->scratch = kzalloc(MPC8260_SPI_RX_SIZE, GFP_KERNEL);
+	if (mpc8260_spi->scratch == NULL) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Allocate dpram. */
+	size = sizeof(cbd_t) * (MPC8260_SPI_RX_BUFS + MPC8260_SPI_TX_BUFS);
+	mpc8260_spi->dpram = cpm_dpalloc(size, 8);
+	if (IS_DPERR(mpc8260_spi->dpram)) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Initialize the buffer descriptors. */
+	bd = (cbd_t*)cpm_dpram_addr(mpc8260_spi->dpram);
+	mpc8260_spi->rx_base = bd;
+	mpc8260_spi->rx_head = bd;
+	mpc8260_spi->rx_tail = bd;
+	for (i = 0; i < MPC8260_SPI_RX_BUFS; ++i, ++bd) {
+		bd->cbd_bufaddr = 0;
+		bd->cbd_datlen = 0;
+		bd->cbd_sc = 0;
+	}
+	bd[-1].cbd_sc = BD_SC_WRAP;
+
+	mpc8260_spi->tx_base = bd;
+	mpc8260_spi->tx_head = bd;
+	mpc8260_spi->tx_tail = bd;
+	for (i = 0; i < MPC8260_SPI_TX_BUFS; ++i, ++bd) {
+		bd->cbd_bufaddr = 0;
+		bd->cbd_datlen = 0;
+		bd->cbd_sc = 0;
+	}
+	bd[-1].cbd_sc = BD_SC_WRAP;
+
+	return 0;
+
+error:
+	kfree(mpc8260_spi->scratch);
+	if (!IS_DPERR(mpc8260_spi->dpram))
+		cpm_dpfree(mpc8260_spi->dpram);
+	return ret;
+}
+
+static void mpc8260_spi_free_bufs(struct mpc8260_spi *mpc8260_spi)
+{
+	cpm_dpfree(mpc8260_spi->dpram);
+	kfree(mpc8260_spi->scratch);
+}
+
+static int mpc8260_spi_init_cpm(struct mpc8260_spi *mpc8260_spi)
+{
+	cpm2_map_t *immap;
+	int ret = 0;
+
+	immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	if (immap == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Initialize I/O ports. */
+	clrbits32(&immap->im_ioport.iop_ppard, 0x00001000);
+	setbits32(&immap->im_ioport.iop_ppard, 0x0000e000);
+	setbits32(&immap->im_ioport.iop_psord, 0x0000f000);
+	clrbits32(&immap->im_ioport.iop_pdird, 0x0000f000);
+
+	*(u16 *)(&immap->im_dprambase[PROFF_SPI_BASE]) = PROFF_SPI;
+
+	if ((ret = mpc8260_spi_alloc_bufs(mpc8260_spi)) < 0)
+		goto out;
+
+	W16(mpc8260_spi->pram, spi_rbase, mpc8260_spi->dpram);
+	W16(mpc8260_spi->pram, spi_tbase, mpc8260_spi->dpram + sizeof(cbd_t) * MPC8260_SPI_RX_BUFS);
+	W8(mpc8260_spi->pram, spi_rfcr, CPMFCR_GBL | CPMFCR_EB);
+	W8(mpc8260_spi->pram, spi_tfcr, CPMFCR_GBL | CPMFCR_EB);
+	W16(mpc8260_spi->pram, spi_mrblr, MPC8260_SPI_RX_SIZE);
+
+	W32(&immap->im_cpm, cp_cpcr, mk_cr_cmd(CPM_CR_SPI_PAGE,
+			CPM_CR_SPI_SBLOCK, 0, CPM_CR_INIT_TRX | CPM_CR_FLG));
+        while (R32(&immap->im_cpm, cp_cpcr) & CPM_CR_FLG) {};
+
+	W16(mpc8260_spi->regs, spi_spmode, 0x0000);
+	W8(mpc8260_spi->regs, spi_spie, 0xff);
+	W8(mpc8260_spi->regs, spi_spim, SPIM_TXE | SPIM_BSY | SPIM_TXB | SPIM_RXB);
+
+out:
+	if (immap)
+		iounmap(immap);
+
+	return ret;
+}
+
+/* --------------------------------------------------------------------------
+ * Initialization
+ */
+
+static int __init mpc8260_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct mpc8260_spi *mpc8260_spi;
+	struct fsl_spi_platform_data *pdata;
+	struct resource *regs, *pram;
+	int ret = 0;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof *mpc8260_spi);
+	if (master == NULL) {
+		dev_err(&pdev->dev, "cannot allocate spi master\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+	platform_set_drvdata(pdev, master);
+
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->max_chipselect;
+	master->setup = mpc8260_spi_setup;
+	master->transfer = mpc8260_spi_transfer;
+	master->cleanup = mpc8260_spi_cleanup;
+
+	mpc8260_spi = spi_master_get_devdata(master);
+	INIT_LIST_HEAD(&mpc8260_spi->messages);
+	spin_lock_init(&mpc8260_spi->lock);
+	mpc8260_spi->cur_message = NULL;
+	mpc8260_spi->cur_transfer = NULL;
+	mpc8260_spi->cur_length = 0;
+	mpc8260_spi->cur_status = 0;
+	mpc8260_spi->sysclk = pdata->sysclk;
+	mpc8260_spi->activate_cs = pdata->activate_cs;
+	mpc8260_spi->deactivate_cs = pdata->deactivate_cs;
+
+	/* Get resources(memory, IRQ) associated with the device. */
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (regs == NULL) {
+		dev_err(&pdev->dev, "regs resource not defined\n");
+		ret = -ENODEV;
+		goto free_master;
+	}
+	pram = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram");
+	if (pram == NULL) {
+		dev_err(&pdev->dev, "pram resource not defined\n");
+		ret = -ENODEV;
+		goto free_master;
+	}
+
+	mpc8260_spi->regs = ioremap(regs->start, regs->end - regs->start + 1);
+	if (mpc8260_spi->regs == NULL) {
+		ret = -ENOMEM;
+		goto put_master;
+	}
+	mpc8260_spi->pram = ioremap(pram->start, pram->end - pram->start + 1);
+	if (mpc8260_spi->pram == NULL) {
+		ret = -ENOMEM;
+		goto unmap_regs;
+	}
+
+	mpc8260_spi->irq = platform_get_irq(pdev, 0);
+	if (mpc8260_spi->irq < 0) {
+		dev_err(&pdev->dev, "irq resource not defined\n");
+		ret = -ENXIO;
+		goto unmap_pram;
+	}
+
+	/* Register SPI interrupt */
+	ret = request_irq(mpc8260_spi->irq, mpc8260_spi_irq,
+			  0, "mpc8260_spi", mpc8260_spi);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "cannot get irq\n");
+		goto unmap_pram;
+	}
+
+	/* SPI controller initializations */
+	ret = mpc8260_spi_init_cpm(mpc8260_spi);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "problem initializing the CPM\n");
+		goto free_irq;
+	}
+
+	ret = spi_register_master(master);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "problem registering spi master\n");
+		goto uninit_cpm;
+	}
+
+	printk(KERN_INFO
+	       "%s: MPC8260 SPI Controller driver at 0x%p (irq = %d)\n",
+	       pdev->dev.bus_id, mpc8260_spi->regs, mpc8260_spi->irq);
+
+	return 0;
+
+uninit_cpm:
+	mpc8260_spi_free_bufs(mpc8260_spi);
+free_irq:
+	free_irq(mpc8260_spi->irq, mpc8260_spi);
+unmap_pram:
+	iounmap(mpc8260_spi->pram);
+unmap_regs:
+	iounmap(mpc8260_spi->regs);
+put_master:
+	spi_master_put(master);
+free_master:
+	kfree(master);
+error:
+	return ret;
+}
+
+static int __devexit mpc8260_spi_remove(struct platform_device *dev)
+{
+	struct mpc8260_spi *mpc8260_spi;
+	struct spi_master *master;
+
+	master = platform_get_drvdata(dev);
+	mpc8260_spi = spi_master_get_devdata(master);
+
+	mpc8260_spi_free_bufs(mpc8260_spi);
+
+	free_irq(mpc8260_spi->irq, mpc8260_spi);
+	iounmap(mpc8260_spi->regs);
+	iounmap(mpc8260_spi->pram);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static struct platform_driver mpc8260_spi_driver = {
+	.probe = mpc8260_spi_probe,
+	.remove = __devexit_p(mpc8260_spi_remove),
+	.driver = {
+		   .name = "fsl-cpm-spi",
+	},
+};
+
+static int __init mpc8260_spi_init(void)
+{
+	return platform_driver_register(&mpc8260_spi_driver);
+}
+
+static void __exit mpc8260_spi_exit(void)
+{
+	platform_driver_unregister(&mpc8260_spi_driver);
+}
+
+module_init(mpc8260_spi_init);
+module_exit(mpc8260_spi_exit);
+
+MODULE_AUTHOR("Laurent Pinchart");
+MODULE_DESCRIPTION("MPC8260 SPI Driver");
+MODULE_LICENSE("GPL");

--Boundary-00=_kgb5EHx5l0Ky99Z--
