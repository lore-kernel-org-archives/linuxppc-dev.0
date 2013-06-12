Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C0482C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 20:30:23 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Jun 2013 20:21:11 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9D67D3578050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 20:30:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5CAFTWK4129236
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 20:15:29 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5CAUAFs021318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 20:30:11 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, scottwood@freescale.com
Subject: [PATCH] powerpc: Fix bad pmd error with book3E config
Date: Wed, 12 Jun 2013 16:00:04 +0530
Message-Id: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Book3E uses the hugepd at PMD level and don't encode pte directly
at the pmd level. So it will find the lower bits of pmd set
and the pmd_bad check throws error. Infact the current code
will never take the free_hugepd_range call at all because it will
clear the pmd if it find a hugepd pointer.

Reported-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f2f01fd..0d3d3ee 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -536,19 +536,26 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	do {
 		pmd = pmd_offset(pud, addr);
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
+		if (!is_hugepd(pmd)) {
+			/*
+			 * if it is not hugepd pointer, we should already find
+			 * it cleared.
+			 */
+			if (!pmd_none_or_clear_bad(pmd))
+				WARN_ON(1);
+		} else {
 #ifdef CONFIG_PPC_FSL_BOOK3E
-		/*
-		 * Increment next by the size of the huge mapping since
-		 * there may be more than one entry at this level for a
-		 * single hugepage, but all of them point to
-		 * the same kmem cache that holds the hugepte.
-		 */
-		next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
+			/*
+			 * Increment next by the size of the huge mapping since
+			 * there may be more than one entry at this level for a
+			 * single hugepage, but all of them point to
+			 * the same kmem cache that holds the hugepte.
+			 */
+			next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
 #endif
-		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
-				  addr, next, floor, ceiling);
+			free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
+					  addr, next, floor, ceiling);
+		}
 	} while (addr = next, addr != end);
 
 	start &= PUD_MASK;
-- 
1.8.1.2
