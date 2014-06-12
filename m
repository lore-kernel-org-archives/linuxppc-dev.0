Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 315AF1A0614
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 13:17:52 +1000 (EST)
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH v2 10/10] mm, cma: use spinlock instead of mutex
Date: Thu, 12 Jun 2014 12:21:47 +0900
Message-Id: <1402543307-29800-11-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we should take the mutex for manipulating bitmap.
This job may be really simple and short so we don't need to sleep
if contended. So I change it to spinlock.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/cma.c b/mm/cma.c
index 22a5b23..3085e8c 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -27,6 +27,7 @@
 #include <linux/memblock.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -36,7 +37,7 @@ struct cma {
 	unsigned long	count;
 	unsigned long	*bitmap;
 	int order_per_bit; /* Order of pages represented by one bit */
-	struct mutex	lock;
+	spinlock_t	lock;
 };
 
 /*
@@ -72,9 +73,9 @@ static void clear_cma_bitmap(struct cma *cma, unsigned long pfn, int count)
 	bitmapno = (pfn - cma->base_pfn) >> cma->order_per_bit;
 	nr_bits = cma_bitmap_pages_to_bits(cma, count);
 
-	mutex_lock(&cma->lock);
+	spin_lock(&cma->lock);
 	bitmap_clear(cma->bitmap, bitmapno, nr_bits);
-	mutex_unlock(&cma->lock);
+	spin_unlock(&cma->lock);
 }
 
 static int __init cma_activate_area(struct cma *cma)
@@ -112,7 +113,7 @@ static int __init cma_activate_area(struct cma *cma)
 		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
 	} while (--i);
 
-	mutex_init(&cma->lock);
+	spin_lock_init(&cma->lock);
 	return 0;
 
 err:
@@ -261,11 +262,11 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
 	nr_bits = cma_bitmap_pages_to_bits(cma, count);
 
 	for (;;) {
-		mutex_lock(&cma->lock);
+		spin_lock(&cma->lock);
 		bitmapno = bitmap_find_next_zero_area(cma->bitmap,
 					bitmap_maxno, start, nr_bits, mask);
 		if (bitmapno >= bitmap_maxno) {
-			mutex_unlock(&cma->lock);
+			spin_unlock(&cma->lock);
 			break;
 		}
 		bitmap_set(cma->bitmap, bitmapno, nr_bits);
@@ -274,7 +275,7 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
 		 * our exclusive use. If the migration fails we will take the
 		 * lock again and unmark it.
 		 */
-		mutex_unlock(&cma->lock);
+		spin_unlock(&cma->lock);
 
 		pfn = cma->base_pfn + (bitmapno << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
-- 
1.7.9.5
