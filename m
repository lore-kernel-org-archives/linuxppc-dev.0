Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wfKt5MntzF2FQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 06:29:54 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7MHDrQ7087340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 13:16:20 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m1b7b24yg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 13:16:19 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 22 Aug 2018 11:16:19 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/hash: Only need the Nest MMU workaround for R
 -> RW transition
Date: Wed, 22 Aug 2018 22:46:05 +0530
In-Reply-To: <20180822171605.15054-1-aneesh.kumar@linux.ibm.com>
References: <20180822171605.15054-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180822171605.15054-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Nest MMU workaround is only needed for RW upgrades. Avoid doing that
for other pte updates.

We also avoid clearing the pte while marking it invalid. This is because other
page table walk will find this pte none and can result in unexpected behaviour
due to that. Instead we clear _PAGE_PRESENT and set the software pte bit
_PAGE_INVALID. pte_present is already updated to check for bot the bits. This
make sure page table walkers will find the pte present and things like
pte_pfn(pte) returns the right value.

Based on the original patch from Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 7be99fd9af15..c879979faa73 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1045,20 +1045,22 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
+
+	unsigned long change = pte_val(entry) ^ pte_val(*ptep);
 	/*
 	 * To avoid NMMU hang while relaxing access, we need mark
 	 * the pte invalid in between.
 	 */
-	if (atomic_read(&mm->context.copros) > 0) {
+	if ((change & _PAGE_RW) && atomic_read(&mm->context.copros) > 0) {
 		unsigned long old_pte, new_pte;
 
-		old_pte = __radix_pte_update(ptep, ~0, 0);
+		old_pte = __radix_pte_update(ptep, _PAGE_PRESENT, _PAGE_INVALID);
 		/*
 		 * new value of pte
 		 */
 		new_pte = old_pte | set;
 		radix__flush_tlb_page_psize(mm, address, psize);
-		__radix_pte_update(ptep, 0, new_pte);
+		__radix_pte_update(ptep, _PAGE_INVALID, new_pte);
 	} else {
 		__radix_pte_update(ptep, 0, set);
 		/*
-- 
2.17.1
