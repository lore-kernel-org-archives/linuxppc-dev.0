Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id ABED1B7DB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:27 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 5/9] arm: use generic dmabounce support
Date: Sun, 28 Feb 2010 15:07:58 +0100
Message-Id: <1267366082-15248-6-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update ARM dmabounce to use the generic dmabounce support.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/arm/Kconfig              |    4 +-
 arch/arm/common/Kconfig       |    6 +-
 arch/arm/common/dmabounce.c   |  376 +++++++---------------------------------
 arch/arm/include/asm/device.h |    2 +-
 include/linux/dmabounce.h     |    6 -
 lib/dmabounce.c               |    6 -
 6 files changed, 70 insertions(+), 330 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 184a6bd..25fe1d0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -417,7 +417,7 @@ config ARCH_IXP4XX
 	select GENERIC_GPIO
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select DMABOUNCE if PCI
+	select HAVE_DMABOUNCE if PCI
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
@@ -974,7 +974,7 @@ config PCI_HOST_ITE8152
 	bool
 	depends on PCI && MACH_ARMCORE
 	default y
-	select DMABOUNCE
+	select HAVE_DMABOUNCE
 
 source "drivers/pci/Kconfig"
 
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 4efbb9d..01869a5 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -20,11 +20,7 @@ config ICST307
 
 config SA1111
 	bool
-	select DMABOUNCE if !ARCH_PXA
-
-config DMABOUNCE
-	bool
-	select ZONE_DMA
+	select HAVE_DMABOUNCE if !ARCH_PXA
 
 config TIMER_ACORN
 	bool
diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index cc32c1e..a114ee1 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -31,203 +31,38 @@
 #include <linux/dmapool.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
+#include <linux/dmabounce.h>
 
 #include <asm/cacheflush.h>
 
