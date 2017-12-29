Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7Jm51dlXzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 18:55:17 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@kernel.org>,
 linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] memremap: remove to_vmem_altmap
Date: Fri, 29 Dec 2017 08:54:02 +0100
Message-Id: <20171229075406.1936-14-hch@lst.de>
In-Reply-To: <20171229075406.1936-1-hch@lst.de>
References: <20171229075406.1936-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All callers are gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |  9 ---------
 kernel/memremap.c        | 26 --------------------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 26e8aaba27d5..3fddcfe57bb0 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -26,15 +26,6 @@ struct vmem_altmap {
 	unsigned long alloc;
 };
 
-#ifdef CONFIG_ZONE_DEVICE
-struct vmem_altmap *to_vmem_altmap(unsigned long memmap_start);
-#else
-static inline struct vmem_altmap *to_vmem_altmap(unsigned long memmap_start)
-{
-	return NULL;
-}
-#endif
-
 /*
  * Specialize ZONE_DEVICE memory into multiple types each having differents
  * usage.
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 891c77487a6a..b09517439dec 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -476,32 +476,6 @@ void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
 	altmap->alloc -= nr_pfns;
 }
 
-struct vmem_altmap *to_vmem_altmap(unsigned long memmap_start)
-{
-	/*
-	 * 'memmap_start' is the virtual address for the first "struct
-	 * page" in this range of the vmemmap array.  In the case of
-	 * CONFIG_SPARSEMEM_VMEMMAP a page_to_pfn conversion is simple
-	 * pointer arithmetic, so we can perform this to_vmem_altmap()
-	 * conversion without concern for the initialization state of
-	 * the struct page fields.
-	 */
-	struct page *page = (struct page *) memmap_start;
-	struct dev_pagemap *pgmap;
-
-	/*
-	 * Unconditionally retrieve a dev_pagemap associated with the
-	 * given physical address, this is only for use in the
-	 * arch_{add|remove}_memory() for setting up and tearing down
-	 * the memmap.
-	 */
-	rcu_read_lock();
-	pgmap = find_dev_pagemap(__pfn_to_phys(page_to_pfn(page)));
-	rcu_read_unlock();
-
-	return pgmap ? pgmap->altmap : NULL;
-}
-
 /**
  * get_dev_pagemap() - take a new live reference on the dev_pagemap for @pfn
  * @pfn: page frame number to lookup page_map
-- 
2.14.2
