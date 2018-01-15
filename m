Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDq5W0fzF0X9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:35 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id j2so7416246pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:35 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 17/17] ASoC: fsl_ssi: Use ssi->streams instead of reading
 register
Date: Sun, 14 Jan 2018 20:21:27 -0800
Message-Id: <1515990087-11598-18-git-send-email-nicoleotsuka@gmail.com>
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

Since ssi->streams is being updated along with SCR register and
its SSIEN bit, it's simpler to use it instead.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d2072de..2768def 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -803,11 +803,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
-	u32 scr;
-	int enabled;
-
-	regmap_read(regs, REG_SSI_SCR, &scr);
-	enabled = scr & SSI_SCR_SSIEN;
 
 	/*
 	 * SSI is properly configured if it is enabled and running in
@@ -815,7 +810,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	 * that should set separate configurations for STCCR and SRCCR
 	 * despite running in the synchronous mode.
 	 */
-	if (enabled && ssi->synchronous)
+	if (ssi->streams && ssi->synchronous)
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
-- 
2.7.4
