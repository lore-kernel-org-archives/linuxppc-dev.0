Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A4A1DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 09:15:26 +1000 (EST)
Date: Wed, 30 Jul 2008 18:15:19 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
In-Reply-To: <64F97436-C94D-4CD7-A217-3C4356C93807@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0807301814310.4922@blarg.am.freescale.net>
References: <1217389038.11188.285.camel@pasglop>
	<C8EC8414-A033-46FE-AFEC-8C2A6AB5B4F7@kernel.crashing.org>
	<1217456772.11188.342.camel@pasglop>
	<64F97436-C94D-4CD7-A217-3C4356C93807@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's the code.. I haven't looked at this in any detail and I didn't
write it.

- k

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index c758407..c502909 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -26,7 +26,13 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/sched.h>

+#ifdef CONFIG_SMP
+#include <linux/rcupdate.h>
+#endif
+
+#include <asm/tlb.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/fixmap.h>
@@ -48,7 +54,7 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */

 extern char etext[], _stext[];

-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_FSL_BOOKE)
 extern void hash_page_sync(void);
 #endif

@@ -79,6 +85,84 @@ extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
 #define PGDIR_ORDER	0
 #endif

+#ifdef CONFIG_SMP
+struct pte_freelist_batch
+{
+	struct rcu_head	rcu;
+	unsigned int	index;
+	struct page *	tables[0];
+	struct mm_struct *mm;
+};
+
+#define PTE_FREELIST_SIZE \
+	((PAGE_SIZE - sizeof(struct pte_freelist_batch)) \
+	  / sizeof(struct page *))
+
+DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
+
+static void pte_free_smp_sync(void *arg)
+{
+	/* Do nothing, just ensure we sync with all CPUs */
+}
+
+/* This is only called when we are critically out of memory
+ * (and fail to get a page in pte_free_tlb).
+ */
+static void pgtable_free_now(struct mm_struct *mm, struct page *pte)
+{
+	smp_call_function(pte_free_smp_sync, NULL, 0, 1);
+
+	pte_free(mm, pte);
+}
+
+static void pte_free_rcu_callback(struct rcu_head *head)
+{
+	struct pte_freelist_batch *batch =
+		container_of(head, struct pte_freelist_batch, rcu);
+	unsigned int i;
+
+	for (i = 0; i < batch->index; i++)
+		pte_free(batch->mm, batch->tables[i]);
+
+	free_page((unsigned long)batch);
+}
+
+static void pte_free_submit(struct pte_freelist_batch *batch)
+{
+	INIT_RCU_HEAD(&batch->rcu);
+	call_rcu(&batch->rcu, pte_free_rcu_callback);
+}
+
+void pgtable_free_tlb(struct mmu_gather *tlb, struct page *pte)
+{
+	/* This is safe since tlb_gather_mmu has disabled preemption */
+        cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
+	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+
+	if (atomic_read(&tlb->mm->mm_users) < 2 ||
+	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
+		pte_free(tlb->mm, pte);
+		return;
+	}
+
+	if (*batchp == NULL) {
+		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
+		if (*batchp == NULL) {
+			pgtable_free_now(tlb->mm, pte);
+			return;
+		}
+		(*batchp)->index = 0;
+	}
+	(*batchp)->tables[(*batchp)->index++] = pte;
+	if ((*batchp)->index == PTE_FREELIST_SIZE) {
+		(*batchp)->mm = tlb->mm;
+		pte_free_submit(*batchp);
+		*batchp = NULL;
+	}
+}
+
+#endif	/* CONFIG_SMP */
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret;
@@ -127,7 +211,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)

 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_FSL_BOOKE)
 	hash_page_sync();
 #endif
 	free_page((unsigned long)pte);
@@ -135,7 +219,7 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)

 void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_FSL_BOOKE)
 	hash_page_sync();
 #endif
 	pgtable_page_dtor(ptepage);
diff --git a/include/asm-powerpc/pgalloc-32.h b/include/asm-powerpc/pgalloc-32.h
index 58c0714..1cb9245 100644
--- a/include/asm-powerpc/pgalloc-32.h
+++ b/include/asm-powerpc/pgalloc-32.h
@@ -36,7 +36,14 @@ extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
 extern void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
 extern void pte_free(struct mm_struct *mm, pgtable_t pte);

+#ifdef CONFIG_SMP
+extern void pgtable_free_tlb(struct mmu_gather *tlb, struct page *pte);
+
+#define __pte_free_tlb(tlb, pte)	pgtable_free_tlb(tlb, pte)
+
+#else
 #define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, (pte))
+#endif	/* CONFIG_SMP */

 #define check_pgt_cache()	do { } while (0)
