Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BA1A1A2BFE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 11:44:55 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v9 2/5] genalloc:support allocating specific region
Date: Mon, 14 Sep 2015 09:38:17 +0800
Message-ID: <1442194700-6194-2-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
References: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
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
memory matching the size requirement (no alignment constraint)

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v9:
	- reserve a specific region, if the return region
	- is not during the specific region, return fail.

 include/linux/genalloc.h | 11 +++++++++++
 lib/genalloc.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index aaf3dc2..85e3b2f 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -82,6 +82,13 @@ struct genpool_data_align {
 	int align;		/* alignment by bytes for starting address */
 };
 
+/*
+ *  gen_pool data descriptor for gen_pool_fixed_fit.
+ */
+struct genpool_data_fixed {
+	unsigned long offset;		/* The offset of the specific region */
+};
+
 extern struct gen_pool *gen_pool_create(int, int);
 extern phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
 extern int gen_pool_add_virt(struct gen_pool *, unsigned long, phys_addr_t,
@@ -121,6 +128,10 @@ extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
 		struct gen_pool *pool);
 
+extern unsigned long gen_pool_fixed_fit(unsigned long *map,
+		unsigned long size, unsigned long start, unsigned int nr,
+		void *data, struct gen_pool *pool);
+
 extern unsigned long gen_pool_first_fit_align(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
 		void *data, struct gen_pool *pool);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index b8762b1..87a045e 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -554,6 +554,36 @@ unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
 EXPORT_SYMBOL(gen_pool_first_fit_align);
 
 /**
+ * gen_pool_fixed_fit - reserve a specific region of
+ * matching the size requirement (no alignment constraint)
+ * @map: The address to base the search on
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ * @nr: The number of zeroed bits we're looking for
+ * @data: data for alignment
+ * @pool: pool to get order from
+ */
+unsigned long gen_pool_fixed_fit(unsigned long *map, unsigned long size,
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
+	start_bit = bitmap_find_next_zero_area(map, size,
+			start + offset_bit, nr, 0);
+	if (start_bit != offset_bit)
+		start_bit = size;
+	return start_bit;
+}
+EXPORT_SYMBOL(gen_pool_fixed_fit);
+
+/**
  * gen_pool_first_fit_order_align - find the first available region
  * of memory matching the size requirement. The region will be aligned
  * to the order of the size specified.
-- 
2.1.0.27.g96db324
