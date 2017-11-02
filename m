Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySBrW3jnPzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 15:27:21 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b6so3649898pfh.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 21:27:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/powernv: Improve local TLB flush for boot and MCE
 on POWER9
Date: Thu,  2 Nov 2017 15:27:09 +1100
Message-Id: <20171102042709.7040-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two cases outside the normal address space management
where a CPU's local TLB is to be flushed:

  1. Booting the kernel, in case something has left stale entries in
     the TLB (e.g., kexec).

  2. Machine check, to clean corrupted TLB entries.

CPU state restore from deep idle states also currently flushes the TLB.
However this is just a side-effect of reusing the boot code to set CPU
state, rather than a requirement itself.

This type of TLB flush is coded inflexibly, several times for each CPU
type, and they have a number of problems with ISA v3.0B:

- The current radix mode of the MMU is not taken into account. tlbiel
  is undefined if the R field does not match the current radix mode.

- ISA v3.0B hash must flush the partition and process table caches.

- ISA v3.0B radix must flush partition and process scoped translations,
  partition and process table caches, and also the page walk cache.

To improve this situation, consolidate the flushing code and implement
it in C and inline asm under the mm/ directory with the rest of the
flush code. Add ISA v3.0B cases for radix and hash. Take it out from early
cputable detection hooks, and move it later in the boot process after
the MMU registers are set up and before relocation is first turned on.

Provide capability for LPID flush to specify radix mode.

The TLB flush is no longer called when restoring from deep idle states.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Booted this on power8 and power9 with hash and radix

 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |   1 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   3 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  34 ++++++
 arch/powerpc/include/asm/cputable.h                |  12 ---
 arch/powerpc/kernel/cpu_setup_power.S              |  50 ---------
 arch/powerpc/kernel/cputable.c                     |  14 ---
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |  30 ------
 arch/powerpc/kernel/mce_power.c                    | 115 +--------------------
 arch/powerpc/kvm/book3s_hv_ras.c                   |   6 +-
 arch/powerpc/mm/hash_native_64.c                   |  97 +++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c                    |   8 ++
 arch/powerpc/mm/pgtable-radix.c                    |   6 ++
 arch/powerpc/mm/tlb-radix.c                        |  66 ++++++++++++
 13 files changed, 219 insertions(+), 223 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 99c99bb04353..f0e17f3f3f2f 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -50,6 +50,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
 
+extern void hash__tlbiel_all(unsigned int action);
 
 extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, unsigned long flags);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index af06c6fe8a9f..db025dd7f619 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -10,6 +10,8 @@ static inline int mmu_get_ap(int psize)
 	return mmu_psize_defs[psize].ap;
 }
 
+extern void radix__tlbiel_all(unsigned int action);
+
 extern void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma,
 					   unsigned long start, unsigned long end);
 extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
@@ -46,4 +48,5 @@ extern void radix__flush_tlb_lpid(unsigned long lpid);
 extern void radix__flush_tlb_all(void);
 extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 					unsigned long address);
+
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 70760d018bcd..d9f3dc35d8fd 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -7,6 +7,40 @@
 #include <asm/book3s/64/tlbflush-hash.h>
 #include <asm/book3s/64/tlbflush-radix.h>
 
