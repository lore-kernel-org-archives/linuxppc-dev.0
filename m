Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bL5v59mkzDrVP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 02:19:31 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PGEOen008030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 12:19:29 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kevj206tu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 12:19:29 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 25 Jul 2018 12:19:27 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 4/6] arch/powerpc/mm/hash: validate the pte entries before
 handling the hash fault
Date: Wed, 25 Jul 2018 21:49:01 +0530
In-Reply-To: <20180725161903.31257-1-aneesh.kumar@linux.ibm.com>
References: <20180725161903.31257-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180725161903.31257-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure we are operating on THP and hugetlb entries in the respective hash
fault handling routines.

No functional change in this patch. If we walked the table wrongly before, we
will retry the access.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c    | 6 ++++++
 arch/powerpc/mm/hugetlbpage-hash64.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index f20d16f849c5..049dcb8c95c2 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -51,6 +51,12 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 			new_pmd |= _PAGE_DIRTY;
 	} while (!pmd_xchg(pmdp, __pmd(old_pmd), __pmd(new_pmd)));
 
+	/*
+	 * Make sure this is thp or devmap entry
+	 */
+	if (!(old_pmd & (H_PAGE_THP_HUGE | _PAGE_DEVMAP)))
+		return 0;
+
 	rflags = htab_convert_pte_flags(new_pmd);
 
 #if 0
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index b320f5097a06..2e6a8f9345d3 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -62,6 +62,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			new_pte |= _PAGE_DIRTY;
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
+	/* Make sure this is a hugetlb entry */
+	if (old_pte & (H_PAGE_THP_HUGE | _PAGE_DEVMAP))
+		return 0;
+
 	rflags = htab_convert_pte_flags(new_pte);
 	if (unlikely(mmu_psize == MMU_PAGE_16G))
 		offset = PTRS_PER_PUD;
-- 
2.17.1
