Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 697CEDDFB5
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 21:13:29 +1100 (EST)
Date: Thu, 13 Dec 2007 19:13:14 +0900 (JST)
Message-Id: <20071213.191314.-1350525689.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 2/2] celleb: split machine definition
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch splits machine definition for celleb into two definitoins,
one is for celleb_beat, and another is for celleb_native. Though this
patch looks complex because of sorting some functions, there are no
more semantic changes than that for the splitting.

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Here is the previous discussion:
 http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047436.html


Index: linux-powerpc-git/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-powerpc-git/arch/powerpc/platforms/cell/iommu.c
@@ -700,8 +700,8 @@ static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
 
-	if ((!machine_is(cell) && !machine_is(celleb)) ||
-	    firmware_has_feature(FW_FEATURE_LPAR))
+	if (!machine_is(cell) &&
+	    !machine_is(celleb_native))
 		return -ENODEV;
 
 	/* If IOMMU is disabled or we have little enough RAM to not need
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc_uhc.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c
@@ -47,7 +47,8 @@ static void enable_scc_uhc(struct pci_de
 	u32 val = 0;
 	int i;
 
-	if (!machine_is(celleb))
+	if (!machine_is(celleb_beat) &&
+	    !machine_is(celleb_native))
 		return;
 
 	uhc_base = ioremap(pci_resource_start(dev, 0),
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
@@ -93,30 +93,43 @@ static void celleb_progress(char *s, uns
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static void __init celleb_init_IRQ_native(void)
+static void __init celleb_setup_arch_common(void)
 {
-	iic_init_IRQ();
-	spider_init_IRQ();
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
 }
 
-static void __init celleb_setup_arch_beat(void)
+static struct of_device_id celleb_bus_ids[] __initdata = {
+	{ .type = "scc", },
+	{ .type = "ioif", },	/* old style */
+	{},
+};
+
+static int __init celleb_publish_devices(void)
 {
-	ppc_md.restart		= beat_restart;
-	ppc_md.power_off	= beat_power_off;
-	ppc_md.halt		= beat_halt;
-	ppc_md.get_rtc_time	= beat_get_rtc_time;
-	ppc_md.set_rtc_time	= beat_set_rtc_time;
-	ppc_md.power_save	= beat_power_save;
-	ppc_md.nvram_size	= beat_nvram_get_size;
-	ppc_md.nvram_read	= beat_nvram_read;
-	ppc_md.nvram_write	= beat_nvram_write;
-	ppc_md.set_dabr		= beat_set_xdabr;
-	ppc_md.init_IRQ		= beatic_init_IRQ;
-	ppc_md.get_irq		= beatic_get_irq;
-#ifdef CONFIG_KEXEC
-	ppc_md.kexec_cpu_down	= beat_kexec_cpu_down;
-#endif
+	if (!machine_is(celleb_beat) &&
+	    !machine_is(celleb_native))
+		return -ENODEV;
+
+	/* Publish OF platform devices for southbridge IOs */
+	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
 
+	celleb_pci_workaround_init();
+
+	return 0;
+}
+device_initcall(celleb_publish_devices);
+
+
+/*
+ * functions for Celleb-Beat
+ */
+static void __init celleb_setup_arch_beat(void)
+{
 #ifdef CONFIG_SPU_BASE
 	spu_priv1_ops		= &spu_priv1_beat_ops;
 	spu_management_ops	= &spu_management_of_ops;
@@ -125,18 +138,36 @@ static void __init celleb_setup_arch_bea
 #ifdef CONFIG_SMP
 	smp_init_celleb();
 #endif
+
+	celleb_setup_arch_common();
 }
 
-static void __init celleb_setup_arch_native(void)
+static int __init celleb_probe_beat(void)
 {
-	ppc_md.restart		= rtas_restart;
-	ppc_md.power_off	= rtas_power_off;
-	ppc_md.halt		= rtas_halt;
-	ppc_md.get_boot_time	= rtas_get_boot_time;
-	ppc_md.get_rtc_time	= rtas_get_rtc_time;
-	ppc_md.set_rtc_time	= rtas_set_rtc_time;
-	ppc_md.init_IRQ		= celleb_init_IRQ_native;
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "Beat"))
+		return 0;
+
+	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS
+		| FW_FEATURE_BEAT | FW_FEATURE_LPAR;
+	hpte_init_beat_v3();
+
+	return 1;
+}
 
