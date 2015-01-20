Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0108.outbound.protection.outlook.com [157.56.111.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4DBF1A0C59
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 07:42:35 +1100 (AEDT)
Date: Tue, 20 Jan 2015 14:02:00 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Rik van Riel <riel@redhat.com>, Josh Triplett
 <josh@joshtriplett.org>, Sasha Levin <sasha.levin@oracle.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
 Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/2] mm: fix undefined reference to `.kernel_map_pages' on
 PPC builds
Message-ID: <20150120140200.aa7ba0eb28d95e456972e178@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's possible to configure DEBUG_PAGEALLOC without PAGE_POISONING on
ppc.  Fix building the generic kernel_map_pages() implementation in
this case:

  LD      init/built-in.o
mm/built-in.o: In function `free_pages_prepare':
mm/page_alloc.c:770: undefined reference to `.kernel_map_pages'
mm/built-in.o: In function `prep_new_page':
mm/page_alloc.c:933: undefined reference to `.kernel_map_pages'
mm/built-in.o: In function `map_pages':
mm/compaction.c:61: undefined reference to `.kernel_map_pages'
make: *** [vmlinux] Error 1

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 mm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Makefile b/mm/Makefile
index 4bf586e..2956467 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += debug-pagealloc.o
+obj-$(CONFIG_DEBUG_PAGEALLOC) += debug-pagealloc.o
 obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KMEMCHECK) += kmemcheck.o
-- 
2.2.2
