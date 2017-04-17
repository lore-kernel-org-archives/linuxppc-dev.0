Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6FF26TdvzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 03:12:22 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HH91h8113112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:12:18 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29w00k5152-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:12:18 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 13:12:17 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/7] mm/hugetlb: export hugetlb_entry_migration helper
Date: Mon, 17 Apr 2017 22:41:42 +0530
In-Reply-To: <1492449106-27467-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1492449106-27467-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1492449106-27467-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will be using this later from the ppc64 code. Change the return type to bool.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b857fc8cc2ec..fddf6cf403d5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -126,6 +126,7 @@ int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
+bool is_hugetlb_entry_migration(pte_t pte);
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2c090189f314..9b630e2195d5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3189,17 +3189,17 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 		update_mmu_cache(vma, address, ptep);
 }
 
-static int is_hugetlb_entry_migration(pte_t pte)
+bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
 	if (huge_pte_none(pte) || pte_present(pte))
-		return 0;
+		return false;
 	swp = pte_to_swp_entry(pte);
 	if (non_swap_entry(swp) && is_migration_entry(swp))
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 static int is_hugetlb_entry_hwpoisoned(pte_t pte)
-- 
2.7.4
