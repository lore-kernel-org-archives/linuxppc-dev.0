Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56C261A090A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:39:44 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 3/6] powerpc: Remove powerpc specific cmd_line
Date: Wed, 17 Sep 2014 14:39:36 +1000
Message-Id: <1410928779-20938-3-git-send-email-anton@samba.org>
In-Reply-To: <1410928779-20938-1-git-send-email-anton@samba.org>
References: <1410928779-20938-1-git-send-email-anton@samba.org>
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
 arch/powerpc/include/asm/machdep.h      | 2 --
 arch/powerpc/kernel/prom.c              | 4 +---
 arch/powerpc/kernel/setup-common.c      | 2 --
 arch/powerpc/kernel/setup_32.c          | 2 +-
 arch/powerpc/kernel/setup_64.c          | 2 +-
 arch/powerpc/mm/init_32.c               | 4 ++--
 arch/powerpc/platforms/chrp/setup.c     | 2 +-
 arch/powerpc/platforms/powermac/setup.c | 8 ++++----
 drivers/cpufreq/pmac32-cpufreq.c        | 2 +-
 drivers/tty/hvc/hvc_vio.c               | 2 +-
 10 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index b125cea..902ab20 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -330,8 +330,6 @@ extern struct machdep_calls *machine_id;
 
 extern void probe_machine(void);
 
-extern char cmd_line[COMMAND_LINE_SIZE];
-
 #ifdef CONFIG_PPC_PMAC
 /*
  * Power macintoshes have either a CUDA, PMU or SMU controlling
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5957625..099f27e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -668,14 +668,12 @@ void __init early_init_devtree(void *params)
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
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index c933acd..0df37f5 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -81,8 +81,6 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
 
 unsigned long klimit = (unsigned long) _end;
 
-char cmd_line[COMMAND_LINE_SIZE];
-
 /*
  * This still seems to be needed... -- paulus
  */ 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ea4fda6..07831ed 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -268,7 +268,7 @@ static void __init exc_lvl_early_init(void)
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
-	*cmdline_p = cmd_line;
+	*cmdline_p = boot_command_line;
 
 	/* so udelay does something sensible, assume <= 1000 bogomips */
 	loops_per_jiffy = 500000000 / HZ;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index fa17c94..a3ba9d0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -657,7 +657,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	ppc64_boot_msg(0x12, "Setup Arch");
 
-	*cmdline_p = cmd_line;
+	*cmdline_p = boot_command_line;
 
 	/*
 	 * Set cache line size based on type of cpu as a default.
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index cff59f1..cad68ff 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -106,11 +106,11 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
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
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 7044fd3..5b77b19 100644
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
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 141f8899..b127a29 100644
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
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 7615180..1f49d97 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -611,7 +611,7 @@ static int __init pmac_cpufreq_setup(void)
 	struct device_node	*cpunode;
 	const u32		*value;
 
-	if (strstr(cmd_line, "nocpufreq"))
+	if (strstr(boot_command_line, "nocpufreq"))
 		return 0;
 
 	/* Get first CPU node */
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 5618b5f..f575a9b 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -452,7 +452,7 @@ void __init hvc_vio_init_early(void)
 		return;
 #endif
 	/* Check whether the user has requested a different console. */
-	if (!strstr(cmd_line, "console="))
+	if (!strstr(boot_command_line, "console="))
 		add_preferred_console("hvc", 0, NULL);
 	hvc_instantiate(0, 0, ops);
 }
-- 
1.9.1
