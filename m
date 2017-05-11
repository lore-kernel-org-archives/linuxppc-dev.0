Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNnhh2VqCzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 19:23:15 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so2587531pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 02:23:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/64s: dt_cpu_ftrs use tlbiel-sets mmu property
Date: Thu, 11 May 2017 19:22:58 +1000
Message-Id: <20170511092258.30430-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the open-coding of radix set sizes for loops. Populate the
cputable with the correct values for old firmware, but dt_cpu_ftrs
will use a property under its mmu feature nodes.

Not-yet-Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi,

This is a proposal for a different approach here, by using specific
properties under dt_cpu_ftrs feature nodes to provide more data.

This was some question about whether we should allow these kind of
custom properties in general. Code-wise, it turns out simpler to do
it this way mainly because a dependency between the init-time TLB
flushing in the dt_cpu_ftrs init case, and the parsing of the tlbiel-sets
value.

So it would be pretty trivial *not* to do it this way (and the boot
time tlb flushing needs to be reworked and moved later in boot anyway),
but it kind of turns out pretty nicely this way.


 arch/powerpc/include/asm/cputable.h | 14 +++++------
 arch/powerpc/include/asm/mce.h      |  5 ++++
 arch/powerpc/kernel/cputable.c      | 26 ++++++++++----------
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 48 +++++++++++++++++++++----------------
 arch/powerpc/kernel/mce_power.c     | 46 ++++++++---------------------------
 arch/powerpc/kernel/prom.c          |  1 +
 arch/powerpc/kvm/book3s_hv.c        | 13 +++++-----
 arch/powerpc/kvm/book3s_hv_ras.c    |  6 ++---
 arch/powerpc/mm/init_64.c           |  7 ++++--
 arch/powerpc/mm/tlb-radix.c         |  2 +-
 10 files changed, 77 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index c2d509584a98..1ae262e163eb 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -62,6 +62,12 @@ struct cpu_spec {
 	unsigned int	cpu_user_features2;	/* Userland features v2 */
 	unsigned int	mmu_features;		/* MMU features */
 
+	/* Number of sets/congruence classes for tlbiel IS!=0 invalidation */
+	/* For POWER7 and later Book3s 64-bit CPUs */
+	unsigned int	tlbiel_sets;		/* set to current MMU mode */
+	unsigned int	tlbiel_sets_hash;
+	unsigned int	tlbiel_sets_radix;
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
@@ -132,7 +132,7 @@ extern void cpu_feature_keys_init(void);
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
index 9b3e88b1a9c8..6df3abc765a0 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -74,9 +74,6 @@ extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
 extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power9(void);
-extern void __flush_tlb_power7(unsigned int action);
-extern void __flush_tlb_power8(unsigned int action);
-extern void __flush_tlb_power9(unsigned int action);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
@@ -361,13 +358,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlbiel_sets_hash		= POWER7_TLB_SETS,
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
@@ -379,13 +376,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlbiel_sets_hash		= POWER8_TLB_SETS,
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
@@ -403,7 +400,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
 	{	/* Power7 */
@@ -414,6 +410,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlbiel_sets_hash		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -422,7 +419,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -434,6 +430,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
+		.tlbiel_sets_hash		= POWER7_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -442,7 +439,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7+",
 	},
@@ -454,6 +450,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlbiel_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -462,7 +459,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -474,6 +470,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlbiel_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -482,7 +479,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -494,6 +490,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlbiel_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -502,7 +499,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -514,6 +510,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
+		.tlbiel_sets_hash		= POWER8_TLB_SETS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -522,7 +519,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -534,6 +530,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
+		.tlbiel_sets_hash		= POWER9_TLB_SETS_HASH,
+		.tlbiel_sets_radix		= POWER9_TLB_SETS_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -542,7 +540,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
@@ -554,6 +551,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
+		.tlbiel_sets_hash		= POWER9_TLB_SETS_HASH,
+		.tlbiel_sets_radix		= POWER9_TLB_SETS_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -562,7 +561,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index fcc7588a96d6..098fed15ebd8 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -76,8 +76,6 @@ struct dt_cpu_feature {
  * Set up the base CPU
  */
 
-extern void __flush_tlb_power8(unsigned int action);
-extern void __flush_tlb_power9(unsigned int action);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
 
@@ -94,30 +92,16 @@ static void (*init_pmu_registers)(void);
 static void cpufeatures_flush_tlb(void)
 {
 	unsigned long rb;
-	unsigned int i, num_sets;
+	unsigned int i;
 
 	/*
 	 * This is a temporary measure to keep equivalent TLB flush as the
 	 * cputable based setup code.
 	 */
-	switch (PVR_VER(mfspr(SPRN_PVR))) {
-	case PVR_POWER8:
-	case PVR_POWER8E:
-	case PVR_POWER8NVL:
-		num_sets = POWER8_TLB_SETS;
-		break;
-	case PVR_POWER9:
-		num_sets = POWER9_TLB_SETS_HASH;
-		break;
-	default:
-		num_sets = 1;
-		pr_err("unknown CPU version for boot TLB flush\n");
-		break;
-	}
 
 	asm volatile("ptesync" : : : "memory");
 	rb = TLBIEL_INVAL_SET;
-	for (i = 0; i < num_sets; i++) {
+	for (i = 0; i < cur_cpu_spec->tlbiel_sets_hash; i++) {
 		asm volatile("tlbiel %0" : : "r" (rb));
 		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
 	}
@@ -162,13 +146,15 @@ static struct cpu_spec __initdata base_cpu_spec = {
 	.mmu_features		= 0,
 	.icache_bsize		= 32, /* minimum block size, fixed by */
 	.dcache_bsize		= 32, /* cache info init.             */
+	.tlbiel_sets		= 0,
+	.tlbiel_sets_hash	= 0,
+	.tlbiel_sets_radix	= 0,
 	.num_pmcs		= 0,
 	.pmc_type		= PPC_PMC_DEFAULT,
 	.oprofile_cpu_type	= NULL,
 	.oprofile_type		= PPC_OPROFILE_INVALID,
 	.cpu_setup		= NULL,
 	.cpu_restore		= __restore_cpu_cpufeatures,
-	.flush_tlb		= NULL,
 	.machine_check_early	= NULL,
 	.platform		= NULL,
 };
@@ -342,6 +328,7 @@ static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
 static int __init feat_enable_mmu_hash(struct dt_cpu_feature *f)
 {
 	u64 lpcr;
+	const __be32 *prop;
 
 	lpcr = mfspr(SPRN_LPCR);
 	lpcr &= ~LPCR_ISL;
@@ -355,12 +342,19 @@ static int __init feat_enable_mmu_hash(struct dt_cpu_feature *f)
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
 	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
 
+	prop = of_get_flat_dt_prop(f->node, "tlbiel-sets", NULL);
+	if (prop)
+		cur_cpu_spec->tlbiel_sets_hash = be32_to_cpup(prop);
+	else
+		cur_cpu_spec->tlbiel_sets_hash = 1;
+
 	return 1;
 }
 
 static int __init feat_enable_mmu_hash_v3(struct dt_cpu_feature *f)
 {
 	u64 lpcr;
+	const __be32 *prop;
 
 	lpcr = mfspr(SPRN_LPCR);
 	lpcr &= ~LPCR_ISL;
@@ -369,6 +363,12 @@ static int __init feat_enable_mmu_hash_v3(struct dt_cpu_feature *f)
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
 	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
 
+	prop = of_get_flat_dt_prop(f->node, "tlbiel-sets", NULL);
+	if (prop)
+		cur_cpu_spec->tlbiel_sets_hash = be32_to_cpup(prop);
+	else
+		cur_cpu_spec->tlbiel_sets_hash = 1;
+
 	return 1;
 }
 
@@ -376,10 +376,18 @@ static int __init feat_enable_mmu_hash_v3(struct dt_cpu_feature *f)
 static int __init feat_enable_mmu_radix(struct dt_cpu_feature *f)
 {
 #ifdef CONFIG_PPC_RADIX_MMU
+	const __be32 *prop;
+
 	cur_cpu_spec->mmu_features |= MMU_FTR_TYPE_RADIX;
 	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
 	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
 
+	prop = of_get_flat_dt_prop(f->node, "tlbiel-sets", NULL);
+	if (prop)
+		cur_cpu_spec->tlbiel_sets_radix = be32_to_cpup(prop);
+	else
+		cur_cpu_spec->tlbiel_sets_radix = 1;
+
 	return 1;
 #endif
 	return 0;
@@ -423,7 +431,6 @@ static void init_pmu_power8(void)
 static int __init feat_enable_mce_power8(struct dt_cpu_feature *f)
 {
 	cur_cpu_spec->platform = "power8";
-	cur_cpu_spec->flush_tlb = __flush_tlb_power8;
 	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p8;
 
 	return 1;
@@ -462,7 +469,6 @@ static void init_pmu_power9(void)
 static int __init feat_enable_mce_power9(struct dt_cpu_feature *f)
 {
 	cur_cpu_spec->platform = "power9";
-	cur_cpu_spec->flush_tlb = __flush_tlb_power9;
 	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p9;
 
 	return 1;
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index f913139bb0c2..b3f4f62d47e9 100644
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
+	for (i = 0; i < cur_cpu_spec->tlbiel_sets; i++) {
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
index 40c4887c27b6..720d52e4cead 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -237,6 +237,7 @@ static void __init init_mmu_slb_size(unsigned long node)
 	if (slb_size_ptr)
 		mmu_slb_size = be32_to_cpup(slb_size_ptr);
 }
+
 #else
 #define init_mmu_slb_size(node) do { } while(0)
 #endif
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index fadb75abfe37..64c7d151679a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3429,15 +3429,16 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	/*
 	 * Work out how many sets the TLB has, for the use of
 	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
+	 *
+	 * Note that depending on implementation of future architecture that
+	 * allows mixed radix/hash mode, this may not be the right thing to
+	 * do for flushing guest TLB. The dt property is valid for the host
+	 * tlbiel (and guest when radix mode matches host).
 	 */
 	if (kvm_is_radix(kvm))
-		kvm->arch.tlb_sets = POWER9_TLB_SETS_RADIX;	/* 128 */
-	else if (cpu_has_feature(CPU_FTR_ARCH_300))
-		kvm->arch.tlb_sets = POWER9_TLB_SETS_HASH;	/* 256 */
-	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		kvm->arch.tlb_sets = POWER8_TLB_SETS;		/* 512 */
+		kvm->arch.tlb_sets = cur_cpu_spec->tlbiel_sets_radix;
 	else
-		kvm->arch.tlb_sets = POWER7_TLB_SETS;		/* 128 */
+		kvm->arch.tlb_sets = cur_cpu_spec->tlbiel_sets_hash;
 
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
index ec84b31c6c86..09c636ed9e56 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -405,9 +405,12 @@ void __init mmu_early_init_devtree(void)
 	if (!(mfmsr() & MSR_HV))
 		early_check_vec5();
 
-	if (early_radix_enabled())
+	if (early_radix_enabled()) {
+		cur_cpu_spec->tlbiel_sets = cur_cpu_spec->tlbiel_sets_radix;
 		radix__early_init_devtree();
-	else
+	} else {
+		cur_cpu_spec->tlbiel_sets = cur_cpu_spec->tlbiel_sets_hash;
 		hash__early_init_devtree();
+	}
 }
 #endif /* CONFIG_PPC_STD_MMU_64 */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 02e71402fdd3..426bc7cd82d2 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -56,7 +56,7 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 		/* For the remaining sets, just flush the TLB */
 		ric = RIC_FLUSH_TLB;
 
-	for (set = 1; set < POWER9_TLB_SETS_RADIX ; set++)
+	for (set = 1; set < cur_cpu_spec->tlbiel_sets; set++)
 		__tlbiel_pid(pid, set, ric);
 
 	asm volatile("ptesync": : :"memory");
-- 
2.11.0
