Return-Path: <robherring2@gmail.com>
Received: from mail-yb0-f195.google.com (mail-yb0-f195.google.com
 [209.85.213.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDgmn6PvRzDqx5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 05:28:57 +1000 (AEST)
Received: by mail-yb0-f195.google.com with SMTP id z37so1894304ybh.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 12:28:57 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: [PATCH v2] sound: Convert to using %pOF instead of full_name
Date: Fri, 21 Jul 2017 14:28:34 -0500
Message-Id: <20170721192835.25555-3-robh@kernel.org>
In-Reply-To: <20170721192835.25555-1-robh@kernel.org>
References: <20170721192835.25555-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
---
v2:
- Add printf specifier change for fsl_dma.c

 sound/aoa/codecs/tas.c     |  4 ++--
 sound/soc/fsl/fsl_dma.c    |  4 ++--
 sound/soc/fsl/imx-audmux.c | 16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 733b6365dad6..15c05755d270 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -905,8 +905,8 @@ static int tas_i2c_probe(struct i2c_client *client,
 		goto fail;
 	}
 	printk(KERN_DEBUG
-	       "snd-aoa-codec-tas: tas found, addr 0x%02x on %s\n",
-	       (unsigned int)client->addr, node->full_name);
+	       "snd-aoa-codec-tas: tas found, addr 0x%02x on %pOF\n",
+	       (unsigned int)client->addr, node);
 	return 0;
  fail:
 	mutex_destroy(&tas->mtx);
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ccadefceeff2..ed8ea002902d 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -897,8 +897,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 
 	ret = of_address_to_resource(ssi_np, 0, &res);
 	if (ret) {
-		dev_err(&pdev->dev, "could not determine resources for %s\n",
-			ssi_np->full_name);
+		dev_err(&pdev->dev, "could not determine resources for %pOF\n",
+			ssi_np);
 		of_node_put(ssi_np);
 		return ret;
 	}
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index fc57da341d61..392d5eef356d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -268,13 +268,13 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 
 		ret = of_property_read_u32(child, "fsl,audmux-port", &port);
 		if (ret) {
-			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%s\"\n",
-					child->full_name);
+			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%pOF\"\n",
+					child);
 			continue;
 		}
 		if (!of_property_read_bool(child, "fsl,port-config")) {
-			dev_warn(&pdev->dev, "child node \"%s\" does not have property fsl,port-config\n",
-					child->full_name);
+			dev_warn(&pdev->dev, "child node \"%pOF\" does not have property fsl,port-config\n",
+					child);
 			continue;
 		}
 
@@ -292,15 +292,15 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 		}
 
 		if (ret != -EOVERFLOW) {
-			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %s\n",
-					i, child->full_name);
+			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %pOF\n",
+					i, child);
 			continue;
 		}
 
 		if (audmux_type == IMX31_AUDMUX) {
 			if (i % 2) {
-				dev_err(&pdev->dev, "One pdcr value is missing in child node %s\n",
-						child->full_name);
+				dev_err(&pdev->dev, "One pdcr value is missing in child node %pOF\n",
+						child);
 				continue;
 			}
 			imx_audmux_v2_configure_port(port, ptcr, pdcr);
-- 
2.11.0
