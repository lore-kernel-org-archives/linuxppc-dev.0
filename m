Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7JmN34mgzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 18:55:32 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@kernel.org>,
 linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] memremap: merge find_dev_pagemap into get_dev_pagemap
Date: Fri, 29 Dec 2017 08:54:06 +0100
Message-Id: <20171229075406.1936-18-hch@lst.de>
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

There is only one caller of the trivial function find_dev_pagemap left,
so just merge it into the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index a9a948cd3d7f..ada31b0d76d4 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -306,14 +306,6 @@ static void devm_memremap_pages_release(void *data)
 		      "%s: failed to free all reserved pages\n", __func__);
 }
 
-/* assumes rcu_read_lock() held at entry */
-static struct dev_pagemap *find_dev_pagemap(resource_size_t phys)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	return radix_tree_lookup(&pgmap_radix, PHYS_PFN(phys));
-}
-
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
@@ -466,7 +458,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 
 	/* fall back to slow path lookup */
 	rcu_read_lock();
-	pgmap = find_dev_pagemap(phys);
+	pgmap = radix_tree_lookup(&pgmap_radix, PHYS_PFN(phys));
 	if (pgmap && !percpu_ref_tryget_live(pgmap->ref))
 		pgmap = NULL;
 	rcu_read_unlock();
-- 
2.14.2
