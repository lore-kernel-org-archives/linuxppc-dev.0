Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlVhP5Fc3zDrk2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 21:13:09 +1000 (AEST)
From: Lukasz Majewski <lukma@denx.de>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal to
 system freq
Date: Sun,  3 Sep 2017 13:05:01 +0200
Message-Id: <1504436701-20700-1-git-send-email-lukma@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The problem is visible in the following setup (on the imx6q):
"simple-audio-card" -> ssi2 -> I2S + I2C -> codec

The function call log (simple-card probe -> CONFIG_SND_SIMPLE_CARD):

asoc_simple_card_init_dai() @ sound/soc/generic/simple-card-utils.c
snd_soc_dai_set_sysclk()
fsl_ssi_set_dai_sysclk() @ sound/soc/fsl/fsl_ssi.c

The last call is changing the bit clock (BCLK) frequency to SSI's IP
block clock (ipg = 66 MHz) [1].
This is wrong, since IMX SSI block requires the I2S BCLK to be less
than 1/5 of [1].

As a result the driver initialization passes without any errors, but the
speaker-test test case breaks.

This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
not equal to [1].

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 173cb84..1186fa9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -809,6 +809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+	if (clk_get_rate(ssi_private->clk) == freq)
+		return 0;
 
 	ssi_private->bitclk_freq = freq;
 
-- 
2.1.4
