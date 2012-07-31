Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id BFA6A2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 09:46:01 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 7/7] carma: remove unnecessary DMA_INTERRUPT capability
Date: Tue, 31 Jul 2012 16:45:52 -0700
Message-Id: <1343778352-5549-8-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
References: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
Cc: B32616@freescale.com, linuxppc-dev@lists.ozlabs.org,
 "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

These drivers set the DMA_INTERRUPT capability bit when requesting a DMA
controller channel. This was historical, and is no longer needed.

Recent changes to the drivers/dma/fsldma.c driver have removed support
for this flag. This makes the carma drivers unable to find a DMA channel
with the required capabilities.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/misc/carma/carma-fpga-program.c |    1 -
 drivers/misc/carma/carma-fpga.c         |    3 +--
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/carma/carma-fpga-program.c b/drivers/misc/carma/carma-fpga-program.c
index a2d25e4..eaddfe9 100644
--- a/drivers/misc/carma/carma-fpga-program.c
+++ b/drivers/misc/carma/carma-fpga-program.c
@@ -978,7 +978,6 @@ static int fpga_of_probe(struct platform_device *op)
 	dev_set_drvdata(priv->dev, priv);
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
-	dma_cap_set(DMA_INTERRUPT, mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_SG, mask);
 
diff --git a/drivers/misc/carma/carma-fpga.c b/drivers/misc/carma/carma-fpga.c
index 8c279da..861b298 100644
--- a/drivers/misc/carma/carma-fpga.c
+++ b/drivers/misc/carma/carma-fpga.c
@@ -666,7 +666,7 @@ static int data_submit_dma(struct fpga_device *priv, struct data_buf *buf)
 	src = SYS_FPGA_BLOCK;
 	tx = chan->device->device_prep_dma_memcpy(chan, dst, src,
 						  REG_BLOCK_SIZE,
-						  DMA_PREP_INTERRUPT);
+						  0);
 	if (!tx) {
 		dev_err(priv->dev, "unable to prep SYS-FPGA DMA\n");
 		return -ENOMEM;
@@ -1333,7 +1333,6 @@ static int data_of_probe(struct platform_device *op)
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
-	dma_cap_set(DMA_INTERRUPT, mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_SG, mask);
 
-- 
1.7.8.6
