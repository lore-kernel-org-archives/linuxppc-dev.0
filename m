Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1ED01A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 19:30:15 +1100 (AEDT)
From: <xuelin.shi@freescale.com>
To: <dan.j.williams@intel.com>, <vinod.koul@intel.com>
Subject: [RESEND PATCH v4] dmaengine: Driver support for FSL RaidEngine device.
Date: Fri, 17 Oct 2014 15:28:20 +0800
Message-ID: <1413530900-22732-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>,
 Xuelin Shi <xuelin.shi@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Naveen Burmi <naveenburmi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@freescale.com>

The RaidEngine is a new FSL hardware used for Raid5/6 acceration.

This patch enables the RaidEngine functionality and provides
hardware offloading capability for memcpy, xor and pq computation.
It works with async_tx.

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
Signed-off-by: Naveen Burmi <naveenburmi@freescale.com>
Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
---
 changes for v4:
  - use upper/lower_32_bits(...) instead of direct shift.
  - change FSL_RAID dependency !ASYNC_TX_ENABLE_CHANNEL_SWITCH in Kconfig.

 changes for v3:
  - fix memory allocation flag GFP_xxx usage.
  - add re_jr_issue_pending call in cleanup.
  - remove unnecessary dma_run_dependencies(...).
  - use dma_cookie_complete(...) instead of direct updating cookie.

 drivers/dma/Kconfig    |  11 +
 drivers/dma/Makefile   |   1 +
 drivers/dma/fsl_raid.c | 875 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/fsl_raid.h | 307 +++++++++++++++++
 4 files changed, 1194 insertions(+)
 create mode 100644 drivers/dma/fsl_raid.c
 create mode 100644 drivers/dma/fsl_raid.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 605b016..b85880c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -100,6 +100,17 @@ config FSL_DMA
 	  EloPlus is on mpc85xx and mpc86xx and Pxxx parts, and the Elo3 is on
 	  some Txxx and Bxxx parts.
 
+config FSL_RAID
+        tristate "Freescale RAID engine Support"
+        depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
+        select DMA_ENGINE
+        select DMA_ENGINE_RAID
+        ---help---
+          Enable support for Freescale RAID Engine. RAID Engine is
+          available on some QorIQ SoCs (like P5020). It has
+          the capability to offload memcpy, xor and pq computation
+	  for raid5/6.
+
 config MPC512X_DMA
 	tristate "Freescale MPC512x built-in DMA engine support"
 	depends on PPC_MPC512x || PPC_MPC831x
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a029d0f4..60b163b 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
 obj-$(CONFIG_TI_CPPI41) += cppi41.o
 obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_MOXART_DMA) += moxart-dma.o
+obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
new file mode 100644
index 0000000..1dc5981
--- /dev/null
+++ b/drivers/dma/fsl_raid.c
@@ -0,0 +1,875 @@
+/*
+ * drivers/dma/fsl_raid.c
+ *
+ * Freescale RAID Engine device driver
+ *
+ * Author:
+ *	Harninder Rai <harninder.rai@freescale.com>
+ *	Naveen Burmi <naveenburmi@freescale.com>
+ *
+ * Rewrite:
+ *	Xuelin Shi <xuelin.shi@freescale.com>
+ *
+ * Copyright (c) 2010-2014 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * Theory of operation:
+ *
+ * General capabilities:
+ *	RAID Engine (RE) block is capable of offloading XOR, memcpy and P/Q
+ *	calculations required in RAID5 and RAID6 operations. RE driver
+ *	registers with Linux's ASYNC layer as dma driver. RE hardware
+ *	maintains strict ordering of the requests through chained
+ *	command queueing.
+ *
+ * Data flow:
+ *	Software RAID layer of Linux (MD layer) maintains RAID partitions,
+ *	strips, stripes etc. It sends requests to the underlying AYSNC layer
+ *	which further passes it to RE driver. ASYNC layer decides which request
+ *	goes to which job ring of RE hardware. For every request processed by
+ *	RAID Engine, driver gets an interrupt unless coalescing is set. The
+ *	per job ring interrupt handler checks the status register for errors,
+ *	clears the interrupt and leave the post interrupt processing to the irq
+ *	thread.
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/dmaengine.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+
+#include "dmaengine.h"
+#include "fsl_raid.h"
+
+#define MAX_XOR_SRCS		16
+#define MAX_PQ_SRCS		16
+#define MAX_INITIAL_DESCS	256
+#define MAX_DESCS_LIMIT		(4 * MAX_INITIAL_DESCS)
+#define FRAME_FORMAT		0x1
+#define MAX_DATA_LENGTH		(1024*1024)
+
+#define to_fsl_re_dma_desc(tx) container_of(tx, \
+		struct fsl_re_dma_async_tx_desc, async_tx)
+
+/* Add descriptors into per jr software queue - submit_q */
+static dma_cookie_t re_jr_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct fsl_re_dma_async_tx_desc *desc;
+	struct re_jr *jr;
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	desc = to_fsl_re_dma_desc(tx);
+	jr = container_of(tx->chan, struct re_jr, chan);
+
+	spin_lock_irqsave(&jr->desc_lock, flags);
+	cookie = dma_cookie_assign(tx);
+	list_add_tail(&desc->node, &jr->submit_q);
+	spin_unlock_irqrestore(&jr->desc_lock, flags);
+
+	return cookie;
+}
+
+/* Copy descriptor from per jr software queue into hardware job ring */
+static void re_jr_issue_pending(struct dma_chan *chan)
+{
+	struct re_jr *jr;
+	int avail;
+	struct fsl_re_dma_async_tx_desc *desc, *_desc;
+	unsigned long flags;
+
+	jr = container_of(chan, struct re_jr, chan);
+
+	avail = RE_JR_INB_SLOT_AVAIL(in_be32(&jr->jrregs->inbring_slot_avail));
+	if (!avail)
+		return;
+
+	spin_lock_irqsave(&jr->desc_lock, flags);
+	list_for_each_entry_safe(desc, _desc, &jr->submit_q, node) {
+		if (!avail)
+			break;
+
+		list_move_tail(&desc->node, &jr->active_q);
+
+		memcpy(&jr->inb_ring_virt_addr[jr->inb_count], &desc->hwdesc,
+		       sizeof(struct jr_hw_desc));
+
+		jr->inb_count = (jr->inb_count + 1) & RING_SIZE_MASK;
+
+		/* add one job into job ring */
+		out_be32(&jr->jrregs->inbring_add_job, RE_JR_INB_JOB_ADD(1));
+		avail--;
+	}
+	spin_unlock_irqrestore(&jr->desc_lock, flags);
+}
+
+static void re_jr_desc_done(struct fsl_re_dma_async_tx_desc *desc)
+{
+	dma_async_tx_callback callback;
+	void *callback_param;
+
+	dma_cookie_complete(&desc->async_tx);
+
+	callback = desc->async_tx.callback;
+	callback_param = desc->async_tx.callback_param;
+	if (callback)
+		callback(callback_param);
+
+	dma_descriptor_unmap(&desc->async_tx);
+}
+
+static void re_jr_dequeue(struct re_jr *jr)
+{
+	struct fsl_re_dma_async_tx_desc *desc, *_desc;
+	struct jr_hw_desc *hwdesc;
+	unsigned int count;
+	int found;
+
+	count =	RE_JR_OUB_SLOT_FULL(in_be32(&jr->jrregs->oubring_slot_full));
+	while (count--) {
+		found = 0;
+		hwdesc = &jr->oub_ring_virt_addr[jr->oub_count];
+		list_for_each_entry_safe(desc, _desc, &jr->active_q, node) {
+			/* compare the hw dma addr to find the completed */
+			if (desc->hwdesc.lbea32 == hwdesc->lbea32 &&
+			    desc->hwdesc.addr_low == hwdesc->addr_low) {
+				found = 1;
+				break;
+			}
+		}
+
+		BUG_ON(!found);
+		re_jr_desc_done(desc);
+		list_move_tail(&desc->node, &jr->ack_q);
+
+		jr->oub_count = (jr->oub_count + 1) & RING_SIZE_MASK;
+		out_be32(&jr->jrregs->oubring_job_rmvd, RE_JR_OUB_JOB_RMVD(1));
+	}
+}
+
+static void re_jr_cleanup_descs(struct re_jr *jr)
+{
+	struct fsl_re_dma_async_tx_desc *desc, *_desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&jr->desc_lock, flags);
+	re_jr_dequeue(jr);
+	list_for_each_entry_safe(desc, _desc, &jr->ack_q, node) {
+		if (async_tx_test_ack(&desc->async_tx))
+			list_move_tail(&desc->node, &jr->free_q);
+	}
+	spin_unlock_irqrestore(&jr->desc_lock, flags);
+
+	re_jr_issue_pending(&jr->chan);
+}
+
+static irqreturn_t re_jr_isr_thread(int irq, void *data)
+{
+	struct re_jr *jr = (struct re_jr *)data;
+
+	re_jr_cleanup_descs(jr);
+
+	return IRQ_HANDLED;
+}
+
+/* Per Job Ring interrupt handler */
+static irqreturn_t re_jr_isr(int irq, void *data)
+{
+	struct re_jr *jr = (struct re_jr *)data;
+
+	u32 irqstate, status;
+	irqstate = in_be32(&jr->jrregs->jr_interrupt_status);
+	if (!irqstate)
+		return IRQ_NONE;
+
+	/*
+	 * There's no way in upper layer (read MD layer) to recover from
+	 * error conditions except restart everything. In long term we
+	 * need to do something more than just crashing
+	 */
+	if (irqstate & RE_JR_ERROR) {
+		status = in_be32(&jr->jrregs->jr_status);
+		dev_err(jr->dev, "jr error irqstate: %x, status: %x\n",
+			irqstate, status);
+	}
+
+	/* Clear interrupt */
+	out_be32(&jr->jrregs->jr_interrupt_status, RE_JR_CLEAR_INT);
+	return IRQ_WAKE_THREAD;
+}
+
+static enum dma_status re_jr_tx_status(struct dma_chan *chan,
+		dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	enum dma_status ret;
+	struct re_jr *jr = container_of(chan, struct re_jr, chan);
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+
+	if (ret != DMA_COMPLETE) {
+		re_jr_cleanup_descs(jr);
+		ret = dma_cookie_status(chan, cookie, txstate);
+	}
+
+	return ret;
+}
+
+void fill_cfd_frame(struct cmpnd_frame *cf, u8 index,
+		size_t length, dma_addr_t addr, bool final)
+{
+	u32 efrl = length & CF_LENGTH_MASK;
+	efrl |= final << CF_FINAL_SHIFT;
+	cf[index].efrl32 = efrl;
+	cf[index].addr_high = upper_32_bits(addr);
+	cf[index].addr_low = lower_32_bits(addr);
+}
+
+static struct fsl_re_dma_async_tx_desc *re_jr_init_desc(struct re_jr *jr,
+	struct fsl_re_dma_async_tx_desc *desc, void *cf, dma_addr_t paddr)
+{
+	desc->jr = jr;
+	desc->async_tx.tx_submit = re_jr_tx_submit;
+	dma_async_tx_descriptor_init(&desc->async_tx, &jr->chan);
+	INIT_LIST_HEAD(&desc->node);
+
+	desc->hwdesc.fmt32 = FRAME_FORMAT << HWDESC_FMT_SHIFT;
+	desc->hwdesc.lbea32 = upper_32_bits(paddr);
+	desc->hwdesc.addr_low = lower_32_bits(paddr);
+	desc->cf_addr = cf;
+	desc->cf_paddr = paddr;
+
+	desc->cdb_addr = (void *)(cf + RE_CF_DESC_SIZE);
+	desc->cdb_paddr = paddr + RE_CF_DESC_SIZE;
+
+	return desc;
+}
+
+static struct fsl_re_dma_async_tx_desc *re_jr_alloc_desc(struct re_jr *jr,
+		unsigned long flags)
+{
+	struct fsl_re_dma_async_tx_desc *desc = NULL;
+	void *cf;
+	dma_addr_t paddr;
+	unsigned long lock_flag;
+
+	re_jr_cleanup_descs(jr);
+
+	spin_lock_irqsave(&jr->desc_lock, lock_flag);
+	if (!list_empty(&jr->free_q)) {
+		/* take one desc from free_q */
+		desc = list_first_entry(&jr->free_q,
+					struct fsl_re_dma_async_tx_desc, node);
+		list_del(&desc->node);
+
+		desc->async_tx.flags = flags;
+	}
+	spin_unlock_irqrestore(&jr->desc_lock, lock_flag);
+
+	if (!desc) {
+		desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+		cf = dma_pool_alloc(jr->re_dev->cf_desc_pool, GFP_NOWAIT,
+				    &paddr);
+		if (!desc || !cf) {
+			kfree(desc);
+			return NULL;
+		}
+
+		desc = re_jr_init_desc(jr, desc, cf, paddr);
+		desc->async_tx.flags = flags;
+
+		spin_lock_irqsave(&jr->desc_lock, lock_flag);
+		jr->alloc_count++;
+		spin_unlock_irqrestore(&jr->desc_lock, lock_flag);
+	}
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *re_jr_prep_genq(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
+		unsigned int src_cnt, const unsigned char *scf, size_t len,
+		unsigned long flags)
+{
+	struct re_jr *jr;
+	struct fsl_re_dma_async_tx_desc *desc;
+	struct xor_cdb *xor;
+	struct cmpnd_frame *cf;
+	u32 cdb;
+	unsigned int i, j;
+
+	if (len > MAX_DATA_LENGTH) {
+		pr_err("Length greater than %d not supported\n",
+		       MAX_DATA_LENGTH);
+		return NULL;
+	}
+
+	jr = container_of(chan, struct re_jr, chan);
+	desc = re_jr_alloc_desc(jr, flags);
+	if (desc <= 0)
+		return NULL;
+
+	/* Filling xor CDB */
+	cdb = RE_XOR_OPCODE << RE_CDB_OPCODE_SHIFT;
+	cdb |= (src_cnt - 1) << RE_CDB_NRCS_SHIFT;
+	cdb |= RE_BLOCK_SIZE << RE_CDB_BLKSIZE_SHIFT;
+	cdb |= INTERRUPT_ON_ERROR << RE_CDB_ERROR_SHIFT;
+	cdb |= DATA_DEPENDENCY << RE_CDB_DEPEND_SHIFT;
+	xor = desc->cdb_addr;
+	xor->cdb32 = cdb;
+
+	if (scf != NULL) {
+		/* compute q = src0*coef0^src1*coef1^..., * is GF(8) mult */
+		for (i = 0; i < src_cnt; i++)
+			xor->gfm[i] = scf[i];
+	} else {
+		/* compute P, that is XOR all srcs */
+		for (i = 0; i < src_cnt; i++)
+			xor->gfm[i] = 1;
+	}
+
+	/* Filling frame 0 of compound frame descriptor with CDB */
+	cf = desc->cf_addr;
+	fill_cfd_frame(cf, 0, sizeof(struct xor_cdb), desc->cdb_paddr, 0);
+
+	/* Fill CFD's 1st frame with dest buffer */
+	fill_cfd_frame(cf, 1, len, dest, 0);
+
+	/* Fill CFD's rest of the frames with source buffers */
+	for (i = 2, j = 0; j < src_cnt; i++, j++)
+		fill_cfd_frame(cf, i, len, src[j], 0);
+
+	/* Setting the final bit in the last source buffer frame in CFD */
+	cf[i - 1].efrl32 |= 1 << CF_FINAL_SHIFT;
+
+	return &desc->async_tx;
+}
+
+/*
+ * Prep function for P parity calculation.In RAID Engine terminology,
+ * XOR calculation is called GenQ calculation done through GenQ command
+ */
+static struct dma_async_tx_descriptor *re_jr_prep_dma_xor(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
+		unsigned int src_cnt, size_t len, unsigned long flags)
+{
+	/* NULL let genq take all coef as 1 */
+	return re_jr_prep_genq(chan, dest, src, src_cnt, NULL, len, flags);
+}
+
+/*
+ * Prep function for P/Q parity calculation.In RAID Engine terminology,
+ * P/Q calculation is called GenQQ done through GenQQ command
+ */
+static struct dma_async_tx_descriptor *re_jr_prep_pq(
+		struct dma_chan *chan, dma_addr_t *dest, dma_addr_t *src,
+		unsigned int src_cnt, const unsigned char *scf, size_t len,
+		unsigned long flags)
+{
+	struct re_jr *jr;
+	struct fsl_re_dma_async_tx_desc *desc;
+	struct pq_cdb *pq;
+	struct cmpnd_frame *cf;
+	u32 cdb;
+	u8 *p;
+	int gfmq_len, i, j;
+
+	if (len > MAX_DATA_LENGTH) {
+		pr_err("Length greater than %d not supported\n",
+		       MAX_DATA_LENGTH);
+		return NULL;
+	}
+
+	/*
+	 * RE requires at least 2 sources, if given only one source, we pass the
+	 * second source same as the first one.
+	 * With only one source, generating P is meaningless, only generate Q.
+	 */
+	if (src_cnt == 1) {
+		struct dma_async_tx_descriptor *tx;
+		dma_addr_t dma_src[2];
+		unsigned char coef[2];
+
+		dma_src[0] = *src;
+		coef[0] = *scf;
+		dma_src[1] = *src;
+		coef[1] = 0;
+		tx = re_jr_prep_genq(chan, dest[1], dma_src, 2, coef, len,
+				flags);
+		if (tx)
+			desc = to_fsl_re_dma_desc(tx);
+
+		return tx;
+	}
+
+	/*
+	 * During RAID6 array creation, Linux's MD layer gets P and Q
+	 * calculated separately in two steps. But our RAID Engine has
+	 * the capability to calculate both P and Q with a single command
+	 * Hence to merge well with MD layer, we need to provide a hook
+	 * here and call re_jq_prep_genq() function
+	 */
+
+	if (flags & DMA_PREP_PQ_DISABLE_P)
+		return re_jr_prep_genq(chan, dest[1], src, src_cnt,
+				scf, len, flags);
+
+	jr = container_of(chan, struct re_jr, chan);
+	desc = re_jr_alloc_desc(jr, flags);
+	if (desc <= 0)
+		return NULL;
+
+	/* Filling GenQQ CDB */
+	cdb = RE_PQ_OPCODE << RE_CDB_OPCODE_SHIFT;
+	cdb |= (src_cnt - 1) << RE_CDB_NRCS_SHIFT;
+	cdb |= RE_BLOCK_SIZE << RE_CDB_BLKSIZE_SHIFT;
+	cdb |= BUFFERABLE_OUTPUT << RE_CDB_BUFFER_SHIFT;
+	cdb |= DATA_DEPENDENCY << RE_CDB_DEPEND_SHIFT;
+
+	pq = desc->cdb_addr;
+	pq->cdb32 = cdb;
+
+	p = pq->gfm_q1;
+	/* Init gfm_q1[] */
+	for (i = 0; i < src_cnt; i++)
+		p[i] = 1;
+
+	/* Align gfm[] to 32bit */
+	gfmq_len = ALIGN(src_cnt, 4);
+
+	/* Init gfm_q2[] */
+	p += gfmq_len;
+	for (i = 0; i < src_cnt; i++)
+		p[i] = scf[i];
+
+	/* Filling frame 0 of compound frame descriptor with CDB */
+	cf = desc->cf_addr;
+	fill_cfd_frame(cf, 0, sizeof(struct pq_cdb), desc->cdb_paddr, 0);
+
+	/* Fill CFD's 1st & 2nd frame with dest buffers */
+	for (i = 1, j = 0; i < 3; i++, j++)
+		fill_cfd_frame(cf, i, len, dest[j], 0);
+
+	/* Fill CFD's rest of the frames with source buffers */
+	for (i = 3, j = 0; j < src_cnt; i++, j++)
+		fill_cfd_frame(cf, i, len, src[j], 0);
+
+	/* Setting the final bit in the last source buffer frame in CFD */
+	cf[i - 1].efrl32 |= 1 << CF_FINAL_SHIFT;
+
+	return &desc->async_tx;
+}
+
+/*
+ * Prep function for memcpy. In RAID Engine, memcpy is done through MOVE
+ * command. Logic of this function will need to be modified once multipage
+ * support is added in Linux's MD/ASYNC Layer
+ */
+static struct dma_async_tx_descriptor *re_jr_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		size_t len, unsigned long flags)
+{
+	struct re_jr *jr;
+	struct fsl_re_dma_async_tx_desc *desc;
+	size_t length;
+	struct cmpnd_frame *cf;
+	struct move_cdb *move;
+	u32 cdb;
+
+	jr = container_of(chan, struct re_jr, chan);
+
+	if (len > MAX_DATA_LENGTH) {
+		pr_err("Length greater than %d not supported\n",
+		       MAX_DATA_LENGTH);
+		return NULL;
+	}
+
+	desc = re_jr_alloc_desc(jr, flags);
+	if (desc <= 0)
+		return NULL;
+
+	/* Filling move CDB */
+	cdb = RE_MOVE_OPCODE << RE_CDB_OPCODE_SHIFT;
+	cdb |= RE_BLOCK_SIZE << RE_CDB_BLKSIZE_SHIFT;
+	cdb |= INTERRUPT_ON_ERROR << RE_CDB_ERROR_SHIFT;
+	cdb |= DATA_DEPENDENCY << RE_CDB_DEPEND_SHIFT;
+
+	move = desc->cdb_addr;
+	move->cdb32 = cdb;
+
+	/* Filling frame 0 of CFD with move CDB */
+	cf = desc->cf_addr;
+	fill_cfd_frame(cf, 0, sizeof(struct move_cdb), desc->cdb_paddr, 0);
+
+	length = min_t(size_t, len, MAX_DATA_LENGTH);
+
+	/* Fill CFD's 1st frame with dest buffer */
+	fill_cfd_frame(cf, 1, length, dest, 0);
+
+	/* Fill CFD's 2nd frame with src buffer */
+	fill_cfd_frame(cf, 2, length, src, 1);
+
+	return &desc->async_tx;
+}
+
+static int re_jr_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct re_jr *jr = container_of(chan, struct re_jr, chan);
+	struct fsl_re_dma_async_tx_desc *desc;
+	void *cf;
+	dma_addr_t paddr;
+
+	int i;
+
+	for (i = 0; i < MAX_DESCS_LIMIT; i++) {
+		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+		cf = dma_pool_alloc(jr->re_dev->cf_desc_pool, GFP_KERNEL,
+				    &paddr);
+		if (!desc || !cf) {
+			kfree(desc);
+			break;
+		}
+
+		INIT_LIST_HEAD(&desc->node);
+		re_jr_init_desc(jr, desc, cf, paddr);
+
+		list_add_tail(&desc->node, &jr->free_q);
+		jr->alloc_count++;
+	}
+	return jr->alloc_count;
+}
+
+static void re_jr_free_chan_resources(struct dma_chan *chan)
+{
+	struct re_jr *jr = container_of(chan, struct re_jr, chan);
+	struct fsl_re_dma_async_tx_desc *desc;
+
+	while (jr->alloc_count--) {
+		desc = list_first_entry(&jr->free_q,
+				struct fsl_re_dma_async_tx_desc,
+				node);
+
+		list_del(&desc->node);
+		dma_pool_free(jr->re_dev->cf_desc_pool, desc->cf_addr,
+			      desc->cf_paddr);
+		kfree(desc);
+	}
+
+	BUG_ON(!list_empty(&jr->free_q));
+}
+
+int re_jr_probe(struct platform_device *ofdev,
+		struct device_node *np, u8 q, u32 off)
+{
+	struct device *dev;
+	struct re_drv_private *repriv;
+	struct re_jr *jr;
+	struct dma_device *dma_dev;
+	u32 ptr;
+	u32 status;
+	int ret = 0, rc;
+	struct platform_device *jr_ofdev;
+
+	dev = &ofdev->dev;
+	repriv = dev_get_drvdata(dev);
+	dma_dev = &repriv->dma_dev;
+
+	jr = devm_kzalloc(dev, sizeof(*jr), GFP_KERNEL);
+	if (!jr) {
+		dev_err(dev, "No free memory for allocating JR struct\n");
+		return -ENOMEM;
+	}
+
+	/* create platform device for jr node */
+	jr_ofdev = of_platform_device_create(np, NULL, dev);
+	if (jr_ofdev == NULL) {
+		dev_err(dev, "Not able to create ofdev for jr %d\n", q);
+		ret = -EINVAL;
+		goto err_free;
+	}
+	dev_set_drvdata(&jr_ofdev->dev, jr);
+
+	/* read reg property from dts */
+	rc = of_property_read_u32(np, "reg", &ptr);
+	if (rc) {
+		dev_err(dev, "Reg property not found in JR number %d\n", q);
+		ret = -ENODEV;
+		goto err_free;
+	}
+
+	jr->jrregs = (struct jr_config_regs *)((u8 *)repriv->re_regs +
+			off + ptr);
+
+	/* read irq property from dts */
+	jr->irq = irq_of_parse_and_map(np, 0);
+	if (jr->irq == NO_IRQ) {
+		dev_err(dev, "No IRQ defined for JR %d\n", q);
+		ret = -ENODEV;
+		goto err_free;
+	}
+
+	ret = devm_request_threaded_irq(&jr_ofdev->dev, jr->irq, re_jr_isr,
+					re_jr_isr_thread, 0, jr->name, jr);
+
+	if (ret) {
+		dev_err(dev, "Unable to register JR interrupt for JR %d\n", q);
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	snprintf(jr->name, sizeof(jr->name), "re_jr%02d", q);
+
+	repriv->re_jrs[q] = jr;
+	jr->chan.device = dma_dev;
+	jr->chan.private = jr;
+	jr->dev = &jr_ofdev->dev;
+	jr->re_dev = repriv;
+
+	spin_lock_init(&jr->desc_lock);
+	INIT_LIST_HEAD(&jr->ack_q);
+	INIT_LIST_HEAD(&jr->active_q);
+	INIT_LIST_HEAD(&jr->submit_q);
+	INIT_LIST_HEAD(&jr->free_q);
+
+	list_add_tail(&jr->chan.device_node, &dma_dev->channels);
+	dma_dev->chancnt++;
+
+	jr->inb_ring_virt_addr = dma_pool_alloc(jr->re_dev->hw_desc_pool,
+		GFP_KERNEL, &jr->inb_phys_addr);
+
+	if (!jr->inb_ring_virt_addr) {
+		dev_err(dev, "No dma memory for inb_ring_virt_addr\n");
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	jr->oub_ring_virt_addr = dma_pool_alloc(jr->re_dev->hw_desc_pool,
+		GFP_KERNEL, &jr->oub_phys_addr);
+
+	if (!jr->oub_ring_virt_addr) {
+		dev_err(dev, "No dma memory for oub_ring_virt_addr\n");
+		ret = -ENOMEM;
+		goto err_free_1;
+	}
+
+	jr->inb_count = 0;
+	jr->oub_count = 0;
+	jr->alloc_count = 0;
+
+	/* Program the Inbound/Outbound ring base addresses and size */
+	out_be32(&jr->jrregs->inbring_base_h,
+		 jr->inb_phys_addr & RE_JR_ADDRESS_BIT_MASK);
+	out_be32(&jr->jrregs->oubring_base_h,
+		 jr->oub_phys_addr & RE_JR_ADDRESS_BIT_MASK);
+	out_be32(&jr->jrregs->inbring_base_l,
+		 jr->inb_phys_addr >> RE_JR_ADDRESS_BIT_SHIFT);
+	out_be32(&jr->jrregs->oubring_base_l,
+		 jr->oub_phys_addr >> RE_JR_ADDRESS_BIT_SHIFT);
+	out_be32(&jr->jrregs->inbring_size, RING_SIZE << RING_SIZE_SHIFT);
+	out_be32(&jr->jrregs->oubring_size, RING_SIZE << RING_SIZE_SHIFT);
+
+	/* Read LIODN value from u-boot */
+	status = in_be32(&jr->jrregs->jr_config_1) & RE_JR_REG_LIODN_MASK;
+
+	/* Program the CFG reg */
+	out_be32(&jr->jrregs->jr_config_1,
+		 RE_JR_CFG1_CBSI | RE_JR_CFG1_CBS0 | status);
+
+	/* Enable RE/JR */
+	out_be32(&jr->jrregs->jr_command, RE_JR_ENABLE);
+
+	return 0;
+
+err_free_1:
+	dma_pool_free(jr->re_dev->hw_desc_pool, jr->inb_ring_virt_addr,
+		      jr->inb_phys_addr);
+err_free:
+	return ret;
+}
+
+/* Probe function for RAID Engine */
+static int raide_probe(struct platform_device *ofdev)
+{
+	struct re_drv_private *repriv;
+	struct device_node *np;
+	struct device_node *child;
+	u32 off;
+	u8 ridx = 0;
+	struct dma_device *dma_dev;
+	struct resource *res;
+	int rc;
+	struct device *dev = &ofdev->dev;
+
+	dev_info(dev, "Freescale RAID Engine driver\n");
+
+	repriv = devm_kzalloc(dev, sizeof(*repriv), GFP_KERNEL);
+	if (!repriv)
+		return -ENOMEM;
+
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	/* IOMAP the entire RAID Engine region */
+	repriv->re_regs = devm_ioremap(dev, res->start, resource_size(res));
+	if (!repriv->re_regs)
+		return -EBUSY;
+
+	dev_set_drvdata(dev, repriv);
+
+	/* Print the RE version */
+	dev_info(dev, "Ver = %x\n", in_be32(&repriv->re_regs->re_version_id));
+
+	/* Program the RE mode */
+	out_be32(&repriv->re_regs->global_config, RE_NON_DPAA_MODE);
+	dev_info(dev, "RE mode is %x\n",
+		 in_be32(&repriv->re_regs->global_config));
+
+	/* Program Galois Field polynomial */
+	out_be32(&repriv->re_regs->galois_field_config, RE_GFM_POLY);
+	dev_info(dev, "Galois Field Polynomial is %x\n",
+		 in_be32(&repriv->re_regs->galois_field_config));
+
+	dma_dev = &repriv->dma_dev;
+	dma_dev->dev = dev;
+	INIT_LIST_HEAD(&dma_dev->channels);
+	dma_set_mask(dev, DMA_BIT_MASK(40));
+
+	dma_dev->device_alloc_chan_resources = re_jr_alloc_chan_resources;
+	dma_dev->device_tx_status = re_jr_tx_status;
+	dma_dev->device_issue_pending = re_jr_issue_pending;
+
+	dma_dev->max_xor = MAX_XOR_SRCS;
+	dma_dev->device_prep_dma_xor = re_jr_prep_dma_xor;
+	dma_cap_set(DMA_XOR, dma_dev->cap_mask);
+
+	dma_dev->max_pq = MAX_PQ_SRCS;
+	dma_dev->device_prep_dma_pq = re_jr_prep_pq;
+	dma_cap_set(DMA_PQ, dma_dev->cap_mask);
+
+	dma_dev->device_prep_dma_memcpy = re_jr_prep_memcpy;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+
+	dma_dev->device_free_chan_resources = re_jr_free_chan_resources;
+
+	repriv->total_jrs = 0;
+
+	repriv->cf_desc_pool = dmam_pool_create("re_cf_desc_pool", dev,
+					RE_CF_CDB_SIZE,
+					RE_CF_CDB_ALIGN, 0);
+
+	if (!repriv->cf_desc_pool) {
+		pr_err("No memory for dma desc pool\n");
+		return -ENOMEM;
+	}
+
+	repriv->hw_desc_pool = dmam_pool_create("re_hw_desc_pool", dev,
+				sizeof(struct jr_hw_desc) * RING_SIZE,
+				FRAME_DESC_ALIGNMENT, 0);
+	if (!repriv->hw_desc_pool) {
+		pr_err("No memory for hw desc pool\n");
+		return -ENOMEM;
+	}
+
+	/* Parse Device tree to find out the total number of JQs present */
+	for_each_compatible_node(np, NULL, "fsl,raideng-v1.0-job-queue") {
+		rc = of_property_read_u32(np, "reg", &off);
+		if (rc) {
+			dev_err(dev, "Reg property not found in JQ node\n");
+			return -ENODEV;
+		}
+		/* Find out the Job Rings present under each JQ */
+		for_each_child_of_node(np, child) {
+			rc = of_device_is_compatible(child,
+					"fsl,raideng-v1.0-job-ring");
+			if (rc) {
+				re_jr_probe(ofdev, child, ridx++, off);
+				repriv->total_jrs++;
+			}
+		}
+	}
+
+	dma_async_device_register(dma_dev);
+
+	return 0;
+}
+
+static void release_jr(struct re_jr *jr)
+{
+	dma_pool_free(jr->re_dev->hw_desc_pool, jr->inb_ring_virt_addr,
+		      jr->inb_phys_addr);
+
+	dma_pool_free(jr->re_dev->hw_desc_pool, jr->oub_ring_virt_addr,
+		      jr->oub_phys_addr);
+}
+
+static int raide_remove(struct platform_device *ofdev)
+{
+	struct re_drv_private *repriv;
+	struct device *dev;
+	int i;
+
+	dev = &ofdev->dev;
+	repriv = dev_get_drvdata(dev);
+
+	/* Cleanup JR related memory areas */
+	for (i = 0; i < repriv->total_jrs; i++)
+		release_jr(repriv->re_jrs[i]);
+
+	/* Unregister the driver */
+	dma_async_device_unregister(&repriv->dma_dev);
+
+	return 0;
+}
+
+static struct of_device_id raide_ids[] = {
+	{ .compatible = "fsl,raideng-v1.0", },
+	{}
+};
+
+static struct platform_driver raide_driver = {
+	.driver = {
+		.name = "fsl-raideng",
+		.owner = THIS_MODULE,
+		.of_match_table = raide_ids,
+	},
+	.probe = raide_probe,
+	.remove = raide_remove,
+};
+
+module_platform_driver(raide_driver);
+
+MODULE_AUTHOR("Harninder Rai <harninder.rai@freescale.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Freescale RAID Engine Device Driver");
diff --git a/drivers/dma/fsl_raid.h b/drivers/dma/fsl_raid.h
new file mode 100644
index 0000000..225dbf2
--- /dev/null
+++ b/drivers/dma/fsl_raid.h
@@ -0,0 +1,307 @@
+/*
+ * drivers/dma/fsl_raid.h
+ *
+ * Freescale RAID Engine device driver
+ *
+ * Author:
+ *	Harninder Rai <harninder.rai@freescale.com>
+ *	Naveen Burmi <naveenburmi@freescale.com>
+ *
+ * Rewrite:
+ *	Xuelin Shi <xuelin.shi@freescale.com>
+
+ * Copyright (c) 2010-2012 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#define MAX_RE_JRS		4
+
+#define RE_DPAA_MODE		(1 << 30)
+#define RE_NON_DPAA_MODE	(1 << 31)
+#define RE_GFM_POLY		0x1d000000
+#define RE_JR_INB_JOB_ADD(x)	((x) << 16)
+#define RE_JR_OUB_JOB_RMVD(x)	((x) << 16)
+#define RE_JR_CFG1_CBSI		0x08000000
+#define RE_JR_CFG1_CBS0		0x00080000
+#define RE_JR_OUB_SLOT_FULL_SHIFT	8
+#define RE_JR_OUB_SLOT_FULL(x)	((x) >> RE_JR_OUB_SLOT_FULL_SHIFT)
+#define RE_JR_INB_SLOT_AVAIL_SHIFT	8
+#define RE_JR_INB_SLOT_AVAIL(x)	((x) >> RE_JR_INB_SLOT_AVAIL_SHIFT)
+#define RE_PQ_OPCODE		0x1B
+#define RE_XOR_OPCODE		0x1A
+#define RE_MOVE_OPCODE		0x8
+#define FRAME_DESC_ALIGNMENT	16
+#define RE_BLOCK_SIZE		0x3 /* 4096 bytes */
+#define CACHEABLE_INPUT_OUTPUT	0x0
+#define BUFFERABLE_OUTPUT	0x0
+#define INTERRUPT_ON_ERROR	0x1
+#define DATA_DEPENDENCY		0x1
+#define ENABLE_DPI		0x0
+#define RING_SIZE		0x400
+#define RING_SIZE_MASK		(RING_SIZE - 1)
+#define RING_SIZE_SHIFT		8
+#define RE_JR_ADDRESS_BIT_SHIFT	4
+#define RE_JR_ADDRESS_BIT_MASK	((1 << RE_JR_ADDRESS_BIT_SHIFT) - 1)
+#define RE_JR_ERROR		0x40000000
+#define RE_JR_INTERRUPT		0x80000000
+#define RE_JR_CLEAR_INT		0x80000000
+#define RE_JR_PAUSE		0x80000000
+#define RE_JR_ENABLE		0x80000000
+
+#define RE_JR_REG_LIODN_MASK	0x00000FFF
+#define RE_CF_CDB_ALIGN		64
+
+#define RE_CDB_OPCODE_MASK	0xF8000000
+#define RE_CDB_OPCODE_SHIFT	27
+#define RE_CDB_EXCLEN_MASK	0x03000000
+#define RE_CDB_EXCLEN_SHIFT	24
+#define RE_CDB_EXCLQ1_MASK	0x00F00000
+#define RE_CDB_EXCLQ1_SHIFT	20
+#define RE_CDB_EXCLQ2_MASK	0x000F0000
+#define RE_CDB_EXCLQ2_SHIFT	16
+#define RE_CDB_BLKSIZE_MASK	0x0000C000
+#define RE_CDB_BLKSIZE_SHIFT	14
+#define RE_CDB_CACHE_MASK	0x00003000
+#define RE_CDB_CACHE_SHIFT	12
+#define RE_CDB_BUFFER_MASK	0x00000800
+#define RE_CDB_BUFFER_SHIFT	11
+#define RE_CDB_ERROR_MASK	0x00000400
+#define RE_CDB_ERROR_SHIFT	10
+#define RE_CDB_NRCS_MASK	0x0000003C
+#define RE_CDB_NRCS_SHIFT	6
+#define RE_CDB_DEPEND_MASK	0x00000008
+#define RE_CDB_DEPEND_SHIFT	3
+#define RE_CDB_DPI_MASK		0x00000004
+#define RE_CDB_DPI_SHIFT	2
+
+/*
+ * the largest cf block is 19*sizeof(struct cmpnd_frame), which is 304 bytes.
+ * here 19 = 1(cdb)+2(dest)+16(src), align to 64bytes, that is 320 bytes.
+ * the largest cdb block: struct pq_cdb which is 180 bytes, adding to cf block
+ * 320+180=500, align to 64bytes, that is 512 bytes.
+ */
+#define RE_CF_DESC_SIZE		320
+#define RE_CF_CDB_SIZE		512
+
+struct re_ctrl {
+	/* General Configuration Registers */
+	__be32 global_config;	/* Global Configuration Register */
+	u8     rsvd1[4];
+	__be32 galois_field_config; /* Galois Field Configuration Register */
+	u8     rsvd2[4];
+	__be32 jq_wrr_config;   /* WRR Configuration register */
+	u8     rsvd3[4];
+	__be32 crc_config;	/* CRC Configuration register */
+	u8     rsvd4[228];
+	__be32 system_reset;	/* System Reset Register */
+	u8     rsvd5[252];
+	__be32 global_status;	/* Global Status Register */
+	u8     rsvd6[832];
+	__be32 re_liodn_base;	/* LIODN Base Register */
+	u8     rsvd7[1712];
+	__be32 re_version_id;	/* Version ID register of RE */
+	__be32 re_version_id_2; /* Version ID 2 register of RE */
+	u8     rsvd8[512];
+	__be32 host_config;	/* Host I/F Configuration Register */
+};
+
+struct jr_config_regs {
+	/* Registers for JR interface */
+	__be32 jr_config_0;	/* Job Queue Configuration 0 Register */
+	__be32 jr_config_1;	/* Job Queue Configuration 1 Register */
+	__be32 jr_interrupt_status; /* Job Queue Interrupt Status Register */
+	u8     rsvd1[4];
+	__be32 jr_command;	/* Job Queue Command Register */
+	u8     rsvd2[4];
+	__be32 jr_status;	/* Job Queue Status Register */
+	u8     rsvd3[228];
+
+	/* Input Ring */
+	__be32 inbring_base_h;	/* Inbound Ring Base Address Register - High */
+	__be32 inbring_base_l;	/* Inbound Ring Base Address Register - Low */
+	__be32 inbring_size;	/* Inbound Ring Size Register */
+	u8     rsvd4[4];
+	__be32 inbring_slot_avail; /* Inbound Ring Slot Available Register */
+	u8     rsvd5[4];
+	__be32 inbring_add_job;	/* Inbound Ring Add Job Register */
+	u8     rsvd6[4];
+	__be32 inbring_cnsmr_indx; /* Inbound Ring Consumer Index Register */
+	u8     rsvd7[220];
+
+	/* Output Ring */
+	__be32 oubring_base_h;	/* Outbound Ring Base Address Register - High */
+	__be32 oubring_base_l;	/* Outbound Ring Base Address Register - Low */
+	__be32 oubring_size;	/* Outbound Ring Size Register */
+	u8     rsvd8[4];
+	__be32 oubring_job_rmvd; /* Outbound Ring Job Removed Register */
+	u8     rsvd9[4];
+	__be32 oubring_slot_full; /* Outbound Ring Slot Full Register */
+	u8     rsvd10[4];
+	__be32 oubring_prdcr_indx; /* Outbound Ring Producer Index */
+};
+
+/*
+ * Command Descriptor Block (CDB) for unicast move command.
+ * In RAID Engine terms, memcpy is done through move command
+ */
+struct move_cdb {
+	__be32 cdb32;
+};
+
+/* Data protection/integrity related fields */
+#define DPI_APPS_MASK		0xC0000000
+#define DPI_APPS_SHIFT		30
+#define DPI_REF_MASK		0x30000000
+#define DPI_REF_SHIFT		28
+#define DPI_GUARD_MASK		0x0C000000
+#define DPI_GUARD_SHIFT		26
+#define DPI_ATTR_MASK		0x03000000
+#define DPI_ATTR_SHIFT		24
+#define DPI_META_MASK		0x0000FFFF
+
+struct dpi_related {
+	__be32 dpi32;
+	__be32 ref;
+};
+
+/*
+ * CDB for GenQ command. In RAID Engine terminology, XOR is
+ * done through this command
+ */
+struct xor_cdb {
+	__be32 cdb32;
+	u8 gfm[16];
+	struct dpi_related dpi_dest_spec;
+	struct dpi_related dpi_src_spec[16];
+};
+
+/* CDB for no-op command */
+struct noop_cdb {
+	__be32 cdb32;
+};
+
+/*
+ * CDB for GenQQ command. In RAID Engine terminology, P/Q is
+ * done through this command
+ */
+struct pq_cdb {
+	__be32 cdb32;
+	u8 gfm_q1[16];
+	u8 gfm_q2[16];
+	struct dpi_related dpi_dest_spec[2];
+	struct dpi_related dpi_src_spec[16];
+};
+
+/* Compound frame */
+#define CF_ADDR_HIGH_MASK	0x000000FF
+#define CF_EXT_MASK		0x80000000
+#define CF_EXT_SHIFT		31
+#define CF_FINAL_MASK		0x40000000
+#define CF_FINAL_SHIFT		30
+#define CF_LENGTH_MASK		0x000FFFFF
+#define CF_BPID_MASK		0x00FF0000
+#define CF_BPID_SHIFT		16
+#define CF_OFFSET_MASK		0x00001FFF
+
+struct cmpnd_frame {
+	__be32 addr_high;
+	__be32 addr_low;
+	__be32 efrl32;
+	__be32 rbro32;
+};
+
+/* Frame descriptor */
+#define HWDESC_LIODN_MASK	0x3F000000
+#define HWDESC_LIODN_SHIFT	24
+#define HWDESC_BPID_MASK	0x00FF0000
+#define HWDESC_BPID_SHIFT	16
+#define HWDESC_ELIODN_MASK	0x0000F000
+#define HWDESC_ELIODN_SHIFT	12
+#define HWDESC_FMT_SHIFT	29
+#define HWDESC_FMT_MASK		(0x3 << HWDESC_FMT_SHIFT)
+
+struct jr_hw_desc {
+	__be32 lbea32;
+	__be32 addr_low;
+	__be32 fmt32;
+	__be32 status;
+};
+
+/* Raid Engine device private data */
+struct re_drv_private {
+	u8 total_jrs;
+	struct dma_device dma_dev;
+	struct re_ctrl *re_regs;
+	struct re_jr *re_jrs[MAX_RE_JRS];
+	struct dma_pool *cf_desc_pool;
+	struct dma_pool *hw_desc_pool;
+};
+
+/* Per job ring data structure */
+struct re_jr {
+	char name[16];
+	spinlock_t desc_lock; /* queue lock */
+	struct list_head ack_q;  /* wait to acked queue */
+	struct list_head active_q; /* already issued on hw, not completed */
+	struct list_head submit_q;
+	struct list_head free_q; /* alloc available queue */
+	struct device *dev;
+	struct re_drv_private *re_dev;
+	struct dma_chan chan;
+	struct jr_config_regs *jrregs;
+	int irq;
+	u32 alloc_count;
+
+	/* hw descriptor ring for inbound queue*/
+	dma_addr_t inb_phys_addr;
+	struct jr_hw_desc *inb_ring_virt_addr;
+	u32 inb_count;
+
+	/* hw descriptor ring for outbound queue */
+	dma_addr_t oub_phys_addr;
+	struct jr_hw_desc *oub_ring_virt_addr;
+	u32 oub_count;
+};
+
+/* Async transaction descriptor */
+struct fsl_re_dma_async_tx_desc {
+	struct dma_async_tx_descriptor async_tx;
+	struct list_head node;
+	struct jr_hw_desc hwdesc;
+	struct re_jr *jr;
+
+	/* hwdesc will point to cf_addr */
+	void *cf_addr;
+	dma_addr_t cf_paddr;
+
+	void *cdb_addr;
+	dma_addr_t cdb_paddr;
+	int status;
+};
-- 
1.8.3.2
