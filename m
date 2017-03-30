Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3Fw31FTzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 03/19] powerpc/mm: Move copy_mm_to_paca to paca.c
Date: Thu, 30 Mar 2017 23:03:51 +1100
Message-Id: <1490875447-4016-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We also update the function arg to struct mm_struct. Move this so that function
finds the definition of struct mm_struct. No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h | 18 +-----------------
 arch/powerpc/kernel/paca.c      | 19 +++++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c |  4 ++--
 arch/powerpc/mm/slb.c           |  2 +-
 arch/powerpc/mm/slice.c         |  2 +-
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 708c3e592eeb..f48c250339fd 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -206,23 +206,7 @@ struct paca_struct {
 #endif
 };
 
-#ifdef CONFIG_PPC_BOOK3S
-static inline void copy_mm_to_paca(mm_context_t *context)
-{
-	get_paca()->mm_ctx_id = context->id;
-#ifdef CONFIG_PPC_MM_SLICES
-	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
-	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
-#else
-	get_paca()->mm_ctx_user_psize = context->user_psize;
-	get_paca()->mm_ctx_sllp = context->sllp;
-#endif
-}
-#else
-static inline void copy_mm_to_paca(mm_context_t *context){}
-#endif
-
+extern void copy_mm_to_paca(struct mm_struct *mm);
 extern struct paca_struct *paca;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index dfc479df9634..e2cf745a4b94 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -245,3 +245,22 @@ void __init free_unused_pacas(void)
 
 	free_lppacas();
 }
+
+void copy_mm_to_paca(struct mm_struct *mm)
+{
+#ifdef CONFIG_PPC_BOOK3S
+	mm_context_t *context = &mm->context;
+
+	get_paca()->mm_ctx_id = context->id;
+#ifdef CONFIG_PPC_MM_SLICES
+	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
+	memcpy(&get_paca()->mm_ctx_high_slices_psize,
+	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
+#else /* CONFIG_PPC_MM_SLICES */
+	get_paca()->mm_ctx_user_psize = context->user_psize;
+	get_paca()->mm_ctx_sllp = context->sllp;
+#endif
+#else /* CONFIG_PPC_BOOK3S */
+	return;
+#endif
+}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d0ee17029e99..716255f88bbd 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1133,7 +1133,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 	copro_flush_all_slbs(mm);
 	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
 
-		copy_mm_to_paca(&mm->context);
+		copy_mm_to_paca(mm);
 		slb_flush_and_rebolt();
 	}
 }
@@ -1205,7 +1205,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 {
 	if (user_region) {
 		if (psize != get_paca_psize(ea)) {
-			copy_mm_to_paca(&mm->context);
+			copy_mm_to_paca(mm);
 			slb_flush_and_rebolt();
 		}
 	} else if (get_paca()->vmalloc_sllp !=
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5e01b2ece1d0..98ae810b8c21 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -229,7 +229,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		asm volatile("slbie %0" : : "r" (slbie_data));
 
 	get_paca()->slb_cache_ptr = 0;
-	copy_mm_to_paca(&mm->context);
+	copy_mm_to_paca(mm);
 
 	/*
 	 * preload some userspace segments into the SLB.
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index d1da357583e3..175e0dbce89b 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -192,7 +192,7 @@ static void slice_flush_segments(void *parm)
 	if (mm != current->active_mm)
 		return;
 
-	copy_mm_to_paca(&current->active_mm->context);
+	copy_mm_to_paca(current->active_mm);
 
 	local_irq_save(flags);
 	slb_flush_and_rebolt();
-- 
2.7.4
