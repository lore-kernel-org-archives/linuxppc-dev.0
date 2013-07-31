Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 605B62C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 21:57:22 +1000 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [PATCH 1/3] ASoC: codec: spdif: Add S20_3LE and S24_LE support for
 dummy codec drivers
Date: Wed, 31 Jul 2013 20:07:05 +0800
Message-ID: <ad8f9d8812c1823ae6f9e4a0d1e6d3c76b26a285.1375271745.git.b42378@freescale.com>
In-Reply-To: <cover.1375271745.git.b42378@freescale.com>
References: <cover.1375271745.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Generally, S/PDIF supports 20bit and optional 24bit samples. Thus add these
two formats for the dummy codec drivers.

If one S/PDIF controller has its own limitation, its CPU DAI driver should
set the supported format by its own circumstance, since the soc-pcm driver
will use the intersection of cpu_dai's formats and codec_dai's formats.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/spdif_receiver.c    |    2 ++
 sound/soc/codecs/spdif_transmitter.c |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
index e9d7881..26d3474 100644
--- a/sound/soc/codecs/spdif_receiver.c
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -25,6 +25,8 @@
 
 #define STUB_RATES	SNDRV_PCM_RATE_8000_192000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
 static struct snd_soc_codec_driver soc_codec_spdif_dir;
diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index 1828049..efc3d88 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -25,8 +25,9 @@
 #define DRV_NAME "spdif-dit"
 
 #define STUB_RATES	SNDRV_PCM_RATE_8000_96000
-#define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
-
+#define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_codec_driver soc_codec_spdif_dit;
 
-- 
1.7.1
