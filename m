Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0BCE42C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 01:28:53 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 20:54:15 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1310AE0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 21:01:35 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55FSd2A11076050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 20:58:39 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55FSkfF007049
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 01:28:47 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V10 10/15] powerpc: Prevent gcc to re-read the pagetables
Date: Wed,  5 Jun 2013 20:58:34 +0530
Message-Id: <1370446119-8837-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

GCC is very likely to read the pagetables just once and cache them in
the local stack or in a register, but it is can also decide to re-read
the pagetables. The problem is that the pagetable in those places can
change from under gcc.

With THP/hugetlbfs the pmd (and pgd for hugetlbfs giga pages) can
change under gup_fast. The pages won't be freed untill we finish
gup fast because we have irq disabled and we free these pages via
rcu callback.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/gup.c         | 8 ++++----
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
index 3d36fd7..4823e4d 100644
--- a/arch/powerpc/mm/gup.c
+++ b/arch/powerpc/mm/gup.c
@@ -34,7 +34,7 @@ static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
 
 	ptep = pte_offset_kernel(&pmd, addr);
 	do {
-		pte_t pte = *ptep;
+		pte_t pte = ACCESS_ONCE(*ptep);
 		struct page *page;
 
 		if ((pte_val(pte) & mask) != result)
@@ -63,7 +63,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 
 	pmdp = pmd_offset(&pud, addr);
 	do {
-		pmd_t pmd = *pmdp;
+		pmd_t pmd = ACCESS_ONCE(*pmdp);
 
 		next = pmd_addr_end(addr, end);
 		/*
@@ -102,7 +102,7 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 
 	pudp = pud_offset(&pgd, addr);
 	do {
-		pud_t pud = *pudp;
+		pud_t pud = ACCESS_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
@@ -165,7 +165,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	pgdp = pgd_offset(mm, addr);
 	do {
-		pgd_t pgd = *pgdp;
+		pgd_t pgd = ACCESS_ONCE(*pgdp);
 
 		pr_devel("  %016lx: normal pgd %p\n", addr,
 			 (void *)pgd_val(pgd));
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e9e6882..f2f01fd 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -1024,7 +1024,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = *ptep;
+	pte = ACCESS_ONCE(*ptep);
 	mask = _PAGE_PRESENT | _PAGE_USER;
 	if (write)
 		mask |= _PAGE_RW;
-- 
1.8.1.2
