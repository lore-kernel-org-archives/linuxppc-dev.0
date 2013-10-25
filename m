Return-Path: <weiyj.lk@gmail.com>
Received: from mail-ee0-x22c.google.com (mail-ee0-x22c.google.com
 [IPv6:2a00:1450:4013:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3899D2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 20:29:31 +1100 (EST)
Received: by mail-ee0-f44.google.com with SMTP id c4so1293670eek.31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 02:29:25 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 25 Oct 2013 17:29:25 +0800
Message-ID: <CAPgLHd-2d+RLDq1U=wXR72nAEH1Hr6FDcWp0eAyEkrNmfjrEaA@mail.gmail.com>
Subject: [PATCH] ASoC: fsl_spdif: fix return value check in fsl_spdif_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com
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

In case of error, the function platform_get_resource() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/fsl_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3920c3e..e5bfafe 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1107,9 +1107,9 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res)) {
+	if (!res) {
 		dev_err(&pdev->dev, "could not determine device resources\n");
-		return PTR_ERR(res);
+		return -ENXIO;
 	}
 
 	regs = devm_ioremap_resource(&pdev->dev, res);
