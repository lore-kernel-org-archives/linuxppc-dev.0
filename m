Return-Path: <Adam.Thomson.Opensource@diasemi.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8214A1A0144
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 03:31:22 +1000 (AEST)
Message-ID: <9f62b701350bbb1857b56ba22bb832d7550b676e.1441041757.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 31 Aug 2015 18:24:09 +0100
Subject: [PATCH] ASoC: fsl_ssi: Fix checking of dai format for AC97 mode
To: Mark Brown <broonie@kernel.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo
 Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
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

Current code incorrectly treats dai format for AC97 as bit mask
whereas it's actually an integer value. This causes DAI formats
other than AC97 (e.g. DSP_B) to trigger AC97 related code,
which is incorrect and breaks functionality. This patch fixes
the code to correctly compare values to determine AC97 or not.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c0b940e..ee47041 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -249,7 +249,8 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
 
 static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 {
-	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+		SND_SOC_DAIFMT_AC97;
 }
 
 static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
@@ -945,7 +946,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 				CCSR_SSI_SCR_TCH_EN);
 	}
 
-	if (fmt & SND_SOC_DAIFMT_AC97)
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
-- 
1.9.3
