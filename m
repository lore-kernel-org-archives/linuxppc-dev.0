Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95D272C06CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:24 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:09:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4FC733578051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:17 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r266BEi355836712
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:11:14 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266BGjT015429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:11:16 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 22/26] powerpc: Handle huge page in perf callchain
Date: Wed,  6 Mar 2013 11:40:23 +0530
Message-Id: <1362550227-575-23-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/perf/callchain.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 578cac7..99262ce 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -115,7 +115,7 @@ static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
 {
 	pgd_t *pgdir;
 	pte_t *ptep, pte;
-	unsigned shift;
+	unsigned shift, hugepage;
 	unsigned long addr = (unsigned long) ptr;
 	unsigned long offset;
 	unsigned long pfn;
@@ -125,20 +125,30 @@ static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
 	if (!pgdir)
 		return -EFAULT;
 
-	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift, NULL);
+	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift, &hugepage);
 	if (!shift)
 		shift = PAGE_SHIFT;
 
-	/* align address to page boundary */
-	offset = addr & ((1UL << shift) - 1);
-	addr -= offset;
-
-	if (ptep == NULL)
-		return -EFAULT;
-	pte = *ptep;
-	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
+	if (!ptep)
 		return -EFAULT;
-	pfn = pte_pfn(pte);
+
+	if (hugepage) {
+		pmd_t pmd = *(pmd_t *)ptep;
+		shift = mmu_psize_defs[MMU_PAGE_16M].shift;
+		offset = addr & ((1UL << shift) - 1);
+
+		if (!pmd_large(pmd) || !(pmd_val(pmd) & PMD_HUGE_USER))
+			return -EFAULT;
+		pfn = pmd_pfn(pmd);
+	} else {
+		offset = addr & ((1UL << shift) - 1);
+
+		pte = *ptep;
+		if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
+			return -EFAULT;
+		pfn = pte_pfn(pte);
+	}
+
 	if (!page_is_ram(pfn))
 		return -EFAULT;
 
-- 
1.7.10
