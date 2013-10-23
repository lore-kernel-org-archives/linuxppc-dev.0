Return-Path: <B31939@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B09E2C03F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:42:07 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 07/12][v3] pci: fsl: port PCI platform driver
Date: Wed, 23 Oct 2013 18:41:29 +0800
Message-ID: <1382524894-15164-7-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. The patch ports FSL PCI platform driver. probe function
initialize fsl_pci and register it to architecture PCI system,
remove function removes fsl_pci from architecture PCI system.
fsl_arch_pci_sys_register() and fsl_arch_pci_sys_remove() should
be implemented in architecture-specific driver to provide
register/remove functionality.
2. Remove architecture-specific header and unnecessary header.
3. Change Kconfig and Makefile to support FSL PCI common driver

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 arch/powerpc/Kconfig              |  1 +
 drivers/pci/host/Kconfig          | 10 ++++++++
 drivers/pci/host/Makefile         |  1 +
 drivers/pci/host/pci-fsl-common.c | 53 +++++++++++++++++++++++++--------------
 include/linux/fsl/pci-common.h    |  6 +++++
 5 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 38f3b7e..7447d97d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -690,6 +690,7 @@ config FSL_SOC
 
 config FSL_PCI
  	bool
+	select PCI_FSL_COMMON if FSL_SOC_BOOKE || PPC_86xx
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 3d95048..48242b33 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -19,4 +19,14 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA
 
+config PCI_FSL_COMMON
+	bool "Common driver for Freescale PCI/PCIe controller"
+	depends on FSL_SOC_BOOKE || PPC_86xx
+	help
+	  This driver provides common support for PCI/PCIE controller
+	  on Freescale embedded processors 85xx/86xx/QorIQ/Layerscape.
+	  Additional drivers must be enabled in order to provide some
+	  architecture-dependent functions and register the controller
+	  to PCI subsystem.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index c9a997b..7c338a7 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
+obj-$(CONFIG_PCI_FSL_COMMON) += pci-fsl-common.o
diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index e09a0ec..c7bc472 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -16,26 +16,12 @@
  */
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/log2.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-#include <asm/machdep.h>
-#include <asm/disassemble.h>
-#include <asm/ppc-opcode.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
+#include <linux/fsl/pci-common.h>
 
 /* Indirect type */
 #define INDIRECT_TYPE_EXT_REG			0x00000002
@@ -672,12 +658,40 @@ static const struct of_device_id pci_ids[] = {
 static int fsl_pci_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct device_node *node;
+	struct fsl_pci *pci;
+
+	if (!of_device_is_available(pdev->dev.of_node)) {
+		dev_dbg(&pdev->dev, "disabled\n");
+		return -ENODEV;
+	}
+
+	pci = devm_kzalloc(&pdev->dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci) {
+		dev_err(&pdev->dev, "no memory for fsl_pci\n");
+		return -ENOMEM;
+	}
+
+	ret = fsl_pci_setup(pdev, pci);
+	if (ret)
+		return ret;
+
+	ret = fsl_arch_pci_sys_register(pci);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register pcie to Arch\n");
+		return ret;
+	}
+
+	return 0;
+}
 
-	node = pdev->dev.of_node;
-	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
+static int fsl_pci_remove(struct platform_device *pdev)
+{
+	struct fsl_pci *pci = platform_get_drvdata(pdev);
+
+	if (!pci)
+		return -ENODEV;
 
-	mpc85xx_pci_err_probe(pdev);
+	fsl_arch_pci_sys_remove(pci);
 
 	return 0;
 }
@@ -721,6 +735,7 @@ static struct platform_driver fsl_pci_driver = {
 		.of_match_table = pci_ids,
 	},
 	.probe = fsl_pci_probe,
+	.remove = fsl_pci_remove,
 };
 
 static int __init fsl_pci_init(void)
diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index 490ee53..bfb1f03 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -159,5 +159,11 @@ extern struct pci_bus *fsl_arch_fake_pci_bus(struct fsl_pci *pci, int busnr);
 /* Return PCI64 DMA offset */
 u64 fsl_arch_pci64_dma_offset(void);
 
+/* Register PCI/PCIe controller to architecture system */
+extern int fsl_arch_pci_sys_register(struct fsl_pci *pci);
+
+/* Remove PCI/PCIe controller from architecture system */
+extern void fsl_arch_pci_sys_remove(struct fsl_pci *pci);
+
 #endif /* __PCI_COMMON_H */
 #endif /* __KERNEL__ */
-- 
1.8.1.2
