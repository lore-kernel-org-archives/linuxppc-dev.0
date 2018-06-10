Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413cTv6GX6zF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 23:30:43 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id w12-v6so8485110pgc.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 06:30:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH] powerpc/64s: remove POWER9 DD1 support
Date: Sun, 10 Jun 2018 23:30:27 +1000
Message-Id: <20180610133027.16819-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 DD1 was never a product. It is no longer supported by upstream
firmware, and it is not effectively supported in Linux due to lack of
testing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h  | 15 +-----
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  5 +-
 arch/powerpc/include/asm/book3s/64/radix.h    | 35 ++-----------
 .../include/asm/book3s/64/tlbflush-radix.h    |  2 -
 arch/powerpc/include/asm/cputable.h           | 13 ++---
 arch/powerpc/include/asm/paca.h               |  5 --
 arch/powerpc/kernel/asm-offsets.c             |  1 -
 arch/powerpc/kernel/cputable.c                | 19 -------
 arch/powerpc/kernel/dt_cpu_ftrs.c             |  4 +-
 arch/powerpc/kernel/exceptions-64s.S          |  4 +-
 arch/powerpc/kernel/idle_book3s.S             | 50 -------------------
 arch/powerpc/kernel/process.c                 | 10 +---
 arch/powerpc/kvm/book3s_64_mmu_radix.c        | 15 +-----
 arch/powerpc/kvm/book3s_hv.c                  | 10 ----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       | 16 +-----
 arch/powerpc/kvm/book3s_xive_template.c       | 14 +-----
 arch/powerpc/mm/hash_utils_64.c               |  5 --
 arch/powerpc/mm/hugetlbpage.c                 |  8 ++-
 arch/powerpc/mm/mmu_context_book3s64.c        | 12 +----
 arch/powerpc/mm/pgtable-radix.c               | 31 +-----------
 arch/powerpc/mm/tlb-radix.c                   | 18 -------
 arch/powerpc/perf/core-book3s.c               | 33 ------------
 arch/powerpc/perf/isa207-common.c             | 12 ++---
 arch/powerpc/perf/isa207-common.h             |  5 --
 arch/powerpc/perf/power9-pmu.c                | 37 +-------------
 arch/powerpc/platforms/powernv/idle.c         | 28 -----------
 arch/powerpc/platforms/powernv/smp.c          | 27 ++--------
 arch/powerpc/xmon/xmon.c                      |  1 -
 drivers/misc/cxl/cxl.h                        |  8 ---
 drivers/misc/cxl/cxllib.c                     |  4 --
 drivers/misc/cxl/pci.c                        | 41 ++++++---------
 31 files changed, 51 insertions(+), 437 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index c459f937d484..8000aa4990d2 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -36,20 +36,7 @@ static inline int hstate_get_psize(struct hstate *hstate)
 static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 				       struct page *page, int writable)
 {
-	unsigned long page_shift;
-
-	if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
-		return entry;
-
-	page_shift = huge_page_shift(hstate_vma(vma));
-	/*
-	 * We don't support 1G hugetlb pages yet.
-	 */
-	VM_WARN_ON(page_shift == mmu_psize_defs[MMU_PAGE_1G].shift);
-	if (page_shift == mmu_psize_defs[MMU_PAGE_2M].shift)
-		return __pte(pte_val(entry) | R_PAGE_LARGE);
-	else
-		return entry;
+	return entry;
 }
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 63cee159022b..d334e6b9a46d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -474,9 +474,8 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 {
 	if (full && radix_enabled()) {
 		/*
-		 * Let's skip the DD1 style pte update here. We know that
-		 * this is a full mm pte clear and hence can be sure there is
-		 * no parallel set_pte.
+		 * We know that this is a full mm pte clear and
+		 * hence can be sure there is no parallel set_pte.
 		 */
 		return radix__ptep_get_and_clear_full(mm, addr, ptep, full);
 	}
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index ef9f96742ce1..3ab3f7aef022 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -12,12 +12,6 @@
 #include <asm/book3s/64/radix-4k.h>
 #endif
 
-/*
- * For P9 DD1 only, we need to track whether the pte's huge.
- */
-#define R_PAGE_LARGE	_RPAGE_RSV1
-
-
 #ifndef __ASSEMBLY__
 #include <asm/book3s/64/tlbflush-radix.h>
 #include <asm/cpu_has_feature.h>
@@ -154,20 +148,7 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 {
 	unsigned long old_pte;
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-
-		unsigned long new_pte;
-
-		old_pte = __radix_pte_update(ptep, ~0ul, 0);
-		/*
-		 * new value of pte
-		 */
-		new_pte = (old_pte | set) & ~clr;
-		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
-		if (new_pte)
-			__radix_pte_update(ptep, 0, new_pte);
-	} else
-		old_pte = __radix_pte_update(ptep, clr, set);
+	old_pte = __radix_pte_update(ptep, clr, set);
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
@@ -253,8 +234,6 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 {
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		return __pmd(pmd_val(pmd) | _PAGE_PTE | R_PAGE_LARGE);
 	return __pmd(pmd_val(pmd) | _PAGE_PTE);
 }
 
@@ -285,18 +264,14 @@ static inline unsigned long radix__get_tree_size(void)
 	unsigned long rts_field;
 	/*
 	 * We support 52 bits, hence:
-	 *  DD1    52-28 = 24, 0b11000
-	 *  Others 52-31 = 21, 0b10101
+	 * bits 52 - 31 = 21, 0b10101
 	 * RTS encoding details
 	 * bits 0 - 3 of rts -> bits 6 - 8 unsigned long
 	 * bits 4 - 5 of rts -> bits 62 - 63 of unsigned long
 	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		rts_field = (0x3UL << 61);
-	else {
-		rts_field = (0x5UL << 5); /* 6 - 8 bits */
-		rts_field |= (0x2UL << 61);
-	}
+	rts_field = (0x5UL << 5); /* 6 - 8 bits */
+	rts_field |= (0x2UL << 61);
+
 	return rts_field;
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index ef5c3f2994c9..1154a6dc6d26 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -48,8 +48,6 @@ extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmad
 extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
 extern void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr);
 extern void radix__flush_tlb_all(void);
-extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
-					unsigned long address);
 
 extern void radix__flush_tlb_lpid_page(unsigned int lpid,
 					unsigned long addr,
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 9c0a3083571b..f980f91cad8a 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -210,7 +210,6 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0000008000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0000010000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x0000020000000000)
-#define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x0000040000000000)
 #define CPU_FTR_POWER9_DD2_1		LONG_ASM_CONST(0x0000080000000000)
 #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
@@ -464,8 +463,6 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
 	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
 	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
-#define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
-			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
 #define CPU_FTRS_POWER9_DD2_1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD2_1)
 #define CPU_FTRS_POWER9_DD2_2 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD2_1 | \
@@ -489,16 +486,14 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
 	     CPU_FTRS_POWER8_DD1 | CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | \
-	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
-	     CPU_FTRS_POWER9_DD2_2)
+	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2)
 #else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
 	     CPU_FTRS_PA6T | CPU_FTR_VSX_COMP | CPU_FTR_ALTIVEC_COMP | \
-	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
-	     CPU_FTRS_POWER9_DD2_2)
+	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD2_1 | CPU_FTRS_POWER9_DD2_2)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
 #endif
 #else
@@ -567,7 +562,7 @@ enum {
 #define CPU_FTRS_ALWAYS \
 	    (CPU_FTRS_POSSIBLE & ~CPU_FTR_HVMODE & CPU_FTRS_POWER7 & \
 	     CPU_FTRS_POWER8E & CPU_FTRS_POWER8 & CPU_FTRS_POWER8_DD1 & \
-	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
+	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD2_1 & \
 	     CPU_FTRS_DT_CPU_BASE)
 #else
 #define CPU_FTRS_ALWAYS		\
@@ -575,7 +570,7 @@ enum {
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
 	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
 	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
-	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
+	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD2_1 & \
 	     CPU_FTRS_DT_CPU_BASE)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
 #endif
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6d34bd71139d..4e9cede5a7e7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -187,11 +187,6 @@ struct paca_struct {
 	u8 subcore_sibling_mask;
 	/* Flag to request this thread not to stop */
 	atomic_t dont_stop;
-	/*
-	 * Pointer to an array which contains pointer
-	 * to the sibling threads' paca.
-	 */
-	struct paca_struct **thread_sibling_pacas;
 	/* The PSSCR value that the kernel requested before going to stop */
 	u64 requested_psscr;
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9fc9e0977009..e329c71a60dd 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -766,7 +766,6 @@ int main(void)
 	OFFSET(PACA_THREAD_IDLE_STATE, paca_struct, thread_idle_state);
 	OFFSET(PACA_THREAD_MASK, paca_struct, thread_mask);
 	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
-	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
 	OFFSET(PACA_DONT_STOP, paca_struct, dont_stop);
 #define STOP_SPR(x, f)	OFFSET(x, paca_struct, stop_sprs.f)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c8fc9691f8c7..bc75a2908a7e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -485,25 +485,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
-	{	/* Power9 DD1*/
-		.pvr_mask		= 0xffffff00,
-		.pvr_value		= 0x004e0100,
-		.cpu_name		= "POWER9 (raw)",
-		.cpu_features		= CPU_FTRS_POWER9_DD1,
-		.cpu_user_features	= COMMON_USER_POWER9,
-		.cpu_user_features2	= COMMON_USER2_POWER9,
-		.mmu_features		= MMU_FTRS_POWER9,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 6,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power9",
-		.oprofile_type		= PPC_OPROFILE_INVALID,
-		.cpu_setup		= __setup_cpu_power9,
-		.cpu_restore		= __restore_cpu_power9,
-		.machine_check_early	= __machine_check_early_realmode_p9,
-		.platform		= "power9",
-	},
 	{	/* Power9 DD2.0 */
 		.pvr_mask		= 0xffffefff,
 		.pvr_value		= 0x004e0200,
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 4be1c0de9406..98c373a4c1cf 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -701,9 +701,7 @@ static __init void cpufeatures_cpu_quirks(void)
 	/*
 	 * Not all quirks can be derived from the cpufeatures device tree.
 	 */
-	if ((version & 0xffffff00) == 0x004e0100)
-		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
-	else if ((version & 0xffffefff) == 0x004e0200)
+	if ((version & 0xffffefff) == 0x004e0200)
 		; /* DD2.0 has no feature flag */
 	else if ((version & 0xffffefff) == 0x004e0201)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 285c6465324a..76a14702cb9c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -276,9 +276,7 @@ BEGIN_FTR_SECTION
 	 *
 	 * This interrupt can wake directly from idle. If that is the case,
 	 * the machine check is handled then the idle wakeup code is called
-	 * to restore state. In that case, the POWER9 DD1 idle PACA workaround
-	 * is not applied in the early machine check code, which will cause
-	 * bugs.
+	 * to restore state.
 	 */
 	mr	r11,r1			/* Save r1 */
 	lhz	r10,PACA_IN_MCE(r13)
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index e734f6e45abc..d85d5515a091 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -466,43 +466,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
 	blr		/* return 0 for wakeup cause / SRR1 value */
 #endif
 
-/*
- * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
- * HSPRG0 will be set to the HSPRG0 value of one of the
- * threads in this core. Thus the value we have in r13
- * may not be this thread's paca pointer.
- *
- * Fortunately, the TIR remains invariant. Since this thread's
- * paca pointer is recorded in all its sibling's paca, we can
- * correctly recover this thread's paca pointer if we
- * know the index of this thread in the core.
- *
- * This index can be obtained from the TIR.
- *
- * i.e, thread's position in the core = TIR.
- * If this value is i, then this thread's paca is
- * paca->thread_sibling_pacas[i].
- */
-power9_dd1_recover_paca:
-	mfspr	r4, SPRN_TIR
-	/*
-	 * Since each entry in thread_sibling_pacas is 8 bytes
-	 * we need to left-shift by 3 bits. Thus r4 = i * 8
-	 */
-	sldi	r4, r4, 3
-	/* Get &paca->thread_sibling_pacas[0] in r5 */
-	ld	r5, PACA_SIBLING_PACA_PTRS(r13)
-	/* Load paca->thread_sibling_pacas[i] into r13 */
-	ldx	r13, r4, r5
-	SET_PACA(r13)
-	/*
-	 * Indicate that we have lost NVGPR state
-	 * which needs to be restored from the stack.
-	 */
-	li	r3, 1
-	stb	r3,PACA_NAPSTATELOST(r13)
-	blr
-
 /*
  * Called from machine check handler for powersave wakeups.
  * Low level machine check processing has already been done. Now just
@@ -537,9 +500,6 @@ pnv_powersave_wakeup:
 	ld	r2, PACATOC(r13)
 
 BEGIN_FTR_SECTION
-BEGIN_FTR_SECTION_NESTED(70)
-	bl	power9_dd1_recover_paca
-END_FTR_SECTION_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
 	bl	pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
 	bl	pnv_restore_hyp_resource_arch207
@@ -602,22 +562,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_POWER9_DD2_1)
 	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 
-BEGIN_FTR_SECTION_NESTED(71)
-	/*
-	 * Assume that we are waking up from the state
-	 * same as the Requested Level (RL) in the PSSCR
-	 * which are Bits 60-63
-	 */
-	ld	r5,PACA_REQ_PSSCR(r13)
-	rldicl  r5,r5,0,60
-FTR_SECTION_ELSE_NESTED(71)
 	/*
 	 * 0-3 bits correspond to Power-Saving Level Status
 	 * which indicates the idle state we are waking up from
 	 */
 	mfspr	r5, SPRN_PSSCR
 	rldicl  r5,r5,4,60
-ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 71)
 	li	r0, 0		/* clear requested_psscr to say we're awake */
 	std	r0, PACA_REQ_PSSCR(r13)
 	cmpd	cr4,r5,r4
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ef4aea9fffe..27f0caee55ea 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1250,17 +1250,9 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings. If the new process has the foreign real address
 		 * mappings, we must issue a cp_abort to clear any state and
 		 * prevent snooping, corruption or a covert channel.
-		 *
-		 * DD1 allows paste into normal system memory so we do an
-		 * unpaired copy, rather than cp_abort, to clear the buffer,
-		 * since cp_abort is quite expensive.
 		 */
-		if (current_thread_info()->task->thread.used_vas) {
+		if (current_thread_info()->task->thread.used_vas)
 			asm volatile(PPC_CP_ABORT);
-		} else if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-			asm volatile(PPC_COPY(%0, %1)
-					: : "r"(dummy_copy_buffer), "r"(0));
-		}
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 481da8f93fa4..0aa40b7d6000 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -66,10 +66,7 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	bits = root & RPDS_MASK;
 	root = root & RPDB_MASK;
 
-	/* P9 DD1 interprets RTS (radix tree size) differently */
 	offset = rts + 31;
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		offset -= 3;
 
 	/* current implementations only support 52-bit space */
 	if (offset != 52)
@@ -180,17 +177,7 @@ unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep,
 				      unsigned long clr, unsigned long set,
 				      unsigned long addr, unsigned int shift)
 {
-	unsigned long old = 0;
-
-	if (!(clr & _PAGE_PRESENT) && cpu_has_feature(CPU_FTR_POWER9_DD1) &&
-	    pte_present(*ptep)) {
-		/* have to invalidate it first */
-		old = __radix_pte_update(ptep, _PAGE_PRESENT, 0);
-		kvmppc_radix_tlbie_page(kvm, addr, shift);
-		set |= _PAGE_PRESENT;
-		old &= _PAGE_PRESENT;
-	}
-	return __radix_pte_update(ptep, clr, set) | old;
+	return __radix_pte_update(ptep, clr, set);
 }
 
 void kvmppc_radix_set_pte_at(struct kvm *kvm, unsigned long addr,
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cb6d2313b19f..ca17a9e7f759 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1664,14 +1664,6 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 		r = set_vpa(vcpu, &vcpu->arch.dtl, addr, len);
 		break;
 	case KVM_REG_PPC_TB_OFFSET:
-		/*
-		 * POWER9 DD1 has an erratum where writing TBU40 causes
-		 * the timebase to lose ticks.  So we don't let the
-		 * timebase offset be changed on P9 DD1.  (It is
-		 * initialized to zero.)
-		 */
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-			break;
 		/* round up to multiple of 2^24 */
 		vcpu->arch.vcore->tb_offset =
 			ALIGN(set_reg_val(id, *val), 1UL << 24);
@@ -1989,8 +1981,6 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	/*
 	 * Set the default HFSCR for the guest from the host value.
 	 * This value is only used on POWER9.
-	 * On POWER9 DD1, TM doesn't work, so we make sure to
-	 * prevent the guest from using it.
 	 * On POWER9, we want to virtualize the doorbell facility, so we
 	 * turn off the HFSCR bit, which causes those instructions to trap.
 	 */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b97d261d3b89..fe22b40c356d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -916,9 +916,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_DAWR)
 	mtspr	SPRN_BESCR, r6
 	mtspr	SPRN_PID, r7
 	mtspr	SPRN_WORT, r8
