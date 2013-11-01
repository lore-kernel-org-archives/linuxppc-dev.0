Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x229.google.com (mail-lb0-x229.google.com
 [IPv6:2a00:1450:4010:c04::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70D322C03F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 18:16:25 +1100 (EST)
Received: by mail-lb0-f169.google.com with SMTP id p9so996122lbv.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2013 00:16:21 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH RFC v5 2/5] dma: mpc512x: add support for peripheral transfers
Date: Fri,  1 Nov 2013 11:19:31 +0400
Message-Id: <1383290374-17484-3-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce support for slave s/g transfer preparation and the associated
device control callback in the MPC512x DMA controller driver, which adds
support for data transfers between memory and peripheral I/O to the
previously supported mem-to-mem transfers.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 drivers/dma/mpc512x_dma.c | 232 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index f41639f..d2ec42d 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -2,6 +2,7 @@
  * Copyright (C) Freescale Semicondutor, Inc. 2007, 2008.
  * Copyright (C) Semihalf 2009
  * Copyright (C) Ilya Yanok, Emcraft Systems 2010
+ * Copyright (C) Alexander Popov, Promcontroller 2013
  *
  * Written by Piotr Ziecik <kosmo@semihalf.com>. Hardware description
  * (defines, structures and comments) was taken from MPC5121 DMA driver
@@ -29,8 +30,15 @@
  */
 
 /*
- * This is initial version of MPC5121 DMA driver. Only memory to memory
- * transfers are supported (tested using dmatest module).
+ * This version of MPC5121 DMA driver supports
+ * memory to memory data transfers (tested using dmatest module) and
+ * data transfers between memory and peripheral I/O memory
+ * by means of slave s/g with these limitations:
+ * - chunked transfers (transfers with more than one part) are refused
+ * as long as proper support for scatter/gather is missing;
+ * - transfers on MPC8308 always start from software as this SoC appears
+ * not to have external request lines for peripheral flow control;
+ * - minimal memory <-> I/O memory transfer size is 4 bytes.
  */
 
 #include <linux/module.h>
@@ -187,6 +195,7 @@ struct mpc_dma_desc {
 	dma_addr_t			tcd_paddr;
 	int				error;
 	struct list_head		node;
+	int				will_access_peripheral;
 };
 
 struct mpc_dma_chan {
@@ -199,6 +208,10 @@ struct mpc_dma_chan {
 	struct mpc_dma_tcd		*tcd;
 	dma_addr_t			tcd_paddr;
 
+	/* Settings for access to peripheral FIFO */
+	dma_addr_t			per_paddr;	/* FIFO address */
+	u32				tcd_nunits;
+
 	/* Lock for this structure */
 	spinlock_t			lock;
 };
@@ -249,8 +262,21 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 	struct mpc_dma_desc *mdesc;
 	int cid = mchan->chan.chan_id;
 
-	/* Move all queued descriptors to active list */
-	list_splice_tail_init(&mchan->queued, &mchan->active);
+	while (!list_empty(&mchan->queued)) {
+		mdesc = list_first_entry(&mchan->queued,
+						struct mpc_dma_desc, node);
+
+		/* Grab either several mem-to-mem transfer descriptors
+		 * or one peripheral transfer descriptor,
+		 * don't mix mem-to-mem and peripheral transfer descriptors
+		 * within the same 'active' list. */
+		if (mdesc->will_access_peripheral) {
+			if (list_empty(&mchan->active))
+				list_move_tail(&mdesc->node, &mchan->active);
+			break;
+		} else
+			list_move_tail(&mdesc->node, &mchan->active);
+	}
 
 	/* Chain descriptors into one transaction */
 	list_for_each_entry(mdesc, &mchan->active, node) {
@@ -264,6 +290,8 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 
 		prev->tcd->dlast_sga = mdesc->tcd_paddr;
 		prev->tcd->e_sg = 1;
+
+		/* software initiated start for chained transfers */
 		mdesc->tcd->start = 1;
 
 		prev = mdesc;
@@ -276,7 +304,17 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 
 	if (first != prev)
 		mdma->tcd[cid].e_sg = 1;
-	out_8(&mdma->regs->dmassrt, cid);
+
+	if (mdma->is_mpc8308) {
+		/* MPC8308, no request lines, software initiated start */
+		out_8(&mdma->regs->dmassrt, cid);
+	} else if (first->will_access_peripheral) {
+		/* peripherals involved, start by external request signal */
+		out_8(&mdma->regs->dmaserq, cid);
+	} else {
+		/* memory to memory transfer, software initiated start */
+		out_8(&mdma->regs->dmassrt, cid);
+	}
 }
 
 /* Handle interrupt on one half of DMA controller (32 channels) */
@@ -594,6 +632,7 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 	}
 
 	mdesc->error = 0;
+	mdesc->will_access_peripheral = 0;
 	tcd = mdesc->tcd;
 
 	/* Prepare Transfer Control Descriptor for this transaction */
@@ -641,6 +680,186 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 	return &mdesc->desc;
 }
 
