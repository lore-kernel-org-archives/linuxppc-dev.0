Return-Path: <saurabh.truth@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F49B1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 19:52:33 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id pv5so7649422pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 00:52:33 -0800 (PST)
From: Saurabh Sengar <saurabh.truth@gmail.com>
To: scottwood@freescale.com, qiang.zhao@freescale.com, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] QE: making cpm_muram_alloc_common into static
Date: Tue, 26 Jan 2016 14:22:01 +0530
Message-Id: <1453798321-7787-1-git-send-email-saurabh.truth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

as cpm_muram_alloc_common is used only in this file,
making it static

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/soc/fsl/qe/qe_common.c | 66 +++++++++++++++++++++---------------------
 include/soc/fsl/qe/qe.h        |  2 --
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 419fa5b..e18159a 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -103,6 +103,39 @@ out_muram:
 }
 
 /*
+ * cpm_muram_alloc_common - cpm_muram_alloc common code
+ * @size: number of bytes to allocate
+ * @algo: algorithm for alloc.
+ * @data: data for genalloc's algorithm.
+ *
+ * This function returns an offset into the muram area.
+ */
+static unsigned long cpm_muram_alloc_common(unsigned long size,
+		genpool_algo_t algo, void *data)
+{
+	struct muram_block *entry;
+	unsigned long start;
+
+	start = gen_pool_alloc_algo(muram_pool, size, algo, data);
+	if (!start)
+		goto out2;
+	start = start - GENPOOL_OFFSET;
+	memset_io(cpm_muram_addr(start), 0, size);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out1;
+	entry->start = start;
+	entry->size = size;
+	list_add(&entry->head, &muram_block_list);
+
+	return start;
+out1:
+	gen_pool_free(muram_pool, start, size);
+out2:
+	return (unsigned long)-ENOMEM;
+}
+
+/*
  * cpm_muram_alloc - allocate the requested size worth of multi-user ram
  * @size: number of bytes to allocate
  * @align: requested alignment, in bytes
@@ -175,39 +208,6 @@ unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
 }
 EXPORT_SYMBOL(cpm_muram_alloc_fixed);
 
-/*
- * cpm_muram_alloc_common - cpm_muram_alloc common code
- * @size: number of bytes to allocate
- * @algo: algorithm for alloc.
- * @data: data for genalloc's algorithm.
- *
- * This function returns an offset into the muram area.
- */
-unsigned long cpm_muram_alloc_common(unsigned long size, genpool_algo_t algo,
-				     void *data)
-{
-	struct muram_block *entry;
-	unsigned long start;
-
-	start = gen_pool_alloc_algo(muram_pool, size, algo, data);
-	if (!start)
-		goto out2;
-	start = start - GENPOOL_OFFSET;
-	memset_io(cpm_muram_addr(start), 0, size);
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		goto out1;
-	entry->start = start;
-	entry->size = size;
-	list_add(&entry->head, &muram_block_list);
-
-	return start;
-out1:
-	gen_pool_free(muram_pool, start, size);
-out2:
-	return (unsigned long)-ENOMEM;
-}
-
 /**
  * cpm_muram_addr - turn a muram offset into a virtual address
  * @offset: muram offset to convert
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index c7fa36c..33b29ea 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -103,8 +103,6 @@ int cpm_muram_init(void);
 unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
 int cpm_muram_free(unsigned long offset);
 unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
-unsigned long cpm_muram_alloc_common(unsigned long size, genpool_algo_t algo,
-				     void *data);
 void __iomem *cpm_muram_addr(unsigned long offset);
 unsigned long cpm_muram_offset(void __iomem *addr);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
-- 
1.9.1