-BEGIN_FTR_SECTION
-	PPC_INVALIDATE_ERAT
-END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
 BEGIN_FTR_SECTION
 	/* POWER8-only registers */
 	ld	r5, VCPU_TCSCR(r4)
@@ -1909,7 +1906,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	ld	r5, VCPU_KVM(r9)
 	lbz	r0, KVM_RADIX(r5)
 	cmpwi	cr2, r0, 0
-	beq	cr2, 4f
+	beq	cr2, 2f
 
 	/*
 	 * Radix: do eieio; tlbsync; ptesync sequence in case we
@@ -1949,11 +1946,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	bdnz	1b
 	ptesync
 
-2:	/* Flush the ERAT on radix P9 DD1 guest exit */
-BEGIN_FTR_SECTION
-	PPC_INVALIDATE_ERAT
-END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
-4:
+2:
 #endif /* CONFIG_PPC_RADIX_MMU */
 
 	/*
@@ -3533,11 +3526,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_CIABR, r0
 	mtspr	SPRN_DAWRX, r0
 
-	/* Flush the ERAT on radix P9 DD1 guest exit */
-BEGIN_FTR_SECTION
-	PPC_INVALIDATE_ERAT
-END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
-
 BEGIN_MMU_FTR_SECTION
 	b	4f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index 99c3620b40d9..487f1f6650cc 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -25,18 +25,6 @@ static void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc)
 	 */
 	eieio();
 
