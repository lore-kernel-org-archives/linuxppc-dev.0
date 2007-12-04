Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F4C9DDE0C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 19:38:35 +1100 (EST)
Date: Tue, 04 Dec 2007 17:38:24 +0900 (JST)
Message-Id: <20071204.173824.-1350527485.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 2/3] celleb: add supporting for native CBE
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds supporting for native CBE on Celleb.  Many codes in
platforms/cell/ are used when native CBE environment.

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-powerpc-git/arch/powerpc/platforms/cell/iommu.c
@@ -34,6 +34,7 @@
 #include <asm/udbg.h>
 #include <asm/of_platform.h>
 #include <asm/lmb.h>
+#include <asm/firmware.h>
 #include <asm/cell-regs.h>
 
 #include "interrupt.h"
@@ -699,7 +700,8 @@ static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
 
-	if (!machine_is(cell))
+	if ((!machine_is(cell) && !machine_is(celleb)) ||
+	    firmware_has_feature(FW_FEATURE_LPAR))
 		return -ENODEV;
 
 	/* If IOMMU is disabled or we have little enough RAM to not need
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Kconfig
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/Kconfig
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Kconfig
@@ -2,6 +2,8 @@ config PPC_CELLEB
 	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
+	select PPC_CELL_NATIVE
+	select PPC_RTAS
 	select PPC_INDIRECT_IO
 	select PPC_OF_PLATFORM_PCI
 	select HAS_TXX9_SERIAL
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/iommu.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 
 #include <asm/of_platform.h>
+#include <asm/firmware.h>
 
 #include "beat_wrapper.h"
 
@@ -91,7 +92,7 @@ static struct notifier_block celleb_of_b
 
 static int __init celleb_init_iommu(void)
 {
-	if (!machine_is(celleb))
+	if (!firmware_has_feature(FW_FEATURE_BEAT))
 		return -ENODEV;
 
 	celleb_init_direct_mapping();
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
@@ -53,11 +53,16 @@
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
 #include <asm/of_platform.h>
+#include <asm/rtas.h>
+#include <asm/cell-regs.h>
 
 #include "interrupt.h"
 #include "beat_wrapper.h"
 #include "beat.h"
 #include "pci.h"
+#include "../cell/interrupt.h"
+#include "../cell/pervasive.h"
+#include "../cell/ras.h"
 
 static char celleb_machine_type[128] = "Celleb";
 
@@ -88,16 +93,74 @@ static void celleb_progress(char *s, uns
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static void __init celleb_setup_arch(void)
+static void __init celleb_init_IRQ_native(void)
+{
+	iic_init_IRQ();
+	spider_init_IRQ();
+}
+
+static void __init celleb_setup_arch_beat(void)
 {
+	ppc_md.restart		= beat_restart;
+	ppc_md.power_off	= beat_power_off;
+	ppc_md.halt		= beat_halt;
+	ppc_md.get_rtc_time	= beat_get_rtc_time;
+	ppc_md.set_rtc_time	= beat_set_rtc_time;
+	ppc_md.power_save	= beat_power_save;
+	ppc_md.nvram_size	= beat_nvram_get_size;
+	ppc_md.nvram_read	= beat_nvram_read;
+	ppc_md.nvram_write	= beat_nvram_write;
+	ppc_md.set_dabr		= beat_set_xdabr;
+	ppc_md.init_IRQ		= beatic_init_IRQ;
+	ppc_md.get_irq		= beatic_get_irq;
+#ifdef CONFIG_KEXEC
+	ppc_md.kexec_cpu_down	= beat_kexec_cpu_down;
+#endif
+
 #ifdef CONFIG_SPU_BASE
-	spu_priv1_ops = &spu_priv1_beat_ops;
-	spu_management_ops = &spu_management_of_ops;
+	spu_priv1_ops		= &spu_priv1_beat_ops;
+	spu_management_ops	= &spu_management_of_ops;
 #endif
 
 #ifdef CONFIG_SMP
 	smp_init_celleb();
 #endif
+}
+
+static void __init celleb_setup_arch_native(void)
+{
+	ppc_md.restart		= rtas_restart;
+	ppc_md.power_off	= rtas_power_off;
+	ppc_md.halt		= rtas_halt;
+	ppc_md.get_boot_time	= rtas_get_boot_time;
+	ppc_md.get_rtc_time	= rtas_get_rtc_time;
+	ppc_md.set_rtc_time	= rtas_set_rtc_time;
+	ppc_md.init_IRQ		= celleb_init_IRQ_native;
+
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops		= &spu_priv1_mmio_ops;
+	spu_management_ops	= &spu_management_of_ops;
+#endif
+
+	cbe_regs_init();
+
+#ifdef CONFIG_CBE_RAS
+	cbe_ras_init();
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_cell();
+#endif
+
+	cbe_pervasive_init();
+}
+
+static void __init celleb_setup_arch(void)
+{
+	if (firmware_has_feature(FW_FEATURE_BEAT))
+		celleb_setup_arch_beat();
+	else
+		celleb_setup_arch_native();
 
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
@@ -111,12 +174,19 @@ static int __init celleb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (!of_flat_dt_is_compatible(root, "Beat"))
-		return 0;
+	if (of_flat_dt_is_compatible(root, "Beat")) {
+		powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS
+			| FW_FEATURE_BEAT | FW_FEATURE_LPAR;
+		hpte_init_beat_v3();
+		return 1;
+	}
+	if (of_flat_dt_is_compatible(root, "TOSHIBA,Celleb")) {
+		powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS;
+		hpte_init_native();
+		return 1;
+	}
 
-	powerpc_firmware_features |= FW_FEATURE_CELLEB_POSSIBLE;
-	hpte_init_beat_v3();
-	return 1;
+	return 0;
 }
 
 static struct of_device_id celleb_bus_ids[] __initdata = {
@@ -144,24 +214,11 @@ define_machine(celleb) {
 	.probe			= celleb_probe,
 	.setup_arch		= celleb_setup_arch,
 	.show_cpuinfo		= celleb_show_cpuinfo,
-	.restart		= beat_restart,
-	.power_off		= beat_power_off,
-	.halt			= beat_halt,
-	.get_rtc_time		= beat_get_rtc_time,
-	.set_rtc_time		= beat_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= celleb_progress,
-	.power_save		= beat_power_save,
-	.nvram_size		= beat_nvram_get_size,
-	.nvram_read		= beat_nvram_read,
-	.nvram_write		= beat_nvram_write,
-	.set_dabr		= beat_set_xdabr,
-	.init_IRQ		= beatic_init_IRQ,
-	.get_irq		= beatic_get_irq,
 	.pci_probe_mode 	= celleb_pci_probe_mode,
 	.pci_setup_phb		= celleb_setup_phb,
 #ifdef CONFIG_KEXEC
-	.kexec_cpu_down		= beat_kexec_cpu_down,
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
 	.machine_crash_shutdown	= default_machine_crash_shutdown,
Index: linux-powerpc-git/include/asm-powerpc/firmware.h
===================================================================
--- linux-powerpc-git.orig/include/asm-powerpc/firmware.h
+++ linux-powerpc-git/include/asm-powerpc/firmware.h
@@ -64,7 +64,7 @@ enum {
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_BEAT,
-	FW_FEATURE_CELLEB_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_BEAT,
+	FW_FEATURE_CELLEB_ALWAYS = 0,
 	FW_FEATURE_NATIVE_POSSIBLE = 0,
 	FW_FEATURE_NATIVE_ALWAYS = 0,
 	FW_FEATURE_POSSIBLE =
