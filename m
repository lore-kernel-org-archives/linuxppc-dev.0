Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyH1LPPzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 41/70] powerpc/mm: Hash abstraction for tlbflush routines
Date: Fri, 29 Apr 2016 23:26:04 +1000
Message-Id: <1461936393-10131-41-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 28 ++++++-----
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 56 ++++++++++++++++++++++
 arch/powerpc/include/asm/tlbflush.h                |  2 +-
 arch/powerpc/mm/tlb_hash64.c                       |  2 +-
 4 files changed, 73 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush.h

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 1b753f96b374..cc092ea0387c 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -52,40 +52,42 @@ extern void flush_hash_range(unsigned long number, int local);
 extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 				pmd_t *pmdp, unsigned int psize, int ssize,
 				unsigned long flags);
-
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
+static inline void hash__local_flush_tlb_mm(struct mm_struct *mm)
 {
 }
 
-static inline void flush_tlb_mm(struct mm_struct *mm)
+static inline void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 }
 
-static inline void local_flush_tlb_page(struct vm_area_struct *vma,
-					unsigned long vmaddr)
+static inline void hash__local_flush_tlb_page(struct vm_area_struct *vma,
+					  unsigned long vmaddr)
 {
 }
 
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long vmaddr)
+static inline void hash__flush_tlb_page(struct vm_area_struct *vma,
+				    unsigned long vmaddr)
 {
 }
 
-static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
-					 unsigned long vmaddr)
+static inline void hash__flush_tlb_page_nohash(struct vm_area_struct *vma,
+					   unsigned long vmaddr)
 {
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end)
+static inline void hash__flush_tlb_range(struct vm_area_struct *vma,
+				     unsigned long start, unsigned long end)
 {
 }
 
-static inline void flush_tlb_kernel_range(unsigned long start,
-					  unsigned long end)
+static inline void hash__flush_tlb_kernel_range(unsigned long start,
+					    unsigned long end)
 {
 }
 
+
+struct mmu_gather;
+extern void hash__tlb_flush(struct mmu_gather *tlb);
 /* Private function for use by PCI IO mapping code */
 extern void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 				     unsigned long end);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
new file mode 100644
index 000000000000..476ea24b0313
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
+	return hash__flush_tlb_range(vma, start, end);
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end)
+{
+	return hash__flush_tlb_kernel_range(start, end);
+}
+
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	return hash__local_flush_tlb_mm(mm);
+}
+
+static inline void local_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long vmaddr)
+{
+	return hash__local_flush_tlb_page(vma, vmaddr);
+}
+
+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
+					 unsigned long vmaddr)
+{
+	return hash__flush_tlb_page_nohash(vma, vmaddr);
+}
+
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	return hash__tlb_flush(tlb);
+}
+
+#ifdef CONFIG_SMP
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	return hash__flush_tlb_mm(mm);
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long vmaddr)
+{
+	return hash__flush_tlb_page(vma, vmaddr);
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
index 38497cf5e31b..4517aa43a8b1 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -155,7 +155,7 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 	batch->index = 0;
 }
 
-void tlb_flush(struct mmu_gather *tlb)
+void hash__tlb_flush(struct mmu_gather *tlb)
 {
 	struct ppc64_tlb_batch *tlbbatch = &get_cpu_var(ppc64_tlb_batch);
 
-- 
2.5.0
