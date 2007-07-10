Return-Path: <wei.zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57CFFDDFB0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:37:49 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 4/4] Add DMA engine driver for Freescale MPC8xxx processors.
Date: Tue, 10 Jul 2007 17:45:26 +0800
Message-Id: <11840607262279-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This driver adopts DMA engine API, which could be used for
MEM<-->MEM, IO_ADDR<-->MEM and IO_ADDR<-->IO_ADDR data transfer.
This driver support both Basic and Extended chain mode of Freescale
MPC8xxx DMA controller.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
---
 drivers/dma/Kconfig  |    7 +
 drivers/dma/Makefile |    1 +
 drivers/dma/fsldma.c | 1074 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/fsldma.h |  161 ++++++++
 4 files changed, 1243 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/fsldma.c
 create mode 100644 drivers/dma/fsldma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 72be6c6..8102a0b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -32,4 +32,11 @@ config INTEL_IOATDMA
 	---help---
 	  Enable support for the Intel(R) I/OAT DMA engine.
 
+config FSL_DMA
+	bool "Freescale MPC8xxx DMA support"
+	depends on DMA_ENGINE && (PPC_86xx || PPC_85xx)
+	---help---
+	  Enable support for the Freescale DMA engine. Now, it support
+	  MPC8xxx processors.
+
 endmenu
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index bdcfdbd..7a28d5c 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_NET_DMA) += iovlock.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
+obj-$(CONFIG_FSL_DMA) += fsldma.o
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
new file mode 100644
index 0000000..f5a2a78
--- /dev/null
+++ b/drivers/dma/fsldma.c
@@ -0,0 +1,1074 @@
+/*
+ * Freescale MPC8xxx DMA Engine support
+ *
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author:
+ *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
+ *   Ebony Zhu <ebony.zhu@freescale.com>, May 2007
+ *
+ * Description:
+ *   DMA engine driver for Freescale MPC8xxx DMA controller, such as MPC85xx,
+ *   MPC86xx.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include "fsldma.h"
+
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+
+static LIST_HEAD(reserved_chan_list);
+
+#define to_fsl_chan(chan) container_of(chan, struct fsl_dma_chan, common)
+#define to_fsl_desc(lh) container_of(lh, struct fsl_desc_sw, node)
+
+#define FSL_SET_EOSIE(x) (x) = cpu_to_be64(be64_to_cpu(x) | FSL_DMA_EOSIE);
+#define FSL_CLR_EOSIE(x) (x) = cpu_to_be64(be64_to_cpu(x) & ~FSL_DMA_EOSIE);
+#define FSL_SET_EOL(x)   (x) = cpu_to_be64(be64_to_cpu(x) | FSL_DMA_EOL);
+#define FSL_CLR_EOL(x)   (x) = cpu_to_be64(be64_to_cpu(x) & ~FSL_DMA_EOL);
+
+#define INSERT_LD_RING(fsl_chan, desc, ld, reg)				\
+		(desc)->hw.ld.reg = cpu_to_be64(			\
+			(uint64_t)to_fsl_desc(list_ring_next(		\
+			&(desc)->node, &(fsl_chan)->ld_ring))->phys);	\
+		to_fsl_desc(list_ring_prev(&(desc)->node,		\
+			&(fsl_chan)->ld_ring))->hw.ld.reg		\
+				= cpu_to_be64((uint64_t)desc->phys);
+
+static inline int fsl_dma_idle(struct fsl_dma_chan *fsl_chan)
+{
+	return (((in_be32(&fsl_chan->reg_base->sr) & FSL_DMA_SR_CB) == 0) &&
+		((in_be32(&fsl_chan->reg_base->mr) & FSL_DMA_MR_CC) == 0));
+}
+
+static inline void fsl_dma_start(struct fsl_dma_chan *fsl_chan)
+{
+	if (fsl_dma_idle(fsl_chan))
+		setbits32(&fsl_chan->reg_base->mr, FSL_DMA_MR_CS);
+}
+
+static inline void fsl_dma_halt(struct fsl_dma_chan *fsl_chan)
+{
+	clrbits32(&fsl_chan->reg_base->mr, FSL_DMA_MR_CS);
+}
+
+static inline struct list_head *list_ring_next(struct list_head *cur,
+		struct list_head *head)
+{
+	return (cur->next == head) ? head->next : cur->next;
+}
+
+static inline struct list_head *list_ring_prev(struct list_head *cur,
+		struct list_head *head)
+{
+	return (cur->prev == head) ? head->prev : cur->prev;
+}
+
+/* Get current list physical address from DMA register */
+static inline dma_addr_t fsl_get_cur_list_pa(struct fsl_dma_chan *fsl_chan)
+{
+	return be64_to_cpu(
+			((uint64_t)in_be32(&fsl_chan->reg_base->eclsdar) << 32
+				| in_be32(&fsl_chan->reg_base->clsdar))
+			& FSL_DMA_NLDA_MASK);
+}
+
+/* Get current link physical address from DMA register */
+static inline dma_addr_t fsl_get_cur_link_pa(struct fsl_dma_chan *fsl_chan)
+{
+	return be64_to_cpu(
+			((uint64_t)in_be32(&fsl_chan->reg_base->eclndar) << 32
+				| in_be32(&fsl_chan->reg_base->clndar))
+			& FSL_DMA_NLDA_MASK);
+}
+/**
+ * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.
+ *
+ * Return - The descriptor allocated. NULL for failed.
+ */
+static struct fsl_desc_sw *fsl_dma_alloc_descriptor(struct dma_pool *pool,
+						gfp_t flags)
+{
+	dma_addr_t pdesc;
+	struct fsl_desc_sw *desc_sw;
+
+	desc_sw = dma_pool_alloc(pool, flags, &pdesc);
+	if (likely(desc_sw)) {
+		INIT_LIST_HEAD(&desc_sw->link_desc_head);
+		desc_sw->phys = pdesc;
+		desc_sw->cookie = 0;
+	}
+
+	return desc_sw;
+}
+
+#define FSLDMA_LD_INIT_RING_SIZE 64
+
+/**
+ * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
+ *
+ * This function will create a dma pool for descriptor allocation.
+ *
+ * Return - The number of descriptors allocated.
+ */
+static int fsl_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct fsl_desc_sw *desc;
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	int i;
+	LIST_HEAD(tmp_list);
+
+	/* We need the descriptor to be aligned to 32bytes
+	 * for meeting FSL DMA specification requirement.
+	 */
+	fsl_chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
+			fsl_chan->device->dev, sizeof(struct fsl_desc_sw),
+			32, 0);
+	if (unlikely(!fsl_chan->desc_pool)) {
+		dev_err(fsl_chan->device->dev, "No memory for channel %d "
+			"descriptor dma pool.\n", fsl_chan->id);
+		return 0;
+	}
+
+	/* Allocate list ring, and form the static list ring */
+	for (i = 0; i < FSLDMA_LD_INIT_RING_SIZE; i++) {
+		desc = fsl_dma_alloc_descriptor(fsl_chan->desc_pool,
+				GFP_KERNEL);
+
+		if (unlikely(!desc)) {
+			dev_err(fsl_chan->device->dev,
+				"Only %d initial descriptors\n", i);
+			break;
+		}
+#ifdef FSL_DMA_LD_DEBUG
+		dev_dbg(fsl_chan->device->dev, "new LD allocated %p\n", desc);
+#endif
+		list_add_tail(&desc->node, &fsl_chan->ld_ring);
+		/* Insert LD into the ring */
+		switch (fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			INSERT_LD_RING(fsl_chan, desc, list, next_ls_addr);
+			break;
+		case FSL_DMA_BASIC:
+			INSERT_LD_RING(fsl_chan, desc, link, next_ln_addr);
+			break;
+		}
+	}
+
+	return i;
+}
+
+/**
+ * fsl_dma_free_chan_resources - Free all resources of the channel.
+ */
+static void fsl_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsl_desc_sw *desc, *_desc;
+	struct fsl_desc_sw *linkdesc, *_linkdesc;
+	unsigned long flags;
+
+	dev_dbg(fsl_chan->device->dev, "Free all channel resources.\n");
+	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+	list_for_each_entry_safe(desc, _desc, &fsl_chan->ld_ring, node) {
+#ifdef FSL_DMA_LD_DEBUG
+		dev_dbg(fsl_chan->device->dev,
+				"LD %p will be released.\n", desc);
+#endif
+		switch (fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			/* Release link descriptors of list descriptor */
+			list_for_each_entry_safe(linkdesc, _linkdesc,
+				&desc->link_desc_head, node) {
+#ifdef FSL_DMA_LD_DEBUG
+				dev_dbg(fsl_chan->device->dev,
+					"link descriptor %p will be "
+					"released.\n", linkdesc);
+#endif
+				list_del(&linkdesc->node);
+				/* free link descriptor */
+				dma_pool_free(fsl_chan->desc_pool, linkdesc,
+					linkdesc->phys);
+			}
+			break;
+		case FSL_DMA_BASIC:
+			break;
+		}
+		list_del(&desc->node);
+		/* free list descritpor */
+		dma_pool_free(fsl_chan->desc_pool, desc, desc->phys);
+	}
+	/* Reset the enque and deque to the head of the ring */
+	fsl_chan->enque = &fsl_chan->ld_ring;
+	fsl_chan->deque = fsl_chan->enque;
+
+	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	dma_pool_destroy(fsl_chan->desc_pool);
+}
+
+/**
+ * do_fsl_dma_memcpy - The DMA core function to assign descriptors
+ *                     for preparing transfer.
+ *
+ * Return - The DMA transfer cookie.
+ */
+static dma_cookie_t do_fsl_dma_memcpy(struct fsl_dma_chan *fsl_chan,
+				      dma_addr_t dest,
+				      dma_addr_t src, size_t len,
+				      dma_xfer_callback cb, void *data)
+{
+	struct fsl_desc_sw *first = NULL, *prev = NULL, *list, *new;
+	size_t copy;
+	dma_cookie_t cookie;
+	unsigned long flags;
+	struct fsl_dma_device *fdev = fsl_chan->device;
+	int err = 0;
+	LIST_HEAD(link_chain);
+
+	if (unlikely(!fsl_chan || !dest || !src))
+		return -EFAULT;
+
+	if (unlikely(!len))
+		return fsl_chan->common.cookie;
+
+	dev_dbg(fdev->dev, "chan %d memcpy: src = %x, dest = %x, len = %d\n",
+					fsl_chan->id, src, dest, len);
+
+	dev_dbg(fdev->dev, "enque = %p, deque = %p\n",
+					fsl_chan->enque, fsl_chan->deque);
+
+	/* If the desc_ring is empty or there is no free node
+	 * in LD ring, we need to add the new node to LD
+	 * ring.
+	 */
+	if (unlikely(list_empty(&fsl_chan->ld_ring)
+		|| (list_ring_prev(fsl_chan->deque, &fsl_chan->ld_ring)
+			 == fsl_chan->enque))) {
+		struct fsl_desc_sw *ld;
+
+		dev_dbg(fdev->dev, "no free node in ld_ring, "
+				"new LD will be allocated.\n");
+		/* Allocate the ld descriptor*/
+		ld = fsl_dma_alloc_descriptor(fsl_chan->desc_pool,
+				GFP_ATOMIC);
+
+		if (unlikely(!ld)) {
+			dev_err(fdev->dev, "No free memory for LD.\n");
+			err = -ENOMEM;
+			goto out;
+		}
+		dev_dbg(fdev->dev, "new LD allocated %p\n", ld);
+		spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+		/* Stop the DMA */
+		fsl_dma_halt(fsl_chan);
+		/* Insert the ld descriptor to the LD ring */
+		list_add(&ld->node, fsl_chan->enque);
+		switch (fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			INSERT_LD_RING(fsl_chan, ld, list, next_ls_addr);
+			break;
+		case FSL_DMA_BASIC:
+			INSERT_LD_RING(fsl_chan, ld, link, next_ln_addr);
+			break;
+		}
+		spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	}
+
+	/* cookie incr and addition to used_list must be atomic */
+	cookie = fsl_chan->common.cookie;
+	cookie++;
+	if (cookie < 0)
+		cookie = 1;
+
+	if (fsl_chan->mode == FSL_DMA_BASIC)
+		spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+
+	do {
+		int alloc_ld = 0;
+		switch (fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			alloc_ld = 1;
+			break;
+		case FSL_DMA_BASIC:
+			alloc_ld = ((list_ring_prev(fsl_chan->deque,
+				&fsl_chan->ld_ring) == fsl_chan->enque));
+			break;
+		}
+		if (alloc_ld) {
+			/* Allocate the link descriptor from DMA pool */
+			new = fsl_dma_alloc_descriptor(fsl_chan->desc_pool,
+				GFP_ATOMIC);
+			if (unlikely(!new)) {
+				if (fsl_chan->mode == FSL_DMA_BASIC)
+					spin_unlock_irqrestore(
+						&fsl_chan->desc_lock, flags);
+				dev_err(fdev->dev,
+					"No free memory for link descriptor\n");
+				err = -ENOMEM;
+				goto out;
+			}
+			dev_dbg(fdev->dev, "new link desc alloc %p\n", new);
+		} else
+			new = to_fsl_desc(list_ring_next(fsl_chan->enque,
+						&fsl_chan->ld_ring));
+
+		copy = min(len, (size_t)FSL_DMA_BCR_MAX_CNT);
+		/* Initialize the link descriptor */
+		new->hw.link.count = cpu_to_be32(copy);
+		new->hw.link.src_addr = cpu_to_be32((uint32_t)src);
+		new->hw.link.dst_addr = cpu_to_be32((uint32_t)dest);
+		/* Read and write with snoop local processor */
+		new->hw.link.src_attr =	cpu_to_be32(
+					FSL_DMA_SATR_SREADTYPE_SNOOP_READ |
+					(((uint64_t)src >> 32) & 0x2ff));
+		new->hw.link.dst_attr =	cpu_to_be32(
+					FSL_DMA_DATR_DWRITETYPE_SNOOP_WRITE
+					| (((uint64_t)dest >> 32) & 0x2ff));
+
+		if (!first)
+			first = new;
+
+		switch (fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			if (prev)
+				prev->hw.link.next_ln_addr = cpu_to_be64(
+							(uint64_t)new->phys);
+			list_add_tail(&new->node, &link_chain);
+			break;
+		case FSL_DMA_BASIC:
+			new->cookie = cookie;
+			if (alloc_ld)
+				INSERT_LD_RING(fsl_chan, new, link,
+								next_ln_addr);
+			FSL_CLR_EOL(new->hw.link.next_ln_addr);
+			FSL_CLR_EOSIE(new->hw.link.next_ln_addr);
+			fsl_chan->enque = list_ring_next(fsl_chan->enque,
+						&fsl_chan->ld_ring);
+			break;
+		}
+
+		prev = new;
+
+		len -= copy;
+		dest += copy;
+		src += copy;
+	} while(len);
+
+	/* Set End-of-link to the last link descriptor */
+	FSL_SET_EOL(new->hw.link.next_ln_addr);
+
+	dev_dbg(fdev->dev, "assign cookie %d\n", cookie);
+	fsl_chan->common.cookie = cookie;
+
+	switch (fsl_chan->mode) {
+	case FSL_DMA_EXTENDED:
+		/* Add the link descriptors to list ring node */
+		spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+		/* Link first link address to the list node */
+		list = to_fsl_desc(list_ring_next(fsl_chan->enque,
+				&fsl_chan->ld_ring));
+		dev_dbg(fdev->dev, "list %p, ->phys=%x\n", list, list->phys);
+		dev_dbg(fdev->dev, "first link->phys=%x\n", first->phys);
+
+		list->hw.list.first_ln_addr = cpu_to_be64(
+						(uint64_t)first->phys);
+		list_splice_init(&link_chain, &list->link_desc_head);
+		list->cookie = cookie;
+
+		/* Hook the callback function */
+		if (cb) {
+			list->callback = cb;
+			list->cb_data = data;
+		}
+
+		/* Set End-of-List to the tail of list ring */
+		FSL_SET_EOL(list->hw.list.next_ls_addr);
+
+		/* Clear End-of-List to the previous list node in the ring */
+		FSL_CLR_EOL(to_fsl_desc(fsl_chan->enque)
+						->hw.list.next_ls_addr);
+		fsl_chan->enque = list_ring_next(fsl_chan->enque,
+						&fsl_chan->ld_ring);
+
+		if (!fsl_get_cur_list_pa(fsl_chan)) {
+			fsl_dma_halt(fsl_chan);
+			out_be32(&fsl_chan->reg_base->clsdar, (uint32_t)
+				to_fsl_desc(list_ring_prev(&list->node,
+					&fsl_chan->ld_ring))
+						->hw.list.next_ls_addr);
+			out_be32(&fsl_chan->reg_base->eclsdar, (uint32_t)
+				(to_fsl_desc(list_ring_prev(&list->node,
+						&fsl_chan->ld_ring))
+						->hw.list.next_ls_addr >> 32));
+			dev_dbg(fdev->dev, "set clsdar %08x, eclsdar %08x\n",
+					in_be32(&fsl_chan->reg_base->clsdar),
+					in_be32(&fsl_chan->reg_base->eclsdar));
+		}
+		break;
+	case FSL_DMA_BASIC:
+		/* Hook the callback function to the first link
+		 * descriptor of this transfer.
+		 */
+		if (cb) {
+			first->callback = cb;
+			first->cb_data = data;
+		}
+
+		/* Enable End-of-segment interrupt for
+		 * the last link descriptor.
+		 * (the previous node's next link descriptor)
+		 */
+		FSL_SET_EOSIE(to_fsl_desc(list_ring_prev(&new->node,
+				&fsl_chan->ld_ring))->hw.link.next_ln_addr);
+
+		/* Clear End-of-Link to the previous link node in the ring */
+		FSL_CLR_EOL(to_fsl_desc(list_ring_prev(&first->node,
+				&fsl_chan->ld_ring))->hw.link.next_ln_addr);
+
+		if (!fsl_get_cur_link_pa(fsl_chan)) {
+			out_be32(&fsl_chan->reg_base->clndar, (uint32_t)
+				to_fsl_desc(list_ring_prev(&first->node,
+					&fsl_chan->ld_ring))
+						->hw.link.next_ln_addr);
+			out_be32(&fsl_chan->reg_base->eclndar, (uint32_t)
+				(to_fsl_desc(
+					list_ring_prev(&first->node,
+						&fsl_chan->ld_ring))
+						->hw.link.next_ln_addr >> 32));
+			dev_dbg(fdev->dev, "set clndar %08x, eclndar %08x\n",
+					in_be32(&fsl_chan->reg_base->clndar),
+					in_be32(&fsl_chan->reg_base->eclndar));
+		}
+		break;
+	}
+	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	dev_dbg(fdev->dev, "enque updated = %p\n", fsl_chan->enque);
+out:
+	return cookie;
+}
+
+/**
+ * fsl_dma_raw_xfer - The function assigns descriptors for preparing
+ *                    raw transfer. dest and src both are physical
+ *                    address.
+ *
+ * Return - The DMA transfer cookie.
+ */
+static inline dma_cookie_t fsl_dma_raw_xfer(struct dma_chan *chan,
+				dma_addr_t dest, dma_addr_t src, size_t len,
+				dma_xfer_callback cb, void *data)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	return do_fsl_dma_memcpy(fsl_chan, dest, src, len, cb, data);
+}
+
+/**
+ * fsl_dma_memcpy_buf_to_buf - The function assigns descriptors
+ *                             for preparing buffer to buffer transfer.
+ *
+ * Return - The DMA transfer cookie.
+ */
+static dma_cookie_t fsl_dma_memcpy_buf_to_buf(struct dma_chan *chan,
+					      void *dest, void *src, size_t len)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	dma_addr_t dest_addr;
+	dma_addr_t src_addr;
+
+	dest_addr = dma_map_single(fsl_chan->device->dev, dest, len,
+			DMA_FROM_DEVICE);
+	src_addr = dma_map_single(fsl_chan->device->dev, src, len,
+			DMA_TO_DEVICE);
+
+	return do_fsl_dma_memcpy(fsl_chan, dest_addr, src_addr, len,
+				NULL, NULL);
+}
+
+/**
+ * fsl_dma_memcpy_buf_to_pg - The function assigns descriptors
+ *                            for preparing buffer to page transfer.
+ *
+ * Return - The DMA transfer cookie.
+ */
+static dma_cookie_t fsl_dma_memcpy_buf_to_pg(struct dma_chan *chan,
+                                              struct page *page,
+                                              unsigned int offset,
+                                              void *src,
+                                              size_t len)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	dma_addr_t dest_addr;
+	dma_addr_t src_addr;
+
+	dest_addr = dma_map_page(fsl_chan->device->dev, page, offset, len,
+			DMA_FROM_DEVICE);
+	src_addr = dma_map_single(fsl_chan->device->dev, src, len,
+			DMA_TO_DEVICE);
+
+	return do_fsl_dma_memcpy(fsl_chan, dest_addr, src_addr, len,
+				NULL, NULL);
+}
+
+/**
+ * fsl_dma_memcpy_pg_to_pg - The function assigns descriptors
+ *                           for preparing page to page transfer.
+ *
+ * Return - The DMA transfer cookie.
+ */
+static dma_cookie_t fsl_dma_memcpy_pg_to_pg(struct dma_chan *chan,
+                                             struct page *dest_pg,
+                                             unsigned int dest_off,
+                                             struct page *src_pg,
+                                             unsigned int src_off,
+                                             size_t len)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	dma_addr_t dest_addr;
+	dma_addr_t src_addr;
+
+	dest_addr = dma_map_page(fsl_chan->device->dev, dest_pg, dest_off, len,
+			DMA_FROM_DEVICE);
+	src_addr = dma_map_page(fsl_chan->device->dev, src_pg, src_off, len,
+			DMA_TO_DEVICE);
+
+	return do_fsl_dma_memcpy(fsl_chan, dest_addr, src_addr, len,
+				NULL, NULL);
+}
+
+/**
+ * fsl_dma_memcpy_issue_pending - Issue the DMA start command
+ */
+static void fsl_dma_memcpy_issue_pending(struct dma_chan *chan)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+
+#ifdef FSL_DMA_LD_DEBUG
+	struct fsl_desc_sw *list, *link;
+	if (fsl_chan->enque == fsl_chan->deque)
+		return;
+	dev_dbg(fsl_chan->device->dev, "--memcpy issue--\n");
+	list_for_each_entry(list, &fsl_chan->ld_ring, node) {
+		int i;
+		dev_dbg(fsl_chan->device->dev, "Ch %d, LD %08x\n",
+				fsl_chan->id, list->phys);
+		for (i = 0; i < 8; i++)
+			dev_dbg(fsl_chan->device->dev,
+					"LD offset %d: %08x\n",
+					i, *(((u32 *)&list->hw) + i));
+		list_for_each_entry(link, &list->link_desc_head, node) {
+			int j;
+			dev_dbg(fsl_chan->device->dev, "link %08x\n",
+					link->phys);
+			for (j = 0; j < 8; j++)
+				dev_dbg(fsl_chan->device->dev,
+						"  link offset %d: %08x\n", j,
+						*(((u32 *)&link->hw) + j));
+			dev_dbg(fsl_chan->device->dev, "  ----\n");
+		}
+	}
+	dev_dbg(fsl_chan->device->dev, "----------------\n");
+#endif
+
+	/* Start the DMA transfer */
+	if (fsl_chan->enque != fsl_chan->deque)
+		fsl_dma_start(fsl_chan);
+}
+
+/**
+ * fsl_dma_update_completed_cookie - Update the completed cookie.
+ */
+static void fsl_dma_update_completed_cookie(struct fsl_dma_chan *fsl_chan)
+{
+	struct fsl_desc_sw *cur_desc;
+	dma_addr_t ld_phy;
+
+	switch (fsl_chan->mode) {
+	case FSL_DMA_EXTENDED:
+		ld_phy = fsl_get_cur_list_pa(fsl_chan);
+		break;
+	case FSL_DMA_BASIC:
+		ld_phy = fsl_get_cur_link_pa(fsl_chan);
+		break;
+	}
+
+	if (ld_phy) {
+		cur_desc = (struct fsl_desc_sw *)bus_to_virt(ld_phy);
+
+		if (cur_desc->cookie) {
+			if (fsl_dma_idle(fsl_chan))
+				fsl_chan->completed_cookie = cur_desc->cookie;
+			else
+				fsl_chan->completed_cookie = cur_desc->cookie
+									- 1;
+		}
+	}
+}
+
+/**
+ * fsl_dma_is_complete -- Determine the DMA status
+ */
+static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
+                                            dma_cookie_t cookie,
+                                            dma_cookie_t *done,
+                                            dma_cookie_t *used)
+{
+	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	dma_cookie_t last_used;
+	dma_cookie_t last_complete;
+
+	fsl_dma_update_completed_cookie(fsl_chan);
+
+	last_used = chan->cookie;
+	last_complete = fsl_chan->completed_cookie;
+
+	if (done)
+		*done = last_complete;
+
+	if (used)
+		*used = last_used;
+
+	return dma_async_is_complete(cookie, last_complete, last_used);
+}
+
+/**
+ * fsl_dma_destroy - Destroy all fsl dma device resources and
+ *                    close the channel
+ */
+static void fsl_dma_destroy(struct fsl_dma_device *fdev)
+{
+	struct dma_chan *chan, *_chan;
+	if (!fdev)
+		return;
+
+	list_for_each_entry_safe(chan, _chan, &fdev->common.channels,
+				device_node) {
+		struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+		out_be32(&fsl_chan->reg_base->mr, 0);
+		free_irq(fsl_chan->irq, fsl_chan);
+		list_del(&chan->device_node);
+		kfree(fsl_chan);
+	}
+	kfree(fdev);
+}
+
+static irqreturn_t fsl_dma_do_interrupt(int irq, void *data)
+{
+	struct fsl_dma_chan *fsl_chan = (struct fsl_dma_chan *)data;
+	uint8_t stat;
+	int busy;
+	unsigned long flags;
+	struct fsl_desc_sw *desc, *_desc;
+	int need_dequeue = 0;
+	int end_of_transfer = 0;
+
+	stat = in_be32(&fsl_chan->reg_base->sr);
+	dev_dbg(fsl_chan->device->dev, "event: channel %d, stat = 0x%x\n",
+						fsl_chan->id, stat);
+	if (!stat)
+		return IRQ_NONE;
+	busy = stat & (FSL_DMA_SR_CB);
+	stat &= ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);
+
+	if (stat & FSL_DMA_SR_EOLNI) {
+		dev_dbg(fsl_chan->device->dev, "event: End-of-link INT\n");
+		stat &= ~FSL_DMA_SR_EOLNI;
+		setbits32(&fsl_chan->reg_base->sr, FSL_DMA_SR_EOLNI);
+		switch (fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			need_dequeue = 1;
+			break;
+		case FSL_DMA_BASIC:
+			end_of_transfer = 1;
+			break;
+		}
+	}
+
+	if (stat & FSL_DMA_SR_EOSI) {
+		dev_dbg(fsl_chan->device->dev, "event: End-of-segments INT\n");
+		dev_dbg(fsl_chan->device->dev, "event: clndar 0x%08x, "
+				"nlndar 0x%08x\n",
+				in_be32(&fsl_chan->reg_base->clndar),
+				in_be32(&fsl_chan->reg_base->nlndar));
+		stat &= ~FSL_DMA_SR_EOSI;
+		setbits32(&fsl_chan->reg_base->sr, FSL_DMA_SR_EOSI);
+		need_dequeue = 1;
+	}
+
+	if (stat & FSL_DMA_SR_EOLSI) {
+		dev_dbg(fsl_chan->device->dev, "event: End-of-list INT\n");
+		stat &= ~FSL_DMA_SR_EOLSI;
+		setbits32(&fsl_chan->reg_base->sr, FSL_DMA_SR_EOLSI);
+		end_of_transfer = 1;
+	}
+
+	/* If the ld descriptor transfer finishes,
+	 * we will recycle the used descriptor.
+	 */
+	if (need_dequeue) {
+		LIST_HEAD(recy_ln_chain);	/* LINK chain for recycle */
+		dev_dbg(fsl_chan->device->dev,
+				"event: enque = %p, deque = %p\n",
+				fsl_chan->enque, fsl_chan->deque);
+
+		fsl_dma_update_completed_cookie(fsl_chan);
+
+		spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+		dev_dbg(fsl_chan->device->dev,
+				"event: chan completed_cookie = %d\n",
+				fsl_chan->completed_cookie);
+		for (desc = to_fsl_desc(list_ring_next(fsl_chan->deque,
+					&fsl_chan->ld_ring));
+		     (desc->cookie > 0)
+			&& (desc->cookie <= fsl_chan->completed_cookie);
+		     fsl_chan->deque = &desc->node,
+		            desc = to_fsl_desc(list_ring_next(
+				fsl_chan->deque, &fsl_chan->ld_ring))) {
+			dev_dbg(fsl_chan->device->dev,
+					"..cookie %d cleaned\n", desc->cookie);
+			/* Add the link descriptors to recycle chain */
+			list_splice_init(&desc->link_desc_head, &recy_ln_chain);
+
+			/* Run the LD descriptor callback function */
+			if (desc->callback) {
+				spin_unlock_irqrestore(&fsl_chan->desc_lock,
+						flags);
+				desc->callback(&fsl_chan->common,
+						desc->cb_data);
+				desc->callback = NULL;
+				spin_lock_irqsave(&fsl_chan->desc_lock,
+						flags);
+			}
+			desc->cookie = 0;
+			fsl_chan->deque = &desc->node;
+		}
+		spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+
+		/* Now, free all list node from recycle chain */
+		list_for_each_entry_safe(desc, _desc, &recy_ln_chain, node) {
+			/* Recycle it! */
+			dev_dbg(fsl_chan->device->dev,
+				"event: link descriptor %p will be recycle.\n",
+				desc);
+			list_del(&desc->node);
+			dma_pool_free(fsl_chan->desc_pool, desc, desc->phys);
+		}
+		dev_dbg(fsl_chan->device->dev, "event: deque updated = %p\n",
+					fsl_chan->deque);
+	}
+
+	/* If it current transfer is the end-of-transfer,
+	 * we should clear the Channel Start bit for
+	 * prepare next transfer.
+	 */
+	if (end_of_transfer && !busy) {
+		fsl_dma_halt(fsl_chan);
+		/* If there still are some ld descriptors
+		 * not transfered in queue. We need start it.
+		 */
+		if (fsl_chan->enque != fsl_chan->deque) {
+			dev_dbg(fsl_chan->device->dev,
+				"event: Continue to xfer rest LDs\n");
+			switch (fsl_chan->mode) {
+			case FSL_DMA_EXTENDED:
+				out_be32(&fsl_chan->reg_base->clsdar,
+					in_be32(&fsl_chan->reg_base->nlsdar)
+					& FSL_DMA_NLDA_MASK);
+				out_be32(&fsl_chan->reg_base->eclsdar,
+					in_be32(&fsl_chan->reg_base->enlsdar));
+				break;
+			case FSL_DMA_BASIC:
+				out_be32(&fsl_chan->reg_base->clndar,
+					in_be32(&fsl_chan->reg_base->nlndar)
+					& FSL_DMA_NLDA_MASK);
+				out_be32(&fsl_chan->reg_base->eclndar,
+					in_be32(&fsl_chan->reg_base->enlndar));
+				break;
+			}
+			fsl_dma_start(fsl_chan);
+		} else {
+			out_be32(&fsl_chan->reg_base->clsdar, 0);
+			out_be32(&fsl_chan->reg_base->eclsdar, 0);
+			out_be32(&fsl_chan->reg_base->clndar, 0);
+			out_be32(&fsl_chan->reg_base->eclndar, 0);
+		}
+	}
+
+	if (stat)
+		dev_dbg(fsl_chan->device->dev, "event: unhandled sr 0x%02x\n", stat);
+	out_be32(&fsl_chan->reg_base->sr, stat);	/* Clean SR */
+
+	wake_up_interruptible(&fsl_chan->common.wait_q);
+
+	dev_dbg(fsl_chan->device->dev, "event: Exit\n");
+	return IRQ_HANDLED;
+}
+
+static int fsl_dma_self_test(struct fsl_dma_device *fdev)
+{
+	struct dma_chan *chan;
+	struct fsl_dma_chan *fsl_chan;
+	int err = 0;
+	dma_cookie_t cookie;
+	uint8_t src[1024], dest[1024];
+	int i;
+	size_t test_size;
+	DEFINE_WAIT(wait);
+
+	test_size = 1024;
+	for (i = 0; i < test_size; i++) {
+		src[i] = (uint8_t) i;
+	}
+
+	chan = container_of(fdev->common.channels.next,
+				struct dma_chan, device_node);
+	fsl_chan = to_fsl_chan(chan);
+
+	if (fsl_dma_alloc_chan_resources(chan) < 1) {
+		dev_err(fdev->dev,
+				"selftest: Can not alloc resources for DMA\n");
+		err = -ENODEV;
+		goto out;
+	}
+
+	cookie =
+	    fsl_dma_memcpy_buf_to_buf(chan, dest, src, 4);
+	cookie =
+	    fsl_dma_memcpy_buf_to_buf(chan, dest + 4, src + 4,
+				test_size / 2 - 4);
+	fsl_dma_memcpy_issue_pending(chan);
+	cookie =
+		fsl_dma_memcpy_buf_to_buf(chan, dest + test_size / 2,
+				src + test_size / 2, test_size / 2);
+	fsl_dma_memcpy_issue_pending(chan);
+#ifdef TEST_DMA_WAIT_Q
+	prepare_to_wait(&chan->common.wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (fsl_dma_is_complete(chan, cookie, NULL, NULL) != DMA_SUCCESS)
+		schedule();
+	finish_wait(&chan->common.wait_q, &wait);
+#else
+	while (fsl_dma_is_complete(chan, cookie, NULL, NULL)
+			!= DMA_SUCCESS);
+#endif
+	err = memcmp(src, dest, test_size);
+	if (err) {
+		for (i = 0; (*(src + i) == *(dest + i)) && (i < test_size);
+				i++);
+		dev_err(fdev->dev, "selftest: Test failed, data %d/%d is "
+				"error! src 0x%x, dest 0x%x\n",
+				i, test_size, *(src + i), *(dest + i));
+	}
+
+	fsl_dma_free_chan_resources(chan);
+
+out:
+	return err;
+}
+
+static struct dma_chan *of_find_dma_chan_by_phandle(phandle phandle)
+{
+	struct device_node *np;
+	struct dma_chan *chan;
+
+	np = of_find_node_by_phandle(phandle);
+	if (np)
+		list_for_each_entry(chan, &reserved_chan_list, device_node)
+			if (to_fsl_chan(chan)->np == np)
+				return chan;
+	return NULL;
+}
+EXPORT_SYMBOL(of_find_dma_chan_by_phandle);
+
+static int __devinit of_fsl_dma_probe(struct of_device *dev,
+			const struct of_device_id *match)
+{
+	int err;
+	int i;
+	struct fsl_dma_device *fdev;
+	struct device_node *chnode, *prev;
+	struct resource base;
+
+	fdev = kzalloc(sizeof(struct fsl_dma_device), GFP_KERNEL);
+	if (!fdev) {
+		dev_err(&dev->dev, "No enough memory for 'priv'\n");
+		err = -ENOMEM;
+		goto err;
+	}
+	fdev->dev = &dev->dev;
+	INIT_LIST_HEAD(&fdev->common.channels);
+
+	/* get dma controller register base */
+	err = of_address_to_resource(dev->node, 0, &base);
+	if (err) {
+		dev_err(&dev->dev, "Can't get %s property 'reg'\n",
+				dev->node->full_name);
+		goto err;
+	}
+
+	dev_info(&dev->dev,
+			"Probe the fsl,mpc8xxx-dma controller at 0x%08x...\n",
+			base.start);
+
+	/* get all channel data from of tree */
+	for (i = 0, chnode = of_get_next_child(dev->node, NULL);
+			chnode;
+			prev = chnode, i++,
+			chnode = of_get_next_child(dev->node, prev)) {
+		struct fsl_dma_chan *new_fsl_chan;
+		struct resource reg;
+		int cplen;
+		const int *extended;
+		const int *reserved;
+
+		/* get dma channel register base */
+		err = of_address_to_resource(chnode, 0, &reg);
+		if (err) {
+			dev_err(&dev->dev, "Can't get %s property 'reg'\n",
+					chnode->full_name);
+			goto err;
+		}
+
+		/* alloc channel */
+		new_fsl_chan = kzalloc(sizeof(struct fsl_dma_chan),
+					GFP_KERNEL);
+		if (!new_fsl_chan) {
+			dev_err(&dev->dev, "No free memory for allocating "
+					"dma channels!\n");
+			err = -ENOMEM;
+			goto err;
+		}
+		new_fsl_chan->np = chnode;
+
+		new_fsl_chan->device = fdev;
+		new_fsl_chan->id = (reg.start - base.end - 1) /
+				sizeof(struct fsl_dma_channel_regs);
+		new_fsl_chan->reg_base = ioremap(reg.start,
+						reg.end - reg.start + 1);
+		reserved = of_get_property(chnode, "reserved", &cplen);
+		extended = of_get_property(chnode, "extended", &cplen);
+		if (extended)
+			new_fsl_chan->mode = FSL_DMA_EXTENDED;
+		else
+			new_fsl_chan->mode = FSL_DMA_BASIC;
+
+		/* Reset the channel */
+		out_be32(&new_fsl_chan->reg_base->mr, 0);
+		/* Set the channel to below modes:
+		 * EIE - Error interrupt enable
+		 * EOSIE - End of segments interrupt enable (basic mode)
+		 * EOLNIE - End of links interrupt enable
+		 * EOLSIE - End of lists interrupt enable
+		 * XFE - Extended features enable
+		 */
+		switch (new_fsl_chan->mode) {
+		case FSL_DMA_EXTENDED:
+			out_be32(&new_fsl_chan->reg_base->mr, FSL_DMA_MR_EIE
+				| FSL_DMA_MR_EOLNIE | FSL_DMA_MR_EOLSIE
+				| FSL_DMA_MR_XFE);
+
+			/* Clear clsdar and eclsdar registers */
+			out_be32(&new_fsl_chan->reg_base->clsdar, 0);
+			out_be32(&new_fsl_chan->reg_base->eclsdar, 0);
+			break;
+		case FSL_DMA_BASIC:
+			out_be32(&new_fsl_chan->reg_base->mr, FSL_DMA_MR_EIE
+				| FSL_DMA_MR_EOLNIE | FSL_DMA_MR_EOSIE);
+
+			/* Clear clndar and eclndar registers */
+			out_be32(&new_fsl_chan->reg_base->clndar, 0);
+			out_be32(&new_fsl_chan->reg_base->eclndar, 0);
+			break;
+		default:
+			err = -EINVAL;
+			goto err;
+		}
+
+		spin_lock_init(&new_fsl_chan->desc_lock);
+		INIT_LIST_HEAD(&new_fsl_chan->ld_ring);
+
+		/* Link the enque and deque to the head of the ring */
+		new_fsl_chan->enque = &new_fsl_chan->ld_ring;
+		new_fsl_chan->deque = new_fsl_chan->enque;
+
+		new_fsl_chan->common.device = &fdev->common;
+		new_fsl_chan->common.client = NULL;
+		init_waitqueue_head(&new_fsl_chan->common.wait_q);
+		/* If this channel is not reserved,
+		 * add it to dma device channel list
+		 */
+		if (!reserved) {
+			list_add_tail(&new_fsl_chan->common.device_node,
+				      &fdev->common.channels);
+			fdev->common.chancnt++;
+		} else
+			list_add_tail(&new_fsl_chan->common.device_node,
+				      &reserved_chan_list);
+
+		new_fsl_chan->irq = irq_of_parse_and_map(chnode, 0);
+		err = request_irq(new_fsl_chan->irq, &fsl_dma_do_interrupt,
+				  IRQF_SHARED, "fsldma", new_fsl_chan);
+		if (err) {
+			dev_err(&dev->dev, "DMA channel %s request_irq error "
+				"with return %d\n", chnode->full_name, err);
+			goto err;
+		}
+		dev_info(&dev->dev, "Channel #%d (%s), irq %d, %s chain mode\n",
+					i, chnode->name, new_fsl_chan->irq,
+					extended ? "extended" : "basic");
+		if (reserved)
+			dev_info(&dev->dev, " -- reserved\n");
+		of_node_put(chnode);
+	}
+
+	fdev->common.device_alloc_chan_resources = fsl_dma_alloc_chan_resources;
+	fdev->common.device_free_chan_resources = fsl_dma_free_chan_resources;
+	fdev->common.device_raw_xfer = fsl_dma_raw_xfer;
+	fdev->common.device_memcpy_buf_to_buf = fsl_dma_memcpy_buf_to_buf;
+	fdev->common.device_memcpy_buf_to_pg = fsl_dma_memcpy_buf_to_pg;
+	fdev->common.device_memcpy_pg_to_pg = fsl_dma_memcpy_pg_to_pg;
+	fdev->common.device_memcpy_complete = fsl_dma_is_complete;
+	fdev->common.device_memcpy_issue_pending = fsl_dma_memcpy_issue_pending;
+
+	dev_set_drvdata(&(dev->dev), fdev);
+
+	fsl_dma_self_test(fdev);
+
+	dma_async_device_register(&fdev->common);
+	return 0;
+err:
+	fsl_dma_destroy(fdev);
+	return err;
+}
+
+static struct of_device_id of_fsl_dma_ids[] = {
+	{
+		.compatible = "fsl,mpc8xxx-dma",
+	},
+	{},
+};
+
+static struct of_platform_driver of_fsl_dma_driver = {
+	.name = "of-fsl-dma",
+	.match_table = of_fsl_dma_ids,
+	.probe = of_fsl_dma_probe,
+};
+
+static __init int of_fsl_dma_init(void)
+{
+	return of_register_platform_driver(&of_fsl_dma_driver);
+}
+
+device_initcall(of_fsl_dma_init);
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
new file mode 100644
index 0000000..b6d89bf
--- /dev/null
+++ b/drivers/dma/fsldma.h
@@ -0,0 +1,161 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author:
+ *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
+ *   Ebony Zhu <ebony.zhu@freescale.com>, May 2007
+ *
+ * Description:
+ *   This file defines data structures needed by Freescale
+ *   MPC8xxx DMA controller.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/device.h>
+#include <linux/dmapool.h>
+#include <linux/dmaengine.h>
+
+#define FSL_DMA_MR_CS		0x00000001
+#define FSL_DMA_MR_CC		0x00000002
+#define FSL_DMA_MR_EIE		0x00000040
+#define FSL_DMA_MR_XFE		0x00000020
+#define FSL_DMA_MR_EOLNIE	0x00000100
+#define FSL_DMA_MR_EOLSIE	0x00000080
+#define FSL_DMA_MR_EOSIE	0x00000200
+#define FSL_DMA_MR_CDSM		0x00000010
+#define FSL_DMA_MR_CTM		0x00000004
+
+#define FSL_DMA_SR_CH		0x00000020
+#define FSL_DMA_SR_CB		0x00000004
+#define FSL_DMA_SR_TE		0x00000080
+#define FSL_DMA_SR_EOSI		0x00000002
+#define FSL_DMA_SR_EOLSI	0x00000001
+#define FSL_DMA_SR_EOLNI	0x00000008
+
+#define FSL_DMA_SATR_SBPATMU			0x20000000
+#define FSL_DMA_SATR_STRANSINT_RIO		0x00c00000
+#define FSL_DMA_SATR_SREADTYPE_SNOOP_READ	0x00050000
+#define FSL_DMA_SATR_SREADTYPE_BP_IORH		0x00020000
+#define FSL_DMA_SATR_SREADTYPE_BP_NREAD		0x00040000
+#define FSL_DMA_SATR_SREADTYPE_BP_MREAD		0x00070000
+
+#define FSL_DMA_DATR_DBPATMU			0x20000000
+#define FSL_DMA_DATR_DTRANSINT_RIO		0x00c00000
+#define FSL_DMA_DATR_DWRITETYPE_SNOOP_WRITE	0x00050000
+#define FSL_DMA_DATR_DWRITETYPE_BP_FLUSH	0x00010000
+
+#define FSL_DMA_EOL		((uint64_t)0x1)
+#define FSL_DMA_EOSIE		0x8
+#define FSL_DMA_NLDA_MASK	(~(uint64_t)0x1f)
+
+#define FSL_DMA_BCR_MAX_CNT	((2 << 26) - 1)
+
+#define FSL_DMA_DGSR_TE		0x80
+#define FSL_DMA_DGSR_CH		0x20
+#define FSL_DMA_DGSR_PE		0x10
+#define FSL_DMA_DGSR_EOLNI	0x08
+#define FSL_DMA_DGSR_CB		0x04
+#define FSL_DMA_DGSR_EOSI	0x02
+#define FSL_DMA_DGSR_EOLSI	0x01
+
+enum fsl_dma_mode {
+	FSL_DMA_BASIC,		/* Basic chain mode,
+				 * only support link descriptor
+				 */
+	FSL_DMA_EXTENDED	/* Extended chain mode,
+				 * suport both list and link descriptor
+				 */
+};
+
+struct fsl_dma_list_descriptor {
+	__be64	next_ls_addr;
+	__be64	first_ln_addr;
+	__be32	src_stride;
+	__be32	dst_stride;
+	__be32	reserve[2];
+} __attribute__ ((aligned(32)));
+
+struct fsl_dma_link_descriptor {
+	__be32	src_attr;
+	__be32	src_addr;
+	__be32	dst_attr;
+	__be32	dst_addr;
+	__be64	next_ln_addr;
+	__be32	count;
+	__be32	reserve;
+} __attribute__ ((aligned(32)));
+
+struct fsl_desc_sw {
+	union {
+		struct fsl_dma_list_descriptor list;
+		struct fsl_dma_link_descriptor link;
+	} hw;
+	struct list_head node;
+	struct list_head link_desc_head;
+	dma_cookie_t cookie;
+	dma_addr_t phys;
+	void *priv;
+	dma_xfer_callback callback;
+	void *cb_data;
+} __attribute__ ((aligned(32)));
+
+struct fsl_dma_channel_regs {
+	__be32	mr;		/* 0x00 - Mode Register */
+	__be32	sr;		/* 0x04 - Status Register */
+	__be32	eclndar;	/* 0x08 - Current Link Descriptor Extended
+				 *        Address Register */
+	__be32	clndar;		/* 0x0c - Current Link Descriptor
+				 *        Address Register */
+	__be32	satr;		/* 0x10 - Source Attributes Register */
+	__be32	sar;		/* 0x14 - Source Address Register */
+	__be32	datr;		/* 0x18 - Destination Attributes Register */
+	__be32	dar;		/* 0x1c - Destination Address Register */
+	__be32	bcr;		/* 0x20 - Byte Count Register */
+	__be32	enlndar;	/* 0x24 - Next Link Descriptor Extended
+				 *        Address Register */
+	__be32	nlndar;		/* 0x28 - Next Link Descriptor
+				 *        Address Register */
+	uint8_t	res1[4];
+	__be32	eclsdar;	/* 0x30 - Current List Descriptor
+				 *        Entended Address Register */
+	__be32	clsdar;		/* 0x34 - Current List Alternate Base
+				 *        Descriptor Address Register */
+	__be32	enlsdar;	/* 0x38 - Next List Descriptor
+				 *        Extended Address Register */
+	__be32	nlsdar;		/* 0x3c - Next List Descriptor
+				 *        Address Register */
+	__be32	ssr;		/* 0x40 - Source Stride Register */
+	__be32	dsr;		/* 0x44 - Destination Stride Register */
+	uint8_t	res2[56];
+};
+
+struct fsl_dma_device {
+	struct device *dev;
+	struct dma_device common;
+};
+
+struct fsl_dma_chan {
+	/* The channel register point */
+	volatile struct fsl_dma_channel_regs __iomem *reg_base;
+
+	dma_cookie_t completed_cookie;   /* The maximum cookie completed */
+	spinlock_t desc_lock;
+	struct list_head ld_ring;        /* List/Link escritpors ring */
+	struct fsl_dma_device *device;
+	struct dma_chan common;
+	struct dma_pool *desc_pool;
+	struct list_head *enque;         /* Point to the last
+					  * list enqueue node
+					  */
+	struct list_head *deque;         /* Point to the last
+					  * list dequeue node
+					  */
+	enum fsl_dma_mode mode;
+	int irq;
+	int id;                          /* Raw id of this channel */
+	struct device_node *np;          /* Device node for OF tree */
+};
-- 
1.5.1
