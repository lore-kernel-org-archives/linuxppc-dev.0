Return-Path: <weiyj.lk@gmail.com>
Received: from mail-bk0-x22f.google.com (mail-bk0-x22f.google.com
 [IPv6:2a00:1450:4008:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8227A2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 01:27:36 +1100 (EST)
Received: by mail-bk0-f47.google.com with SMTP id mx12so1147934bkb.34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jan 2014 06:27:31 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 9 Jan 2014 22:27:31 +0800
Message-ID: <CAPgLHd-wvDcOz1Ne69g3o4b=VS7jaPU5Gu4DBMq_tBCsY0xcew@mail.gmail.com>
Subject: [PATCH -next] ASoC: fsl-ssi: Add missing clk_disable_unprepare() on
 error in fsl_ssi_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.de, grant.likely@linaro.org, robh+dt@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return from
fsl_ssi_probe() in the request irq error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e18b4b3..4c6818d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1464,7 +1464,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
 					ssi_private->irq);
-			goto error_irqmap;
+			goto error_clk;
 		}
 	}
 
