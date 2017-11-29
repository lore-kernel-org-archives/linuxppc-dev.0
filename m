Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn8xB5fqfzDrnq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 06:00:11 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: add 20-bit sample format for AC'97 and use it
 for capture" to the asoc tree
In-Reply-To: <b05cc20e-90cf-5cc3-c331-1beba28764ca@maciej.szmigiero.name>
Message-Id: <E1eK7aQ-0004hM-AY@debutante>
Date: Wed, 29 Nov 2017 18:59:58 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: add 20-bit sample format for AC'97 and use it for capture

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 10582635dc8f4f99448c5dcddac38cc18a72dfde Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Mon, 27 Nov 2017 23:34:44 +0100
Subject: [PATCH] ASoC: fsl_ssi: add 20-bit sample format for AC'97 and use it
 for capture

When testing AC'97 capture on UDOO board (currently the only user of
fsl_ssi driver in the AC'97 mode) it become obvious that there is a massive
distortion above certain, small input signal.

This problem has been traced to silicon errata ERR003778:
"In AC97, 16-bit mode, received data is shifted by 4-bit locations" that
has "No fix scheduled".
This errata suggests a workaround of doing a 4-bit shift back in SDMA
script for this specific operation mode, however our SDMA scripts are
shared between various SoC peripherals so we can't really modify them.

There is a simple way to avoid this problem, however, that is to disallow
recording in 16-bit mode and only support it in AC'97-native 20-bit mode.
We have to use a 4-byte format for this since SSI FIFOs do not allow 3-byte
accesses (and these aren't supported by imx-sdma driver anyway).
With this change the capture distortion is gone.

We can also add this format as an additional one supported for playback,
using this opportunity to make sure that we use CPU-endian-native formats
in AC'97 mode as we already do in I2S mode.

There is no problem in using different bit widths in playback and capture
in AC'97 mode so allow this, too.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 20ef09e1a395..c350117c8e31 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1278,14 +1278,15 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_S20,
 	},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		/* 16-bit capture is broken (errata ERR003778) */
+		.formats = SNDRV_PCM_FMTBIT_S20,
 	},
 	.ops = &fsl_ssi_dai_ops,
 };
@@ -1557,11 +1558,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
-		if (!fsl_ssi_is_ac97(ssi_private))
+		if (!fsl_ssi_is_ac97(ssi_private)) {
 			ssi_private->cpu_dai_drv.symmetric_rates = 1;
+			ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
+		}
 
 		ssi_private->cpu_dai_drv.symmetric_channels = 1;
-		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
 	}
 
 	/* Determine the FIFO depth. */
-- 
2.15.0
