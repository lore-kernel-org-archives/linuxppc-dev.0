Return-Path: <garsilva@embeddedor.com>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.168.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7T0m151zzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 18:06:16 +1000 (AEST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 0B32216CB7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 02:19:26 -0500 (CDT)
Date: Thu, 13 Jul 2017 02:19:25 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: fsl_esai: constify snd_soc_dai_ops structure
Message-ID: <20170713071925.GA32343@embeddedgus>
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
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 809a069..cef79a1 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -620,7 +620,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_esai_dai_ops = {
+static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
 	.startup = fsl_esai_startup,
 	.shutdown = fsl_esai_shutdown,
 	.trigger = fsl_esai_trigger,
-- 
2.5.0