+/* TLB flush actions. Used as argument to tlbiel_all() */
+enum {
+	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
+	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
+};
+
+static inline void tlbiel_all(void)
+{
+	/*
+	 * This is used for host machine check and bootup.
+	 *
+	 * This uses early_radix_enabled and implementations use
+	 * early_cpu_has_feature etc because that works early in boot
+	 * and this is the machine check path which is not performance
+	 * critical.
+	 */
+	if (early_radix_enabled())
+		radix__tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
+	else
+		hash__tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
+}
+
+static inline void tlbiel_all_lpid(bool radix)
+{
+	/*
+	 * This is used for guest machine check.
+	 */
+	if (radix)
+		radix__tlbiel_all(TLB_INVAL_SCOPE_LPID);
+	else
+		hash__tlbiel_all(TLB_INVAL_SCOPE_LPID);
+}
+
+
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
 				       unsigned long start, unsigned long end)
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921f4efc..bb25bb84369b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -106,12 +106,6 @@ struct cpu_spec {
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
@@ -132,12 +126,6 @@ extern void cpu_feature_keys_init(void);
 static inline void cpu_feature_keys_init(void) { }
 #endif
 
-/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
-enum {
-	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
-	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
-};
-
 #endif /* __ASSEMBLY__ */
 
 /* CPU kernel features */
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 610955fe8b81..730ade48329b 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -31,7 +31,6 @@ _GLOBAL(__setup_cpu_power7)
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR_ISA206
-	bl	__init_tlb_power7
 	mtlr	r11
 	blr
 
@@ -45,7 +44,6 @@ _GLOBAL(__restore_cpu_power7)
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR_ISA206
-	bl	__init_tlb_power7
 	mtlr	r11
 	blr
 
@@ -64,7 +62,6 @@ _GLOBAL(__setup_cpu_power8)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR_ISA206
 	bl	__init_HFSCR
-	bl	__init_tlb_power8
 	bl	__init_PMU_HV
 	bl	__init_PMU_HV_ISA207
 	mtlr	r11
@@ -86,7 +83,6 @@ _GLOBAL(__restore_cpu_power8)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR_ISA206
 	bl	__init_HFSCR
-	bl	__init_tlb_power8
 	bl	__init_PMU_HV
 	bl	__init_PMU_HV_ISA207
 	mtlr	r11
@@ -110,7 +106,6 @@ _GLOBAL(__setup_cpu_power9)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR_ISA300
 	bl	__init_HFSCR
-	bl	__init_tlb_power9
 	bl	__init_PMU_HV
 	mtlr	r11
 	blr
@@ -134,7 +129,6 @@ _GLOBAL(__restore_cpu_power9)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR_ISA300
 	bl	__init_HFSCR
-	bl	__init_tlb_power9
 	bl	__init_PMU_HV
 	mtlr	r11
 	blr
@@ -192,50 +186,6 @@ __init_HFSCR:
 	mtspr	SPRN_HFSCR,r3
 	blr
 
-/*
- * Clear the TLB using the specified IS form of tlbiel instruction
- * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
- */
-__init_tlb_power7:
-	li	r6,POWER7_TLB_SETS
-	mtctr	r6
-	li	r7,0xc00	/* IS field = 0b11 */
-	ptesync
-2:	tlbiel	r7
-	addi	r7,r7,0x1000
-	bdnz	2b
-	ptesync
-1:	blr
-
-__init_tlb_power8:
-	li	r6,POWER8_TLB_SETS
-	mtctr	r6
-	li	r7,0xc00	/* IS field = 0b11 */
-	ptesync
-2:	tlbiel	r7
-	addi	r7,r7,0x1000
-	bdnz	2b
-	ptesync
-1:	blr
-
-/*
- * Flush the TLB in hash mode. Hash must flush with RIC=2 once for process
- * and one for partition scope to clear process and partition table entries.
- */
-__init_tlb_power9:
-	li	r6,POWER9_TLB_SETS_HASH - 1
-	mtctr	r6
-	li	r7,0xc00	/* IS field = 0b11 */
-	li	r8,0
-	ptesync
-	PPC_TLBIEL(7, 8, 2, 1, 0)
-	PPC_TLBIEL(7, 8, 2, 0, 0)
-2:	addi	r7,r7,0x1000
-	PPC_TLBIEL(7, 8, 0, 0, 0)
-	bdnz	2b
-	ptesync
-1:	blr
-
 __init_PMU_HV:
 	li	r5,0
 	mtspr	SPRN_MMCRC,r5
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 760872916013..bb1dc215286e 100644
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
@@ -368,7 +365,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -386,7 +382,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -404,7 +399,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
 	{	/* Power7 */
@@ -423,7 +417,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -443,7 +436,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7+",
 	},
@@ -463,7 +455,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -483,7 +474,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -503,7 +493,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -523,7 +512,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -543,7 +531,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
@@ -563,7 +550,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 7275fed271af..3c9f0e6df2ca 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -77,8 +77,6 @@ struct dt_cpu_feature {
  * Set up the base CPU
  */
 
-extern void __flush_tlb_power8(unsigned int action);
-extern void __flush_tlb_power9(unsigned int action);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
 
@@ -92,27 +90,6 @@ static struct {
 
 static void (*init_pmu_registers)(void);
 
-static void cpufeatures_flush_tlb(void)
-{
-	/*
-	 * This is a temporary measure to keep equivalent TLB flush as the
-	 * cputable based setup code.
-	 */
-	switch (PVR_VER(mfspr(SPRN_PVR))) {
-	case PVR_POWER8:
-	case PVR_POWER8E:
-	case PVR_POWER8NVL:
-		__flush_tlb_power8(TLB_INVAL_SCOPE_GLOBAL);
-		break;
-	case PVR_POWER9:
-		__flush_tlb_power9(TLB_INVAL_SCOPE_GLOBAL);
-		break;
-	default:
-		pr_err("unknown CPU version for boot TLB flush\n");
-		break;
-	}
-}
-
 static void __restore_cpu_cpufeatures(void)
 {
 	/*
@@ -137,8 +114,6 @@ static void __restore_cpu_cpufeatures(void)
 
 	if (init_pmu_registers)
 		init_pmu_registers();
-
-	cpufeatures_flush_tlb();
 }
 
 static char dt_cpu_name[64];
@@ -157,7 +132,6 @@ static struct cpu_spec __initdata base_cpu_spec = {
 	.oprofile_type		= PPC_OPROFILE_INVALID,
 	.cpu_setup		= NULL,
 	.cpu_restore		= __restore_cpu_cpufeatures,
-	.flush_tlb		= NULL,
 	.machine_check_early	= NULL,
 	.platform		= NULL,
 };
@@ -412,7 +386,6 @@ static void init_pmu_power8(void)
 static int __init feat_enable_mce_power8(struct dt_cpu_feature *f)
 {
 	cur_cpu_spec->platform = "power8";
-	cur_cpu_spec->flush_tlb = __flush_tlb_power8;
 	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p8;
 
 	return 1;
@@ -451,7 +424,6 @@ static void init_pmu_power9(void)
 static int __init feat_enable_mce_power9(struct dt_cpu_feature *f)
 {
 	cur_cpu_spec->platform = "power9";
-	cur_cpu_spec->flush_tlb = __flush_tlb_power9;
 	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p9;
 
 	return 1;
@@ -750,8 +722,6 @@ static void __init cpufeatures_setup_finished(void)
 	system_registers.hfscr = mfspr(SPRN_HFSCR);
 	system_registers.fscr = mfspr(SPRN_FSCR);
 
-	cpufeatures_flush_tlb();
-
 	pr_info("final cpu/mmu features = 0x%016lx 0x%08x\n",
 		cur_cpu_spec->cpu_features, cur_cpu_spec->mmu_features);
 }
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 49f5ab0bb1bb..43b68a20cde6 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -58,115 +58,6 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 	return pte_pfn(*ptep);
 }
 
-static void flush_tlb_206(unsigned int num_sets, unsigned int action)
-{
-	unsigned long rb;
-	unsigned int i;
-
-	switch (action) {
-	case TLB_INVAL_SCOPE_GLOBAL:
-		rb = TLBIEL_INVAL_SET;
-		break;
-	case TLB_INVAL_SCOPE_LPID:
-		rb = TLBIEL_INVAL_SET_LPID;
-		break;
-	default:
-		BUG();
-		break;
-	}
-
-	asm volatile("ptesync" : : : "memory");
-	for (i = 0; i < num_sets; i++) {
-		asm volatile("tlbiel %0" : : "r" (rb));
-		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
-	}
-	asm volatile("ptesync" : : : "memory");
-}
-
-static void flush_tlb_300(unsigned int num_sets, unsigned int action)
-{
-	unsigned long rb;
-	unsigned int i;
-	unsigned int r;
-
-	switch (action) {
-	case TLB_INVAL_SCOPE_GLOBAL:
-		rb = TLBIEL_INVAL_SET;
-		break;
-	case TLB_INVAL_SCOPE_LPID:
-		rb = TLBIEL_INVAL_SET_LPID;
-		break;
-	default:
-		BUG();
-		break;
-	}
-
-	asm volatile("ptesync" : : : "memory");
-
-	if (early_radix_enabled())
-		r = 1;
-	else
-		r = 0;
-
-	/*
-	 * First flush table/PWC caches with set 0, then flush the
-	 * rest of the sets, partition scope. Radix must then do it
-	 * all again with process scope. Hash just has to flush
-	 * process table.
-	 */
-	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
-			"r"(rb), "r"(0), "i"(2), "i"(0), "r"(r));
-	for (i = 1; i < num_sets; i++) {
-		unsigned long set = i * (1<<TLBIEL_INVAL_SET_SHIFT);
-
-		asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
-				"r"(rb+set), "r"(0), "i"(2), "i"(0), "r"(r));
-	}
-
-	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
-			"r"(rb), "r"(0), "i"(2), "i"(1), "r"(r));
-	if (early_radix_enabled()) {
-		for (i = 1; i < num_sets; i++) {
-			unsigned long set = i * (1<<TLBIEL_INVAL_SET_SHIFT);
-
-			asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
-				"r"(rb+set), "r"(0), "i"(2), "i"(1), "r"(r));
-		}
-	}
-
-	asm volatile("ptesync" : : : "memory");
-}
-
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
-	if (early_radix_enabled())
-		num_sets = POWER9_TLB_SETS_RADIX;
-	else
-		num_sets = POWER9_TLB_SETS_HASH;
-
-	flush_tlb_300(num_sets, action);
-}
-
-
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_STD_MMU_64
 static void flush_and_reload_slb(void)
