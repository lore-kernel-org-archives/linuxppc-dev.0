Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2C223B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 22:25:29 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [PATCH 3/3] mpc512x_dma: add MPC8308 support
Date: Tue, 28 Sep 2010 14:24:56 +0200
Message-Id: <1285676696-5358-4-git-send-email-yanok@emcraft.com>
In-Reply-To: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8308 has pretty much the same DMA controller as MPC5121 and
this patch adds support for MPC8308 to the mpc512x_dma driver.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
---
 drivers/dma/Kconfig       |    2 +-
 drivers/dma/mpc512x_dma.c |   95 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 9520cf0..5c5e95b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -100,7 +100,7 @@ config FSL_DMA
 
 config MPC512X_DMA
 	tristate "Freescale MPC512x built-in DMA engine support"
-	depends on PPC_MPC512x
+	depends on PPC_MPC512x || PPC_MPC831x
 	select DMA_ENGINE
 	---help---
 	  Enable support for the Freescale MPC512x built-in DMA engine.
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 0717527..97b92ec 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) Freescale Semicondutor, Inc. 2007, 2008.
  * Copyright (C) Semihalf 2009
+ * Copyright (C) Ilya Yanok, Emcraft Systems 2010
  *
  * Written by Piotr Ziecik <kosmo@semihalf.com>. Hardware description
  * (defines, structures and comments) was taken from MPC5121 DMA driver
@@ -70,6 +71,8 @@
 #define MPC_DMA_DMAES_SBE	(1 << 1)
 #define MPC_DMA_DMAES_DBE	(1 << 0)
 
+#define MPC_DMA_DMAGPOR_SNOOP_ENABLE	(1 << 6)
+
 #define MPC_DMA_TSIZE_1		0x00
 #define MPC_DMA_TSIZE_2		0x01
 #define MPC_DMA_TSIZE_4		0x02
@@ -104,7 +107,10 @@ struct __attribute__ ((__packed__)) mpc_dma_regs {
 	/* 0x30 */
 	u32 dmahrsh;		/* DMA hw request status high(ch63~32) */
 	u32 dmahrsl;		/* DMA hardware request status low(ch31~0) */
-	u32 dmaihsa;		/* DMA interrupt high select AXE(ch63~32) */
+	union {
+		u32 dmaihsa;	/* DMA interrupt high select AXE(ch63~32) */
+		u32 dmagpor;	/* (General purpose register on MPC8308) */
+	};
 	u32 dmailsa;		/* DMA interrupt low select AXE(ch31~0) */
 	/* 0x40 ~ 0xff */
 	u32 reserve0[48];	/* Reserved */
@@ -195,7 +201,9 @@ struct mpc_dma {
 	struct mpc_dma_regs __iomem	*regs;
 	struct mpc_dma_tcd __iomem	*tcd;
 	int				irq;
+	int				irq2;
 	uint				error_status;
+	int				is_mpc8308;
 
 	/* Lock for error_status field in this structure */
 	spinlock_t			error_status_lock;
@@ -307,8 +315,10 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
 	spin_unlock(&mdma->error_status_lock);
 
 	/* Handle interrupt on each channel */
-	mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmainth),
+	if (mdma->dma.chancnt > 32) {
+		mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmainth),
 					in_be32(&mdma->regs->dmaerrh), 32);
+	}
 	mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmaintl),
 					in_be32(&mdma->regs->dmaerrl), 0);
 
