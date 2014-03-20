Return-Path: <xuelin.shi@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 237782C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 20:00:06 +1100 (EST)
From: <xuelin.shi@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>
Subject: [PATCH v2] fix wrong usage of dmaengine_unmap_put in async_xxx
Date: Thu, 20 Mar 2014 16:16:25 +0800
Message-ID: <1395303385-29461-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Xuelin Shi <xuelin.shi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@freescale.com>

dmaengine_unmap_put does below two things:
a) unmap pages for srcs and dests
b) free unmap struct

The unmap struct data is generated but only initialized while
other some dma contions are met, like dma alignment etc.
If the unmap data is not initialized, call dmaengine_unmap_put
will unmap some random data in unmap->addr[...]

Also call dmaengine_get_unmap_data immediatally after generating tx
is not correct. Maybe the tx has not been finished by DMA hardware
yet but the srcs and dests are dma unmapped.

This patch fixed above two issues by:
a) only generates unmap struct data when other dma conditions are met.
b) eliminates dmaengine_unmap_put when tx is generated because tx knowes
the best time to unmap it (in interrupt processing).

Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
---
change log:
	v1: include change in async_memcpy, async_xor, async_pq
 	v2: add change in async_raid6_recov.c and fix some style issue

 crypto/async_tx/async_memcpy.c      |  80 ++++++++-------
 crypto/async_tx/async_pq.c          | 189 +++++++++++++++++++-----------------
 crypto/async_tx/async_raid6_recov.c | 108 +++++++++++----------
 crypto/async_tx/async_xor.c         | 164 ++++++++++++++++---------------
 4 files changed, 286 insertions(+), 255 deletions(-)

