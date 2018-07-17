Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V6cj5zw5zF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 14:24:37 +1000 (AEST)
From: David Gibson <david@gibson.dropbear.id.au>
To: aneesh.kumar@linux.vnet.ibm.com,
	mpe@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/hugetlbpage: Rmove unhelpful HUGEPD_*_SHIFT macros
Date: Tue, 17 Jul 2018 14:24:30 +1000
Message-Id: <20180717042430.15395-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HUGEPD_*_SHIFT macros are always defined to be PGDIR_SHIFT and
PUD_SHIFT, and have to have those values to work properly.  They once used
to have different values, but that was really only because they were used
to mean different things in different contexts.

6fa50483 "powerpc/mm/hugetlb: initialize the pagetable cache correctly for
hugetlb" removed that double meaning, but left the now useless constants.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/mm/hugetlbpage.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8a9a49c13865..acbbaabdaaf8 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -117,15 +117,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	return 0;
 }
 
-/*
- * These macros define how to determine which level of the page table holds
- * the hpdp.
- */
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-#define HUGEPD_PGD_SHIFT PGDIR_SHIFT
-#define HUGEPD_PUD_SHIFT PUD_SHIFT
-#endif
-
 /*
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
@@ -174,13 +165,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 		}
 	}
 #else
-	if (pshift >= HUGEPD_PGD_SHIFT) {
+	if (pshift >= PGDIR_SHIFT) {
 		ptl = &mm->page_table_lock;
 		hpdp = (hugepd_t *)pg;
 	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
-		if (pshift >= HUGEPD_PUD_SHIFT) {
+		if (pshift >= PUD_SHIFT) {
 			ptl = pud_lockptr(mm, pu);
 			hpdp = (hugepd_t *)pu;
 		} else {
@@ -695,9 +686,9 @@ static int __init hugetlbpage_init(void)
 		else
 			pdshift = PMD_SHIFT;
 #else
-		if (shift < HUGEPD_PUD_SHIFT)
+		if (shift < PUD_SHIFT)
 			pdshift = PMD_SHIFT;
-		else if (shift < HUGEPD_PGD_SHIFT)
+		else if (shift < PGDIR_SHIFT)
 			pdshift = PUD_SHIFT;
 		else
 			pdshift = PGDIR_SHIFT;
-- 
2.17.1
