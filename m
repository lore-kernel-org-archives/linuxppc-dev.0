Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4464D2C02F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:35 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 18:47:17 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 202B42CE8044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K91No84587824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:23 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K91VWd001879
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:31 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V11 11/15] powerpc: Prevent gcc to re-read the pagetables
Date: Thu, 20 Jun 2013 14:30:23 +0530
Message-Id: <1371718827-15065-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 223a255..49822d9 100644
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
@@ -97,7 +97,7 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 
 	pudp = pud_offset(&pgd, addr);
 	do {
-		pud_t pud = *pudp;
+		pud_t pud = ACCESS_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
@@ -160,7 +160,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
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
