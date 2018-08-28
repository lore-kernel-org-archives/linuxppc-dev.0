Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zsJy0dM1zDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:55:13 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so47224ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:55:13 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org
Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:44 -0500
Message-Id: <20180828015252.28511-43-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/dove/pmu.c            |  8 +++---
 drivers/soc/fsl/qe/qe_tdm.c       |  4 +--
 drivers/soc/qcom/apr.c            |  2 +-
 drivers/soc/rockchip/pm_domains.c | 44 +++++++++++++++----------------
 drivers/soc/tegra/pmc.c           | 12 ++++-----
 drivers/soc/ti/knav_dma.c         |  8 +++---
 drivers/soc/ti/knav_qmss_queue.c  |  8 +++---
 7 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 5abb08ffb74d..ffc5311c0ed8 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -383,7 +383,7 @@ int __init dove_init_pmu(void)
 
 	domains_node = of_get_child_by_name(np_pmu, "domains");
 	if (!domains_node) {
-		pr_err("%s: failed to find domains sub-node\n", np_pmu->name);
+		pr_err("%pOFn: failed to find domains sub-node\n", np_pmu);
 		return 0;
 	}
 
@@ -396,7 +396,7 @@ int __init dove_init_pmu(void)
 	pmu->pmc_base = of_iomap(pmu->of_node, 0);
 	pmu->pmu_base = of_iomap(pmu->of_node, 1);
 	if (!pmu->pmc_base || !pmu->pmu_base) {
-		pr_err("%s: failed to map PMU\n", np_pmu->name);
+		pr_err("%pOFn: failed to map PMU\n", np_pmu);
 		iounmap(pmu->pmu_base);
 		iounmap(pmu->pmc_base);
 		kfree(pmu);
@@ -414,7 +414,7 @@ int __init dove_init_pmu(void)
 			break;
 
 		domain->pmu = pmu;
-		domain->base.name = kstrdup(np->name, GFP_KERNEL);
+		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
 		if (!domain->base.name) {
 			kfree(domain);
 			break;
@@ -444,7 +444,7 @@ int __init dove_init_pmu(void)
 	/* Loss of the interrupt controller is not a fatal error. */
 	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
 	if (!parent_irq) {
-		pr_err("%s: no interrupt specified\n", np_pmu->name);
+		pr_err("%pOFn: no interrupt specified\n", np_pmu);
 	} else {
 		ret = dove_init_pmu_irq(pmu, parent_irq);
 		if (ret)
diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f744c214f680..f78c34647ca2 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -131,7 +131,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 
 	pdev = of_find_device_by_node(np2);
 	if (!pdev) {
-		pr_err("%s: failed to lookup pdev\n", np2->name);
+		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
 		return -EINVAL;
 	}
@@ -153,7 +153,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	pdev = of_find_device_by_node(np2);
 	if (!pdev) {
 		ret = -EINVAL;
-		pr_err("%s: failed to lookup pdev\n", np2->name);
+		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
 		goto err_miss_siram_property;
 	}
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 57af8a537332..4bda793ba6ae 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -219,7 +219,7 @@ static int apr_add_device(struct device *dev, struct device_node *np,
 	adev->domain_id = id->domain_id;
 	adev->version = id->svc_version;
 	if (np)
-		strncpy(adev->name, np->name, APR_NAME_SIZE);
+		snprintf(adev->name, APR_NAME_SIZE, "%pOFn", np);
 	else
 		strncpy(adev->name, id->name, APR_NAME_SIZE);
 
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 6dff8682155f..6f86a726bb45 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -392,21 +392,21 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	error = of_property_read_u32(node, "reg", &id);
 	if (error) {
 		dev_err(pmu->dev,
-			"%s: failed to retrieve domain id (reg): %d\n",
-			node->name, error);
+			"%pOFn: failed to retrieve domain id (reg): %d\n",
+			node, error);
 		return -EINVAL;
 	}
 
 	if (id >= pmu->info->num_domains) {
-		dev_err(pmu->dev, "%s: invalid domain id %d\n",
-			node->name, id);
+		dev_err(pmu->dev, "%pOFn: invalid domain id %d\n",
+			node, id);
 		return -EINVAL;
 	}
 
 	pd_info = &pmu->info->domain_info[id];
 	if (!pd_info) {
-		dev_err(pmu->dev, "%s: undefined domain id %d\n",
-			node->name, id);
+		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
+			node, id);
 		return -EINVAL;
 	}
 
@@ -424,8 +424,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		if (!pd->clks)
 			return -ENOMEM;
 	} else {
-		dev_dbg(pmu->dev, "%s: doesn't have clocks: %d\n",
-			node->name, pd->num_clks);
+		dev_dbg(pmu->dev, "%pOFn: doesn't have clocks: %d\n",
+			node, pd->num_clks);
 		pd->num_clks = 0;
 	}
 
@@ -434,8 +434,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		if (IS_ERR(pd->clks[i].clk)) {
 			error = PTR_ERR(pd->clks[i].clk);
 			dev_err(pmu->dev,
-				"%s: failed to get clk at index %d: %d\n",
-				node->name, i, error);
+				"%pOFn: failed to get clk at index %d: %d\n",
+				node, i, error);
 			return error;
 		}
 	}