-#undef STATS
-
-#ifdef STATS
-#define DO_STATS(X) do { X ; } while (0)
-#else
-#define DO_STATS(X) do { } while (0)
-#endif
-
-/* ************************************************** */
-
-struct safe_buffer {
-	struct list_head node;
-
-	/* original request */
-	void		*ptr;
-	size_t		size;
-	int		direction;
-
-	/* safe buffer info */
-	struct dmabounce_pool *pool;
-	void		*safe;
-	dma_addr_t	safe_dma_addr;
-};
-
-struct dmabounce_pool {
-	unsigned long	size;
-	struct dma_pool	*pool;
-#ifdef STATS
-	unsigned long	allocs;
-#endif
-};
-
-struct dmabounce_device_info {
-	struct device *dev;
-	struct list_head safe_buffers;
-#ifdef STATS
-	unsigned long total_allocs;
-	unsigned long map_op_count;
-	unsigned long bounce_count;
-	int attr_res;
-#endif
-	struct dmabounce_pool	small;
-	struct dmabounce_pool	large;
-
-	rwlock_t lock;
-};
-
-#ifdef STATS
-static ssize_t dmabounce_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
-	return sprintf(buf, "%lu %lu %lu %lu %lu %lu\n",
-		device_info->small.allocs,
-		device_info->large.allocs,
-		device_info->total_allocs - device_info->small.allocs -
-			device_info->large.allocs,
-		device_info->total_allocs,
-		device_info->map_op_count,
-		device_info->bounce_count);
-}
-
-static DEVICE_ATTR(dmabounce_stats, 0400, dmabounce_show, NULL);
-#endif
-
-
-/* allocate a 'safe' buffer and keep track of it */
-static inline struct safe_buffer *
-alloc_safe_buffer(struct dmabounce_device_info *device_info, void *ptr,
-		  size_t size, enum dma_data_direction dir)
-{
-	struct safe_buffer *buf;
-	struct dmabounce_pool *pool;
-	struct device *dev = device_info->dev;
-	unsigned long flags;
-
-	dev_dbg(dev, "%s(ptr=%p, size=%d, dir=%d)\n",
-		__func__, ptr, size, dir);
-
-	if (size <= device_info->small.size) {
-		pool = &device_info->small;
-	} else if (size <= device_info->large.size) {
-		pool = &device_info->large;
-	} else {
-		pool = NULL;
-	}
-
-	buf = kmalloc(sizeof(struct safe_buffer), GFP_ATOMIC);
-	if (buf == NULL) {
-		dev_warn(dev, "%s: kmalloc failed\n", __func__);
-		return NULL;
-	}
-
-	buf->ptr = ptr;
-	buf->size = size;
-	buf->direction = dir;
-	buf->pool = pool;
-
-	if (pool) {
-		buf->safe = dma_pool_alloc(pool->pool, GFP_ATOMIC,
-					   &buf->safe_dma_addr);
-	} else {
-		buf->safe = dma_alloc_coherent(dev, size, &buf->safe_dma_addr,
-					       GFP_ATOMIC);
-	}
-
-	if (buf->safe == NULL) {
-		dev_warn(dev,
-			 "%s: could not alloc dma memory (size=%d)\n",
-			 __func__, size);
-		kfree(buf);
-		return NULL;
-	}
-
-#ifdef STATS
-	if (pool)
-		pool->allocs++;
-	device_info->total_allocs++;
-#endif
-
-	write_lock_irqsave(&device_info->lock, flags);
-	list_add(&buf->node, &device_info->safe_buffers);
-	write_unlock_irqrestore(&device_info->lock, flags);
-
-	return buf;
-}
-
-/* determine if a buffer is from our "safe" pool */
-static inline struct safe_buffer *
-find_safe_buffer(struct dmabounce_device_info *device_info, dma_addr_t safe_dma_addr)
-{
-	struct safe_buffer *b, *rb = NULL;
-	unsigned long flags;
-
-	read_lock_irqsave(&device_info->lock, flags);
-
-	list_for_each_entry(b, &device_info->safe_buffers, node)
-		if (b->safe_dma_addr == safe_dma_addr) {
-			rb = b;
-			break;
-		}
-
-	read_unlock_irqrestore(&device_info->lock, flags);
-	return rb;
-}
-
-static inline void
-free_safe_buffer(struct dmabounce_device_info *device_info, struct safe_buffer *buf)
-{
-	unsigned long flags;
-
-	dev_dbg(device_info->dev, "%s(buf=%p)\n", __func__, buf);
-
-	write_lock_irqsave(&device_info->lock, flags);
-
-	list_del(&buf->node);
-
-	write_unlock_irqrestore(&device_info->lock, flags);
-
-	if (buf->pool)
-		dma_pool_free(buf->pool->pool, buf->safe, buf->safe_dma_addr);
-	else
-		dma_free_coherent(device_info->dev, buf->size, buf->safe,
-				    buf->safe_dma_addr);
-
-	kfree(buf);
-}
-
-/* ************************************************** */
-
-static struct safe_buffer *find_safe_buffer_dev(struct device *dev,
-		dma_addr_t dma_addr, const char *where)
+static struct dmabounce_buffer *
+find_safe_buffer_dev(struct device *dev, dma_addr_t dma_addr, size_t size,
+		     enum dma_data_direction dir, const char *where)
 {
 	if (!dev || !dev->archdata.dmabounce)
 		return NULL;
 	if (dma_mapping_error(dev, dma_addr)) {
 		if (dev)
 			dev_err(dev, "Trying to %s invalid mapping\n", where);
-		else
-			pr_err("unknown device: Trying to %s invalid mapping\n", where);
+		else {
+			pr_err("unknown device: "
+			       "Trying to %s invalid mapping\n", where);
+		}
 		return NULL;
 	}
-	return find_safe_buffer(dev->archdata.dmabounce, dma_addr);
+	return dmabounce_find_buffer(dev->archdata.dmabounce, dma_addr,
+				     size, dir);
 }
 
 static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		enum dma_data_direction dir)
 {
-	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
+	struct dmabounce_info *info = dev->archdata.dmabounce;
 	dma_addr_t dma_addr;
 	int needs_bounce = 0;
 
-	if (device_info)
-		DO_STATS ( device_info->map_op_count++ );
+	if (info)
+		DMABOUNCE_DO_STATS(info, map_op_count++);
 
 	dma_addr = virt_to_dma(dev, ptr);
 
@@ -248,11 +83,11 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;
 	}
 
