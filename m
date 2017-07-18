Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtxG1PjLzDrJF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:45:06 +1000 (AEST)
Received: by mail-pg0-f66.google.com with SMTP id y129so4336079pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:45:06 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: arm@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Qiang Zhao <qiang.zhao@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Subject: [PATCH] soc: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:29 -0500
Message-Id: <20170718214339.7774-49-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Scott Wood <oss@buserror.net>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/soc/fsl/qbman/bman_ccsr.c    | 10 +++++-----
 drivers/soc/fsl/qbman/bman_portal.c  |  8 +++-----
 drivers/soc/fsl/qbman/qman_ccsr.c    | 12 ++++++------
 drivers/soc/fsl/qbman/qman_portal.c  | 11 ++++-------
 drivers/soc/fsl/qe/gpio.c            |  4 ++--
 drivers/soc/mediatek/mtk-pmic-wrap.c |  4 ++--
 drivers/soc/renesas/rcar-rst.c       |  4 ++--
 drivers/soc/renesas/rcar-sysc.c      |  6 +++---
 drivers/soc/samsung/pm_domains.c     |  8 ++++----
 9 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index a8e8389a6894..eaa9585c7347 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -177,8 +177,8 @@ static int fsl_bman_probe(struct platform_device *pdev)

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(dev, "Can't get %s property 'IORESOURCE_MEM'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
+			node);
 		return -ENXIO;
 	}
 	bm_ccsr_start = devm_ioremap(dev, res->start, resource_size(res));
@@ -205,14 +205,14 @@ static int fsl_bman_probe(struct platform_device *pdev)

 	err_irq = platform_get_irq(pdev, 0);
 	if (err_irq <= 0) {
-		dev_info(dev, "Can't get %s IRQ\n", node->full_name);
+		dev_info(dev, "Can't get %pOF IRQ\n", node);
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, err_irq, bman_isr, IRQF_SHARED, "bman-err",
 			       dev);
 	if (ret)  {
-		dev_err(dev, "devm_request_irq() failed %d for '%s'\n",
-			ret, node->full_name);
+		dev_err(dev, "devm_request_irq() failed %d for '%pOF'\n",
+			ret, node);
 		return ret;
 	}
 	/* Disable Buffer Pool State Change */
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 8354d4dabdad..39b39c8f1399 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -103,16 +103,14 @@ static int bman_portal_probe(struct platform_device *pdev)
 	addr_phys[0] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CE);
 	if (!addr_phys[0]) {
-		dev_err(dev, "Can't get %s property 'reg::CE'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
 		return -ENXIO;
 	}

 	addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CI);
 	if (!addr_phys[1]) {
-		dev_err(dev, "Can't get %s property 'reg::CI'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
 		return -ENXIO;
 	}

@@ -120,7 +118,7 @@ static int bman_portal_probe(struct platform_device *pdev)

 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "Can't get %s IRQ'\n", node->full_name);
+		dev_err(dev, "Can't get %pOF IRQ'\n", node);
 		return -ENXIO;
 	}
 	pcfg->irq = irq;
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 90bc40c48675..835ce947ffca 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -695,8 +695,8 @@ static int fsl_qman_probe(struct platform_device *pdev)

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(dev, "Can't get %s property 'IORESOURCE_MEM'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
+			node);
 		return -ENXIO;
 	}
 	qm_ccsr_start = devm_ioremap(dev, res->start, resource_size(res));
