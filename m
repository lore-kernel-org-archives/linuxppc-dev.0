Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwQb4QdkzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:07:19 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id i130so1395834pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 03:07:19 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-omap@vger.kernel.org
Subject: [PATCH 2/3] ASoC: fsl-asoc-card: Handle return value of devm_kasprintf
Date: Wed, 20 Sep 2017 15:36:10 +0530
Message-Id: <1505901971-12004-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 2db4d0c..86f240b 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -639,6 +639,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 				devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					       "ac97-codec.%u",
 					       (unsigned int)idx);
+		if (!priv->dai_link[0].codec_name)
+			goto asrc_fail;
 	}
 
 	priv->dai_link[0].platform_of_node = cpu_np;
-- 
1.9.1
