Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrW13FjzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:34 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:33 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B3ACF3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:30 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8QUNc35782746
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:26:30 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QTA5030202
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:30 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 56/65] powerpc/mm: Fix vma_mmu_pagesize for radix
Date: Sun, 27 Mar 2016 13:54:04 +0530
Message-Id: <1459067053-10835-56-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix don't use SLICE framework to find page size. Hence use
vma to find the page size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7201e9c624d5..9eab82cfbb91 100644
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
