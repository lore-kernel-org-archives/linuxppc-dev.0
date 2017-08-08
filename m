Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWmq1vTvzDqrG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:06:35 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
In-Reply-To: <20170807232919.30247-1-robh@kernel.org>
Message-Id: <E1df2L7-0004yV-QT@finisterre>
Date: Tue, 08 Aug 2017 12:06:21 +0100
Subject: Applied "ASoC: fsl: Convert to using %pOF instead of full_name" to
 the asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl: Convert to using %pOF instead of full_name

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 06d15a2ede999a77f0d05aa600ed473d90d9a909 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Aug 2017 18:29:18 -0500
Subject: [PATCH] ASoC: fsl: Convert to using %pOF instead of full_name

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c    |  4 ++--
 sound/soc/fsl/imx-audmux.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ccadefceeff2..ed8ea002902d 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -897,8 +897,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 
 	ret = of_address_to_resource(ssi_np, 0, &res);
 	if (ret) {
-		dev_err(&pdev->dev, "could not determine resources for %s\n",
-			ssi_np->full_name);
+		dev_err(&pdev->dev, "could not determine resources for %pOF\n",
+			ssi_np);
 		of_node_put(ssi_np);
 		return ret;
 	}
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index fc57da341d61..392d5eef356d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -268,13 +268,13 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 
 		ret = of_property_read_u32(child, "fsl,audmux-port", &port);
 		if (ret) {
-			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%s\"\n",
-					child->full_name);
+			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%pOF\"\n",
+					child);
 			continue;
 		}
 		if (!of_property_read_bool(child, "fsl,port-config")) {
-			dev_warn(&pdev->dev, "child node \"%s\" does not have property fsl,port-config\n",
-					child->full_name);
+			dev_warn(&pdev->dev, "child node \"%pOF\" does not have property fsl,port-config\n",
+					child);
 			continue;
 		}
 
@@ -292,15 +292,15 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 		}
 
 		if (ret != -EOVERFLOW) {
-			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %s\n",
-					i, child->full_name);
+			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %pOF\n",
+					i, child);
 			continue;
 		}
 
 		if (audmux_type == IMX31_AUDMUX) {
 			if (i % 2) {
-				dev_err(&pdev->dev, "One pdcr value is missing in child node %s\n",
-						child->full_name);
+				dev_err(&pdev->dev, "One pdcr value is missing in child node %pOF\n",
+						child);
 				continue;
 			}
 			imx_audmux_v2_configure_port(port, ptcr, pdcr);
-- 
2.13.2
