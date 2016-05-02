Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qyyGq445WzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 18:32:35 +1000 (AEST)
Date: Mon, 2 May 2016 18:32:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Ebru Akagunduz
 <ebru.akagunduz@gmail.com>, Rik van Riel <riel@redhat.com>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20160502183234.1dad8115@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (powerpc
allyesconfig and pseries_le_defconfig) failed like this:

In file included from include/linux/mm.h:394:0,
                 from mm/huge_memory.c:10:
include/linux/huge_mm.h:53:22: error: initializer element is not constant
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                      ^
mm/huge_memory.c:104:62: note: in expansion of macro 'HPAGE_PMD_NR'
 static unsigned int khugepaged_max_ptes_swap __read_mostly = HPAGE_PMD_NR/8;
                                                              ^

Caused by commit

  6d34b9749be2 ("mm: make optimistic check for swapin readahead")

interacting with commit

  dd1842a2a448 ("powerpc/mm: Make page table size a variable")

from the powerpc tree.

I applied this fix patch for today (hopefully this is still initialised
early enough):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 2 May 2016 18:25:42 +1000
Subject: [PATCH] mm: make optimistic check for swapin readahead fix

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f0cd9dbc1157..6aabfa166b6d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -101,7 +101,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  * fault.
  */
 static unsigned int khugepaged_max_ptes_none __read_mostly;
-static unsigned int khugepaged_max_ptes_swap __read_mostly = HPAGE_PMD_NR/8;
+static unsigned int khugepaged_max_ptes_swap __read_mostly;
 static unsigned long allocstall;
 
 static int khugepaged(void *none);
@@ -703,6 +703,7 @@ static int __init hugepage_init(void)
 
 	khugepaged_pages_to_scan = HPAGE_PMD_NR * 8;
 	khugepaged_max_ptes_none = HPAGE_PMD_NR - 1;
+	khugepaged_max_ptes_swap = HPAGE_PMD_NR / 8;
 	/*
 	 * hugepages can't be allocated by the buddy allocator
 	 */
-- 
2.7.0




-- 
Cheers,
Stephen Rothwell
