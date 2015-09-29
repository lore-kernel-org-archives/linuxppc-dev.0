Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBD0E1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 12:15:41 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v11 1/6] genalloc:support memory-allocation with
 bytes-alignment to genalloc
Date: Tue, 29 Sep 2015 10:09:16 +0800
Message-ID: <1443492561-11538-1-git-send-email-qiang.zhao@freescale.com>
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

Bytes alignment is required to manage some special RAM,
so add gen_pool_first_fit_align to genalloc,
meanwhile add gen_pool_alloc_data to pass data to
gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v6:
	- patches set v6 include a new patch because of using 
	- genalloc to manage QE MURAM, patch 0001 is the new 
	- patch, adding bytes alignment for allocation for use.
Changes for v7:
	- cpm muram also need to use genalloc to manage, it has 
	  a function to reserve a specific region of muram,
	  add offset to genpool_data for start addr to be allocated.
Changes for v8:
	- remove supporting reserving a specific region from this patch
	  add a new patch to support it.
Changes for v9:
	- Nil 
Changes for v10:
	- Nil
Changes for v11:
	- Nil

 include/linux/genalloc.h | 24 ++++++++++++++++----
 lib/genalloc.c           | 58 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 1ccaab4..aaf3dc2 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -30,10 +30,12 @@
 #ifndef __GENALLOC_H__
 #define __GENALLOC_H__
 
+#include <linux/types.h>
 #include <linux/spinlock_types.h>
 
 struct device;
 struct device_node;
+struct gen_pool;
 
 /**
  * Allocation callback function type definition
@@ -47,7 +49,7 @@ typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
 			unsigned long start,
 			unsigned int nr,
-			void *data);
+			void *data, struct gen_pool *pool);
 
 /*
  *  General purpose special memory pool descriptor.
@@ -73,6 +75,13 @@ struct gen_pool_chunk {
 	unsigned long bits[0];		/* bitmap for allocating memory chunk */
 };
 
+/*
+ *  gen_pool data descriptor for gen_pool_first_fit_align.
+ */
+struct genpool_data_align {
+	int align;		/* alignment by bytes for starting address */
+};
+
 extern struct gen_pool *gen_pool_create(int, int);
 extern phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
 extern int gen_pool_add_virt(struct gen_pool *, unsigned long, phys_addr_t,
@@ -96,6 +105,7 @@ static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
 }
 extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
+extern unsigned long gen_pool_alloc_data(struct gen_pool *, size_t, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
@@ -108,14 +118,20 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
 		void *data);
 
 extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
-		unsigned long start, unsigned int nr, void *data);
+		unsigned long start, unsigned int nr, void *data,
+		struct gen_pool *pool);
+
+extern unsigned long gen_pool_first_fit_align(unsigned long *map,
+		unsigned long size, unsigned long start, unsigned int nr,
+		void *data, struct gen_pool *pool);
 
 extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
-		void *data);
+		void *data, struct gen_pool *pool);
 
 extern unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
-		unsigned long start, unsigned int nr, void *data);
+		unsigned long start, unsigned int nr, void *data,
+		struct gen_pool *pool);
 
 extern struct gen_pool *devm_gen_pool_create(struct device *dev,
 		int min_alloc_order, int nid);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index d214866..b8762b1 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -269,6 +269,24 @@ EXPORT_SYMBOL(gen_pool_destroy);
  */
 unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
 {
+	return gen_pool_alloc_data(pool, size, pool->data);
+}
+EXPORT_SYMBOL(gen_pool_alloc);
+
+/**
+ * gen_pool_alloc_data - allocate special memory from the pool
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @data: data passed to algorithm
+ *
+ * Allocate the requested number of bytes from the specified pool.
+ * Uses the pool allocation function (with first-fit algorithm by default).
+ * Can not be used in NMI handler on architectures without
+ * NMI-safe cmpxchg implementation.
+ */
+unsigned long gen_pool_alloc_data(struct gen_pool *pool, size_t size,
+		void *data)
+{
 	struct gen_pool_chunk *chunk;
 	unsigned long addr = 0;
 	int order = pool->min_alloc_order;
@@ -290,7 +308,7 @@ unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
 		end_bit = chunk_size(chunk) >> order;
 retry:
 		start_bit = pool->algo(chunk->bits, end_bit, start_bit, nbits,
-				pool->data);
+				data, pool);
 		if (start_bit >= end_bit)
 			continue;
 		remain = bitmap_set_ll(chunk->bits, start_bit, nbits);
@@ -309,7 +327,7 @@ retry:
 	rcu_read_unlock();
 	return addr;
 }
-EXPORT_SYMBOL(gen_pool_alloc);
+EXPORT_SYMBOL(gen_pool_alloc_data);
 
 /**
  * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
@@ -500,15 +518,42 @@ EXPORT_SYMBOL(gen_pool_set_algo);
  * @start: The bitnumber to start searching at
  * @nr: The number of zeroed bits we're looking for
  * @data: additional data - unused
+ * @pool: pool to find the fit region memory from
  */
 unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
-		unsigned long start, unsigned int nr, void *data)
+		unsigned long start, unsigned int nr, void *data,
+		struct gen_pool *pool)
 {
 	return bitmap_find_next_zero_area(map, size, start, nr, 0);
 }
 EXPORT_SYMBOL(gen_pool_first_fit);
 
 /**
+ * gen_pool_first_fit_align - find the first available region
+ * of memory matching the size requirement (alignment constraint)
+ * @map: The address to base the search on
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ * @nr: The number of zeroed bits we're looking for
+ * @data: data for alignment
+ * @pool: pool to get order from
+ */
+unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
+		unsigned long start, unsigned int nr, void *data,
+		struct gen_pool *pool)
+{
+	struct genpool_data_align *alignment;
+	unsigned long align_mask;
+	int order;
+
+	alignment = data;
+	order = pool->min_alloc_order;
+	align_mask = ((alignment->align + (1UL << order) - 1) >> order) - 1;
+	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
+}
+EXPORT_SYMBOL(gen_pool_first_fit_align);
+
+/**
  * gen_pool_first_fit_order_align - find the first available region
  * of memory matching the size requirement. The region will be aligned
  * to the order of the size specified.
@@ -517,10 +562,11 @@ EXPORT_SYMBOL(gen_pool_first_fit);
  * @start: The bitnumber to start searching at
  * @nr: The number of zeroed bits we're looking for
  * @data: additional data - unused
+ * @pool: pool to find the fit region memory from
  */
 unsigned long gen_pool_first_fit_order_align(unsigned long *map,
 		unsigned long size, unsigned long start,
-		unsigned int nr, void *data)
+		unsigned int nr, void *data, struct gen_pool *pool)
 {
 	unsigned long align_mask = roundup_pow_of_two(nr) - 1;
 
@@ -536,12 +582,14 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);
  * @start: The bitnumber to start searching at
  * @nr: The number of zeroed bits we're looking for
  * @data: additional data - unused
+ * @pool: pool to find the fit region memory from
  *
  * Iterate over the bitmap to find the smallest free region
  * which we can allocate the memory.
  */
 unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
-		unsigned long start, unsigned int nr, void *data)
+		unsigned long start, unsigned int nr, void *data,
+		struct gen_pool *pool)
 {
 	unsigned long start_bit = size;
 	unsigned long len = size + 1;
-- 
2.1.0.27.g96db324
