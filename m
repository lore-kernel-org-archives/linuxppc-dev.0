Return-Path: <npiggin@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8vPw0mq7zDqG3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 10:59:16 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id h41so35244237ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 17:59:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: use ibm,
 tlbiel-congruence-classes-(hash|radix) dt property
Date: Sat, 22 Apr 2017 10:58:54 +1000
Message-Id: <20170422005854.17128-2-npiggin@gmail.com>
In-Reply-To: <20170422005854.17128-1-npiggin@gmail.com>
References: <20170422005854.17128-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tlbiel instruction with IS!=0 on POWER7 and later Book3s CPUs invalidate
TLBs belonging to a specified congruence class. In order to operate on
the entire TLB, all congruence classes must be specified, requiring a
software loop.

This dt property specifies the number of classes that must be operated
on. Use this to set tlbiel loop counts. If the property does not exist,
fall back to hard coded values based on the cpu table.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h | 14 +++++------
 arch/powerpc/include/asm/mce.h      |  5 ++++
 arch/powerpc/kernel/cputable.c      | 26 ++++++++++-----------
 arch/powerpc/kernel/mce_power.c     | 46 ++++++++-----------------------------
 arch/powerpc/kernel/prom.c          | 21 +++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c        |  9 +-------
 arch/powerpc/kvm/book3s_hv_ras.c    |  6 ++---
 arch/powerpc/mm/init_64.c           | 10 ++++++--
 arch/powerpc/mm/tlb-radix.c         |  9 ++++----
 9 files changed, 71 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 1f6847b107e4..f4cdd04ec37b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -62,6 +62,12 @@ struct cpu_spec {
 	unsigned int	cpu_user_features2;	/* Userland features v2 */
 	unsigned int	mmu_features;		/* MMU features */
 
+	/* Number of sets/congruence classes for tlbiel IS!=0 invalidation */
+	/* For POWER7 and later Book3s CPUs */
+	unsigned int	tlb_sets;		/* set to current MMU mode */
+	unsigned int	tlb_sets_hash;
+	unsigned int	tlb_sets_radix;
+
 	/* cache line sizes */
 	unsigned int	icache_bsize;
 	unsigned int	dcache_bsize;
@@ -106,12 +112,6 @@ struct cpu_spec {
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
@@ -130,7 +130,7 @@ extern void cpu_feature_keys_init(void);
 static inline void cpu_feature_keys_init(void) { }
 #endif
 
-/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
+/* TLB flush actions. Used as argument to machine_check_flush_tlb() */
 enum {
 	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
 	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 81eff8631434..907fba5817e2 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -211,4 +211,9 @@ extern void machine_check_print_event_info(struct machine_check_event *evt,
 					   bool user_mode);
 extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
 
+/*
+ * TLB flush for POWER7 and later
+ */
+extern void machine_check_flush_tlb(unsigned int action);
+
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e79b9daa873c..4823937c14ee 100644
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
 extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
@@ -359,13 +356,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlb_sets_hash		= POWER7_TLB_SETS,
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
@@ -377,13 +374,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_sets_hash		= POWER8_TLB_SETS,
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
@@ -401,7 +398,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
 	{	/* Power7 */
@@ -412,6 +408,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlb_sets_hash		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -420,7 +417,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -432,6 +428,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlb_sets_hash		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -440,7 +437,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7+",
 	},
@@ -452,6 +448,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -460,7 +457,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -472,6 +468,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -480,7 +477,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -492,6 +488,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -500,7 +497,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -512,6 +508,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlb_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -520,7 +517,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -532,6 +528,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
+		.tlb_sets_hash		= POWER9_TLB_SETS_HASH,
+		.tlb_sets_radix		= POWER9_TLB_SETS_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -540,7 +538,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
@@ -552,6 +549,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
+		.tlb_sets_hash		= POWER9_TLB_SETS_HASH,
+		.tlb_sets_radix		= POWER9_TLB_SETS_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -560,7 +559,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index f913139bb0c2..4092ddaaacf0 100644
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
@@ -46,43 +52,13 @@ static void flush_tlb_206(unsigned int num_sets, unsigned int action)
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
-	unsigned int num_sets;
-
-	if (radix_enabled())
-		num_sets = POWER9_TLB_SETS_RADIX;
-	else
-		num_sets = POWER9_TLB_SETS_HASH;
-
-	flush_tlb_206(num_sets, action);
-}
-
-
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_STD_MMU_64
 static void flush_and_reload_slb(void)
@@ -142,10 +118,8 @@ static int mce_flush(int what)
 		return 1;
 	}
 	if (what == MCE_FLUSH_TLB) {
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-			return 1;
-		}
+		machine_check_flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
+		return 1;
 	}
 
 	return 0;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d2f0afeae5a0..08ec2f431eff 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -236,8 +236,27 @@ static void __init init_mmu_slb_size(unsigned long node)
 	if (slb_size_ptr)
 		mmu_slb_size = be32_to_cpup(slb_size_ptr);
 }
