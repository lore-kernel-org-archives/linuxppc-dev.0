Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D5EE1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 18:07:08 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id pv5so5683925pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 23:07:08 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, tiwai@suse.de,
 perex@perex.cz
Subject: [PATCH] ASoC: fsl-asoc-card: Don't add DAPM routes for ASRC if it
 doesn't exist
Date: Sat, 30 Jan 2016 23:07:00 -0800
Message-Id: <1454224020-19746-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <nicolinc@nvidia.com>

There are a pair of warnings when ASRC is absent in the DTB:
  fsl-asoc-card sound: ASoC: no source widget found for ASRC-Playback
  fsl-asoc-card sound: ASoC: Failed to add route ASRC-Playback -> direct -> CPU-Playback
  fsl-asoc-card sound: ASoC: no sink widget found for ASRC-Capture
  fsl-asoc-card sound: ASoC: Failed to add route CPU-Capture -> direct -> ASRC-Capture

This is because the driver is still trying to add DAPM routes for ASRC
even if it doesn't exist on that platform.

The warnings are harmless but it might be annoying. So this patch drops
the DAPM routes of ASRC when it's absent in the DAI link.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 562b3bd..3d40797 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -99,19 +99,26 @@ struct fsl_asoc_card_priv {
 /**
  * This dapm route map exsits for DPCM link only.
  * The other routes shall go through Device Tree.
+ *
+ * Note: keep all ASRC routes in the second half
+ *	 to drop them easily for non-ASRC cases.
  */
 static const struct snd_soc_dapm_route audio_map[] = {
-	{"CPU-Playback",  NULL, "ASRC-Playback"},
+	/* 1st half -- Normal DAPM routes */
 	{"Playback",  NULL, "CPU-Playback"},
-	{"ASRC-Capture",  NULL, "CPU-Capture"},
 	{"CPU-Capture",  NULL, "Capture"},
+	/* 2nd half -- ASRC DAPM routes */
+	{"CPU-Playback",  NULL, "ASRC-Playback"},
+	{"ASRC-Capture",  NULL, "CPU-Capture"},
 };
 
 static const struct snd_soc_dapm_route audio_map_ac97[] = {
-	{"AC97 Playback",  NULL, "ASRC-Playback"},
+	/* 1st half -- Normal DAPM routes */
 	{"Playback",  NULL, "AC97 Playback"},
-	{"ASRC-Capture",  NULL, "AC97 Capture"},
 	{"AC97 Capture",  NULL, "Capture"},
+	/* 2nd half -- ASRC DAPM routes */
+	{"AC97 Playback",  NULL, "ASRC-Playback"},
+	{"ASRC-Capture",  NULL, "AC97 Capture"},
 };
 
 /* Add all possible widgets into here without being redundant */
@@ -593,6 +600,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
 	priv->card.num_dapm_widgets = ARRAY_SIZE(fsl_asoc_card_dapm_widgets);
 
+	/* Drop the second half of DAPM routes -- ASRC */
+	if (!asrc_pdev)
+		priv->card.num_dapm_routes /= 2;
+
 	memcpy(priv->dai_link, fsl_asoc_card_dai,
 	       sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));
 
-- 
1.9.1
