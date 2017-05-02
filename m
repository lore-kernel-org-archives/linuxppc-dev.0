Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHQWy0kN1zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 01:42:06 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id t7so23054759pgt.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 May 2017 08:42:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: Fix local TLB flush (for init and MCE) on POWER9
Date: Wed,  3 May 2017 01:41:49 +1000
Message-Id: <20170502154149.32020-1-npiggin@gmail.com>
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

  1. Host boot; in case something has left stale entries in the
     TLB (e.g., kexec).

  2. Host machine check; to clean corrupted TLB entries.

CPU state restore from an idle state incurring full state loss also
flushes the TLB, which seems to be a side effect of using the same
code as #1 rather than a requirement itself.

The problem with these are they are coded inflexibly, several times
for each CPU type, and they also don't take into account the radix
mode of the MMU in POWER9 (tlbiel instructions with R parameter not
matching the radix mode cause undefined behaviour according to
ISA v3.0B).

- tlbiel is undefined if R does not match the current radix mode.
  This could happen in machine check and cpu_restore from non-boot
  code (idle restore and OPAL call bug workaround).

- ISAv3.0B hash mode should also be flushing the partition and
  process table caches.

- Likewise for radix mode, and radix should also be flushing page walk
  cache.

Move all that flushing code to C, move it into the mm/ directory, and
add ISAv3 cases for radix and hash. Take it out from the early cputable
detection hooks and go by ISA level checks instead.

The boot process calls this flush on each CPU after it has set up all
its MMU registers, and right before switching on relocation.

TLB flush is no longer called when restoring from idle states.

This could use some review.
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  1 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 22 ++++++
 arch/powerpc/include/asm/cputable.h                | 12 ----
 arch/powerpc/kernel/cpu_setup_power.S              | 43 ------------
 arch/powerpc/kernel/cputable.c                     | 14 ----
 arch/powerpc/kernel/mce_power.c                    | 61 +---------------
 arch/powerpc/kvm/book3s_hv_ras.c                   |  6 +-
 arch/powerpc/mm/hash_native_64.c                   | 82 ++++++++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c                    |  4 ++
 arch/powerpc/mm/pgtable-radix.c                    |  4 ++
 arch/powerpc/mm/tlb-radix.c                        | 57 +++++++++++++++
 12 files changed, 177 insertions(+), 132 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 2f6373144e2c..c02ece27fd7b 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -50,6 +50,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
 
+extern void hash__tlbiel_all(unsigned int action);
 
 extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, unsigned long flags);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index cc7fbde4f53c..e7b767a3b2fa 100644
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
@@ -44,4 +46,5 @@ extern void radix__flush_tlb_lpid(unsigned long lpid);
 extern void radix__flush_tlb_all(void);
 extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 					unsigned long address);
+
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 72b925f97bab..397ad199467c 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -7,6 +7,28 @@
 #include <asm/book3s/64/tlbflush-hash.h>
 #include <asm/book3s/64/tlbflush-radix.h>
 
+/* TLB flush actions. Used as argument to tlbiel_all() */
+enum {
+	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
+	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
+};
+
+static inline void tlbiel_all(unsigned int action)
+{
+	/*
+	 * This is used for host machine check and bootup.
+	 *
+	 * This could be reimplemented more robustly without using the
+	 * radix_is_enabled(), cpu_feature(), etc. calls. However these
+	 * should be set up before relocation starts to be used at boot,
+	 * so we shouldn't see TLB machine checks before then.
+	 */
+	if (radix_enabled())
+		radix__tlbiel_all(action);
+	else
+		hash__tlbiel_all(action);
+}
+
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
 				       unsigned long start, unsigned long end)
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 1f6847b107e4..8205ce79c173 100644
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
@@ -130,12 +124,6 @@ extern void cpu_feature_keys_init(void);
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
index 1fce4ddd2e6c..d644bee90b02 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -31,7 +31,6 @@ _GLOBAL(__setup_cpu_power7)
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR
-	bl	__init_tlb_power7
 	mtlr	r11
 	blr
 
@@ -45,7 +44,6 @@ _GLOBAL(__restore_cpu_power7)
 	mfspr	r3,SPRN_LPCR
 	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
 	bl	__init_LPCR
-	bl	__init_tlb_power7
 	mtlr	r11
 	blr
 
@@ -64,7 +62,6 @@ _GLOBAL(__setup_cpu_power8)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
-	bl	__init_tlb_power8
 	bl	__init_PMU_HV
 	bl	__init_PMU_HV_ISA207
 	mtlr	r11
@@ -86,7 +83,6 @@ _GLOBAL(__restore_cpu_power8)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
-	bl	__init_tlb_power8
 	bl	__init_PMU_HV
 	bl	__init_PMU_HV_ISA207
 	mtlr	r11
@@ -110,7 +106,6 @@ _GLOBAL(__setup_cpu_power9)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
-	bl	__init_tlb_power9
 	bl	__init_PMU_HV
 	mtlr	r11
 	blr
@@ -134,7 +129,6 @@ _GLOBAL(__restore_cpu_power9)
 	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
-	bl	__init_tlb_power9
 	bl	__init_PMU_HV
 	mtlr	r11
 	blr
@@ -189,43 +183,6 @@ __init_HFSCR:
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
-__init_tlb_power9:
-	li	r6,POWER9_TLB_SETS_HASH
-	mtctr	r6
-	li	r7,0xc00	/* IS field = 0b11 */
-	ptesync
-2:	tlbiel	r7
-	addi	r7,r7,0x1000
-	bdnz	2b
-	ptesync
-1:	blr
-
 __init_PMU_HV:
 	li	r5,0
 	mtspr	SPRN_MMCRC,r5
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e79b9daa873c..437ff57c5101 100644
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
@@ -365,7 +362,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -383,7 +379,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -401,7 +396,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
 	{	/* Power7 */
@@ -420,7 +414,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
@@ -440,7 +433,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
-		.flush_tlb		= __flush_tlb_power7,
 		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7+",
 	},
