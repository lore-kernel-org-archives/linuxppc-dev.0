Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYw37tbzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:08 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 29/37] PCI: dwc: dra7xx: Workaround for errata id i870
Date: Thu, 12 Jan 2017 15:56:18 +0530
Message-ID: <1484216786-17292-30-git-send-email-kishon@ti.com>
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

According to errata i870, access to the PCIe slave port
that are not 32-bit aligned will result in incorrect mapping
to TLP Address and Byte enable fields.

Accessing non 32-bit aligned data causes incorrect data in the target
buffer if memcpy is used. Implement the workaround for this
errata here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 333aa56..7666e3e 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -26,6 +26,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/resource.h>
 #include <linux/types.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pcie-designware.h"
 
@@ -531,6 +533,48 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
 	{},
 };
 
+/*
+ * dra7xx_pcie_ep_legacy_mode: workaround for AM572x/AM571x Errata i870
+ * @dra7xx: the dra7xx device where the workaround should be applied
+ *
+ * Access to the PCIe slave port that are not 32-bit aligned will result
+ * in incorrect mapping to TLP Address and Byte enable fields. Therefore,
+ * byte and half-word accesses are not possible to byte offset 0x1, 0x2, or
+ * 0x3.
+ *
+ * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
+ */
+static int dra7xx_pcie_ep_legacy_mode(struct device *dev)
+{
+	int ret;
+	struct device_node *np = dev->of_node;
+	struct regmap *regmap;
+	unsigned int reg;
+	unsigned int field;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "syscon-legacy-mode");
+	if (IS_ERR(regmap)) {
+		dev_dbg(dev, "can't get syscon-legacy-mode\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "syscon-legacy-mode", 1, &reg)) {
+		dev_err(dev, "couldn't get legacy mode register offset\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "syscon-legacy-mode", 2, &field)) {
+		dev_err(dev, "can't get bit field for setting legacy mode\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(regmap, reg, field, field);
+	if (ret)
+		dev_err(dev, "failed to set legacy mode\n");
+
+	return ret;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -643,6 +687,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	case DW_PCIE_RC_TYPE:
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_RC);
+
 		ret = dra7xx_add_pcie_port(dra7xx, pdev);
 		if (ret < 0)
 			goto err_gpio;
@@ -650,6 +695,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	case DW_PCIE_EP_TYPE:
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
+
+		ret = dra7xx_pcie_ep_legacy_mode(dev);
+		if (ret)
+			goto err_gpio;
+
 		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
 		if (ret < 0)
 			goto err_gpio;
-- 
1.7.9.5
