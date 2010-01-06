Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A4606B6F17
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:08 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 1/8] fsldma: reduce kernel text size
Date: Wed,  6 Jan 2010 15:33:59 -0800
Message-Id: <1262820846-13198-2-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
References: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
Cc: R58472@freescale.com, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Dipen.Dudhat@freescale.com,
	Maneesh.Gupta@freescale.com, herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the functions are written in a way where they use multiple reads
and writes where a single read/write pair could suffice. This shrinks the
kernel text size measurably, while making the functions easier to
understand.

add/remove: 0/0 grow/shrink: 1/4 up/down: 4/-196 (-192)
function                                     old     new   delta
fsl_chan_set_request_count                   120     124      +4
dma_halt                                     300     272     -28
fsl_chan_set_src_loop_size                   208     156     -52
fsl_chan_set_dest_loop_size                  208     156     -52
fsl_chan_xfer_ld_queue                       500     436     -64

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   83 +++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 296f9e7..0bad741 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -143,43 +143,45 @@ static int dma_is_idle(struct fsl_dma_chan *fsl_chan)
 
 static void dma_start(struct fsl_dma_chan *fsl_chan)
 {
-	u32 mr_set = 0;
-
-	if (fsl_chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->bcr, 0, 32);
-		mr_set |= FSL_DMA_MR_EMP_EN;
-	} else if ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32)
-				& ~FSL_DMA_MR_EMP_EN, 32);
+	u32 mode;
+
+	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+
+	if ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
+		if (fsl_chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
+			DMA_OUT(fsl_chan, &fsl_chan->reg_base->bcr, 0, 32);
+			mode |= FSL_DMA_MR_EMP_EN;
+		} else {
+			mode &= ~FSL_DMA_MR_EMP_EN;
+		}
 	}
 
 	if (fsl_chan->feature & FSL_DMA_CHAN_START_EXT)
-		mr_set |= FSL_DMA_MR_EMS_EN;
+		mode |= FSL_DMA_MR_EMS_EN;
 	else
-		mr_set |= FSL_DMA_MR_CS;
+		mode |= FSL_DMA_MR_CS;
 
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32)
-			| mr_set, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
 }
 
 static void dma_halt(struct fsl_dma_chan *fsl_chan)
 {
+	u32 mode;
 	int i;
 
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-		DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32) | FSL_DMA_MR_CA,
-		32);
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-		DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32) & ~(FSL_DMA_MR_CS
-		| FSL_DMA_MR_EMS_EN | FSL_DMA_MR_CA), 32);
+	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode |= FSL_DMA_MR_CA;
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+
+	mode &= ~(FSL_DMA_MR_CS | FSL_DMA_MR_EMS_EN | FSL_DMA_MR_CA);
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
 
 	for (i = 0; i < 100; i++) {
 		if (dma_is_idle(fsl_chan))
 			break;
 		udelay(10);
 	}
+
 	if (i >= 100 && !dma_is_idle(fsl_chan))
 		dev_err(fsl_chan->dev, "DMA halt timeout!\n");
 }
@@ -231,22 +233,23 @@ static void append_ld_queue(struct fsl_dma_chan *fsl_chan,
  */
 static void fsl_chan_set_src_loop_size(struct fsl_dma_chan *fsl_chan, int size)
 {
+	u32 mode;
+
+	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+
 	switch (size) {
 	case 0:
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32) &
-			(~FSL_DMA_MR_SAHE), 32);
+		mode &= ~FSL_DMA_MR_SAHE;
 		break;
 	case 1:
 	case 2:
 	case 4:
 	case 8:
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32) |
-			FSL_DMA_MR_SAHE | (__ilog2(size) << 14),
-			32);
+		mode |= FSL_DMA_MR_SAHE | (__ilog2(size) << 14);
 		break;
 	}
+
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
 }
 
 /**
@@ -262,22 +265,23 @@ static void fsl_chan_set_src_loop_size(struct fsl_dma_chan *fsl_chan, int size)
  */
 static void fsl_chan_set_dest_loop_size(struct fsl_dma_chan *fsl_chan, int size)
 {
+	u32 mode;
+
+	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+
 	switch (size) {
 	case 0:
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32) &
-			(~FSL_DMA_MR_DAHE), 32);
+		mode &= ~FSL_DMA_MR_DAHE;
 		break;
 	case 1:
 	case 2:
 	case 4:
 	case 8:
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32) |
-			FSL_DMA_MR_DAHE | (__ilog2(size) << 16),
-			32);
+		mode |= FSL_DMA_MR_DAHE | (__ilog2(size) << 16);
 		break;
 	}
+
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
 }
 
 /**
@@ -294,11 +298,14 @@ static void fsl_chan_set_dest_loop_size(struct fsl_dma_chan *fsl_chan, int size)
  */
 static void fsl_chan_set_request_count(struct fsl_dma_chan *fsl_chan, int size)
 {
+	u32 mode;
+
 	BUG_ON(size > 1024);
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-		DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32)
-			| ((__ilog2(size) << 24) & 0x0f000000),
-		32);
+
+	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode |= (__ilog2(size) << 24) & 0x0f000000;
+
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
 }
 
 /**
-- 
1.5.4.3
