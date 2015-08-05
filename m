Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 241DB1A1BEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 01:23:04 +1000 (AEST)
Message-ID: <55C22A4D.1080706@maciej.szmigiero.name>
Date: Wed, 05 Aug 2015 17:22:53 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/6][RESEND] ASoC: fsl_ssi: AC'97 DAI driver needs probe method
 too
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AC'97 DAI driver struct need the same probe method as
I2S one to setup DMA params in fsl_ssi driver.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
This is a resend without changes, to keep the whole series
together.

 sound/soc/fsl/fsl_ssi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8185edc..a83b900 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1101,6 +1101,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.bus_control = true,
+	.probe = fsl_ssi_dai_probe,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
