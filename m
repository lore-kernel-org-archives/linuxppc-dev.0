Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id E96DFDE038
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 01:43:44 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Create common ppc4xx_reset_system() in
	ppc4xx_soc.c
Date: Thu, 27 Mar 2008 15:43:31 +0100
Message-Id: <1206629011-28821-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch creates a common system reset routine for all 40x and 44x
systems. Previously only a 44x routine existed. But since this system
reset via the debug control register is common for 40x and 44x let's
share this code for all those platforms in ppc4xx_soc.c.

This patch also enables CONFIG_4xx_SOC for all 40x and 44x platforms.

Tested on Kilauea (405EX) and Canyonlands (440EX).

Signed-off-by: Stefan Roese <sr@denx.de>
---
This patch applies to the linux-next tree of today (2008-03-27).

 arch/powerpc/platforms/40x/ep405.c       |    2 ++
 arch/powerpc/platforms/40x/kilauea.c     |    4 +++-
 arch/powerpc/platforms/40x/makalu.c      |    2 ++
 arch/powerpc/platforms/40x/virtex.c      |    2 ++
 arch/powerpc/platforms/40x/walnut.c      |    4 +++-
 arch/powerpc/platforms/44x/44x.h         |    1 -
 arch/powerpc/platforms/44x/Kconfig       |    1 -
 arch/powerpc/platforms/44x/bamboo.c      |   15 +++++++--------
 arch/powerpc/platforms/44x/canyonlands.c |    5 ++---
 arch/powerpc/platforms/44x/ebony.c       |    5 ++---
 arch/powerpc/platforms/44x/katmai.c      |    5 ++---
 arch/powerpc/platforms/44x/misc_44x.S    |   11 -----------
 arch/powerpc/platforms/44x/rainier.c     |    4 ++--
 arch/powerpc/platforms/44x/sequoia.c     |    4 +---
 arch/powerpc/platforms/44x/taishan.c     |    5 ++---
 arch/powerpc/platforms/44x/warp.c        |    6 ++----
 arch/powerpc/platforms/Kconfig.cputype   |    2 ++
 arch/powerpc/sysdev/ppc4xx_soc.c         |   11 +++++++++++
 include/asm-powerpc/ppc4xx.h             |   18 ++++++++++++++++++
 19 files changed, 63 insertions(+), 44 deletions(-)
 create mode 100644 include/asm-powerpc/ppc4xx.h

diff --git a/arch/powerpc/platforms/40x/ep405.c b/arch/powerpc/platforms/40x/ep405.c
index 13d1345..ae2e7f6 100644
--- a/arch/powerpc/platforms/40x/ep405.c
+++ b/arch/powerpc/platforms/40x/ep405.c
@@ -29,6 +29,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
 
 static struct device_node *bcsr_node;
 static void __iomem *bcsr_regs;
