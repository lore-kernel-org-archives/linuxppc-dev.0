Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B8A71A1C07
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 17:09:46 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <lauraa@codeaurora.org>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <akpm@linux-foundation.org>, <olof@lixom.net>, <catalin.marinas@arm.com>,
 <scottwood@freescale.com>, <X.xie@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [RFC v4] genalloc:support memory-allocation with bytes-alignment to
 genalloc
Date: Wed, 5 Aug 2015 14:50:04 +0800
Message-ID: <1438757404-17777-1-git-send-email-qiang.zhao@freescale.com>
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
*v2:
changes:
title has been modified, original patch link: 
http://patchwork.ozlabs.org/patch/493297/

original patch add a func gen_pool_alloc_align, 
then pass alignment to it as an parameter.
after discussing with lauraa and scott, they recommend 
to pass alignment as part of data based on 
commit message for ca279cf1065fb689abea1dc7d8c11787729bb185 which adds "data":

"As I can't predict all the possible requirements/needs for all allocation    
uses cases, I add a "free" field 'void *data' to pass any needed     
information to the allocation function.  For example 'data' could be used     
to handle a structure where you store the alignment, the expected memory     
bank, the requester device, or any information that could influence the     
allocation algorithm."

*v3:
changes:
title has been modified, original patch link: 
http://patchwork.ozlabs.org/patch/500317/

according to the comments, add gen_pool_alloc_data,
modify gen_pool_alloc as a wrapper, define struct data_align
for gen_pool_first_fit_align algorithm. add parameter 
pointer pool to algorithm.

*v4:
changes:
v3 link: 
http://patchwork.ozlabs.org/patch/500317/
There are comments for v3, according to the comments,
modify the patch for v4. such as modifying annotations,
removing unnecessary chek, removing unnecessary cast and so on.

 include/linux/genalloc.h | 23 +++++++++++++++----
 lib/genalloc.c           | 58 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 1ccaab4..55da07e 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -34,6 +34,7 @@
 
 struct device;
 struct device_node;
+struct gen_pool;
 
 /**
  * Allocation callback function type definition
@@ -47,7 +48,7 @@ typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
 			unsigned long start,
 			unsigned int nr,
-			void *data);
+			void *data, struct gen_pool *pool);
 
 /*
  *  General purpose special memory pool descriptor.
@@ -73,6 +74,13 @@ struct gen_pool_chunk {
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
@@ -96,6 +104,7 @@ static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
 }
 extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
+extern unsigned long gen_pool_alloc_data(struct gen_pool *, size_t, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
@@ -108,14 +117,20 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
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
index d214866..fe11a00 100644
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
+ * @pool: unused, but the algorithm functions have same format.
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
+ * @pool: get order from pool
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
+ * @pool: unused, but the algorithm functions have same format.
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
+ * @pool: unused, but the algorithm functions have same format.
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
