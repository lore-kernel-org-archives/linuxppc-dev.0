Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E8A9B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 06:24:28 +1000 (EST)
Received: by fxe23 with SMTP id 23so5238890fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 13:24:24 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V2 1/2] powerpc/85xx: consolidate of_platform_bus_probe calls
Date: Sat, 23 Jul 2011 00:23:36 +0400
Message-Id: <1311366217-15384-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311366217-15384-1-git-send-email-dbaryshkov@gmail.com>
References: <1311366217-15384-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

85xx board files have a lot of duplication in *_publish_devices()/
*_declare_of_platform_devices() functions. Merge that into a single
function common to most of the boards.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/Makefile         |    2 +
 arch/powerpc/platforms/85xx/ksi8560.c        |   18 +---------
 arch/powerpc/platforms/85xx/mpc8536_ds.c     |   16 ++-------
 arch/powerpc/platforms/85xx/mpc85xx.h        |    4 ++
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   20 ++---------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   16 ++-------
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   26 ++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |   20 +++--------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   46 ++-----------------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   18 ++--------
 arch/powerpc/platforms/85xx/p1010rdb.c       |   15 ++-------
 arch/powerpc/platforms/85xx/p1022_ds.c       |    7 ++--
 arch/powerpc/platforms/85xx/p1023_rds.c      |   19 ++---------
 arch/powerpc/platforms/85xx/sbc8548.c        |   18 ++--------
 arch/powerpc/platforms/85xx/sbc8560.c        |   20 ++---------
 arch/powerpc/platforms/85xx/socrates.c       |   13 +------
 arch/powerpc/platforms/85xx/stx_gp3.c        |   16 ++-------
 arch/powerpc/platforms/85xx/tqm85xx.c        |   16 ++-------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c    |   20 +++--------
 19 files changed, 84 insertions(+), 246 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_common.c

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a971b32..172a4c8 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,6 +3,8 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 
+obj-y += mpc85xx_common.o
+
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index c46f935..7657e1a 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -35,6 +35,7 @@
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
 
+#include "mpc85xx.h"
 
 #define KSI8560_CPLD_HVR		0x04 /* Hardware Version Register */
 #define KSI8560_CPLD_PVR		0x08 /* PLD Version Register */
@@ -215,22 +216,7 @@ static void ksi8560_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .type = "soc", },
-	{ .type = "simple-bus", },
-	{ .name = "cpm", },
-	{ .name = "localbus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(ksi8560, declare_of_platform_devices);
+machine_device_initcall(ksi8560, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index f79f2f1..9ee6455 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -32,6 +32,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 void __init mpc8536_ds_pic_init(void)
 {
 	struct mpic *mpic;
@@ -104,19 +106,7 @@ static void __init mpc8536_ds_setup_arch(void)
 	printk("MPC8536 DS board from Freescale Semiconductor\n");
 }
 
-static struct of_device_id __initdata mpc8536_ds_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init mpc8536_ds_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, mpc8536_ds_ids, NULL);
-}
-machine_device_initcall(mpc8536_ds, mpc8536_ds_publish_devices);
+machine_device_initcall(mpc8536_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
new file mode 100644
index 0000000..1a1b4eb
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -0,0 +1,4 @@
+#ifndef MPC85xx_H
+#define MPC85xx_H
+extern int mpc85xx_common_publish_devices(void);
+#endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 3b2c9bb..153d2aa 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -35,6 +35,8 @@
 #include <sysdev/cpm2_pic.h>
 #endif
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_PCI
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
@@ -221,23 +223,7 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .type = "soc", },
-	{ .name = "cpm", },
-	{ .name = "localbus", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc85xx_ads, declare_of_platform_devices);
+machine_device_initcall(mpc85xx_ads, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6299a2a..a978d46 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -47,6 +47,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* CADMUS info */
 /* xxx - galak, move into device tree */
 #define CADMUS_BASE (0xf8004000)
@@ -331,19 +333,7 @@ static int __init mpc85xx_cds_probe(void)
         return of_flat_dt_is_compatible(root, "MPC85xxCDS");
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	return of_platform_bus_probe(NULL, of_bus_ids, NULL);
-}
-machine_device_initcall(mpc85xx_cds, declare_of_platform_devices);
+machine_device_initcall(mpc85xx_cds, mpc85xx_common_publish_devices);
 
 define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
