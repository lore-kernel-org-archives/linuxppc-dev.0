Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BC251A073C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:18 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 19:38:01 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 992AF3578048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T9LB2v131372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:21:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T9cDVo008398
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 8/8] powerpc: thp: Add tracepoints to track hugepage invalidate
Date: Tue, 29 Jul 2014 15:07:49 +0530
Message-Id: <1406626669-31154-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add tracepoint to track hugepage invalidate. This help us
in debugging difficult to track bugs.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c |  6 +++
 arch/powerpc/mm/tlb_hash64.c |  4 ++
 include/trace/events/thp.h   | 88 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 include/trace/events/thp.h

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 71d084b6f766..ecc4079ca56c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -54,6 +54,9 @@
 
 #include "mmu_decl.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/thp.h>
+
 /* Some sanity checking */
 #if TASK_SIZE_USER64 > PGTABLE_RANGE
 #error TASK_SIZE_USER64 exceeds pagetable range
@@ -537,6 +540,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	old = pmd_val(*pmdp);
 	*pmdp = __pmd((old & ~clr) | set);
 #endif
+	trace_hugepage_update(addr, old, clr, set);
 	if (old & _PAGE_HASHPTE)
 		hpte_do_hugepage_flush(mm, addr, pmdp, old);
 	return old;
@@ -642,6 +646,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 	 * If we didn't had the splitting flag set, go and flush the
 	 * HPTE entries.
 	 */
+	trace_hugepage_splitting(address, old);
 	if (!(old & _PAGE_SPLITTING)) {
 		/* We need to flush the hpte */
 		if (old & _PAGE_HASHPTE)
@@ -709,6 +714,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
+	trace_hugepage_set_pmd(addr, pmd);
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
 }
 
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 9adda5790463..d2a94b85dbc2 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -30,6 +30,8 @@
 #include <asm/tlb.h>
 #include <asm/bug.h>
 
+#include <trace/events/thp.h>
+
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
 /*
@@ -213,6 +215,8 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 		if (ptep == NULL)
 			continue;
 		pte = pte_val(*ptep);
+		if (hugepage_shift)
+			trace_hugepage_invalidate(start, pte_val(pte));
 		if (!(pte & _PAGE_HASHPTE))
 			continue;
 		if (unlikely(hugepage_shift && pmd_trans_huge(*(pmd_t *)pte)))
diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
new file mode 100644
index 000000000000..b59b065e9e5d
--- /dev/null
+++ b/include/trace/events/thp.h
@@ -0,0 +1,88 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM thp
+
+#if !defined(_TRACE_THP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_THP_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(hugepage_invalidate,
+
+	    TP_PROTO(unsigned long addr, unsigned long pte),
+	    TP_ARGS(addr, pte),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, pte)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->pte = pte;
+		    ),
+
+	    TP_printk("hugepage invalidate at addr 0x%lx and pte = 0x%lx",
+		      __entry->addr, __entry->pte)
+);
+
+TRACE_EVENT(hugepage_set_pmd,
+
+	    TP_PROTO(unsigned long addr, unsigned long pmd),
+	    TP_ARGS(addr, pmd),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, pmd)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->pmd = pmd;
+		    ),
+
+	    TP_printk("Set pmd with 0x%lx with 0x%lx", __entry->addr, __entry->pmd)
+);
+
+
+TRACE_EVENT(hugepage_update,
+
+	    TP_PROTO(unsigned long addr, unsigned long pte, unsigned long clr, unsigned long set),
+	    TP_ARGS(addr, pte, clr, set),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, pte)
+		    __field(unsigned long, clr)
+		    __field(unsigned long, set)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->pte = pte;
+		    __entry->clr = clr;
+		    __entry->set = set;
+
+		    ),
+
+	    TP_printk("hugepage update at addr 0x%lx and pte = 0x%lx clr = 0x%lx, set = 0x%lx", __entry->addr, __entry->pte, __entry->clr, __entry->set)
+);
+TRACE_EVENT(hugepage_splitting,
+
+	    TP_PROTO(unsigned long addr, unsigned long pte),
+	    TP_ARGS(addr, pte),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, pte)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->pte = pte;
+		    ),
+
+	    TP_printk("hugepage splitting at addr 0x%lx and pte = 0x%lx",
+		      __entry->addr, __entry->pte)
+);
+
+#endif /* _TRACE_THP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.9.1
