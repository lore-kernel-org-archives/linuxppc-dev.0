Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDX5LkyzF0X9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:20 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id f14so7384609pga.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:20 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 03/17] ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
Date: Sun, 14 Jan 2018 20:21:13 -0800
Message-Id: <1515990087-11598-4-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch replaces the register read with ssi->i2s_net for
simplification. It also removes masking SSIEN from scr value
since it's handled later by regmap_update_bits() to set this
scr value back.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9847a1d..8984ee2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1055,9 +1055,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 	}
 
 	/* The slot number should be >= 2 if using Network mode or I2S mode */
-	regmap_read(regs, REG_SSI_SCR, &val);
-	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
-	if (val && slots < 2) {
+	if (ssi->i2s_net && slots < 2) {
 		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
@@ -1067,9 +1065,8 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 	regmap_update_bits(regs, REG_SSI_SRCCR,
 			   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(slots));
 
-	/* Save SSIEN bit of the SCR register */
+	/* Save the SCR register value */
 	regmap_read(regs, REG_SSI_SCR, &val);
-	val &= SSI_SCR_SSIEN;
 	/* Temporarily enable SSI to allow SxMSKs to be configurable */
 	regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_SSIEN, SSI_SCR_SSIEN);
 
-- 
2.7.4
