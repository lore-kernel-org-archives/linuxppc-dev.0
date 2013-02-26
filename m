Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0B702C03FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:12 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 18:02:12 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9B5002BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:09 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q7rXe31507692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 18:53:33 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q868Gf008878
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:09 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 23/24] powerpc/THP: get_user_pages_fast changes
Date: Tue, 26 Feb 2013 13:35:13 +0530
Message-Id: <1361865914-13911-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
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

handle large pages for get_user_pages_fast. Also take care of large page splitting.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/gup.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
index d7efdbf..835c1ae 100644
--- a/arch/powerpc/mm/gup.c
+++ b/arch/powerpc/mm/gup.c
@@ -55,6 +55,72 @@ static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
 	return 1;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int gup_huge_pmd(pmd_t *pmdp, unsigned long addr,
+			       unsigned long end, int write,
+			       struct page **pages, int *nr)
+{
+	int refs;
+	pmd_t pmd;
+	unsigned long mask;
+	struct page *head, *page, *tail;
+
+	pmd = *pmdp;
+	mask = PMD_HUGE_PRESENT | PMD_HUGE_USER;
+	if (write)
+		mask |= PMD_HUGE_RW;
+
+	if ((pmd_val(pmd) & mask) != mask)
+		return 0;
+
+	/* large pages are never "special" */
+	VM_BUG_ON(!pfn_valid(pmd_pfn(pmd)));
+
+	refs = 0;
+	head = pmd_page(pmd);
+	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	tail = page;
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+
+	if (!page_cache_add_speculative(head, refs)) {
+		*nr -= refs;
+		return 0;
+	}
+
+	if (unlikely(pmd_val(pmd) != pmd_val(*pmdp))) {
+		*nr -= refs;
+		while (refs--)
+			put_page(head);
+		return 0;
+	}
+	/*
+	 * Any tail page need their mapcount reference taken before we
+	 * return.
+	 */
+	while (refs--) {
+		if (PageTail(tail))
+			get_huge_page_tail(tail);
+		tail++;
+	}
+
+	return 1;
+}
+#else
+
+static inline int gup_huge_pmd(pmd_t *pmdp, unsigned long addr,
+			       unsigned long end, int write,
+			       struct page **pages, int *nr)
+{
+	return 1;
+}
+#endif
+
 static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		int write, struct page **pages, int *nr)
 {
@@ -66,9 +132,23 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		pmd_t pmd = *pmdp;
 
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(pmd))
+		/*
+		 * The pmd_trans_splitting() check below explains why
+		 * pmdp_splitting_flush has to flush the tlb, to stop
+		 * this gup-fast code from running while we set the
+		 * splitting bit in the pmd. Returning zero will take
+		 * the slow path that will call wait_split_huge_page()
+		 * if the pmd is still in splitting state. gup-fast
+		 * can't because it has irq disabled and
+		 * wait_split_huge_page() would never return as the
+		 * tlb flush IPI wouldn't run.
+		 */
+		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
 			return 0;
-		if (is_hugepd(pmdp)) {
+		if (unlikely(pmd_large(pmd))) {
+			if (!gup_huge_pmd(pmdp, addr, next, write, pages, nr))
+				return 0;
+		} else if (is_hugepd(pmdp)) {
 			if (!gup_hugepd((hugepd_t *)pmdp, PMD_SHIFT,
 					addr, next, write, pages, nr))
 				return 0;
-- 
1.7.10
