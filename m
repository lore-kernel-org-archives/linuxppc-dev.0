Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0CC71A1FB8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 20:57:51 +1000 (AEST)
Received: by wicmc4 with SMTP id mc4so15679398wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2015 03:57:48 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
Date: Thu, 3 Sep 2015 12:57:47 +0200
From: Luis de Bethencourt <luis@debethencourt.com>
To: linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org,
 Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 06/12] ASoC: fsl-asoc-card: Fix module autoload for OF
 platform driver
Message-ID: <20150903105747.GA16881@goodgumbo.baconseed.org>
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

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index de43887..ca8b469 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -580,6 +580,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, fsl_asoc_card_dt_ids);
 
 static struct platform_driver fsl_asoc_card_driver = {
 	.probe = fsl_asoc_card_probe,
-- 
2.4.6
