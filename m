Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32F9B1A2C88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 17:21:37 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
Date: Fri, 18 Sep 2015 15:15:19 +0800
Message-ID: <1442560521-19354-3-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
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

Use genalloc to manage CPM/QE muram instead of rheap.

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v9:
	- splitted from patch 3/5, modify cpm muram management functions.
Changes for v10:
	- modify cpm muram first, then move to qe_common
	- modify commit.

 arch/powerpc/platforms/Kconfig   |   1 +
 arch/powerpc/sysdev/cpm_common.c | 150 +++++++++++++++++++++++++++------------
 2 files changed, 107 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b7f9c40..01f98a2 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -276,6 +276,7 @@ config QUICC_ENGINE
 	bool "Freescale QUICC Engine (QE) Support"
 	depends on FSL_SOC && PPC32
 	select PPC_LIB_RHEAP
+	select GENERIC_ALLOCATOR
 	select CRC32
 	help
 	  The QUICC Engine (QE) is a new generation of communications
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 4f78695..453d18c 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -17,6 +17,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/genalloc.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
@@ -27,7 +28,6 @@
 
 #include <asm/udbg.h>
 #include <asm/io.h>
-#include <asm/rheap.h>
 #include <asm/cpm.h>
 
 #include <mm/mmu_decl.h>
@@ -65,14 +65,24 @@ void __init udbg_init_cpm(void)
 }
 #endif
 
+static struct gen_pool *muram_pool;
+static struct genpool_data_align muram_pool_data;
+static struct genpool_data_fixed muram_pool_data_fixed;
 static spinlock_t cpm_muram_lock;
-static rh_block_t cpm_boot_muram_rh_block[16];
-static rh_info_t cpm_muram_info;
 static u8 __iomem *muram_vbase;
 static phys_addr_t muram_pbase;
 
-/* Max address size we deal with */
+struct muram_block {
+	struct list_head head;
+	unsigned long start;
+	int size;
+};
+
+static LIST_HEAD(muram_block_list);
+
+/* max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
+#define GENPOOL_OFFSET		4096
 
 int cpm_muram_init(void)
 {
@@ -86,113 +96,165 @@ int cpm_muram_init(void)
 	if (muram_pbase)
 		return 0;
 
-	spin_lock_init(&cpm_muram_lock);
-	/* initialize the info header */
-	rh_init(&cpm_muram_info, 1,
-	        sizeof(cpm_boot_muram_rh_block) /
-	        sizeof(cpm_boot_muram_rh_block[0]),
-	        cpm_boot_muram_rh_block);
-
 	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
 	if (!np) {
 		/* try legacy bindings */
 		np = of_find_node_by_name(NULL, "data-only");
 		if (!np) {
-			printk(KERN_ERR "Cannot find CPM muram data node");
+			pr_err("Cannot find CPM muram data node");
 			ret = -ENODEV;
 			goto out;
 		}
 	}
 
+	muram_pool = gen_pool_create(1, -1);
 	muram_pbase = of_translate_address(np, zero);
 	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
-		printk(KERN_ERR "Cannot translate zero through CPM muram node");
+		pr_err("Cannot translate zero through CPM muram node");
 		ret = -ENODEV;
-		goto out;
+		goto err;
 	}
 
 	while (of_address_to_resource(np, i++, &r) == 0) {
 		if (r.end > max)
 			max = r.end;
+		ret = gen_pool_add(muram_pool, r.start - muram_pbase +
+				   GENPOOL_OFFSET, resource_size(&r), -1);
+		if (ret) {
+				pr_err("QE: couldn't add muram to pool!\n");
+				goto err;
+			}
 
-		rh_attach_region(&cpm_muram_info, r.start - muram_pbase,
-				 resource_size(&r));
 	}
 
 	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
 	if (!muram_vbase) {
-		printk(KERN_ERR "Cannot map CPM muram");
+		pr_err("Cannot map QE muram");
 		ret = -ENOMEM;
+		goto err;
 	}
-
+	goto out;
+err:
+	gen_pool_destroy(muram_pool);
 out:
 	of_node_put(np);
 	return ret;
 }
 
