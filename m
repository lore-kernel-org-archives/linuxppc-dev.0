Return-Path: <guangyu.chen@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe008.messaging.microsoft.com [65.55.88.32])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7AC4314008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 22:38:04 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl_sai: Improve fsl_sai_isr()
Date: Fri, 28 Mar 2014 19:39:25 +0800
Message-ID: <1396006765-4527-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch improves fsl_sai_isr() in these ways:
1, Add comment for mask fetching code.
2, Return IRQ_NONE if the IRQ is not for the device.
3, Use regmap_write() instead of regmap_update_bits().

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 64 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 0bc98bb..f088545 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -30,62 +30,88 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 {
 	struct fsl_sai *sai = (struct fsl_sai *)devid;
 	struct device *dev = &sai->pdev->dev;
-	u32 xcsr, mask;
+	u32 flags, xcsr, mask;
+	bool irq_none = true;
 
-	/* Only handle those what we enabled */
+	/*
+	 * Both IRQ status bits and IRQ mask bits are in the xCSR but
+	 * different shifts. And we here create a mask only for those
+	 * IRQs that we activated.
+	 */
 	mask = (FSL_SAI_FLAGS >> FSL_SAI_CSR_xIE_SHIFT) << FSL_SAI_CSR_xF_SHIFT;
 
 	/* Tx IRQ */
 	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
-	xcsr &= mask;
+	flags = xcsr & mask;
 
-	if (xcsr & FSL_SAI_CSR_WSF)
+	if (flags)
+		irq_none = false;
+	else
+		goto irq_rx;
+
+	if (flags & FSL_SAI_CSR_WSF)
 		dev_dbg(dev, "isr: Start of Tx word detected\n");
 
-	if (xcsr & FSL_SAI_CSR_SEF)
+	if (flags & FSL_SAI_CSR_SEF)
 		dev_warn(dev, "isr: Tx Frame sync error detected\n");
 
-	if (xcsr & FSL_SAI_CSR_FEF) {
+	if (flags & FSL_SAI_CSR_FEF) {
 		dev_warn(dev, "isr: Transmit underrun detected\n");
 		/* FIFO reset for safety */
 		xcsr |= FSL_SAI_CSR_FR;
 	}
 
-	if (xcsr & FSL_SAI_CSR_FWF)
+	if (flags & FSL_SAI_CSR_FWF)
 		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
 
-	if (xcsr & FSL_SAI_CSR_FRF)
+	if (flags & FSL_SAI_CSR_FRF)
 		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
 
-	regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
-			   FSL_SAI_CSR_xF_W_MASK | FSL_SAI_CSR_FR, xcsr);
+	flags &= FSL_SAI_CSR_xF_W_MASK;
+	xcsr &= ~FSL_SAI_CSR_xF_MASK;
+
+	if (flags)
+		regmap_write(sai->regmap, FSL_SAI_TCSR, flags | xcsr);
 
+irq_rx:
 	/* Rx IRQ */
 	regmap_read(sai->regmap, FSL_SAI_RCSR, &xcsr);
-	xcsr &= mask;
+	flags = xcsr & mask;
 
-	if (xcsr & FSL_SAI_CSR_WSF)
+	if (flags)
+		irq_none = false;
+	else
+		goto out;
+
+	if (flags & FSL_SAI_CSR_WSF)
 		dev_dbg(dev, "isr: Start of Rx word detected\n");
 
-	if (xcsr & FSL_SAI_CSR_SEF)
+	if (flags & FSL_SAI_CSR_SEF)
 		dev_warn(dev, "isr: Rx Frame sync error detected\n");
 
-	if (xcsr & FSL_SAI_CSR_FEF) {
+	if (flags & FSL_SAI_CSR_FEF) {
 		dev_warn(dev, "isr: Receive overflow detected\n");
 		/* FIFO reset for safety */
 		xcsr |= FSL_SAI_CSR_FR;
 	}
 
-	if (xcsr & FSL_SAI_CSR_FWF)
+	if (flags & FSL_SAI_CSR_FWF)
 		dev_dbg(dev, "isr: Enabled receive FIFO is full\n");
 
-	if (xcsr & FSL_SAI_CSR_FRF)
+	if (flags & FSL_SAI_CSR_FRF)
 		dev_dbg(dev, "isr: Receive FIFO watermark has been reached\n");
 
-	regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
-			   FSL_SAI_CSR_xF_W_MASK | FSL_SAI_CSR_FR, xcsr);
+	flags &= FSL_SAI_CSR_xF_W_MASK;
+	xcsr &= ~FSL_SAI_CSR_xF_MASK;
 
-	return IRQ_HANDLED;
+	if (flags)
+		regmap_write(sai->regmap, FSL_SAI_TCSR, flags | xcsr);
+
+out:
+	if (irq_none)
+		return IRQ_NONE;
+	else
+		return IRQ_HANDLED;
 }
 
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
-- 
1.8.4