-	/*
-	 * DD1 bug workaround: If PIPR is less favored than CPPR
-	 * ignore the interrupt or we might incorrectly lose an IPB
-	 * bit.
-	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		__be64 qw1 = __x_readq(__x_tima + TM_QW1_OS);
-		u8 pipr = be64_to_cpu(qw1) & 0xff;
-		if (pipr >= xc->hw_cppr)
-			return;
-	}
-
 	/* Perform the acknowledge OS to register cycle. */
 	ack = be16_to_cpu(__x_readw(__x_tima + TM_SPC_ACK_OS_REG));
 
@@ -105,7 +93,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
 		 *
 		 * For LSIs, using the HW EOI cycle works around a problem
 		 * on P9 DD1 PHBs where the other ESB accesses don't work
-		 * properly.
+		 * properly. XXX: can this be removed?
 		 */
 		if (xd->flags & XIVE_IRQ_FLAG_LSI)
 			__x_readq(__x_eoi_page(xd) + XIVE_ESB_LOAD_EOI);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8318716e5075..141ba68d63f3 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -845,8 +845,6 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	htab_size =  __ilog2(htab_size) - 18;
 	mmu_partition_table_set_entry(0, hash_table | htab_size, 0);
 	pr_info("Partition table %p\n", partition_tb);
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		update_hid_for_hash();
 }
 
 static void __init htab_initialize(void)