@@ -562,6 +572,7 @@ static struct dma_async_tx_descriptor *
 mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 					size_t len, unsigned long flags)
 {
+	struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
 	struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
 	struct mpc_dma_desc *mdesc = NULL;
 	struct mpc_dma_tcd *tcd;
@@ -590,7 +601,8 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 		tcd->dsize = MPC_DMA_TSIZE_32;
 		tcd->soff = 32;
 		tcd->doff = 32;
-	} else if (IS_ALIGNED(src | dst | len, 16)) {
+	} else if (!mdma->is_mpc8308 && IS_ALIGNED(src | dst | len, 16)) {
+		/* MPC8308 doesn't support 16 byte transfers */
 		tcd->ssize = MPC_DMA_TSIZE_16;
 		tcd->dsize = MPC_DMA_TSIZE_16;
 		tcd->soff = 16;
@@ -650,6 +662,15 @@ static int __devinit mpc_dma_probe(struct platform_device *op,
 		return -EINVAL;
 	}
 
+	if (of_device_is_compatible(dn, "fsl,mpc8308-dma")) {
+		mdma->is_mpc8308 = 1;
+		mdma->irq2 = irq_of_parse_and_map(dn, 1);
+		if (mdma->irq2 == NO_IRQ) {
+			dev_err(dev, "Error mapping IRQ!\n");
+			return -EINVAL;
+		}
+	}
+
 	retval = of_address_to_resource(dn, 0, &res);
 	if (retval) {
 		dev_err(dev, "Error parsing memory region!\n");
@@ -680,11 +701,23 @@ static int __devinit mpc_dma_probe(struct platform_device *op,
 		return -EINVAL;
 	}
 
+	if (mdma->is_mpc8308) {
+		retval = devm_request_irq(dev, mdma->irq2, &mpc_dma_irq, 0,
+				DRV_NAME, mdma);
+		if (retval) {
+			dev_err(dev, "Error requesting IRQ2!\n");
+			return -EINVAL;
+		}
+	}
+
 	spin_lock_init(&mdma->error_status_lock);
 
 	dma = &mdma->dma;
 	dma->dev = dev;
-	dma->chancnt = MPC_DMA_CHANNELS;
+	if (!mdma->is_mpc8308)
+		dma->chancnt = MPC_DMA_CHANNELS;
+	else
+		dma->chancnt = 16; /* MPC8308 DMA has only 16 channels */
 	dma->device_alloc_chan_resources = mpc_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = mpc_dma_free_chan_resources;
 	dma->device_issue_pending = mpc_dma_issue_pending;
@@ -720,26 +753,40 @@ static int __devinit mpc_dma_probe(struct platform_device *op,
 	 * - Round-robin group arbitration,
 	 * - Round-robin channel arbitration.
 	 */
-	out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_EDCG |
-				MPC_DMA_DMACR_ERGA | MPC_DMA_DMACR_ERCA);
-
-	/* Disable hardware DMA requests */
-	out_be32(&mdma->regs->dmaerqh, 0);
-	out_be32(&mdma->regs->dmaerql, 0);
-
-	/* Disable error interrupts */
-	out_be32(&mdma->regs->dmaeeih, 0);
-	out_be32(&mdma->regs->dmaeeil, 0);
-
-	/* Clear interrupts status */
-	out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
-	out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
-	out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
-	out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
-
-	/* Route interrupts to IPIC */
-	out_be32(&mdma->regs->dmaihsa, 0);
-	out_be32(&mdma->regs->dmailsa, 0);
+	if (!mdma->is_mpc8308) {
+		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_EDCG |
+					MPC_DMA_DMACR_ERGA | MPC_DMA_DMACR_ERCA);
+
+		/* Disable hardware DMA requests */
+		out_be32(&mdma->regs->dmaerqh, 0);
+		out_be32(&mdma->regs->dmaerql, 0);
+
+		/* Disable error interrupts */
+		out_be32(&mdma->regs->dmaeeih, 0);
+		out_be32(&mdma->regs->dmaeeil, 0);
+
+		/* Clear interrupts status */
+		out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
+		out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
+		out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
+		out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
+
+		/* Route interrupts to IPIC */
+		out_be32(&mdma->regs->dmaihsa, 0);
+		out_be32(&mdma->regs->dmailsa, 0);
+	} else {
+		/* MPC8308 has 16 channels and lacks some registers */
+		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_ERCA);
+
+		/* enable snooping */
+		out_be32(&mdma->regs->dmagpor, MPC_DMA_DMAGPOR_SNOOP_ENABLE);
+		/* Disable error interrupts */
+		out_be32(&mdma->regs->dmaeeil, 0);
+
+		/* Clear interrupts status */
+		out_be32(&mdma->regs->dmaintl, 0xFFFF);
+		out_be32(&mdma->regs->dmaerrl, 0xFFFF);
+	}
 
 	/* Register DMA engine */
 	dev_set_drvdata(dev, mdma);
-- 
1.7.2.3
