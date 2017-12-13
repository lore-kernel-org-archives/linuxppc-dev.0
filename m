Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxRlg3wBvzDrZq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:35:43 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id w7so875022pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:35:43 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v2 08/11] ASoC: fsl_ssi: Rename scr_val to scr
Date: Tue, 12 Dec 2017 22:34:31 -0800
Message-Id: <1513146874-25476-9-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify the variable name. This reduces one over-80-character line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 69fa86d..7fcc6bd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -448,12 +448,12 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_reg_val *avals;
 	int nr_active_streams;
-	u32 scr_val;
+	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
+	regmap_read(regs, REG_SSI_SCR, &scr);
 
-	nr_active_streams = !!(scr_val & SSI_SCR_TE) + !!(scr_val & SSI_SCR_RE);
+	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -795,11 +795,11 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
-	u32 scr_val;
+	u32 scr;
 	int enabled;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
-	enabled = scr_val & SSI_SCR_SSIEN;
+	regmap_read(regs, REG_SSI_SCR, &scr);
+	enabled = scr & SSI_SCR_SSIEN;
 
 	/* To support simultaneous TX and RX, bypass it if SSI is enabled */
 	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
-- 
2.7.4