@@ -1077,9 +1075,6 @@ void hash__early_init_mmu_secondary(void)
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-			update_hid_for_hash();
-
 		if (!cpu_has_feature(CPU_FTR_ARCH_300))
 			mtspr(SPRN_SDR1, _SDR1);
 		else
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7c5f479c5c00..3e91acef24b2 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -620,14 +620,12 @@ static int __init add_huge_page_size(unsigned long long size)
 	 * firmware we only add hugetlb support for page sizes that can be
 	 * supported by linux page table layout.
 	 * For now we have
-	 * Radix: 2M
+	 * Radix: 2M and 1G
 	 * Hash: 16M and 16G
 	 */
 	if (radix_enabled()) {
-		if (mmu_psize != MMU_PAGE_2M) {
-			if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
-			    (mmu_psize != MMU_PAGE_1G))
-				return -EINVAL;
+		if (mmu_psize != MMU_PAGE_2M && mmu_psize != MMU_PAGE_1G)
+			return -EINVAL;
 		}
 	} else {
 		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index f3d4b4a0e561..39e9ef0eb78b 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -273,15 +273,7 @@ void arch_exit_mmap(struct mm_struct *mm)
 #ifdef CONFIG_PPC_RADIX_MMU
 void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
-
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		isync();
-		mtspr(SPRN_PID, next->context.id);
-		isync();
-		asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
-	} else {
-		mtspr(SPRN_PID, next->context.id);
-		isync();
-	}
+	mtspr(SPRN_PID, next->context.id);
+	isync();
 }
 #endif
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 96f68c5aa1f5..efe549f707b3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -226,16 +226,6 @@ void radix__mark_rodata_ro(void)
 {
 	unsigned long start, end;
 
-	/*
-	 * mark_rodata_ro() will mark itself as !writable at some point.
-	 * Due to DD1 workaround in radix__pte_update(), we'll end up with
-	 * an invalid pte and the system will crash quite severly.
-	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		pr_warn("Warning: Unable to mark rodata read only on P9 DD1\n");
-		return;
-	}
-
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
@@ -576,22 +566,12 @@ static void radix_init_amor(void)
 
 static void radix_init_iamr(void)
 {
-	unsigned long iamr;
-
-	/*
-	 * The IAMR should set to 0 on DD1.
-	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		iamr = 0;
-	else
-		iamr = (1ul << 62);
-
 	/*
 	 * Radix always uses key0 of the IAMR to determine if an access is
 	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
 	 * fetch.
 	 */
-	mtspr(SPRN_IAMR, iamr);
+	mtspr(SPRN_IAMR, (1ul << 62));
 }
 
 void __init radix__early_init_mmu(void)
@@ -644,8 +624,6 @@ void __init radix__early_init_mmu(void)
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-			update_hid_for_radix();
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
@@ -671,10 +649,6 @@ void radix__early_init_mmu_secondary(void)
 	 * update partition table control register and UPRT
 	 */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
-
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-			update_hid_for_radix();
-
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 
@@ -1095,8 +1069,7 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 	 * To avoid NMMU hang while relaxing access, we need mark
 	 * the pte invalid in between.
 	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
