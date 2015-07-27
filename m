Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AC211A4472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 20:03:04 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <lauraa@codeaurora.org>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <akpm@linux-foundation.org>, <olof@lixom.net>, <catalin.marinas@arm.com>,
 <scottwood@freescale.com>, <X.xie@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [RFC v2] genalloc:add an gen_pool_first_fit_align algo to genalloc
Date: Mon, 27 Jul 2015 17:57:54 +0800
Message-ID: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
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

Bytes alignment is required to manage some special ram,
so add gen_pool_first_fit_align to genalloc.
User should define data structure
struct data {
	int align;
	struct gen_pool *pool;
}
align is the number of  bytes alignment,
pool points to gen_pool which include data.

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




 include/linux/genalloc.h |  4 ++++
 lib/genalloc.c           | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 1ccaab4..b85d0f8 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -110,6 +110,10 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
 extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data);
 
+extern unsigned long gen_pool_first_fit_align(unsigned long *map,
+		unsigned long size, unsigned long start, unsigned int nr,
+		void *data);
+
 extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
 		unsigned long size, unsigned long start, unsigned int nr,
 		void *data);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index d214866..e6608cd 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -509,6 +509,31 @@ unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 EXPORT_SYMBOL(gen_pool_first_fit);
 
 /**
+ * gen_pool_first_fit_align - find the first available region
+ * of memory matching the size requirement (no alignment constraint)
+ * @map: The address to base the search on
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ * @nr: The number of zeroed bits we're looking for
+ * @data: additional data - unused
+ */
+unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
+		unsigned long start, unsigned int nr, void *data)
+{
+	unsigned long align_mask;
+	int order;
+
+	if (data && data->pool) {
+		order = data->pool->min_alloc_order;
+		align_mask = ((data->align + (1UL << order) - 1) >> order) - 1;
+	} else {
+		pr_err("no data or data->pool\n");
+	}
+	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
+}
+EXPORT_SYMBOL(gen_pool_first_fit_algin);
+
+/**
  * gen_pool_first_fit_order_align - find the first available region
  * of memory matching the size requirement. The region will be aligned
  * to the order of the size specified.
-- 
2.1.0.27.g96db324