-	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
-		struct safe_buffer *buf;
+	if (info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
+		struct dmabounce_buffer *bb;
 
-		buf = alloc_safe_buffer(device_info, ptr, size, dir);
-		if (buf == 0) {
+		bb = dmabounce_alloc_buffer(info, ptr, size, dir, GFP_ATOMIC);
+		if (!bb) {
 			dev_err(dev, "%s: unable to map unsafe buffer %p!\n",
 			       __func__, ptr);
 			return 0;
@@ -260,18 +95,17 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 
 		dev_dbg(dev,
 			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-			__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-			buf->safe, buf->safe_dma_addr);
+			__func__, bb->buf, virt_to_dma(dev, bb->buf),
+			bb->bounce_buf, bb->bounce_buf_dma);
 
 		if ((dir == DMA_TO_DEVICE) ||
 		    (dir == DMA_BIDIRECTIONAL)) {
 			dev_dbg(dev, "%s: copy unsafe %p to safe %p, size %d\n",
-				__func__, ptr, buf->safe, size);
-			memcpy(buf->safe, ptr, size);
+				__func__, ptr, bb->bounce_buf, size);
+			memcpy(bb->bounce_buf, ptr, size);
 		}
-		ptr = buf->safe;
 
-		dma_addr = buf->safe_dma_addr;
+		dma_addr = bb->bounce_buf_dma;
 	} else {
 		/*
 		 * We don't need to sync the DMA buffer since
@@ -286,26 +120,25 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	struct safe_buffer *buf = find_safe_buffer_dev(dev, dma_addr, "unmap");
-
-	if (buf) {
-		BUG_ON(buf->size != size);
-		BUG_ON(buf->direction != dir);
+	struct dmabounce_buffer *bb;
 
+	bb = find_safe_buffer_dev(dev, dma_addr, size, dir, "unmap");
+	if (bb) {
 		dev_dbg(dev,
-			"%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-			__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-			buf->safe, buf->safe_dma_addr);
+			"%s: unsafe buffer %p (dma=%#x) mapped to"
+			" %p (dma=%#x)\n",
+			__func__, bb->buf, virt_to_dma(dev, bb->buf),
+			bb->bounce_buf, bb->bounce_buf_dma);
 
-		DO_STATS(dev->archdata.dmabounce->bounce_count++);
+		DMABOUNCE_DO_STATS(dev->archdata.dmabounce, bounce_count++);
 
 		if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
-			void *ptr = buf->ptr;
+			void *ptr = bb->buf;
 
 			dev_dbg(dev,
 				"%s: copy back safe %p to unsafe %p size %d\n",
-				__func__, buf->safe, ptr, size);
-			memcpy(ptr, buf->safe, size);
+				__func__, bb->bounce_buf, ptr, size);
+			memcpy(ptr, bb->bounce_buf, size);
 
 			/*
 			 * Since we may have written to a page cache page,
@@ -314,7 +147,7 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 			 */
 			__cpuc_flush_dcache_area(ptr, size);
 		}
-		free_safe_buffer(dev->archdata.dmabounce, buf);
+		dmabounce_free_buffer(dev->archdata.dmabounce, bb);
 	}
 }
 
@@ -391,27 +224,25 @@ EXPORT_SYMBOL(dma_unmap_page);
 int dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 		unsigned long off, size_t sz, enum dma_data_direction dir)
 {
-	struct safe_buffer *buf;
+	struct dmabounce_buffer *bb;
 
 	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
 		__func__, addr, off, sz, dir);
 
-	buf = find_safe_buffer_dev(dev, addr, __func__);
-	if (!buf)
+	bb = find_safe_buffer_dev(dev, addr, 0, dir, __func__);
+	if (!bb)
 		return 1;
 