-	    atomic_read(&mm->context.copros) > 0) {
+	if (atomic_read(&mm->context.copros) > 0) {
 		unsigned long old_pte, new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..902767b8a9c1 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -994,24 +994,6 @@ void radix__flush_tlb_all(void)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
-				 unsigned long address)
-{
-	/*
-	 * We track page size in pte only for DD1, So we can
-	 * call this only on DD1.
-	 */
-	if (!cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		VM_WARN_ON(1);
-		return;
-	}
-
-	if (old_pte & R_PAGE_LARGE)
-		radix__flush_tlb_page_psize(mm, address, MMU_PAGE_2M);
-	else
-		radix__flush_tlb_page_psize(mm, address, mmu_virtual_psize);
-}
-
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 extern void radix_kvm_prefetch_workaround(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3f66fcf8ad99..19a0cf44744d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -128,10 +128,6 @@ static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
 static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
 static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
-static bool use_ic(u64 event)
-{
-	return false;
-}
 #endif /* CONFIG_PPC32 */
 
 static bool regs_use_siar(struct pt_regs *regs)
@@ -714,14 +710,6 @@ static void pmao_restore_workaround(bool ebb)
 	mtspr(SPRN_PMC6, pmcs[5]);
 }
 
-static bool use_ic(u64 event)
-{
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1) &&
-			(event == 0x200f2 || event == 0x300f2))
-		return true;
-
-	return false;
-}
 #endif /* CONFIG_PPC64 */
 
 static void perf_event_interrupt(struct pt_regs *regs);
@@ -1056,13 +1044,6 @@ static void power_pmu_read(struct perf_event *event)
 
 	if (is_ebb_event(event)) {
 		val = read_pmc(event->hw.idx);
-		if (use_ic(event->attr.config)) {
-			val = mfspr(SPRN_IC);
-			if (val > cpuhw->ic_init)
-				val = val - cpuhw->ic_init;
-			else
-				val = val + (0 - cpuhw->ic_init);
-		}
 		local64_set(&event->hw.prev_count, val);
 		return;
 	}
@@ -1076,13 +1057,6 @@ static void power_pmu_read(struct perf_event *event)
 		prev = local64_read(&event->hw.prev_count);
 		barrier();
 		val = read_pmc(event->hw.idx);
-		if (use_ic(event->attr.config)) {
-			val = mfspr(SPRN_IC);
-			if (val > cpuhw->ic_init)
-				val = val - cpuhw->ic_init;
-			else
-				val = val + (0 - cpuhw->ic_init);
-		}
 		delta = check_and_compute_delta(prev, val);
 		if (!delta)
 			return;
@@ -1535,13 +1509,6 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 					event->attr.branch_sample_type);
 	}
 
