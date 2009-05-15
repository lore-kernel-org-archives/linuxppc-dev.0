Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 57663DE0D5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 07:27:19 +1000 (EST)
Date: Fri, 15 May 2009 14:27:16 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] fsldma: fix infinite loop on multi-descriptor DMA chain
	completion
Message-ID: <20090515212716.GC858@ovro.caltech.edu>
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

When creating a DMA transaction with multiple descriptors, the async_tx
cookie is set to 0 for each descriptor in the chain, excluding the last
descriptor, whose cookie is set to -EBUSY.

When fsl_dma_tx_submit() is run, it only assigns a cookie to the first
descriptor. All of the remaining descriptors keep their original value,
including the last descriptor, which is set to -EBUSY.

After the DMA completes, the driver will update the last completed cookie
to be -EBUSY, which is an error code instead of a valid cookie. This causes
dma_async_is_complete() to always return DMA_IN_PROGRESS.

This causes the fsldma driver to never cleanup the queue of link
descriptors, and the driver will re-run the DMA transaction on the hardware
each time it receives the End-of-Chain interrupt. This causes an infinite
loop.

With this patch, fsl_dma_tx_submit() is changed to assign a cookie to every
descriptor in the chain. The rest of the code then works without problems.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

I discovered this bug while working to add DMA_SLAVE support to the
fsldma driver.

Steps to reproduce:
1) #define DEBUG 1
2) #define FSL_DMA_LD_DEBUG 1
3) change FSL_DMA_BCR_MAX_CNT to (1 << 18)
4) add code to print the cookie while dumping LDs in issue_pending()
5) create a single memcpy transaction 1MB in length

You will see that the cookie for the first transaction gets set to a
non-negative value, and the rest of the cookies are 0 or -EBUSY.

The driver will now keep re-submitting the LD queue forever, and your
machine will lock up. The message "xfer LDs starting from XXXXXXXX" will
be continuously printed to the kernel log.

 drivers/dma/fsldma.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index dba0b58..de0e5c8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -318,8 +318,8 @@ static void fsl_chan_toggle_ext_start(struct fsl_dma_chan *fsl_chan, int enable)
 
 static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
-	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
 	struct fsl_dma_chan *fsl_chan = to_fsl_chan(tx->chan);
+	struct fsl_desc_sw *desc;
 	unsigned long flags;
 	dma_cookie_t cookie;
 
@@ -327,14 +327,17 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
 
 	cookie = fsl_chan->common.cookie;
-	cookie++;
-	if (cookie < 0)
-		cookie = 1;
-	desc->async_tx.cookie = cookie;
-	fsl_chan->common.cookie = desc->async_tx.cookie;
-
-	append_ld_queue(fsl_chan, desc);
-	list_splice_init(&desc->async_tx.tx_list, fsl_chan->ld_queue.prev);
+	list_for_each_entry(desc, &tx->tx_list, node) {
+		cookie++;
+		if (cookie < 0)
+			cookie = 1;
+
+		desc->async_tx.cookie = cookie;
+	}
+
+	fsl_chan->common.cookie = cookie;
+	append_ld_queue(fsl_chan, tx_to_fsl_desc(tx));
+	list_splice_init(&tx->tx_list, fsl_chan->ld_queue.prev);
 
 	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
 
-- 
1.5.4.3
