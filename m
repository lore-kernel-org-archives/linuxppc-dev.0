Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
 [74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B2B74B7238
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 04:56:52 +1100 (EST)
Received: by wyg36 with SMTP id 36so2385115wyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 09:56:47 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
Date: Thu, 17 Nov 2011 21:56:17 +0400
Message-Id: <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
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
 arch/powerpc/platforms/85xx/ksi8560.c        |   17 +---------
 arch/powerpc/platforms/85xx/mpc8536_ds.c     |   14 +-------
 arch/powerpc/platforms/85xx/mpc85xx.h        |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   18 +----------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   14 +-------
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   16 +++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |   18 ++---------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   44 +------------------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   16 +--------
 arch/powerpc/platforms/85xx/p1022_ds.c       |    5 +--
 arch/powerpc/platforms/85xx/sbc8548.c        |   18 ++---------
 arch/powerpc/platforms/85xx/sbc8560.c        |   18 +----------
 arch/powerpc/platforms/85xx/socrates.c       |   12 +------
 arch/powerpc/platforms/85xx/stx_gp3.c        |   14 +-------
 arch/powerpc/platforms/85xx/tqm85xx.c        |   14 +-------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c    |   18 ++---------
 16 files changed, 40 insertions(+), 218 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index bf9b1e5..0f3e688 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -190,22 +190,7 @@ static void ksi8560_show_cpuinfo(struct seq_file *m)
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
index 6a4b2c1..9ee6455 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -106,19 +106,7 @@ static void __init mpc8536_ds_setup_arch(void)
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
index fa55e8b..2aa7c5d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -1,5 +1,7 @@
 #ifndef MPC85xx_H
 #define MPC85xx_H
+extern int mpc85xx_common_publish_devices(void);
+
 #ifdef CONFIG_CPM2
 extern void mpc85xx_cpm2_pic_init(void);
 #else
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 8b8f7a2..986554b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -193,23 +193,7 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
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
index 93bf18a..a268f43 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -333,19 +333,7 @@ static int __init mpc85xx_cds_probe(void)
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
index 49d781c..fe40668 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -11,6 +11,22 @@
 
 #include "mpc85xx.h"
 
+static struct of_device_id __initdata mpc85xx_common_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
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
 #ifdef CONFIG_CPM2
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 55075b9..2113120 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -221,21 +221,9 @@ static int __init mpc8544_ds_probe(void)
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
index 2ee487a..3beb00b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -161,25 +161,6 @@ extern void __init mpc85xx_smp_init(void);
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
@@ -350,7 +331,6 @@ static void __init mpc85xx_mds_qeic_init(void)
 	of_node_put(np);
 }
 #else
-static void __init mpc85xx_publish_qe_devices(void) { }
 static void __init mpc85xx_mds_qe_init(void) { }
 static void __init mpc85xx_mds_qeic_init(void) { }
 #endif	/* CONFIG_QUICC_ENGINE */
@@ -432,24 +412,12 @@ machine_arch_initcall(mpc8568_mds, board_fixups);
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
@@ -457,23 +425,15 @@ static int __init mpc85xx_publish_devices(void)
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
index 824d2b6..9feccbb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -111,20 +111,8 @@ static void __init mpc85xx_rdb_setup_arch(void)
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
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 00d93a4..cacb4d4 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -330,10 +330,6 @@ static void __init p1022_ds_setup_arch(void)
 }
 
 static struct of_device_id __initdata p1022_ds_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
 	/* So that the DMA channel nodes can be probed individually: */
 	{ .compatible = "fsl,eloplus-dma", },
 	{},
@@ -343,6 +339,7 @@ static int __init p1022_ds_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
 }
+machine_device_initcall(p1022_ds, mpc85xx_common_publish_devices);
 machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
 
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index d07dcb7..35deaa9 100644
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
index 43711f8..e9a7ed2 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -180,23 +180,7 @@ static void sbc8560_show_cpuinfo(struct seq_file *m)
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
index 9d0fc28..fec496a 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -97,17 +97,7 @@ static void __init socrates_setup_arch(void)
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
index d24192b..b44c936 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -113,19 +113,7 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
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
index b9e53cc..2418bf8 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -142,19 +142,7 @@ static void __init tqm85xx_ti1520_fixup(struct pci_dev *pdev)
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
index ab7025a..4632c1b 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -179,21 +179,9 @@ static void __init xes_mpc85xx_setup_arch(void)
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
1.7.7.1
