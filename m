Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17549.10162.616962.755474@cargo.ozlabs.ibm.com>
Date: Mon, 12 Jun 2006 18:37:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove unused paca->pgdir field
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pgdir field in the paca was a leftover from the dynamic VSIDs
patch, and is not used in the current kernel code.  This removes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8f85c5e..aa0486d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -122,9 +122,6 @@ #ifdef CONFIG_PPC64
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
-#ifdef CONFIG_PPC_64K_PAGES
-	DEFINE(PACAPGDIR, offsetof(struct paca_struct, pgdir));
-#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	DEFINE(PACALOWHTLBAREAS, offsetof(struct paca_struct, context.low_htlb_areas));
 	DEFINE(PACAHIGHHTLBAREAS, offsetof(struct paca_struct, context.high_htlb_areas));
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index ffc8ed4..2cc6173 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -122,9 +122,6 @@ void switch_slb(struct task_struct *tsk,
 
 	get_paca()->slb_cache_ptr = 0;
 	get_paca()->context = mm->context;
-#ifdef CONFIG_PPC_64K_PAGES
-	get_paca()->pgdir = mm->pgd;
-#endif /* CONFIG_PPC_64K_PAGES */
 
 	/*
 	 * preload some userspace segments into the SLB.
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 4a9291d..691320c 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -200,10 +200,6 @@ void switch_stab(struct task_struct *tsk
 
 	__get_cpu_var(stab_cache_ptr) = 0;
 
-#ifdef CONFIG_PPC_64K_PAGES
-	get_paca()->pgdir = mm->pgd;
-#endif /* CONFIG_PPC_64K_PAGES */
-
 	/* Now preload some entries for the new task */
 	if (test_tsk_thread_flag(tsk, TIF_32BIT))
 		unmapped_base = TASK_UNMAPPED_BASE_USER32;
diff --git a/include/asm-powerpc/mmu_context.h b/include/asm-powerpc/mmu_context.h
index 1b8a25f..8c6b1a6 100644
--- a/include/asm-powerpc/mmu_context.h
+++ b/include/asm-powerpc/mmu_context.h
@@ -20,16 +20,9 @@ #include <asm/cputable.h>
  * 2 of the License, or (at your option) any later version.
  */
 
-/*
- * Getting into a kernel thread, there is no valid user segment, mark
- * paca->pgdir NULL so that SLB miss on user addresses will fault
- */
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
-#ifdef CONFIG_PPC_64K_PAGES
-	get_paca()->pgdir = NULL;
-#endif /* CONFIG_PPC_64K_PAGES */
 }
 
 #define NO_CONTEXT	0
@@ -52,13 +45,8 @@ static inline void switch_mm(struct mm_s
 		cpu_set(smp_processor_id(), next->cpu_vm_mask);
 
 	/* No need to flush userspace segments if the mm doesnt change */
-#ifdef CONFIG_PPC_64K_PAGES
-	if (prev == next && get_paca()->pgdir == next->pgd)
-		return;
-#else
 	if (prev == next)
 		return;
-#endif /* CONFIG_PPC_64K_PAGES */
 
 #ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 706325f..c17fd54 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -79,9 +79,6 @@ #endif /* CONFIG_PPC_ISERIES */
 	u64 exmc[10];		/* used for machine checks */
 	u64 exslb[10];		/* used for SLB/segment table misses
  				 * on the linear mapping */
-#ifdef CONFIG_PPC_64K_PAGES
-	pgd_t *pgdir;
-#endif /* CONFIG_PPC_64K_PAGES */
 
 	mm_context_t context;
 	u16 slb_cache[SLB_CACHE_ENTRIES];