+
+/*
+ * functions for Celleb-native
+ */
+static void __init celleb_init_IRQ_native(void)
+{
+	iic_init_IRQ();
+	spider_init_IRQ();
+}
+
+static void __init celleb_setup_arch_native(void)
+{
 #ifdef CONFIG_SPU_BASE
 	spu_priv1_ops		= &spu_priv1_mmio_ops;
 	spu_management_ops	= &spu_management_of_ops;
@@ -153,71 +184,75 @@ static void __init celleb_setup_arch_nat
 #endif
 
 	cbe_pervasive_init();
-}
 
-static void __init celleb_setup_arch(void)
-{
-	if (firmware_has_feature(FW_FEATURE_BEAT))
-		celleb_setup_arch_beat();
-	else
-		celleb_setup_arch_native();
+	/* XXX: nvram initialization should be added */
 
-	/* init to some ~sane value until calibrate_delay() runs */
-	loops_per_jiffy = 50000000;
-
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
+	celleb_setup_arch_common();
 }
 
-static int __init celleb_probe(void)
+static int __init celleb_probe_native(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "Beat")) {
-		powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS
-			| FW_FEATURE_BEAT | FW_FEATURE_LPAR;
-		hpte_init_beat_v3();
-		return 1;
-	}
-	if (of_flat_dt_is_compatible(root, "TOSHIBA,Celleb")) {
-		powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS;
-		hpte_init_native();
-		return 1;
-	}
-
-	return 0;
-}
-
-static struct of_device_id celleb_bus_ids[] __initdata = {
-	{ .type = "scc", },
-	{ .type = "ioif", },	/* old style */
-	{},
-};
-
-static int __init celleb_publish_devices(void)
-{
-	if (!machine_is(celleb))
+	if (of_flat_dt_is_compatible(root, "Beat") ||
+	    !of_flat_dt_is_compatible(root, "TOSHIBA,Celleb"))
 		return 0;
 
-	/* Publish OF platform devices for southbridge IOs */
-	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
-
-	celleb_pci_workaround_init();
+	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS;
+	hpte_init_native();
 
-	return 0;
+	return 1;
 }
-device_initcall(celleb_publish_devices);
 
-define_machine(celleb) {
-	.name			= "Cell Reference Set",
-	.probe			= celleb_probe,
-	.setup_arch		= celleb_setup_arch,
+
+/*
+ * machine definitions
+ */
+define_machine(celleb_beat) {
+	.name			= "Cell Reference Set (Beat)",
+	.probe			= celleb_probe_beat,
+	.setup_arch		= celleb_setup_arch_beat,
+	.show_cpuinfo		= celleb_show_cpuinfo,
+	.restart		= beat_restart,
+	.power_off		= beat_power_off,
+	.halt			= beat_halt,
+	.get_rtc_time		= beat_get_rtc_time,
+	.set_rtc_time		= beat_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= celleb_progress,
+	.power_save		= beat_power_save,
+	.nvram_size		= beat_nvram_get_size,
+	.nvram_read		= beat_nvram_read,
+	.nvram_write		= beat_nvram_write,
+	.set_dabr		= beat_set_xdabr,
+	.init_IRQ		= beatic_init_IRQ,
+	.get_irq		= beatic_get_irq,
+	.pci_probe_mode 	= celleb_pci_probe_mode,
+	.pci_setup_phb		= celleb_setup_phb,
+#ifdef CONFIG_KEXEC
+	.kexec_cpu_down		= beat_kexec_cpu_down,
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};
+
+define_machine(celleb_native) {
+	.name			= "Cell Reference Set (native)",
+	.probe			= celleb_probe_native,
+	.setup_arch		= celleb_setup_arch_native,
 	.show_cpuinfo		= celleb_show_cpuinfo,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.get_boot_time		= rtas_get_boot_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= celleb_progress,
 	.pci_probe_mode 	= celleb_pci_probe_mode,
 	.pci_setup_phb		= celleb_setup_phb,
+	.init_IRQ		= celleb_init_IRQ_native,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/iommu.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c
@@ -24,7 +24,7 @@
 #include <linux/pci.h>
 
 #include <asm/of_platform.h>
-#include <asm/firmware.h>
+#include <asm/machdep.h>
 
 #include "beat_wrapper.h"
 
@@ -92,7 +92,7 @@ static struct notifier_block celleb_of_b
 
 static int __init celleb_init_iommu(void)
 {
-	if (!firmware_has_feature(FW_FEATURE_BEAT))
+	if (!machine_is(celleb_beat))
 		return -ENODEV;
 
 	celleb_init_direct_mapping();
