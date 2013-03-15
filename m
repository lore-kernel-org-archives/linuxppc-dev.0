Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81DA32C0184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 20:40:37 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 15:08:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CA5B11258065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 15:11:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2F9eJU12818538
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 15:10:19 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2F9eIPP010406
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 20:40:20 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 21/25] powerpc: Handle hugepage in perf callchain
Date: Fri, 15 Mar 2013 15:10:03 +0530
Message-Id: <1363340407-22619-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1363340407-22619-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1363340407-22619-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
