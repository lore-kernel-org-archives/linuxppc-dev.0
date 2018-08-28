Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zsK65n0PzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:55:22 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so1699745oie.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:55:22 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Olivier Moysan <olivier.moysan@st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:52 -0500
Message-Id: <20180828015252.28511-51-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/fsl/fsl_esai.c      | 2 +-
 sound/soc/fsl/fsl_utils.c     | 4 ++--
 sound/soc/meson/axg-card.c    | 2 +-
 sound/soc/stm/stm32_sai.c     | 2 +-
 sound/soc/stm/stm32_sai_sub.c | 8 ++++----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c1d1d06783e5..57b484768a58 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -807,7 +807,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	esai_priv->pdev = pdev;
-	strncpy(esai_priv->name, np->name, sizeof(esai_priv->name) - 1);
+	snprintf(esai_priv->name, sizeof(esai_priv->name), "%pOFn", np);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 7f0fa4b52223..9981668ab590 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -57,8 +57,8 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 		of_node_put(dma_channel_np);
 		return ret;
 	}
-	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
-		 (unsigned long long) res.start, dma_channel_np->name);
+	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
+		 (unsigned long long) res.start, dma_channel_np);
 
 	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
 	if (!iprop) {
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 2914ba0d965b..b76a5f4f1785 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -478,7 +478,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 
 	ret = axg_card_set_link_name(card, link, "be");
 	if (ret)
-		dev_err(card->dev, "error setting %s link name\n", np->name);
+		dev_err(card->dev, "error setting %pOFn link name\n", np);
 
 	return ret;
 }
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index f22654253c43..d597eba61992 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -104,7 +104,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
-			"Device not found for node %s\n", np_provider->name);
+			"Device not found for node %pOFn\n", np_provider);
 		return -ENODEV;
 	}
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 06fba9650ac4..cad8c7888292 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1124,16 +1124,16 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	sai->sync = SAI_SYNC_NONE;
 	if (args.np) {
 		if (args.np == np) {
-			dev_err(&pdev->dev, "%s sync own reference\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn sync own reference\n",
+				np);
 			of_node_put(args.np);
 			return -EINVAL;
 		}
 
 		sai->np_sync_provider  = of_get_parent(args.np);
 		if (!sai->np_sync_provider) {
-			dev_err(&pdev->dev, "%s parent node not found\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn parent node not found\n",
+				np);
 			of_node_put(args.np);
 			return -ENODEV;
 		}
-- 
2.17.1
