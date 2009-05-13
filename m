Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7E0ADDFF4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 07:26:24 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: dan.j.williams@intel.com
Subject: [PATCH] fsldma: Fix compile warnings
Date: Wed, 13 May 2009 16:25:57 -0500
Message-Id: <1242249957-10352-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We we build with dma_addr_t as a 64-bit quantity we get:

drivers/dma/fsldma.c: In function 'fsl_chan_xfer_ld_queue':
drivers/dma/fsldma.c:625: warning: cast to pointer from integer of different size
drivers/dma/fsldma.c: In function 'fsl_dma_chan_do_interrupt':
drivers/dma/fsldma.c:737: warning: cast to pointer from integer of different size
drivers/dma/fsldma.c:737: warning: cast to pointer from integer of different size
drivers/dma/fsldma.c: In function 'of_fsl_dma_probe':
drivers/dma/fsldma.c:927: warning: cast to pointer from integer of different

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/dma/fsldma.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index da8a8ed..66a7687 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -622,8 +622,8 @@ static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
 	if (ld_node != &fsl_chan->ld_queue) {
 		/* Get the ld start address from ld_queue */
 		next_dest_addr = to_fsl_desc(ld_node)->async_tx.phys;
-		dev_dbg(fsl_chan->dev, "xfer LDs staring from %p\n",
-				(void *)next_dest_addr);
+		dev_dbg(fsl_chan->dev, "xfer LDs staring from 0x%llx\n",
+				(unsigned long long)next_dest_addr);
 		set_cdar(fsl_chan, next_dest_addr);
 		dma_start(fsl_chan);
 	} else {
@@ -734,8 +734,9 @@ static irqreturn_t fsl_dma_chan_do_interrupt(int irq, void *data)
 	 */
 	if (stat & FSL_DMA_SR_EOSI) {
 		dev_dbg(fsl_chan->dev, "event: End-of-segments INT\n");
-		dev_dbg(fsl_chan->dev, "event: clndar %p, nlndar %p\n",
-			(void *)get_cdar(fsl_chan), (void *)get_ndar(fsl_chan));
+		dev_dbg(fsl_chan->dev, "event: clndar 0x%llx, nlndar 0x%llx\n",
+			(unsigned long long)get_cdar(fsl_chan),
+			(unsigned long long)get_ndar(fsl_chan));
 		stat &= ~FSL_DMA_SR_EOSI;
 		update_cookie = 1;
 	}
@@ -925,8 +926,8 @@ static int __devinit of_fsl_dma_probe(struct of_device *dev,
 	}
 
 	dev_info(&dev->dev, "Probe the Freescale DMA driver for %s "
-			"controller at %p...\n",
-			match->compatible, (void *)fdev->reg.start);
+			"controller at 0x%llx...\n",
+			match->compatible, (unsigned long long)fdev->reg.start);
 	fdev->reg_base = ioremap(fdev->reg.start, fdev->reg.end
 						- fdev->reg.start + 1);
 
-- 
1.6.0.6
