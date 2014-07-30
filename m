Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9182D1A0213
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 13:08:19 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: fsl_sai: Add stream names for DPCM usage
Date: Wed, 30 Jul 2014 11:10:27 +0800
Message-ID: <da605dc6ca36c124a24c12d2dbc0bfa1a4837037.1406688049.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1406688048.git.nicoleotsuka@gmail.com>
References: <cover.1406688048.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 timur@tabi.org, Li.Xiubo@freescale.com, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DPCM needs extra dapm routes in the machine driver to route audio
between Front-End and Back-End. In order to differ the stream names
in the route map from CODECs, we here add specific stream names to
SAI driver so that we can implement ASRC via DPCM to it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 364410b..faa0497 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -455,12 +455,14 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 static struct snd_soc_dai_driver fsl_sai_dai = {
 	.probe = fsl_sai_dai_probe,
 	.playback = {
+		.stream_name = "CPU-Playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = FSL_SAI_FORMATS,
 	},
 	.capture = {
+		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
-- 
1.8.4
