Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ym1nm2w5CzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 09:34:52 +1100 (AEDT)
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 2/2] ASoC: fsl_ssi: add 20-bit sample format for AC'97 and
 use it for capture
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
Date: Mon, 27 Nov 2017 23:34:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
Changes from v1: Adapt format name to changes in the first patch from
this series.

Changes from v2, v3: None.

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
