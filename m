Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBf02cn5zDqy5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:12 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdt6JRmz9sCY
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:05 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/41] powerpc: Put exception configuration in a common place
Date: Tue,  5 Jul 2016 15:03:49 +1000
Message-Id: <1467695057-12431-14-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
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

v3: Rework a bit, move error handling in the functions themselves
and fix a few more cases of compile failures on odd configs
---
 arch/powerpc/include/asm/hvcall.h      | 11 ----
 arch/powerpc/include/asm/opal.h        |  1 +
 arch/powerpc/include/asm/setup.h       | 12 +++++
 arch/powerpc/kernel/setup_64.c         | 55 ++++++++++++++------
 arch/powerpc/kvm/book3s_pr.c           |  6 +--
 arch/powerpc/platforms/powernv/opal.c  | 13 ++---
 arch/powerpc/platforms/pseries/lpar.c  | 20 +-------
 arch/powerpc/platforms/pseries/setup.c | 92 ++++++++++++++++------------------
 8 files changed, 107 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 0bc9c28..708edeb 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -431,17 +431,6 @@ static inline unsigned long cmo_get_page_size(void)
 {
 	return CMO_PageSize;
 }
-
-extern long pSeries_enable_reloc_on_exc(void);
-extern long pSeries_disable_reloc_on_exc(void);
-
-extern long pseries_big_endian_exceptions(void);
-
-#else
-
-#define pSeries_enable_reloc_on_exc()  do {} while (0)
-#define pSeries_disable_reloc_on_exc() do {} while (0)
-
 #endif /* CONFIG_PPC_PSERIES */
 
 #endif /* __ASSEMBLY__ */
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
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index fa0687e..1ba25c8 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -30,6 +30,18 @@ void initmem_init(void);
 void setup_panic(void);
 #define ARCH_PANIC_TIMEOUT 180
 
+#ifdef CONFIG_PPC_PSERIES
+extern void pseries_enable_reloc_on_exc(void);
+extern void pseries_disable_reloc_on_exc(void);
+extern void pseries_big_endian_exceptions(void);
+extern void pseries_little_endian_exceptions(void);
+#else
+static inline void pseries_enable_reloc_on_exc(void) {}
+static inline void pseries_disable_reloc_on_exc(void) {}
+static inline void pseries_big_endian_exceptions(void) {}
+static inline void pseries_little_endian_exceptions(void) {}
+#endif /* CONFIG_PPC_PSERIES */
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a641753..978c48c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -69,6 +69,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
 #include <asm/livepatch.h>
+#include <asm/opal.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -205,21 +206,47 @@ static void fixup_boot_paca(void)
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
+		/* Enable AIL if possible */
+		pseries_enable_reloc_on_exc();
+
+		/*
+		 * Tell the hypervisor that we want our exceptions to
+		 * be taken in little endian mode.
+		 *
+		 * We don't call this for big endian as our calling convention
+		 * makes us always enter in BE, and the call may fail under
+		 * some circumstances with kdump.
+		 */
+#ifdef __LITTLE_ENDIAN__
+		pseries_little_endian_exceptions();
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
@@ -276,10 +303,10 @@ void __init early_setup(unsigned long dt_ptr)
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
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 8e4f64f..c4f7d6b 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -35,7 +35,7 @@
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
 #include <asm/firmware.h>
-#include <asm/hvcall.h>
+#include <asm/setup.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
@@ -1690,7 +1690,7 @@ static int kvmppc_core_init_vm_pr(struct kvm *kvm)
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		spin_lock(&kvm_global_user_count_lock);
 		if (++kvm_global_user_count == 1)
-			pSeries_disable_reloc_on_exc();
+			pseries_disable_reloc_on_exc();
 		spin_unlock(&kvm_global_user_count_lock);
 	}
 	return 0;
@@ -1706,7 +1706,7 @@ static void kvmppc_core_destroy_vm_pr(struct kvm *kvm)
 		spin_lock(&kvm_global_user_count_lock);
 		BUG_ON(kvm_global_user_count == 0);
 		if (--kvm_global_user_count == 0)
-			pSeries_enable_reloc_on_exc();
+			pseries_enable_reloc_on_exc();
 		spin_unlock(&kvm_global_user_count_lock);
 	}
 }
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
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 7f6100d..eb2374e 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -260,24 +260,8 @@ static void pSeries_lpar_hptab_clear(void)
 	 * This is also called on boot when a fadump happens. In that case we
 	 * must not change the exception endian mode.
 	 */
