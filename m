Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 665A71A1071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:17:08 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:47:05 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1A051E005F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:48:20 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7H1iP786764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:47:01 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GTsW013971
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 32/33] powerpc/mm: Hash linux abstraction for tlbflush
 routines
Date: Tue, 12 Jan 2016 12:46:07 +0530
Message-Id: <1452582968-22669-33-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 000000000000..dd8830ea7143
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
+#define flush_tlb_page(vma,addr)	local_flush_tlb_page(vma,addr)
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
index 98a85e426255..ebf386becf9e 100644
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
