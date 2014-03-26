Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D166614008B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 22:47:49 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Wed, 26 Mar 2014 19:48:37 +0800
Message-ID: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's quite cricial to clear error flags because SAI might hang if getting
FIFO underrun during playback (I haven't confirmed the same issue on Rx
overflow though).

So this patch enables those irq and adds isr() to clear the flags so as to
keep playback entirely safe.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h |  9 +++++++
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index c4a4231..5f91aff 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -23,6 +23,55 @@
 
 #include "fsl_sai.h"
 
+#define FSL_SAI_FLAGS (FSL_SAI_CSR_SEIE |\
+		       FSL_SAI_CSR_FEIE |\
+		       FSL_SAI_CSR_FWIE)
+
+static irqreturn_t fsl_sai_isr(int irq, void *devid)
+{
+	struct fsl_sai *sai = (struct fsl_sai *)devid;
+	struct device *dev = &sai->pdev->dev;
+	u32 xcsr;
+
+	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
+	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
+
+	if (xcsr & FSL_SAI_CSR_WSF)
+		dev_dbg(dev, "isr: Start of Tx word detected\n");
+
+	if (xcsr & FSL_SAI_CSR_SEF)
+		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
+
+	if (xcsr & FSL_SAI_CSR_FEF)
+		dev_dbg(dev, "isr: Transmit underrun detected\n");
+
+	if (xcsr & FSL_SAI_CSR_FWF)
+		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
+
+	if (xcsr & FSL_SAI_CSR_FRF)
+		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
+
+	regmap_read(sai->regmap, FSL_SAI_RCSR, &xcsr);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, xcsr);
+
+	if (xcsr & FSL_SAI_CSR_WSF)
+		dev_dbg(dev, "isr: Start of Rx word detected\n");
+
+	if (xcsr & FSL_SAI_CSR_SEF)
+		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
+
+	if (xcsr & FSL_SAI_CSR_FEF)
+		dev_dbg(dev, "isr: Receive overflow detected\n");
+
+	if (xcsr & FSL_SAI_CSR_FWF)
+		dev_dbg(dev, "isr: Enabled receive FIFO is full\n");
+
+	if (xcsr & FSL_SAI_CSR_FRF)
+		dev_dbg(dev, "isr: Receive FIFO watermark has been reached\n");
+
+	return IRQ_HANDLED;
+}
+
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
@@ -373,8 +422,8 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 
-	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, 0x0);
-	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, 0x0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, FSL_SAI_FLAGS);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, FSL_SAI_FLAGS);
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1, FSL_SAI_CR1_RFW_MASK,
 			   FSL_SAI_MAXBURST_TX * 2);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR1, FSL_SAI_CR1_RFW_MASK,
@@ -490,12 +539,14 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	struct fsl_sai *sai;
 	struct resource *res;
 	void __iomem *base;
-	int ret;
+	int irq, ret;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
 		return -ENOMEM;
 
+	sai->pdev = pdev;
+
 	sai->big_endian_regs = of_property_read_bool(np, "big-endian-regs");
 	if (sai->big_endian_regs)
 		fsl_sai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
@@ -514,6 +565,18 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return PTR_ERR(sai->regmap);
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
+		return ret;
+	}
+
 	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR;
 	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR;
 	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index e432260..05d1a1f 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -37,7 +37,15 @@
 
 /* SAI Transmit/Recieve Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
+#define FSL_SAI_CSR_WSF		BIT(20)
+#define FSL_SAI_CSR_SEF		BIT(19)
+#define FSL_SAI_CSR_FEF		BIT(18)
 #define FSL_SAI_CSR_FWF		BIT(17)
+#define FSL_SAI_CSR_FRF		BIT(16)
+#define FSL_SAI_CSR_WSIE	BIT(12)
+#define FSL_SAI_CSR_SEIE	BIT(11)
+#define FSL_SAI_CSR_FEIE	BIT(10)
+#define FSL_SAI_CSR_FWIE	BIT(9)
 #define FSL_SAI_CSR_FRIE	BIT(8)
 #define FSL_SAI_CSR_FRDE	BIT(0)
 
@@ -99,6 +107,7 @@
 #define FSL_SAI_MAXBURST_RX 6
 
 struct fsl_sai {
+	struct platform_device *pdev;
 	struct regmap *regmap;
 
 	bool big_endian_regs;
-- 
1.8.4
