Return-Path: <dingel@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E890F1A17E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 21:53:03 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dingel@linux.vnet.ibm.com>;
 Thu, 28 May 2015 12:53:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A106C17D805F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 12:53:52 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4SBquhh21954710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 11:52:57 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4SBqleF008642
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 05:52:56 -0600
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com,
 "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@ezchip.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhang Zhen <zhenzhang.zhang@huawei.com>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>,
 David Rientjes <rientjes@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nathan Lynch <nathan_lynch@mentor.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 Hugh Dickins <hughd@google.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/5] mm/hugetlb: remove unused arch hook
 prepare/release_hugepage
Date: Thu, 28 May 2015 13:52:34 +0200
Message-Id: <1432813957-46874-3-git-send-email-dingel@linux.vnet.ibm.com>
In-Reply-To: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With s390 dropping support for emulated hugepages, the last user of
arch_prepare_hugepage and arch_release_hugepage is gone.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 mm/hugetlb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 290984b..a97958e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -917,7 +917,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
-		arch_release_hugepage(page);
 		__free_pages(page, huge_page_order(h));
 	}
 }
@@ -1102,10 +1101,6 @@ static struct page *alloc_fresh_huge_page_node(struct hstate *h, int nid)
 						__GFP_REPEAT|__GFP_NOWARN,
 		huge_page_order(h));
 	if (page) {
-		if (arch_prepare_hugepage(page)) {
-			__free_pages(page, huge_page_order(h));
-			return NULL;
-		}
 		prep_new_huge_page(h, page, nid);
 	}
 
@@ -1257,11 +1252,6 @@ static struct page *alloc_buddy_huge_page(struct hstate *h, int nid)
 			htlb_alloc_mask(h)|__GFP_COMP|__GFP_THISNODE|
 			__GFP_REPEAT|__GFP_NOWARN, huge_page_order(h));
 
-	if (page && arch_prepare_hugepage(page)) {
-		__free_pages(page, huge_page_order(h));
-		page = NULL;
-	}
-
 	spin_lock(&hugetlb_lock);
 	if (page) {
 		INIT_LIST_HEAD(&page->lru);
-- 
2.3.7
