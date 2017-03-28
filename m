Return-Path: <daniel.baluta@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30089.outbound.protection.outlook.com [40.107.3.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vslFC1GkzzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 19:59:10 +1100 (AEDT)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <nicoleotsuka@gmail.com>, <broonie@kernel.org>,
 <alsa-devel@alsa-project.org>
CC: <timur@tabi.org>, <Xiubo.Lee@gmail.com>, <fabio.estevam@nxp.com>,
 <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk cleanup
Date: Tue, 28 Mar 2017 11:58:52 +0300
Message-ID: <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
In-Reply-To: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resource managed devm_clk_get only works with platform's device dev.

Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/imx-wm8962.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 3d894d9..52659fa 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	codec_clk = devm_clk_get(&codec_dev->dev, NULL);
+	codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(codec_clk)) {
 		ret = PTR_ERR(codec_clk);
 		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
@@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	}
 
 	data->clk_frequency = clk_get_rate(codec_clk);
+	clk_put(codec_clk);
 
 	data->dai.name = "HiFi";
 	data->dai.stream_name = "HiFi";
-- 
2.7.4
