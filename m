Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHGZ11fxVzF0XJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 17:44:08 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y89so868981pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 22:44:08 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v2 03/16] ASoC: fsl_ssi: Maintain a mask of active streams
Date: Wed, 10 Jan 2018 22:43:02 -0800
Message-Id: <1515652995-15996-4-git-send-email-nicoleotsuka@gmail.com>
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

Checking TE and RE bits in SCR register doesn't work for AC97 mode
which enables SSIEN, TE and RE in the fsl_ssi_setup_ac97() that's
called during probe().

So when running into the trigger(), it will always get the result
of both TE and RE being enabled already, even if actually there is
no active stream.

This patch fixes this issue by adding a variable to log the active
streams manually.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 491b660..aa14a5d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -201,6 +201,7 @@ struct fsl_ssi_soc_data {
  * @cpu_dai_drv: CPU DAI driver for this device
  *
  * @dai_fmt: DAI configuration this device is currently used with
+ * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
@@ -245,6 +246,7 @@ struct fsl_ssi {
 	struct snd_soc_dai_driver cpu_dai_drv;
 
 	unsigned int dai_fmt;
+	u8 streams;
 	u8 i2s_net;
 	bool use_dma;
 	bool use_dual_fifo;
@@ -440,15 +442,14 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			   struct fsl_ssi_regvals *vals)
 {
+	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *avals;
 	int nr_active_streams;
-	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr);
-
-	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
+	nr_active_streams = !!(ssi->streams & BIT(TX)) +
+			    !!(ssi->streams & BIT(RX));
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -470,6 +471,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 					      keep_active);
 		/* Safely disable SCR register for the stream */
 		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
+
+		/* Log the disabled stream to the mask */
+		ssi->streams &= ~BIT(dir);
 	}
 
 	/*
@@ -545,6 +549,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		}
 		/* Enable all remaining bits */
 		regmap_update_bits(regs, REG_SSI_SCR, vals->scr, vals->scr);
+
+		/* Log the enabled stream to the mask */
+		ssi->streams |= BIT(dir);
 	}
 }
 
-- 
2.7.4
