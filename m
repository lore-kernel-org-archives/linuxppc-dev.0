Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGp6t0Ds7zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 11:21:25 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v160Ici0075690
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Feb 2017 19:21:22 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28e48c86ht-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Feb 2017 19:21:22 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 10:21:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 548223578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 11:21:18 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v160LAft29163766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 11:21:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v160Kjt0016595
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 11:20:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fix typo in set_pte_at()
Date: Mon,  6 Feb 2017 11:19:56 +1100
Message-Id: <1486340396-24609-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the typo about the _PAGE_PTE in set_pte_at() by changing
"tryint" to "trying to".

Fixes: 6a119eae942 ("powerpc/mm: Add a _PAGE_PTE bit")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cb39c8b..a03ff3d 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -193,9 +193,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 */
 	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
 
-	/*
-	 * Add the pte bit when tryint set a pte
-	 */
+	/* Add the pte bit when trying to set a pte */
 	pte = __pte(pte_val(pte) | _PAGE_PTE);
 
 	/* Note: mm->context.id might not yet have been assigned as
-- 
2.7.4
