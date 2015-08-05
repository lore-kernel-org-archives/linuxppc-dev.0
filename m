Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2FF01A2A92
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 01:26:55 +1000 (AEST)
Message-ID: <55C22B34.8040301@maciej.szmigiero.name>
Date: Wed, 05 Aug 2015 17:26:44 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 5/6][RESEND] ASoC: fsl_ssi: instantiate AC'97 CODEC
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instantiate AC'97 CODEC in fsl_ssi driver AC'97 mode.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
This is a resend without changes, to keep the whole series
together.

 sound/soc/fsl/fsl_ssi.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 154bcf6..8e5ff5e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1460,6 +1460,27 @@ done:
 		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
 				     ssi_private->dai_fmt);
 
+	if (fsl_ssi_is_ac97(ssi_private)) {
+		u32 ssi_idx;
+
+		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
+		if (ret) {
+			dev_err(&pdev->dev, "cannot get SSI index property\n");
+			goto error_sound_card;
+		}
+
+		ssi_private->pdev =
+			platform_device_register_data(NULL,
+					"ac97-codec", ssi_idx, NULL, 0);
+		if (IS_ERR(ssi_private->pdev)) {
+			ret = PTR_ERR(ssi_private->pdev);
+			dev_err(&pdev->dev,
+				"failed to register AC97 codec platform: %d\n",
+				ret);
+			goto error_sound_card;
+		}
+	}
+
 	return 0;
 
 error_sound_card:
