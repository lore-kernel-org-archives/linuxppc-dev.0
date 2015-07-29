Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFC971A1A35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:39 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40C5C140E3F
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:36 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7814E394006D
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A7aJ40960026
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A6BH001182
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 4/8] powerpc/slb: Add some helper functions to improve
 modularization
Date: Wed, 29 Jul 2015 12:40:01 +0530
Message-Id: <1438153805-31828-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the following six helper functions to help improve
modularization and readability of the code.

(1) slb_invalidate_all:		Invalidates the entire SLB
(2) slb_invalidate:		Invalidates SLB entries present in PACA
(3) mmu_linear_vsid_flags:	VSID flags for kernel linear mapping
(4) mmu_virtual_vsid_flags:	VSID flags for kernel virtual mapping
(5) mmu_vmemmap_vsid_flags:	VSID flags for kernel vmem mapping
(6) mmu_io_vsid_flags:		VSID flags for kernel I/O mapping

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 92 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 701a57f..c87d5de 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -96,18 +96,37 @@ static inline void new_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
+static inline unsigned long mmu_linear_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
+}
+
+static inline unsigned long mmu_vmalloc_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
+}
+
+static inline unsigned long mmu_io_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
+}
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static inline unsigned long mmu_vmemmap_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmemmap_psize].sllp;
+}
+#endif
+
 static void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * and PR KVM appropriately too. */
-	unsigned long linear_llp, vmalloc_llp, lflags, vflags;
+	unsigned long lflags, vflags;
 	unsigned long ksp_esid_data, ksp_vsid_data;
 
-	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | vmalloc_llp;
-
+	lflags = mmu_linear_vsid_flags();
+	vflags = mmu_vmalloc_vsid_flags();
 	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, KSTACK_SLOT);
 	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
@@ -155,7 +174,7 @@ void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
 
-	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
+	vflags = mmu_vmalloc_vsid_flags();
 	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_SLOT);
 	slb_flush_and_rebolt();
 }
@@ -189,26 +208,15 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 	return (GET_ESID_1T(addr1) == GET_ESID_1T(addr2));
 }
 
-/* Flush all user entries from the segment table of the current processor. */
-void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
+static void slb_invalidate(void)
 {
-	unsigned long offset;
 	unsigned long slbie_data = 0;
-	unsigned long pc = KSTK_EIP(tsk);
-	unsigned long stack = KSTK_ESP(tsk);
-	unsigned long exec_base;
+	unsigned long offset;
+	int i;
 
-	/*
-	 * We need interrupts hard-disabled here, not just soft-disabled,
-	 * so that a PMU interrupt can't occur, which might try to access
-	 * user memory (to get a stack trace) and possible cause an SLB miss
-	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
-	 */
-	hard_irq_disable();
 	offset = get_paca()->slb_cache_ptr;
 	if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
 	    offset <= SLB_CACHE_ENTRIES) {
-		int i;
 		asm volatile("isync" : : : "memory");
 		for (i = 0; i < offset; i++) {
 			slbie_data = (unsigned long)get_paca()->slb_cache[i]
@@ -226,6 +234,23 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	/* Workaround POWER5 < DD2.1 issue */
 	if (offset == 1 || offset > SLB_CACHE_ENTRIES)
 		asm volatile("slbie %0" : : "r" (slbie_data));
+}
+
+/* Flush all user entries from the segment table of the current processor. */
+void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
+{
+	unsigned long pc = KSTK_EIP(tsk);
+	unsigned long stack = KSTK_ESP(tsk);
+	unsigned long exec_base;
+
+	/*
+	 * We need interrupts hard-disabled here, not just soft-disabled,
+	 * so that a PMU interrupt can't occur, which might try to access
+	 * user memory (to get a stack trace) and possible cause an SLB miss
+	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
+	 */
+	hard_irq_disable();
+	slb_invalidate();
 
 	get_paca()->slb_cache_ptr = 0;
 	get_paca()->context = mm->context;
@@ -258,6 +283,14 @@ static inline void patch_slb_encoding(unsigned int *insn_addr,
 	patch_instruction(insn_addr, insn);
 }
 
+/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+static inline void slb_invalidate_all(void)
+{
+	asm volatile("isync":::"memory");
+	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+	asm volatile("isync; slbia; isync":::"memory");
+}
+
 extern u32 slb_miss_kernel_load_linear[];
 extern u32 slb_miss_kernel_load_io[];
 extern u32 slb_compare_rr_to_size[];
@@ -285,16 +318,16 @@ void slb_initialize(void)
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
 	io_llp = mmu_psize_defs[mmu_io_psize].sllp;
 	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	get_paca()->vmalloc_sllp = SLB_VSID_KERNEL | vmalloc_llp;
+	get_paca()->vmalloc_sllp = mmu_vmalloc_vsid_flags();
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	vmemmap_llp = mmu_psize_defs[mmu_vmemmap_psize].sllp;
 #endif
 	if (!slb_encoding_inited) {
 		slb_encoding_inited = 1;
 		patch_slb_encoding(slb_miss_kernel_load_linear,
-				   SLB_VSID_KERNEL | linear_llp);
+				   mmu_linear_vsid_flags());
 		patch_slb_encoding(slb_miss_kernel_load_io,
-				   SLB_VSID_KERNEL | io_llp);
+				   mmu_io_vsid_flags());
 		patch_slb_encoding(slb_compare_rr_to_size,
 				   mmu_slb_size);
 
@@ -303,20 +336,17 @@ void slb_initialize(void)
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 		patch_slb_encoding(slb_miss_kernel_load_vmemmap,
-				   SLB_VSID_KERNEL | vmemmap_llp);
+				   mmu_vmemmap_vsid_flags());
 		pr_devel("SLB: vmemmap LLP = %04lx\n", vmemmap_llp);
 #endif
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED;
 
-	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | vmalloc_llp;
+	lflags = mmu_linear_vsid_flags();
+	vflags = mmu_vmalloc_vsid_flags();
 
-	/* Invalidate the entire SLB (even entry 0) & all the ERATS */
-	asm volatile("isync":::"memory");
-	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
-	asm volatile("isync; slbia; isync":::"memory");
+	slb_invalidate_all();
 	new_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, LINEAR_SLOT);
 	new_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_SLOT);
 
-- 
2.1.0
