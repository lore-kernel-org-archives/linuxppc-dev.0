Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D83041A0186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:08 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D46EC140E01
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:04 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 62DF6394004E
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwxG51970096
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwIV007404
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 4/8] powerpc/slb: Add some helper functions to improve
 modularization
Date: Tue, 21 Jul 2015 12:28:42 +0530
Message-Id: <1437461926-8908-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

This patch adds the following helper functions to improve modularization
and readability of the code.

(1) slb_invalid_all: 		Invalidates entire SLB
(2) slb_invalid_paca_slots: 	Invalidate SLB entries present in PACA
(3) kernel_linear_vsid_flags:	VSID flags for kernel linear mapping
(4) kernel_virtual_vsid_flags:	VSID flags for kernel virtual mapping

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 87 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index cbeaaa2..dcba4c2 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -94,18 +94,37 @@ static inline void new_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
+static inline unsigned long kernel_linear_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
+}
+
+static inline unsigned long kernel_virtual_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
+}
+
+static inline unsigned long kernel_io_vsid_flags(void)
+{
+	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
+}
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static inline unsigned long kernel_vmemmap_vsid_flags(void)
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
+	lflags = kernel_linear_vsid_flags();
+	vflags = kernel_virtual_vsid_flags();
 	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, SLOT_KSTACK);
 	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
@@ -153,7 +172,7 @@ void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
 
-	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
+	vflags = kernel_virtual_vsid_flags();
 	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, SLOT_KVIRT);
 	slb_flush_and_rebolt();
 }
@@ -187,6 +206,23 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 	return (GET_ESID_1T(addr1) == GET_ESID_1T(addr2));
 }
 
+static void slb_invalid_paca_slots(unsigned long offset)
+{
+	unsigned long slbie_data;
+	int i;
+
+	asm volatile("isync" : : : "memory");
+	for (i = 0; i < offset; i++) {
+		slbie_data = (unsigned long)get_paca()->slb_cache[i]
+			<< SID_SHIFT; /* EA */
+		slbie_data |= user_segment_size(slbie_data)
+			<< SLBIE_SSIZE_SHIFT;
+		slbie_data |= SLBIE_C; /* C set for user addresses */
+		asm volatile("slbie %0" : : "r" (slbie_data));
+	}
+	asm volatile("isync" : : : "memory");
+}
+
 /* Flush all user entries from the segment table of the current processor. */
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -206,17 +242,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	offset = get_paca()->slb_cache_ptr;
 	if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
 	    offset <= SLB_CACHE_ENTRIES) {
-		int i;
-		asm volatile("isync" : : : "memory");
-		for (i = 0; i < offset; i++) {
-			slbie_data = (unsigned long)get_paca()->slb_cache[i]
-				<< SID_SHIFT; /* EA */
-			slbie_data |= user_segment_size(slbie_data)
-				<< SLBIE_SSIZE_SHIFT;
-			slbie_data |= SLBIE_C; /* C set for user addresses */
-			asm volatile("slbie %0" : : "r" (slbie_data));
-		}
-		asm volatile("isync" : : : "memory");
+		slb_invalid_paca_slots(offset);
 	} else {
 		__slb_flush_and_rebolt();
 	}
@@ -256,6 +282,14 @@ static inline void patch_slb_encoding(unsigned int *insn_addr,
 	patch_instruction(insn_addr, insn);
 }
 
+/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+static inline void slb_invalid_all(void)
+{
+	asm volatile("isync":::"memory");
+	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+	asm volatile("isync; slbia; isync":::"memory");
+}
+
 extern u32 slb_miss_kernel_load_linear[];
 extern u32 slb_miss_kernel_load_io[];
 extern u32 slb_compare_rr_to_size[];
@@ -283,16 +317,16 @@ void slb_initialize(void)
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
 	io_llp = mmu_psize_defs[mmu_io_psize].sllp;
 	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	get_paca()->vmalloc_sllp = SLB_VSID_KERNEL | vmalloc_llp;
+	get_paca()->vmalloc_sllp = kernel_virtual_vsid_flags();
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	vmemmap_llp = mmu_psize_defs[mmu_vmemmap_psize].sllp;
 #endif
 	if (!slb_encoding_inited) {
 		slb_encoding_inited = 1;
 		patch_slb_encoding(slb_miss_kernel_load_linear,
-				   SLB_VSID_KERNEL | linear_llp);
+				   kernel_linear_vsid_flags());
 		patch_slb_encoding(slb_miss_kernel_load_io,
-				   SLB_VSID_KERNEL | io_llp);
+				   kernel_io_vsid_flags());
 		patch_slb_encoding(slb_compare_rr_to_size,
 				   mmu_slb_size);
 
@@ -301,20 +335,17 @@ void slb_initialize(void)
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 		patch_slb_encoding(slb_miss_kernel_load_vmemmap,
-				   SLB_VSID_KERNEL | vmemmap_llp);
+				   kernel_vmemmap_vsid_flags());
 		pr_devel("SLB: vmemmap LLP = %04lx\n", vmemmap_llp);
 #endif
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED;
 
-	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | vmalloc_llp;
+	lflags = kernel_linear_vsid_flags();
+	vflags = kernel_virtual_vsid_flags();
 
-	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
-	asm volatile("isync":::"memory");
-	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
-	asm volatile("isync; slbia; isync":::"memory");
+	slb_invalid_all();
 	new_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, SLOT_KLINR);
 	new_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, SLOT_KVIRT);
 
-- 
2.1.0
