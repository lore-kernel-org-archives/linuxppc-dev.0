Return-Path: <B45939@freescale.com>
From: <hongbo.zhang@freescale.com>
To: <vinod.koul@intel.com>, <djbw@fb.com>, <leoli@freescale.com>,
 <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V2 2/2] DMA: Freescale: update driver to support 8-channel DMA
 engine
Date: Fri, 5 Jul 2013 14:27:06 +0800
Message-ID: <1373005626-20726-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1373005626-20726-1-git-send-email-hongbo.zhang@freescale.com>
References: <1373005626-20726-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 vakul@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

This patch adds support to 8-channel DMA engine, thus the driver works for both
the new 8-channel and the legacy 4-channel DMA engines.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 drivers/dma/fsldma.c |    5 ++++-
 drivers/dma/fsldma.h |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4fc2980..7732de2 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1261,7 +1261,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	WARN_ON(fdev->feature != chan->feature);
 
 	chan->dev = fdev->dev;
-	chan->id = ((res.start - 0x100) & 0xfff) >> 7;
+	chan->id = (res.start & 0xfff) < 0x300 ?
+		   ((res.start - 0x100) & 0xfff) >> 7 :
+		   ((res.start - 0x200) & 0xfff) >> 7;
 	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "too many channels for device\n");
 		err = -EINVAL;
@@ -1435,6 +1437,7 @@ static int fsldma_of_remove(struct platform_device *op)
 }
 
 static const struct of_device_id fsldma_of_ids[] = {
+	{ .compatible = "fsl,elo3-dma", },
 	{ .compatible = "fsl,eloplus-dma", },
 	{ .compatible = "fsl,elo-dma", },
 	{}
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index f5c3879..1ffc244 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -112,7 +112,7 @@ struct fsldma_chan_regs {
 };
 
 struct fsldma_chan;
-#define FSL_DMA_MAX_CHANS_PER_DEVICE 4
+#define FSL_DMA_MAX_CHANS_PER_DEVICE 8
 
 struct fsldma_device {
 	void __iomem *regs;	/* DGSR register base */
-- 
1.7.9.5
