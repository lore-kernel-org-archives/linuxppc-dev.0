Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ5xf4XkhzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:17:58 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v183DwsS140092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 22:17:55 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fgmthm6e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 22:17:55 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 13:17:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EBFF42BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:17:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v183HeVL17235972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:17:48 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v183HGFx013248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:17:17 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/mm: Fix typo in set_pte_at()
Date: Wed,  8 Feb 2017 14:16:50 +1100
Message-Id: <1486523810-21112-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Removed "Fixes" tag
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
