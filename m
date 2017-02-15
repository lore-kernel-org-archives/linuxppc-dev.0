Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNg4P4c59zDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 00:24:37 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Richard Zhu
 <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Murali
 Karicheri <m-karicheri2@ti.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Niklas Cassel
 <niklas.cassel@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Joao
 Pinto <Joao.Pinto@synopsys.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, Stanimir Varbanov
 <svarbanov@mm-sol.com>, Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 02/10] PCI: dwc: *all*: Add platform_set_drvdata
Date: Wed, 15 Feb 2017 18:48:11 +0530
Message-ID: <1487164699-30708-3-git-send-email-kishon@ti.com>
In-Reply-To: <1487164699-30708-1-git-send-email-kishon@ti.com>
References: <1487164699-30708-1-git-send-email-kishon@ti.com>
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

Add platform_set_drvdata in all designware based drivers to store the
private data structure of the driver so that dev_set_drvdata can be
used to get back private data structure in add_pcie_port/host_init.
This is in preparation for splitting struct pcie_port into core and
host only structures. After the split pcie_port will not be part of
the driver's private data structure and *container_of* used now
to get the private data pointer cannot be used.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c           |    3 ++-
 drivers/pci/dwc/pci-exynos.c           |    3 ++-
 drivers/pci/dwc/pci-imx6.c             |    3 ++-
 drivers/pci/dwc/pci-keystone.c         |    2 ++
 drivers/pci/dwc/pci-layerscape.c       |    2 ++
 drivers/pci/dwc/pcie-armada8k.c        |    2 ++
 drivers/pci/dwc/pcie-artpec6.c         |    2 ++
 drivers/pci/dwc/pcie-designware-plat.c |    2 ++
 drivers/pci/dwc/pcie-hisi.c            |    2 ++
 drivers/pci/dwc/pcie-qcom.c            |    2 ++
 drivers/pci/dwc/pcie-spear13xx.c       |    3 ++-
 11 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index ec5617a..d1cd476 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -433,6 +433,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, dra7xx);
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -459,7 +461,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_gpio;
 
-	platform_set_drvdata(pdev, dra7xx);
 	return 0;
 
 err_gpio:
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index f1c544b..c179e7a 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -583,11 +583,12 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_bus_clk;
 	}
 
+	platform_set_drvdata(pdev, exynos_pcie);
+
 	ret = exynos_add_pcie_port(exynos_pcie, pdev);
 	if (ret < 0)
 		goto fail_bus_clk;
 
-	platform_set_drvdata(pdev, exynos_pcie);
 	return 0;
 
 fail_bus_clk:
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index c8cefb0..6e5d06f 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -719,11 +719,12 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		imx6_pcie->link_gen = 1;
 
+	platform_set_drvdata(pdev, imx6_pcie);
+
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, imx6_pcie);
 	return 0;
 }
 
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 043c19a..4c7ba35 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -422,6 +422,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, ks_pcie);
+
 	ret = ks_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index ea78913..89e8817 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -268,6 +268,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
+	platform_set_drvdata(pdev, pcie);
+
 	ret = ls_add_pcie_port(pcie);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index 0ac0f18..5a28dcb 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -226,6 +226,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	platform_set_drvdata(pdev, pcie);
+
 	ret = armada8k_add_pcie_port(pcie, pdev);
 	if (ret)
 		goto fail;
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 212786b..187a98d 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -261,6 +261,8 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(artpec6_pcie->regmap))
 		return PTR_ERR(artpec6_pcie->regmap);
 
+	platform_set_drvdata(pdev, artpec6_pcie);
+
 	ret = artpec6_add_pcie_port(artpec6_pcie, pdev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 1a02038..bb58540 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -104,6 +104,8 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
 
+	platform_set_drvdata(pdev, dw_plat_pcie);
+
 	ret = dw_plat_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index a301a71..ecc1b08 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -287,6 +287,8 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pp->dbi_base))
 		return PTR_ERR(pp->dbi_base);
 
+	platform_set_drvdata(pdev, hisi_pcie);
+
 	ret = hisi_add_pcie_port(hisi_pcie, pdev);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 1ecff2e..3f525cb 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -716,6 +716,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, pcie);
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index dafe8b8..5970566 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -270,11 +270,12 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
 		spear13xx_pcie->is_gen1 = true;
 
+	platform_set_drvdata(pdev, spear13xx_pcie);
+
 	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
 
-	platform_set_drvdata(pdev, spear13xx_pcie);
 	return 0;
 
 fail_clk:
-- 
1.7.9.5
