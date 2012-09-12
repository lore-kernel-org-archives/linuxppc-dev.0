Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B54042C0102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 12:25:30 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/5] ASoC: fsl: mpc5200 multi-codec fixups
Date: Tue, 11 Sep 2012 22:14:45 -0400
Message-Id: <1347416089-23393-2-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add platform DAI information that is needed to successfully register the
mpc5200 platform.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 arch/powerpc/platforms/52xx/Kconfig |    1 +
 sound/soc/fsl/mpc5200_dma.c         |    4 ++--
 sound/soc/fsl/mpc5200_psc_ac97.c    |    8 ++++++--
 sound/soc/fsl/mpc5200_psc_i2s.c     |    3 +++
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 90f4496..fb35944 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,6 +1,7 @@
 config PPC_MPC52xx
 	bool "52xx-based boards"
 	depends on 6xx
+	select FSL_SOC
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 9a3f7c5..46fb518 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -366,8 +366,8 @@ static void psc_dma_free(struct snd_pcm *pcm)
 
 static struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
 	.ops		= &psc_dma_ops,
-	.pcm_new	= &psc_dma_new,
-	.pcm_free	= &psc_dma_free,
+	.pcm_new	= psc_dma_new,
+	.pcm_free	= psc_dma_free,
 };
 
 static int mpc5200_hpcd_probe(struct platform_device *op)
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index ffa00a2..2f70729 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -28,7 +28,7 @@
 
 #define DRV_NAME "mpc5200-psc-ac97"
 
-/* ALSA only supports a single AC97 device so static is recommend here */
+/* ALSA only supports a single AC97 bus device so static is recommend here */
 static struct psc_dma *psc_dma;
 
 static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
@@ -237,15 +237,18 @@ static const struct snd_soc_dai_ops psc_ac97_digital_ops = {
 
 static struct snd_soc_dai_driver psc_ac97_dai[] = {
 {
+	.name = "mpc5200_psc_ac97.0",
 	.ac97_control = 1,
 	.probe	= psc_ac97_probe,
 	.playback = {
+		.stream_name	= "AC97 Playback",
 		.channels_min   = 1,
 		.channels_max   = 6,
 		.rates          = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S32_BE,
 	},
 	.capture = {
+		.stream_name	= "AC97 Capture",
 		.channels_min   = 1,
 		.channels_max   = 2,
 		.rates          = SNDRV_PCM_RATE_8000_48000,
@@ -254,8 +257,10 @@ static struct snd_soc_dai_driver psc_ac97_dai[] = {
 	.ops = &psc_ac97_analog_ops,
 },
 {
+	.name = "mpc5200_psc_ac97.1",
 	.ac97_control = 1,
 	.playback = {
+		.stream_name	= "AC97 SPDIF",
 		.channels_min   = 1,
 		.channels_max   = 2,
 		.rates          = SNDRV_PCM_RATE_32000 | \
@@ -330,4 +335,3 @@ module_platform_driver(psc_ac97_driver);
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_DESCRIPTION("mpc5200 AC97 module");
 MODULE_LICENSE("GPL");
-
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 7b53032..3cf21df 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -130,13 +130,16 @@ static const struct snd_soc_dai_ops psc_i2s_dai_ops = {
 };
 
 static struct snd_soc_dai_driver psc_i2s_dai[] = {{
+	.name = "mpc5200_psc_i2s.0",
 	.playback = {
+		.stream_name = "I2S Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = PSC_I2S_RATES,
 		.formats = PSC_I2S_FORMATS,
 	},
 	.capture = {
+		.stream_name = "I2S Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = PSC_I2S_RATES,
-- 
1.7.2.5
