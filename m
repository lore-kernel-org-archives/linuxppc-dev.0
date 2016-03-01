Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A83471A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 18:30:00 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 00:29:58 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 67CEA3E40047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 00:29:46 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u217TkxZ41680928
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 00:29:46 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u217TjUK008344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 00:29:46 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 5/8] powerpc/mm: Create a new headers for tlbflush for hash64
Date: Tue,  1 Mar 2016 12:59:21 +0530
Message-Id: <1456817364-3329-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 94 ++++++++++++++++++++++
 arch/powerpc/include/asm/tlbflush.h                | 92 +--------------------
 2 files changed, 95 insertions(+), 91 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
new file mode 100644
index 000000000000..1b753f96b374
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -0,0 +1,94 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_TLBFLUSH_HASH_H
+#define _ASM_POWERPC_BOOK3S_64_TLBFLUSH_HASH_H
+
+#define MMU_NO_CONTEXT		0
+
+/*
+ * TLB flushing for 64-bit hash-MMU CPUs
+ */
+
+#include <linux/percpu.h>
+#include <asm/page.h>
+
+#define PPC64_TLB_BATCH_NR 192
+
+struct ppc64_tlb_batch {
+	int			active;
+	unsigned long		index;
+	struct mm_struct	*mm;
+	real_pte_t		pte[PPC64_TLB_BATCH_NR];
+	unsigned long		vpn[PPC64_TLB_BATCH_NR];
+	unsigned int		psize;
+	int			ssize;
+};
+DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
+
+extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
+
+#define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+
+static inline void arch_enter_lazy_mmu_mode(void)
+{
+	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
+
+	batch->active = 1;
+}
+
+static inline void arch_leave_lazy_mmu_mode(void)
+{
+	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
+
+	if (batch->index)
+		__flush_tlb_pending(batch);
+	batch->active = 0;
+}
+
+#define arch_flush_lazy_mmu_mode()      do {} while (0)
+
+
+extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
+			    int ssize, unsigned long flags);
+extern void flush_hash_range(unsigned long number, int local);
+extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
+				pmd_t *pmdp, unsigned int psize, int ssize,
+				unsigned long flags);
+
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+}
+
+static inline void local_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long vmaddr)
+{
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long vmaddr)
+{
+}
+
+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
+					 unsigned long vmaddr)
+{
+}
+
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end)
+{
+}
+
+/* Private function for use by PCI IO mapping code */
+extern void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
+				     unsigned long end);
+extern void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr);
+#endif /*  _ASM_POWERPC_BOOK3S_64_TLBFLUSH_HASH_H */
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 23d351ca0303..9f77f85e3e99 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -78,97 +78,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 }
 
 #elif defined(CONFIG_PPC_STD_MMU_64)
-
-#define MMU_NO_CONTEXT		0
-
-/*
- * TLB flushing for 64-bit hash-MMU CPUs
- */
-
-#include <linux/percpu.h>
-#include <asm/page.h>
-
-#define PPC64_TLB_BATCH_NR 192
-
-struct ppc64_tlb_batch {
-	int			active;
-	unsigned long		index;
-	struct mm_struct	*mm;
-	real_pte_t		pte[PPC64_TLB_BATCH_NR];
-	unsigned long		vpn[PPC64_TLB_BATCH_NR];
-	unsigned int		psize;
-	int			ssize;
-};
-DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
-
-extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
-
-#define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-
-static inline void arch_enter_lazy_mmu_mode(void)
-{
-	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
-
-	batch->active = 1;
-}
-
-static inline void arch_leave_lazy_mmu_mode(void)
-{
-	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
-
-	if (batch->index)
-		__flush_tlb_pending(batch);
-	batch->active = 0;
-}
-
-#define arch_flush_lazy_mmu_mode()      do {} while (0)
-
-
-extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
-			    int ssize, unsigned long flags);
-extern void flush_hash_range(unsigned long number, int local);
-extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
-				pmd_t *pmdp, unsigned int psize, int ssize,
-				unsigned long flags);
-
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
-{
-}
-
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-}
-
-static inline void local_flush_tlb_page(struct vm_area_struct *vma,
-					unsigned long vmaddr)
-{
-}
-
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long vmaddr)
-{
-}
-
-static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
-					 unsigned long vmaddr)
-{
-}
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end)
-{
-}
-
-static inline void flush_tlb_kernel_range(unsigned long start,
-					  unsigned long end)
-{
-}
-
-/* Private function for use by PCI IO mapping code */
-extern void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
-				     unsigned long end);
-extern void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr);
+#include <asm/book3s/64/tlbflush-hash.h>
 #else
 #error Unsupported MMU type
 #endif
-- 
2.5.0
