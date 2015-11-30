Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89FDA1A0942
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 13:56:47 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <lauraa@codeaurora.org>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <akpm@linux-foundation.org>, <olof@lixom.net>, <catalin.marinas@arm.com>,
 <scottwood@freescale.com>, <X.xie@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v13 2/6] genalloc:support allocating specific region
Date: Mon, 30 Nov 2015 10:48:53 +0800
Message-ID: <1448851737-33125-2-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
References: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new algo for genalloc, it reserve a specific region of
memory

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v9:
	- reserve a specific region, if the return region
	- is not during the specific region, return fail.
Changes for v10:
	- rename gen_pool_fixed_fit to gen_pool_fixed_alloc
Changes for v11:
	- rename gen_pool_fixed_fit to gen_pool_fixed_alloc
Changes for v12:
	- Nil
Changes for v13:
	- modify commit message
	- add WARN_ON.

 include/linux/genalloc.h | 11 +++++++++++
 lib/genalloc.c           | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 3c676ce..29d4385 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -84,6 +84,13 @@ struct genpool_data_align {
 	int align;		/* alignment by bytes for starting address */
 };
 
+/*
+ *  gen_pool data descriptor for gen_pool_fixed_alloc.
+ */
+struct genpool_data_fixed {
+	unsigned long offset;		/* The offset of the specific region */
+};
+
 extern struct gen_pool *gen_pool_create(int, int);
 extern phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
 extern int gen_pool_add_virt(struct gen_pool *, unsigned long, phys_addr_t,
@@ -124,6 +131,10 @@ extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
 		struct gen_pool *pool);
 
+extern unsigned long gen_pool_fixed_alloc(unsigned long *map,
+		unsigned long size, unsigned long start, unsigned int nr,
+		void *data, struct gen_pool *pool);
+
 extern unsigned long gen_pool_first_fit_align(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
 		void *data, struct gen_pool *pool);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index b8cf89d..5ec83cd 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -556,6 +556,38 @@ unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
 EXPORT_SYMBOL(gen_pool_first_fit_align);
 
 /**
+ * gen_pool_fixed_alloc - reserve a specific region
+ * @map: The address to base the search on
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ * @nr: The number of zeroed bits we're looking for
+ * @data: data for alignment
+ * @pool: pool to get order from
+ */
+unsigned long gen_pool_fixed_alloc(unsigned long *map, unsigned long size,
+		unsigned long start, unsigned int nr, void *data,
+		struct gen_pool *pool)
+{
+	struct genpool_data_fixed *fixed_data;
+	int order;
+	unsigned long offset_bit;
+	unsigned long start_bit;
+
+	fixed_data = data;
+	order = pool->min_alloc_order;
+	offset_bit = fixed_data->offset >> order;
+	if (WARN_ON(fixed_data->offset & (1UL << order - 1)))
+		return size;
+
+	start_bit = bitmap_find_next_zero_area(map, size,
+			start + offset_bit, nr, 0);
+	if (start_bit != offset_bit)
+		start_bit = size;
+	return start_bit;
+}
+EXPORT_SYMBOL(gen_pool_fixed_alloc);
+
+/**
  * gen_pool_first_fit_order_align - find the first available region
  * of memory matching the size requirement. The region will be aligned
  * to the order of the size specified.
-- 
2.1.0.27.g96db324
