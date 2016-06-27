Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSxX5wH9zDsRq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:32:16 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 33/38] powerpc/64: Move the content of setup_system() to
 setup_arch()
Date: Mon, 27 Jun 2016 21:29:31 +1000
Message-Id: <1467026976-7974-34-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And kill setup_system()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/head_64.S  |   5 +-
 arch/powerpc/kernel/setup_64.c | 137 +++++++++++++++++++----------------------
 2 files changed, 64 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2d14774..3109d0c 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -941,7 +941,7 @@ start_here_multiplatform:
 	mtspr	SPRN_SRR1,r4
 	RFI
 	b	.	/* prevent speculative execution */
-	
+
 	/* This is where all platforms converge execution */
 
 start_here_common:
@@ -951,9 +951,6 @@ start_here_common:
 	/* Load the TOC (virtual address) */
 	ld	r2,PACATOC(r13)
 
-	/* Do more system initializations in virtual mode */
-	bl	setup_system
-
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 29bbe8c..108035b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -523,80 +523,6 @@ static __init void print_system_info(void)
 	pr_info("-----------------------------------------------------\n");
 }
 
-/*
- * Do some initial setup of the system.  The parameters are those which 
- * were passed in from the bootloader.
- */
-void __init setup_system(void)
-{
-	DBG(" -> setup_system()\n");
-
-	/*
-	 * Unflatten the device-tree passed by prom_init or kexec
-	 */
-	unflatten_device_tree();
-
-	/*
-	 * Fill the ppc64_caches & systemcfg structures with informations
- 	 * retrieved from the device-tree.
-	 */
-	initialize_cache_info();
-
-#ifdef CONFIG_PPC_RTAS
-	/*
-	 * Initialize RTAS if available
-	 */
-	rtas_initialize();
-#endif /* CONFIG_PPC_RTAS */
-
-	/*
-	 * Check if we have an initrd provided via the device-tree
-	 */
-	check_for_initrd();
-
-	/* Probe the machine type */
-	probe_machine();
-
- 	/*
-	 * We can discover serial ports now since the above did setup the
-	 * hash table management for us, thus ioremap works. We do that early
-	 * so that further code can be debugged
-	 */
-	find_legacy_serial_ports();
-
-	/*
-	 * Register early console
-	 */
-	register_early_udbg_console();
-
-	/*
-	 * Initialize xmon
-	 */
-	xmon_setup();
-
-	smp_setup_cpu_maps();
-	check_smt_enabled();
-	setup_tlb_core_data();
-
-	/*
-	 * Freescale Book3e parts spin in a loop provided by firmware,
-	 * so smp_release_cpus() does nothing for them
-	 */
-#if defined(CONFIG_SMP)
-	/* Release secondary cpus out of their spinloops at 0x60 now that
-	 * we can map physical -> logical CPU ids
-	 */
-	smp_release_cpus();
-#endif
-
-	/* Print various info about the machine that gave been gathered
-	 * so far
-	 */
-	print_system_info();
-
-	DBG(" <- setup_system()\n");
-}
-
 /* This returns the limit below which memory accesses to the linear
  * mapping are guarnateed not to cause a TLB or SLB miss. This is
  * used to allocate interrupt or emergency stacks for which our
@@ -708,6 +634,69 @@ void __init setup_arch(char **cmdline_p)
 {
 	*cmdline_p = boot_command_line;
 
+	/*
+	 * Unflatten the device-tree passed by prom_init or kexec
+	 */
+	unflatten_device_tree();
+
+	/*
+	 * Fill the ppc64_caches & systemcfg structures with informations
+ 	 * retrieved from the device-tree.
+	 */
+	initialize_cache_info();
+
+#ifdef CONFIG_PPC_RTAS
+	/*
+	 * Initialize RTAS if available
+	 */
+	rtas_initialize();
+#endif /* CONFIG_PPC_RTAS */
+
+	/*
+	 * Check if we have an initrd provided via the device-tree
+	 */
+	check_for_initrd();
+
+	/* Probe the machine type */
+	probe_machine();
+
+ 	/*
+	 * We can discover serial ports now since the above did setup the
+	 * hash table management for us, thus ioremap works. We do that early
+	 * so that further code can be debugged
+	 */
+	find_legacy_serial_ports();
+
+	/*
+	 * Register early console
+	 */
+	register_early_udbg_console();
+
+	/*
+	 * Initialize xmon
+	 */
+	xmon_setup();
+
+	smp_setup_cpu_maps();
+	check_smt_enabled();
+	setup_tlb_core_data();
+
+	/*
+	 * Freescale Book3e parts spin in a loop provided by firmware,
+	 * so smp_release_cpus() does nothing for them
+	 */
+#if defined(CONFIG_SMP)
+	/* Release secondary cpus out of their spinloops at 0x60 now that
+	 * we can map physical -> logical CPU ids
+	 */
+	smp_release_cpus();
+#endif
+
+	/* Print various info about the machine that gave been gathered
+	 * so far
+	 */
+	print_system_info();
+
 	/* Reserve large chunks of memory for use by CMA for KVM */
 	kvm_cma_reserve();
 
-- 
2.7.4
