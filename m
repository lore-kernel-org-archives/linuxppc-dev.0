Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 735231A0192
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 14:43:33 +1000 (EST)
Date: Tue, 5 Aug 2014 14:43:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc: Remove powerpc specific cmd_line
Message-ID: <20140805144334.38512d09@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need for yet another copy of the command line, just
use boot_command_line like everyone else.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/machdep.h
===================================================================
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -326,8 +326,6 @@ extern struct machdep_calls *machine_id;
 
 extern void probe_machine(void);
 
-extern char cmd_line[COMMAND_LINE_SIZE];
-
 #ifdef CONFIG_PPC_PMAC
 /*
  * Power macintoshes have either a CUDA, PMU or SMU controlling
Index: b/arch/powerpc/kernel/prom.c
===================================================================
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -665,14 +665,12 @@ void __init early_init_devtree(void *par
 	 * device-tree, including the platform type, initrd location and
 	 * size, TCE reserve, and more ...
 	 */
-	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, cmd_line);
+	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
-	/* Save command line for /proc/cmdline and then parse parameters */
-	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	/* make sure we've parsed cmdline for mem= before this */
Index: b/arch/powerpc/kernel/setup-common.c
===================================================================
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -81,8 +81,6 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
 
 unsigned long klimit = (unsigned long) _end;
 
-char cmd_line[COMMAND_LINE_SIZE];
-
 /*
  * This still seems to be needed... -- paulus
  */ 
Index: b/arch/powerpc/kernel/setup_32.c
===================================================================
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -268,7 +268,7 @@ static void __init exc_lvl_early_init(vo
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
-	*cmdline_p = cmd_line;
+	*cmdline_p = boot_command_line;
 
 	/* so udelay does something sensible, assume <= 1000 bogomips */
 	loops_per_jiffy = 500000000 / HZ;
Index: b/arch/powerpc/kernel/setup_64.c
===================================================================
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -653,7 +653,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	ppc64_boot_msg(0x12, "Setup Arch");
 
-	*cmdline_p = cmd_line;
+	*cmdline_p = boot_command_line;
 
 	/*
 	 * Set cache line size based on type of cpu as a default.
Index: b/arch/powerpc/mm/init_32.c
===================================================================
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -106,11 +106,11 @@ unsigned long __max_low_memory = MAX_LOW
 void MMU_setup(void)
 {
 	/* Check for nobats option (used in mapin_ram). */
-	if (strstr(cmd_line, "nobats")) {
+	if (strstr(boot_command_line, "nobats")) {
 		__map_without_bats = 1;
 	}
 
-	if (strstr(cmd_line, "noltlbs")) {
+	if (strstr(boot_command_line, "noltlbs")) {
 		__map_without_ltlbs = 1;
 	}
 #ifdef CONFIG_DEBUG_PAGEALLOC
Index: b/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -258,7 +258,7 @@ static void chrp_init_early(void)
 	struct device_node *node;
 	const char *property;
 
-	if (strstr(cmd_line, "console="))
+	if (strstr(boot_command_line, "console="))
 		return;
 	/* find the boot console from /chosen/stdout */
 	if (!of_chosen)
Index: b/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -336,7 +336,7 @@ static void __init pmac_setup_arch(void)
 #endif
 
 #ifdef CONFIG_ADB
-	if (strstr(cmd_line, "adb_sync")) {
+	if (strstr(boot_command_line, "adb_sync")) {
 		extern int __adb_probe_sync;
 		__adb_probe_sync = 1;
 	}
@@ -460,7 +460,7 @@ pmac_halt(void)
 static void __init pmac_init_early(void)
 {
 	/* Enable early btext debug if requested */
-	if (strstr(cmd_line, "btextdbg")) {
+	if (strstr(boot_command_line, "btextdbg")) {
 		udbg_adb_init_early();
 		register_early_udbg_console();
 	}
@@ -469,8 +469,8 @@ static void __init pmac_init_early(void)
 	pmac_feature_init();
 
 	/* Initialize debug stuff */
-	udbg_scc_init(!!strstr(cmd_line, "sccdbg"));
-	udbg_adb_init(!!strstr(cmd_line, "btextdbg"));
+	udbg_scc_init(!!strstr(boot_command_line, "sccdbg"));
+	udbg_adb_init(!!strstr(boot_command_line, "btextdbg"));
 
 #ifdef CONFIG_PPC64
 	iommu_init_early_dart();
Index: b/drivers/cpufreq/pmac32-cpufreq.c
===================================================================
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -611,7 +611,7 @@ static int __init pmac_cpufreq_setup(voi
 	struct device_node	*cpunode;
 	const u32		*value;
 
-	if (strstr(cmd_line, "nocpufreq"))
+	if (strstr(boot_command_line, "nocpufreq"))
 		return 0;
 
 	/* Get first CPU node */
Index: b/drivers/tty/hvc/hvc_vio.c
===================================================================
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -459,7 +459,7 @@ void __init hvc_vio_init_early(void)
 		goto out;
 #endif
 	/* Check whether the user has requested a different console. */
-	if (!strstr(cmd_line, "console="))
+	if (!strstr(boot_command_line, "console="))
 		add_preferred_console("hvc", 0, NULL);
 	hvc_instantiate(0, 0, ops);
 out:
