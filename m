Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7Jm8441tzDqls
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 18:55:20 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@kernel.org>,
 linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] memremap: simplify duplicate region handling in
 devm_memremap_pages
Date: Fri, 29 Dec 2017 08:54:03 +0100
Message-Id: <20171229075406.1936-15-hch@lst.de>
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

__radix_tree_insert already checks for duplicates and returns -EEXIST in
that case, so remove the duplicate (and racy) duplicates check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/memremap.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index b09517439dec..12e78528fea4 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -396,17 +396,6 @@ void *devm_memremap_pages(struct device *dev, struct resource *res,
 	align_end = align_start + align_size - 1;
 
 	foreach_order_pgoff(res, order, pgoff) {
-		struct dev_pagemap *dup;
-
-		rcu_read_lock();
-		dup = find_dev_pagemap(res->start + PFN_PHYS(pgoff));
-		rcu_read_unlock();
-		if (dup) {
-			dev_err(dev, "%s: %pr collides with mapping for %s\n",
-					__func__, res, dev_name(dup->dev));
-			error = -EBUSY;
-			break;
-		}
 		error = __radix_tree_insert(&pgmap_radix,
 				PHYS_PFN(res->start) + pgoff, order, page_map);
 		if (error) {
-- 
2.14.2