@@ -226,10 +117,8 @@ static int mce_flush(int what)
 		return 1;
 	}
 	if (what == MCE_FLUSH_TLB) {
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-			return 1;
-		}
+		tlbiel_all();
+		return 1;
 	}
 
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index c356f9a40b24..e61066bb6725 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -87,8 +87,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
 		}
 		if (dsisr & DSISR_MC_TLB_MULTI) {
-			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
+			tlbiel_all_lpid(vcpu->kvm->arch.radix);
 			dsisr &= ~DSISR_MC_TLB_MULTI;
 		}
 		/* Any other errors we don't understand? */
@@ -105,8 +104,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		reload_slb(vcpu);
 		break;
 	case SRR1_MC_IFETCH_TLBMULTI:
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
+		tlbiel_all_lpid(vcpu->kvm->arch.radix);
 		break;
 	default:
 		handled = 0;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 3848af167df9..65d7b220b171 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -47,6 +47,103 @@
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
+static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
+{
+	unsigned long rb;
+
+	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
+
+	asm volatile("tlbiel %0" : : "r" (rb));
+}
+
+/*
+ * tlbiel instruction for hash, set invalidation
+ * i.e., r=1 and is=01 or is=10 or is=11
+ */
+static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
+					unsigned int pid,
+					unsigned int ric, unsigned int prs)
+{
+	unsigned long rb;
+	unsigned long rs;
+	unsigned int r = 0; /* hash format */
+
+	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
+	rs = ((unsigned long)pid << PPC_BITLSHIFT(31));
+
+	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4)
+		     : : "r"(rb), "r"(rs), "i"(ric), "i"(prs), "r"(r)
+		     : "memory");
+}
+
+
+static void tlbiel_all_isa206(unsigned int num_sets, unsigned int is)
+{
+	unsigned int set;
+
+	asm volatile("ptesync": : :"memory");
+
+	for (set = 0; set < num_sets; set++)
+		tlbiel_hash_set_isa206(set, is);
+
+	asm volatile("ptesync": : :"memory");
+}
+
+static void tlbiel_all_isa300(unsigned int num_sets, unsigned int is)
+{
+	unsigned int set;
+
+	asm volatile("ptesync": : :"memory");
+
+	/*
+	 * Flush the first set of the TLB, and any caching of partition table
+	 * entries. Then flush the remaining sets of the TLB. Hash mode uses
+	 * partition scoped TLB translations.
+	 */
+	tlbiel_hash_set_isa300(0, is, 0, 2, 0);
+	for (set = 1; set < num_sets; set++)
+		tlbiel_hash_set_isa300(set, is, 0, 0, 0);
+
+	/*
+	 * Now invalidate the process table cache.
+	 *
+	 * From ISA v3.0B p. 1078:
+	 *     The following forms are invalid.
+	 *      * PRS=1, R=0, and RIC!=2 (The only process-scoped
+	 *        HPT caching is of the Process Table.)
+	 */
+	tlbiel_hash_set_isa300(0, is, 0, 2, 1);
+
+	asm volatile("ptesync": : :"memory");
+}
+
+void hash__tlbiel_all(unsigned int action)
+{
+	unsigned int is;
+
+	switch (action) {
+	case TLB_INVAL_SCOPE_GLOBAL:
+		is = 3;
+		break;
+	case TLB_INVAL_SCOPE_LPID:
+		is = 2;
+		break;
+	default:
+		BUG();
+	}
+
+	if (early_cpu_has_feature(CPU_FTR_ARCH_300))
+		tlbiel_all_isa300(POWER9_TLB_SETS_HASH, is);
+	else if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
+		tlbiel_all_isa206(POWER8_TLB_SETS, is);
+	else if (early_cpu_has_feature(CPU_FTR_ARCH_206))
+		tlbiel_all_isa206(POWER7_TLB_SETS, is);
+	else
+		WARN(1, "%s called on pre-POWER7 CPU\n", __func__);
+
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+}
+
 static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 {
 	unsigned long va;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 67ec2e927253..f2e2bd9f05f8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1048,6 +1048,10 @@ void __init hash__early_init_mmu(void)
 	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
 	slb_initialize();
+
+	if (cpu_has_feature(CPU_FTR_ARCH_206)
+			&& cpu_has_feature(CPU_FTR_HVMODE))
+		tlbiel_all();
 }
 
 #ifdef CONFIG_SMP
