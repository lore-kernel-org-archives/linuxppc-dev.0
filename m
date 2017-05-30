Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcNvx5JWMzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:28:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v2] powerpc/64s: Add dt_cpu_ftrs boot time setup option
Date: Tue, 30 May 2017 16:28:09 +1000
Message-Id: <1496125689-27900-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
feature discovery, and fall back to the "cputable" based version.

Also allow control of advertising unknown features to userspace and
with this parameter, and remove the clunky CONFIG option.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Add explicit early check of bootargs in dt_cpu_ftrs_init()]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 +++++
 arch/powerpc/Kconfig                            |  5 ---
 arch/powerpc/kernel/dt_cpu_ftrs.c               | 57 +++++++++++++++++++++----
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 15f79c27748d..f6d8a70b68c4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -866,6 +866,16 @@
 
 	dscc4.setup=	[NET]
 
+	dt_cpu_ftrs=	[PPC]
+			Format: {"off" | "known"}
+			Control how the dt_cpu_ftrs device-tree binding is
+			used for CPU feature discovery and setup (if it
+			exists).
+			off: Do not use it, fall back to legacy cpu table.
+			known: Do not pass through unknown features to guests
+			or userspace, only those that the kernel is not aware
+			of.
+
 	dump_apple_properties	[X86]
 			Dump name and content of EFI device properties on
 			x86 Macs.  Useful for driver authors to determine
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7c8f9972f61..4a4a05afcaf7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -391,11 +391,6 @@ config PPC_DT_CPU_FTRS
 	  firmware provides this binding.
 	  If you're not sure say Y.
 
-config PPC_CPUFEATURES_ENABLE_UNKNOWN
-	bool "cpufeatures pass through unknown features to guest/userspace"
-	depends on PPC_DT_CPU_FTRS
-	default y
-
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index c92ab2f84257..4c7656dc4e04 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
+#include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
@@ -670,12 +671,24 @@ static struct dt_cpu_feature_match __initdata
 	{"wait-v3", feat_enable, 0},
 };
 
-/* XXX: how to configure this? Default + boot time? */
-#ifdef CONFIG_PPC_CPUFEATURES_ENABLE_UNKNOWN
-#define CPU_FEATURE_ENABLE_UNKNOWN 1
-#else
-#define CPU_FEATURE_ENABLE_UNKNOWN 0
-#endif
+static bool __initdata using_dt_cpu_ftrs;
+static bool __initdata enable_unknown = true;
+
+static int __init dt_cpu_ftrs_parse(char *str)
+{
+	if (!str)
+		return 0;
+
+	if (!strcmp(str, "off"))
+		using_dt_cpu_ftrs = false;
+	else if (!strcmp(str, "known"))
+		enable_unknown = false;
+	else
+		return 1;
+
+	return 0;
+}
+early_param("dt_cpu_ftrs", dt_cpu_ftrs_parse);
 
 static void __init cpufeatures_setup_start(u32 isa)
 {
@@ -706,7 +719,7 @@ static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
 		}
 	}
 
-	if (!known && CPU_FEATURE_ENABLE_UNKNOWN) {
+	if (!known && enable_unknown) {
 		if (!feat_try_enable_unknown(f)) {
 			pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
 				f->name);
@@ -755,6 +768,26 @@ static void __init cpufeatures_setup_finished(void)
 		cur_cpu_spec->cpu_features, cur_cpu_spec->mmu_features);
 }
 
+static int __init disabled_on_cmdline(void)
+{
+	unsigned long root, chosen;
+	const char *p;
+
+	root = of_get_flat_dt_root();
+	chosen = of_get_flat_dt_subnode_by_name(root, "chosen");
+	if (chosen == -FDT_ERR_NOTFOUND)
+		return false;
+
+	p = of_get_flat_dt_prop(chosen, "bootargs", NULL);
+	if (!p)
+		return false;
+
+	if (strstr(p, "dt_cpu_ftrs=off"))
+		return true;
+
+	return false;
+}
+
 static int __init fdt_find_cpu_features(unsigned long node, const char *uname,
 					int depth, void *data)
 {
@@ -765,8 +798,6 @@ static int __init fdt_find_cpu_features(unsigned long node, const char *uname,
 	return 0;
 }
 
-static bool __initdata using_dt_cpu_ftrs = false;
-
 bool __init dt_cpu_ftrs_in_use(void)
 {
 	return using_dt_cpu_ftrs;
@@ -774,6 +805,8 @@ bool __init dt_cpu_ftrs_in_use(void)
 
 bool __init dt_cpu_ftrs_init(void *fdt)
 {
+	using_dt_cpu_ftrs = false;
+
 	/* Setup and verify the FDT, if it fails we just bail */
 	if (!early_init_dt_verify(fdt))
 		return false;
@@ -781,6 +814,9 @@ bool __init dt_cpu_ftrs_init(void *fdt)
 	if (!of_scan_flat_dt(fdt_find_cpu_features, NULL))
 		return false;
 
+	if (disabled_on_cmdline())
+		return false;
+
 	cpufeatures_setup_cpu();
 
 	using_dt_cpu_ftrs = true;
@@ -1026,5 +1062,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 
 void __init dt_cpu_ftrs_scan(void)
 {
+	if (!using_dt_cpu_ftrs)
+		return;
+
 	of_scan_flat_dt(dt_cpu_ftrs_scan_callback, NULL);
 }
-- 
2.7.4
