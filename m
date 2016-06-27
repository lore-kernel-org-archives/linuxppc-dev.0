Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRZL213rzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:34 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/38] powerpc: Put exception configuration in a common place
Date: Mon, 27 Jun 2016 21:29:11 +1000
Message-Id: <1467026976-7974-14-git-send-email-benh@kernel.crashing.org>
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

The various calls to establish exception endianness and AIL are
now done from a single point using already established CPU and FW
feature bits to decide what to do.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h        |  1 +
 arch/powerpc/kernel/setup_64.c         | 68 +++++++++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/opal.c  | 13 +++----
 arch/powerpc/platforms/pseries/setup.c | 29 ---------------
 4 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9d86c66..6135816 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -215,6 +215,7 @@ extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
 				 const char *uname, int depth, void *data);
+extern void opal_configure_cores(void);
 
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a641753..47a2706 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -69,6 +69,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
 #include <asm/livepatch.h>
+#include <asm/opal.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -205,21 +206,60 @@ static void fixup_boot_paca(void)
 	get_paca()->data_offset = 0;
 }
 
+static void configure_exceptions(void)
+{
+	/* Setup the trampolines from the lowmem exception vectors
+	 * to the kdump kernel when not using a relocatable kernel.
+	 */
+	setup_kdump_trampoline();
+
+	/* Under a PAPR hypervisor, we need hypercalls */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		long rc;
+
+		/* Enable AIL */
+		rc = pSeries_enable_reloc_on_exc();
+		if (rc == H_P2) {
+			pr_info("Relocation on exceptions not supported\n");
+		} else if (rc != H_SUCCESS) {
+			pr_warn("Unable to enable relocation on exceptions: "
+				"%ld\n", rc);
+		}
+
+		/*
+		 * Tell the hypervisor that we want our exceptions to
+		 * be taken in little endian mode. If this fails we don't
+		 * want to use BUG() because it will trigger an exception.
+		 *
+		 * We don't call this for big endian as our calling convention
+		 * makes us always enter in BE, and the call may fail under
+		 * some circumstances with kdump.
+		 */
+#ifdef __LITTLE_ENDIAN__
+		rc = pseries_little_endian_exceptions();
+		if (rc) {
+			ppc_md.progress("H_SET_MODE LE exception fail", 0);
+			panic("Could not enable little endian exceptions");
+		}
+#endif
+	} else {
+		/* Set endian mode using OPAL */
+		if (firmware_has_feature(FW_FEATURE_OPAL))
+			opal_configure_cores();
+
+		/* Enable AIL if supported, and we are in hypervisor mode */
+		if (cpu_has_feature(CPU_FTR_HVMODE) &&
+		    cpu_has_feature(CPU_FTR_ARCH_207S)) {
+			unsigned long lpcr = mfspr(SPRN_LPCR);
+			mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
+		}
+	}
+}
+
 static void cpu_ready_for_interrupts(void)
 {
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
-
-	/*
-	 * Enable AIL if supported, and we are in hypervisor mode. If we are
-	 * not in hypervisor mode, we enable relocation-on interrupts later
-	 * in pSeries_setup_arch() using the H_SET_MODE hcall.
-	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE) &&
-	    cpu_has_feature(CPU_FTR_ARCH_207S)) {
-		unsigned long lpcr = mfspr(SPRN_LPCR);
-		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
-	}
 }
 
 /*
@@ -276,10 +316,10 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Probe the machine type */
 	probe_machine();
 
-	/* Setup the trampolines from the lowmem exception vectors
-	 * to the kdump kernel when not using a relocatable kernel.
+	/* Configure exception handlers. This include setting up trampolines
+	 * if needed, setting exception endian mode, etc...
 	 */
-	setup_kdump_trampoline();
+	configure_exceptions();
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0256d07..802f3b7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -56,7 +56,7 @@ static DEFINE_SPINLOCK(opal_write_lock);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static uint32_t opal_heartbeat;
 
-static void opal_reinit_cores(void)
+void opal_configure_cores(void)
 {
 	/* Do the actual re-init, This will clobber all FPRs, VRs, etc...
 	 *
@@ -69,6 +69,10 @@ static void opal_reinit_cores(void)
 #else
 	opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_LE);
 #endif
+
+	/* Restore some bits */
+	if (cur_cpu_spec->cpu_restore)
+		cur_cpu_spec->cpu_restore();
 }
 
 int __init early_init_dt_scan_opal(unsigned long node,
@@ -105,13 +109,6 @@ int __init early_init_dt_scan_opal(unsigned long node,
 		panic("OPAL != V3 detected, no longer supported.\n");
 	}
 
-	/* Reinit all cores with the right endian */
-	opal_reinit_cores();
-
-	/* Restore some bits */
-	if (cur_cpu_spec->cpu_restore)
-		cur_cpu_spec->cpu_restore();
-
 	return 1;
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f1fe7aa..6dc91a4 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -537,18 +537,6 @@ static void __init pSeries_setup_arch(void)
 	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
-
-	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
-		long rc;
-
-		rc = pSeries_enable_reloc_on_exc();
-		if (rc == H_P2) {
-			pr_info("Relocation on exceptions not supported\n");
-		} else if (rc != H_SUCCESS) {
-			pr_warn("Unable to enable relocation on exceptions: "
-				"%ld\n", rc);
-		}
-	}
 }
 
 static int __init pSeries_init_panel(void)
@@ -751,23 +739,6 @@ static int __init pSeries_probe(void)
 
 	pr_debug("pSeries detected, looking for LPAR capability...\n");
 
-
-#ifdef __LITTLE_ENDIAN__
-	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
-		long rc;
-		/*
-		 * Tell the hypervisor that we want our exceptions to
-		 * be taken in little endian mode. If this fails we don't
-		 * want to use BUG() because it will trigger an exception.
-		 */
-		rc = pseries_little_endian_exceptions();
-		if (rc) {
-			ppc_md.progress("H_SET_MODE LE exception fail", 0);
-			panic("Could not enable little endian exceptions");
-		}
-	}
-#endif
-
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
 	else
-- 
2.7.4
