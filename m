Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id CC3D5DE0EA
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 02:59:49 +1000 (EST)
Date: Fri, 15 May 2009 09:59:46 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] fsldma: fix memory leak on error path in fsl_dma_prep_memcpy()
Message-ID: <20090515165946.GA858@ovro.caltech.edu>
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

When preparing a memcpy operation, if the kernel fails to allocate memory
for a link descriptor after the first link descriptor has already been
allocated, then some memory will never be released. Fix the problem by
walking the list of allocated descriptors backwards, and freeing the
allocated descriptors back into the DMA pool.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index da8a8ed..4264c98 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -454,8 +454,8 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 {
 	struct fsl_dma_chan *fsl_chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new;
+	struct list_head *list;
 	size_t copy;
-	LIST_HEAD(link_chain);
 
 	if (!chan)
 		return NULL;
@@ -472,7 +472,7 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 		if (!new) {
 			dev_err(fsl_chan->dev,
 					"No free memory for link descriptor\n");
-			return NULL;
+			goto fail;
 		}
 #ifdef FSL_DMA_LD_DEBUG
 		dev_dbg(fsl_chan->dev, "new link desc alloc %p\n", new);
@@ -507,7 +507,19 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 	/* Set End-of-link to the last link descriptor of new list*/
 	set_ld_eol(fsl_chan, new);
 
-	return first ? &first->async_tx : NULL;
+	return &first->async_tx;
+
+fail:
+	if (!first)
+		return NULL;
+
+	list = &first->async_tx.tx_list;
+	list_for_each_entry_safe_reverse(new, prev, list, node) {
+		list_del(&new->node);
+		dma_pool_free(fsl_chan->desc_pool, new, new->async_tx.phys);
+	}
+
+	return NULL;
 }
 
 /**
-- 
1.5.4.3
