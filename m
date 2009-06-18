Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EF09EB729B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 08:53:49 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 01D8EDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 08:53:48 +1000 (EST)
Date: Thu, 18 Jun 2009 15:53:45 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>
Subject: [PATCH v2] fsldma: Add DMA_SLAVE support
Message-ID: <20090618225345.GB16741@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
scatterlist into an arbitrary list of hardware address/length pairs.

This allows a single DMA transaction to copy data from several different
devices into a scatterlist at the same time.

This also adds support to enable some controller-specific features such as
external start and external pause for a DMA transaction.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

After discussion with Dan Williams, this is the second version of the
DMA_SLAVE API for the Freescale DMA controller. I've tested it heavily
with both drivers I have written against this API, an FPGA programmer
and an FPGA data grabber.

Kumar, Dan asked me to add you to the CC list, so you can have a look at
this patch before he adds it to his tree.

The other two small patches I posted earlier are very helpful in testing
this functionality. They make the fsldma driver leave the BWC (bandwidth
control) bits alone on the 83xx controller, as well as making the
external start feature available on 83xx.

In order for the external start/pause features to be useful, the
bandwidth control bits (in the mode register) need to be set before
attempting to use the controller. I could spin a v3 of this patch that
adds a field to struct fsl_dma_slave to set the bits appropriately. Or I
could send another patch for that. Thoughts?

Many thanks to all that have participated in the discussion about this
patch.

v1 -> v2:
* move fsldma.h from include/linux to arch/powerpc/include/asm
* add kerneldoc documentation

 arch/powerpc/include/asm/fsldma.h |  134 ++++++++++++++++++++++
 drivers/dma/fsldma.c              |  224 +++++++++++++++++++++++++++++++++++++
 2 files changed, 358 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsldma.h

diff --git a/arch/powerpc/include/asm/fsldma.h b/arch/powerpc/include/asm/fsldma.h
new file mode 100644
index 0000000..1bc71fb
--- /dev/null
+++ b/arch/powerpc/include/asm/fsldma.h
@@ -0,0 +1,134 @@
+/*
+ * Freescale MPC83XX / MPC85XX DMA Controller
+ *
+ * Copyright (c) 2009 Ira W. Snyder <iws@ovro.caltech.edu>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ARCH_POWERPC_ASM_FSLDMA_H__
+#define __ARCH_POWERPC_ASM_FSLDMA_H__
+
+#include <linux/dmaengine.h>
+
+/*
+ * Definitions for the Freescale DMA controller's DMA_SLAVE implemention
+ *
+ * The Freescale DMA_SLAVE implementation was designed to handle many-to-many
+ * transfers. An example usage would be an accelerated copy between two
+ * scatterlists. Another example use would be an accelerated copy from
+ * multiple non-contiguous device buffers into a single scatterlist.
+ *
+ * A DMA_SLAVE transaction is defined by a struct fsl_dma_slave. This
+ * structure contains a list of hardware addresses that should be copied
+ * to/from the scatterlist passed into device_prep_slave_sg(). The structure
+ * also has some fields to enable hardware-specific features.
+ */
+
+/**
+ * struct fsl_dma_hw_addr
+ * @entry: linked list entry
+ * @address: the hardware address
+ * @length: length to transfer
+ *
+ * Holds a single physical hardware address / length pair for use
+ * with the DMAEngine DMA_SLAVE API.
+ */
+struct fsl_dma_hw_addr {
+	struct list_head entry;
+
+	dma_addr_t address;
+	size_t length;
+};
+
+/**
+ * struct fsl_dma_slave
+ * @addresses: a linked list of struct fsl_dma_hw_addr structures
+ * @src_loop_size: setup and enable constant source-address DMA transfers
+ * @dst_loop_size: setup and enable constant destination address DMA transfers
+ * @external_start: enable externally started DMA transfers
+ * @external_pause: enable externally paused DMA transfers
+ *
+ * Holds a list of address / length pairs for use with the DMAEngine
+ * DMA_SLAVE API implementation for the Freescale DMA controller.
+ */
+struct fsl_dma_slave {
+
+	/* List of hardware address/length pairs */
+	struct list_head addresses;
+
+	/* Support for extra controller features */
+	unsigned int src_loop_size;
+	unsigned int dst_loop_size;
+	bool external_start;
+	bool external_pause;
+};
+
+/**
+ * fsl_dma_slave_append - add an address/length pair to a struct fsl_dma_slave
+ * @slave: the &struct fsl_dma_slave to add to
+ * @address: the hardware address to add
+ * @length: the length of bytes to transfer from @address
+ *
+ * Add a hardware address/length pair to a struct fsl_dma_slave. Returns 0 on
+ * success, -ERRNO otherwise.
+ */
+static inline int fsl_dma_slave_append(struct fsl_dma_slave *slave,
+				       dma_addr_t address, size_t length)
+{
+	struct fsl_dma_hw_addr *addr;
+
+	addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
+	if (!addr)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&addr->entry);
+	addr->address = address;
+	addr->length = length;
+
+	list_add_tail(&addr->entry, &slave->addresses);
+	return 0;
+}
+
+/**
+ * fsl_dma_slave_free - free a struct fsl_dma_slave
+ * @slave: the struct fsl_dma_slave to free
+ *
+ * Free a struct fsl_dma_slave and all associated address/length pairs
+ */
+static inline void fsl_dma_slave_free(struct fsl_dma_slave *slave)
+{
+	struct fsl_dma_hw_addr *addr, *tmp;
+
+	if (slave) {
+		list_for_each_entry_safe(addr, tmp, &slave->addresses, entry) {
+			list_del(&addr->entry);
+			kfree(addr);
+		}
+
+		kfree(slave);
+	}
+}
+
+/**
+ * fsl_dma_slave_alloc - allocate a struct fsl_dma_slave
+ * @gfp: the flags to pass to kmalloc when allocating this structure
+ *
+ * Allocate a struct fsl_dma_slave for use by the DMA_SLAVE API. Returns a new
+ * struct fsl_dma_slave on success, or NULL on failure.
+ */
+static inline struct fsl_dma_slave *fsl_dma_slave_alloc(gfp_t gfp)
+{
+	struct fsl_dma_slave *slave;
+
+	slave = kzalloc(sizeof(*slave), gfp);
+	if (!slave)
+		return NULL;
+
+	INIT_LIST_HEAD(&slave->addresses);
+	return slave;
+}
+
+#endif /* __ARCH_POWERPC_ASM_FSLDMA_H__ */
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index f18d1bd..67c3c47 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -29,6 +29,7 @@
 #include <linux/dmapool.h>
 #include <linux/of_platform.h>
 