+static struct dma_async_tx_descriptor *mpc_dma_prep_slave_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
+	struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
+	struct mpc_dma_desc *mdesc = NULL;
+	dma_addr_t per_paddr;
+	u32 tcd_nunits;
+	struct mpc_dma_tcd *tcd;
+	unsigned long iflags;
+	struct scatterlist *sg;
+	size_t len;
+	int iter, i;
+
+	/* currently there is no proper support for scatter/gather */
+	if (sg_len != 1)
+		return NULL;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		spin_lock_irqsave(&mchan->lock, iflags);
+
+		mdesc = list_first_entry(&mchan->free, struct mpc_dma_desc,
+									node);
+		if (!mdesc) {
+			spin_unlock_irqrestore(&mchan->lock, iflags);
+			/* try to free completed descriptors */
+			mpc_dma_process_completed(mdma);
+			return NULL;
+		}
+
+		list_del(&mdesc->node);
+
+		per_paddr = mchan->per_paddr;
+		tcd_nunits = mchan->tcd_nunits;
+
+		spin_unlock_irqrestore(&mchan->lock, iflags);
+
+		if (per_paddr == 0 || tcd_nunits == 0)
+			goto err_prep;
+
+		mdesc->error = 0;
+		mdesc->will_access_peripheral = 1;
+		tcd = mdesc->tcd;
+
+		/* Prepare Transfer Control Descriptor for this transaction */
+
+		memset(tcd, 0, sizeof(struct mpc_dma_tcd));
+
+		if (!IS_ALIGNED(sg_dma_address(sg), 4))
+			goto err_prep;
+
+		if (direction == DMA_DEV_TO_MEM) {
+			tcd->saddr = per_paddr;
+			tcd->daddr = sg_dma_address(sg);
+			tcd->soff = 0;
+			tcd->doff = 4;
+		} else if (direction == DMA_MEM_TO_DEV) {
+			tcd->saddr = sg_dma_address(sg);
+			tcd->daddr = per_paddr;
+			tcd->soff = 4;
+			tcd->doff = 0;
+		} else
+			goto err_prep;
+
+		tcd->ssize = MPC_DMA_TSIZE_4;
+		tcd->dsize = MPC_DMA_TSIZE_4;
+
+		len = sg_dma_len(sg);
+		tcd->nbytes = tcd_nunits * 4;
+		if (!IS_ALIGNED(len, tcd->nbytes))
+			goto err_prep;
+
+		iter = len / tcd->nbytes;
+		if (iter >= 1 << 15) {
+			/* len is too big */
+			goto err_prep;
+		} else {
+			/* citer_linkch contains the high bits of iter */
+			tcd->biter = iter & 0x1ff;
+			tcd->biter_linkch = iter >> 9;
+			tcd->citer = tcd->biter;
+			tcd->citer_linkch = tcd->biter_linkch;
+		}
+
+		tcd->e_sg = 0;
+		tcd->d_req = 1;
+
+		/* Place descriptor in prepared list */
+		spin_lock_irqsave(&mchan->lock, iflags);
+		list_add_tail(&mdesc->node, &mchan->prepared);
+		spin_unlock_irqrestore(&mchan->lock, iflags);
+	}
+
+	return &mdesc->desc;
+
+ err_prep:
+	/* Put the descriptor back */
+	spin_lock_irqsave(&mchan->lock, iflags);
+	list_add_tail(&mdesc->node, &mchan->free);
+	spin_unlock_irqrestore(&mchan->lock, iflags);
+
+	return NULL;
+}
+
+static int mpc_dma_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+				  unsigned long arg)
+{
+	struct mpc_dma_chan *mchan;
+	struct mpc_dma *mdma;
+	struct dma_slave_config *cfg;
+	unsigned long flags;
+
+	mchan = dma_chan_to_mpc_dma_chan(chan);
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		/* disable channel requests */
+		mdma = dma_chan_to_mpc_dma(chan);
+
+		spin_lock_irqsave(&mchan->lock, flags);
+
+		out_8(&mdma->regs->dmacerq, chan->chan_id);
+		list_splice_tail_init(&mchan->prepared, &mchan->free);
+		list_splice_tail_init(&mchan->queued, &mchan->free);
+		list_splice_tail_init(&mchan->active, &mchan->free);
+
+		spin_unlock_irqrestore(&mchan->lock, flags);
+
+		return 0;
+	case DMA_SLAVE_CONFIG:
+		/* Constraints:
+		 * - only transfers between a peripheral device and
+		 * memory are supported;
+		 * - minimal transfer size is 4 bytes and consequently
+		 * source and destination addresses must be 4-byte aligned and
+		 * transfer size must be aligned on (4 * maxburst) boundary;
+		 * - RAM address is being incremented by minimal transfer size
+		 * during the transfer;
+		 * - peripheral port's address is constant during the transfer.
+		 */
+
+		cfg = (void *)arg;
+
+		if (cfg->direction != DMA_DEV_TO_MEM &&
+			cfg->direction != DMA_MEM_TO_DEV)
+			return -EINVAL;
+
+		if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
+			cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+			return -EINVAL;
+
+		spin_lock_irqsave(&mchan->lock, flags);
+
+		if (cfg->direction == DMA_DEV_TO_MEM) {
+			mchan->per_paddr = cfg->src_addr;
+			mchan->tcd_nunits = cfg->src_maxburst;
+		} else {
+			mchan->per_paddr = cfg->dst_addr;
+			mchan->tcd_nunits = cfg->dst_maxburst;
+		}
+
+		if (!IS_ALIGNED(mchan->per_paddr, 4)) {
+			spin_unlock_irqrestore(&mchan->lock, flags);
+			return -EINVAL;
+		}
+
+		if (mchan->tcd_nunits == 0)
+			mchan->tcd_nunits = 64; /* apply default */
+
+		spin_unlock_irqrestore(&mchan->lock, flags);
+
+		return 0;
+	default:
+		return -ENOSYS;
+	}
+
+	return -EINVAL;
+}
+
 static int mpc_dma_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
@@ -725,9 +944,12 @@ static int mpc_dma_probe(struct platform_device *op)
 	dma->device_issue_pending = mpc_dma_issue_pending;
 	dma->device_tx_status = mpc_dma_tx_status;
 	dma->device_prep_dma_memcpy = mpc_dma_prep_memcpy;
+	dma->device_prep_slave_sg = mpc_dma_prep_slave_sg;
+	dma->device_control = mpc_dma_device_control;
 
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
+	dma_cap_set(DMA_SLAVE, dma->cap_mask);
 
 	for (i = 0; i < dma->chancnt; i++) {
 		mchan = &mdma->channels[i];
-- 
1.7.11.3
