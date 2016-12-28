Return-Path: <sharvari.harisangam@visteon.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0139.outbound.protection.outlook.com [104.47.2.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tpVL30RcwzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2016 22:06:49 +1100 (AEDT)
From: "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "Xiubo
 Li" <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.de>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH]  ASoC : fsl_ssi : Correct the condition to check AC97 mode
Date: Wed, 28 Dec 2016 11:06:44 +0000
Message-ID: <20161228110636.GA14768@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Corrected the condition to check if ssi is configured for AC97
 mode. Other modes like dsp_a also satisfy the ANDing condition.

Signed-off-by: Sharvari Harisangam <sharvari.harisangam@visteon.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ca6f6b1..4fbb7a2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -317,7 +317,8 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
=20
 static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 {
-	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
+	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) =3D=3D
+		SND_SOC_DAIFMT_AC97;
 }
=20
 static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
@@ -1016,7 +1017,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 				CCSR_SSI_SCR_TCH_EN);
 	}
=20
-	if (fmt & SND_SOC_DAIFMT_AC97)
+	if ((fmt & SND_SOC_DAIFMT_AC97) =3D=3D SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
=20
 	return 0;
--=20
2.7.4
