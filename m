Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWQpN5MQ3zDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 00:35:56 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s67so9575545pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 05:35:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC][PATCH] powerpc: use ibm,tlb-congruence-classes dt if it exists
Date: Sun, 26 Feb 2017 23:35:41 +1000
Message-Id: <20170226133541.14278-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the open-coding of radix set sizes for loops. Populate the
cputable with the correct values for old firmware, but override it
with the device-tree property if that exists.

This goes with the skiboot patch posted earlier.

Thanks,
Nick
---
 arch/powerpc/include/asm/cputable.h | 11 +++++----
 arch/powerpc/include/asm/mce.h      |  5 +++++
 arch/powerpc/kernel/cputable.c      | 25 ++++++++++-----------
 arch/powerpc/kernel/mce_power.c     | 45 +++++++++----------------------------
 arch/powerpc/kernel/prom.c          | 21 +++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c        |  7 +-----
 arch/powerpc/kvm/book3s_hv_ras.c    |  6 ++---
 arch/powerpc/mm/init_64.c           |  7 ++++--
 arch/powerpc/mm/tlb-radix.c         |  2 +-
 9 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ab68d0ee7725..033c071a3836 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -62,6 +62,11 @@ struct cpu_spec {
 	unsigned int	cpu_user_features2;	/* Userland features v2 */
 	unsigned int	mmu_features;		/* MMU features */
 
+	/* Number of sets/congruence classes for tlbie invalidation */
+	unsigned int	tlb_sets;		/* set to current MMU mode */
+	unsigned int	tlb_hash_sets;
+	unsigned int	tlb_radix_sets;
+
 	/* cache line sizes */
 	unsigned int	icache_bsize;
 	unsigned int	dcache_bsize;
@@ -106,12 +111,6 @@ struct cpu_spec {
 	 * called in real mode to handle SLB and TLB errors.
 	 */
 	long		(*machine_check_early)(struct pt_regs *regs);
-
-	/*
-	 * Processor specific routine to flush tlbs.
-	 */
-	void		(*flush_tlb)(unsigned int action);
-
 };
 
 extern struct cpu_spec		*cur_cpu_spec;
diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index f97d8cb6bdf6..e26ca0b29d75 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -195,4 +195,9 @@ extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt);
 extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
 
+/*
+ * TLB flush for POWER7 and later
+ */
+extern void machine_check_flush_tlb(unsigned int action);
+
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6a82ef039c50..e39f64ad1da2 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -72,9 +72,6 @@ extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
 extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power9(void);
-extern void __flush_tlb_power7(unsigned int action);
-extern void __flush_tlb_power8(unsigned int action);
-extern void __flush_tlb_power9(unsigned int action);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
@@ -358,13 +355,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlb_hash_sets		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -376,13 +373,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_hash_sets		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -394,6 +391,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlb_hash_sets		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -402,7 +400,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -414,6 +411,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlb_hash_sets		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -422,7 +420,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7+",
 	},
@@ -434,6 +431,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_hash_sets		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -442,7 +440,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -454,6 +451,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_hash_sets		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -462,7 +460,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -474,6 +471,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_hash_sets		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -482,7 +480,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -494,6 +491,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_hash_sets		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -502,7 +500,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -514,6 +511,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
+		.tlb_hash_sets		= POWER9_TLB_SETS_HASH,
+		.tlb_radix_sets		= POWER9_TLB_SETS_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -522,7 +521,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
 	{	/* Power9 */
@@ -533,6 +531,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
+		.tlb_hash_sets		= POWER9_TLB_SETS_HASH,
+		.tlb_radix_sets		= POWER9_TLB_SETS_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -541,7 +541,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
 	{	/* Cell Broadband Engine */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 7353991c4ece..2486b9364b4f 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -28,7 +28,13 @@
 #include <asm/mce.h>
 #include <asm/machdep.h>
 
-static void flush_tlb_206(unsigned int num_sets, unsigned int action)
+/*
+ * Generic routine to flush TLB on POWER7 and later processors.
+ *
+ * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
+ *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
+ */
+void machine_check_flush_tlb(unsigned int action)
 {
 	unsigned long rb;
 	unsigned int i;
@@ -46,39 +52,13 @@ static void flush_tlb_206(unsigned int num_sets, unsigned int action)
 	}
 
 	asm volatile("ptesync" : : : "memory");
-	for (i = 0; i < num_sets; i++) {
+	for (i = 0; i < cur_cpu_spec->tlb_sets; i++) {
 		asm volatile("tlbiel %0" : : "r" (rb));
 		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
 	}
 	asm volatile("ptesync" : : : "memory");
 }
 
-/*
- * Generic routines to flush TLB on POWER processors. These routines
- * are used as flush_tlb hook in the cpu_spec.
- *
- * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
- *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
- */
-void __flush_tlb_power7(unsigned int action)
-{
-	flush_tlb_206(POWER7_TLB_SETS, action);
-}
-
-void __flush_tlb_power8(unsigned int action)
-{
-	flush_tlb_206(POWER8_TLB_SETS, action);
-}
-
-void __flush_tlb_power9(unsigned int action)
-{
-	if (radix_enabled())
-		flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
-
-	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
-}
-
-
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_STD_MMU_64
 static void flush_and_reload_slb(void)
@@ -132,8 +112,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 		dsisr &= ~(slb_error_bits);
 	}
 	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
+		machine_check_flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
 		/* reset error bits */
 		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
 	}
