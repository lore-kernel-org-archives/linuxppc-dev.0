Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v83c4THWzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:42:20 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id j8-v6so6822774pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 02:42:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 2/5] powerpc/64s/hash: remove user SLB data from the paca
Date: Mon, 20 Aug 2018 19:41:57 +1000
Message-Id: <20180820094200.13003-3-npiggin@gmail.com>
In-Reply-To: <20180820094200.13003-1-npiggin@gmail.com>
References: <20180820094200.13003-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

User SLB mappig data is copied into the PACA from the mm->context
so it can be accessed by the SLB miss handlers.

After the previous patch, SLB miss handlers now run with relocation
on, and user SLB misses are able to take recursive kernel SLB misses,
so the user SLB mapping data can be removed from the paca and
accessed directly.
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
 arch/powerpc/include/asm/paca.h               | 13 ------
 arch/powerpc/kernel/asm-offsets.c             |  9 ----
 arch/powerpc/kernel/paca.c                    | 21 ---------
 arch/powerpc/mm/hash_utils_64.c               | 46 +++++--------------
 arch/powerpc/mm/mmu_context.c                 |  3 +-
 arch/powerpc/mm/slb.c                         | 20 +++++++-
 arch/powerpc/mm/slice.c                       | 29 ++++--------
 8 files changed, 40 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b3520b549cba..39764214aef5 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -496,6 +496,7 @@ static inline void hpte_init_pseries(void) { }
 extern void hpte_init_native(void);
 
 extern void slb_initialize(void);
+extern void core_flush_all_slbs(struct mm_struct *mm);
 extern void slb_flush_and_rebolt(void);
 void slb_flush_all_realmode(void);
 void __slb_restore_bolted_realmode(void);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 4331295db0f7..8c258a057207 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -143,18 +143,6 @@ struct paca_struct {
 	struct tlb_core_data tcd;
 #endif /* CONFIG_PPC_BOOK3E */
 
-#ifdef CONFIG_PPC_BOOK3S
-	mm_context_id_t mm_ctx_id;
-#ifdef CONFIG_PPC_MM_SLICES
-	unsigned char mm_ctx_low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
-	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
-	unsigned long mm_ctx_slb_addr_limit;
-#else
-	u16 mm_ctx_user_psize;
-	u16 mm_ctx_sllp;
-#endif
-#endif
-
 	/*
 	 * then miscellaneous read-write fields
 	 */
@@ -256,7 +244,6 @@ struct paca_struct {
 #endif /* CONFIG_PPC_PSERIES */
 } ____cacheline_aligned;
 
-extern void copy_mm_to_paca(struct mm_struct *mm);
 extern struct paca_struct **paca_ptrs;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7834256585f1..43b67ead5b97 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -181,15 +181,6 @@ int main(void)
 	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 	OFFSET(PACA_FTRACE_ENABLED, paca_struct, ftrace_enabled);
-#ifdef CONFIG_PPC_BOOK3S
-	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
-#ifdef CONFIG_PPC_MM_SLICES
-	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
-	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
-	OFFSET(PACA_SLB_ADDR_LIMIT, paca_struct, mm_ctx_slb_addr_limit);
-	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
-#endif /* CONFIG_PPC_MM_SLICES */
-#endif
 
 #ifdef CONFIG_PPC_BOOK3E
 	OFFSET(PACAPGD, paca_struct, pgd);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0ee3e6d50f28..6752e17f0281 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -259,24 +259,3 @@ void __init free_unused_pacas(void)
 			paca_ptrs_size + paca_struct_size, nr_cpu_ids);
 }
 
-void copy_mm_to_paca(struct mm_struct *mm)
-{
-#ifdef CONFIG_PPC_BOOK3S
-	mm_context_t *context = &mm->context;
-
-	get_paca()->mm_ctx_id = context->id;
-#ifdef CONFIG_PPC_MM_SLICES
-	VM_BUG_ON(!mm->context.slb_addr_limit);
-	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
-	memcpy(&get_paca()->mm_ctx_low_slices_psize,
-	       &context->low_slices_psize, sizeof(context->low_slices_psize));
-	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
-#else /* CONFIG_PPC_MM_SLICES */
-	get_paca()->mm_ctx_user_psize = context->user_psize;
-	get_paca()->mm_ctx_sllp = context->sllp;
-#endif
-#else /* !CONFIG_PPC_BOOK3S */
-	return;
-#endif
-}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f23a89d8e4ce..88c95dc8b141 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1088,16 +1088,16 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 }
 
 #ifdef CONFIG_PPC_MM_SLICES
-static unsigned int get_paca_psize(unsigned long addr)
+static unsigned int get_psize(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned char *psizes;
 	unsigned long index, mask_index;
 
 	if (addr < SLICE_LOW_TOP) {
-		psizes = get_paca()->mm_ctx_low_slices_psize;
+		psizes = mm->context.low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {
-		psizes = get_paca()->mm_ctx_high_slices_psize;
+		psizes = mm->context.high_slices_psize;
 		index = GET_HIGH_SLICE_INDEX(addr);
 	}
 	mask_index = index & 0x1;
@@ -1105,9 +1105,9 @@ static unsigned int get_paca_psize(unsigned long addr)
 }
 
 #else
-unsigned int get_paca_psize(unsigned long addr)
+unsigned int get_psize(struct mm_struct *mm, unsigned long addr)
 {
-	return get_paca()->mm_ctx_user_psize;
+	return mm->context.user_psize;
 }
 #endif
 
@@ -1118,15 +1118,11 @@ unsigned int get_paca_psize(unsigned long addr)
 #ifdef CONFIG_PPC_64K_PAGES
 void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
-	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
+	if (get_psize(mm, addr) == MMU_PAGE_4K)
 		return;
 	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
 	copro_flush_all_slbs(mm);
-	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
-
-		copy_mm_to_paca(mm);
-		slb_flush_and_rebolt();
-	}
+	core_flush_all_slbs(mm);
 }
 #endif /* CONFIG_PPC_64K_PAGES */
 
