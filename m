Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BCD37B71AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:08 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/13] powerpc: Only define HAVE_ARCH_HUGETLB_UNMAPPED_AREA if
 PPC_MM_SLICES
Date: Mon, 10 Oct 2011 15:50:36 -0500
Message-Id: <13182798624083-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

If we don't have slices, we should be able to use the generic
hugetlb_get_unmapped_area() code

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/page_64.h |    2 ++
 arch/powerpc/mm/hugetlbpage.c      |    6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index fb40ede..fed85e6 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -130,7 +130,9 @@ do {						\
 
 #ifdef CONFIG_HUGETLB_PAGE
 
+#ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#endif
 
 #endif /* !CONFIG_HUGETLB_PAGE */
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 48b65be..71c6533 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -686,19 +686,17 @@ int gup_hugepd(hugepd_t *hugepd, unsigned pdshift,
 	return 1;
 }
 
+#ifdef CONFIG_PPC_MM_SLICES
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
 {
-#ifdef CONFIG_PPC_MM_SLICES
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
 
 	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1, 0);
-#else
-	return get_unmapped_area(file, addr, len, pgoff, flags);
-#endif
 }
+#endif
 
 unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
-- 
1.5.6.5
