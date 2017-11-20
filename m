Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygk935prvzDrRY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 09:36:39 +1100 (AEDT)
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/2] ASoC: fsl_ssi: AC'97 ops need regmap, clock and cleaning
 up on failure
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
Date: Mon, 20 Nov 2017 23:14:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AC'97 ops (register read / write) need SSI regmap and clock, so they have
to be set after them.

We also need to set these ops back to NULL if we fail the probe.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dad80b4b0cfc..a71bb8391f61 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1460,12 +1460,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 				sizeof(fsl_ssi_ac97_dai));
 
 		fsl_ac97_data = ssi_private;
-
-		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
-		if (ret) {
-			dev_err(&pdev->dev, "could not set AC'97 ops\n");
-			return ret;
-		}
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1576,6 +1570,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (fsl_ssi_is_ac97(ssi_private)) {
+		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			goto error_ac97_ops;
+		}
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
 					      &ssi_private->cpu_dai_drv, 1);
 	if (ret) {
@@ -1659,6 +1661,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
 
 error_asoc_register:
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
+error_ac97_ops:
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