diff --git a/crypto/async_tx/async_memcpy.c b/crypto/async_tx/async_memcpy.c
index f8c0b8d..6546e87 100644
--- a/crypto/async_tx/async_memcpy.c
+++ b/crypto/async_tx/async_memcpy.c
@@ -51,11 +51,10 @@ async_memcpy(struct page *dest, struct page *src, unsigned int dest_offset,
 	struct dma_device *device = chan ? chan->device : NULL;
 	struct dma_async_tx_descriptor *tx = NULL;
 	struct dmaengine_unmap_data *unmap = NULL;
+	void *dest_buf, *src_buf;
 
-	if (device)
-		unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOIO);
-
-	if (unmap && is_dma_copy_aligned(device, src_offset, dest_offset, len)) {
+	if (device &&
+	    is_dma_copy_aligned(device, src_offset, dest_offset, len)) {
 		unsigned long dma_prep_flags = 0;
 
 		if (submit->cb_fn)
@@ -63,45 +62,56 @@ async_memcpy(struct page *dest, struct page *src, unsigned int dest_offset,
 		if (submit->flags & ASYNC_TX_FENCE)
 			dma_prep_flags |= DMA_PREP_FENCE;
 
-		unmap->to_cnt = 1;
-		unmap->addr[0] = dma_map_page(device->dev, src, src_offset, len,
-					      DMA_TO_DEVICE);
-		unmap->from_cnt = 1;
-		unmap->addr[1] = dma_map_page(device->dev, dest, dest_offset, len,
-					      DMA_FROM_DEVICE);
-		unmap->len = len;
-
-		tx = device->device_prep_dma_memcpy(chan, unmap->addr[1],
-						    unmap->addr[0], len,
-						    dma_prep_flags);
+		unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOIO);
+		if (unmap) {
+			unmap->to_cnt = 1;
+			unmap->addr[0] = dma_map_page(device->dev, src,
+						      src_offset, len,
+						      DMA_TO_DEVICE);
+			unmap->from_cnt = 1;
+			unmap->addr[1] = dma_map_page(device->dev, dest,
+						      dest_offset, len,
+						      DMA_FROM_DEVICE);
+			unmap->len = len;
+
+			tx = device->device_prep_dma_memcpy(chan,
+							    unmap->addr[1],
+							    unmap->addr[0],
+							    len,
+							    dma_prep_flags);
+			if (tx) {
+				pr_debug("%s: (async) len: %zu\n", __func__,
+					 len);
+
+				dma_set_unmap(tx, unmap);
+				async_tx_submit(chan, tx, submit);
+				return tx;
+			}
+
+			/* could not get a descriptor, unmap and fall through to
+			 * the synchronous path
+			 */
+			dmaengine_unmap_put(unmap);
+		}
 	}
 
-	if (tx) {
-		pr_debug("%s: (async) len: %zu\n", __func__, len);
+	/* run the operation synchronously */
+	pr_debug("%s: (sync) len: %zu\n", __func__, len);
 
-		dma_set_unmap(tx, unmap);
-		async_tx_submit(chan, tx, submit);
-	} else {
-		void *dest_buf, *src_buf;
-		pr_debug("%s: (sync) len: %zu\n", __func__, len);
+	/* wait for any prerequisite operations */
+	async_tx_quiesce(&submit->depend_tx);
 
-		/* wait for any prerequisite operations */
-		async_tx_quiesce(&submit->depend_tx);
+	dest_buf = kmap_atomic(dest) + dest_offset;
+	src_buf = kmap_atomic(src) + src_offset;
 
-		dest_buf = kmap_atomic(dest) + dest_offset;
-		src_buf = kmap_atomic(src) + src_offset;
+	memcpy(dest_buf, src_buf, len);
 
-		memcpy(dest_buf, src_buf, len);
-
-		kunmap_atomic(src_buf);
-		kunmap_atomic(dest_buf);
-
-		async_tx_sync_epilog(submit);
-	}
+	kunmap_atomic(src_buf);
+	kunmap_atomic(dest_buf);
 
-	dmaengine_unmap_put(unmap);
+	async_tx_sync_epilog(submit);
 
-	return tx;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(async_memcpy);
 
diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
index d05327c..f446cda 100644
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -175,10 +175,7 @@ async_gen_syndrome(struct page **blocks, unsigned int offset, int disks,
 
 	BUG_ON(disks > 255 || !(P(blocks, disks) || Q(blocks, disks)));
 
-	if (device)
-		unmap = dmaengine_get_unmap_data(device->dev, disks, GFP_NOIO);
-
-	if (unmap &&
+	if (device &&
 	    (src_cnt <= dma_maxpq(device, 0) ||
 	     dma_maxpq(device, DMA_PREP_CONTINUE) > 0) &&
 	    is_dma_pq_aligned(device, offset, 0, len)) {
@@ -194,46 +191,54 @@ async_gen_syndrome(struct page **blocks, unsigned int offset, int disks,
 		/* convert source addresses being careful to collapse 'empty'
 		 * sources and update the coefficients accordingly
 		 */
-		unmap->len = len;
-		for (i = 0, j = 0; i < src_cnt; i++) {
-			if (blocks[i] == NULL)
-				continue;
-			unmap->addr[j] = dma_map_page(device->dev, blocks[i], offset,
-						      len, DMA_TO_DEVICE);
-			coefs[j] = raid6_gfexp[i];
-			unmap->to_cnt++;
-			j++;
-		}
+		unmap = dmaengine_get_unmap_data(device->dev, disks, GFP_NOIO);
+		if (unmap) {
+			unmap->len = len;
+			for (i = 0, j = 0; i < src_cnt; i++) {
+				if (blocks[i] == NULL)
+					continue;
+				unmap->addr[j] = dma_map_page(device->dev,
+							      blocks[i],
+							      offset,
+							      len,
+							      DMA_TO_DEVICE);
+				coefs[j] = raid6_gfexp[i];
+				unmap->to_cnt++;
+				j++;
+			}
 
-		/*
-		 * DMAs use destinations as sources,
-		 * so use BIDIRECTIONAL mapping
-		 */
-		unmap->bidi_cnt++;
-		if (P(blocks, disks))
-			unmap->addr[j++] = dma_map_page(device->dev, P(blocks, disks),
-							offset, len, DMA_BIDIRECTIONAL);
-		else {
-			unmap->addr[j++] = 0;
-			dma_flags |= DMA_PREP_PQ_DISABLE_P;
-		}
+			/*
+			 * DMAs use destinations as sources,
+			 * so use BIDIRECTIONAL mapping
+			 */
+			unmap->bidi_cnt++;
+			if (P(blocks, disks))
+				unmap->addr[j++] = dma_map_page(device->dev,
+							P(blocks, disks),
+							offset, len,
+							DMA_BIDIRECTIONAL);
+			else {
+				unmap->addr[j++] = 0;
+				dma_flags |= DMA_PREP_PQ_DISABLE_P;
+			}
 
-		unmap->bidi_cnt++;
-		if (Q(blocks, disks))
-			unmap->addr[j++] = dma_map_page(device->dev, Q(blocks, disks),
-						       offset, len, DMA_BIDIRECTIONAL);
-		else {
-			unmap->addr[j++] = 0;
-			dma_flags |= DMA_PREP_PQ_DISABLE_Q;
-		}
+			unmap->bidi_cnt++;
+			if (Q(blocks, disks))
+				unmap->addr[j++] = dma_map_page(device->dev,
+							Q(blocks, disks),
+							offset, len,
+							DMA_BIDIRECTIONAL);
+			else {
+				unmap->addr[j++] = 0;
+				dma_flags |= DMA_PREP_PQ_DISABLE_Q;
+			}
 
-		tx = do_async_gen_syndrome(chan, coefs, j, unmap, dma_flags, submit);
-		dmaengine_unmap_put(unmap);
-		return tx;
+			tx = do_async_gen_syndrome(chan, coefs, j, unmap,
+						   dma_flags, submit);
+			return tx;
+		}
 	}
 
-	dmaengine_unmap_put(unmap);
-
 	/* run the pq synchronously */
 	pr_debug("%s: (sync) disks: %d len: %zu\n", __func__, disks, len);
 
@@ -293,10 +298,7 @@ async_syndrome_val(struct page **blocks, unsigned int offset, int disks,
 
 	BUG_ON(disks < 4);
 
-	if (device)
-		unmap = dmaengine_get_unmap_data(device->dev, disks, GFP_NOIO);
-
-	if (unmap && disks <= dma_maxpq(device, 0) &&
+	if (device && disks <= dma_maxpq(device, 0) &&
 	    is_dma_pq_aligned(device, offset, 0, len)) {
 		struct device *dev = device->dev;
 		dma_addr_t pq[2];
@@ -305,58 +307,63 @@ async_syndrome_val(struct page **blocks, unsigned int offset, int disks,
 		pr_debug("%s: (async) disks: %d len: %zu\n",
 			 __func__, disks, len);
 
-		unmap->len = len;
-		for (i = 0; i < disks-2; i++)
-			if (likely(blocks[i])) {
-				unmap->addr[j] = dma_map_page(dev, blocks[i],
-							      offset, len,
+		unmap = dmaengine_get_unmap_data(device->dev, disks, GFP_NOIO);
+		if (unmap) {
+			unmap->len = len;
+			for (i = 0; i < disks-2; i++)
+				if (likely(blocks[i])) {
+					unmap->addr[j] = dma_map_page(dev,
+							      blocks[i],
+							      offset,
+							      len,
 							      DMA_TO_DEVICE);
-				coefs[j] = raid6_gfexp[i];
+					coefs[j] = raid6_gfexp[i];
+					unmap->to_cnt++;
+					src_cnt++;
+					j++;
+				}
+
+			if (!P(blocks, disks)) {
+				pq[0] = 0;
+				dma_flags |= DMA_PREP_PQ_DISABLE_P;
+			} else {
+				pq[0] = dma_map_page(dev, P(blocks, disks),
+						     offset, len,
+						     DMA_TO_DEVICE);
+				unmap->addr[j++] = pq[0];
+				unmap->to_cnt++;
+			}
+			if (!Q(blocks, disks)) {
+				pq[1] = 0;
+				dma_flags |= DMA_PREP_PQ_DISABLE_Q;
+			} else {
+				pq[1] = dma_map_page(dev, Q(blocks, disks),
+						     offset, len,
+						     DMA_TO_DEVICE);
+				unmap->addr[j++] = pq[1];
 				unmap->to_cnt++;
-				src_cnt++;
-				j++;
 			}
 
-		if (!P(blocks, disks)) {
-			pq[0] = 0;
-			dma_flags |= DMA_PREP_PQ_DISABLE_P;
-		} else {
-			pq[0] = dma_map_page(dev, P(blocks, disks),
-					     offset, len,
-					     DMA_TO_DEVICE);
-			unmap->addr[j++] = pq[0];
-			unmap->to_cnt++;
-		}
-		if (!Q(blocks, disks)) {
-			pq[1] = 0;
-			dma_flags |= DMA_PREP_PQ_DISABLE_Q;
-		} else {
-			pq[1] = dma_map_page(dev, Q(blocks, disks),
-					     offset, len,
-					     DMA_TO_DEVICE);
-			unmap->addr[j++] = pq[1];
-			unmap->to_cnt++;
-		}
-
-		if (submit->flags & ASYNC_TX_FENCE)
-			dma_flags |= DMA_PREP_FENCE;
-		for (;;) {
-			tx = device->device_prep_dma_pq_val(chan, pq,
-							    unmap->addr,
-							    src_cnt,
-							    coefs,
-							    len, pqres,
-							    dma_flags);
-			if (likely(tx))
-				break;
-			async_tx_quiesce(&submit->depend_tx);
-			dma_async_issue_pending(chan);
-		}
+			if (submit->flags & ASYNC_TX_FENCE)
+				dma_flags |= DMA_PREP_FENCE;
+			for (;;) {
+				tx = device->device_prep_dma_pq_val(chan, pq,
+								    unmap->addr,
+								    src_cnt,
+								    coefs,
+								    len, pqres,
+								    dma_flags);
+				if (likely(tx))
+					break;
+				async_tx_quiesce(&submit->depend_tx);
+				dma_async_issue_pending(chan);
+			}
 
-		dma_set_unmap(tx, unmap);
-		async_tx_submit(chan, tx, submit);
+			dma_set_unmap(tx, unmap);
+			async_tx_submit(chan, tx, submit);
 
-		return tx;
+			return tx;
+		}
 	} else {
 		struct page *p_src = P(blocks, disks);
 		struct page *q_src = Q(blocks, disks);
@@ -411,9 +418,9 @@ async_syndrome_val(struct page **blocks, unsigned int offset, int disks,
 		submit->cb_param = cb_param_orig;
 		submit->flags = flags_orig;
 		async_tx_sync_epilog(submit);
-
-		return NULL;
 	}
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(async_syndrome_val);
 
diff --git a/crypto/async_tx/async_raid6_recov.c b/crypto/async_tx/async_raid6_recov.c
index 934a849..c55d8f1 100644
--- a/crypto/async_tx/async_raid6_recov.c
+++ b/crypto/async_tx/async_raid6_recov.c
@@ -40,10 +40,7 @@ async_sum_product(struct page *dest, struct page **srcs, unsigned char *coef,
 	u8 ax, bx;
 	u8 *a, *b, *c;
 
-	if (dma)
-		unmap = dmaengine_get_unmap_data(dma->dev, 3, GFP_NOIO);
-
-	if (unmap) {
+	if (dma) {
 		struct device *dev = dma->dev;
 		dma_addr_t pq[2];
 		struct dma_async_tx_descriptor *tx;
@@ -51,29 +48,35 @@ async_sum_product(struct page *dest, struct page **srcs, unsigned char *coef,
 
 		if (submit->flags & ASYNC_TX_FENCE)
 			dma_flags |= DMA_PREP_FENCE;
-		unmap->addr[0] = dma_map_page(dev, srcs[0], 0, len, DMA_TO_DEVICE);
-		unmap->addr[1] = dma_map_page(dev, srcs[1], 0, len, DMA_TO_DEVICE);
-		unmap->to_cnt = 2;
-
-		unmap->addr[2] = dma_map_page(dev, dest, 0, len, DMA_BIDIRECTIONAL);
-		unmap->bidi_cnt = 1;
-		/* engine only looks at Q, but expects it to follow P */
-		pq[1] = unmap->addr[2];
-
-		unmap->len = len;
-		tx = dma->device_prep_dma_pq(chan, pq, unmap->addr, 2, coef,
-					     len, dma_flags);
-		if (tx) {
-			dma_set_unmap(tx, unmap);
-			async_tx_submit(chan, tx, submit);
+
+		unmap = dmaengine_get_unmap_data(dma->dev, 3, GFP_NOIO);
+		if (unmap) {
+			unmap->addr[0] = dma_map_page(dev, srcs[0], 0, len,
+						      DMA_TO_DEVICE);
+			unmap->addr[1] = dma_map_page(dev, srcs[1], 0, len,
+						      DMA_TO_DEVICE);
+			unmap->to_cnt = 2;
+
+			unmap->addr[2] = dma_map_page(dev, dest, 0, len,
+						      DMA_BIDIRECTIONAL);
+			unmap->bidi_cnt = 1;
+			/* engine only looks at Q, but expects it to follow P */
+			pq[1] = unmap->addr[2];
+
+			unmap->len = len;
+			tx = dma->device_prep_dma_pq(chan, pq, unmap->addr, 2,
+						     coef, len, dma_flags);
+			if (tx) {
+				dma_set_unmap(tx, unmap);
+				async_tx_submit(chan, tx, submit);
+				return tx;
+			}
+
+			/* could not get a descriptor, unmap and fall through to
+			 * the synchronous path
+			 */
 			dmaengine_unmap_put(unmap);
-			return tx;
 		}
-
-		/* could not get a descriptor, unmap and fall through to
-		 * the synchronous path
-		 */
-		dmaengine_unmap_put(unmap);
 	}
 
 	/* run the operation synchronously */
@@ -104,10 +107,7 @@ async_mult(struct page *dest, struct page *src, u8 coef, size_t len,
 	const u8 *qmul; /* Q multiplier table */
 	u8 *d, *s;
 
-	if (dma)
-		unmap = dmaengine_get_unmap_data(dma->dev, 3, GFP_NOIO);
-
-	if (unmap) {
+	if (dma) {
 		dma_addr_t dma_dest[2];
 		struct device *dev = dma->dev;
 		struct dma_async_tx_descriptor *tx;
@@ -115,31 +115,37 @@ async_mult(struct page *dest, struct page *src, u8 coef, size_t len,
 
 		if (submit->flags & ASYNC_TX_FENCE)
 			dma_flags |= DMA_PREP_FENCE;
-		unmap->addr[0] = dma_map_page(dev, src, 0, len, DMA_TO_DEVICE);
-		unmap->to_cnt++;
-		unmap->addr[1] = dma_map_page(dev, dest, 0, len, DMA_BIDIRECTIONAL);
-		dma_dest[1] = unmap->addr[1];
-		unmap->bidi_cnt++;
-		unmap->len = len;
-
-		/* this looks funny, but the engine looks for Q at
-		 * dma_dest[1] and ignores dma_dest[0] as a dest
-		 * due to DMA_PREP_PQ_DISABLE_P
-		 */
-		tx = dma->device_prep_dma_pq(chan, dma_dest, unmap->addr,
-					     1, &coef, len, dma_flags);
 
-		if (tx) {
-			dma_set_unmap(tx, unmap);
+		unmap = dmaengine_get_unmap_data(dma->dev, 3, GFP_NOIO);
+		if (unmap) {
+			unmap->addr[0] = dma_map_page(dev, src, 0, len,
+						      DMA_TO_DEVICE);
+			unmap->to_cnt++;
+			unmap->addr[1] = dma_map_page(dev, dest, 0, len,
+						      DMA_BIDIRECTIONAL);
+			dma_dest[1] = unmap->addr[1];
+			unmap->bidi_cnt++;
+			unmap->len = len;
+
+			/* this looks funny, but the engine looks for Q at
+			 * dma_dest[1] and ignores dma_dest[0] as a dest
+			 * due to DMA_PREP_PQ_DISABLE_P
+			 */
+			tx = dma->device_prep_dma_pq(chan, dma_dest,
+						     unmap->addr, 1, &coef,
+						     len, dma_flags);
+
+			if (tx) {
+				dma_set_unmap(tx, unmap);
+				async_tx_submit(chan, tx, submit);
+				return tx;
+			}
+
+			/* could not get a descriptor, unmap and fall through to
+			 * the synchronous path
+			 */
 			dmaengine_unmap_put(unmap);
-			async_tx_submit(chan, tx, submit);
-			return tx;
 		}
-
-		/* could not get a descriptor, unmap and fall through to
-		 * the synchronous path
-		 */
-		dmaengine_unmap_put(unmap);
 	}
 
 	/* no channel available, or failed to allocate a descriptor, so
diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index 3c562f5..019e469 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -182,55 +182,57 @@ async_xor(struct page *dest, struct page **src_list, unsigned int offset,
 
 	BUG_ON(src_cnt <= 1);
 
-	if (device)
-		unmap = dmaengine_get_unmap_data(device->dev, src_cnt+1, GFP_NOIO);
-
-	if (unmap && is_dma_xor_aligned(device, offset, 0, len)) {
+	if (device && is_dma_xor_aligned(device, offset, 0, len)) {
 		struct dma_async_tx_descriptor *tx;
 		int i, j;
 
 		/* run the xor asynchronously */
 		pr_debug("%s (async): len: %zu\n", __func__, len);
 
-		unmap->len = len;
-		for (i = 0, j = 0; i < src_cnt; i++) {
-			if (!src_list[i])
-				continue;
-			unmap->to_cnt++;
-			unmap->addr[j++] = dma_map_page(device->dev, src_list[i],
-							offset, len, DMA_TO_DEVICE);
-		}
+		unmap = dmaengine_get_unmap_data(device->dev, src_cnt + 1,
+						 GFP_NOIO);
+		if (unmap) {
+			unmap->len = len;
+			for (i = 0, j = 0; i < src_cnt; i++) {
+				if (!src_list[i])
+					continue;
+				unmap->to_cnt++;
+				unmap->addr[j++] = dma_map_page(device->dev,
+								src_list[i],
+								offset, len,
+								DMA_TO_DEVICE);
+			}
 
-		/* map it bidirectional as it may be re-used as a source */
-		unmap->addr[j] = dma_map_page(device->dev, dest, offset, len,
-					      DMA_BIDIRECTIONAL);
-		unmap->bidi_cnt = 1;
-
-		tx = do_async_xor(chan, unmap, submit);
-		dmaengine_unmap_put(unmap);
-		return tx;
-	} else {
-		dmaengine_unmap_put(unmap);
-		/* run the xor synchronously */
-		pr_debug("%s (sync): len: %zu\n", __func__, len);
-		WARN_ONCE(chan, "%s: no space for dma address conversion\n",
-			  __func__);
-
-		/* in the sync case the dest is an implied source
-		 * (assumes the dest is the first source)
-		 */
-		if (submit->flags & ASYNC_TX_XOR_DROP_DST) {
-			src_cnt--;
-			src_list++;
+			/* map it bidirectional as it may be re-used
+			   as a source */
+			unmap->addr[j] = dma_map_page(device->dev, dest, offset,
+						      len, DMA_BIDIRECTIONAL);
+			unmap->bidi_cnt = 1;
+
+			tx = do_async_xor(chan, unmap, submit);
+			return tx;
 		}
+	}
 
-		/* wait for any prerequisite operations */
-		async_tx_quiesce(&submit->depend_tx);
+	/* run the xor synchronously */
+	pr_debug("%s (sync): len: %zu\n", __func__, len);
+	WARN_ONCE(chan, "%s: no space for dma address conversion\n",
+		  __func__);
+
+	/* in the sync case the dest is an implied source
+	 * (assumes the dest is the first source)
+	 */
+	if (submit->flags & ASYNC_TX_XOR_DROP_DST) {
+		src_cnt--;
+		src_list++;
+	}
 
-		do_sync_xor(dest, src_list, offset, src_cnt, len, submit);
+	/* wait for any prerequisite operations */
+	async_tx_quiesce(&submit->depend_tx);
 
-		return NULL;
-	}
+	do_sync_xor(dest, src_list, offset, src_cnt, len, submit);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(async_xor);
 
@@ -275,13 +277,11 @@ async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 	struct dma_device *device = chan ? chan->device : NULL;
 	struct dma_async_tx_descriptor *tx = NULL;
 	struct dmaengine_unmap_data *unmap = NULL;
+	enum async_tx_flags flags_orig = submit->flags;
 
 	BUG_ON(src_cnt <= 1);
 
-	if (device)
-		unmap = dmaengine_get_unmap_data(device->dev, src_cnt, GFP_NOIO);
-
-	if (unmap && src_cnt <= device->max_xor &&
+	if (device && src_cnt <= device->max_xor &&
 	    is_dma_xor_aligned(device, offset, 0, len)) {
 		unsigned long dma_prep_flags = 0;
 		int i;
@@ -293,51 +293,59 @@ async_xor_val(struct page *dest, struct page **src_list, unsigned int offset,
 		if (submit->flags & ASYNC_TX_FENCE)
 			dma_prep_flags |= DMA_PREP_FENCE;
 
-		for (i = 0; i < src_cnt; i++) {
-			unmap->addr[i] = dma_map_page(device->dev, src_list[i],
-						      offset, len, DMA_TO_DEVICE);
-			unmap->to_cnt++;
-		}
-		unmap->len = len;
-
-		tx = device->device_prep_dma_xor_val(chan, unmap->addr, src_cnt,
-						     len, result,
-						     dma_prep_flags);
-		if (unlikely(!tx)) {
-			async_tx_quiesce(&submit->depend_tx);
-
-			while (!tx) {
-				dma_async_issue_pending(chan);
-				tx = device->device_prep_dma_xor_val(chan,
-					unmap->addr, src_cnt, len, result,
-					dma_prep_flags);
+		unmap = dmaengine_get_unmap_data(device->dev, src_cnt,
+						 GFP_NOIO);
+		if (unmap) {
+			for (i = 0; i < src_cnt; i++) {
+				unmap->addr[i] = dma_map_page(device->dev,
+							      src_list[i],
+							      offset, len,
+							      DMA_TO_DEVICE);
+				unmap->to_cnt++;
+			}
+			unmap->len = len;
+
+			tx = device->device_prep_dma_xor_val(chan, unmap->addr,
+							     src_cnt,
+							     len, result,
+							     dma_prep_flags);
+			if (unlikely(!tx)) {
+				async_tx_quiesce(&submit->depend_tx);
+
+				while (!tx) {
+					dma_async_issue_pending(chan);
+					tx = device->device_prep_dma_xor_val(
+							chan, unmap->addr,
+							src_cnt, len,
+							result, dma_prep_flags);
+				}
 			}
+			dma_set_unmap(tx, unmap);
+			async_tx_submit(chan, tx, submit);
+
+			return tx;
 		}
-		dma_set_unmap(tx, unmap);
-		async_tx_submit(chan, tx, submit);
-	} else {
-		enum async_tx_flags flags_orig = submit->flags;
+	}
 
-		pr_debug("%s: (sync) len: %zu\n", __func__, len);
-		WARN_ONCE(device && src_cnt <= device->max_xor,
-			  "%s: no space for dma address conversion\n",
-			  __func__);
+	/* run the xor_val synchronously */
+	pr_debug("%s: (sync) len: %zu\n", __func__, len);
+	WARN_ONCE(device && src_cnt <= device->max_xor,
+		  "%s: no space for dma address conversion\n",
+		  __func__);
 
-		submit->flags |= ASYNC_TX_XOR_DROP_DST;
-		submit->flags &= ~ASYNC_TX_ACK;
+	submit->flags |= ASYNC_TX_XOR_DROP_DST;
+	submit->flags &= ~ASYNC_TX_ACK;
 
-		tx = async_xor(dest, src_list, offset, src_cnt, len, submit);
+	tx = async_xor(dest, src_list, offset, src_cnt, len, submit);
 
-		async_tx_quiesce(&tx);
+	async_tx_quiesce(&tx);
 
-		*result = !page_is_zero(dest, offset, len) << SUM_CHECK_P;
+	*result = !page_is_zero(dest, offset, len) << SUM_CHECK_P;
 
-		async_tx_sync_epilog(submit);
-		submit->flags = flags_orig;
-	}
-	dmaengine_unmap_put(unmap);
+	async_tx_sync_epilog(submit);
+	submit->flags = flags_orig;
 
-	return tx;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(async_xor_val);
 
-- 
1.8.3.2
