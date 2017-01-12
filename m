Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzlBj15mBzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 23:17:32 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 12/37] PCI: dwc: Create a new config symbol to enable pci dwc
 host
Date: Thu, 12 Jan 2017 15:56:01 +0530
Message-ID: <1484216786-17292-13-git-send-email-kishon@ti.com>
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

Now that pci designware host has a separate file, create a new
config symbol to select the host only driver. This is in preparation
to enable endpoint support to designware driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/Kconfig           |   26 +++++++++++++++-----------
 drivers/pci/dwc/Makefile          |    3 ++-
 drivers/pci/dwc/pcie-designware.h |   29 +++++++++++++++++++++++++----
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 8b08519..d0bdfb5 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -3,13 +3,17 @@ menu "DesignWare PCI Core Support"
 
 config PCIE_DW
 	bool
+
+config PCIE_DW_HOST
+        bool
 	depends on PCI_MSI_IRQ_DOMAIN
+        select PCIE_DW
 
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC.  There
 	 are two instances of PCIe controller in DRA7xx.  This controller can
@@ -18,7 +22,7 @@ config PCI_DRA7XX
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW
+	select PCIE_DW_HOST
 	---help---
 	 This selects the DesignWare PCIe controller support. Select this if
 	 you have a PCIe controller on Platform bus.
@@ -32,21 +36,21 @@ config PCI_EXYNOS
 	depends on SOC_EXYNOS5440 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX6Q || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
@@ -55,7 +59,7 @@ config PCI_KEYSTONE
 	depends on ARCH_KEYSTONE || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Keystone
 	  SoCs. The PCI controller on Keystone is based on Designware hardware
@@ -67,7 +71,7 @@ config PCI_LAYERSCAPE
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
 
@@ -76,7 +80,7 @@ config PCI_HISI
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
@@ -86,7 +90,7 @@ config PCIE_QCOM
 	depends on (ARCH_QCOM || COMPILE_TEST) && OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the Designware core plus Qualcomm-specific
@@ -97,7 +101,7 @@ config PCIE_ARMADA_8K
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
@@ -109,7 +113,7 @@ config PCIE_ARTPEC6
 	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
 	  SoCs.  This PCIe controller uses the DesignWare core.
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index 3b57e55..a2df13c 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -1,4 +1,5 @@
-obj-$(CONFIG_PCIE_DW) += pcie-designware.o pcie-designware-host.o
+obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 808d17b..8f3dcb2 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -162,10 +162,6 @@ struct dw_pcie {
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
-void dw_pcie_msi_init(struct pcie_port *pp);
-void dw_pcie_setup_rc(struct pcie_port *pp);
-int dw_pcie_host_init(struct pcie_port *pp);
 
 u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
 void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
@@ -175,4 +171,29 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
 			       u32 size);
 void dw_pcie_setup(struct dw_pcie *pci);
+
+#ifdef CONFIG_PCIE_DW_HOST
+irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
+void dw_pcie_msi_init(struct pcie_port *pp);
+void dw_pcie_setup_rc(struct pcie_port *pp);
+int dw_pcie_host_init(struct pcie_port *pp);
+#else
+static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
+{
+	return IRQ_NONE;
+}
+
+static inline void dw_pcie_msi_init(struct pcie_port *pp)
+{
+}
+
+static inline void dw_pcie_setup_rc(struct pcie_port *pp)
+{
+}
+
+static inline int dw_pcie_host_init(struct pcie_port *pp)
+{
+	return 0;
+}
+#endif
 #endif /* _PCIE_DESIGNWARE_H */
-- 
1.7.9.5
