Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyQnv56dYzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 15:55:45 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a7so2093524pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 22:55:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH] powerpc: introduce CPU version quirks
Date: Thu, 21 Sep 2017 15:55:33 +1000
Message-Id: <20170921055533.28610-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU feature bitmask is shared among all powerpcs, which is
not very suitable for adding quirks of particular implementations.

Introduce CPU version specific quirks, which provides alternate
instruction patching and static branches. This can be used to
clear out the cpu features space. The POWER9_DD1 feature is moved
over to DD1 being a quirk of POWER9, to demonstrate (patches will
be split).
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  2 +-
 arch/powerpc/include/asm/book3s/64/radix.h   |  8 +++---
 arch/powerpc/include/asm/cpu_has_feature.h   | 39 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h          | 21 ++++++++++++---
 arch/powerpc/include/asm/feature-fixups.h    | 18 +++++++++++++
 arch/powerpc/kernel/cputable.c               | 28 +++++++++++++++++++-
 arch/powerpc/kernel/dt_cpu_ftrs.c            |  3 ++-
 arch/powerpc/kernel/idle_book3s.S            |  8 +++---
 arch/powerpc/kernel/module.c                 |  6 +++++
 arch/powerpc/kernel/process.c                |  2 +-
 arch/powerpc/kernel/vdso.c                   | 10 +++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S      |  3 +++
 arch/powerpc/kernel/vdso64/vdso64.lds.S      |  3 +++
 arch/powerpc/kernel/vmlinux.lds.S            |  6 +++++
 arch/powerpc/kvm/book3s_64_mmu_radix.c       |  4 +--
 arch/powerpc/kvm/book3s_hv.c                 |  2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S      |  8 +++---
 arch/powerpc/kvm/book3s_xive_template.c      |  2 +-
 arch/powerpc/lib/feature-fixups.c            |  9 +++++++
 arch/powerpc/mm/hash_utils_64.c              |  4 +--
 arch/powerpc/mm/hugetlbpage.c                |  2 +-
 arch/powerpc/mm/mmu_context_book3s64.c       |  2 +-
 arch/powerpc/mm/pgtable-radix.c              |  6 ++---
 arch/powerpc/mm/tlb-radix.c                  |  2 +-
 arch/powerpc/perf/core-book3s.c              |  2 +-
 arch/powerpc/perf/isa207-common.c            | 10 +++----
 arch/powerpc/perf/power9-pmu.c               |  2 +-
 arch/powerpc/platforms/powernv/idle.c        |  4 +--
 arch/powerpc/platforms/powernv/smp.c         |  2 +-
 drivers/misc/cxl/cxl.h                       |  3 +--
 drivers/misc/cxl/cxllib.c                    |  2 +-
 31 files changed, 179 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 2d1ca488ca44..4408f1b9a4b8 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -37,7 +37,7 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 {
 	unsigned long page_shift;
 
-	if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (!cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		return entry;
 
 	page_shift = huge_page_shift(hstate_vma(vma));
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 1e5ba94e62ef..eb0ebd5f9b52 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -148,7 +148,7 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 {
 	unsigned long old_pte;
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 
 		unsigned long new_pte;
 
@@ -201,7 +201,7 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 
 		unsigned long old_pte, new_pte;
 
@@ -264,7 +264,7 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 {
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		return __pmd(pmd_val(pmd) | _PAGE_PTE | R_PAGE_LARGE);
 	return __pmd(pmd_val(pmd) | _PAGE_PTE);
 }
@@ -308,7 +308,7 @@ static inline unsigned long radix__get_tree_size(void)
 	 * bits 0 - 3 of rts -> bits 6 - 8 unsigned long
 	 * bits 4 - 5 of rts -> bits 62 - 63 of unsigned long
 	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		rts_field = (0x3UL << 61);
 	else {
 		rts_field = (0x5UL << 5); /* 6 - 8 bits */
diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 0d1df02bf99d..411cfae2ba38 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -12,6 +12,16 @@ static inline bool early_cpu_has_feature(unsigned long feature)
 		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
 }
 
+static inline bool early_cpu_has_quirk(unsigned long quirk)
+{
+	if ((cur_cpu_spec->cpu_quirks & CPU_QUIRK_VERSION_MASK)
+			!= (quirk & CPU_QUIRK_VERSION_MASK))
+		return false;
+	if (cur_cpu_spec->cpu_quirks & quirk & ~CPU_QUIRK_VERSION_MASK)
+		return true;
+	return false;
+}
+
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 #include <linux/jump_label.h>
 
@@ -44,11 +54,40 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 	i = __builtin_ctzl(feature);
 	return static_branch_likely(&cpu_feature_keys[i]);
 }
+
+#define NUM_QUIRK_KEYS	(BITS_PER_LONG - 16)
+
+extern struct static_key_false power9_quirk_keys[NUM_QUIRK_KEYS];
+
+static __always_inline bool cpu_has_quirk(unsigned long quirk)
+{
+	int i;
+
+#ifndef __clang__ /* clang can't cope with this */
+	BUILD_BUG_ON(!__builtin_constant_p(quirk));
+#endif
+
+#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
+	if (!static_key_initialized) {
+		printk("Warning! cpu_has_quirk() used prior to jump label init!\n");
+		dump_stack();
+		return early_cpu_has_quirk(quirk);
+	}
+#endif
+	i = __builtin_ctzl(quirk & ~CPU_QUIRK_VERSION_MASK) - 16;
+	if ((quirk & CPU_QUIRK_VERSION_MASK) == QUIRK_POWER9)
+		return static_branch_likely(&power9_quirk_keys[i]);
+	return false;
+}
 #else
 static inline bool cpu_has_feature(unsigned long feature)
 {
 	return early_cpu_has_feature(feature);
 }
+static inline bool cpu_has_quirk(unsigned long quirk)
+{
+	return early_cpu_has_quirk(quirk);
+}
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921f4efc..2f903ccb128f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -58,6 +58,7 @@ struct cpu_spec {
 
 	char		*cpu_name;
 	unsigned long	cpu_features;		/* Kernel features */
+	unsigned long	cpu_quirks;		/* CPU version specific quirk */
 	unsigned int	cpu_user_features;	/* Userland features */
 	unsigned int	cpu_user_features2;	/* Userland features v2 */
 	unsigned int	mmu_features;		/* MMU features */
@@ -117,6 +118,7 @@ struct cpu_spec {
 extern struct cpu_spec		*cur_cpu_spec;
 
 extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
+extern unsigned int __start___quirks_ftr_fixup, __stop___quirks_ftr_fixup;
 
 extern void set_cur_cpu_spec(struct cpu_spec *s);
 extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
@@ -128,8 +130,10 @@ extern const char *powerpc_base_platform;
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 extern void cpu_feature_keys_init(void);
+extern void quirk_keys_init(void);
 #else
 static inline void cpu_feature_keys_init(void) { }
+static inline void quirk_keys_init(void) { }
 #endif
 
 /* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
@@ -214,7 +218,19 @@ enum {
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
-#define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
+
+/*
+ * Version is the PVR version (top 16-bits of PVR, shifted right 16 bits).
+ * 32-bit versions have 16 quirk bits available
+ * 64-bit versions can also use the upper 32 quirk bits
+ */
+#define CPU_QUIRK_VERSION_MASK		ASM_CONST(0x0000ffff)
+
+/*
+ * POWER9 quirks
+ */
+#define QUIRK_POWER9			0x004E /* PVR version */
+#define QUIRK_DD1			ASM_CONST(0x00010000)
 
 #ifndef __ASSEMBLY__
 
@@ -475,8 +491,7 @@ enum {
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
-#define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
-			     (~CPU_FTR_SAO))
+#define CPU_FTRS_POWER9_DD1 (CPU_FTRS_POWER9 & ~CPU_FTR_SAO)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 8f88f771cc55..5fb087086bab 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -87,6 +87,24 @@ label##5:							\
 #define ALT_FTR_SECTION_END_IFCLR(msk)	\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
 
+/* CPU version dependent quicks sections */
+#define BEGIN_QUIRK_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
+#define BEGIN_QUIRK_FTR_SECTION		START_FTR_SECTION(97)
+
+#define END_QUIRK_FTR_SECTION_NESTED(msk, label) 		\
+	FTR_SECTION_ELSE_NESTED(label)				\
+	MAKE_FTR_SECTION_ENTRY(msk, msk, label, __quirks_ftr_fixup)
+
+#define END_QUIRK_FTR_SECTION(msk)		\
+	END_QUIRK_FTR_SECTION_NESTED(msk, 97)
+
+/* CPU feature sections with alternatives, use BEGIN_FTR_SECTION to start */
+#define QUIRK_FTR_SECTION_ELSE	FTR_SECTION_ELSE_NESTED(97)
+#define ALT_QUIRK_FTR_SECTION_END_NESTED(msk, label)	\
+	MAKE_FTR_SECTION_ENTRY(msk, msk, label, __quirks_ftr_fixup)
+#define ALT_QUIRK_FTR_SECTION_END(msk)	\
+	ALT_QUIRK_FTR_SECTION_END_NESTED(msk, msk, 97)
+
 /* MMU feature dependent sections */
 #define BEGIN_MMU_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
 #define BEGIN_MMU_FTR_SECTION			START_FTR_SECTION(97)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 760872916013..bc6d2c0254e3 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -532,6 +532,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_value		= 0x004e0100,
 		.cpu_name		= "POWER9 (raw)",
 		.cpu_features		= CPU_FTRS_POWER9_DD1,
+		.cpu_quirks		= QUIRK_DD1,
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
@@ -2206,6 +2207,8 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 	/* Copy everything, then do fixups */
 	*t = *s;
 
+	s->cpu_quirks |= PVR_VER(mfspr(SPRN_PVR));
+
 	/*
 	 * If we are overriding a previous value derived from the real
 	 * PVR with a new value obtained using a logical PVR value,
@@ -2268,7 +2271,6 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 	int i;
 
 	s = PTRRELOC(s);
-
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++) {
 		if ((pvr & s->pvr_mask) == s->pvr_value)
 			return setup_cpu_spec(offset, s);
@@ -2320,6 +2322,30 @@ void __init cpu_feature_keys_init(void)
 	}
 }
 
+struct static_key_false power9_quirk_keys[NUM_QUIRK_KEYS] = {
+			[0 ... NUM_QUIRK_KEYS - 1] = STATIC_KEY_FALSE_INIT
+};
+EXPORT_SYMBOL_GPL(power9_quirk_keys);
+
+void __init quirk_keys_init(void)
+{
+	struct static_key_false *k;
+	int i;
+
+	if (PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER9)
+		k = &power9_quirk_keys[0];
+	else
+		return;
+
+	for (i = 0; i < NUM_QUIRK_KEYS; i++) {
+		unsigned long f = (1ul << i) + 16;
+
+		if (!(cur_cpu_spec->cpu_quirks & f))
+			static_branch_enable(&k[i]);
+	}
+}
+
+
 struct static_key_true mmu_feature_keys[NUM_MMU_FTR_KEYS] = {
 			[0 ... NUM_MMU_FTR_KEYS - 1] = STATIC_KEY_TRUE_INIT
 };
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 1df770e8cbe0..c095daab317a 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -733,8 +733,9 @@ static __init void cpufeatures_cpu_quirks(void)
 	/*
 	 * Not all quirks can be derived from the cpufeatures device tree.
 	 */
+	cur_cpu_spec->cpu_quirks = PVR_VER(version);
 	if ((version & 0xffffff00) == 0x004e0100)
-		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
+		cur_cpu_spec->cpu_quirks |= QUIRK_DD1;
 }
 
 static void __init cpufeatures_setup_finished(void)
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 1125c9be9e06..9cdc444e14a2 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -518,9 +518,9 @@ pnv_powersave_wakeup:
 	ld	r2, PACATOC(r13)
 
 BEGIN_FTR_SECTION
-BEGIN_FTR_SECTION_NESTED(70)
+BEGIN_QUIRK_FTR_SECTION_NESTED(70)
 	bl	power9_dd1_recover_paca
-END_FTR_SECTION_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
+END_QUIRK_FTR_SECTION_NESTED(QUIRK_POWER9 | QUIRK_DD1, 70)
 	bl	pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
 	bl	pnv_restore_hyp_resource_arch207
@@ -572,7 +572,7 @@ pnv_restore_hyp_resource_arch300:
 	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 
-BEGIN_FTR_SECTION_NESTED(71)
+BEGIN_QUIRK_FTR_SECTION_NESTED(71)
 	/*
 	 * Assume that we are waking up from the state
 	 * same as the Requested Level (RL) in the PSSCR
@@ -587,7 +587,7 @@ FTR_SECTION_ELSE_NESTED(71)
 	 */
 	mfspr	r5, SPRN_PSSCR
 	rldicl  r5,r5,4,60
-ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 71)
+ALT_QUIRK_FTR_SECTION_END_NESTED(QUIRK_POWER9 | QUIRK_DD1, 71)
 	cmpd	cr4,r5,r4
 	bge	cr4,pnv_wakeup_tb_loss /* returns to caller */
 
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 3f7ba0f5bf29..bc5ecc508278 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -60,6 +60,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
 
+	sect = find_section(hdr, sechdrs, "__quirks_ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(cur_cpu_spec->cpu_quirks,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+
 	sect = find_section(hdr, sechdrs, "__mmu_ftr_fixup");
 	if (sect != NULL)
 		do_feature_fixups(cur_cpu_spec->mmu_features,
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bbf3454..dc20686a3554 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1226,7 +1226,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings. We don't have a VAS driver that allocates those
 		 * yet, so no cpabort is required.
 		 */
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 			/*
 			 * DD1 allows paste into normal system memory, so we
 			 * do an unpaired copy here to clear the buffer and
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 22b01a3962f0..cde9e20230dc 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -560,6 +560,11 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 		do_feature_fixups(cur_cpu_spec->cpu_features,
 				  start, start + size);
 
+	start = find_section64(v64->hdr, "__quirks_ftr_fixup", &size);
+	if (start)
+		do_feature_fixups(cur_cpu_spec->cpu_quirks,
+				  start, start + size);
+
 	start = find_section64(v64->hdr, "__mmu_ftr_fixup", &size);
 	if (start)
 		do_feature_fixups(cur_cpu_spec->mmu_features,
@@ -582,6 +587,11 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 		do_feature_fixups(cur_cpu_spec->cpu_features,
 				  start, start + size);
 
+	start = find_section32(v32->hdr, "__quirks_ftr_fixup", &size);
+	if (start)
+		do_feature_fixups(cur_cpu_spec->cpu_quirks,
+				  start, start + size);
+
 	start = find_section32(v32->hdr, "__mmu_ftr_fixup", &size);
 	if (start)
 		do_feature_fixups(cur_cpu_spec->mmu_features,
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index e58ee10fa5c0..faf0d9b6fe88 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -38,6 +38,9 @@ SECTIONS
 	__ftr_fixup	: { *(__ftr_fixup) }
 
 	. = ALIGN(8);
+	__quirks_ftr_fixup	: { *(__quirks_ftr_fixup) }
+
+	. = ALIGN(8);
 	__mmu_ftr_fixup	: { *(__mmu_ftr_fixup) }
 
 	. = ALIGN(8);
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 64fb183a47c2..8aafe4730a9f 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -39,6 +39,9 @@ SECTIONS
 	__ftr_fixup	: { *(__ftr_fixup) }
 
 	. = ALIGN(8);
+	__quirks_ftr_fixup	: { *(__quirks_ftr_fixup) }
+
+	. = ALIGN(8);
 	__mmu_ftr_fixup	: { *(__mmu_ftr_fixup) }
 
 	. = ALIGN(8);
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 882628fa6987..6a7d66ee4b5a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -188,6 +188,12 @@ SECTIONS
 		__stop___ftr_fixup = .;
 	}
 	. = ALIGN(8);
+	__quirks_ftr_fixup : AT(ADDR(__quirks_ftr_fixup) - LOAD_OFFSET) {
+		__start___quirks_ftr_fixup = .;
+		*(__quirks_ftr_fixup)
+		__stop___quirks_ftr_fixup = .;
+	}
+	. = ALIGN(8);
 	__mmu_ftr_fixup : AT(ADDR(__mmu_ftr_fixup) - LOAD_OFFSET) {
 		__start___mmu_ftr_fixup = .;
 		*(__mmu_ftr_fixup)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index c5d7435455f1..ecabf1dba0c3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -68,7 +68,7 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 
 	/* P9 DD1 interprets RTS (radix tree size) differently */
 	offset = rts + 31;
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		offset -= 3;
 
 	/* current implementations only support 52-bit space */
@@ -166,7 +166,7 @@ unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep,
 {
 	unsigned long old = 0;
 
-	if (!(clr & _PAGE_PRESENT) && cpu_has_feature(CPU_FTR_POWER9_DD1) &&
+	if (!(clr & _PAGE_PRESENT) && cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1) &&
 	    pte_present(*ptep)) {
 		/* have to invalidate it first */
 		old = __radix_pte_update(ptep, _PAGE_PRESENT, 0);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 18e974a34fce..8172dd09e6ce 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1634,7 +1634,7 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 		 * timebase offset be changed on P9 DD1.  (It is
 		 * initialized to zero.)
 		 */
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 			break;
 		/* round up to multiple of 2^24 */
 		vcpu->arch.vcore->tb_offset =
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 663a4a861e7f..75fa22b4c217 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -882,9 +882,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_BESCR, r6
 	mtspr	SPRN_PID, r7
 	mtspr	SPRN_WORT, r8
-BEGIN_FTR_SECTION
+BEGIN_QUIRK_FTR_SECTION
 	PPC_INVALIDATE_ERAT
-END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
+END_QUIRK_FTR_SECTION(QUIRK_POWER9 | QUIRK_DD1)
 BEGIN_FTR_SECTION
 	/* POWER8-only registers */
 	ld	r5, VCPU_TCSCR(r4)
@@ -1782,9 +1782,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	ptesync
 
 2:	/* Flush the ERAT on radix P9 DD1 guest exit */
-BEGIN_FTR_SECTION
+BEGIN_QUIRK_FTR_SECTION
 	PPC_INVALIDATE_ERAT
-END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1)
+END_QUIRK_FTR_SECTION(QUIRK_POWER9 | QUIRK_DD1)
 	b	4f
 #endif /* CONFIG_PPC_RADIX_MMU */
 
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index d1ed2c41b5d2..e83f25e30f3e 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -27,7 +27,7 @@ static void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc)
 	 * ignore the interrupt or we might incorrectly lose an IPB
 	 * bit.
 	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 		u8 pipr = __x_readb(__x_tima + TM_QW1_OS + TM_PIPR);
 		if (pipr >= xc->hw_cppr)
 			return;
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 41cf5ae273cf..87bef5c1f990 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -155,6 +155,7 @@ static void do_final_fixups(void)
 }
 
 static unsigned long __initdata saved_cpu_features;
+static unsigned long __initdata saved_quirks;
 static unsigned int __initdata saved_mmu_features;
 #ifdef CONFIG_PPC64
 static unsigned long __initdata saved_firmware_features;
@@ -165,6 +166,7 @@ void __init apply_feature_fixups(void)
 	struct cpu_spec *spec = PTRRELOC(*PTRRELOC(&cur_cpu_spec));
 
 	*PTRRELOC(&saved_cpu_features) = spec->cpu_features;
+	*PTRRELOC(&saved_quirks) = spec->cpu_quirks;
 	*PTRRELOC(&saved_mmu_features) = spec->mmu_features;
 
 	/*
@@ -175,6 +177,10 @@ void __init apply_feature_fixups(void)
 			  PTRRELOC(&__start___ftr_fixup),
 			  PTRRELOC(&__stop___ftr_fixup));
 
+	do_feature_fixups(spec->cpu_quirks,
+			  PTRRELOC(&__start___quirks_ftr_fixup),
+			  PTRRELOC(&__stop___quirks_ftr_fixup));
+
 	do_feature_fixups(spec->mmu_features,
 			  PTRRELOC(&__start___mmu_ftr_fixup),
 			  PTRRELOC(&__stop___mmu_ftr_fixup));
@@ -200,6 +206,7 @@ void __init setup_feature_keys(void)
 	 */
 	jump_label_init();
 	cpu_feature_keys_init();
+	quirk_keys_init();
 	mmu_feature_keys_init();
 }
 
@@ -207,6 +214,8 @@ static int __init check_features(void)
 {
 	WARN(saved_cpu_features != cur_cpu_spec->cpu_features,
 	     "CPU features changed after feature patching!\n");
+	WARN(saved_quirks != cur_cpu_spec->cpu_quirks,
+	     "CPU quirks changed after feature patching!\n");
 	WARN(saved_mmu_features != cur_cpu_spec->mmu_features,
 	     "MMU features changed after feature patching!\n");
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 67ec2e927253..66c1eb6c9a27 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -838,7 +838,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	htab_size =  __ilog2(htab_size) - 18;
 	mmu_partition_table_set_entry(0, hash_table | htab_size, 0);
 	pr_info("Partition table %p\n", partition_tb);
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		update_hid_for_hash();
 }
 
@@ -1056,7 +1056,7 @@ void hash__early_init_mmu_secondary(void)
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 			update_hid_for_hash();
 
 		if (!cpu_has_feature(CPU_FTR_ARCH_300))
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 1571a498a33f..3898d697c16e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -611,7 +611,7 @@ static int __init add_huge_page_size(unsigned long long size)
 	 */
 	if (radix_enabled()) {
 		if (mmu_psize != MMU_PAGE_2M) {
-			if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
+			if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1) ||
 			    (mmu_psize != MMU_PAGE_1G))
 				return -EINVAL;
 		}
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 05e15386d4cb..281ec241ba9d 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -235,7 +235,7 @@ void destroy_context(struct mm_struct *mm)
 void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 		isync();
 		mtspr(SPRN_PID, next->context.id);
 		isync();
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 39c252b54d16..afa8a77e5e60 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -490,7 +490,7 @@ static void radix_init_iamr(void)
 	/*
 	 * The IAMR should set to 0 on DD1.
 	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		iamr = 0;
 	else
 		iamr = (1ul << 62);
@@ -555,7 +555,7 @@ void __init radix__early_init_mmu(void)
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 			update_hid_for_radix();
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
@@ -579,7 +579,7 @@ void radix__early_init_mmu_secondary(void)
 	 */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 			update_hid_for_radix();
 
 		lpcr = mfspr(SPRN_LPCR);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b3e849c4886e..9bee84a4cc45 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -468,7 +468,7 @@ void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 	 * We track page size in pte only for DD1, So we can
 	 * call this only on DD1.
 	 */
-	if (!cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (!cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 		VM_WARN_ON(1);
 		return;
 	}
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2e3eb7431571..82356ea3673a 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -698,7 +698,7 @@ static void pmao_restore_workaround(bool ebb)
 
 static bool use_ic(u64 event)
 {
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1) &&
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1) &&
 			(event == 0x200f2 || event == 0x300f2))
 		return true;
 
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 2efee3f196f5..fd18d4d82314 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -59,7 +59,7 @@ static bool is_event_valid(u64 event)
 {
 	u64 valid_mask = EVENT_VALID_MASK;
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		valid_mask = p9_EVENT_VALID_MASK;
 
 	return !(event & ~valid_mask);
@@ -96,7 +96,7 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		if (is_event_marked(event) || (*mmcra & MMCRA_SAMPLE_ENABLE))
 			*mmcra &= MMCRA_SDAR_MODE_NO_UPDATES;
-		else if (!cpu_has_feature(CPU_FTR_POWER9_DD1) && p9_SDAR_MODE(event))
+		else if (!cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1) && p9_SDAR_MODE(event))
 			*mmcra |=  p9_SDAR_MODE(event) << MMCRA_SDAR_MODE_SHIFT;
 		else
 			*mmcra |= MMCRA_SDAR_MODE_DCACHE;
