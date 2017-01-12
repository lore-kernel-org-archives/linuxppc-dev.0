Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzj4d0sYDzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:42:08 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 27/37] PCI: dwc: dra7xx: Add EP mode support
Date: Thu, 12 Jan 2017 15:56:16 +0530
Message-ID: <1484216786-17292-28-git-send-email-kishon@ti.com>
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

The PCIe controller integrated in dra7xx SoCs is capable of operating
in endpoint mode. Add endpoint mode support to dra7xx driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/Kconfig           |   31 +++++-
 drivers/pci/dwc/Makefile          |    4 +-
 drivers/pci/dwc/pci-dra7xx.c      |  197 ++++++++++++++++++++++++++++++++++---
 drivers/pci/dwc/pcie-designware.h |    7 ++
 4 files changed, 221 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 4cb1ba0..7932be6 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -16,14 +16,37 @@ config PCIE_DW_EP
 
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
-	depends on PCI
+	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	help
+	 Enables support for the PCIe controller in the DRA7xx SoC. There
+	 are two instances of PCIe controller in DRA7xx. This controller can
+	 work either as EP or RC. In order to enable host specific features
+	 PCI_DRA7XX_HOST must be selected and in order to enable device
+	 specific features PCI_DRA7XX_EP must be selected. This uses
+	 the Designware core.
+
+if PCI_DRA7XX
+
+config PCI_DRA7XX_HOST
+	bool "PCI DRA7xx Host Mode"
+	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	default y
 	help
-	 Enables support for the PCIe controller in the DRA7xx SoC.  There
-	 are two instances of PCIe controller in DRA7xx.  This controller can
-	 act both as EP and RC.  This reuses the Designware core.
+	 Enables support for the PCIe controller in the DRA7xx SoC to work in
+	 host mode.
+
+config PCI_DRA7XX_EP
+	bool "PCI DRA7xx Endpoint Mode"
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	 Enables support for the PCIe controller in the DRA7xx SoC to work in
+	 endpoint mode.
+
+endif
 
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index b38425d..f31a859 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -2,7 +2,9 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
-obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
+ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
+        obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
+endif
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index eb3a9c6..333aa56 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -10,12 +10,14 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -57,6 +59,11 @@
 #define	MSI						BIT(4)
 #define	LEG_EP_INTERRUPTS (INTA | INTB | INTC | INTD)
 
+#define	PCIECTRL_TI_CONF_DEVICE_TYPE			0x0100
+#define	DEVICE_TYPE_EP					0x0
+#define	DEVICE_TYPE_LEG_EP				0x1
+#define	DEVICE_TYPE_RC					0x4
+
 #define	PCIECTRL_DRA7XX_CONF_DEVICE_CMD			0x0104
 #define	LTSSM_EN					0x1
 
@@ -66,6 +73,13 @@
 
 #define EXP_CAP_ID_OFFSET				0x70
 
+#define	PCIECTRL_TI_CONF_INTX_ASSERT			0x0124
+#define	PCIECTRL_TI_CONF_INTX_DEASSERT			0x0128
+
+#define	PCIECTRL_TI_CONF_MSI_XMT			0x012c
+#define MSI_REQ_GRANT					BIT(0)
+#define MSI_VECTOR_SHIFT				7
+
 struct dra7xx_pcie {
 	struct dw_pcie		*pci;
 	void __iomem		*base;		/* DT ti_conf */
@@ -73,6 +87,11 @@ struct dra7xx_pcie {
 	struct phy		**phy;
 	int			link_gen;
 	struct irq_domain	*irq_domain;
+	enum dw_pcie_device_mode mode;
+};
+
+struct dra7xx_pcie_of_data {
+	enum dw_pcie_device_mode mode;
 };
 
 #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
@@ -101,9 +120,19 @@ static int dra7xx_pcie_link_up(struct dw_pcie *pci)
 	return !!(reg & LINK_UP);
 }
 
-static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
+static void dra7xx_pcie_stop_link(struct dw_pcie *pci)
 {
-	struct dw_pcie *pci = dra7xx->pci;
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+	u32 reg;
+
+	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
+	reg &= ~LTSSM_EN;
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
+}
+
+static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
+{
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	struct device *dev = pci->dev;
 	u32 reg;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
@@ -137,7 +166,7 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	return dw_pcie_wait_for_link(pci);
+	return 0;
 }
 
 static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
@@ -171,7 +200,8 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	dra7xx_pcie_establish_link(dra7xx);
+	dra7xx_pcie_establish_link(pci);
+	dw_pcie_wait_for_link(pci);
 	dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
 }
@@ -249,6 +279,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	struct dra7xx_pcie *dra7xx = arg;
 	struct dw_pcie *pci = dra7xx->pci;
 	struct device *dev = pci->dev;
+	struct dw_pcie_ep *ep = &pci->ep;
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
@@ -285,8 +316,11 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	if (reg & LINK_REQ_RST)
 		dev_dbg(dev, "Link Request Reset\n");
 
