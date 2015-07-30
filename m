Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D14031A1D7A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 00:36:09 +1000 (AEST)
Message-ID: <55BA364E.1000803@maciej.szmigiero.name>
Date: Thu, 30 Jul 2015 16:35:58 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 6/6] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adjust set DAI format function in fsl_ssi driver so it
doesn't fail and clears RXDIR in AC'97 mode.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8e5ff5e..37aabe3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -900,14 +900,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		return -EINVAL;
+		if (!fsl_ssi_is_ac97(ssi_private))
+			return -EINVAL;
 	}
 
 	stcr |= strcr;
 	srcr |= strcr;
 
-	if (ssi_private->cpu_dai_drv.symmetric_rates) {
-		/* Need to clear RXDIR when using SYNC mode */
+	if (ssi_private->cpu_dai_drv.symmetric_rates
+		|| fsl_ssi_is_ac97(ssi_private)) {
+		/* Need to clear RXDIR when using SYNC or AC97 mode */
 		srcr &= ~CCSR_SSI_SRCR_RXDIR;
 		scr |= CCSR_SSI_SCR_SYN;
 	}