+#include <asm/fsldma.h>
 #include "fsldma.h"
 
 static void dma_init(struct fsl_dma_chan *fsl_chan)
@@ -531,6 +532,226 @@ fail:
 }
 
 /**
+ * fsl_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
+ * @chan: DMA channel
+ * @sgl: scatterlist to transfer to/from
+ * @sg_len: number of entries in @scatterlist
+ * @direction: DMA direction
+ * @flags: DMAEngine flags
+ *
+ * Prepare a set of descriptors for a DMA_SLAVE transaction. Following the
+ * DMA_SLAVE API, this gets the device-specific information from the
+ * chan->private variable.
+ */
+static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
+	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
+	enum dma_data_direction direction, unsigned long flags)
+{
+	struct fsl_dma_chan *fsl_chan;
+	struct fsl_desc_sw *first = NULL, *prev = NULL, *new = NULL;
+	struct fsl_dma_slave *slave;
+	struct list_head *tx_list;
+	size_t copy;
+
+	int i;
+	struct scatterlist *sg;
+	size_t sg_used;
+	size_t hw_used;
+	struct fsl_dma_hw_addr *hw;
+	dma_addr_t dma_dst, dma_src;
+
+	if (!chan)
+		return NULL;
+
+	if (!chan->private)
+		return NULL;
+
+	fsl_chan = to_fsl_chan(chan);
+	slave = chan->private;
+
+	if (list_empty(&slave->addresses))
+		return NULL;
+
+	hw = list_first_entry(&slave->addresses, struct fsl_dma_hw_addr, entry);
+	hw_used = 0;
+
+	/*
+	 * Build the hardware transaction to copy from the scatterlist to
+	 * the hardware, or from the hardware to the scatterlist
+	 *
+	 * If you are copying from the hardware to the scatterlist and it
+	 * takes two hardware entries to fill an entire page, then both
+	 * hardware entries will be coalesced into the same page
+	 *
+	 * If you are copying from the scatterlist to the hardware and a
+	 * single page can fill two hardware entries, then the data will
+	 * be read out of the page into the first hardware entry, and so on
+	 */
+	for_each_sg(sgl, sg, sg_len, i) {
+		sg_used = 0;
+
+		/* Loop until the entire scatterlist entry is used */
+		while (sg_used < sg_dma_len(sg)) {
+
+			/*
+			 * If we've used up the current hardware address/length
+			 * pair, we need to load a new one
+			 *
+			 * This is done in a while loop so that descriptors with
+			 * length == 0 will be skipped
+			 */
+			while (hw_used >= hw->length) {
+
+				/*
+				 * If the current hardware entry is the last
+				 * entry in the list, we're finished
+				 */
+				if (list_is_last(&hw->entry, &slave->addresses))
+					goto finished;
+
+				/* Get the next hardware address/length pair */
+				hw = list_entry(hw->entry.next,
+						struct fsl_dma_hw_addr, entry);
+				hw_used = 0;
+			}
+
+			/* Allocate the link descriptor from DMA pool */
+			new = fsl_dma_alloc_descriptor(fsl_chan);
+			if (!new) {
+				dev_err(fsl_chan->dev, "No free memory for "
+						       "link descriptor\n");
+				goto fail;
+			}
+#ifdef FSL_DMA_LD_DEBUG
+			dev_dbg(fsl_chan->dev, "new link desc alloc %p\n", new);
+#endif
+
+			/*
+			 * Calculate the maximum number of bytes to transfer,
+			 * making sure it is less than the DMA controller limit
+			 */
+			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
+					     hw->length - hw_used);
+			copy = min_t(size_t, copy, FSL_DMA_BCR_MAX_CNT);
+
+			/*
+			 * DMA_FROM_DEVICE
+			 * from the hardware to the scatterlist
+			 *
+			 * DMA_TO_DEVICE
+			 * from the scatterlist to the hardware
+			 */
+			if (direction == DMA_FROM_DEVICE) {
+				dma_src = hw->address + hw_used;
+				dma_dst = sg_dma_address(sg) + sg_used;
+			} else {
+				dma_src = sg_dma_address(sg) + sg_used;
+				dma_dst = hw->address + hw_used;
+			}
+
+			/* Fill in the descriptor */
+			set_desc_cnt(fsl_chan, &new->hw, copy);
+			set_desc_src(fsl_chan, &new->hw, dma_src);
+			set_desc_dest(fsl_chan, &new->hw, dma_dst);
+
+			/*
+			 * If this is not the first descriptor, chain the
+			 * current descriptor after the previous descriptor
+			 */
+			if (!first) {
+				first = new;
+			} else {
+				set_desc_next(fsl_chan, &prev->hw,
+					      new->async_tx.phys);
+			}
+
+			new->async_tx.cookie = 0;
+			async_tx_ack(&new->async_tx);
+
+			prev = new;
+			sg_used += copy;
+			hw_used += copy;
+
+			/* Insert the link descriptor into the LD ring */
+			list_add_tail(&new->node, &first->async_tx.tx_list);
+		}
+	}
+
+finished:
+
+	/* All of the hardware address/length pairs had length == 0 */
+	if (!first || !new)
+		return NULL;
+
+	new->async_tx.flags = flags;
+	new->async_tx.cookie = -EBUSY;
+
+	/* Set End-of-link to the last link descriptor of new list */
+	set_ld_eol(fsl_chan, new);
+
+	/* Enable extra controller features */
+	if (fsl_chan->set_src_loop_size)
+		fsl_chan->set_src_loop_size(fsl_chan, slave->src_loop_size);
+
+	if (fsl_chan->set_dest_loop_size)
+		fsl_chan->set_dest_loop_size(fsl_chan, slave->dst_loop_size);
+
+	if (fsl_chan->toggle_ext_start)
+		fsl_chan->toggle_ext_start(fsl_chan, slave->external_start);
+
+	if (fsl_chan->toggle_ext_pause)
+		fsl_chan->toggle_ext_pause(fsl_chan, slave->external_pause);
+
+	return &first->async_tx;
+
+fail:
+	/* If first was not set, then we failed to allocate the very first
+	 * descriptor, and we're done */
+	if (!first)
+		return NULL;
+
+	/*
+	 * First is set, so all of the descriptors we allocated have been added
+	 * to first->async_tx.tx_list, INCLUDING "first" itself. Therefore we
+	 * must traverse the list backwards freeing each descriptor in turn
+	 *
+	 * We're re-using variables for the loop, oh well
+	 */
+	tx_list = &first->async_tx.tx_list;
+	list_for_each_entry_safe_reverse(new, prev, tx_list, node) {
+		list_del_init(&new->node);
+		dma_pool_free(fsl_chan->desc_pool, new, new->async_tx.phys);
+	}
+
+	return NULL;
+}
+
+static void fsl_dma_device_terminate_all(struct dma_chan *chan)
+{
+	struct fsl_dma_chan *fsl_chan;
+	struct fsl_desc_sw *desc, *tmp;
+	unsigned long flags;
+
+	if (!chan)
+		return;
+
+	fsl_chan = to_fsl_chan(chan);
+
+	/* Halt the DMA engine */
+	dma_halt(fsl_chan);
+
+	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+
+	/* Remove and free all of the descriptors in the LD queue */
+	list_for_each_entry_safe(desc, tmp, &fsl_chan->ld_queue, node) {
+		list_del(&desc->node);
+		dma_pool_free(fsl_chan->desc_pool, desc, desc->async_tx.phys);
+	}
+
+	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+}
+
+/**
  * fsl_dma_update_completed_cookie - Update the completed cookie.
  * @fsl_chan : Freescale DMA channel
  */
@@ -955,12 +1176,15 @@ static int __devinit of_fsl_dma_probe(struct of_device *dev,
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
+	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
 	fdev->common.device_alloc_chan_resources = fsl_dma_alloc_chan_resources;
 	fdev->common.device_free_chan_resources = fsl_dma_free_chan_resources;
 	fdev->common.device_prep_dma_interrupt = fsl_dma_prep_interrupt;
 	fdev->common.device_prep_dma_memcpy = fsl_dma_prep_memcpy;
 	fdev->common.device_is_tx_complete = fsl_dma_is_complete;
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
+	fdev->common.device_prep_slave_sg = fsl_dma_prep_slave_sg;
+	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
 	fdev->common.dev = &dev->dev;
 
 	fdev->irq = irq_of_parse_and_map(dev->node, 0);
-- 
1.5.4.3
