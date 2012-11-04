Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 512F02C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Nov 2012 23:04:13 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id rp16so3049199pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2012 04:04:10 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: iommu: use bitmap library
Date: Sun,  4 Nov 2012 21:03:43 +0900
Message-Id: <1352030625-3471-1-git-send-email-akinobu.mita@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 - Caluculate the bitmap size with BITS_TO_LONGS()
 - Use bitmap_empty() to verify that all bits are cleared

This also includes a printk to pr_warn() conversion.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/iommu.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 8226c6c..c862fd7 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -656,7 +656,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	struct iommu_pool *p;
 
 	/* number of bytes needed for the bitmap */
-	sz = (tbl->it_size + 7) >> 3;
+	sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
 
 	page = alloc_pages_node(nid, GFP_ATOMIC, get_order(sz));
 	if (!page)
@@ -708,7 +708,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 
 void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
-	unsigned long bitmap_sz, i;
+	unsigned long bitmap_sz;
 	unsigned int order;
 
 	if (!tbl || !tbl->it_map) {
@@ -718,17 +718,11 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	}
 
 	/* verify that table contains no entries */
-	/* it_size is in entries, and we're examining 64 at a time */
-	for (i = 0; i < (tbl->it_size/64); i++) {
-		if (tbl->it_map[i] != 0) {
-			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
-				__func__, node_name);
-			break;
-		}
-	}
+	if (!bitmap_empty(tbl->it_map, tbl->it_size))
+		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
 
 	/* calculate bitmap size in bytes */
-	bitmap_sz = (tbl->it_size + 7) / 8;
+	bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
 
 	/* free bitmap */
 	order = get_order(bitmap_sz);
-- 
1.7.11.7
