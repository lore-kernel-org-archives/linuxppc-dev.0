Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmJ431KtzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:14:28 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:14:26 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 60C993E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:14:23 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396EN3n38142160
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 23:14:23 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396EMgw030242
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 00:14:23 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>
Subject: [PATCH V2 02/68] powerpc/mm/nohash: Return correctly from
 flush_tlb_page
Date: Sat,  9 Apr 2016 11:42:58 +0530
Message-Id: <1460182444-2468-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

if it is a hugetlb address return without calling __flush_tlb_page.

Cc: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb_nohash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index f4668488512c..8ed4c037cb00 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -328,9 +328,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
 #ifdef CONFIG_HUGETLB_PAGE
 	if (vma && is_vm_hugetlb_page(vma))
-		flush_hugetlb_page(vma, vmaddr);
+		return flush_hugetlb_page(vma, vmaddr);
 #endif
-
 	__flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
 			 mmu_get_tsize(mmu_virtual_psize), 0);
 }
-- 
2.5.0
