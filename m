Return-Path: <prabhakar@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8550B2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 20:42:33 +1100 (EST)
Received: from mail1-am1 (localhost [127.0.0.1])	by mail1-am1-R.bigfish.com
 (Postfix) with ESMTP id C44F54A04D2	for <linuxppc-dev@lists.ozlabs.org>; Fri,
 31 Jan 2014 09:42:26 +0000 (UTC)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2][v8] driver/memory:Move Freescale IFC driver to a common
 driver
Date: Fri, 31 Jan 2014 15:09:59 +0530
Message-ID: <1391161199-28018-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Freescale IFC controller has been used for mpc8xxx. It will be used
 for ARM-based SoC as well. This patch moves the driver to driver/memory
 and fix the header file includes.

 Also remove module_platform_driver() and  instead call
 platform_driver_register() from subsys_initcall() to make sure this module
 has been loaded before MTD partition parsing starts.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
Branch next

Changes for v2:
	- Move fsl_ifc in driver/memory

Changes for v3:
	- move device tree bindings to memory

Changes for v4: Rebased to 
	git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git

Changes for v5: 
	- Moved powerpc/Kconfig option to driver/memory

Changes for v6:
	- Update Kconfig details

Changes for v7:
	- Update Kconfig

Changes for v8:
    - Update Kconfig help

 .../{powerpc => memory-controllers}/fsl/ifc.txt    |    0
 arch/powerpc/Kconfig                               |    4 ----
 arch/powerpc/sysdev/Makefile                       |    1 -
 drivers/memory/Kconfig                             |    8 ++++++++
 drivers/memory/Makefile                            |    1 +
 {arch/powerpc/sysdev => drivers/memory}/fsl_ifc.c  |    8 ++++++--
 drivers/mtd/nand/fsl_ifc_nand.c                    |    2 +-
 .../include/asm => include/linux}/fsl_ifc.h        |    0
 8 files changed, 16 insertions(+), 8 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => memory-controllers}/fsl/ifc.txt (100%)
 rename {arch/powerpc/sysdev => drivers/memory}/fsl_ifc.c (98%)
 rename {arch/powerpc/include/asm => include/linux}/fsl_ifc.h (100%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ifc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/ifc.txt
rename to Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a5e5d2e..00edd29 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -734,10 +734,6 @@ config FSL_LBC
 	  controller.  Also contains some common code used by
 	  drivers for specific local bus peripherals.
 
-config FSL_IFC
-	bool
-        depends on FSL_SOC
-
 config FSL_GTM
 	bool
 	depends on PPC_83xx || QUICC_ENGINE || CPM2
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f67ac90..afbcc37 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o fsl_mpic_err.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
-obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 29a11db..57721ed 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -50,4 +50,12 @@ config TEGRA30_MC
 	  analysis, especially for IOMMU/SMMU(System Memory Management
 	  Unit) module.
 
+config FSL_IFC
+	bool "Freescale Integrated Flash Controller"
+	depends on FSL_SOC
+	help
+	  This driver is for the Integrated Flash Controller(IFC) module
+	  available in Freescale SoCs. This controller allows to handle
+	  devices such as NOR, NAND, FPGA and ASIC etc.
+
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 969d923..f2bf25c 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -6,6 +6,7 @@ ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
 obj-$(CONFIG_TI_EMIF)		+= emif.o
+obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
 obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
diff --git a/arch/powerpc/sysdev/fsl_ifc.c b/drivers/memory/fsl_ifc.c
similarity index 98%
rename from arch/powerpc/sysdev/fsl_ifc.c
rename to drivers/memory/fsl_ifc.c
index fbc885b..3d5d792 100644
--- a/arch/powerpc/sysdev/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -29,8 +29,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/fsl_ifc.h>
 #include <asm/prom.h>
-#include <asm/fsl_ifc.h>
 
 struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
 EXPORT_SYMBOL(fsl_ifc_ctrl_dev);
@@ -298,7 +298,11 @@ static struct platform_driver fsl_ifc_ctrl_driver = {
 	.remove      = fsl_ifc_ctrl_remove,
 };
 
-module_platform_driver(fsl_ifc_ctrl_driver);
+static int __init fsl_ifc_init(void)
+{
+	return platform_driver_register(&fsl_ifc_ctrl_driver);
+}
+subsys_initcall(fsl_ifc_init);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Freescale Semiconductor");
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 4335577..865b323 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -30,7 +30,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand_ecc.h>
-#include <asm/fsl_ifc.h>
+#include <linux/fsl_ifc.h>
 
 #define FSL_IFC_V1_1_0	0x01010000
 #define ERR_BYTE		0xFF /* Value returned for read
diff --git a/arch/powerpc/include/asm/fsl_ifc.h b/include/linux/fsl_ifc.h
similarity index 100%
rename from arch/powerpc/include/asm/fsl_ifc.h
rename to include/linux/fsl_ifc.h
-- 
1.7.9.5