new file mode 100644
index 0000000..999567a
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -0,0 +1,26 @@
+/*
+ * Routines common to most mpc85xx-based boards.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+#include "mpc85xx.h"
+
+static struct of_device_id __initdata mpc85xx_common_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,qe", },
+	{ .compatible = "fsl,cpm2", },
+	{},
+};
+
+int __init mpc85xx_common_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
+}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c7b97f7..4508804 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -36,6 +36,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -218,21 +220,9 @@ static int __init mpc8544_ds_probe(void)
 	return 0;
 }
 
-static struct of_device_id __initdata mpc85xxds_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init mpc85xxds_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, mpc85xxds_ids, NULL);
-}
-machine_device_initcall(mpc8544_ds, mpc85xxds_publish_devices);
-machine_device_initcall(mpc8572_ds, mpc85xxds_publish_devices);
-machine_device_initcall(p2020_ds, mpc85xxds_publish_devices);
+machine_device_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
+machine_device_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
+machine_device_initcall(p2020_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 747d1ee..fde37e5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -53,6 +53,8 @@
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 
+#include "mpc85xx.h"
+
 #undef DEBUG
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -159,25 +161,6 @@ extern void __init mpc85xx_smp_init(void);
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
-static struct of_device_id mpc85xx_qe_ids[] __initdata = {
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
-	{ },
-};
-
-static void __init mpc85xx_publish_qe_devices(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
-
-	of_platform_bus_probe(NULL, mpc85xx_qe_ids, NULL);
-}
-
 static void __init mpc85xx_mds_reset_ucc_phys(void)
 {
 	struct device_node *np;
@@ -348,7 +331,6 @@ static void __init mpc85xx_mds_qeic_init(void)
 	of_node_put(np);
 }
 #else
-static void __init mpc85xx_publish_qe_devices(void) { }
 static void __init mpc85xx_mds_qe_init(void) { }
 static void __init mpc85xx_mds_qeic_init(void) { }
 #endif	/* CONFIG_QUICC_ENGINE */
@@ -430,24 +412,12 @@ machine_arch_initcall(mpc8568_mds, board_fixups);
 machine_arch_initcall(mpc8569_mds, board_fixups);
 
 static struct of_device_id mpc85xx_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,rapidio-delta", },
 	{ .compatible = "fsl,mpc8548-guts", },
 	{ .compatible = "gpio-leds", },
 	{},
 };
 
-static struct of_device_id p1021_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
 static int __init mpc85xx_publish_devices(void)
 {
 	if (machine_is(mpc8568_mds))
@@ -455,23 +425,15 @@ static int __init mpc85xx_publish_devices(void)
 	if (machine_is(mpc8569_mds))
 		simple_gpiochip_init("fsl,mpc8569mds-bcsr-gpio");
 
+	mpc85xx_common_publish_devices();
 	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
-	mpc85xx_publish_qe_devices();
-
-	return 0;
-}
-
-static int __init p1021_publish_devices(void)
-{
-	of_platform_bus_probe(NULL, p1021_ids, NULL);
-	mpc85xx_publish_qe_devices();
 
 	return 0;
 }
 
 machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
 machine_device_initcall(mpc8569_mds, mpc85xx_publish_devices);
-machine_device_initcall(p1021_mds, p1021_publish_devices);
+machine_device_initcall(p1021_mds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 088f30b..19d717e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -30,6 +30,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -108,20 +110,8 @@ static void __init mpc85xx_rdb_setup_arch(void)
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
-static struct of_device_id __initdata mpc85xxrdb_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init mpc85xxrdb_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
-}
-machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
-machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
+machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
+machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index d7387fa..2f479f8 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -28,6 +28,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 void __init p1010_rdb_pic_init(void)
 {
 	struct mpic *mpic;
@@ -81,18 +83,7 @@ static void __init p1010_rdb_setup_arch(void)
 	printk(KERN_INFO "P1010 RDB board from Freescale Semiconductor\n");
 }
 
