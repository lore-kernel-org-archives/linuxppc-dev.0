Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4YM1mwxzDr0Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:29:43 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72KSqHj049112
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 16:29:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c3fxx1j0j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 16:29:39 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 21:29:38 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, alistair@popple.id.au,
 vaibhav@linux.vnet.ibm.com
Subject: [PATCH v3 1/3] powerpc/mm: Add marker for contexts requiring global
 TLB invalidations
Date: Wed,  2 Aug 2017 22:29:28 +0200
In-Reply-To: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
References: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170802202930.5616-2-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a new 'flags' attribute per context and define its first bit
to be a marker requiring all TLBIs for that context to be broadcasted
globally. Once that marker is set on a context, it cannot be removed.

Such a marker is useful for memory contexts used by devices behind the
NPU and CAPP/PSL. The NPU and the PSL keep their own translation cache
so they need to see all the TLBIs for those contexts.

Rename mm_is_thread_local() to mm_is_invalidation_local() to better
describe what it's doing.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 18 ++++++++++++++++++
 arch/powerpc/include/asm/tlb.h           | 27 +++++++++++++++++++++++----
 arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
 arch/powerpc/mm/tlb-radix.c              |  8 ++++----
 arch/powerpc/mm/tlb_hash64.c             |  3 ++-
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 5b4023c616f7..03d4515ecfa6 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -79,8 +79,12 @@ struct spinlock;
 /* Maximum possible number of NPUs in a system. */
 #define NV_MAX_NPUS 8
 
+/* Bits definition for the context flags */
+#define MM_GLOBAL_TLBIE	0	/* TLBI must be global */
+
 typedef struct {
 	mm_context_id_t id;
+	unsigned long flags;
 	u16 user_psize;		/* page size index */
 
 	/* NPU NMMU context */
@@ -165,5 +169,19 @@ extern void radix_init_pseries(void);
 static inline void radix_init_pseries(void) { };
 #endif
 
+/*
+ * Mark the memory context as requiring global TLBIs, when used by
+ * GPUs or CAPI accelerators managing their own TLB or ERAT.
+ */
+static inline void mm_context_set_global_tlbi(mm_context_t *ctx)
+{
+	set_bit(MM_GLOBAL_TLBIE, &ctx->flags);
+}
+
+static inline bool mm_context_get_global_tlbi(mm_context_t *ctx)
+{
+	return test_bit(MM_GLOBAL_TLBIE, &ctx->flags);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 609557569f65..f06dcac82097 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -69,10 +69,29 @@ static inline int mm_is_core_local(struct mm_struct *mm)
 			      topology_sibling_cpumask(smp_processor_id()));
 }
 
-static inline int mm_is_thread_local(struct mm_struct *mm)
+static inline int mm_is_invalidation_local(struct mm_struct *mm)
 {
-	return cpumask_equal(mm_cpumask(mm),
-			      cpumask_of(smp_processor_id()));
+	int rc;
+
+	rc = cpumask_equal(mm_cpumask(mm),
+			cpumask_of(smp_processor_id()));
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (rc) {
+		/*
+		 * Check if context requires global TLBI.
+		 *
+		 * We need to make sure the PTE update is happening
+		 * before reading the context global flag. Otherwise,
+		 * reading the flag may be re-ordered and happen
+		 * first, and we could end up in a situation where the
+		 * old PTE was seen by the NPU/PSL/device, but the
+		 * TLBI is local.
+		 */
+		mb();
+		rc = !mm_context_get_global_tlbi(&mm->context);
+	}
+#endif
+	return rc;
 }
 
 #else
@@ -81,7 +100,7 @@ static inline int mm_is_core_local(struct mm_struct *mm)
 	return 1;
 }
 
-static inline int mm_is_thread_local(struct mm_struct *mm)
+static inline int mm_is_invalidation_local(struct mm_struct *mm)
 {
 	return 1;
 }
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index a75f63833284..4dfe57f9c3b0 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -165,6 +165,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 		return index;
 
 	mm->context.id = index;
+	mm->context.flags = 0;
 #ifdef CONFIG_PPC_ICSWX
 	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
 	if (!mm->context.cop_lockp) {
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 16ae1bbe13f0..620ed7dced44 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -207,7 +207,7 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-	if (!mm_is_thread_local(mm))
+	if (!mm_is_invalidation_local(mm))
 		_tlbie_pid(pid, RIC_FLUSH_ALL);
 	else
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
@@ -233,7 +233,7 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-	if (!mm_is_thread_local(mm))
+	if (!mm_is_invalidation_local(mm))
 		_tlbie_pid(pid, RIC_FLUSH_PWC);
 	else
 		tlbiel_pwc(pid);
@@ -252,7 +252,7 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
-	if (!mm_is_thread_local(mm))
+	if (!mm_is_invalidation_local(mm))
 		_tlbie_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 	else
 		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
@@ -335,7 +335,7 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long pid;
 	unsigned long addr;
-	int local = mm_is_thread_local(mm);
+	int local = mm_is_invalidation_local(mm);
 	unsigned long ap = mmu_get_ap(psize);
 	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
 
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index b5b0fb97b9c0..618865cdc793 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -96,7 +96,8 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 * flush now and return.
 	 */
 	if (!batch->active) {
-		flush_hash_page(vpn, rpte, psize, ssize, mm_is_thread_local(mm));
+		flush_hash_page(vpn, rpte, psize, ssize,
+				mm_is_invalidation_local(mm));
 		put_cpu_var(ppc64_tlb_batch);
 		return;
 	}
-- 
2.11.0