@@ -1191,22 +1187,6 @@ void hash_failure_debug(unsigned long ea, unsigned long access,
 		trap, vsid, ssize, psize, lpsize, pte);
 }
 
-static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
-			     int psize, bool user_region)
-{
-	if (user_region) {
-		if (psize != get_paca_psize(ea)) {
-			copy_mm_to_paca(mm);
-			slb_flush_and_rebolt();
-		}
-	} else if (get_paca()->vmalloc_sllp !=
-		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
-		get_paca()->vmalloc_sllp =
-			mmu_psize_defs[mmu_vmalloc_psize].sllp;
-		slb_vmalloc_update();
-	}
-}
-
 /* Result code is:
  *  0 - handled
  *  1 - normal page fault
@@ -1239,7 +1219,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 			rc = 1;
 			goto bail;
 		}
-		psize = get_slice_psize(mm, ea);
+		psize = get_psize(mm, ea);
 		ssize = user_segment_size(ea);
 		vsid = get_user_vsid(&mm->context, ea, ssize);
 		break;
@@ -1327,9 +1307,6 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 			WARN_ON(1);
 		}
 #endif
-		if (current->mm == mm)
-			check_paca_psize(ea, mm, psize, user_region);
-
 		goto bail;
 	}
 
@@ -1364,15 +1341,14 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 			       "to 4kB pages because of "
 			       "non-cacheable mapping\n");
 			psize = mmu_vmalloc_psize = MMU_PAGE_4K;
+			slb_vmalloc_update();
 			copro_flush_all_slbs(mm);
+			core_flush_all_slbs(mm);
 		}
 	}
 
 #endif /* CONFIG_PPC_64K_PAGES */
 
-	if (current->mm == mm)
-		check_paca_psize(ea, mm, psize, user_region);
-
 #ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
@@ -1460,7 +1436,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 #ifdef CONFIG_PPC_MM_SLICES
 static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 {
-	int psize = get_slice_psize(mm, ea);
+	int psize = get_psize(mm, ea);
 
 	/* We only prefault standard pages for now */
 	if (unlikely(psize != mm->context.user_psize))
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index f84e14f23e50..28ae2835db3d 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -54,8 +54,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * MMU context id, which is then moved to SPRN_PID.
 		 *
 		 * For the hash MMU it is either the first load from slb_cache
-		 * in switch_slb(), and/or the store of paca->mm_ctx_id in
-		 * copy_mm_to_paca().
+		 * in switch_slb(), and/or load of MMU context id.
 		 *
 		 * On the other side, the barrier is in mm/tlb-radix.c for
 		 * radix which orders earlier stores to clear the PTEs vs
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5643879fa2b1..221d94b4f9cf 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -274,8 +274,6 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		get_paca()->slb_cache_ptr = 0;
 	}
 
-	copy_mm_to_paca(mm);
-
 	/*
 	 * preload some userspace segments into the SLB.
 	 * Almost all 32 and 64bit PowerPC executables are linked at
@@ -302,6 +300,24 @@ void slb_set_size(u16 size)
 	mmu_slb_size = size;
 }
 
+static void cpu_flush_slb(void *parm)
+{
+        struct mm_struct *mm = parm;
+        unsigned long flags;
+
+        if (mm != current->active_mm)
+                return;
+
+        local_irq_save(flags);
+        slb_flush_and_rebolt();
+        local_irq_restore(flags);
+}
+
+void core_flush_all_slbs(struct mm_struct *mm)
+{
+	on_each_cpu(cpu_flush_slb, mm, 1);
+}
+
 void slb_initialize(void)
 {
 	unsigned long linear_llp, vmalloc_llp, io_llp;
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 205fe557ca10..606f424aac47 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -207,23 +207,6 @@ static bool slice_check_range_fits(struct mm_struct *mm,
 	return true;
 }
 
-static void slice_flush_segments(void *parm)
-{
-#ifdef CONFIG_PPC64
-	struct mm_struct *mm = parm;
-	unsigned long flags;
-
-	if (mm != current->active_mm)
-		return;
-
-	copy_mm_to_paca(current->active_mm);
-
-	local_irq_save(flags);
-	slb_flush_and_rebolt();
-	local_irq_restore(flags);
-#endif
-}
-
 static void slice_convert(struct mm_struct *mm,
 				const struct slice_mask *mask, int psize)
 {
@@ -289,6 +272,9 @@ static void slice_convert(struct mm_struct *mm,
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 	copro_flush_all_slbs(mm);
+#ifdef CONFIG_PPC64
+	core_flush_all_slbs(mm);
+#endif
 }
 
 /*
@@ -502,8 +488,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 * be already initialised beyond the old address limit.
 		 */
 		mm->context.slb_addr_limit = high_limit;
-
-		on_each_cpu(slice_flush_segments, mm, 1);
+#ifdef CONFIG_PPC64
+		core_flush_all_slbs(mm);
+#endif
 	}
 
 	/* Sanity checks */
@@ -665,8 +652,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		(SLICE_NUM_HIGH &&
 		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
 		slice_convert(mm, &potential_mask, psize);
+#ifdef CONFIG_PPC64
 		if (psize > MMU_PAGE_BASE)
-			on_each_cpu(slice_flush_segments, mm, 1);
+			core_flush_all_slbs(mm);
+#endif
 	}
 	return newaddr;
 
-- 
2.17.0
