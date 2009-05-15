Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 9EF4DDE15D
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 08:57:02 +1000 (EST)
Date: Fri, 15 May 2009 15:56:59 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] fsldma: Add DMA_SLAVE support
Message-ID: <20090515225659.GD858@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
scatterlist into an arbitrary list of hardware address/length pairs.

This allows a single DMA transaction to copy data from several different
devices into a scatterlist at the same time.

This also adds support to enable some controller-specific features such as
external start and external pause of a DMA transaction.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This is a request for comments on this patch. I hunch it is not quite
ready for inclusion, though it is certainly ready for review. Correct
functioning of this patch depends on the patches submitted earlier.

As suggested by Dan Williams, I implemented DMA_SLAVE support for the
fsldma controller to allow me to use the hardware to transfer to/from a
scatterlist to a list of hardware address/length pairs.

I implemented support for the extra features available in the DMA
controller, such as external pause and external start. I have not tested
the features yet. I am willing to drop the support if everything else
looks good.

I have implemented helper functions for creating the list of hardware
address/length pairs as static inline functions in the linux/fsldma.h
header. Should I incorporate these into the driver itself and use
EXPORT_SYMBOL()? I've never done this before :)

Thanks for your review,
Ira

 drivers/dma/fsldma.c   |  226 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsldma.h |  105 ++++++++++++++++++++++
 2 files changed, 331 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/fsldma.h

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index de0e5c8..465846c 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -29,6 +29,7 @@
 #include <linux/dmapool.h>
 #include <linux/of_platform.h>
 
+#include <linux/fsldma.h>
 #include "fsldma.h"
 
 static void dma_init(struct fsl_dma_chan *fsl_chan)
@@ -530,6 +531,228 @@ fail:
 	return NULL;
 }
 
+/*
+ * Setup the DMA controller for a DMA_SLAVE transaction
+ *
+ * NOTE: this gets the hardware address/length pairs from the
+ * NOTE: struct fsl_dma_slave stored in chan->private
+ *
+ * @param chan the DMA channel
+ * @param sgl the scatterlist to transfer to/from
+ * @param sg_len the number of entries in the scatterlist
+ * @param direction the DMA direction
+ * @param flags DMAEngine flags
+ *
+ * @return a new struct dma_async_tx_descriptor or NULL
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
 /**
  * fsl_dma_update_completed_cookie - Update the completed cookie.
  * @fsl_chan : Freescale DMA channel
@@ -952,12 +1175,15 @@ static int __devinit of_fsl_dma_probe(struct of_device *dev,
 
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
diff --git a/include/linux/fsldma.h b/include/linux/fsldma.h
new file mode 100644
index 0000000..a42dcdd
--- /dev/null
+++ b/include/linux/fsldma.h
@@ -0,0 +1,105 @@
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
+#ifndef __LINUX_FSLDMA_H__
+#define __LINUX_FSLDMA_H__
+
+#include <linux/dmaengine.h>
+
+/*
+ * physical hardware address / length pair for use with the
+ * DMAEngine DMA_SLAVE API
+ */
+struct fsl_dma_hw_addr {
+	struct list_head entry;
+
+	dma_addr_t address;
+	size_t length;
+};
+
+/*
+ * structure passed to the DMAEngine DMA_SLAVE API via the
+ * chan->private pointer
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
+/*
+ * Add an address/length pair to an existing DMA_SLAVE structure
+ *
+ * @param slave the DMA_SLAVE structure
+ * @param address the hardware address
+ * @param length the length of bytes to transfer
+ * @return 0 on success, -ERRNO otherwise
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
+/*
+ * Free a DMA_SLAVE structure and associated address/length pairs
+ *
+ * @param slave the DMA_SLAVE structure to free
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
+/*
+ * Allocate a DMA_SLAVE structure
+ *
+ * @param gfp memory allocation flags
+ * @return a new struct fsl_dma_slave or NULL
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
+#endif /* __LINUX_FSLDMA_H__ */
-- 
1.5.4.3