@@ -486,8 +486,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	error = rockchip_pd_power(pd, true);
 	if (error) {
 		dev_err(pmu->dev,
-			"failed to power on domain '%s': %d\n",
-			node->name, error);
+			"failed to power on domain '%pOFn': %d\n",
+			node, error);
 		goto err_unprepare_clocks;
 	}
 
@@ -575,24 +575,24 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 		error = of_property_read_u32(parent, "reg", &idx);
 		if (error) {
 			dev_err(pmu->dev,
-				"%s: failed to retrieve domain id (reg): %d\n",
-				parent->name, error);
+				"%pOFn: failed to retrieve domain id (reg): %d\n",
+				parent, error);
 			goto err_out;
 		}
 		parent_domain = pmu->genpd_data.domains[idx];
 
 		error = rockchip_pm_add_one_domain(pmu, np);
 		if (error) {
-			dev_err(pmu->dev, "failed to handle node %s: %d\n",
-				np->name, error);
+			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
+				np, error);
 			goto err_out;
 		}
 
 		error = of_property_read_u32(np, "reg", &idx);
 		if (error) {
 			dev_err(pmu->dev,
-				"%s: failed to retrieve domain id (reg): %d\n",
-				np->name, error);
+				"%pOFn: failed to retrieve domain id (reg): %d\n",
+				np, error);
 			goto err_out;
 		}
 		child_domain = pmu->genpd_data.domains[idx];
@@ -683,16 +683,16 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
-			dev_err(dev, "failed to handle node %s: %d\n",
-				node->name, error);
+			dev_err(dev, "failed to handle node %pOFn: %d\n",
+				node, error);
 			of_node_put(node);
 			goto err_out;
 		}
 
 		error = rockchip_pm_add_subdomain(pmu, node);
 		if (error < 0) {
-			dev_err(dev, "failed to handle subdomain node %s: %d\n",
-				node->name, error);
+			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
+				node, error);
 			of_node_put(node);
 			goto err_out;
 		}
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2d6f3fcf3211..acbe63e925d5 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -796,7 +796,7 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	id = tegra_powergate_lookup(pmc, np->name);
 	if (id < 0) {
-		pr_err("powergate lookup failed for %s: %d\n", np->name, id);
+		pr_err("powergate lookup failed for %pOFn: %d\n", np, id);
 		goto free_mem;
 	}
 
@@ -816,13 +816,13 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	err = tegra_powergate_of_get_clks(pg, np);
 	if (err < 0) {
-		pr_err("failed to get clocks for %s: %d\n", np->name, err);
+		pr_err("failed to get clocks for %pOFn: %d\n", np, err);
 		goto set_available;
 	}
 
 	err = tegra_powergate_of_get_resets(pg, np, off);
 	if (err < 0) {
-		pr_err("failed to get resets for %s: %d\n", np->name, err);
+		pr_err("failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
@@ -851,15 +851,15 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	err = pm_genpd_init(&pg->genpd, NULL, off);
 	if (err < 0) {
-		pr_err("failed to initialise PM domain %s: %d\n", np->name,
+		pr_err("failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
 		goto remove_resets;
 	}
 
 	err = of_genpd_add_provider_simple(np, &pg->genpd);
 	if (err < 0) {
-		pr_err("failed to add PM domain provider for %s: %d\n",
-		       np->name, err);
+		pr_err("failed to add PM domain provider for %pOFn: %d\n",
+		       np, err);
 		goto remove_genpd;
 	}
 
diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 224d7ddeeb76..bbd4e5bc8707 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -544,15 +544,15 @@ static void __iomem *pktdma_get_regs(struct knav_dma_device *dma,
 
 	ret = of_address_to_resource(node, index, &res);
 	if (ret) {
-		dev_err(dev, "Can't translate of node(%s) address for index(%d)\n",
-			node->name, index);
+		dev_err(dev, "Can't translate of node(%pOFn) address for index(%d)\n",
+			node, index);
 		return ERR_PTR(ret);
 	}
 
 	regs = devm_ioremap_resource(kdev->dev, &res);
 	if (IS_ERR(regs))
-		dev_err(dev, "Failed to map register base for index(%d) node(%s)\n",
-			index, node->name);
+		dev_err(dev, "Failed to map register base for index(%d) node(%pOFn)\n",
+			index, node);
 	if (_size)
 		*_size = resource_size(&res);
 
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6755f2af5619..b5d5673c255c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1382,15 +1382,15 @@ static void __iomem *knav_queue_map_reg(struct knav_device *kdev,
 
 	ret = of_address_to_resource(node, index, &res);
 	if (ret) {
-		dev_err(kdev->dev, "Can't translate of node(%s) address for index(%d)\n",
-			node->name, index);
+		dev_err(kdev->dev, "Can't translate of node(%pOFn) address for index(%d)\n",
+			node, index);
 		return ERR_PTR(ret);
 	}
 
 	regs = devm_ioremap_resource(kdev->dev, &res);
 	if (IS_ERR(regs))
-		dev_err(kdev->dev, "Failed to map register base for index(%d) node(%s)\n",
-			index, node->name);
+		dev_err(kdev->dev, "Failed to map register base for index(%d) node(%pOFn)\n",
+			index, node);
 	return regs;
 }
 
-- 
2.17.1
