Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF97A1A2BD5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 16:28:27 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8D375140D17
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 16:28:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 16:28:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 896442CE8054
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 16:28:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8E6SAqS31785024
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 16:28:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8E6RmsP027745
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 16:27:49 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, mikey@neuling.org
Subject: [RFC] powerpc/hugetlb: Add warning message when gpage allocation
 request fails
Date: Mon, 14 Sep 2015 11:57:31 +0530
Message-Id: <1442212051-15235-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a 16GB huge page is requested on POWER platform through kernel command
line interface, it silently fails because of the lack of any gigantic pages
on the system which the platform should have communicated through 16GB memory
blocks in the device tree during boot time. For example

[    0.480940] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    0.480945] HugeTLB registered 16 MB page size, pre-allocated 16 pages

This adds a warning message during alloc_bootmem_huge_page request both on
book3e and book3s powerpc platforms. After this change

[    0.000000] Gigantic HugeTLB page not available
[    0.473417] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    0.473423] HugeTLB registered 16 MB page size, pre-allocated 16 pages

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 06c1452..54f3e42 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -307,8 +307,10 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 	int idx = shift_to_mmu_psize(huge_page_shift(hstate));
 	int nr_gpages = gpage_freearray[idx].nr_gpages;
 
-	if (nr_gpages == 0)
+	if (nr_gpages == 0) {
+		printk(KERN_WARNING "Gigantic HugeTLB page not available\n");
 		return 0;
+	}
 
 #ifdef CONFIG_HIGHMEM
 	/*
@@ -429,8 +431,10 @@ void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages)
 int alloc_bootmem_huge_page(struct hstate *hstate)
 {
 	struct huge_bootmem_page *m;
-	if (nr_gpages == 0)
+	if (nr_gpages == 0) {
+		printk(KERN_WARNING "Gigantic HugeTLB page not available\n");
 		return 0;
+	}
 	m = phys_to_virt(gpage_freearray[--nr_gpages]);
 	gpage_freearray[nr_gpages] = 0;
 	list_add(&m->list, &huge_boot_pages);
-- 
2.1.0
