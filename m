Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED2B42C0415
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:34:47 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 12:00:14 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4DF551258043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:03:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J6YbRP22609926
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:04:37 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6Yc2U019629
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:34:40 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, scottwood@freescale.com
Subject: [PATCH -V2] powerpc: Fix bad pmd error with book3E config
Date: Wed, 19 Jun 2013 12:04:26 +0530
Message-Id: <1371623666-27348-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
clear the pmd if it find a hugepd pointer. Fix this by clearing
bad pmd only if it is not a hugepd pointer.

This is regression introduced by e2b3d202d1dba8f3546ed28224ce485bc50010be
"powerpc: Switch 16GB and 16MB explicit hugepages to a different page table format"

Reported-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f2f01fd..5555778 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -536,8 +536,14 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	do {
 		pmd = pmd_offset(pud, addr);
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
+		if (!is_hugepd(pmd)) {
+			/*
+			 * if it is not hugepd pointer, we should already find
+			 * it cleared.
+			 */
+			WARN_ON(!pmd_none_or_clear_bad(pmd));
 			continue;
+		}
 #ifdef CONFIG_PPC_FSL_BOOK3E
 		/*
 		 * Increment next by the size of the huge mapping since
-- 
1.8.1.2
