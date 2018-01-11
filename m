Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHGYz2ZhMzF0XJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 17:44:06 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i66so868465pfd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 22:44:06 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v2 01/16] ASoC: fsl_ssi: Keep ssi->i2s_net updated
Date: Wed, 10 Jan 2018 22:43:00 -0800
Message-Id: <1515652995-15996-2-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hw_params() overwrites i2s_net settings for special cases like
mono-channel support, however, it doesn't update ssi->i2s_net as
set_dai_fmt() does.

This patch removes the local i2s_net variable and directly updates
ssi->i2s_net in the hw_params() so that the driver can simply look
up the ssi->i2s_net instead of reading the register.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index aecd00f..c8bd353 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -834,16 +834,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!fsl_ssi_is_ac97(ssi)) {
-		u8 i2s_net;
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
-		else
-			i2s_net = ssi->i2s_net;
+			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
+
+		/* Use Normal mode to send mono data at 1st slot of 2 slots */
+		if (channels == 1)
+			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_I2S_NET_MASK,
-				   channels == 1 ? 0 : i2s_net);
+				   SSI_SCR_I2S_NET_MASK, ssi->i2s_net);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-- 
2.7.4
