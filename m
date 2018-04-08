Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x232.google.com (mail-pl0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Jgjz1P6CzDr3C
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Apr 2018 14:41:10 +1000 (AEST)
Received: by mail-pl0-x232.google.com with SMTP id s10-v6so3102557plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Apr 2018 21:41:10 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	mika.penttila@nextfour.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org
Subject: [PATCH] ASoC: fsl_ssi: Fix mode setting when changing channel number
Date: Sat,  7 Apr 2018 21:40:21 -0700
Message-Id: <1523162421-26400-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a partial revert (in a cleaner way) of commit ebf08ae3bc90
("ASoC: fsl_ssi: Keep ssi->i2s_net updated") to fix a regression
at test cases when switching between mono and stereo audio.

The problem is that ssi->i2s_net is initialized in set_dai_fmt()
only, while this set_dai_fmt() is only called during the dai-link
probe(). The original patch assumed set_dai_fmt() would be called
during every playback instance, so it failed at the overriding use
cases.

This patch adds the local variable i2s_net back to let regular use
cases still follow the mode settings from the set_dai_fmt().

Meanwhile, the original commit of keeping ssi->i2s_net updated was
to make set_tdm_slot() clean by checking the ssi->i2s_net directly
instead of reading SCR register. However, the change itself is not
necessary (or even harmful) because the set_tdm_slot() might fail
to check the slot number for Normal-Mode-None-Net settings while
mono audio cases still need 2 slots. So this patch can also fix it.
And it adds an extra line of comments to declare ssi->i2s_net does
not reflect the register value but merely the initial setting from
the set_dai_fmt().

Reported-by: Mika Penttilä <mika.penttila@nextfour.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
---
 sound/soc/fsl/fsl_ssi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0823b08..89df2d9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -217,6 +217,7 @@ struct fsl_ssi_soc_data {
  * @dai_fmt: DAI configuration this device is currently used with
  * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
+ *           (this is the initial settings based on the DAI format)
  * @synchronous: Use synchronous mode - both of TX and RX use STCK and SFCK
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
@@ -829,16 +830,23 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!fsl_ssi_is_ac97(ssi)) {
+		/*
+		 * Keep the ssi->i2s_net intact while having a local variable
+		 * to override settings for special use cases. Otherwise, the
+		 * ssi->i2s_net will lose the settings for regular use cases.
+		 */
+		u8 i2s_net = ssi->i2s_net;
+
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
+			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
 
 		/* Use Normal mode to send mono data at 1st slot of 2 slots */
 		if (channels == 1)
-			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL;
+			i2s_net = SSI_SCR_I2S_MODE_NORMAL;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_I2S_NET_MASK, ssi->i2s_net);
+				   SSI_SCR_I2S_NET_MASK, i2s_net);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-- 
2.7.4
