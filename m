Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1BFC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 02:44:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A750020857
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 02:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A750020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N0rk68MZzDqNP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 13:44:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N0fz702ZzDqKt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 13:36:11 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Mar 2019 19:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,491,1544515200"; d="scan'208";a="155877421"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2019 19:36:04 -0700
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
Subject: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Date: Sun, 17 Mar 2019 11:34:35 -0700
Message-Id: <20190317183438.2057-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317183438.2057-1-ira.weiny@intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
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
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Ira Weiny <ira.weiny@intel.com>

DAX pages were previously unprotected from longterm pins when users
called get_user_pages_fast().

Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
back to regular GUP processing if a DEVMAP page is encountered.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0684a9536207..173db0c44678 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1600,6 +1600,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 
 		if (pte_devmap(pte)) {
+			if (unlikely(flags & FOLL_LONGTERM))
+				goto pte_unmap;
+
 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
 				undo_dev_pagemap(nr, nr_start, pages);
@@ -1739,8 +1742,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pmd_devmap(orig))
+	if (pmd_devmap(orig)) {
+		if (unlikely(flags & FOLL_LONGTERM))
+			return 0;
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
+	}
 
 	refs = 0;
 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -1777,8 +1783,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pud_devmap(orig))
+	if (pud_devmap(orig)) {
+		if (unlikely(flags & FOLL_LONGTERM))
+			return 0;
 		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
+	}
 
 	refs = 0;
 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
@@ -2066,8 +2075,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		start += nr << PAGE_SHIFT;
 		pages += nr;
 
-		ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
-					      gup_flags);
+		if (gup_flags & FOLL_LONGTERM) {
+			down_read(&current->mm->mmap_sem);
+			ret = __gup_longterm_locked(current, current->mm,
+						    start, nr_pages - nr,
+						    pages, NULL, gup_flags);
+			up_read(&current->mm->mmap_sem);
+		} else {
+			/*
+			 * retain FAULT_FOLL_ALLOW_RETRY optimization if
+			 * possible
+			 */
+			ret = get_user_pages_unlocked(start, nr_pages - nr,
+						      pages, gup_flags);
+		}
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
-- 
2.20.1

