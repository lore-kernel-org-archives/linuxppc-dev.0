Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1773D1A0216
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 15:54:24 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org,
 Cyril Bur <cyrilbur@gmail.com>
Subject: [PATCH 1/2] powerpc: Add function to copy mm_context_t to the paca
Date: Wed, 28 Oct 2015 15:54:06 +1100
Message-Id: <1446008047-2393-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a function to copy the mm->context to the paca.  This is
only a basic conversion for now but will be used more extensively in
the next patch.

This also adds #ifdef CONFIG_PPC_BOOK3S around this code since it's
not used elsewhere.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/paca.h   | 11 +++++++++++
 arch/powerpc/kernel/asm-offsets.c |  2 ++
 arch/powerpc/mm/hash_utils_64.c   |  5 +++--
 arch/powerpc/mm/slb.c             |  2 +-
 arch/powerpc/mm/slice.c           |  3 +--
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 70bd438..1cc6e08 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -131,7 +131,9 @@ struct paca_struct {
 	struct tlb_core_data tcd;
 #endif /* CONFIG_PPC_BOOK3E */
 
+#ifdef CONFIG_PPC_BOOK3S
 	mm_context_t context;
+#endif
 
 	/*
 	 * then miscellaneous read-write fields
@@ -194,6 +196,15 @@ struct paca_struct {
 #endif
 };
 
+#ifdef CONFIG_PPC_BOOK3S
+static inline void copy_mm_to_paca(mm_context_t *context)
+{
+	get_paca()->context = *context;
+}
+#else
+static inline void copy_mm_to_paca(mm_context_t *context){}
+#endif
+
 extern struct paca_struct *paca;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 221d584..9db7be2 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -185,6 +185,7 @@ int main(void)
 	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
 	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
 	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
+#ifdef CONFIG_PPC_BOOK3S
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
 #ifdef CONFIG_PPC_MM_SLICES
 	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
@@ -193,6 +194,7 @@ int main(void)
 					    context.high_slices_psize));
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
+#endif
 
 #ifdef CONFIG_PPC_BOOK3E
 	DEFINE(PACAPGD, offsetof(struct paca_struct, pgd));
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index aee7017..fa62eb0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -906,7 +906,8 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
 	copro_flush_all_slbs(mm);
 	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
-		get_paca()->context = mm->context;
+
+		copy_mm_to_paca(&mm->context);
 		slb_flush_and_rebolt();
 	}
 }
@@ -973,7 +974,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 {
 	if (user_region) {
 		if (psize != get_paca_psize(ea)) {
-			get_paca()->context = mm->context;
+			copy_mm_to_paca(&mm->context);
 			slb_flush_and_rebolt();
 		}
 	} else if (get_paca()->vmalloc_sllp !=
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 8a32a2be..4412b8e 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -223,7 +223,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		asm volatile("slbie %0" : : "r" (slbie_data));
 
 	get_paca()->slb_cache_ptr = 0;
-	get_paca()->context = mm->context;
+	copy_mm_to_paca(&mm->context);
 
 	/*
 	 * preload some userspace segments into the SLB.
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 0f432a7..42954f0 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -185,8 +185,7 @@ static void slice_flush_segments(void *parm)
 	if (mm != current->active_mm)
 		return;
 
-	/* update the paca copy of the context struct */
-	get_paca()->context = current->active_mm->context;
+	copy_mm_to_paca(&current->active_mm->context);
 
 	local_irq_save(flags);
 	slb_flush_and_rebolt();
-- 
2.5.0
