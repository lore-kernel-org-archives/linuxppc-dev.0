Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmM76JMRzDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:07 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:17:05 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CDB563E40030
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:17:02 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396H2E831916108
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:17:02 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396H1gE018321
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:17:02 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 59/68] powerpc/mm: Add radix support for hugetlb
Date: Sat,  9 Apr 2016 11:43:55 +0530
Message-Id: <1460182444-2468-60-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h | 14 ++++
 arch/powerpc/include/asm/hugetlb.h                 | 14 ++++
 arch/powerpc/mm/Makefile                           |  1 +
 arch/powerpc/mm/hugetlbpage-radix.c                | 87 ++++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage.c                      |  8 +-
 arch/powerpc/mm/tlb-radix.c                        |  9 +++
 6 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
 create mode 100644 arch/powerpc/mm/hugetlbpage-radix.c

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h b/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
new file mode 100644
index 000000000000..6f8f644bb26e
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
+#define _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
+/*
+ * For radix we want generic code to handle hugetlb. But then if we want
+ * both hash and radix to be enabled together we need to workaround the
+ * limitations.
+ */
+void flush_hugetlb_rpage(struct vm_area_struct *vma, unsigned long vmaddr);
+void __local_flush_hugetlb_rpage(struct vm_area_struct *vma, unsigned long vmaddr);
+extern unsigned long
+hugetlb_get_radix_unmapped_area(struct file *file, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags);
+#endif
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 6b49121d042e..2a21b93952b6 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -8,6 +8,8 @@
 extern struct kmem_cache *hugepte_cache;
 
 #ifdef CONFIG_PPC_BOOK3S_64
+
+#include <asm/book3s/64/hugetlb-radix.h>
 /*
  * This should work for other subarchs too. But right now we use the
  * new format only for 64bit book3s
@@ -31,7 +33,19 @@ static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
 	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
 }
+static inline void flush_hugetlb_page(struct vm_area_struct *vma,
+				      unsigned long vmaddr)
+{
+	if (radix_enabled())
+		return flush_hugetlb_rpage(vma, vmaddr);
+}
 
+static inline void __local_flush_hugetlb_page(struct vm_area_struct *vma,
+					      unsigned long vmaddr)
+{
+	if (radix_enabled())
+		return __local_flush_hugetlb_rpage(vma, vmaddr);
+}
 #else
 
 static inline pte_t *hugepd_page(hugepd_t hpd)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 48aa11ae6a6b..47511dd00599 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-y				+= hugetlbpage.o
 ifeq ($(CONFIG_HUGETLB_PAGE),y)
 obj-$(CONFIG_PPC_STD_MMU_64)	+= hugetlbpage-hash64.o
+obj-$(CONFIG_PPC_RADIX_MMU)	+= hugetlbpage-radix.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
 endif
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += hugepage-hash64.o
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
new file mode 100644
index 000000000000..94ff1f23078d
--- /dev/null
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -0,0 +1,87 @@
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/machdep.h>
+#include <asm/mman.h>
+
+void flush_hugetlb_rpage(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	unsigned long ap, shift;
+	struct hstate *hstate = hstate_file(vma->vm_file);
+
+	shift = huge_page_shift(hstate);
+	if (shift == mmu_psize_defs[MMU_PAGE_2M].shift)
+		ap = mmu_get_ap(MMU_PAGE_2M);
+	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
+		ap = mmu_get_ap(MMU_PAGE_1G);
+	else {
+		WARN(1, "Wrong huge page shift\n");
+		return ;
+	}
+	__flush_rtlb_page(vma->vm_mm, vmaddr, ap, 0);
+}
+
+void __local_flush_hugetlb_rpage(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	unsigned long ap, shift;
+	struct hstate *hstate = hstate_file(vma->vm_file);
+
+	shift = huge_page_shift(hstate);
+	if (shift == mmu_psize_defs[MMU_PAGE_2M].shift)
+		ap = mmu_get_ap(MMU_PAGE_2M);
+	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
+		ap = mmu_get_ap(MMU_PAGE_1G);
+	else {
+		WARN(1, "Wrong huge page shift\n");
+		return ;
+	}
+	__local_flush_rtlb_page(vma->vm_mm, vmaddr, ap, 0);
+}
+
+/*
+ * A vairant of hugetlb_get_unmapped_area doing topdown search
+ * FIXME!! should we do as x86 does or non hugetlb area does ?
+ * ie, use topdown or not based on mmap_is_legacy check ?
+ */
+unsigned long
+hugetlb_get_radix_unmapped_area(struct file *file, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (addr) {
+		addr = ALIGN(addr, huge_page_size(h));
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	/*
+	 * We are always doing an topdown search here. Slice code
+	 * does that too.
+	 */
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = current->mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9eab82cfbb91..fa242c744ec1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -711,6 +711,9 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
 
+	if (radix_enabled())
+		return hugetlb_get_radix_unmapped_area(file, addr, len,
+						       pgoff, flags);
 	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
 }
 #endif
@@ -823,7 +826,7 @@ static int __init hugetlbpage_init(void)
 {
 	int psize;
 
-	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
 
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
@@ -863,6 +866,9 @@ static int __init hugetlbpage_init(void)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
 	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
+	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
+
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 9129c0d6322c..b0f7f63acc09 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -142,6 +142,11 @@ void __local_flush_rtlb_page(struct mm_struct *mm, unsigned long vmaddr,
 
 void local_flush_rtlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
+#ifdef CONFIG_HUGETLB_PAGE
+	/* need the return fix for nohash.c */
+	if (vma && is_vm_hugetlb_page(vma))
+		return __local_flush_hugetlb_page(vma, vmaddr);
+#endif
 	__local_flush_rtlb_page(vma ? vma->vm_mm : NULL, vmaddr,
 			       mmu_get_ap(mmu_virtual_psize), 0);
 }
@@ -203,6 +208,10 @@ bail:
 
 void flush_rtlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
+#ifdef CONFIG_HUGETLB_PAGE
+	if (vma && is_vm_hugetlb_page(vma))
+		return flush_hugetlb_page(vma, vmaddr);
+#endif
 	__flush_rtlb_page(vma ? vma->vm_mm : NULL, vmaddr,
 			 mmu_get_ap(mmu_virtual_psize), 0);
 }
-- 
2.5.0