-static struct of_device_id __initdata p1010rdb_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-static int __init p1010rdb_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, p1010rdb_ids, NULL);
-}
-machine_device_initcall(p1010_rdb, p1010rdb_publish_devices);
+machine_device_initcall(p1010_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 266b3aa..26e6f75 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -27,6 +27,8 @@
 #include <sysdev/fsl_pci.h>
 #include <asm/fsl_guts.h>
 
+#include "mpc85xx.h"
+
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
 /*
@@ -325,10 +327,6 @@ static void __init p1022_ds_setup_arch(void)
 }
 
 static struct of_device_id __initdata p1022_ds_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
 	/* So that the DMA channel nodes can be probed individually: */
 	{ .compatible = "fsl,eloplus-dma", },
 	{},
@@ -338,6 +336,7 @@ static int __init p1022_ds_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
 }
+machine_device_initcall(p1022_ds, mpc85xx_common_publish_devices);
 machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
 
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 835e0b3..e76c4dc 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -34,6 +34,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -92,22 +94,7 @@ static void __init mpc85xx_rds_setup_arch(void)
 #endif
 }
 
-static struct of_device_id p1023_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-
-static int __init p1023_publish_devices(void)
-{
-	of_platform_bus_probe(NULL, p1023_ids, NULL);
-
-	return 0;
-}
-
-machine_device_initcall(p1023_rds, p1023_publish_devices);
+machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index ecdd8c0..a6605a2 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -49,6 +49,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 static int sbc_rev;
 
 static void __init sbc8548_pic_init(void)
@@ -150,21 +152,7 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .type = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(sbc8548, declare_of_platform_devices);
+machine_device_initcall(sbc8548, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 678f5a8..bbb656f 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -37,6 +37,8 @@
 #include <sysdev/cpm2_pic.h>
 #endif
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_CPM2
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
@@ -208,23 +210,7 @@ static void sbc8560_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .type = "soc", },
-	{ .name = "cpm", },
-	{ .name = "localbus", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(sbc8560, declare_of_platform_devices);
+machine_device_initcall(sbc8560, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index 747d8fb..fec496a 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -41,6 +41,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
 #include "socrates_fpga_pic.h"
 
 static void __init socrates_pic_init(void)
@@ -96,17 +97,7 @@ static void __init socrates_setup_arch(void)
 #endif
 }
 
-static struct of_device_id __initdata socrates_of_bus_ids[] = {
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init socrates_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, socrates_of_bus_ids, NULL);
-}
-machine_device_initcall(socrates, socrates_publish_devices);
+machine_device_initcall(socrates, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 5387e9f..ab80044 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -40,6 +40,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
@@ -144,19 +146,7 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(stx_gp3, declare_of_platform_devices);
+machine_device_initcall(stx_gp3, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 325de77..19e711f 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -38,6 +38,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
@@ -173,19 +175,7 @@ static void __init tqm85xx_ti1520_fixup(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520,
 		tqm85xx_ti1520_fixup);
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(tqm85xx, declare_of_platform_devices);
+machine_device_initcall(tqm85xx, mpc85xx_common_publish_devices);
 
 static const char *board[] __initdata = {
 	"tqc,tqm8540",
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 0125604..0ee3721 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -33,6 +33,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* A few bit definitions needed for fixups on some boards */
 #define MPC85xx_L2CTL_L2E		0x80000000 /* L2 enable */
 #define MPC85xx_L2CTL_L2I		0x40000000 /* L2 flash invalidate */
@@ -177,21 +179,9 @@ static void __init xes_mpc85xx_setup_arch(void)
 #endif
 }
 
-static struct of_device_id __initdata xes_mpc85xx_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init xes_mpc85xx_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, xes_mpc85xx_ids, NULL);
-}
-machine_device_initcall(xes_mpc8572, xes_mpc85xx_publish_devices);
-machine_device_initcall(xes_mpc8548, xes_mpc85xx_publish_devices);
-machine_device_initcall(xes_mpc8540, xes_mpc85xx_publish_devices);
+machine_device_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
+machine_device_initcall(xes_mpc8548, mpc85xx_common_publish_devices);
+machine_device_initcall(xes_mpc8540, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
-- 
1.7.2.5
