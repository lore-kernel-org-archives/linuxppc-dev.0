Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r42SH421yzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 00:58:23 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id xk12so6561130pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 07:58:23 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 2/2] Deduplicate the actual base page size code
Date: Wed, 11 May 2016 00:57:42 +1000
Message-Id: <1462892262-18066-3-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1462892262-18066-1-git-send-email-bsingharora@gmail.com>
References: <1462892262-18066-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Deduplicate to one function to compute the actual page size.
Some additional warnings added for AP size as well.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/hugetlbpage-radix.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 1e11559..9108645 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -6,7 +6,8 @@
 #include <asm/machdep.h>
 #include <asm/mman.h>
 
-void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+static inline unsigned long get_base_page_size(struct vm_area_struct *vma,
+					       unsigned long vmaddr)
 {
 	unsigned long ap, shift;
 	struct hstate *hstate = hstate_file(vma->vm_file);
@@ -18,25 +19,25 @@ void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		ap = mmu_get_ap(MMU_PAGE_1G);
 	else {
 		WARN(1, "Wrong huge page shift\n");
-		return ;
+		return 0;
 	}
-	radix___flush_tlb_page(vma->vm_mm, vmaddr, ap, 0);
+#ifdef CONFIG_DEBUG_VM
+	/* Double check this assumption */
+	WARN_ON(ap != 0 && ap != 0x5);
+#endif
+	return ap;
 }
 
-void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
-	unsigned long ap, shift;
-	struct hstate *hstate = hstate_file(vma->vm_file);
+	unsigned long ap = get_base_page_size(vma, vmaddr);
+	radix___flush_tlb_page(vma->vm_mm, vmaddr, ap, 0);
+}
 
-	shift = huge_page_shift(hstate);
-	if (shift == mmu_psize_defs[MMU_PAGE_2M].shift)
-		ap = mmu_get_ap(MMU_PAGE_2M);
-	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
-		ap = mmu_get_ap(MMU_PAGE_1G);
-	else {
-		WARN(1, "Wrong huge page shift\n");
-		return ;
-	}
+void radix__local_flush_hugetlb_page(struct vm_area_struct *vma,
+				     unsigned long vmaddr)
+{
+	unsigned long ap = get_base_page_size(vma, vmaddr);
 	radix___local_flush_tlb_page(vma->vm_mm, vmaddr, ap, 0);
 }
 
-- 
2.5.5
