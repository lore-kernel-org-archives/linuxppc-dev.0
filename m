Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B61A140117
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 03:07:54 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 21:37:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 007141258044
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 21:40:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s32G7qbW9961864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 21:37:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s32G7kLa027403
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 21:37:47 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/mm: numa pte should be handled via slow path in
 get_user_pages_fast
Date: Wed,  2 Apr 2014 21:37:39 +0530
Message-Id: <1396454859-5274-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We need to handle numa pte via the slow path

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/gup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
index c5f734e20b0f..d8746684f606 100644
--- a/arch/powerpc/mm/gup.c
+++ b/arch/powerpc/mm/gup.c
@@ -36,6 +36,11 @@ static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
 	do {
 		pte_t pte = ACCESS_ONCE(*ptep);
 		struct page *page;
+		/*
+		 * Similar to the PMD case, NUMA hinting must take slow path
+		 */
+		if (pte_numa(pte))
+			return 0;
 
 		if ((pte_val(pte) & mask) != result)
 			return 0;
@@ -75,6 +80,14 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
 			return 0;
 		if (pmd_huge(pmd) || pmd_large(pmd)) {
+			/*
+			 * NUMA hinting faults need to be handled in the GUP
+			 * slowpath for accounting purposes and so that they
+			 * can be serialised against THP migration.
+			 */
+			if (pmd_numa(pmd))
+				return 0;
+
 			if (!gup_hugepte((pte_t *)pmdp, PMD_SIZE, addr, next,
 					 write, pages, nr))
 				return 0;
-- 
1.8.3.2