@@ -1067,6 +1071,10 @@ void hash__early_init_mmu_secondary(void)
 	}
 	/* Initialize SLB */
 	slb_initialize();
+
+	if (cpu_has_feature(CPU_FTR_ARCH_206)
+			&& cpu_has_feature(CPU_FTR_HVMODE))
+		tlbiel_all();
 }
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 39c252b54d16..e58873df1a70 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -569,6 +569,9 @@ void __init radix__early_init_mmu(void)
 
 	radix_init_iamr();
 	radix_init_pgtable();
+
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		tlbiel_all();
 }
 
 void radix__early_init_mmu_secondary(void)
@@ -590,6 +593,9 @@ void radix__early_init_mmu_secondary(void)
 		radix_init_amor();
 	}
 	radix_init_iamr();
+
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		tlbiel_all();
 }
 
 void radix__mmu_cleanup_all(void)
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index e2f15810b9c0..e92f5c5aaa56 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -23,6 +23,72 @@
 #define RIC_FLUSH_PWC 1
 #define RIC_FLUSH_ALL 2
 
+/*
+ * tlbiel instruction for radix, set invalidation
+ * i.e., r=1 and is=01 or is=10 or is=11
+ */
+static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
+					unsigned int pid,
+					unsigned int ric, unsigned int prs)
+{
+	unsigned long rb;
+	unsigned long rs;
+	unsigned int r = 1; /* radix format */
+
+	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
+	rs = ((unsigned long)pid << PPC_BITLSHIFT(31));
+
+	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4)
+		     : : "r"(rb), "r"(rs), "i"(ric), "i"(prs), "r"(r)
+		     : "memory");
+}
+
+static void tlbiel_all_isa300(unsigned int num_sets, unsigned int is)
+{
+	unsigned int set;
+
+	asm volatile("ptesync": : :"memory");
+
+	/*
+	 * Flush the first set of the TLB, and the entire Page Walk Cache
+	 * and partition table entries. Then flush the remaining sets of the
+	 * TLB.
+	 */
+	tlbiel_radix_set_isa300(0, is, 0, RIC_FLUSH_ALL, 0);
+	for (set = 1; set < num_sets; set++)
+		tlbiel_radix_set_isa300(set, is, 0, RIC_FLUSH_TLB, 0);
+
+	/* Do the same for process scoped entries. */
+	tlbiel_radix_set_isa300(0, is, 0, RIC_FLUSH_ALL, 1);
+	for (set = 1; set < num_sets; set++)
+		tlbiel_radix_set_isa300(set, is, 0, RIC_FLUSH_TLB, 1);
+
+	asm volatile("ptesync": : :"memory");
+}
+
+void radix__tlbiel_all(unsigned int action)
+{
+	unsigned int is;
+
+	switch (action) {
+	case TLB_INVAL_SCOPE_GLOBAL:
+		is = 3;
+		break;
+	case TLB_INVAL_SCOPE_LPID:
+		is = 2;
+		break;
+	default:
+		BUG();
+	}
+
+	if (early_cpu_has_feature(CPU_FTR_ARCH_300))
+		tlbiel_all_isa300(POWER9_TLB_SETS_RADIX, is);
+	else
+		WARN(1, "%s called on pre-POWER9 CPU\n", __func__);
+
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+}
+
 static inline void __tlbiel_pid(unsigned long pid, int set,
 				unsigned long ric)
 {
-- 
2.15.0