+static void __init init_mmu_tlb_sets_hash(unsigned long node)
+{
+	const __be32 *ptr;
+
+	ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-hash", NULL);
+	if (ptr)
+		cur_cpu_spec->tlb_sets_hash = be32_to_cpup(ptr);
+}
+
+static void __init init_mmu_tlb_sets_radix(unsigned long node)
+{
+	const __be32 *ptr;
+
+	ptr = of_get_flat_dt_prop(node, "ibm,tlbiel-congruence-classes-radix", NULL);
+	if (ptr)
+		cur_cpu_spec->tlb_sets_radix = be32_to_cpup(ptr);
+}
 #else
 #define init_mmu_slb_size(node) do { } while(0)
+#define init_mmu_hash_sets(node) do { } while(0)
+#define init_mmu_radix_sets(node) do { } while(0)
 #endif
 
 static struct feature_property {
@@ -385,6 +404,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	check_cpu_feature_properties(node);
 	check_cpu_pa_features(node);
 	init_mmu_slb_size(node);
+	init_mmu_tlb_sets_hash(node);
+	init_mmu_tlb_sets_radix(node);
 
 #ifdef CONFIG_PPC64
 	if (nthreads > 1)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index fadb75abfe37..2211cda5de90 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3430,14 +3430,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	 * Work out how many sets the TLB has, for the use of
 	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
 	 */
-	if (kvm_is_radix(kvm))
-		kvm->arch.tlb_sets = POWER9_TLB_SETS_RADIX;	/* 128 */
-	else if (cpu_has_feature(CPU_FTR_ARCH_300))
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
index ec84b31c6c86..a7c771170993 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -405,9 +405,15 @@ void __init mmu_early_init_devtree(void)
 	if (!(mfmsr() & MSR_HV))
 		early_check_vec5();
 
-	if (early_radix_enabled())
+	if (early_radix_enabled()) {
+		cur_cpu_spec->tlb_sets = cur_cpu_spec->tlb_sets_radix;
 		radix__early_init_devtree();
-	else
+	} else {
+		cur_cpu_spec->tlb_sets = cur_cpu_spec->tlb_sets_hash;
 		hash__early_init_devtree();
+	}
+	/* This should not happen, but fall back to 1 set */
+	if (!cur_cpu_spec->tlb_sets)
+		cur_cpu_spec->tlb_sets = 1;
 }
 #endif /* CONFIG_PPC_STD_MMU_64 */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b68b5219cf45..76c8ed7549a7 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -38,15 +38,16 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 }
 
-/*
- * We use 128 set in radix mode and 256 set in hpt mode.
- */
 static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
 	asm volatile("ptesync": : :"memory");
-	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
+	/*
+	 * tlbiel with IS != 0 operates on a specified congruence class,
+	 * requiring a loop to invalidate the entire TLB (see ISA).
+	 */
+	for (set = 0; set < cur_cpu_spec->tlb_sets; set++) {
 		__tlbiel_pid(pid, set, ric);
 	}
 	asm volatile("ptesync": : :"memory");
-- 
2.11.0
