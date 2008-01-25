Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A31E3DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 13:46:02 +1100 (EST)
Date: Thu, 24 Jan 2008 20:45:51 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/9] powerpc: fold the mpc8313 platform into the mpc831x
	platform
Message-Id: <20080124204551.10cea5fd.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

prepare for adding support for the mpc8315 rdb,
since they are identical wrt platform code.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
Kumar, this set of patches is base support for two new boards - the
mpc8315e rdb and the mpc837xe rdb.  Please consider for 2.6.25.  Thanks.

 arch/powerpc/configs/mpc8313_rdb_defconfig         |    2 +-
 arch/powerpc/platforms/83xx/Kconfig                |    6 ++--
 arch/powerpc/platforms/83xx/Makefile               |    2 +-
 .../83xx/{mpc8313_rdb.c => mpc831x_rdb.c}          |   35 +++++++------------
 4 files changed, 18 insertions(+), 27 deletions(-)
 rename arch/powerpc/platforms/83xx/{mpc8313_rdb.c => mpc831x_rdb.c} (70%)

diff --git a/arch/powerpc/configs/mpc8313_rdb_defconfig b/arch/powerpc/configs/mpc8313_rdb_defconfig
index db08e73..3b29ac5 100644
--- a/arch/powerpc/configs/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/mpc8313_rdb_defconfig
@@ -138,7 +138,7 @@ CONFIG_PPC_83xx=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
-CONFIG_MPC8313_RDB=y
+CONFIG_MPC831x_RDB=y
 # CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC832x_RDB is not set
 # CONFIG_MPC834x_MDS is not set
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2430ac8..faaa651 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -3,8 +3,8 @@ choice
 	depends on PPC_83xx
 	default MPC834x_MDS
 
-config MPC8313_RDB
-	bool "Freescale MPC8313 RDB"
+config MPC831x_RDB
+	bool "Freescale MPC831x RDB"
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8313 RDB board.
@@ -61,7 +61,7 @@ config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC8313_RDB
+	default y if MPC831x_RDB
 
 config PPC_MPC832x
 	bool
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index df46629..1111a50 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -3,7 +3,7 @@
 #
 obj-y				:= misc.o usb.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_MPC8313_RDB)	+= mpc8313_rdb.o
+obj-$(CONFIG_MPC831x_RDB)	+= mpc831x_rdb.o
 obj-$(CONFIG_MPC832x_RDB)	+= mpc832x_rdb.o
 obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
 obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
similarity index 70%
rename from arch/powerpc/platforms/83xx/mpc8313_rdb.c
rename to arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 4996b7d..b484b2b 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -1,7 +1,7 @@
 /*
- * arch/powerpc/platforms/83xx/mpc8313_rdb.c
+ * arch/powerpc/platforms/83xx/mpc831x_rdb.c
  *
- * Description: MPC8313x RDB board specific routines.
+ * Description: MPC831x RDB board specific routines.
  * This file is based on mpc834x_sys.c
  * Author: Lo Wlison <r43300@freescale.com>
  *
@@ -22,26 +22,17 @@
 
 #include "mpc83xx.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-/* ************************************************************************
- *
+/*
  * Setup the architecture
- *
  */
-static void __init mpc8313_rdb_setup_arch(void)
+static void __init mpc831x_rdb_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
 
 	if (ppc_md.progress)
-		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);
+		ppc_md.progress("mpc831x_rdb_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
@@ -50,7 +41,7 @@ static void __init mpc8313_rdb_setup_arch(void)
 	mpc831x_usb_cfg();
 }
 
-void __init mpc8313_rdb_init_IRQ(void)
+void __init mpc831x_rdb_init_IRQ(void)
 {
 	struct device_node *np;
 
@@ -69,7 +60,7 @@ void __init mpc8313_rdb_init_IRQ(void)
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-static int __init mpc8313_rdb_probe(void)
+static int __init mpc831x_rdb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
@@ -86,13 +77,13 @@ static int __init declare_of_platform_devices(void)
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-machine_device_initcall(mpc8313_rdb, declare_of_platform_devices);
+machine_device_initcall(mpc831x_rdb, declare_of_platform_devices);
 
-define_machine(mpc8313_rdb) {
-	.name			= "MPC8313 RDB",
-	.probe			= mpc8313_rdb_probe,
-	.setup_arch		= mpc8313_rdb_setup_arch,
-	.init_IRQ		= mpc8313_rdb_init_IRQ,
+define_machine(mpc831x_rdb) {
+	.name			= "MPC831x RDB",
+	.probe			= mpc831x_rdb_probe,
+	.setup_arch		= mpc831x_rdb_setup_arch,
+	.init_IRQ		= mpc831x_rdb_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
-- 
1.5.2.2
