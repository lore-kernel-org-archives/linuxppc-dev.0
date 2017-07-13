Return-Path: <garsilva@embeddedor.com>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.46])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Rry4pV2zDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:14:26 +1000 (AEST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id BAB9017622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 02:14:23 -0500 (CDT)
Date: Thu, 13 Jul 2017 02:14:21 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Gusatvo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: fsl_spdif: constify snd_soc_dai_ops structure
Message-ID: <20170713071335.GA30695@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 1ff467c..7e6cc4d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -626,7 +626,7 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_spdif_dai_ops = {
+static const struct snd_soc_dai_ops fsl_spdif_dai_ops = {
 	.startup = fsl_spdif_startup,
 	.hw_params = fsl_spdif_hw_params,
 	.trigger = fsl_spdif_trigger,
-- 
2.5.0
