Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 6104BB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 08:30:42 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] fsldma: ignore end of segments interrupt
Date: Tue, 31 Jan 2012 13:30:39 -0800
Message-Id: <1328045439-7668-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
Cc: Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc8349ea has been observed to generate spurious end of segments
interrupts despite the fact that they are not enabled by this driver.
Check for them and ignore them to avoid a kernel error message.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Cc: Dan Williams <dan.j.williams@intel.com>
---

Changes v1 -> v2:
- skip the descriptor cleanup tasklet if the controller is not yet idle

 drivers/dma/fsldma.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 8a78154..037631a 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1052,20 +1052,41 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		stat &= ~FSL_DMA_SR_EOLNI;
 	}
 
-	/* check that the DMA controller is really idle */
-	if (!dma_is_idle(chan))
-		chan_err(chan, "irq: controller not idle!\n");
+	/*
+	 * This driver does not use this feature, therefore we shouldn't
+	 * ever see this bit set in the status register. However, it has
+	 * been observed on MPC8349EA parts.
+	 */
+	if (stat & FSL_DMA_SR_EOSI) {
+		chan_dbg(chan, "irq: End-of-Segments INT\n");
+		stat &= ~FSL_DMA_SR_EOSI;
+	}
 
 	/* check that we handled all of the bits */
 	if (stat)
 		chan_err(chan, "irq: unhandled sr 0x%08x\n", stat);
 
 	/*
+	 * Check that the DMA controller is really idle
+	 *
+	 * Occasionally on MPC8349EA parts, a spurious End-of-Segments
+	 * interrupt is generated. When this happens, the controller is
+	 * still busy. In this case, we shouldn't run the tasklet to
+	 * clean up idle descriptors, since the controller is not yet idle.
+	 */
+	if (!dma_is_idle(chan)) {
+		chan_err(chan, "irq: controller not idle!\n");
+		goto out_skip_tasklet;
+	}
+
+	/*
 	 * Schedule the tasklet to handle all cleanup of the current
 	 * transaction. It will start a new transaction if there is
 	 * one pending.
 	 */
 	tasklet_schedule(&chan->tasklet);
+
+out_skip_tasklet:
 	chan_dbg(chan, "irq: Exit\n");
 	return IRQ_HANDLED;
 }
-- 
1.7.3.4
