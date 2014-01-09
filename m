Return-Path: <guangyu.chen@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B34FF2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 20:41:25 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [PATCH] ASoC: fsl_ssi: Set default slot number for common cases
Date: Thu, 9 Jan 2014 17:41:54 +0800
Message-ID: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 lgirdwood@gmail.com, perex@perex.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For those platforms using DAI master mode like I2S, it's better to pre-set
a default slot number so that there's no need for these common cases to set
the slot number from its machine driver any more.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 94dedcb..57ab45b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -711,6 +711,16 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	if (ssi_private->imx_ac97)
 		fsl_ssi_setup_ac97(ssi_private);
 
+	/* Set a default slot number so that there is no need for those common
+	 * cases like I2S mode to call the extra set_tdm_slot() any more.
+	 */
+	if (!ssi_private->imx_ac97) {
+		write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
+				CCSR_SSI_SxCCR_DC(2));
+		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
+				CCSR_SSI_SxCCR_DC(2));
+	}
+
 	return 0;
 }
 
-- 
1.8.4
