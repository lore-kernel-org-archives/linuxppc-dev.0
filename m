Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F47F2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:44 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 12 May 2013 21:38:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 758F53940053
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4CGEVDm2884046
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:31 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4CGEbvq023488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:38 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V8 11/18] powerpc: Update find_linux_pte_or_hugepte to handle
 transparent hugepages
Date: Sun, 12 May 2013 21:44:18 +0530
Message-Id: <1368375265-19593-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Reviewed-by: David Gibson <dwg@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 2865077..4928204 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -936,30 +936,50 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
 
 	pg = pgdir + pgd_index(ea);
 
-	if (pgd_huge(*pg)) {
+	/*
+	 * we should first check for none. That takes care of a
+	 * a parallel hugetlb or THP pagefault moving none entries
+	 * to respective types.
+	 */
+	if (pgd_none(*pg))
+		return NULL;
+	else if (pgd_huge(*pg)) {
 		ret_pte = (pte_t *) pg;
 		goto out;
 	} else if (is_hugepd(pg))
 		hpdp = (hugepd_t *)pg;
-	else if (!pgd_none(*pg)) {
+	else {
 		pdshift = PUD_SHIFT;
 		pu = pud_offset(pg, ea);
 
-		if (pud_huge(*pu)) {
+		if (pud_none(*pu))
+			return NULL;
+		else if (pud_huge(*pu)) {
 			ret_pte = (pte_t *) pu;
 			goto out;
 		} else if (is_hugepd(pu))
 			hpdp = (hugepd_t *)pu;
-		else if (!pud_none(*pu)) {
+		else {
 			pdshift = PMD_SHIFT;
 			pm = pmd_offset(pu, ea);
+			/*
+			 * A hugepage collapse is captured by pmd_none, because
+			 * it mark the pmd none and do a hpte invalidate.
+			 *
+			 * A hugepage split is captured by pmd_trans_splitting
+			 * because we mark the pmd trans splitting and do a
+			 * hpte invalidate
+			 *
+			 */
+			if (pmd_none(*pm) || pmd_trans_splitting(*pm))
+				return NULL;
 
-			if (pmd_huge(*pm)) {
+			if (pmd_huge(*pm) || pmd_large(*pm)) {
 				ret_pte = (pte_t *) pm;
 				goto out;
 			} else if (is_hugepd(pm))
 				hpdp = (hugepd_t *)pm;
-			else if (!pmd_none(*pm))
+			else
 				return pte_offset_kernel(pm, ea);
 		}
 	}
-- 
1.8.1.2