@@ -119,5 +120,6 @@ define_machine(ep405) {
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
+	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
index f9206a7..1dd24ff 100644
--- a/arch/powerpc/platforms/40x/kilauea.c
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -1,7 +1,7 @@
 /*
  * Kilauea board specific routines
  *
- * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ * Copyright 2007-2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
  *
  * Based on the Walnut code by
  * Josh Boyer <jwboyer@linux.vnet.ibm.com>
@@ -20,6 +20,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id kilauea_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -54,5 +55,6 @@ define_machine(kilauea) {
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
+	.restart			= ppc4xx_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/40x/makalu.c b/arch/powerpc/platforms/40x/makalu.c
index 4e4df72..a6a1d60 100644
--- a/arch/powerpc/platforms/40x/makalu.c
+++ b/arch/powerpc/platforms/40x/makalu.c
@@ -20,6 +20,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id makalu_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -54,5 +55,6 @@ define_machine(makalu) {
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
+	.restart			= ppc4xx_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 0422590..fc7fb00 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -14,6 +14,7 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/xilinx_intc.h>
+#include <asm/ppc4xx.h>
 
 static struct of_device_id xilinx_of_bus_ids[] __initdata = {
 	{ .compatible = "xlnx,plb-v46-1.00.a", },
@@ -48,5 +49,6 @@ define_machine(virtex) {
 	.probe			= virtex_probe,
 	.init_IRQ		= xilinx_intc_init_tree,
 	.get_irq		= xilinx_intc_get_irq,
+	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index b8b257e..335df91 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -26,6 +26,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id walnut_of_bus[] = {
 	{ .compatible = "ibm,plb3", },
@@ -61,5 +62,6 @@ define_machine(walnut) {
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
-	.calibrate_decr	= generic_calibrate_decr,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/44x.h b/arch/powerpc/platforms/44x/44x.h
index 42eabf8..dbc4d2b 100644
--- a/arch/powerpc/platforms/44x/44x.h
+++ b/arch/powerpc/platforms/44x/44x.h
@@ -3,6 +3,5 @@
 
 extern u8 as1_readb(volatile u8 __iomem  *addr);
 extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
-extern void ppc44x_reset_system(char *cmd);
 
 #endif /* __POWERPC_PLATFORMS_44X_44X_H */
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 5fc28aa..6abe913 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -129,7 +129,6 @@ config 440GP
 
 config 440GX
 	bool
-	select 4xx_SOC
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
 	select IBM_NEW_EMAC_ZMII #test only
diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
index fb9a22a..cef169e 100644
--- a/arch/powerpc/platforms/44x/bamboo.c
+++ b/arch/powerpc/platforms/44x/bamboo.c
@@ -22,8 +22,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
-
-#include "44x.h"
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id bamboo_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -53,11 +52,11 @@ static int __init bamboo_probe(void)
 }
 
 define_machine(bamboo) {
-	.name 				= "Bamboo",
-	.probe 				= bamboo_probe,
-	.progress 			= udbg_progress,
-	.init_IRQ 			= uic_init_tree,
-	.get_irq 			= uic_get_irq,
-	.restart			= ppc44x_reset_system,
+	.name 			= "Bamboo",
+	.probe 			= bamboo_probe,
+	.progress 		= udbg_progress,
+	.init_IRQ 		= uic_init_tree,
+	.get_irq 		= uic_get_irq,
+	.restart		= ppc4xx_reset_system,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
index dac5b32..3949289 100644
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -23,8 +23,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
-
-#include "44x.h"
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id canyonlands_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -59,6 +58,6 @@ define_machine(canyonlands) {
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
-	.restart			= ppc44x_reset_system,
+	.restart			= ppc4xx_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index 1a8d467..a0e8fe4 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -26,8 +26,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
-
-#include "44x.h"
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id ebony_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -66,6 +65,6 @@ define_machine(ebony) {
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
-	.restart		= ppc44x_reset_system,
+	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/katmai.c b/arch/powerpc/platforms/44x/katmai.c
index 1113412..44f4b3a 100644
--- a/arch/powerpc/platforms/44x/katmai.c
+++ b/arch/powerpc/platforms/44x/katmai.c
@@ -22,8 +22,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
-
-#include "44x.h"
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id katmai_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -58,6 +57,6 @@ define_machine(katmai) {
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
-	.restart			= ppc44x_reset_system,
+	.restart			= ppc4xx_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/misc_44x.S b/arch/powerpc/platforms/44x/misc_44x.S
index 3bce71d..dc12b80 100644
--- a/arch/powerpc/platforms/44x/misc_44x.S
+++ b/arch/powerpc/platforms/44x/misc_44x.S
@@ -44,14 +44,3 @@ _GLOBAL(as1_writeb)
 	sync
 	isync
 	blr
-
-/*
- * void ppc44x_reset_system(char *cmd)
- *
- * At present, this routine just applies a system reset.
- */
-_GLOBAL(ppc44x_reset_system)
-	mfspr	r13,SPRN_DBCR0
-	oris	r13,r13,DBCR0_RST_SYSTEM@h
-	mtspr	SPRN_DBCR0,r13
-	b	.			/* Just in case the reset doesn't work */
diff --git a/arch/powerpc/platforms/44x/rainier.c b/arch/powerpc/platforms/44x/rainier.c
index a7fae1c..4f1ff84 100644
--- a/arch/powerpc/platforms/44x/rainier.c
+++ b/arch/powerpc/platforms/44x/rainier.c
@@ -22,7 +22,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
-#include "44x.h"
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id rainier_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -57,6 +57,6 @@ define_machine(rainier) {
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
-	.restart			= ppc44x_reset_system,
+	.restart			= ppc4xx_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
index d279db4..1782d41 100644
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
@@ -23,8 +23,6 @@
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
 
-#include "44x.h"
-
 static __initdata struct of_device_id sequoia_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
@@ -58,6 +56,6 @@ define_machine(sequoia) {
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
-	.restart			= ppc44x_reset_system,
+	.restart			= ppc4xx_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/taishan.c b/arch/powerpc/platforms/44x/taishan.c
index 28ab7e2..49c78b2 100644
--- a/arch/powerpc/platforms/44x/taishan.c
+++ b/arch/powerpc/platforms/44x/taishan.c
@@ -29,8 +29,7 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
-
-#include "44x.h"
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id taishan_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -68,6 +67,6 @@ define_machine(taishan) {
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
-	.restart		= ppc44x_reset_system,
+	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index da5b7b7..39cf615 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -18,9 +18,7 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
-
-#include "44x.h"
-
+#include <asm/ppc4xx.h>
 
 static __initdata struct of_device_id warp_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -49,7 +47,7 @@ define_machine(warp) {
 	.progress 	= udbg_progress,
 	.init_IRQ 	= uic_init_tree,
 	.get_irq 	= uic_get_irq,
-	.restart	= ppc44x_reset_system,
+	.restart	= ppc4xx_reset_system,
 	.calibrate_decr = generic_calibrate_decr,
 };
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0c3face..5fc7fac 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -41,11 +41,13 @@ config 40x
 	bool "AMCC 40x"
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
+	select 4xx_SOC
 
 config 44x
 	bool "AMCC 44x"
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
+	select 4xx_SOC
 
 config E200
 	bool "Freescale e200"
diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
index 4b8617e..5b32adc 100644
--- a/arch/powerpc/sysdev/ppc4xx_soc.c
+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
@@ -23,6 +23,7 @@
 
 #include <asm/dcr.h>
 #include <asm/dcr-regs.h>
+#include <asm/reg.h>
 
 static u32 dcrbase_l2c;
 
@@ -187,3 +188,13 @@ static int __init ppc4xx_l2c_probe(void)
 	return 0;
 }
 arch_initcall(ppc4xx_l2c_probe);
+
+/*
+ * At present, this routine just applies a system reset.
+ */
+void ppc4xx_reset_system(char *cmd)
+{
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_RST_SYSTEM);
+	while (1)
+		;	/* Just in case the reset doesn't work */
+}
diff --git a/include/asm-powerpc/ppc4xx.h b/include/asm-powerpc/ppc4xx.h
new file mode 100644
index 0000000..033039a
--- /dev/null
+++ b/include/asm-powerpc/ppc4xx.h
@@ -0,0 +1,18 @@
+/*
+ * PPC4xx Prototypes and definitions
+ *
+ * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __ASM_POWERPC_PPC4xx_H__
+#define __ASM_POWERPC_PPC4xx_H__
+
+extern void ppc4xx_reset_system(char *cmd);
+
+#endif /* __ASM_POWERPC_PPC4xx_H__ */
-- 
1.5.4.4
