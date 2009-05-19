Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AE3C8DE154
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 08:42:17 +1000 (EST)
Date: Tue, 19 May 2009 15:42:13 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] fsldma: fix "DMA halt timeout!" errors
Message-ID: <20090519224213.GB31602@ovro.caltech.edu>
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

When using the DMA controller from multiple threads at the same time, it is
possible to get lots of "DMA halt timeout!" errors printed to the kernel
log.

This occurs due to a race between fsl_dma_memcpy_issue_pending() and the
interrupt handler, fsl_dma_chan_do_interrupt(). Both call the
fsl_chan_xfer_ld_queue() function, which does not protect against
concurrent accesses to dma_halt() and dma_start().

The existing spinlock is moved to cover the dma_halt() and dma_start()
functions. Testing shows that the "DMA halt timeout!" errors disappear.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 465846c..8db3ffd 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -841,15 +841,16 @@ static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
 	dma_addr_t next_dest_addr;
 	unsigned long flags;
 
+	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+
 	if (!dma_is_idle(fsl_chan))
-		return;
+		goto out_unlock;
 
 	dma_halt(fsl_chan);
 
 	/* If there are some link descriptors
 	 * not transfered in queue. We need to start it.
 	 */
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
 
 	/* Find the first un-transfer desciptor */
 	for (ld_node = fsl_chan->ld_queue.next;
@@ -860,8 +861,6 @@ static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
 				fsl_chan->common.cookie) == DMA_SUCCESS);
 		ld_node = ld_node->next);
 
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
-
 	if (ld_node != &fsl_chan->ld_queue) {
 		/* Get the ld start address from ld_queue */
 		next_dest_addr = to_fsl_desc(ld_node)->async_tx.phys;
@@ -873,6 +872,9 @@ static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
 		set_cdar(fsl_chan, 0);
 		set_ndar(fsl_chan, 0);
 	}
+
+out_unlock:
+	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
 }
 
 /**
-- 
1.5.4.3
