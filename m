Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 5E1A3B71AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 09:23:37 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 9/9] fsldma: make halt behave nicely on all supported
	controllers
Date: Wed,  2 Mar 2011 14:23:21 -0800
Message-Id: <1299104601-15447-10-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1299104601-15447-1-git-send-email-iws@ovro.caltech.edu>
References: <1299104601-15447-1-git-send-email-iws@ovro.caltech.edu>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original dma_halt() function set the CA (channel abort) bit on both
the 83xx and 85xx controllers. This is incorrect on the 83xx, where this
bit means TEM (transfer error mask) instead. The 83xx doesn't support
channel abort, so we only do this operation on 85xx.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 40babc1..eb7bc24 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -216,13 +216,26 @@ static void dma_halt(struct fsldma_chan *chan)
 	u32 mode;
 	int i;
 
+	/* read the mode register */
 	mode = DMA_IN(chan, &chan->regs->mr, 32);
-	mode |= FSL_DMA_MR_CA;
-	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 
-	mode &= ~(FSL_DMA_MR_CS | FSL_DMA_MR_EMS_EN | FSL_DMA_MR_CA);
+	/*
+	 * The 85xx controller supports channel abort, which will stop
+	 * the current transfer. On 83xx, this bit is the transfer error
+	 * mask bit, which should not be changed.
+	 */
+	if ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
+		mode |= FSL_DMA_MR_CA;
+		DMA_OUT(chan, &chan->regs->mr, mode, 32);
+
+		mode &= ~FSL_DMA_MR_CA;
+	}
+
+	/* stop the DMA controller */
+	mode &= ~(FSL_DMA_MR_CS | FSL_DMA_MR_EMS_EN);
 	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 
+	/* wait for the DMA controller to become idle */
 	for (i = 0; i < 100; i++) {
 		if (dma_is_idle(chan))
 			return;
-- 
1.7.3.4