-	/*
-	 * Workaround for POWER9 DD1 to use the Instruction Counter
-	 * register value for instruction counting
-	 */
-	if (use_ic(event->attr.config))
-		cpuhw->ic_init = mfspr(SPRN_IC);
-
 	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
 	return ret;
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 2efee3f196f5..177de814286f 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -59,7 +59,7 @@ static bool is_event_valid(u64 event)
 {
 	u64 valid_mask = EVENT_VALID_MASK;
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		valid_mask = p9_EVENT_VALID_MASK;
 
 	return !(event & ~valid_mask);
@@ -86,8 +86,6 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 	 * Incase of Power9:
 	 * Marked event: MMCRA[SDAR_MODE] will be set to 0b00 ('No Updates'),
 	 *               or if group already have any marked events.
-	 * Non-Marked events (for DD1):
-	 *	MMCRA[SDAR_MODE] will be set to 0b01
 	 * For rest
 	 *	MMCRA[SDAR_MODE] will be set from event code.
 	 *      If sdar_mode from event is zero, default to 0b01. Hardware
@@ -96,7 +94,7 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		if (is_event_marked(event) || (*mmcra & MMCRA_SAMPLE_ENABLE))
 			*mmcra &= MMCRA_SDAR_MODE_NO_UPDATES;
-		else if (!cpu_has_feature(CPU_FTR_POWER9_DD1) && p9_SDAR_MODE(event))
+		else if (p9_SDAR_MODE(event))
 			*mmcra |=  p9_SDAR_MODE(event) << MMCRA_SDAR_MODE_SHIFT;
 		else
 			*mmcra |= MMCRA_SDAR_MODE_DCACHE;
@@ -106,7 +104,7 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 
 static u64 thresh_cmp_val(u64 value)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		return value << p9_MMCRA_THR_CMP_SHIFT;
 
 	return value << MMCRA_THR_CMP_SHIFT;
@@ -114,7 +112,7 @@ static u64 thresh_cmp_val(u64 value)
 
 static unsigned long combine_from_event(u64 event)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		return p9_EVENT_COMBINE(event);
 
 	return EVENT_COMBINE(event);
@@ -122,7 +120,7 @@ static unsigned long combine_from_event(u64 event)
 
 static unsigned long combine_shift(unsigned long pmc)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		return p9_MMCR1_COMBINE_SHIFT(pmc);
 
 	return MMCR1_COMBINE_SHIFT(pmc);
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 6a0b586c935a..0028f4b9490d 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -158,11 +158,6 @@
 	CNST_PMC_VAL(1) | CNST_PMC_VAL(2) | CNST_PMC_VAL(3) | \
 	CNST_PMC_VAL(4) | CNST_PMC_VAL(5) | CNST_PMC_VAL(6) | CNST_NC_VAL
 
-/*
- * Lets restrict use of PMC5 for instruction counting.
- */
-#define P9_DD1_TEST_ADDER	(ISA207_TEST_ADDER | CNST_PMC_VAL(5))
-
 /* Bits in MMCR1 for PowerISA v2.07 */
 #define MMCR1_UNIT_SHIFT(pmc)		(60 - (4 * ((pmc) - 1)))
 #define MMCR1_COMBINE_SHIFT(pmc)	(35 - ((pmc) - 1))
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 2ca0b33b4efb..56124dd1a82c 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -439,25 +439,6 @@ static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 
 #undef C
 
-static struct power_pmu power9_isa207_pmu = {
-	.name			= "POWER9",
-	.n_counter		= MAX_PMU_COUNTERS,
-	.add_fields		= ISA207_ADD_FIELDS,
-	.test_adder		= P9_DD1_TEST_ADDER,
-	.compute_mmcr		= isa207_compute_mmcr,
-	.config_bhrb		= power9_config_bhrb,
-	.bhrb_filter_map	= power9_bhrb_filter_map,
-	.get_constraint		= isa207_get_constraint,
-	.get_alternatives	= power9_get_alternatives,
-	.disable_pmc		= isa207_disable_pmc,
-	.flags			= PPMU_NO_SIAR | PPMU_ARCH_207S,
-	.n_generic		= ARRAY_SIZE(power9_generic_events_dd1),
-	.generic_events		= power9_generic_events_dd1,
-	.cache_events		= &power9_cache_events,
-	.attr_groups		= power9_isa207_pmu_attr_groups,
-	.bhrb_nr		= 32,
-};
-
 static struct power_pmu power9_pmu = {
 	.name			= "POWER9",
 	.n_counter		= MAX_PMU_COUNTERS,
@@ -500,23 +481,7 @@ static int __init init_power9_pmu(void)
 		}
 	}
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		/*
-		 * Since PM_INST_CMPL may not provide right counts in all
-		 * sampling scenarios in power9 DD1, instead use PM_INST_DISP.
-		 */
-		EVENT_VAR(PM_INST_CMPL, _g).id = PM_INST_DISP;
-		/*
-		 * Power9 DD1 should use PM_BR_CMPL_ALT event code for
-		 * "branches" to provide correct counter value.
-		 */
-		EVENT_VAR(PM_BR_CMPL, _g).id = PM_BR_CMPL_ALT;
-		EVENT_VAR(PM_BR_CMPL, _c).id = PM_BR_CMPL_ALT;
-		rc = register_power_pmu(&power9_isa207_pmu);
-	} else {
-		rc = register_power_pmu(&power9_pmu);
-	}
-
+	rc = register_power_pmu(&power9_pmu);
 	if (rc)
 		return rc;
 
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1c5d0675b43c..12f13acee1f6 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -177,11 +177,6 @@ static void pnv_alloc_idle_core_states(void)
 			paca_ptrs[cpu]->core_idle_state_ptr = core_idle_state;
 			paca_ptrs[cpu]->thread_idle_state = PNV_THREAD_RUNNING;
 			paca_ptrs[cpu]->thread_mask = 1 << j;
-			if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
-				continue;
-			paca_ptrs[cpu]->thread_sibling_pacas =
-				kmalloc_node(paca_ptr_array_size,
-					     GFP_KERNEL, node);
 		}
 	}
 
@@ -805,29 +800,6 @@ static int __init pnv_init_idle_states(void)
 
 	pnv_alloc_idle_core_states();
 
