Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svFnC2G0qzDsyK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:58:07 +1100 (AEDT)
Subject: [PATCH v2 5/7] PCI: layerscape: Move struct pcie_port setup to
 probe function
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:58:02 -0500
Message-ID: <20161012135802.29815.48363.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do the basic pcie_port setup in the probe function for consistency with
other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 2b31296..2d77104 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -216,13 +216,10 @@ static const struct of_device_id ls_pcie_of_match[] = {
 static int __init ls_add_pcie_port(struct ls_pcie *pcie,
 				   struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct pcie_port *pp = &pcie->pp;
+	struct device *dev = pp->dev;
 	int ret;
 
-	pp->dev = dev;
-	pp->ops = pcie->drvdata->ops;
-
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -237,6 +234,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 	struct ls_pcie *pcie;
+	struct pcie_port *pp;
 	struct resource *dbi_base;
 	int ret;
 
@@ -248,6 +246,10 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pp = &pcie->pp;
+	pp->dev = dev;
+	pp->ops = pcie->drvdata->ops;
+
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pcie->pp.dbi_base)) {