-/**
+/*
  * cpm_muram_alloc - allocate the requested size worth of multi-user ram
  * @size: number of bytes to allocate
  * @align: requested alignment, in bytes
  *
  * This function returns an offset into the muram area.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- * Use cpm_muram_free() to free the allocation.
  */
 unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
 {
 	unsigned long start;
 	unsigned long flags;
+	struct muram_block *entry;
 
 	spin_lock_irqsave(&cpm_muram_lock, flags);
-	cpm_muram_info.alignment = align;
-	start = rh_alloc(&cpm_muram_info, size, "commproc");
+	muram_pool_data.align = align;
+	gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
+			  &muram_pool_data);
+	start = gen_pool_alloc(muram_pool, size);
+	if (!start)
+		goto out2;
+	start = start - GENPOOL_OFFSET;
 	memset(cpm_muram_addr(start), 0, size);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out1;
+	entry->start = start;
+	entry->size = size;
+	list_add(&entry->head, &muram_block_list);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
 
 	return start;
+out1:
+	gen_pool_free(muram_pool, start, size);
+out2:
+	spin_unlock_irqrestore(&cpm_muram_lock, flags);
+	return (unsigned long) -ENOMEM;
 }
 EXPORT_SYMBOL(cpm_muram_alloc);
 
-/**
- * cpm_muram_free - free a chunk of multi-user ram
- * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
+/*
+ * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
+ * @size: number of bytes to allocate
+ * @offset: offset of allocation start address
+ *
+ * This function returns an offset into the muram area.
  */
-int cpm_muram_free(unsigned long offset)
+unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
 {
-	int ret;
+
+	unsigned long start;
 	unsigned long flags;
+	unsigned long size_alloc = size;
+	struct muram_block *entry;
+	int end_bit;
+	int order = muram_pool->min_alloc_order;
 
 	spin_lock_irqsave(&cpm_muram_lock, flags);
-	ret = rh_free(&cpm_muram_info, offset);
+	end_bit = (offset >> order) + ((size + (1UL << order) - 1) >> order);
+	if ((offset + size) > (end_bit << order))
+		size_alloc = size + (1UL << order);
+
+	muram_pool_data_fixed.offset = offset + GENPOOL_OFFSET;
+	gen_pool_set_algo(muram_pool, gen_pool_fixed_alloc,
+			  &muram_pool_data_fixed);
+	start = gen_pool_alloc(muram_pool, size_alloc);
+	if (!start)
+		goto out2;
+	start = start - GENPOOL_OFFSET;
+	memset(cpm_muram_addr(start), 0, size_alloc);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out1;
+	entry->start = start;
+	entry->size = size_alloc;
+	list_add(&entry->head, &muram_block_list);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
 
-	return ret;
+	return start;
+out1:
+	gen_pool_free(muram_pool, start, size_alloc);
+out2:
+	spin_unlock_irqrestore(&cpm_muram_lock, flags);
+	return (unsigned long) -ENOMEM;
+
+
 }
-EXPORT_SYMBOL(cpm_muram_free);
+EXPORT_SYMBOL(cpm_muram_alloc_fixed);
 
 /**
- * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
- * @offset: the offset into the muram area to reserve
- * @size: the number of bytes to reserve
- *
- * This function returns "start" on success, -ENOMEM on failure.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- * Use cpm_muram_free() to free the allocation.
+ * cpm_muram_free - free a chunk of multi-user ram
+ * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
  */
-unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
+int cpm_muram_free(unsigned long offset)
 {
-	unsigned long start;
 	unsigned long flags;
+	int size;
+	struct muram_block *tmp;
 
+	size = 0;
 	spin_lock_irqsave(&cpm_muram_lock, flags);
-	cpm_muram_info.alignment = 1;
-	start = rh_alloc_fixed(&cpm_muram_info, offset, size, "commproc");
+	list_for_each_entry(tmp, &muram_block_list, head) {
+		if (tmp->start == offset) {
+			size = tmp->size;
+			list_del(&tmp->head);
+			kfree(tmp);
+			break;
+		}
+	}
+	gen_pool_free(muram_pool, offset + GENPOOL_OFFSET, size);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
 
-	return start;
+	return size;
 }
-EXPORT_SYMBOL(cpm_muram_alloc_fixed);
+EXPORT_SYMBOL(cpm_muram_free);
 
 /**
  * cpm_muram_addr - turn a muram offset into a virtual address
-- 
2.1.0.27.g96db324
