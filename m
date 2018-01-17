Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLyT86MPSzF0f4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 17:52:44 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id j3so11043000pfh.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 22:52:44 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v5 16/17] ASoC: fsl_ssi: Move DT related code to a separate
 probe()
Date: Tue, 16 Jan 2018 22:51:41 -0800
Message-Id: <1516171902-32669-17-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
References: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans up probe() function by moving all Device Tree
related code into a separate function. It allows the probe() to
be Device Tree independent. This will be very useful for future
integration of imx-ssi driver which has similar functionalities
while exists only because it supports non-DT cases.

This patch also moves symmetric_channels of AC97 from the probe
to the structure snd_soc_dai_driver for simplification.

Additionally, since PowerPC and AC97 use the same pdev pointer
to register a platform device, this patch also unifies related
code.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
Changelog
v5
 * Uses NULL as the parent device as CODEC platform device with
   comments for the reason
 * Updated comments of three pointers for the platform_device
v4
 * Made bool synchronous exclusive with AC97 mode in PATCH-16

 sound/soc/fsl/fsl_ssi.c | 219 +++++++++++++++++++++++++++---------------------
 1 file changed, 124 insertions(+), 95 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7ce055c..a8a040d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -239,8 +239,12 @@ struct fsl_ssi_soc_data {
  *
  * @fiq_params: FIQ stream filtering parameters
  *
- * @pdev: Pointer to pdev when using fsl-ssi as sound card (ppc only)
- *        TODO: Should be replaced with simple-sound-card
+ * @card_pdev: Platform_device pointer to register a sound card for PowerPC or
+ *             to register a CODEC platform device for AC97
+ * @card_name: Platform_device name to register a sound card for PowerPC or
+ *             to register a CODEC platform device for AC97
+ * @card_idx: The index of SSI to register a sound card for PowerPC or
+ *            to register a CODEC platform device for AC97
  *
  * @dbg_stats: Debugging statistics
  *
@@ -285,7 +289,9 @@ struct fsl_ssi {
 
 	struct imx_pcm_fiq_params fiq_params;
 
-	struct platform_device *pdev;
+	struct platform_device *card_pdev;
+	char card_name[32];
+	u32 card_idx;
 
 	struct fsl_ssi_dbg dbg_stats;
 
@@ -1134,6 +1140,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.bus_control = true,
+	.symmetric_channels = 1,
 	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "AC97 Playback",
@@ -1291,9 +1298,7 @@ static void make_lowercase(char *s)
 static int fsl_ssi_imx_probe(struct platform_device *pdev,
 			     struct fsl_ssi *ssi, void __iomem *iomem)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	u32 dmas[4];
 	int ret;
 
 	/* Backward compatible for a DT without ipg clock name assigned */
@@ -1327,14 +1332,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	ssi->dma_params_tx.addr = ssi->ssi_phys + REG_SSI_STX0;
 	ssi->dma_params_rx.addr = ssi->ssi_phys + REG_SSI_SRX0;
 
-	/* Set to dual FIFO mode according to the SDMA sciprt */
-	ret = of_property_read_u32_array(np, "dmas", dmas, 4);
-	if (ssi->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL) {
-		ssi->use_dual_fifo = true;
-		/*
-		 * Use even numbers to avoid channel swap due to SDMA
-		 * script design
-		 */
+	/* Use even numbers to avoid channel swap due to SDMA script design */
+	if (ssi->use_dual_fifo) {
 		ssi->dma_params_tx.maxburst &= ~0x1;
 		ssi->dma_params_rx.maxburst &= ~0x1;
 	}
@@ -1375,41 +1374,109 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev, struct fsl_ssi *ssi)
 		clk_disable_unprepare(ssi->clk);
 }
 
-static int fsl_ssi_probe(struct platform_device *pdev)
+static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
 {
-	struct fsl_ssi *ssi;
-	int ret = 0;
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
+	struct device *dev = ssi->dev;
+	struct device_node *np = dev->of_node;
 	const struct of_device_id *of_id;
 	const char *p, *sprop;
 	const uint32_t *iprop;
-	struct resource *res;
-	void __iomem *iomem;
-	char name[64];
-	struct regmap_config regconfig = fsl_ssi_regconfig;
+	u32 dmas[4];
+	int ret;
 
 	of_id = of_match_device(fsl_ssi_ids, dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
-	ssi = devm_kzalloc(dev, sizeof(*ssi), GFP_KERNEL);
-	if (!ssi)
-		return -ENOMEM;
-
 	ssi->soc = of_id->data;
-	ssi->dev = dev;
+
+	ret = of_property_match_string(np, "clock-names", "ipg");
+	/* Get error code if not found */
+	ssi->has_ipg_clk_name = ret >= 0;
 
 	/* Check if being used in AC97 mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
-	if (sprop) {
-		if (!strcmp(sprop, "ac97-slave"))
-			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
+	if (sprop && !strcmp(sprop, "ac97-slave")) {
+		ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
+
+		ret = of_property_read_u32(np, "cell-index", &ssi->card_idx);
+		if (ret) {
+			dev_err(dev, "failed to get SSI index property\n");
+			return -EINVAL;
+		}
+		strcpy(ssi->card_name, "ac97-codec");
+	} else if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
+		/*
+		 * In synchronous mode, STCK and STFS ports are used by RX
+		 * as well. So the software should limit the sample rates,
+		 * sample bits and channels to be symmetric.
+		 *
+		 * This is exclusive with FSLSSI_AC97_FORMATS as AC97 runs
+		 * in the SSI synchronous mode however it does not have to
+		 * limit symmetric sample rates and sample bits.
+		 */
+		ssi->synchronous = true;
 	}
 
 	/* Select DMA or FIQ */
 	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
 
+	/* Fetch FIFO depth; Set to 8 for older DT without this property */
+	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
+	if (iprop)
+		ssi->fifo_depth = be32_to_cpup(iprop);
+	else
+		ssi->fifo_depth = 8;
+
+	/* Use dual FIFO mode depending on the support from SDMA script */
+	ret = of_property_read_u32_array(np, "dmas", dmas, 4);
+	if (ssi->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL)
+		ssi->use_dual_fifo = true;
+
+	/*
+	 * Backward compatible for older bindings by manually triggering the
+	 * machine driver's probe(). Use /compatible property, including the
+	 * address of CPU DAI driver structure, as the name of machine driver
+	 *
+	 * If card_name is set by AC97 earlier, bypass here since it uses a
+	 * different name to register the device.
+	 */
+	if (!ssi->card_name[0] && of_get_property(np, "codec-handle", NULL)) {
+		sprop = of_get_property(of_find_node_by_path("/"),
+					"compatible", NULL);
+		/* Strip "fsl," in the compatible name if applicable */
+		p = strrchr(sprop, ',');
+		if (p)
+			sprop = p + 1;
+		snprintf(ssi->card_name, sizeof(ssi->card_name),
+			 "snd-soc-%s", sprop);
+		make_lowercase(ssi->card_name);
+		ssi->card_idx = 0;
+	}
+
+	return 0;
+}
+
+static int fsl_ssi_probe(struct platform_device *pdev)
+{
+	struct regmap_config regconfig = fsl_ssi_regconfig;
+	struct device *dev = &pdev->dev;
+	struct fsl_ssi *ssi;
+	struct resource *res;
+	void __iomem *iomem;
+	int ret = 0;
+
+	ssi = devm_kzalloc(dev, sizeof(*ssi), GFP_KERNEL);
+	if (!ssi)
+		return -ENOMEM;
+
+	ssi->dev = dev;
+
+	/* Probe from DT */
+	ret = fsl_ssi_probe_from_dt(ssi);
+	if (ret)
+		return ret;
+
 	if (fsl_ssi_is_ac97(ssi)) {
 		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_ac97_dai,
 		       sizeof(fsl_ssi_ac97_dai));
@@ -1433,15 +1500,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			REG_SSI_SRMSK / sizeof(uint32_t) + 1;
 	}
 
-	ret = of_property_match_string(np, "clock-names", "ipg");
-	if (ret < 0) {
-		ssi->has_ipg_clk_name = false;
-		ssi->regs = devm_regmap_init_mmio(dev, iomem, &regconfig);
-	} else {
-		ssi->has_ipg_clk_name = true;
+	if (ssi->has_ipg_clk_name)
 		ssi->regs = devm_regmap_init_mmio_clk(dev, "ipg", iomem,
 						      &regconfig);
-	}
+	else
+		ssi->regs = devm_regmap_init_mmio(dev, iomem, &regconfig);
 	if (IS_ERR(ssi->regs)) {
 		dev_err(dev, "failed to init register map\n");
 		return PTR_ERR(ssi->regs);
@@ -1453,24 +1516,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return ssi->irq;
 	}
 
-	/* Set software limitations for synchronous mode */
-	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
-		if (!fsl_ssi_is_ac97(ssi)) {
-			ssi->cpu_dai_drv.symmetric_rates = 1;
-			ssi->cpu_dai_drv.symmetric_samplebits = 1;
-			ssi->synchronous = true;
-		}
-
+	/* Set software limitations for synchronous mode except AC97 */
+	if (ssi->synchronous && !fsl_ssi_is_ac97(ssi)) {
+		ssi->cpu_dai_drv.symmetric_rates = 1;
 		ssi->cpu_dai_drv.symmetric_channels = 1;
+		ssi->cpu_dai_drv.symmetric_samplebits = 1;
 	}
 
-	/* Fetch FIFO depth; Set to 8 for older DT without this property */
-	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
-	if (iprop)
-		ssi->fifo_depth = be32_to_cpup(iprop);
-	else
-		ssi->fifo_depth = 8;
-
 	/*
 	 * Configure TX and RX DMA watermarks -- when to send a DMA request
 	 *
@@ -1535,50 +1587,27 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_asoc_register;
 
-	/* Bypass it if using newer DT bindings of ASoC machine drivers */
-	if (!of_get_property(np, "codec-handle", NULL))
-		goto done;
-
-	/*
-	 * Backward compatible for older bindings by manually triggering the
-	 * machine driver's probe(). Use /compatible property, including the
-	 * address of CPU DAI driver structure, as the name of machine driver.
-	 */
-	sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);
-	/* Sometimes the compatible name has a "fsl," prefix, so we strip it. */
-	p = strrchr(sprop, ',');
-	if (p)
-		sprop = p + 1;
-	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
-	make_lowercase(name);
-
-	ssi->pdev = platform_device_register_data(dev, name, 0, NULL, 0);
-	if (IS_ERR(ssi->pdev)) {
-		ret = PTR_ERR(ssi->pdev);
-		dev_err(dev, "failed to register platform: %d\n", ret);
-		goto error_sound_card;
-	}
-
-done:
 	/* Initially configures SSI registers */
 	fsl_ssi_hw_init(ssi);
 
