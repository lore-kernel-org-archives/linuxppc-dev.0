Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy9j86c2YzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 00:05:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v34E3xAX105588
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 10:05:10 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ktf7a8tu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 10:05:10 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 08:05:08 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 5/7] mm/follow_page_mask: Add support for hugetlb pgd
 entries.
Date: Tue,  4 Apr 2017 19:34:33 +0530
In-Reply-To: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1491314675-15787-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc64 supports pgd hugetlb entries. Add code to handle hugetlb pgd entries to
follow_page_mask so that ppc64 can switch to it to handle hugetlbe entries.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/hugetlb.h | 3 +++
 mm/gup.c                | 7 +++++++
 mm/hugetlb.c            | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d3a4be0022d8..04b73a9c8b4b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -124,6 +124,9 @@ struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 				pmd_t *pmd, int flags);
 struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 				pud_t *pud, int flags);
+struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
+			     pgd_t *pgd, int flags);
+
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
diff --git a/mm/gup.c b/mm/gup.c
index 0e18fd5f65b4..74a25e33dddb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -382,6 +382,13 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		return no_page_table(vma, flags);
 
+	if (pgd_huge(*pgd)) {
+		page = follow_huge_pgd(mm, address, pgd, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
+
 	if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pgd_val(*pgd)), flags,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b02faa1079bd..eb39a7496de7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4702,6 +4702,15 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
 }
 
+struct page * __weak
+follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
+{
+	if (flags & FOLL_GET)
+		return NULL;
+
+	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
+}
+
 #ifdef CONFIG_MEMORY_FAILURE
 
 /*
-- 
2.7.4
