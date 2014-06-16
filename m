Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 82DC91A0376
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 15:36:43 +1000 (EST)
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH v3 -next 1/9] DMA, CMA: fix possible memory leak
Date: Mon, 16 Jun 2014 14:40:43 +0900
Message-Id: <1402897251-23639-2-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should free memory for bitmap when we find zone mis-match,
otherwise this memory will leak.

Additionally, I copy code comment from PPC KVM's CMA code to inform
why we need to check zone mis-match.

* Note
Minchan suggested to add a tag for the stable, but, I don't do it,
because I found this possibility during code-review and, IMO,
this patch isn't suitable for stable tree.

Acked-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Reviewed-by: Michal Nazarewicz <mina86@mina86.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 83969f8..6467c91 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -176,14 +176,24 @@ static int __init cma_activate_area(struct cma *cma)
 		base_pfn = pfn;
 		for (j = pageblock_nr_pages; j; --j, pfn++) {
 			WARN_ON_ONCE(!pfn_valid(pfn));
+			/*
+			 * alloc_contig_range requires the pfn range
+			 * specified to be in the same zone. Make this
+			 * simple by forcing the entire CMA resv range
+			 * to be in the same zone.
+			 */
 			if (page_zone(pfn_to_page(pfn)) != zone)
-				return -EINVAL;
+				goto err;
 		}
 		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
 	} while (--i);
 
 	mutex_init(&cma->lock);
 	return 0;
+
+err:
+	kfree(cma->bitmap);
+	return -EINVAL;
 }
 
 static struct cma cma_areas[MAX_CMA_AREAS];
-- 
1.7.9.5