@@ -740,15 +740,15 @@ static int fsl_qman_probe(struct platform_device *pdev)

 	err_irq = platform_get_irq(pdev, 0);
 	if (err_irq <= 0) {
-		dev_info(dev, "Can't get %s property 'interrupts'\n",
-			 node->full_name);
+		dev_info(dev, "Can't get %pOF property 'interrupts'\n",
+			 node);
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, err_irq, qman_isr, IRQF_SHARED, "qman-err",
 			       dev);
 	if (ret)  {
-		dev_err(dev, "devm_request_irq() failed %d for '%s'\n",
-			ret, node->full_name);
+		dev_err(dev, "devm_request_irq() failed %d for '%pOF'\n",
+			ret, node);
 		return ret;
 	}

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index adbaa30d3c5a..cbacdf4f98ed 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -237,30 +237,27 @@ static int qman_portal_probe(struct platform_device *pdev)
 	addr_phys[0] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CE);
 	if (!addr_phys[0]) {
-		dev_err(dev, "Can't get %s property 'reg::CE'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
 		return -ENXIO;
 	}

 	addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CI);
 	if (!addr_phys[1]) {
-		dev_err(dev, "Can't get %s property 'reg::CI'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
 		return -ENXIO;
 	}

 	err = of_property_read_u32(node, "cell-index", &val);
 	if (err) {
-		dev_err(dev, "Can't get %s property 'cell-index'\n",
-			node->full_name);
+		dev_err(dev, "Can't get %pOF property 'cell-index'\n", node);
 		return err;
 	}
 	pcfg->channel = val;
 	pcfg->cpu = -1;
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "Can't get %s IRQ\n", node->full_name);
+		dev_err(dev, "Can't get %pOF IRQ\n", node);
 		return -ENXIO;
 	}
 	pcfg->irq = irq;
diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 0aaf429f31d5..3b27075c21a7 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -304,8 +304,8 @@ static int __init qe_add_gpiochips(void)
 			goto err;
 		continue;
 err:
-		pr_err("%s: registration failed with status %d\n",
-		       np->full_name, ret);
+		pr_err("%pOF: registration failed with status %d\n",
+		       np, ret);
 		kfree(qe_gc);
 		/* try others anyway */
 	}
diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index c80a04e1b2b1..af9768db42b4 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1233,8 +1233,8 @@ static int pwrap_probe(struct platform_device *pdev)

 	ret = of_platform_populate(np, NULL, NULL, wrp->dev);
 	if (ret) {
-		dev_dbg(wrp->dev, "failed to create child devices at %s\n",
-				np->full_name);
+		dev_dbg(wrp->dev, "failed to create child devices at %pOF\n",
+				np);
 		goto err_out2;
 	}

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index a6d1c26d3167..78c40d5dd62b 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -61,7 +61,7 @@ static int __init rcar_rst_init(void)

 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_warn("%s: Cannot map regs\n", np->full_name);
+		pr_warn("%pOF: Cannot map regs\n", np);
 		error = -ENOMEM;
 		goto out_put;
 	}
@@ -70,7 +70,7 @@ static int __init rcar_rst_init(void)
 	cfg = match->data;
 	saved_mode = ioread32(base + cfg->modemr);

-	pr_debug("%s: MODE = 0x%08x\n", np->full_name, saved_mode);
+	pr_debug("%pOF: MODE = 0x%08x\n", np, saved_mode);

 out_put:
 	of_node_put(np);
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 7c8da3c90011..cd387347fa94 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -323,7 +323,7 @@ static int __init rcar_sysc_pd_init(void)

 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_warn("%s: Cannot map regs\n", np->full_name);
+		pr_warn("%pOF: Cannot map regs\n", np);
 		error = -ENOMEM;
 		goto out_put;
 	}
@@ -348,13 +348,13 @@ static int __init rcar_sysc_pd_init(void)
 	 */
 	syscimr = ioread32(base + SYSCIMR);
 	syscimr |= syscier;
-	pr_debug("%s: syscimr = 0x%08x\n", np->full_name, syscimr);
+	pr_debug("%pOF: syscimr = 0x%08x\n", np, syscimr);
 	iowrite32(syscimr, base + SYSCIMR);

 	/*
 	 * SYSC needs all interrupt sources enabled to control power.
 	 */
-	pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
+	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
 	iowrite32(syscier, base + SYSCIER);

 	for (i = 0; i < info->num_areas; i++) {
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index a6a5d807cc2b..c630eba32066 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -237,11 +237,11 @@ static __init int exynos4_pm_init_power_domain(void)
 			continue;

 		if (of_genpd_add_subdomain(&parent, &child))
-			pr_warn("%s failed to add subdomain: %s\n",
-				parent.np->full_name, child.np->full_name);
+			pr_warn("%pOF failed to add subdomain: %pOF\n",
+				parent.np, child.np);
 		else
-			pr_info("%s has as child subdomain: %s.\n",
-				parent.np->full_name, child.np->full_name);
+			pr_info("%pOF has as child subdomain: %pOF.\n",
+				parent.np, child.np);
 	}

 	return 0;
--
2.11.0
