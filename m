Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmL551cQzDqMt
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:16:13 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:16:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0620C38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:16:08 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396G70p38142032
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:16:07 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396G7ZG032145
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:16:07 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 38/68] powerpc/mm: Hash linux abstraction for tlbflush
 routines
Date: Sat,  9 Apr 2016 11:43:34 +0530
Message-Id: <1460182444-2468-39-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 28 ++++++-----
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 56 ++++++++++++++++++++++
 arch/powerpc/include/asm/tlbflush.h                |  2 +-
 arch/powerpc/mm/tlb_hash64.c                       |  2 +-
 4 files changed, 73 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush.h

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 1b753f96b374..ddce8477fe0c 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -52,40 +52,42 @@ extern void flush_hash_range(unsigned long number, int local);
 extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 				pmd_t *pmdp, unsigned int psize, int ssize,
 				unsigned long flags);
-
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
+static inline void local_flush_hltlb_mm(struct mm_struct *mm)
 {
 }
 
-static inline void flush_tlb_mm(struct mm_struct *mm)
+static inline void flush_hltlb_mm(struct mm_struct *mm)
 {
 }
 
-static inline void local_flush_tlb_page(struct vm_area_struct *vma,
-					unsigned long vmaddr)
+static inline void local_flush_hltlb_page(struct vm_area_struct *vma,
+					  unsigned long vmaddr)
 {
 }
 
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long vmaddr)
+static inline void flush_hltlb_page(struct vm_area_struct *vma,
+				    unsigned long vmaddr)
 {
 }
 
-static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
-					 unsigned long vmaddr)
+static inline void flush_hltlb_page_nohash(struct vm_area_struct *vma,
+					   unsigned long vmaddr)
 {
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end)
+static inline void flush_hltlb_range(struct vm_area_struct *vma,
+				     unsigned long start, unsigned long end)
 {
 }
 
-static inline void flush_tlb_kernel_range(unsigned long start,
-					  unsigned long end)
+static inline void flush_hltlb_kernel_range(unsigned long start,
+					    unsigned long end)
 {
 }
 
+
+struct mmu_gather;
+extern void hltlb_flush(struct mmu_gather *tlb);
 /* Private function for use by PCI IO mapping code */
 extern void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 				     unsigned long end);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
new file mode 100644
index 000000000000..37d7f289ad42
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -0,0 +1,56 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H
+#define _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H
+
+#include <asm/book3s/64/tlbflush-hash.h>
+
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end)
+{
+	return flush_hltlb_range(vma, start, end);
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end)
+{
+	return flush_hltlb_kernel_range(start, end);
+}
+
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	return local_flush_hltlb_mm(mm);
+}
+
+static inline void local_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long vmaddr)
+{
+	return local_flush_hltlb_page(vma, vmaddr);
+}
+
+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
+					 unsigned long vmaddr)
+{
+	return flush_hltlb_page_nohash(vma, vmaddr);
+}
+
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	return hltlb_flush(tlb);
+}
+
+#ifdef CONFIG_SMP
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	return flush_hltlb_mm(mm);
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long vmaddr)
+{
+	return flush_hltlb_page(vma, vmaddr);
+}
+#else
+#define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
+#define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
+#endif /* CONFIG_SMP */
+
+#endif /*  _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H */
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 9f77f85e3e99..2fc4331c5bc5 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -78,7 +78,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 }
 
 #elif defined(CONFIG_PPC_STD_MMU_64)
-#include <asm/book3s/64/tlbflush-hash.h>
+#include <asm/book3s/64/tlbflush.h>
 #else
 #error Unsupported MMU type
 #endif
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 38497cf5e31b..d3a189d014f2 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -155,7 +155,7 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 	batch->index = 0;
 }
 
-void tlb_flush(struct mmu_gather *tlb)
+void hltlb_flush(struct mmu_gather *tlb)
 {
 	struct ppc64_tlb_batch *tlbbatch = &get_cpu_var(ppc64_tlb_batch);
 
-- 
2.5.0
