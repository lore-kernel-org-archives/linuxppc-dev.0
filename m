Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNfyq41CRzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 00:19:47 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/10] PCI: dwc: Remove dependency of designware to CONFIG_PCI
Date: Wed, 15 Feb 2017 18:48:19 +0530
Message-ID: <1487164699-30708-11-git-send-email-kishon@ti.com>
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

CONFIG_PCI is used to enable the host mode PCI. In preparation for adding
endpoint mode support to designware driver, remove the dependency of
designware to CONFIG_PCI and make only the host specific part depend on
CONFIG_PCI.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/Makefile        |    3 +++
 drivers/pci/Makefile    |    3 ---
 drivers/pci/dwc/Kconfig |   13 ++++++++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 060026a..f521cb0 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
 obj-$(CONFIG_GPIOLIB)		+= gpio/
 obj-y				+= pwm/
 obj-$(CONFIG_PCI)		+= pci/
+# PCI dwc controller drivers
+obj-y				+= pci/dwc/
+
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
 obj-y				+= video/
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index b7e9751..8db5079 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -66,8 +66,5 @@ obj-$(CONFIG_OF) += of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
-# PCI dwc controller drivers
-obj-y += dwc/
-
 # PCI host controller drivers
 obj-y += host/
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index ab92a0c..dfb8a69 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -1,16 +1,17 @@
 menu "DesignWare PCI Core Support"
-	depends on PCI
 
 config PCIE_DW
 	bool
 
 config PCIE_DW_HOST
         bool
+	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
         select PCIE_DW
 
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
+	depends on PCI
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
@@ -21,6 +22,7 @@ config PCI_DRA7XX
 
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
+	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	---help---
@@ -33,6 +35,7 @@ config PCIE_DW_PLAT
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
+	depends on PCI
 	depends on SOC_EXYNOS5440
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -40,6 +43,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
+	depends on PCI
 	depends on SOC_IMX6Q
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -47,6 +51,7 @@ config PCI_IMX6
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
+	depends on PCI
 	depends on ARCH_SPEAR13XX
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -56,6 +61,7 @@ config PCIE_SPEAR13XX
 
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
+	depends on PCI
 	depends on ARCH_KEYSTONE
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -68,6 +74,7 @@ config PCI_KEYSTONE
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
+	depends on PCI
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
@@ -78,6 +85,7 @@ config PCI_LAYERSCAPE
 config PCI_HISI
 	depends on OF && ARM64
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -87,6 +95,7 @@ config PCI_HISI
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
+	depends on PCI
 	depends on ARCH_QCOM && OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -98,6 +107,7 @@ config PCIE_QCOM
 
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
+	depends on PCI
 	depends on ARCH_MVEBU
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
@@ -110,6 +120,7 @@ config PCIE_ARMADA_8K
 
 config PCIE_ARTPEC6
 	bool "Axis ARTPEC-6 PCIe controller"
+	depends on PCI
 	depends on MACH_ARTPEC6
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-- 
1.7.9.5
