Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqT4V3XJ7zDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 03:13:46 +1100 (AEDT)
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 5/7] zram: Convert to using memset_l
Date: Fri, 24 Mar 2017 09:13:16 -0700
Message-Id: <20170324161318.18718-6-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matthew Wilcox <mawilcox@microsoft.com>

zram was the motivation for creating memset_l().  Minchan Kim sees a 7%
performance improvement on x86 with 100MB of non-zero deduplicatable
data:

        perf stat -r 10 dd if=/dev/zram0 of=/dev/null

vanilla:        0.232050465 seconds time elapsed ( +-  0.51% )
memset_l:	0.217219387 seconds time elapsed ( +-  0.07% )

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Tested-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e27d89a36c34..25dcad309695 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -157,20 +157,11 @@ static inline void update_used_max(struct zram *zram,
 	} while (old_max != cur_max);
 }
 
-static inline void zram_fill_page(char *ptr, unsigned long len,
+static inline void zram_fill_page(void *ptr, unsigned long len,
 					unsigned long value)
 {
-	int i;
-	unsigned long *page = (unsigned long *)ptr;
-
 	WARN_ON_ONCE(!IS_ALIGNED(len, sizeof(unsigned long)));
-
-	if (likely(value == 0)) {
-		memset(ptr, 0, len);
-	} else {
-		for (i = 0; i < len / sizeof(*page); i++)
-			page[i] = value;
-	}
+	memset_l(ptr, value, len / sizeof(unsigned long));
 }
 
 static bool page_same_filled(void *ptr, unsigned long *element)
@@ -193,7 +184,7 @@ static bool page_same_filled(void *ptr, unsigned long *element)
 static void handle_same_page(struct bio_vec *bvec, unsigned long element)
 {
 	struct page *page = bvec->bv_page;
-	void *user_mem;
+	char *user_mem;
 
 	user_mem = kmap_atomic(page);
 	zram_fill_page(user_mem + bvec->bv_offset, bvec->bv_len, element);
-- 
2.11.0