@@ -460,7 +452,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -480,7 +471,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -500,7 +490,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -520,7 +509,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
-		.flush_tlb		= __flush_tlb_power8,
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
@@ -540,7 +528,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
@@ -560,7 +547,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index f913139bb0c2..bcce34c88c51 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -28,61 +28,6 @@
 #include <asm/mce.h>
 #include <asm/machdep.h>
 
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
@@ -142,10 +87,8 @@ static int mce_flush(int what)
 		return 1;
 	}
 	if (what == MCE_FLUSH_TLB) {
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
-			return 1;
-		}
+		tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
+		return 1;
 	}
 
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 7ef0993214f3..3e7783cff0c5 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -87,8 +87,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
 		}
 		if (dsisr & DSISR_MC_TLB_MULTI) {
-			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
+			tlbiel_all(TLB_INVAL_SCOPE_LPID);
 			dsisr &= ~DSISR_MC_TLB_MULTI;
 		}
 		/* Any other errors we don't understand? */
@@ -105,8 +104,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		reload_slb(vcpu);
 		break;
 	case SRR1_MC_IFETCH_TLBMULTI:
-		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
+		tlbiel_all(TLB_INVAL_SCOPE_LPID);
 		break;
 	default:
 		handled = 0;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 65bb8f33b399..5e79c04db4fa 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -45,6 +45,88 @@
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
+static inline void __tlbiel_all_isa206(unsigned int set, unsigned int is)
+{
+	unsigned long rb;
+
+	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
+
+	asm volatile("tlbiel %0" : : "r" (rb));
+}
+
+static inline void __tlbiel_all_isa300(unsigned int set, unsigned int is,
+					unsigned int ric, unsigned int prs)
+{
+	unsigned int r = 0; /* hash format */
+	unsigned long rb;
+	unsigned long rs = 0;
+
+	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
+
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+}
+
+static void tlbiel_all_isa206(unsigned int num_sets, unsigned int is)
+{
+	unsigned int set;
+
+	asm volatile("ptesync": : :"memory");
+
+	for (set = 0; set < num_sets; set++)
+		__tlbiel_all_isa206(set, is);
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
+	__tlbiel_all_isa300(0, is, 2, 0);
+	for (set = 1; set < num_sets; set++)
+		__tlbiel_all_isa300(set, is, 0, 0);
+
+	/* Flush process table entries */
+	__tlbiel_all_isa300(0, is, 2, 1);
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
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		tlbiel_all_isa300(POWER9_TLB_SETS_HASH, is);
+	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		tlbiel_all_isa206(POWER8_TLB_SETS, is);
+	else if (cpu_has_feature(CPU_FTR_ARCH_206))
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
index f2095ce9d4b0..c98e085a25ec 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1044,6 +1044,8 @@ void __init hash__early_init_mmu(void)
 	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
 	slb_initialize();
+
+	tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
 }
 
 #ifdef CONFIG_SMP
@@ -1063,6 +1065,8 @@ void hash__early_init_mmu_secondary(void)
 	}
 	/* Initialize SLB */
 	slb_initialize();
+
+	tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c28165d8970b..fbf9e8fb20ba 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -426,6 +426,8 @@ void __init radix__early_init_mmu(void)
 
 	radix_init_iamr();
 	radix_init_pgtable();
+
+	tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
 }
 
 void radix__early_init_mmu_secondary(void)
@@ -447,6 +449,8 @@ void radix__early_init_mmu_secondary(void)
 		radix_init_amor();
 	}
 	radix_init_iamr();
+
+	tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
 }
 
 void radix__mmu_cleanup_all(void)
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 5e17c4e873a5..b2758a48e12b 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -23,6 +23,63 @@ static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 #define RIC_FLUSH_PWC 1
 #define RIC_FLUSH_ALL 2
 
+static inline void __tlbiel_all_isa300(unsigned int set, unsigned int is,
+					unsigned int ric, unsigned int prs)
+{
+	unsigned int r = 1; /* radix format */
+	unsigned long rb;
+	unsigned long rs = 0;
+
+	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
+
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+}
+
+static void tlbiel_all_isa300(unsigned int num_sets, unsigned int is)
+{
+	unsigned int set;
+
+	asm volatile("ptesync": : :"memory");
+
+	/*
+	 * Flush the first set of the TLB, and the entire Page Walk Cache.
+	 * Then flush the remaining sets of the TLB.
+	 */
+	__tlbiel_all_isa300(0, is, RIC_FLUSH_ALL, 1);
+	for (set = 1; set < num_sets; set++)
+		__tlbiel_all_isa300(set, is, RIC_FLUSH_TLB, 1);
+
+	/* Do the same for partitioned scoped entries. */
+	__tlbiel_all_isa300(0, is, RIC_FLUSH_ALL, 0);
+	for (set = 1; set < num_sets; set++)
+		__tlbiel_all_isa300(set, is, RIC_FLUSH_TLB, 0);
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
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		tlbiel_all_isa300(POWER9_TLB_SETS_RADIX, is);
+	else
+		WARN(1, "%s called on pre-POWER9 CPU\n", __func__);
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+}
+
 static inline void __tlbiel_pid(unsigned long pid, int set,
 				unsigned long ric)
 {
-- 
2.11.0