-	if (fsl_ssi_is_ac97(ssi)) {
-		u32 ssi_idx;
-
-		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
-		if (ret) {
-			dev_err(dev, "failed to get SSI index property\n");
-			goto error_sound_card;
-		}
-
-		ssi->pdev = platform_device_register_data(NULL, "ac97-codec",
-							  ssi_idx, NULL, 0);
-		if (IS_ERR(ssi->pdev)) {
-			ret = PTR_ERR(ssi->pdev);
-			dev_err(dev,
-				"failed to register AC97 codec platform: %d\n",
-				ret);
+	/* Register a platform device for older bindings or AC97 */
+	if (ssi->card_name[0]) {
+		struct device *parent = dev;
+		/*
+		 * Do not set SSI dev as the parent of AC97 CODEC device since
+		 * it does not have a DT node. Otherwise ASoC core will assume
+		 * CODEC has the same DT node as the SSI, so it may return a
+		 * NULL pointer of CODEC when asked for SSI via the DT node
+		 */
+		if (fsl_ssi_is_ac97(ssi))
+			parent = NULL;
+
+		ssi->card_pdev = platform_device_register_data(parent,
+				ssi->card_name, ssi->card_idx, NULL, 0);
+		if (IS_ERR(ssi->card_pdev)) {
+			ret = PTR_ERR(ssi->card_pdev);
+			dev_err(dev, "failed to register %s: %d\n",
+				ssi->card_name, ret);
 			goto error_sound_card;
 		}
 	}
@@ -1606,8 +1635,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 	fsl_ssi_debugfs_remove(&ssi->dbg_stats);
 
-	if (ssi->pdev)
-		platform_device_unregister(ssi->pdev);
+	if (ssi->card_pdev)
+		platform_device_unregister(ssi->card_pdev);
 
 	/* Clean up SSI registers */
 	fsl_ssi_hw_clean(ssi);
-- 
2.7.4
