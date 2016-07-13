Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDKj6VQnzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:38:33 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YDRQ014769
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24567bwsk5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:31 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:38:30 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 03/10] powerpc/mm/radix: Add radix_set_pte to use in
 early init
Date: Wed, 13 Jul 2016 15:08:03 +0530
In-Reply-To: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402690-5373-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to use the static key based feature check in set_pte_at. Since
we call radix__map_kernel_page early in boot before jump label is
initialized we can't call set_pte_at there. Add radix__set_pte for the
same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ce21a0f2c2a1..e9f8a542f75b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -39,6 +39,27 @@ static __ref void *early_alloc_pgtable(unsigned long size)
 
 	return pt;
 }
+/*
+ * set_pte stores a linux PTE into the linux page table.
+ */
+static void radix__set_pte(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+			   pte_t pte)
+{
+	/*
+	 * When handling numa faults, we already have the pte marked
+	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
+	 * Hence we can use set_pte_at for them.
+	 */
+	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
+
+	/*
+	 * Add the pte bit when tryint set a pte
+	 */
+	pte = __pte(pte_val(pte) | _PAGE_PTE);
+
+	/* Perform the setting of the PTE */
+	radix__set_pte_at(mm, addr, ptep, pte, 0);
+}
 
 int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 			  pgprot_t flags,
@@ -102,7 +123,7 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 	}
 
 set_the_pte:
-	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
+	radix__set_pte(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
 	smp_wmb();
 	return 0;
 }
-- 
2.7.4
