Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygk975cMFzDrTm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 09:36:43 +1100 (AEDT)
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: fsl_ssi: remove duplicated flag setting in
 fsl_ssi_setup_reg_vals()
Message-ID: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
Date: Mon, 20 Nov 2017 23:12:01 +0100
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

We don't need to set CCSR_SSI_SIER_RFF0_EN / CCSR_SSI_SIER_TFE0_EN bits
in reg->rx.sier / reg->tx.sier variables in a non-AC'97 mode considering we
had just initialized these variables to these very values unconditionally a
few lines earlier.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f2f51e06e22c..48bb850a34d9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -597,9 +597,7 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
 
 	if (!fsl_ssi_is_ac97(ssi_private)) {
 		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
-		reg->rx.sier |= CCSR_SSI_SIER_RFF0_EN;
 		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
-		reg->tx.sier |= CCSR_SSI_SIER_TFE0_EN;
 	}
 
 	if (ssi_private->use_dma) {
