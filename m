Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 1F26BB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 07:58:44 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] fsldma: ignore end of segments interrupt
Date: Thu, 26 Jan 2012 12:58:40 -0800
Message-Id: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
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
 drivers/dma/fsldma.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 8a78154..7dc9689 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1052,6 +1052,16 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		stat &= ~FSL_DMA_SR_EOLNI;
 	}
 
+	/*
+	 * This driver does not use this feature, therefore we shouldn't
+	 * ever see this bit set in the status register. However, it has
+	 * been observed on MPC8349EA parts.
+	 */
+	if (stat & FSL_DMA_SR_EOSI) {
+		chan_dbg(chan, "irq: End-of-Segments INT\n");
+		stat &= ~FSL_DMA_SR_EOSI;
+	}
+
 	/* check that the DMA controller is really idle */
 	if (!dma_is_idle(chan))
 		chan_err(chan, "irq: controller not idle!\n");
-- 
1.7.3.4
