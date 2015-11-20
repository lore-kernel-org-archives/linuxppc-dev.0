Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73B831A0771
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 17:34:21 +1100 (AEDT)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, <timur@tabi.org>,
 <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <shawnguo@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V2 3/3] ASoC: fsl_asrc: spba clock is needed by asrc device
Date: Fri, 20 Nov 2015 14:17:53 +0800
Message-ID: <7b40da78c965d4152c15794ec527c75198c9e2f9.1447997800.git.shengjiu.wang@freescale.com>
In-Reply-To: <cover.1447997800.git.shengjiu.wang@freescale.com>
References: <cover.1447997800.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ASRC need to enable the spba clock, when sdma is using share peripheral
script. In this case, there is two spba master port is used, if don't
enable the clock, the spba bus will have arbitration issue, which may
cause read/write wrong data from/to ASRC registers

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt |  2 ++
 sound/soc/fsl/fsl_asrc.c                             | 10 ++++++++++
 sound/soc/fsl/fsl_asrc.h                             |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index b93362a..d8eeee3 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -25,6 +25,8 @@ Required properties:
 	"mem"		  Peripheral access clock to access registers.
 	"ipg"		  Peripheral clock to driver module.
 	"asrck_<0-f>"	  Clock sources for input and output clock.
+	"spba"		  The spba clock is needed when two spba master port
+			  is used.
 
    - big-endian		: If this property is absent, the little endian mode
 			  will be in use as default. Otherwise, the big endian
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 9f087d4..800828e 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -859,6 +859,10 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return PTR_ERR(asrc_priv->ipg_clk);
 	}
 
+	asrc_priv->spba_clk = devm_clk_get(&pdev->dev, "spba");
+	if (IS_ERR(asrc_priv->spba_clk))
+		dev_warn(&pdev->dev, "failed to get spba clock\n");
+
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		sprintf(tmp, "asrck_%x", i);
 		asrc_priv->asrck_clk[i] = devm_clk_get(&pdev->dev, tmp);
@@ -939,6 +943,9 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 	ret = clk_prepare_enable(asrc_priv->ipg_clk);
 	if (ret)
 		goto disable_mem_clk;
+	ret = clk_prepare_enable(asrc_priv->spba_clk);
+	if (ret)
+		goto disable_ipg_clk;
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		ret = clk_prepare_enable(asrc_priv->asrck_clk[i]);
 		if (ret)
@@ -950,6 +957,8 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 disable_asrck_clk:
 	for (i--; i >= 0; i--)
 		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	clk_disable_unprepare(asrc_priv->spba_clk);
+disable_ipg_clk:
 	clk_disable_unprepare(asrc_priv->ipg_clk);
 disable_mem_clk:
 	clk_disable_unprepare(asrc_priv->mem_clk);
@@ -963,6 +972,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
 		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	clk_disable_unprepare(asrc_priv->spba_clk);
 	clk_disable_unprepare(asrc_priv->ipg_clk);
 	clk_disable_unprepare(asrc_priv->mem_clk);
 
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 4aed63c..889080e 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -442,6 +442,7 @@ struct fsl_asrc {
 	unsigned long paddr;
 	struct clk *mem_clk;
 	struct clk *ipg_clk;
+	struct clk *spba_clk;
 	struct clk *asrck_clk[ASRC_CLK_MAX_NUM];
 	spinlock_t lock;
 
-- 
1.9.1
