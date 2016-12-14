Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdkQ45NK9zDvwx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 15:39:56 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBE4daBd126420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 23:39:54 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27axsxhuxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 23:39:54 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 21:39:53 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Remove the debug hugepd_ok check
Date: Wed, 14 Dec 2016 10:09:45 +0530
Message-Id: <20161214043945.26549-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't do this for other page table entries. So lets keep this simple
and always return false for hugepd check on a 64K page size config.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h |  5 -----
 arch/powerpc/mm/hugetlbpage-hash64.c             | 21 ---------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 0d2845b44763..198aff33c380 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -35,10 +35,6 @@ static inline int pgd_huge(pgd_t pgd)
 }
 #define pgd_huge pgd_huge
 
-#ifdef CONFIG_DEBUG_VM
-extern int hugepd_ok(hugepd_t hpd);
-#define is_hugepd(hpd)               (hugepd_ok(hpd))
-#else
 /*
  * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
  * need to setup hugepage directory for them. Our pte and page directory format
@@ -49,7 +45,6 @@ static inline int hugepd_ok(hugepd_t hpd)
 	return 0;
 }
 #define is_hugepd(pdep)			0
-#endif /* CONFIG_DEBUG_VM */
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 37b5f91e381b..a84bb44497f9 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -116,24 +116,3 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
-
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_DEBUG_VM)
-/*
- * This enables us to catch the wrong page directory format
- * Moved here so that we can use WARN() in the call.
- */
-int hugepd_ok(hugepd_t hpd)
-{
-	bool is_hugepd;
-	unsigned long hpdval;
-
-	hpdval = hpd_val(hpd);
-
-	/*
-	 * We should not find this format in page directory, warn otherwise.
-	 */
-	is_hugepd = (((hpdval & 0x3) == 0x0) && ((hpdval & HUGEPD_SHIFT_MASK) != 0));
-	WARN(is_hugepd, "Found wrong page directory format\n");
-	return 0;
-}
-#endif
-- 
2.10.2