-	BUG_ON(buf->direction != dir);
-
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-		buf->safe, buf->safe_dma_addr);
+		__func__, bb->buf, virt_to_dma(dev, bb->buf),
+		bb->bounce_buf, bb->bounce_buf_dma);
 
-	DO_STATS(dev->archdata.dmabounce->bounce_count++);
+	DMABOUNCE_DO_STATS(dev->archdata.dmabounce, bounce_count++);
 
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
 		dev_dbg(dev, "%s: copy back safe %p to unsafe %p size %d\n",
-			__func__, buf->safe + off, buf->ptr + off, sz);
-		memcpy(buf->ptr + off, buf->safe + off, sz);
+			__func__, bb->bounce_buf + off, bb->buf + off, sz);
+		memcpy(bb->buf + off, bb->bounce_buf + off, sz);
 	}
 	return 0;
 }
@@ -420,135 +251,60 @@ EXPORT_SYMBOL(dmabounce_sync_for_cpu);
 int dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 		unsigned long off, size_t sz, enum dma_data_direction dir)
 {
-	struct safe_buffer *buf;
+	struct dmabounce_buffer *bb;
 
 	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
 		__func__, addr, off, sz, dir);
 
-	buf = find_safe_buffer_dev(dev, addr, __func__);
-	if (!buf)
+	bb = find_safe_buffer_dev(dev, addr, 0, dir, __func__);
+	if (!bb)
 		return 1;
 
-	BUG_ON(buf->direction != dir);
-
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
-		buf->safe, buf->safe_dma_addr);
+		__func__, bb->buf, virt_to_dma(dev, bb->buf),
+		bb->bounce_buf, bb->bounce_buf_dma);
 
-	DO_STATS(dev->archdata.dmabounce->bounce_count++);
+	DMABOUNCE_DO_STATS(dev->archdata.dmabounce, bounce_count++);
 
 	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL) {
 		dev_dbg(dev, "%s: copy out unsafe %p to safe %p, size %d\n",
-			__func__,buf->ptr + off, buf->safe + off, sz);
-		memcpy(buf->safe + off, buf->ptr + off, sz);
+			__func__, bb->buf + off, bb->bounce_buf + off, sz);
+		memcpy(bb->bounce_buf + off, bb->buf + off, sz);
 	}
 	return 0;
 }
 EXPORT_SYMBOL(dmabounce_sync_for_device);
 