-	/*
-	 * For each CPU, record its PACA address in each of it's
-	 * sibling thread's PACA at the slot corresponding to this
-	 * CPU's index in the core.
-	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		int cpu;
-
-		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
-		for_each_present_cpu(cpu) {
-			int base_cpu = cpu_first_thread_sibling(cpu);
-			int idx = cpu_thread_in_core(cpu);
-			int i;
-
-			for (i = 0; i < threads_per_core; i++) {
-				int j = base_cpu + i;
-
-				paca_ptrs[j]->thread_sibling_pacas[idx] =
-					paca_ptrs[cpu];
-			}
-		}
-	}
-
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index b80909957792..0d354e19ef92 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -283,23 +283,6 @@ static void pnv_cause_ipi(int cpu)
 	ic_cause_ipi(cpu);
 }
 
-static void pnv_p9_dd1_cause_ipi(int cpu)
-{
-	int this_cpu = get_cpu();
-
-	/*
-	 * POWER9 DD1 has a global addressed msgsnd, but for now we restrict
-	 * IPIs to same core, because it requires additional synchronization
-	 * for inter-core doorbells which we do not implement.
-	 */
-	if (cpumask_test_cpu(cpu, cpu_sibling_mask(this_cpu)))
-		doorbell_global_ipi(cpu);
-	else
-		ic_cause_ipi(cpu);
-
-	put_cpu();
-}
-
 static void __init pnv_smp_probe(void)
 {
 	if (xive_enabled())
@@ -311,14 +294,10 @@ static void __init pnv_smp_probe(void)
 		ic_cause_ipi = smp_ops->cause_ipi;
 		WARN_ON(!ic_cause_ipi);
 
-		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-			if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-				smp_ops->cause_ipi = pnv_p9_dd1_cause_ipi;
-			else
-				smp_ops->cause_ipi = doorbell_global_ipi;
-		} else {
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			smp_ops->cause_ipi = doorbell_global_ipi;
+		else
 			smp_ops->cause_ipi = pnv_cause_ipi;
-		}
 	}
 }
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..21119cfe8474 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2429,7 +2429,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, thread_idle_state, "%#-*x");
 	DUMP(p, thread_mask, "%#-*x");
 	DUMP(p, subcore_sibling_mask, "%#-*x");
-	DUMP(p, thread_sibling_pacas, "%-*px");
 	DUMP(p, requested_psscr, "%#-*llx");
 	DUMP(p, stop_sprs.pid, "%#-*llx");
 	DUMP(p, stop_sprs.ldbar, "%#-*llx");
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 918d4fb742d1..505f973e13f3 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -865,14 +865,6 @@ static inline bool cxl_is_power9(void)
 	return false;
 }
 
-static inline bool cxl_is_power9_dd1(void)
-{
-	if ((pvr_version_is(PVR_POWER9)) &&
-	    cpu_has_feature(CPU_FTR_POWER9_DD1))
-		return true;
-	return false;
-}
-
 ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 				loff_t off, size_t count);
 
diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index 0bc7c31cf739..5a3f91255258 100644
--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -102,10 +102,6 @@ int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg)
 	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &cfg->dsnctl);
 	if (rc)
 		return rc;
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		/* workaround for DD1 - nbwind = capiind */
-		cfg->dsnctl |= ((u64)0x02 << (63-47));
-	}
 
 	cfg->version  = CXL_XSL_CONFIG_CURRENT_VERSION;
 	cfg->log_bar_size = CXL_CAPI_WINDOW_LOG_SIZE;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 429d6de1dde7..2af0d4c47b76 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -465,23 +465,21 @@ int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg)
 	/* nMMU_ID Defaults to: b’000001001’*/
 	xsl_dsnctl |= ((u64)0x09 << (63-28));
 
-	if (!(cxl_is_power9_dd1())) {
-		/*
-		 * Used to identify CAPI packets which should be sorted into
-		 * the Non-Blocking queues by the PHB. This field should match
-		 * the PHB PBL_NBW_CMPM register
-		 * nbwind=0x03, bits [57:58], must include capi indicator.
-		 * Not supported on P9 DD1.
-		 */
-		xsl_dsnctl |= (nbwind << (63-55));
+	/*
+	 * Used to identify CAPI packets which should be sorted into
+	 * the Non-Blocking queues by the PHB. This field should match
+	 * the PHB PBL_NBW_CMPM register
+	 * nbwind=0x03, bits [57:58], must include capi indicator.
+	 * Not supported on P9 DD1.
+	 */
+	xsl_dsnctl |= (nbwind << (63-55));
 
-		/*
-		 * Upper 16b address bits of ASB_Notify messages sent to the
-		 * system. Need to match the PHB’s ASN Compare/Mask Register.
-		 * Not supported on P9 DD1.
-		 */
-		xsl_dsnctl |= asnind;
-	}
+	/*
+	 * Upper 16b address bits of ASB_Notify messages sent to the
+	 * system. Need to match the PHB’s ASN Compare/Mask Register.
+	 * Not supported on P9 DD1.
+	 */
+	xsl_dsnctl |= asnind;
 
 	*reg = xsl_dsnctl;
 	return 0;
@@ -539,15 +537,8 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	/* Snoop machines */
 	cxl_p1_write(adapter, CXL_PSL9_APCDEDALLOC, 0x800F000200000000ULL);
 
-	if (cxl_is_power9_dd1()) {
-		/* Disabling deadlock counter CAR */
-		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0020000000000001ULL);
-		/* Enable NORST */
-		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
-	} else {
-		/* Enable NORST and DD2 features */
-		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0xC000000000000000ULL);
-	}
+	/* Enable NORST and DD2 features */
+	cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0xC000000000000000ULL);
 
 	/*
 	 * Check if PSL has data-cache. We need to flush adapter datacache
-- 
2.17.0
