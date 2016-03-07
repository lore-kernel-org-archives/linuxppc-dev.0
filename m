Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0089.outbound.protection.outlook.com [207.46.100.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87A7B1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:50:14 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 4/7] iommu/fsl: Factor out PCI specific code
Date: Mon, 7 Mar 2016 17:34:20 +0200
Message-ID: <1457364863-18004-5-git-send-email-codrin.ciubotariu@nxp.com>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
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

From: Varun Sethi <Varun.Sethi@freescale.com>

Factor out PCI specific code in the PAMU driver.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu_domain.c | 77 ++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 869e55e..37f95d3 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -661,21 +661,14 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 	return ret;
 }
 
-static int fsl_pamu_attach_device(struct iommu_domain *domain,
-				  struct device *dev)
+static struct device *get_dma_device(struct device *dev)
 {
-	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-	const u32 *liodn;
-	u32 liodn_cnt;
-	int len, ret = 0;
-	struct pci_dev *pdev = NULL;
-	struct pci_controller *pci_ctl;
-
-	/*
-	 * Use LIODN of the PCI controller while attaching a
-	 * PCI device.
-	 */
+	struct device *dma_dev = dev;
+#ifdef CONFIG_PCI
 	if (dev_is_pci(dev)) {
+		struct pci_controller *pci_ctl;
+		struct pci_dev *pdev;
+
 		pdev = to_pci_dev(dev);
 		pci_ctl = pci_bus_to_host(pdev->bus);
 		/*
@@ -683,16 +676,30 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 		 * so we can get the LIODN programmed by
 		 * u-boot.
 		 */
-		dev = pci_ctl->parent;
+		dma_dev = pci_ctl->parent;
 	}
+#endif
+	return dma_dev;
+}
+
+static int fsl_pamu_attach_device(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	struct device *dma_dev;
+	const u32 *liodn;
+	u32 liodn_cnt;
+	int len, ret = 0;
+
+	dma_dev = get_dma_device(dev);
 
-	liodn = of_get_property(dev->of_node, "fsl,liodn", &len);
+	liodn = of_get_property(dma_dev->of_node, "fsl,liodn", &len);
 	if (liodn) {
 		liodn_cnt = len / sizeof(u32);
 		ret = handle_attach_device(dma_domain, dev, liodn, liodn_cnt);
 	} else {
 		pr_debug("missing fsl,liodn property at %s\n",
-			 dev->of_node->full_name);
+			 dma_dev->of_node->full_name);
 		ret = -EINVAL;
 	}
 
@@ -703,27 +710,13 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	struct device *dma_dev;
 	const u32 *prop;
 	int len;
-	struct pci_dev *pdev = NULL;
-	struct pci_controller *pci_ctl;
 
-	/*
-	 * Use LIODN of the PCI controller while detaching a
-	 * PCI device.
-	 */
-	if (dev_is_pci(dev)) {
-		pdev = to_pci_dev(dev);
-		pci_ctl = pci_bus_to_host(pdev->bus);
-		/*
-		 * make dev point to pci controller device
-		 * so we can get the LIODN programmed by
-		 * u-boot.
-		 */
-		dev = pci_ctl->parent;
-	}
+	dma_dev = get_dma_device(dev);
 
-	prop = of_get_property(dev->of_node, "fsl,liodn", &len);
+	prop = of_get_property(dma_dev->of_node, "fsl,liodn", &len);
 	if (prop)
 		detach_device(dev, dma_domain);
 	else
@@ -884,6 +877,7 @@ static struct iommu_group *get_device_iommu_group(struct device *dev)
 	return group;
 }
 
+#ifdef CONFIG_PCI
 static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)
 {
 	u32 version;
@@ -927,6 +921,10 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 	bool pci_endpt_partioning;
 	struct iommu_group *group = NULL;
 
+	/* Don't create device groups for virtual PCI bridges */
+	if (pdev->subordinate)
+		return NULL;
+
 	pci_ctl = pci_bus_to_host(pdev->bus);
 	pci_endpt_partioning = check_pci_ctl_endpt_part(pci_ctl);
 	/* We can partition PCIe devices so assign device group to the device */
@@ -963,6 +961,7 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 
 	return group;
 }
+#endif
 
 static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 {
@@ -973,10 +972,14 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 	 * For platform devices we allocate a separate group for
 	 * each of the devices.
 	 */
-	if (dev_is_pci(dev))
+	if (!dev_is_pci(dev)) {
+		if (of_get_property(dev->of_node, "fsl, liodn", &len))
+			group = get_device_iommu_group(dev);
+#ifdef CONFIG_PCI
+	} else {
 		group = get_pci_device_group(to_pci_dev(dev));
-	else if (of_get_property(dev->of_node, "fsl,liodn", &len))
-		group = get_device_iommu_group(dev);
+#endif
+	}
 
 	return group;
 }
@@ -1085,7 +1088,9 @@ int __init pamu_domain_init(void)
 		return ret;
 
 	bus_set_iommu(&platform_bus_type, &fsl_pamu_ops);
+#ifdef CONFIG_PCI
 	bus_set_iommu(&pci_bus_type, &fsl_pamu_ops);
+#endif
 
 	return ret;
 }
-- 
1.9.3
