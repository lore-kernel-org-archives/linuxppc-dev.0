Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYv2Y57zDqPl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:07 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 09/37] PCI: dwc: designware: Parse *num-lanes* property in
 dw_pcie_setup_rc
Date: Thu, 12 Jan 2017 15:55:58 +0530
Message-ID: <1484216786-17292-10-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
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

*num-lanes* dt property is parsed in dw_pcie_host_init. However
*num-lanes* property is applicable to both root complex mode and
endpoint mode. As a first step, move the parsing of this property
outside dw_pcie_host_init. This is in preparation for splitting
pcie-designware.c to pcie-designware.c and pcie-designware-host.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |   18 +++++++++++-------
 drivers/pci/dwc/pcie-designware.h |    1 -
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 00a0fdc..89cdb6b 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -551,10 +551,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	ret = of_property_read_u32(np, "num-lanes", &pci->lanes);
-	if (ret)
-		pci->lanes = 0;
-
 	ret = of_property_read_u32(np, "num-viewport", &pci->num_viewport);
 	if (ret)
 		pci->num_viewport = 2;
@@ -751,18 +747,26 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
+	int ret;
+	u32 lanes;
 	u32 val;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 
 	/* get iATU unroll support */
 	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
 	dev_dbg(pci->dev, "iATU unroll: %s\n",
 		pci->iatu_unroll_enabled ? "enabled" : "disabled");
 
+	ret = of_property_read_u32(np, "num-lanes", &lanes);
+	if (ret)
+		lanes = 0;
+
 	/* set the number of lanes */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
-	switch (pci->lanes) {
+	switch (lanes) {
 	case 1:
 		val |= PORT_LINK_MODE_1_LANES;
 		break;
@@ -776,7 +780,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LINK_MODE_8_LANES;
 		break;
 	default:
-		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->lanes);
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", lanes);
 		return;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
@@ -784,7 +788,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	/* set link width speed control register */
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pci->lanes) {
+	switch (lanes) {
 	case 1:
 		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index d4b3d43..491fbe3 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -148,7 +148,6 @@ struct dw_pcie_ops {
 struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
-	u32			lanes;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
-- 
1.7.9.5