-	if (reg & LINK_UP_EVT)
+	if (reg & LINK_UP_EVT) {
+		if (dra7xx->mode == DW_PCIE_EP_TYPE)
+			dw_pcie_ep_linkup(ep);
 		dev_dbg(dev, "Link-up state change\n");
+	}
 
 	if (reg & CFG_BME_EVT)
 		dev_dbg(dev, "CFG 'Bus Master Enable' change\n");
@@ -299,6 +333,94 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+
+	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
+}
+
+static void dra7xx_pcie_raise_legacy_irq(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_INTX_ASSERT, 0x1);
+	mdelay(1);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_INTX_DEASSERT, 0x1);
+}
+
+static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
+				      u8 interrupt_num)
+{
+	u32 reg;
+
+	reg = (interrupt_num - 1) << MSI_VECTOR_SHIFT;
+	reg |= MSI_REQ_GRANT;
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_MSI_XMT, reg);
+}
+
+static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep,
+				 enum pci_epc_irq_type type, u8 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		dra7xx_pcie_raise_legacy_irq(dra7xx);
+		break;
+	case PCI_EPC_IRQ_MSI:
+		dra7xx_pcie_raise_msi_irq(dra7xx, interrupt_num);
+		break;
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+	}
+
+	return 0;
+}
+
+static struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = dra7xx_pcie_ep_init,
+	.raise_irq = dra7xx_pcie_raise_irq,
+};
+
+static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
+				     struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = dra7xx->pci;
+
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
+	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
+	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base2)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
@@ -345,6 +467,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
+	.start_link = dra7xx_pcie_establish_link,
+	.stop_link = dra7xx_pcie_stop_link,
 	.link_up = dra7xx_pcie_link_up,
 };
 
@@ -387,6 +511,26 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
 	return ret;
 }
 
+static const struct dra7xx_pcie_of_data dra7xx_pcie_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
+static const struct of_device_id of_dra7xx_pcie_match[] = {
+	{
+		.compatible = "ti,dra7-pcie",
+		.data = &dra7xx_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra7-pcie-ep",
+		.data = &dra7xx_pcie_ep_of_data,
+	},
+	{},
+};
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -403,6 +547,16 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	char name[10];
 	struct gpio_desc *reset;
+	const struct of_device_id *match;
+	const struct dra7xx_pcie_of_data *data;
+	enum dw_pcie_device_mode mode;
+
+	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct dra7xx_pcie_of_data *)match->data;
+	mode = (enum dw_pcie_device_mode)data->mode;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -485,9 +639,25 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
 		dra7xx->link_gen = 2;
 
-	ret = dra7xx_add_pcie_port(dra7xx, pdev);
-	if (ret < 0)
-		goto err_gpio;
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
+				   DEVICE_TYPE_RC);
+		ret = dra7xx_add_pcie_port(dra7xx, pdev);
+		if (ret < 0)
+			goto err_gpio;
+		break;
+	case DW_PCIE_EP_TYPE:
+		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
+				   DEVICE_TYPE_EP);
+		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
+		if (ret < 0)
+			goto err_gpio;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+	}
+	dra7xx->mode = mode;
 
 	return 0;
 
@@ -509,6 +679,9 @@ static int dra7xx_pcie_suspend(struct device *dev)
 	void __iomem *base = pci->dbi_base;
 	u32 val;
 
+	if (dra7xx->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
 	/* clear MSE */
 	val = dw_pcie_read_dbi(pci, base, PCI_COMMAND, 0x4);
 	val &= ~PCI_COMMAND_MEMORY;
@@ -524,6 +697,9 @@ static int dra7xx_pcie_resume(struct device *dev)
 	void __iomem *base = pci->dbi_base;
 	u32 val;
 
+	if (dra7xx->mode != DW_PCIE_RC_TYPE)
+		return 0;
+
 	/* set MSE */
 	val = dw_pcie_read_dbi(pci, base, PCI_COMMAND, 0x4);
 	val |= PCI_COMMAND_MEMORY;
@@ -562,11 +738,6 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
 				      dra7xx_pcie_resume_noirq)
 };
 
-static const struct of_device_id of_dra7xx_pcie_match[] = {
-	{ .compatible = "ti,dra7-pcie", },
-	{},
-};
-
 static struct platform_driver dra7xx_pcie_driver = {
 	.driver = {
 		.name	= "dra7-pcie",
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 7476234..5679aa3 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -117,6 +117,13 @@ enum dw_pcie_region_type {
 	DW_PCIE_REGION_OUTBOUND,
 };
 
+enum dw_pcie_device_mode {
+	DW_PCIE_UNKNOWN_TYPE,
+	DW_PCIE_EP_TYPE,
+	DW_PCIE_LEG_EP_TYPE,
+	DW_PCIE_RC_TYPE,
+};
+
 struct dw_pcie_host_ops {
 	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
 	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
-- 
1.7.9.5
