Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyc4Q28zDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 61/70] powerpc/mm: Fix vma_mmu_pagesize() for radix
Date: Fri, 29 Apr 2016 23:26:24 +1000
Message-Id: <1461936393-10131-61-git-send-email-mpe@ellerman.id.au>
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

Radix doesn't use the slice framework to find the page size. Hence use
vma to find the page size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hugetlbpage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 6d910960217e..7d677ef51033 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -719,14 +719,14 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
 #ifdef CONFIG_PPC_MM_SLICES
 	unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
-
-	return 1UL << mmu_psize_to_shift(psize);
-#else
+	/* With radix we don't use slice, so derive it from vma*/
+	if (!radix_enabled())
+		return 1UL << mmu_psize_to_shift(psize);
+#endif
 	if (!is_vm_hugetlb_page(vma))
 		return PAGE_SIZE;
 
 	return huge_page_size(hstate_vma(vma));
-#endif
 }
 
 static inline bool is_power_of_4(unsigned long x)
-- 
2.5.0