@@ -165,10 +144,8 @@ static long mce_handle_common_ierror(uint64_t srr1)
 		handled = 1;
 		break;
 	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-			handled = 1;
-		}
+		machine_check_flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
+		handled = 1;
 		break;
 #endif
 	default:
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f5d399e46193..0b7f127ed33d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -237,8 +237,27 @@ static void __init init_mmu_slb_size(unsigned long node)
 	if (slb_size_ptr)
 		mmu_slb_size = be32_to_cpup(slb_size_ptr);
 }
+static void __init init_mmu_tlb_hash_sets(unsigned long node)
+{
+	const __be32 *ptr;
+
+	ptr = of_get_flat_dt_prop(node, "ibm,tlb-congruence-classes", NULL);
+	if (ptr)
+		cur_cpu_spec->tlb_hash_sets = be32_to_cpup(ptr);
+}
+
+static void __init init_mmu_tlb_radix_sets(unsigned long node)
+{
+	const __be32 *ptr;
+
+	ptr = of_get_flat_dt_prop(node, "ibm,tlb-radix-congruence-classes", NULL);
+	if (ptr)
+		cur_cpu_spec->tlb_radix_sets = be32_to_cpup(ptr);
+}
 #else
 #define init_mmu_slb_size(node) do { } while(0)
+#define init_mmu_hash_sets(node) do { } while(0)
+#define init_mmu_radix_sets(node) do { } while(0)
 #endif
 
 static struct feature_property {
@@ -386,6 +405,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	check_cpu_feature_properties(node);
 	check_cpu_pa_features(node);
 	init_mmu_slb_size(node);
+	init_mmu_tlb_hash_sets(node);
+	init_mmu_tlb_radix_sets(node);
 
 #ifdef CONFIG_PPC64
 	if (nthreads > 1)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ec34e39471a7..c1426623a276 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3315,12 +3315,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	 * Work out how many sets the TLB has, for the use of
 	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
 	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		kvm->arch.tlb_sets = POWER9_TLB_SETS_HASH;	/* 256 */
-	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		kvm->arch.tlb_sets = POWER8_TLB_SETS;		/* 512 */
-	else
-		kvm->arch.tlb_sets = POWER7_TLB_SETS;		/* 128 */
+	kvm->arch.tlb_sets = cur_cpu_spec->tlb_sets;
 
 	/*
 	 * Track that we now have a HV mode VM active. This blocks secondary
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 7ef0993214f3..f62798ce304b 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -87,8 +87,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
 		}
 		if (dsisr & DSISR_MC_TLB_MULTI) {
-			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
+			machine_check_flush_tlb(TLB_INVAL_SCOPE_LPID);
 			dsisr &= ~DSISR_MC_TLB_MULTI;
 		}
 		/* Any other errors we don't understand? */
@@ -105,8 +104,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		reload_slb(vcpu);
 		break;
 	case SRR1_MC_IFETCH_TLBMULTI:
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
+		machine_check_flush_tlb(TLB_INVAL_SCOPE_LPID);
 		break;
 	default:
 		handled = 0;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 93abf8a9813d..88d76fec13ea 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -350,9 +350,12 @@ void __init mmu_early_init_devtree(void)
 	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
-	if (early_radix_enabled())
+	if (early_radix_enabled()) {
+		cur_cpu_spec->tlb_sets = cur_cpu_spec->tlb_radix_sets;
 		radix__early_init_devtree();
-	else
+	} else {
+		cur_cpu_spec->tlb_sets = cur_cpu_spec->tlb_hash_sets;
 		hash__early_init_devtree();
+	}
 }
 #endif /* CONFIG_PPC_STD_MMU_64 */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 952713d6cf04..b5dd79f0275d 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -47,7 +47,7 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
-	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
+	for (set = 0; set < cur_cpu_spec->tlb_sets; set++) {
 		__tlbiel_pid(pid, set, ric);
 	}
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
-- 
2.11.0
