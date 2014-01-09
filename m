Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D7B3D2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 21:42:36 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [PATCH v2] ASoC: fsl_ssi: Set default slot number for common cases
Date: Thu, 9 Jan 2014 18:42:48 +0800
Message-ID: <1389264168-13379-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org,
 lgirdwood@gmail.com, perex@perex.cz, festevam@gmail.com
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

Changelog
v2:
 * Correct coding style for multi-line comment.

 sound/soc/fsl/fsl_ssi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 94dedcb..aad2a1f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -711,6 +711,17 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	if (ssi_private->imx_ac97)
 		fsl_ssi_setup_ac97(ssi_private);
 
+	/*
+	 * Set a default slot number so that there is no need for those common
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