-	if (firmware_has_feature(FW_FEATURE_SET_MODE) && !is_fadump_active()) {
-		long rc;
-
-		rc = pseries_big_endian_exceptions();
-		/*
-		 * At this point it is unlikely panic() will get anything
-		 * out to the user, but at least this will stop us from
-		 * continuing on further and creating an even more
-		 * difficult to debug situation.
-		 *
-		 * There is a known problem when kdump'ing, if cpus are offline
-		 * the above call will fail. Rather than panicking again, keep
-		 * going and hope the kdump kernel is also little endian, which
-		 * it usually is.
-		 */
-		if (rc && !kdump_in_progress())
-			panic("Could not enable big endian exceptions");
-	}
+	if (firmware_has_feature(FW_FEATURE_SET_MODE) && !is_fadump_active())
+		pseries_big_endian_exceptions();
 #endif
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f1fe7aa..1543be0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -392,15 +392,23 @@ static void pseries_lpar_idle(void)
  * to ever be a problem in practice we can move this into a kernel thread to
  * finish off the process later in boot.
  */
-long pSeries_enable_reloc_on_exc(void)
+void pseries_enable_reloc_on_exc(void)
 {
 	long rc;
 	unsigned int delay, total_delay = 0;
 
 	while (1) {
 		rc = enable_reloc_on_exceptions();
-		if (!H_IS_LONG_BUSY(rc))
-			return rc;
+		if (!H_IS_LONG_BUSY(rc)) {
+			if (rc == H_P2) {
+				pr_info("Relocation on exceptions not"
+					" supported\n");
+			} else if (rc != H_SUCCESS) {
+				pr_warn("Unable to enable relocation"
+					" on exceptions: %ld\n", rc);
+			}
+			break;
+		}
 
 		delay = get_longbusy_msecs(rc);
 		total_delay += delay;
@@ -408,66 +416,81 @@ long pSeries_enable_reloc_on_exc(void)
 			pr_warn("Warning: Giving up waiting to enable "
 				"relocation on exceptions (%u msec)!\n",
 				total_delay);
-			return rc;
+			return;
 		}
 
 		mdelay(delay);
 	}
 }
-EXPORT_SYMBOL(pSeries_enable_reloc_on_exc);
+EXPORT_SYMBOL(pseries_enable_reloc_on_exc);
 
-long pSeries_disable_reloc_on_exc(void)
+void pseries_disable_reloc_on_exc(void)
 {
 	long rc;
 
 	while (1) {
 		rc = disable_reloc_on_exceptions();
 		if (!H_IS_LONG_BUSY(rc))
-			return rc;
+			break;
 		mdelay(get_longbusy_msecs(rc));
 	}
+	if (rc != H_SUCCESS)
+		pr_warning("Warning: Failed to disable relocation on "
+			   "exceptions: %ld\n", rc);
 }
-EXPORT_SYMBOL(pSeries_disable_reloc_on_exc);
+EXPORT_SYMBOL(pseries_disable_reloc_on_exc);
 
 #ifdef CONFIG_KEXEC
 static void pSeries_machine_kexec(struct kimage *image)
 {
-	long rc;
-
-	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
-		rc = pSeries_disable_reloc_on_exc();
-		if (rc != H_SUCCESS)
-			pr_warning("Warning: Failed to disable relocation on "
-				   "exceptions: %ld\n", rc);
-	}
+	if (firmware_has_feature(FW_FEATURE_SET_MODE))
+		pseries_disable_reloc_on_exc();
 
 	default_machine_kexec(image);
 }
 #endif
 
 #ifdef __LITTLE_ENDIAN__
-long pseries_big_endian_exceptions(void)
+void pseries_big_endian_exceptions(void)
 {
 	long rc;
 
 	while (1) {
 		rc = enable_big_endian_exceptions();
 		if (!H_IS_LONG_BUSY(rc))
-			return rc;
+			break;
 		mdelay(get_longbusy_msecs(rc));
 	}
+
+	/*
+	 * At this point it is unlikely panic() will get anything
+	 * out to the user, since this is called very late in kexec
+	 * but at least this will stop us from continuing on further
+	 * and creating an even more difficult to debug situation.
+	 *
+	 * There is a known problem when kdump'ing, if cpus are offline
+	 * the above call will fail. Rather than panicking again, keep
+	 * going and hope the kdump kernel is also little endian, which
+	 * it usually is.
+	 */
+	if (rc && !kdump_in_progress())
+		panic("Could not enable big endian exceptions");
 }
 
-static long pseries_little_endian_exceptions(void)
+void pseries_little_endian_exceptions(void)
 {
 	long rc;
 
 	while (1) {
 		rc = enable_little_endian_exceptions();
 		if (!H_IS_LONG_BUSY(rc))
-			return rc;
+			break;
 		mdelay(get_longbusy_msecs(rc));
 	}
+	if (rc) {
+		ppc_md.progress("H_SET_MODE LE exception fail", 0);
+		panic("Could not enable little endian exceptions");
+	}
 }
 #endif
 
@@ -537,18 +560,6 @@ static void __init pSeries_setup_arch(void)
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
@@ -751,23 +762,6 @@ static int __init pSeries_probe(void)
 
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
