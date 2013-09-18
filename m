Return-Path: <B45939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D685E2C011C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 20:16:24 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <rob.herring@calxeda.com>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <swarren@wwwdotorg.org>, <ian.campbell@citrix.com>, <vinod.koul@intel.com>,
 <djbw@fb.com>
Subject: [PATCH v10 3/3] DMA: Freescale: update driver to support 8-channel
 DMA engine
Date: Wed, 18 Sep 2013 18:15:33 +0800
Message-ID: <1379499333-4745-4-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
References: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
 drivers/dma/Kconfig  |    9 +++++----
 drivers/dma/fsldma.c |    9 ++++++---
 drivers/dma/fsldma.h |    2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6825957..3979c65 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -89,14 +89,15 @@ config AT_HDMAC
 	  Support the Atmel AHB DMA controller.
 
 config FSL_DMA
-	tristate "Freescale Elo and Elo Plus DMA support"
+	tristate "Freescale Elo series DMA support"
 	depends on FSL_SOC
 	select DMA_ENGINE
 	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	---help---
-	  Enable support for the Freescale Elo and Elo Plus DMA controllers.
-	  The Elo is the DMA controller on some 82xx and 83xx parts, and the
-	  Elo Plus is the DMA controller on 85xx and 86xx parts.
+	  Enable support for the Freescale Elo series DMA controllers.
+	  The Elo is the DMA controller on some mpc82xx and mpc83xx parts, the
+	  EloPlus is on mpc85xx and mpc86xx and Pxxx parts, and the Elo3 is on
+	  some Txxx and Bxxx parts.
 
 config MPC512X_DMA
 	tristate "Freescale MPC512x built-in DMA engine support"
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 49e8fbd..16a9a48 100644
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
@@ -1434,6 +1436,7 @@ static int fsldma_of_remove(struct platform_device *op)
 }
 
 static const struct of_device_id fsldma_of_ids[] = {
+	{ .compatible = "fsl,elo3-dma", },
 	{ .compatible = "fsl,eloplus-dma", },
 	{ .compatible = "fsl,elo-dma", },
 	{}
@@ -1455,7 +1458,7 @@ static struct platform_driver fsldma_of_driver = {
 
 static __init int fsldma_init(void)
 {
-	pr_info("Freescale Elo / Elo Plus DMA driver\n");
+	pr_info("Freescale Elo series DMA driver\n");
 	return platform_driver_register(&fsldma_of_driver);
 }
 
@@ -1467,5 +1470,5 @@ static void __exit fsldma_exit(void)
 subsys_initcall(fsldma_init);
 module_exit(fsldma_exit);
 
-MODULE_DESCRIPTION("Freescale Elo / Elo Plus DMA driver");
+MODULE_DESCRIPTION("Freescale Elo series DMA driver");
 MODULE_LICENSE("GPL");
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