-static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
-		const char *name, unsigned long size)
-{
-	pool->size = size;
-	DO_STATS(pool->allocs = 0);
-	pool->pool = dma_pool_create(name, dev, size,
-				     0 /* byte alignment */,
-				     0 /* no page-crossing issues */);
-
-	return pool->pool ? 0 : -ENOMEM;
-}
-
 int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
 		unsigned long large_buffer_size)
 {
-	struct dmabounce_device_info *device_info;
-	int ret;
-
-	device_info = kmalloc(sizeof(struct dmabounce_device_info), GFP_ATOMIC);
-	if (!device_info) {
-		dev_err(dev,
-			"Could not allocated dmabounce_device_info\n");
-		return -ENOMEM;
-	}
-
-	ret = dmabounce_init_pool(&device_info->small, dev,
-				  "small_dmabounce_pool", small_buffer_size);
-	if (ret) {
-		dev_err(dev,
-			"dmabounce: could not allocate DMA pool for %ld byte objects\n",
-			small_buffer_size);
-		goto err_free;
-	}
-
-	if (large_buffer_size) {
-		ret = dmabounce_init_pool(&device_info->large, dev,
-					  "large_dmabounce_pool",
-					  large_buffer_size);
-		if (ret) {
-			dev_err(dev,
-				"dmabounce: could not allocate DMA pool for %ld byte objects\n",
-				large_buffer_size);
-			goto err_destroy;
-		}
-	}
-
-	device_info->dev = dev;
-	INIT_LIST_HEAD(&device_info->safe_buffers);
-	rwlock_init(&device_info->lock);
-
-#ifdef STATS
-	device_info->total_allocs = 0;
-	device_info->map_op_count = 0;
-	device_info->bounce_count = 0;
-	device_info->attr_res = device_create_file(dev, &dev_attr_dmabounce_stats);
-#endif
-
-	dev->archdata.dmabounce = device_info;
-
-	dev_info(dev, "dmabounce: registered device\n");
-
-	return 0;
-
- err_destroy:
-	dma_pool_destroy(device_info->small.pool);
- err_free:
-	kfree(device_info);
-	return ret;
+	struct dmabounce_info *info;
+	int error = -ENOMEM;
+
+	info = dmabounce_info_alloc(dev, small_buffer_size, large_buffer_size,
+				    0, 0);
+	if (!info)
+		goto out;
+	error = dmabounce_info_register(dev, info);
+	if (error)
+		dmabounce_info_free(info);
+out:
+	return error;
 }
 EXPORT_SYMBOL(dmabounce_register_dev);
 
 void dmabounce_unregister_dev(struct device *dev)
 {
-	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
-
-	dev->archdata.dmabounce = NULL;
+	struct dmabounce_info *info = dev->archdata.dmabounce;
 
-	if (!device_info) {
+	if (!info) {
 		dev_warn(dev,
 			 "Never registered with dmabounce but attempting"
 			 "to unregister!\n");
 		return;
 	}
-
-	if (!list_empty(&device_info->safe_buffers)) {
-		dev_err(dev,
-			"Removing from dmabounce with pending buffers!\n");
-		BUG();
-	}
-
-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
-
-#ifdef STATS
-	if (device_info->attr_res == 0)
-		device_remove_file(dev, &dev_attr_dmabounce_stats);
-#endif
-
-	kfree(device_info);
-
-	dev_info(dev, "dmabounce: device unregistered\n");
+	dmabounce_info_unregister(dev);
+	dmabounce_info_free(info);
 }
 EXPORT_SYMBOL(dmabounce_unregister_dev);
 
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..709d501 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -8,7 +8,7 @@
 
 struct dev_archdata {
 #ifdef CONFIG_DMABOUNCE
-	struct dmabounce_device_info *dmabounce;
+	struct dmabounce_info *dmabounce;
 #endif
 };
 
diff --git a/include/linux/dmabounce.h b/include/linux/dmabounce.h
index d60dc04..dc3ad5b 100644
--- a/include/linux/dmabounce.h
+++ b/include/linux/dmabounce.h
@@ -1,9 +1,6 @@
 #ifndef _LINUX_DMABOUNCE_H
 #define _LINUX_DMABOUNCE_H
 
-/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
-#ifndef CONFIG_ARM
-
 #ifdef CONFIG_DMABOUNCE
 
 #include <linux/dmapool.h>
@@ -71,7 +68,4 @@ extern void dmabounce_info_unregister(struct device *dev);
 
 #endif /* CONFIG_DMABOUNCE */
 
-/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
-#endif /* !CONFIG_ARM */
-
 #endif /* _LINUX_DMABOUNCE_H */
diff --git a/lib/dmabounce.c b/lib/dmabounce.c
index 620d314..7cb4740 100644
--- a/lib/dmabounce.c
+++ b/lib/dmabounce.c
@@ -18,9 +18,6 @@
  * version 2 as published by the Free Software Foundation.
  */
 
-/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
-#ifndef CONFIG_ARM
-
 #define DRV_MODULE_NAME "dmabounce"
 #define DRV_DESCRIPTION "Generic DMA bounce buffer functions"
 #define DRV_AUTHOR      "Christopher Hoover <ch@hpl.hp.com>, " \
@@ -390,6 +387,3 @@ EXPORT_SYMBOL(dmabounce_info_unregister);
 MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_LICENSE("GPL");
-
-/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
-#endif /* !CONFIG_ARM */
-- 
1.6.3.3