@@ -106,7 +106,7 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 
 static u64 thresh_cmp_val(u64 value)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		return value << p9_MMCRA_THR_CMP_SHIFT;
 
 	return value << MMCRA_THR_CMP_SHIFT;
@@ -114,7 +114,7 @@ static u64 thresh_cmp_val(u64 value)
 
 static unsigned long combine_from_event(u64 event)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		return p9_EVENT_COMBINE(event);
 
 	return EVENT_COMBINE(event);
@@ -122,7 +122,7 @@ static unsigned long combine_from_event(u64 event)
 
 static unsigned long combine_shift(unsigned long pmc)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		return p9_MMCR1_COMBINE_SHIFT(pmc);
 
 	return MMCR1_COMBINE_SHIFT(pmc);
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 24b5b5b7a206..679c2bb1d368 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -452,7 +452,7 @@ static int __init init_power9_pmu(void)
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
 		return -ENODEV;
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 		/*
 		 * Since PM_INST_CMPL may not provide right counts in all
 		 * sampling scenarios in power9 DD1, instead use PM_INST_DISP.
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 9f59041a172b..4690ca23772e 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -176,7 +176,7 @@ static void pnv_alloc_idle_core_states(void)
 			paca[cpu].core_idle_state_ptr = core_idle_state;
 			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
 			paca[cpu].thread_mask = 1 << j;
-			if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
+			if (!cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 				continue;
 			paca[cpu].thread_sibling_pacas =
 				kmalloc_node(paca_ptr_array_size,
@@ -731,7 +731,7 @@ static int __init pnv_init_idle_states(void)
 	 * sibling thread's PACA at the slot corresponding to this
 	 * CPU's index in the core.
 	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 		int cpu;
 
 		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c17f81e433f7..77c85472fc76 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -280,7 +280,7 @@ static void __init pnv_smp_probe(void)
 		WARN_ON(!ic_cause_ipi);
 
 		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-			if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+			if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 				smp_ops->cause_ipi = pnv_p9_dd1_cause_ipi;
 			else
 				smp_ops->cause_ipi = doorbell_global_ipi;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b1afeccbb97f..d44dbb274f35 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -852,8 +852,7 @@ static inline bool cxl_is_power9(void)
 
 static inline bool cxl_is_power9_dd1(void)
 {
-	if ((pvr_version_is(PVR_POWER9)) &&
-	    cpu_has_feature(CPU_FTR_POWER9_DD1))
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1))
 		return true;
 	return false;
 }
diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index 5dba23ca2e5f..b0a34086b1d0 100644
--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -102,7 +102,7 @@ int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg)
 	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &cfg->dsnctl);
 	if (rc)
 		return rc;
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	if (cpu_has_quirk(QUIRK_POWER9 | QUIRK_DD1)) {
 		/* workaround for DD1 - nbwind = capiind */
 		cfg->dsnctl |= ((u64)0x02 << (63-47));
 	}
-- 
2.13.3
