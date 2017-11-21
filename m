Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhMsN4vHBzDrCY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 10:55:20 +1100 (AEDT)
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v2 2/2] ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt() just once
 in AC'97 mode
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <5c2325bd-3e7b-0026-4c1a-65f32737a74a@maciej.szmigiero.name>
Date: Wed, 22 Nov 2017 00:55:14 +0100
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

In AC'97 mode we configure and start SSI RX / TX on probe path via
a call to _fsl_ssi_set_dai_fmt() function.
We don't need to call this function again later and in fact don't want to
do it since this function temporarily sets STCR, SRCR and SCR to some
intermediate values.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: The SACCST setup code was split out into a separate
commit.

 sound/soc/fsl/fsl_ssi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 375aaaf6080d..70df6bf832df 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1116,6 +1116,9 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 
+	if (fsl_ssi_is_ac97(ssi_private))
+		return 0;
+
 	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi_private, fmt);
 }
 
