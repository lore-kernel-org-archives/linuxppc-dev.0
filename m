Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x231.google.com (mail-la0-x231.google.com
 [IPv6:2a00:1450:4010:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B0742C0172
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 22:09:50 +1100 (EST)
Received: by mail-la0-f49.google.com with SMTP id mc6so1970474lab.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 03:09:45 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v8 1/5] dma: mpc512x: reorder mpc8308 specific instructions
Date: Mon, 24 Feb 2014 15:09:28 +0400
Message-Id: <1393240172-18769-2-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Concentrate the specific code for MPC8308 in the 'if' branch
and handle MPC512x in the 'else' branch.
This modification only reorders instructions but doesn't change behaviour.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
Acked-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/dma/mpc512x_dma.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 448750d..2ce248b 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -52,9 +52,17 @@
 #define MPC_DMA_DESCRIPTORS	64
 
 /* Macro definitions */
-#define MPC_DMA_CHANNELS	64
 #define MPC_DMA_TCD_OFFSET	0x1000
 
+/*
+ * Maximum channel counts for individual hardware variants
+ * and the maximum channel count over all supported controllers,
+ * used for data structure size
+ */
+#define MPC8308_DMACHAN_MAX	16
+#define MPC512x_DMACHAN_MAX	64
+#define MPC_DMA_CHANNELS	64
+
 /* Arbitration mode of group and channel */
 #define MPC_DMA_DMACR_EDCG	(1 << 31)
 #define MPC_DMA_DMACR_ERGA	(1 << 3)
@@ -710,10 +718,10 @@ static int mpc_dma_probe(struct platform_device *op)
 
 	dma = &mdma->dma;
 	dma->dev = dev;
-	if (!mdma->is_mpc8308)
-		dma->chancnt = MPC_DMA_CHANNELS;
+	if (mdma->is_mpc8308)
+		dma->chancnt = MPC8308_DMACHAN_MAX;
 	else
-		dma->chancnt = 16; /* MPC8308 DMA has only 16 channels */
+		dma->chancnt = MPC512x_DMACHAN_MAX;
 	dma->device_alloc_chan_resources = mpc_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = mpc_dma_free_chan_resources;
 	dma->device_issue_pending = mpc_dma_issue_pending;
@@ -747,7 +755,19 @@ static int mpc_dma_probe(struct platform_device *op)
 	 * - Round-robin group arbitration,
 	 * - Round-robin channel arbitration.
 	 */
-	if (!mdma->is_mpc8308) {
+	if (mdma->is_mpc8308) {
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
+	} else {
 		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_EDCG |
 					MPC_DMA_DMACR_ERGA | MPC_DMA_DMACR_ERCA);
 
@@ -768,18 +788,6 @@ static int mpc_dma_probe(struct platform_device *op)
 		/* Route interrupts to IPIC */
 		out_be32(&mdma->regs->dmaihsa, 0);
 		out_be32(&mdma->regs->dmailsa, 0);
-	} else {
-		/* MPC8308 has 16 channels and lacks some registers */
-		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_ERCA);
-
-		/* enable snooping */
-		out_be32(&mdma->regs->dmagpor, MPC_DMA_DMAGPOR_SNOOP_ENABLE);
-		/* Disable error interrupts */
-		out_be32(&mdma->regs->dmaeeil, 0);
-
-		/* Clear interrupts status */
-		out_be32(&mdma->regs->dmaintl, 0xFFFF);
-		out_be32(&mdma->regs->dmaerrl, 0xFFFF);
 	}
 
 	/* Register DMA engine */
-- 
1.8.4.2
