Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 165861A0223
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 19:33:07 +1000 (EST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s6V9X5iX007287
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 09:33:06 GMT
Date: Thu, 31 Jul 2014 12:32:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Timur Tabi <timur@tabi.org>
Subject: [patch -next] ASoC: fsl_asrc: fix an error code in fsl_asrc_probe()
Message-ID: <20140731093209.GF30276@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a cut and paste bug so it returns success instead of the error
code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index b9a2888..b04438c 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -826,7 +826,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	asrc_priv->mem_clk = devm_clk_get(&pdev->dev, "mem");
 	if (IS_ERR(asrc_priv->mem_clk)) {
 		dev_err(&pdev->dev, "failed to get mem clock\n");
-		return PTR_ERR(asrc_priv->ipg_clk);
+		return PTR_ERR(asrc_priv->mem_clk);
 	}
 
 	asrc_priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
