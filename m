Return-Path: <BATV+f9b51a8ca15fdac5c6a2+5227+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yysl83yFGzDrZJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 01:10:11 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] memremap: provide stubs for vmem_altmap_offset and
 vmem_altmap_free
Date: Fri, 15 Dec 2017 15:09:31 +0100
Message-Id: <20171215140947.26075-2-hch@lst.de>
In-Reply-To: <20171215140947.26075-1-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently all calls to those functions are eliminated by the compiler when
CONFIG_ZONE_DEVICE is not set, but this soon won't be the case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memremap.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 10d23c367048..d5a6736d9737 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -26,9 +26,6 @@ struct vmem_altmap {
 	unsigned long alloc;
 };
 
-unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
-void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
-
 #ifdef CONFIG_ZONE_DEVICE
 struct vmem_altmap *to_vmem_altmap(unsigned long memmap_start);
 #else
@@ -138,6 +135,9 @@ void *devm_memremap_pages(struct device *dev, struct resource *res,
 		struct percpu_ref *ref, struct vmem_altmap *altmap);
 struct dev_pagemap *find_dev_pagemap(resource_size_t phys);
 
+unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
+void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
+
 static inline bool is_zone_device_page(const struct page *page);
 #else
 static inline void *devm_memremap_pages(struct device *dev,
@@ -157,7 +157,17 @@ static inline struct dev_pagemap *find_dev_pagemap(resource_size_t phys)
 {
 	return NULL;
 }
-#endif
+
+static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+{
+	return 0;
+}
+
+static inline void vmem_altmap_free(struct vmem_altmap *altmap,
+		unsigned long nr_pfns)
+{
+}
+#endif /* CONFIG_ZONE_DEVICE */
 
 #if defined(CONFIG_DEVICE_PRIVATE) || defined(CONFIG_DEVICE_PUBLIC)
 static inline bool is_device_private_page(const struct page *page)
-- 
2.14.2
