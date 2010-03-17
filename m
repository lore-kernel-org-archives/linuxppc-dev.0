Return-Path: <temerkhanov@cifronik.ru>
Received: from cifronik.21th.com (cifronik.21th.com [62.16.86.116])
	by ozlabs.org (Postfix) with ESMTP id 97B30B7D2A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 05:29:28 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cifronic.local (Postfix) with ESMTP id 090A58952F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 21:17:35 +0300 (MSK)
Received: from mail.cifronic.local ([127.0.0.1])
	by localhost (server.cifronic.local [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 6Vw97F0wUP0n for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 21:17:30 +0300 (MSK)
Received: from satanklaus.localnet (satanklaus.cifronic.local [192.168.0.99])
	by mail.cifronic.local (Postfix) with ESMTPSA id CEF8C8952D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 21:17:30 +0300 (MSK)
From: Sergey Temerkhanov <temerkhanov@cifronik.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] [RFC] Xilinx MPMC SDMA subsystem
Date: Wed, 17 Mar 2010 21:18:41 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B0RoL0lPzetejVK"
Message-Id: <201003172118.41559.temerkhanov@cifronik.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Boundary-00=_B0RoL0lPzetejVK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds generic support for Xilinx MPMC SoftDMA channels which are 
used by, e.g., LLTEMAC and other IP cores (including custom cores). So, the 
implemented functions include only SDMA channels enumeration and control 
(finding device by phandle property, channel reset, initialization of RX/TX 
links, enabling/disabling IRQs,  IRQ coalescing control and submission of 
descriptors (struct sdma_desc).

The users of this subsystem are supposed to get the pointer to the struct 
sdma_device by phandle (using sdma_find_device() function), fill the struct 
sdma_client with pointers to the callback functions which are called on rx/tx 
completion, on error, and when sdma_reset is called by any client and then 
register the client with add_client() (sdma_del_client can be used to 
unregister the struct sdma_client)

Also, some auxiliary functions are provided to check the status of descriptors 
(busy, done, start of packet, end of packet).

The user is also responsible for maintenance of linked descriptors queue, 
proper initialization of their fields, and submission of the descriptors list 
to SDMA channel. IRQ acknowledge must be performed by user too (calling 
sdma_[rx|tx]_irq_ack respectively in [rx|tx]_complete callbacks). Also on RX 
side user must check the __be32 user[4] fields of descriptors to get the 
information supplied by SDMA channel.

This code uses SDMA channels in "Tail pointer fashion", i.e. the call to 
sdma_[rx|tx]_init is performed only once after reset and then only sdma_[rx|
tx]_submit calls are used to update the pointer to the last descriptor in SDMA 
channel.

Simple bus driver for MPMC is also added by this patch.

This code is in production use with our internal LLTEMAC driver implementation 
since 2008 and with a few custom cores drivers since 2009.

This code currently supports only soft MPMCs, i.e., only SDMA channels with 
memory-mapped registers. In order to support channels with DCR, a few 
modifications are needed.

Any comments and suggestions are appreciated.

Regards, Sergey Temerkhanov, Cifronic ZAO

--Boundary-00=_B0RoL0lPzetejVK
Content-Type: text/x-patch;
  charset="UTF-8";
  name="sdma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdma.patch"

* * *
* * *

diff --git a/arch/powerpc/include/asm/sdma.h b/arch/powerpc/include/asm/sdma.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/include/asm/sdma.h
@@ -0,0 +1,173 @@
+#ifndef __SDMA_H__
+#define __SDMA_H__
+
+/*
+ * SDMA subsystem support for Xilinx MPMC.
+ *
+ * Author: Sergey Temerkhanov
+ *
+ * Copyright (c) 2008-2010 Cifronic ZAO
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/dma-mapping.h>
+#include <asm/dcr.h>
+
+#define SDMA_ALIGNMENT	0x40
+
+struct sdma_desc {
+	__be32 next;
+	__be32 address;
+	__be32 length;
+	__be32 stat_ctl;
+	__be32 user[4];
+	void *virt;
+	u32 flags;
+} __attribute__((aligned(SDMA_ALIGNMENT)));
+
+
+enum {
+	SDMA_STSCTL_ERROR	= (1 << 31), /* DMA error */
+	SDMA_STSCTL_IOE		= (1 << 30), /* Interrupt on end */
+	SDMA_STSCTL_SOE		= (1 << 29), /* Stop on end */
+	SDMA_STSCTL_DONE	= (1 << 28), /* DMA completed */
+	SDMA_STSCTL_SOP		= (1 << 27), /* Start of packet */
+	SDMA_STSCTL_EOP		= (1 << 26), /* End of packet */
+	SDMA_STSCTL_BUSY	= (1 << 25), /* DMA busy */
+	SDMA_STSCTL_CSUM	= (1 << 0),  /* Checksum enable */
+
+	SDMA_STSCTL_MSK		= (0xFF << 24), /*Status/control field */
+};
+
+/* SDMA client operations */
+struct sdma_client {
+	void *data;
+	void (*tx_complete) (void *data);
+	void (*rx_complete) (void *data);
+	void (*error) (void *data);
+	void (*reset) (void *data);
+	struct list_head item;
+};
+
+struct sdma_coalesce {
+	int tx_threshold;
+	int tx_timeout;
+
+	int rx_threshold;
+	int rx_timeout;
+};
+
+#define DEFINE_SDMA_COALESCE(x) struct sdma_coalesce x = { \
+	.tx_timeout	= 0, \
+	.tx_threshold	= 1, \
+	.rx_timeout	= 0, \
+	.rx_threshold	= 1, };
+
+struct mpmc_device {
+	void __iomem		*ioaddr;
+
+	struct resource		memregion;
+	int			irq;
+
+	int			registered;
+	struct list_head	item;
+
+	struct mutex		devs_lock;
+	struct list_head	sdma_devs;
+};
+
+struct sdma_device {
+	void __iomem		*ioaddr;
+	wait_queue_head_t 	wait;
+
+	spinlock_t		lock;
+
+	dcr_host_t		dcr_host;
+
+	struct resource		memregion;
+	int			rx_irq;
+	int			tx_irq;
+	int			rx_ack;
+	int			tx_ack;
+	int			phandle;
+
+	int			registered;
+	struct mpmc_device	*parent;
+
+	struct sdma_coalesce	coal;
+	struct list_head	item;
+
+	struct mutex		clients_lock;
+	struct list_head	clients;
+};
+
+static inline void sdma_add_client(struct sdma_device *sdma, struct sdma_client *client)
+{
+	mutex_lock(&sdma->clients_lock);
+	list_add(&client->item, &sdma->clients);
+	mutex_unlock(&sdma->clients_lock);
+}
+
+static inline void sdma_del_client(struct sdma_device *sdma, struct sdma_client *client)
+{
+	mutex_lock(&sdma->clients_lock);
+	list_del(&client->item);
+	mutex_unlock(&sdma->clients_lock);
+}
+
+struct sdma_device *sdma_find_device(int phandle);
+void sdma_pause(struct sdma_device *sdma);
+void sdma_resume(struct sdma_device *sdma);
+void sdma_reset(struct sdma_device *sdma);
+void sdma_rx_init(struct sdma_device *sdma, dma_addr_t desc);
+void sdma_tx_init(struct sdma_device *sdma, dma_addr_t desc);
+
+int sdma_tx_submit(struct sdma_device *sdma, dma_addr_t desc);
+int sdma_rx_submit(struct sdma_device *sdma, dma_addr_t desc);
+
+void sdma_tx_irq_enable(struct sdma_device *sdma);
+void sdma_rx_irq_enable(struct sdma_device *sdma);
+void sdma_tx_irq_disable(struct sdma_device *sdma);
+void sdma_rx_irq_disable(struct sdma_device *sdma);
+void sdma_tx_irq_ack(struct sdma_device *sdma);
+void sdma_rx_irq_ack(struct sdma_device *sdma);
+
+int sdma_set_coalesce(struct sdma_device *sdma, struct sdma_coalesce *coal);
+int sdma_get_coalesce(struct sdma_device *sdma, struct sdma_coalesce *coal);
+
+static inline int sdma_desc_busy(struct sdma_desc *desc)
+{
+	return (be32_to_cpu(desc->stat_ctl) & SDMA_STSCTL_BUSY);
+}
+
+static inline int sdma_desc_done(struct sdma_desc *desc)
+{
+	return (be32_to_cpu(desc->stat_ctl) & SDMA_STSCTL_DONE);
+}
+
+static inline int sdma_desc_sop(struct sdma_desc *desc)
+{
+	return (be32_to_cpu(desc->stat_ctl) & SDMA_STSCTL_SOP);
+}
+
+static inline int sdma_desc_eop(struct sdma_desc *desc)
+{
+	return (be32_to_cpu(desc->stat_ctl) & SDMA_STSCTL_EOP);
+}
+
+static inline void sdma_set_ack(struct sdma_device *sdma, int rx_ack, int tx_ack)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&sdma->lock, flags);
+	sdma->rx_ack = rx_ack;
+	sdma->tx_ack = tx_ack;
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+#endif
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,7 +35,7 @@
 obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
-obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o sdma.o
 obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
diff --git a/arch/powerpc/sysdev/sdma.c b/arch/powerpc/sysdev/sdma.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/sysdev/sdma.c
@@ -0,0 +1,751 @@
+/*
+ * SDMA subsystem support for Xilinx MPMC.
+ *
+ * Author: Sergey Temerkhanov
+ *
+ * Copyright (c) 2008-2010 Cifronic ZAO
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <asm/io.h>
+#include <asm/sdma.h>
+
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#define DRV_VERSION "0.0.3"
+#define DRV_NAME "sdma"
+
+MODULE_AUTHOR ("Sergey Temerkhanov <temerkhanov@cifronik.ru>");
+MODULE_DESCRIPTION ("Xilinx SDMA driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+LIST_HEAD(mpmc_devs);
+DEFINE_MUTEX(mpmc_devs_lock);
+
+enum {
+	SDMA_TX_REGS	= 0x00,	/* TX channel registers beginning */
+	SDMA_RX_REGS	= 0x20,	/* RX channel registers beginning */
+	SDMA_DMACR	= 0x40,	/* DMA control register */
+
+	SDMA_NDESCR	= 0x00,	/* Next descriptor address */
+	SDMA_BUFA	= 0x04,	/* Current buffer address */
+	SDMA_BUFL	= 0x08,	/* Current buffer length */
+	SDMA_CDESCR	= 0x0C,	/* Current descriptor address */
+	SDMA_TDESCR	= 0x10,	/* Tail descriptor address */
+	SDMA_CR		= 0x14,	/* Channel control */
+	SDMA_IRQ	= 0x18,	/* Interrupt register */
+	SDMA_SR		= 0x1C,	/* Status */
+};
+
+enum {
+	SDMA_CR_IRQ_TIMEOUT_MSK	  = (0xFF << 24),	/* Interrupt coalesce timeout */
+	SDMA_CR_IRQ_THRESHOLD_MSK = (0xFF << 16),	/* Interrupt coalesce count */
+	SDMA_CR_MSB_ADDR_MSK	  = (0xF << 12),	/* MSB for 36 bit addressing */
+	SDMA_CR_APP_EN		  = (1 << 11),	/* Application data mask enable */
+	SDMA_CR_1_BIT_CNT	  = (1 << 10),	/* All interrupt counters are 1-bit */
+	SDMA_CR_INT_ON_END	  = (1 << 9),	/* Interrupt-on-end */
+	SDMA_CR_LD_IRQ_CNT	  = (1 << 8),	/* Load IRQ_COUNT */
+	SDMA_CR_IRQ_EN		  = (1 << 7),	/* Master interrupt enable */
+	SDMA_CR_IRQ_ERROR	  = (1 << 2),	/* Error interrupt enable */
+	SDMA_CR_IRQ_TIMEOUT	  = (1 << 1),	/* Coalesce timeout interrupt enable */
+	SDMA_CR_IRQ_THRESHOLD	  = (1 << 0),	/* Coalesce threshold interrupt enable */
+
+	SDMA_CR_IRQ_ALL		  = SDMA_CR_IRQ_EN | SDMA_CR_IRQ_ERROR |
+					SDMA_CR_IRQ_TIMEOUT | SDMA_CR_IRQ_THRESHOLD,
+
+	SDMA_CR_IRQ_TIMEOUT_SH	 = 24,
+	SDMA_CR_IRQ_THRESHOLD_SH = 16,
+	SDMA_CR_MSB_ADDR_SH	 = 12,
+
+	SDMA_IRQ_WRQ_EMPTY	= (1 << 14),	/* Write Command Queue Empty (rx) */
+	SDMA_IRQ_PLB_RD_ERROR	= (1 << 4),	/* PLB Read Error IRQ */
+	SDMA_IRQ_PLB_WR_ERROR	= (1 << 3),	/* PLB Write Error IRQ */
+	SDMA_IRQ_ERROR		= (1 << 2),	/* Error IRQ */
+	SDMA_IRQ_TIMEOUT	= (1 << 1),	/* Coalesce timeout IRQ */
+	SDMA_IRQ_THRESHOLD	= (1 << 0),	/* Coalesce threshold IRQ */
+
+	SDMA_IRQ_ALL_ERR	= 0x1C,		/* All error interrupt */
+	SDMA_IRQ_ALL		= 0x1F,		/* All interrupt bits */
+	SDMA_IRQ_ALL_DONE	= 0x3,		/* All work complete interrupt bits */
+
+
+#define SDMA_IRQ_COALESCE_COUNT(x)	((x >> 10) & 0xF)
+#define SDMA_IRQ_DELAY_COUNT(x)		((x >> 8) & 0x3)
+
+	SDMA_SR_ERR_TDESCR	= (1 << 21),	/* Tail descriptor pointer is invalid */
+	SDMA_SR_ERR_CMPL	= (1 << 20),	/* Complete bit is set */
+	SDMA_SR_ERR_BUFA	= (1 << 19),	/* Buffer address is invalid */
+	SDMA_SR_ERR_NDESCR	= (1 << 18),	/* Next descriptor pointer is invalid */
+	SDMA_SR_ERR_CDESCR	= (1 << 17),	/* Current descriptor pointer is invalid */
+	SDMA_SR_ERR_BUSYWR	= (1 << 16),	/* Current descriptor modified */
+	SDMA_SR_ERROR		= (1 << 7),	/* Error IRQ has occurred */
+	SDMA_SR_IRQ_ON_END	= (1 << 6),	/* On-end IRQ has occurred */
+	SDMA_SR_STOP_ON_END	= (1 << 5), 	/* Stop on end has occurred */
+	SDMA_SR_COMPLETED	= (1 << 4),	/* BD completed */
+	SDMA_SR_SOP		= (1 << 3),	/* Current BD has SOP set */
+	SDMA_SR_EOP		= (1 << 2),	/* Current BD has EOP set */
+	SDMA_SR_ENGINE_BUSY	= (1 << 1),	/* Channel is busy */
+	
+
+	SDMA_DMACR_TX_PAUSE	= (1 << 29),	/* Pause TX channel */
+	SDMA_DMACR_RX_PAUSE	= (1 << 28),	/* Pause RX channel */
+	SDMA_DMACR_PLB_ERR_DIS	= (1 << 5),	/* Disable PLB error detection */
+	SDMA_DMACR_RX_OVF_DIS	= (1 << 4),	/* Disable error on RX coalesce counter overflows */
+	SDMA_DMACR_TX_OVF_DIS	= (1 << 3),	/* Disable error on TX coalesce counter overflows */
+	SDMA_DMACR_TAIL_PTR_EN	= (1 << 2),	/* Enable use of tail pointer register */
+	SDMA_DMACR_EN_ARB_HOLD	= (1 << 1),	/* Enable arbitration hold */
+	SDMA_DMACR_RESET	= (1 << 0),	/* Reset both channels */
+};
+
+#if 1
+#  define debug(x...)	printk(KERN_DEBUG x)
+#else
+#  define debug(x...)
+#endif
+
+static inline void sdma_write_cr(struct sdma_device *sdma, u32 value)
+{
+	out_be32(sdma->ioaddr + SDMA_DMACR, value);
+}
+
+static inline u32 sdma_read_cr(struct sdma_device *sdma)
+{
+	return in_be32(sdma->ioaddr + SDMA_DMACR);
+}
+
+static inline void sdma_tx_out32(struct sdma_device *sdma, int reg, u32 value)
+{
+	out_be32(sdma->ioaddr + reg + SDMA_TX_REGS, value);
+}
+
+static inline u32 sdma_tx_in32(struct sdma_device *sdma, int reg)
+{
+	return in_be32(sdma->ioaddr + reg + SDMA_TX_REGS);
+}
+
+static inline void sdma_rx_out32(struct sdma_device *sdma, int reg, u32 value)
+{
+	out_be32(sdma->ioaddr + reg + SDMA_RX_REGS, value);
+}
+
+static inline u32 sdma_rx_in32(struct sdma_device *sdma, int reg)
+{
+	return in_be32(sdma->ioaddr + reg + SDMA_RX_REGS);
+}
+
+void sdma_reset(struct sdma_device *sdma)
+{
+	u32 rx_cr, tx_cr, rx_irq, tx_irq;
+
+	dma_addr_t curr_desc_rx;
+	dma_addr_t curr_desc_tx;
+	unsigned long flags;
+	struct sdma_client *client, *tmp;
+
+	DEFINE_SDMA_COALESCE(coal);
+	spin_lock_irqsave(&sdma->lock, flags);
+
+ 	curr_desc_rx= sdma_rx_in32(sdma, SDMA_CDESCR);
+	curr_desc_tx = sdma_tx_in32(sdma, SDMA_CDESCR);
+
+	sdma_write_cr(sdma, SDMA_DMACR_RESET);
+
+	while (sdma_read_cr(sdma) & SDMA_DMACR_RESET)
+		udelay(100);
+
+	rx_cr = sdma_rx_in32(sdma, SDMA_CR);
+	tx_cr = sdma_tx_in32(sdma, SDMA_CR);
+
+	sdma_rx_out32(sdma, SDMA_CR, rx_cr & ~SDMA_CR_IRQ_ALL);
+	sdma_tx_out32(sdma, SDMA_CR, tx_cr & ~SDMA_CR_IRQ_ALL);
+
+	rx_irq = sdma_rx_in32(sdma, SDMA_IRQ);
+	tx_irq = sdma_tx_in32(sdma, SDMA_IRQ);
+
+	sdma_rx_out32(sdma, SDMA_IRQ, rx_irq);
+	sdma_tx_out32(sdma, SDMA_IRQ, tx_irq);
+
+	sdma_write_cr(sdma, SDMA_DMACR_TAIL_PTR_EN |
+		SDMA_DMACR_RX_OVF_DIS | SDMA_DMACR_TX_OVF_DIS);
+
+	sdma_rx_out32(sdma, SDMA_CR, rx_cr | (SDMA_CR_IRQ_ALL & ~SDMA_CR_IRQ_EN));
+	sdma_tx_out32(sdma, SDMA_CR, tx_cr | (SDMA_CR_IRQ_ALL & ~SDMA_CR_IRQ_EN));
+
+	rx_cr = sdma_rx_in32(sdma, SDMA_CR);
+	sdma_rx_out32(sdma, SDMA_CR, rx_cr | SDMA_CR_IRQ_EN);
+	tx_cr = sdma_tx_in32(sdma, SDMA_CR);
+	sdma_tx_out32(sdma, SDMA_CR, tx_cr | SDMA_CR_IRQ_EN);
+
+	spin_unlock_irqrestore(&sdma->lock, flags);
+
+	list_for_each_entry_safe(client, tmp, &sdma->clients, item)
+		if (likely(client->reset))
+			client->reset(client->data);
+
+	sdma_set_coalesce(sdma, &coal);
+}
+
+void sdma_tx_irq_enable(struct sdma_device *sdma)
+{
+	u32 tx_cr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	tx_cr = sdma_tx_in32(sdma, SDMA_CR);
+	sdma_tx_out32(sdma, SDMA_CR, tx_cr | SDMA_CR_IRQ_EN);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_rx_irq_enable(struct sdma_device *sdma)
+{
+	u32 rx_cr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	rx_cr = sdma_rx_in32(sdma, SDMA_CR);
+	sdma_rx_out32(sdma, SDMA_CR, rx_cr | SDMA_CR_IRQ_EN);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_tx_irq_disable(struct sdma_device *sdma)
+{
+	u32 tx_cr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	tx_cr = sdma_tx_in32(sdma, SDMA_CR);
+	sdma_tx_out32(sdma, SDMA_CR, tx_cr & ~SDMA_CR_IRQ_EN);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_rx_irq_disable(struct sdma_device *sdma)
+{
+	u32 rx_cr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	rx_cr = sdma_rx_in32(sdma, SDMA_CR);
+	sdma_rx_out32(sdma, SDMA_CR, rx_cr & ~SDMA_CR_IRQ_EN);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_tx_irq_ack(struct sdma_device *sdma)
+{
+	u32 irq_stat;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	irq_stat = sdma_tx_in32(sdma, SDMA_IRQ);
+	sdma_tx_out32(sdma, SDMA_IRQ, irq_stat & SDMA_IRQ_ALL_DONE);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_rx_irq_ack(struct sdma_device *sdma)
+{
+	u32 irq_stat;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	irq_stat = sdma_rx_in32(sdma, SDMA_IRQ);
+	sdma_rx_out32(sdma, SDMA_IRQ, irq_stat & SDMA_IRQ_ALL_DONE);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_pause(struct sdma_device *sdma)
+{
+	u32 dmacr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	dmacr = sdma_read_cr(sdma);
+	dmacr |= SDMA_DMACR_TX_PAUSE | SDMA_DMACR_RX_PAUSE;
+	sdma_write_cr(sdma, dmacr);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+void sdma_resume(struct sdma_device *sdma)
+{
+	u32 dmacr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+	dmacr = sdma_read_cr(sdma);
+	dmacr &= ~(SDMA_DMACR_TX_PAUSE | SDMA_DMACR_RX_PAUSE);
+	sdma_write_cr(sdma, dmacr);
+	spin_unlock_irqrestore(&sdma->lock, flags);
+}
+
+int sdma_set_coalesce(struct sdma_device *sdma, struct sdma_coalesce *coal)
+{
+	u32 tx_cr, rx_cr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+
+	tx_cr = sdma_tx_in32(sdma, SDMA_CR);
+	rx_cr = sdma_rx_in32(sdma, SDMA_CR);
+
+	if (coal->tx_timeout > 255 ||
+	    coal->rx_timeout > 255 ||
+	    coal->tx_threshold > 255 ||
+	    coal->rx_threshold > 255)
+		return -EINVAL;
+
+	if (coal->tx_timeout == 0) {
+		coal->tx_timeout = 1;
+		tx_cr &= ~SDMA_CR_IRQ_TIMEOUT;
+	} else {
+		tx_cr |= SDMA_CR_IRQ_TIMEOUT;
+	}
+
+	if (coal->rx_timeout == 0) {
+		coal->rx_timeout = 1;
+		rx_cr &= ~SDMA_CR_IRQ_TIMEOUT;
+	} else {
+		rx_cr |= SDMA_CR_IRQ_TIMEOUT;
+	}
+
+	tx_cr &= ~(SDMA_CR_IRQ_THRESHOLD_MSK | SDMA_CR_IRQ_TIMEOUT_SH);
+	tx_cr |= (coal->tx_threshold << SDMA_CR_IRQ_THRESHOLD_SH) & SDMA_CR_IRQ_THRESHOLD_MSK;
+	tx_cr |= (coal->tx_timeout << SDMA_CR_IRQ_TIMEOUT_SH) & SDMA_CR_IRQ_TIMEOUT_MSK;
+	tx_cr |= SDMA_CR_LD_IRQ_CNT;
+
+
+	rx_cr &= ~(SDMA_CR_IRQ_THRESHOLD_MSK | SDMA_CR_IRQ_TIMEOUT_SH);
+	rx_cr |= (coal->rx_threshold << SDMA_CR_IRQ_THRESHOLD_SH) & SDMA_CR_IRQ_THRESHOLD_MSK;
+	rx_cr |= (coal->rx_timeout << SDMA_CR_IRQ_TIMEOUT_SH) & SDMA_CR_IRQ_TIMEOUT_MSK;
+	rx_cr |= SDMA_CR_LD_IRQ_CNT;
+
+	sdma_tx_out32(sdma, SDMA_CR, tx_cr);
+	sdma_rx_out32(sdma, SDMA_CR, rx_cr);
+
+	spin_unlock_irqrestore(&sdma->lock, flags);
+
+	return 0;
+}
+
+int sdma_get_coalesce(struct sdma_device *sdma, struct sdma_coalesce *coal)
+{
+	u32 tx_cr, rx_cr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdma->lock, flags);
+
+	tx_cr = sdma_tx_in32(sdma, SDMA_CR);
+	rx_cr = sdma_rx_in32(sdma, SDMA_CR);
+
+	coal->tx_threshold = (tx_cr & SDMA_CR_IRQ_THRESHOLD_MSK) >> SDMA_CR_IRQ_THRESHOLD_SH;
+	coal->tx_timeout = (tx_cr & SDMA_CR_IRQ_TIMEOUT_MSK) >> SDMA_CR_IRQ_TIMEOUT_SH;
+
+	coal->rx_threshold = (rx_cr & SDMA_CR_IRQ_THRESHOLD_MSK) >> SDMA_CR_IRQ_THRESHOLD_SH;
+	coal->rx_timeout = (rx_cr & SDMA_CR_IRQ_TIMEOUT_MSK) >> SDMA_CR_IRQ_TIMEOUT_SH;
+
+	if (!(tx_cr & SDMA_CR_IRQ_TIMEOUT))
+		coal->tx_timeout = 0;
+
+	if (!(rx_cr & SDMA_CR_IRQ_TIMEOUT))
+		coal->rx_timeout = 0;
+
+	spin_unlock_irqrestore(&sdma->lock, flags);
+
+	return 0;
+}
+
+int sdma_tx_submit(struct sdma_device *sdma, dma_addr_t desc)
+{
+	sdma_tx_out32(sdma, SDMA_TDESCR, desc);
+	return 0;
+}
+
+int sdma_rx_submit(struct sdma_device *sdma, dma_addr_t desc)
+{
+	sdma_rx_out32(sdma, SDMA_TDESCR, desc);
+	return 0;
+}
+
+void sdma_tx_init(struct sdma_device *sdma, dma_addr_t desc)
+{
+	sdma_tx_out32(sdma, SDMA_CDESCR, desc);
+	sdma_tx_out32(sdma, SDMA_TDESCR, desc);
+}
+
+void sdma_rx_init(struct sdma_device *sdma, dma_addr_t desc)
+{
+	sdma_rx_out32(sdma, SDMA_CDESCR, desc);
+	sdma_rx_out32(sdma, SDMA_TDESCR, desc);
+}
+
+
+struct sdma_device *sdma_find_device(int phandle)
+{
+	struct mpmc_device *mpmc;
+	struct sdma_device *sdma = NULL;
+	int found = 0;
+	mutex_lock(&mpmc_devs_lock);
+	list_for_each_entry(mpmc, &mpmc_devs, item) {
+		mutex_lock(&mpmc->devs_lock);
+		list_for_each_entry(sdma, &mpmc->sdma_devs, item) {
+			if (sdma->phandle == phandle) {
+				found = 1;
+				break;
+			}
+		}
+		mutex_unlock(&mpmc->devs_lock);
+		if (found)
+			break;
+		else
+			sdma = NULL;
+	}
+	mutex_unlock(&mpmc_devs_lock);
+	return sdma;
+}
+
+EXPORT_SYMBOL_GPL(sdma_find_device);
+EXPORT_SYMBOL_GPL(sdma_tx_submit);
+EXPORT_SYMBOL_GPL(sdma_rx_submit);
+EXPORT_SYMBOL_GPL(sdma_set_coalesce);
+EXPORT_SYMBOL_GPL(sdma_get_coalesce);
+EXPORT_SYMBOL_GPL(sdma_pause);
+EXPORT_SYMBOL_GPL(sdma_resume);
+EXPORT_SYMBOL_GPL(sdma_reset);
+EXPORT_SYMBOL_GPL(sdma_rx_init);
+EXPORT_SYMBOL_GPL(sdma_tx_init);
+EXPORT_SYMBOL_GPL(sdma_rx_irq_disable);
+EXPORT_SYMBOL_GPL(sdma_tx_irq_disable);
+EXPORT_SYMBOL_GPL(sdma_rx_irq_enable);
+EXPORT_SYMBOL_GPL(sdma_tx_irq_enable);
+EXPORT_SYMBOL_GPL(sdma_rx_irq_ack);
+EXPORT_SYMBOL_GPL(sdma_tx_irq_ack);
+
+static irqreturn_t sdma_rx_intr(int irq, void *dev_id)
+{
+	u32 irq_ack, status;
+	struct sdma_device *sdma = dev_id;
+	struct sdma_client *client, *tmp;
+
+	/* Read pending interrupts */
+	status = sdma_rx_in32(sdma, SDMA_IRQ);
+	irq_ack = status;
+	irq_ack &= sdma->rx_ack ? SDMA_IRQ_ALL : SDMA_IRQ_ALL_ERR;
+	sdma_rx_out32(sdma, SDMA_IRQ, irq_ack);
+
+	if (unlikely(status & SDMA_IRQ_ALL_ERR)) {
+		printk("%s: error status: %08x\n", __func__, status);
+		sdma_reset(sdma);
+		list_for_each_entry_safe(client, tmp, &sdma->clients, item)
+			if (likely(client->error))
+				client->error(client->data);
+		return IRQ_HANDLED;
+	}
+
+	if (likely(status & SDMA_IRQ_ALL_DONE)) {
+		list_for_each_entry_safe(client, tmp, &sdma->clients, item)
+			if (likely(client->rx_complete))
+				client->rx_complete(client->data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sdma_tx_intr(int irq, void *dev_id)
+{
+	u32 irq_ack, status;
+	struct sdma_device *sdma = dev_id;
+	struct sdma_client *client, *tmp;
+
+	/* Read pending interrupts */
+	status = sdma_tx_in32(sdma, SDMA_IRQ);
+	irq_ack = status;
+	irq_ack &= sdma->tx_ack ? SDMA_IRQ_ALL : SDMA_IRQ_ALL_ERR;
+	sdma_tx_out32(sdma, SDMA_IRQ, irq_ack);
+
+	if (unlikely(status & SDMA_IRQ_ALL_ERR)) {
+		printk("%s: error status: %08x\n", __func__, status);
+		sdma_reset(sdma);
+		list_for_each_entry_safe(client, tmp, &sdma->clients, item)
+			if (likely(client->error))
+				client->error(client->data);
+		return IRQ_HANDLED;
+	}
+
+	if (likely(status & SDMA_IRQ_ALL_DONE)) {
+		list_for_each_entry_safe(client, tmp, &sdma->clients, item)
+			if (likely(client->tx_complete))
+				client->tx_complete(client->data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void sdma_dev_register(struct mpmc_device *mpmc, struct sdma_device *sdma)
+{
+	mutex_lock(&mpmc->devs_lock);
+	list_add(&sdma->item, &mpmc->sdma_devs);
+	mutex_unlock(&mpmc->devs_lock);
+}
+
+static void sdma_dev_unregister(struct sdma_device *sdma)
+{
+	struct mpmc_device *mpmc = sdma->parent;
+
+	mutex_lock(&mpmc->devs_lock);
+	list_del(&sdma->item);
+	mutex_unlock(&mpmc->devs_lock);
+}
+
+static int sdma_of_remove(struct of_device* op)
+{
+	struct sdma_device *sdma = dev_get_drvdata(&op->dev);
+
+	if (sdma->tx_irq)
+		free_irq(sdma->tx_irq, sdma);
+
+	if (sdma->rx_irq)
+		free_irq(sdma->rx_irq, sdma);
+
+	if (sdma->memregion.start)
+		release_mem_region(sdma->memregion.start,
+			sdma->memregion.end - sdma->memregion.start + 1);
+
+	if (sdma->ioaddr)
+		iounmap(sdma->ioaddr);
+
+	sdma_dev_unregister(sdma);
+
+	kfree(sdma);
+
+	dev_set_drvdata(&op->dev, NULL);
+
+	return 0;
+}
+
+/* Match table for of_platform binding */
+static struct of_device_id sdma_of_match[] = {
+	{ .compatible = "xlnx,ll-dma-1.00.a" },
+	{},
+};
+
+static int __devinit sdma_of_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct sdma_device *sdma;
+	struct mpmc_device *mpmc;
+
+	const int *prop;
+	struct resource rx_irq, tx_irq, mem;
+	int res;
+
+	mpmc = dev_get_drvdata(op->dev.parent);
+
+	sdma = kzalloc(sizeof(struct sdma_device), GFP_KERNEL);
+
+	dev_set_drvdata(&op->dev, sdma);
+
+	spin_lock_init(&sdma->lock);
+
+	if (!sdma) {
+		dev_err(&op->dev, "Cannot allocate SDMA device\n");
+		return -ENOMEM;
+	}
+
+	res = of_address_to_resource(op->node, 0, &mem);
+	if(res) {
+		dev_err(&op->dev, "invalid address\n");
+		return res;
+	}
+
+	INIT_LIST_HEAD(&sdma->clients);
+	mutex_init(&sdma->clients_lock);
+	sdma->parent = mpmc;
+	/* IRQ */
+	res = of_irq_to_resource(op->node, 0, &rx_irq);
+	if(res == NO_IRQ) {
+		dev_err(&op->dev, "no RX IRQ assigned.\n");
+		return res;
+	}
+
+	res = of_irq_to_resource(op->node, 1, &tx_irq);
+	if(res == NO_IRQ) {
+		dev_err(&op->dev, "no TX IRQ assigned.\n");
+		return res;
+	}
+
+	prop = of_get_property(op->node, "linux,phandle", NULL);
+	sdma->phandle = (prop) ? *prop : -1;
+
+	if(!request_mem_region(mem.start, mem.end - mem.start + 1, DRV_NAME)) {
+		dev_err(&op->dev, "I/O memory region at %p is busy\n", (void *)mem.start);
+		sdma_of_remove(op);
+		return -EBUSY;
+	}
+
+	sdma->memregion = mem;
+	sdma->ioaddr = ioremap(mem.start, mem.end - mem.start + 1);
+
+	if (!sdma->ioaddr) {
+		dev_err(&op->dev, "Cannot ioremap() I/O memory %p\n", (void*)mem.start);
+		sdma_of_remove(op);
+		return -ENOMEM;
+	}
+
+	sdma_reset(sdma);
+
+	res = request_irq(rx_irq.start, sdma_rx_intr,
+			IRQF_SHARED, "SDMA RX", sdma);
+	if (res) {
+		dev_err(&op->dev, "Could not allocate RX interrupt %d.\n", rx_irq.start);
+		sdma_of_remove(op);
+		return res;
+	}
+
+	sdma->rx_irq = rx_irq.start;
+
+	res = request_irq(tx_irq.start, sdma_tx_intr,
+			IRQF_SHARED, "SDMA TX", sdma);
+	if (res) {
+		dev_err(&op->dev, "Could not allocate TX interrupt %d.\n", tx_irq.start);
+		sdma_of_remove(op);
+		return res;
+	}
+
+	sdma->tx_irq = tx_irq.start;
+
+	sdma->rx_ack = 1;
+	sdma->tx_ack = 1;
+	sdma_dev_register(mpmc, sdma);
+
+	return 0;
+}
+
+static struct of_platform_driver sdma_of_driver = {
+	.name		= "xilinx-sdma",
+	.match_table	= sdma_of_match,
+	.probe		= sdma_of_probe,
+	.remove		= sdma_of_remove,
+};
+
+int __init sdma_of_init(void)
+{
+	int ret;
+
+	ret = of_register_platform_driver(&sdma_of_driver);
+	if (ret) {
+		of_unregister_platform_driver(&sdma_of_driver);
+		printk(KERN_ERR "registering driver failed: err=%i", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void sdma_of_exit(void)
+{
+	of_unregister_platform_driver(&sdma_of_driver);
+}
+
+
+static void mpmc_dev_register(struct mpmc_device *mpmc)
+{
+	mutex_lock(&mpmc_devs_lock);
+	list_add_tail(&mpmc->item, &mpmc_devs);
+	mutex_unlock(&mpmc_devs_lock);
+}
+
+static void mpmc_dev_unregister(struct mpmc_device *mpmc)
+{
+	mutex_lock(&mpmc_devs_lock);
+	list_del(&mpmc->item);
+	mutex_unlock(&mpmc_devs_lock);
+}
+
+static int mpmc_of_remove(struct of_device *op)
+{
+	struct mpmc_device *mpmc = dev_get_drvdata(&op->dev);
+	struct device_node *node;
+	struct of_device *ofdev;
+	
+	for_each_child_of_node(op->node, node) {
+		ofdev = of_find_device_by_node(node);
+		of_device_unregister(ofdev);
+		of_device_free(ofdev);
+	}
+
+	if (mpmc->registered)
+		mpmc_dev_unregister(mpmc);
+
+	kfree(mpmc);
+	dev_set_drvdata(&op->dev, NULL);
+	return 0;
+}
+
+static int __devinit mpmc_of_probe(struct of_device *op,
+			const struct of_device_id *match)
+{
+	struct mpmc_device *mpmc;
+
+	mpmc = kzalloc(sizeof(struct mpmc_device), GFP_KERNEL);
+
+	if (!mpmc) {
+		dev_err(&op->dev, "Cannot allocate MPMC device\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&op->dev, mpmc);
+
+	INIT_LIST_HEAD(&mpmc->sdma_devs);
+	mutex_init(&mpmc->devs_lock);
+
+	mpmc_dev_register(mpmc);
+
+	mpmc->registered = 1;
+
+	of_platform_bus_probe(op->node, sdma_of_match, &op->dev);
+
+	return 0;
+}
+
+static struct of_device_id  __devinitdata mpmc_of_match[] = {
+	{ .compatible = "xlnx,mpmc-4.01.a" },
+	{ .compatible = "xlnx,mpmc-4.03.a" },
+	{},
+};
+
+static struct of_platform_driver mpmc_of_driver = {
+	.name = "xilinx-mpmc",
+	.match_table = mpmc_of_match,
+	.probe = mpmc_of_probe,
+	.remove	= mpmc_of_remove,
+};
+
+int __init mpmc_of_init(void)
+{
+	return of_register_platform_driver(&mpmc_of_driver);
+}
+
+void mpmc_cleanup(void)
+{
+}
+
+void mpmc_of_exit(void)
+{
+	mpmc_cleanup();
+	of_unregister_platform_driver(&mpmc_of_driver);
+}
+
+subsys_initcall(mpmc_of_init);
+subsys_initcall(sdma_of_init);

--Boundary-00=_B0RoL0lPzetejVK--
