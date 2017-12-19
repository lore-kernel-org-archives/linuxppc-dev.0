Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1PLp2rwjzDx6D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 04:01:22 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id u25so11368708pfg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:01:22 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
Date: Tue, 19 Dec 2017 09:00:15 -0800
Message-Id: <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AC97 configures some registers earlier to start a communication
with CODECs, so this patch moves those register settings to the
dai_probe() as well, along with other register configurations.

It also applies _fsl_ssi_set_dai_fmt() to AC97 only since other
formats would be configured via fsl_ssi_set_dai_fmt() directly.

Meanwhile, this patch adds fsl_ssi_dai_ac97_remove() to cleanup
some control bits for AC97.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4673709..2fdae78 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -977,9 +977,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
-		fsl_ssi_setup_ac97(ssi);
-
 	return 0;
 }
 
@@ -1108,6 +1105,26 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 		regmap_update_bits(ssi->regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
 
+	/* AC97 should start earlier to communicate with CODECs */
+	if (fsl_ssi_is_ac97(ssi)) {
+		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		fsl_ssi_setup_ac97(ssi);
+	}
+
+	return 0;
+}
+
+/**
+ * Disable register bits for AC97
+ */
+static int fsl_ssi_dai_ac97_remove(struct snd_soc_dai *dai)
+{
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
+
+	regmap_write(ssi->regs, REG_SSI_SCR, 0);
+	regmap_write(ssi->regs, REG_SSI_SACNT, 0);
+	regmap_write(ssi->regs, REG_SSI_SOR, 0);
+
 	return 0;
 }
 
@@ -1147,6 +1164,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.bus_control = true,
 	.probe = fsl_ssi_dai_probe,
+	.remove = fsl_ssi_dai_ac97_remove,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
@@ -1524,9 +1542,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
-	if (ssi->dai_fmt)
-		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
-
 	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
-- 
2.7.4
