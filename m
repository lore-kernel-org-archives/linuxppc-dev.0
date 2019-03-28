Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC4C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 16:49:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFAD2173C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 16:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFAD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VW7D3ZR1zDqBL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 03:49:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VW2f0Kq0zDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 03:45:42 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Mar 2019 09:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,281,1549958400"; d="scan'208";a="218460196"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga001.jf.intel.com with ESMTP; 28 Mar 2019 09:45:35 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
 John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>
Subject: [PATCH V3 2/7] mm/gup: Change write parameter to flags in fast walk
Date: Thu, 28 Mar 2019 01:44:17 -0700
Message-Id: <20190328084422.29911-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328084422.29911-1-ira.weiny@intel.com>
References: <20190328084422.29911-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-rdma@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Ira Weiny <ira.weiny@intel.com>

In order to support more options in the GUP fast walk, change
the write parameter to flags throughout the call stack.

This patch does not change functionality and passes FOLL_WRITE
where write was previously used.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2
	Add review by

 mm/gup.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 12ce886733b9..6304317a308e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1591,7 +1591,7 @@ static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
 
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			 int write, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
 	int nr_start = *nr, ret = 0;
@@ -1609,7 +1609,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (pte_protnone(pte))
 			goto pte_unmap;
 
-		if (!pte_access_permitted(pte, write))
+		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
 		if (pte_devmap(pte)) {
@@ -1661,7 +1661,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
  * useful to have gup_huge_pmd even if we can't operate on ptes.
  */
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			 int write, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr)
 {
 	return 0;
 }
@@ -1744,12 +1744,12 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 #endif
 
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, int write, struct page **pages, int *nr)
+		unsigned long end, unsigned int flags, struct page **pages, int *nr)
 {
 	struct page *head, *page;
 	int refs;
 
-	if (!pmd_access_permitted(orig, write))
+	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
 	if (pmd_devmap(orig))
@@ -1782,12 +1782,12 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 }
 
 static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, int write, struct page **pages, int *nr)
+		unsigned long end, unsigned int flags, struct page **pages, int *nr)
 {
 	struct page *head, *page;
 	int refs;
 
-	if (!pud_access_permitted(orig, write))
+	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
 	if (pud_devmap(orig))
@@ -1820,13 +1820,13 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 }
 
 static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
-			unsigned long end, int write,
+			unsigned long end, unsigned int flags,
 			struct page **pages, int *nr)
 {
 	int refs;
 	struct page *head, *page;
 
-	if (!pgd_access_permitted(orig, write))
+	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
 	BUILD_BUG_ON(pgd_devmap(orig));
@@ -1857,7 +1857,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 }
 
 static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
-		int write, struct page **pages, int *nr)
+		unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -1880,7 +1880,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			if (pmd_protnone(pmd))
 				return 0;
 
-			if (!gup_huge_pmd(pmd, pmdp, addr, next, write,
+			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
 				pages, nr))
 				return 0;
 
@@ -1890,9 +1890,9 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			 * pmd format and THP pmd format
 			 */
 			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
-					 PMD_SHIFT, next, write, pages, nr))
+					 PMD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
+		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
 			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
@@ -1900,7 +1900,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 }
 
 static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
-			 int write, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pud_t *pudp;
@@ -1913,14 +1913,14 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 		if (pud_none(pud))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
-			if (!gup_huge_pud(pud, pudp, addr, next, write,
+			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
 			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
-					 PUD_SHIFT, next, write, pages, nr))
+					 PUD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
@@ -1928,7 +1928,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 }
 
 static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
-			 int write, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	p4d_t *p4dp;
@@ -1943,9 +1943,9 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 		BUILD_BUG_ON(p4d_huge(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
 			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
-					 P4D_SHIFT, next, write, pages, nr))
+					 P4D_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pud_range(p4d, addr, next, write, pages, nr))
+		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr))
 			return 0;
 	} while (p4dp++, addr = next, addr != end);
 
@@ -1953,7 +1953,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 }
 
 static void gup_pgd_range(unsigned long addr, unsigned long end,
-		int write, struct page **pages, int *nr)
+		unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pgd_t *pgdp;
@@ -1966,14 +1966,14 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_huge(pgd))) {
-			if (!gup_huge_pgd(pgd, pgdp, addr, next, write,
+			if (!gup_huge_pgd(pgd, pgdp, addr, next, flags,
 					  pages, nr))
 				return;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
 			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
-					 PGDIR_SHIFT, next, write, pages, nr))
+					 PGDIR_SHIFT, next, flags, pages, nr))
 				return;
-		} else if (!gup_p4d_range(pgd, addr, next, write, pages, nr))
+		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr))
 			return;
 	} while (pgdp++, addr = next, addr != end);
 }
@@ -2027,7 +2027,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_save(flags);
-		gup_pgd_range(start, end, write, pages, &nr);
+		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
 		local_irq_restore(flags);
 	}
 
@@ -2069,7 +2069,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, write, pages, &nr);
+		gup_pgd_range(addr, end, write ? FOLL_WRITE : 0, pages, &nr);
 		local_irq_enable();
 		ret = nr;
 	}
-- 
2.20.1

