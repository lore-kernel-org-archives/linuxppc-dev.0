Return-Path: <weiyj.lk@gmail.com>
Received: from mail-bk0-x233.google.com (mail-bk0-x233.google.com
 [IPv6:2a00:1450:4008:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCEA42C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 10:00:10 +1000 (EST)
Received: by mail-bk0-f51.google.com with SMTP id mx10so2420795bkb.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 17:00:05 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 Aug 2013 08:00:05 +0800
Message-ID: <CAPgLHd8kBPX2RjLJ3FeXSFpiZjvGyaUM4nmoU0wEVMM7zjfWBA@mail.gmail.com>
Subject: [PATCH -next] ASoC: fsl_spdif: remove redundant dev_err call in
 fsl_spdif_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, yongjun_wei@trendmicro.com.cn,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/fsl_spdif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a9798aa..e93dc0d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1113,10 +1113,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs)) {
-		dev_err(&pdev->dev, "could not map device resources\n");
+	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-	}
 
 	spdif_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
 			"core", regs, &fsl_spdif_regmap_config);
