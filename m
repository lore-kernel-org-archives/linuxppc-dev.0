Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C6ECCDDFCC
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 05:26:43 +1000 (EST)
Date: Thu, 28 May 2009 12:26:40 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] fsldma: do not clear bandwidth control bits on the 83xx
	controller
Message-ID: <20090528192640.GC25993@ovro.caltech.edu>
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

The 83xx controller does not support the external pause feature. The bit
in the mode register that controls external pause on the 85xx controller
happens to be part of the bandwidth control settings for the 83xx
controller.

This patch fixes the driver so that it only clears the external pause bit
if the hardware is the 85xx controller. When driving the 83xx controller,
the bit is left untouched. This follows the existing convention that mode
registers settings are not touched unless necessary.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

There is currently no interface to change the bandwidth control setting.
I have changed the bandwidth control setting by requesting exclusive
access to the DMA channel (via dma_request_channel()) then, since I know
the channel is idle, I just add the value I need.

I have tested this using the DMA_SLAVE patch I posted last week, and
verified that the bandwidth control bits do not change on the 83xx
controller.

The conditional could be changed from "== 85XX" to "!= 83XX", as they
are equivalent in the current driver. I'm not sure which is better.

 drivers/dma/fsldma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b2fd35e..a662aac 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -148,10 +148,11 @@ static void dma_start(struct fsl_dma_chan *fsl_chan)
 	if (fsl_chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
 		DMA_OUT(fsl_chan, &fsl_chan->reg_base->bcr, 0, 32);
 		mr_set |= FSL_DMA_MR_EMP_EN;
-	} else
+	} else if ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
 		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
 			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32)
 				& ~FSL_DMA_MR_EMP_EN, 32);
+	}
 
 	if (fsl_chan->feature & FSL_DMA_CHAN_START_EXT)
 		mr_set |= FSL_DMA_MR_EMS_EN;
-- 
1.5.4.3
