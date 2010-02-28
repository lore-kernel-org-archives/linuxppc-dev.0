Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id 762AEB7D22
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:26 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 4/9] add generic dmabounce support
Date: Sun, 28 Feb 2010 15:07:57 +0100
Message-Id: <1267366082-15248-5-git-send-email-albert_herranz@yahoo.es>
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

This patch makes part of the ARM dmabounce code available to other
architectures as a generic API.
See included kernel-doc annotations for the actual API implemented.

An architecture can opt-in for generic dmabounce support by defining
HAVE_DMABOUNCE.

This support will be used later to address DMA memory access restrictions
on the Nintendo Wii video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/Kconfig              |    3 +
 include/linux/dmabounce.h |   77 +++++++++
 lib/Kconfig               |   10 ++
 lib/Makefile              |    2 +
 lib/dmabounce.c           |  395 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 487 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/dmabounce.h
 create mode 100644 lib/dmabounce.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 9d055b4..98ff26d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -130,6 +130,9 @@ config HAVE_CLK
 config HAVE_DMA_API_DEBUG
 	bool
 
+config HAVE_DMABOUNCE
+	bool
+
 config HAVE_DEFAULT_NO_SPIN_MUTEXES
 	bool
 
diff --git a/include/linux/dmabounce.h b/include/linux/dmabounce.h
new file mode 100644
index 0000000..d60dc04
--- /dev/null
+++ b/include/linux/dmabounce.h
@@ -0,0 +1,77 @@
+#ifndef _LINUX_DMABOUNCE_H
+#define _LINUX_DMABOUNCE_H
+
+/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
+#ifndef CONFIG_ARM
+
+#ifdef CONFIG_DMABOUNCE
+
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/device.h>
+
+struct dmabounce_info;
+
+#ifdef CONFIG_DMABOUNCE_STATS
+struct dmabounce_stats {
+	unsigned long total_allocs;
+	unsigned long map_op_count;
+	unsigned long bounce_count;
+};
+extern struct dmabounce_stats *dmabounce_get_stats(struct dmabounce_info *);
+#define DMABOUNCE_DO_STATS(i, X) do { dmabounce_get_stats(i)->X ; } while (0)
+#else
+#define DMABOUNCE_DO_STATS(i, X) do { } while (0)
+#endif /* CONFIG_DMABOUNCE_STATS */
+
+struct dmabounce_pool {
+	unsigned long	size;
+	struct dma_pool	*pool;
+#ifdef CONFIG_DMABOUNCE_STATS
+	unsigned long allocs;
+#endif
+};
+
+struct dmabounce_buffer {
+	struct list_head node;
+
+	/* original buffer */
+	void		*buf;
+	size_t		size;
+	enum dma_data_direction dir;
+
+	/* bounced buffer */
+	void		*bounce_buf;
+	dma_addr_t	bounce_buf_dma;
+
+	struct dmabounce_pool	*pool;
+};
+
+extern struct dmabounce_buffer *
+dmabounce_alloc_buffer(struct dmabounce_info *info,
+		       void *buf, size_t size, enum dma_data_direction dir,
+		       gfp_t gfp);
+extern void dmabounce_free_buffer(struct dmabounce_info *info,
+				  struct dmabounce_buffer *bb);
+extern struct dmabounce_buffer *
+dmabounce_find_buffer(struct dmabounce_info *info, dma_addr_t bounce_buf_dma,
+		      size_t size, enum dma_data_direction dir);
+
+extern struct dmabounce_info *
+dmabounce_info_alloc(struct device *dev,
+		     size_t small_buffer_size, size_t large_buffer_size,
+		     size_t align, size_t boundary);
+extern void dmabounce_info_free(struct dmabounce_info *info);
+
+extern int dmabounce_info_register(struct device *dev,
+				   struct dmabounce_info *info);
+extern void dmabounce_info_unregister(struct device *dev);
+
+#endif /* CONFIG_DMABOUNCE */
+
+/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
+#endif /* !CONFIG_ARM */
+
+#endif /* _LINUX_DMABOUNCE_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 97b136f..b53b7dc 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -207,4 +207,14 @@ config GENERIC_ATOMIC64
 config LRU_CACHE
 	tristate
 
+config DMABOUNCE
+	bool
+	depends on HAVE_DMABOUNCE
+	select ZONE_DMA if ARM
+	default y
+
+config DMABOUNCE_STATS
+	bool "Track dmabounce statistics"
+	depends on DMABOUNCE
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index 3b0b4a6..097c2ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -100,6 +100,8 @@ obj-$(CONFIG_GENERIC_CSUM) += checksum.o
 
 obj-$(CONFIG_GENERIC_ATOMIC64) += atomic64.o
 
+obj-$(CONFIG_DMABOUNCE) += dmabounce.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff --git a/lib/dmabounce.c b/lib/dmabounce.c
new file mode 100644
index 0000000..620d314
--- /dev/null
+++ b/lib/dmabounce.c
@@ -0,0 +1,395 @@
+/*
+ * lib/dmabounce.c
+ *
+ * Generic DMA bounce buffer functions.
+ * Copyright (C) 2010 Albert Herranz <albert_herranz@yahoo.es>
+ *
+ * Based on arch/arm/common/dmabounce.c
+ *
+ * Original version by Brad Parker (brad@heeltoe.com)
+ * Re-written by Christopher Hoover <ch@murgatroid.com>
+ * Made generic by Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright (C) 2002 Hewlett Packard Company.
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
+#ifndef CONFIG_ARM
+
+#define DRV_MODULE_NAME "dmabounce"
+#define DRV_DESCRIPTION "Generic DMA bounce buffer functions"
+#define DRV_AUTHOR      "Christopher Hoover <ch@hpl.hp.com>, " \
+			"Deepak Saxena <dsaxena@plexity.net>, " \
+			"Albert Herranz <albert_herranz@yahoo.es>"
+
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/dmabounce.h>
+
+
+struct dmabounce_info {
+	struct device *dev;
+	struct list_head bounce_buffers;
+
+#ifdef CONFIG_DMABOUNCE_STATS
+	struct dmabounce_stats stats;
+	int attr_res;
+#endif
+	struct dmabounce_pool	small;
+	struct dmabounce_pool	large;
+
+	rwlock_t lock;
+};
+
+#ifdef CONFIG_DMABOUNCE_STATS
+struct dmabounce_stats *dmabounce_get_stats(struct dmabounce_info *info)
+{
+	return &info->stats;
+}
+
+static ssize_t dmabounce_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+	return sprintf(buf, "%lu %lu %lu %lu %lu %lu\n",
+		       info->small.allocs,
+		       info->large.allocs,
+		       info->stats.total_allocs -
+				info->small.allocs - info->large.allocs,
+		       info->stats.total_allocs,
+		       info->stats.map_op_count,
+		       info->stats.bounce_count);
+}
+
+static DEVICE_ATTR(dmabounce_stats, 0400, dmabounce_show, NULL);
+#endif /* CONFIG_DMABOUNCE_STATS */
+
+/**
+ * dmabounce_alloc_buffer() - try to allocate a coherent DMA bounce buffer
+ * @info:	This dmabounce_info.
+ * @buf:	Original buffer virtual address.
+ * @size:	Original buffer length.
+ * @dir:	Direction of DMA transfer for this buffer.
+ * @gfp:	Flags used for memory allocations.
+ *
+ * Use this function to allocate a coherent buffer of size @size associated
+ * to a dmabounce_info structure @info.
+ * The allocation will be performed using the @gfp allocation flags.
+ *
+ * The coherent buffer can be used later to bounce data from/to the
+ * corresponding normal buffer @buf with the specified direction @dir.
+ *
+ * If the buffer cannot be allocated the function returns NULL.
+ * Otherwise, the allocated buffer is returned.
+ */
+struct dmabounce_buffer *
+dmabounce_alloc_buffer(struct dmabounce_info *info,
+		       void *buf, size_t size, enum dma_data_direction dir,
+		       gfp_t gfp)
+{
+	struct device *dev = info->dev;
+	struct dmabounce_pool *pool = NULL;
+	struct dmabounce_buffer *bb;
+	unsigned long flags;
+
+	dev_dbg(dev, "%s(buf=%p, size=%d, dir=%d)\n", __func__, buf, size, dir);
+
+	if (size <= info->small.size)
+		pool = &info->small;
+	else if (size <= info->large.size)
+		pool = &info->large;
+
+	bb = kzalloc(sizeof(*bb), gfp);
+	if (!bb) {
+		dev_err(dev, "%s: kmalloc failed\n", __func__);
+		goto out;
+	}
+
+	if (pool) {
+		bb->bounce_buf = dma_pool_alloc(pool->pool, gfp,
+						&bb->bounce_buf_dma);
+	} else {
+		bb->bounce_buf = dma_alloc_coherent(dev, size,
+						    &bb->bounce_buf_dma, gfp);
+	}
+
+	if (!bb->bounce_buf) {
+		dev_err(dev, "%s: error allocating DMA memory (size=%d)\n",
+			__func__, size);
+		kfree(bb);
+		bb = NULL;
+		goto out;
+	}
+
+#ifdef CONFIG_DMABOUNCE_STATS
+	if (pool)
+		pool->allocs++;
+#endif
+	DMABOUNCE_DO_STATS(info, total_allocs++);
+
+	bb->buf = buf;
+	bb->size = size;
+	bb->dir = dir;
+	bb->pool = pool;
+
+	write_lock_irqsave(&info->lock, flags);
+	list_add(&bb->node, &info->bounce_buffers);
+	write_unlock_irqrestore(&info->lock, flags);
+out:
+	return bb;
+}
+EXPORT_SYMBOL(dmabounce_alloc_buffer);
+
+/**
+ * dmabounce_free_buffer() - free a coherent DMA bounce buffer
+ * @info:	This dmabounce_info.
+ * @bb:		The coherent DMA bounce buffer to free.
+ *
+ * Free a previously allocated coherent DMA bounce buffer @bb from its
+ * associated dmabounce_info structure @info.
+ *
+ * The coherent DMA bounce buffer @bb must have been previously allocated
+ * using dmabounce_alloc_buffer().
+ */
+void
+dmabounce_free_buffer(struct dmabounce_info *info, struct dmabounce_buffer *bb)
+{
+	unsigned long flags;
+
+	dev_dbg(info->dev, "%s(buf=%p)\n", __func__, bb->buf);
+
+	write_lock_irqsave(&info->lock, flags);
+	list_del(&bb->node);
+	write_unlock_irqrestore(&info->lock, flags);
+
+	if (bb->pool)
+		dma_pool_free(bb->pool->pool, bb->bounce_buf,
+			      bb->bounce_buf_dma);
+	else {
+		dma_free_coherent(info->dev, bb->size, bb->bounce_buf,
+				  bb->bounce_buf_dma);
+	}
+
+	kfree(bb);
+}
+EXPORT_SYMBOL(dmabounce_free_buffer);
+
+/**
+ * dmabounce_find_buffer() - locate an existing coherent DMA bounce buffer
+ * @info:		This dmabounce_info.
+ * @bounce_buf_dma:	DMA handle for the bounce buffer to find.
+ * @size:		Size of the bounce buffer to find.
+ * @dir:		Direction of DMA transfer for the buffer to find.
+ *
+ * Finds a previously allocated coherent DMA bounce buffer associated
+ * to a dmabounce_info structure @info.
+ *
+ * The coherent DMA bounce buffer searched must have the given
+ * @bounce_buf_dma DMA handle, @size size and DMA direction @dir.
+ * If @size is zero, the searched buffer can have any size.
+ *
+ * If no matching coherent DMA bounce buffer is found the function returns
+ * NULL. Otherwise, the matching buffer is returned.
+ */
+struct dmabounce_buffer *
+dmabounce_find_buffer(struct dmabounce_info *info, dma_addr_t bounce_buf_dma,
+		      size_t size, enum dma_data_direction dir)
+{
+	struct dmabounce_buffer *bb, *needle = NULL;
+	unsigned long flags;
+
+	read_lock_irqsave(&info->lock, flags);
+
+	list_for_each_entry(bb, &info->bounce_buffers, node) {
+		if (bb->bounce_buf_dma == bounce_buf_dma) {
+			/* we should get a perfect match here */
+			BUG_ON((size && bb->size != size) || bb->dir != dir);
+
+			needle = bb;
+			break;
+		}
+	}
+
+	read_unlock_irqrestore(&info->lock, flags);
+	return needle;
+}
+EXPORT_SYMBOL(dmabounce_find_buffer);
+
+static int dmabounce_init_pool(struct dmabounce_pool *pool,
+			       struct device *dev, const char *name,
+			       size_t size, size_t align, size_t boundary)
+{
+	pool->size = size;
+#ifdef CONFIG_DMABOUNCE_STATS
+	pool->allocs = 0;
+#endif
+	pool->pool = dma_pool_create(name, dev, size, align, boundary);
+
+	return pool->pool ? 0 : -ENOMEM;
+}
+
+/**
+ * dmabounce_info_alloc() - allocate a dmabounce_info structure
+ * @dev:		Device for which coherent memory allocations are done.
+ * @small_buffer_size:	Buffer size for allocations from the small pool.
+ * @large_buffer_size:	Buffer size for allocations from the large pool.
+ * @align:		Alignment for pool based allocations.
+ * @boundary:		Boundary for pool based allocations.
+ *
+ * Use this function to allocate a dmabounce_info structure.
+ * A dmabounce_info structure can be used to manage a set of related
+ * coherent DMA bounce buffers.
+ *
+ * Memory for the coherent DMA bounce buffers will be allocated for the
+ * specified device @dev.
+ * If @small_buffer_size or @large_buffer_size are non-zero, allocations
+ * will be tried from the closest associated DMA pool which has a size
+ * greater or equal than the specified @size size. Allocations from DMA
+ * pools will honor the alignment and boundary crossing restrictions
+ * specified in @align and @boundary.
+ * Otherwise, allocations will be performed from non-pool coherent memory.
+ *
+ * If the dmabounce_info structure cannot be allocated the function
+ * returns NULL. Otherwise, the allocated dmabounce_info structure is returned.
+ */
+struct dmabounce_info *
+dmabounce_info_alloc(struct device *dev,
+		     size_t small_buffer_size, size_t large_buffer_size,
+		     size_t align, size_t boundary)
+{
+	struct dmabounce_info *info;
+	int error;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		dev_err(dev, "%s: allocation error\n", __func__);
+		goto out;
+	}
+
+	if (small_buffer_size) {
+		error = dmabounce_init_pool(&info->small, dev,
+					    "small_dmabounce_pool",
+					    small_buffer_size, align, boundary);
+		if (error) {
+			dev_err(dev, "error %d allocating DMA pool for %zu"
+				" byte objects\n", error, small_buffer_size);
+			goto err_alloc_small;
+		}
+	}
+
+	if (large_buffer_size) {
+		error = dmabounce_init_pool(&info->large, dev,
+					    "large_dmabounce_pool",
+					    large_buffer_size, align, boundary);
+		if (error) {
+			dev_err(dev, "error %d allocating DMA pool for %zu"
+				" byte objects\n", error, large_buffer_size);
+			goto err_alloc_large;
+		}
+	}
+
+	info->dev = dev;
+	INIT_LIST_HEAD(&info->bounce_buffers);
+	rwlock_init(&info->lock);
+
+	DMABOUNCE_DO_STATS(info, total_allocs = 0);
+	DMABOUNCE_DO_STATS(info, map_op_count = 0);
+	DMABOUNCE_DO_STATS(info, bounce_count = 0);
+	goto out;
+
+err_alloc_large:
+	dma_pool_destroy(info->small.pool);
+err_alloc_small:
+	kfree(info);
+	info = NULL;
+out:
+	return info;
+}
+EXPORT_SYMBOL(dmabounce_info_alloc);
+
+/**
+ * dmabounce_info_free() - free a dmabounce_info
+ * @info:	This dmabounce_info.
+ *
+ * Free a previously allocated dmabounce_info structure @info.
+ *
+ * The dmabounce_info structure @info must have been previously allocated
+ * using dmabounce_info_alloc().
+ */
+void dmabounce_info_free(struct dmabounce_info *info)
+{
+	if (!list_empty(&info->bounce_buffers)) {
+		dev_err(info->dev, "freeing dmabounce with pending buffers!\n");
+		BUG();
+	}
+
+	if (info->small.pool)
+		dma_pool_destroy(info->small.pool);
+	if (info->large.pool)
+		dma_pool_destroy(info->large.pool);
+
+	kfree(info);
+}
+EXPORT_SYMBOL(dmabounce_info_free);
+
+/**
+ * dmabounce_info_register() - register a dmabounce_info for a device
+ * @dev:	Device for which the dmabounce_info is registered.
+ * @info:	dmabounce_info to register.
+ *
+ * Use this function to register a given dmabounce_info @info into a
+ * device @dev.
+ *
+ * A device can only have one dmabounce_info registered with.
+ * The same dmabounce_info may be registered for many devices.
+ */
+int dmabounce_info_register(struct device *dev, struct dmabounce_info *info)
+{
+	if (dev->archdata.dmabounce)
+		return -EBUSY;
+
+	dev->archdata.dmabounce = info;
+
+#ifdef CONFIG_DMABOUNCE_STATS
+	info->attr_res = device_create_file(dev, &dev_attr_dmabounce_stats);
+#endif
+
+	dev_info(dev, pr_fmt("device registered\n"));
+	return 0;
+}
+EXPORT_SYMBOL(dmabounce_info_register);
+
+/**
+ * dmabounce_info_unregister() - unregister the dmabounce_info from a device
+ * @dev:	Device for which the dmabounce_info is unregistered.
+ *
+ * Use this function to unregister a previously registered dmabounce_info
+ * from a device @dev.
+ */
+void dmabounce_info_unregister(struct device *dev)
+{
+#ifdef CONFIG_DMABOUNCE_STATS
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+
+	if (info && info->attr_res == 0)
+		device_remove_file(dev, &dev_attr_dmabounce_stats);
+#endif
+	dev->archdata.dmabounce = NULL;
+
+	dev_info(dev, pr_fmt("device unregistered\n"));
+}
+EXPORT_SYMBOL(dmabounce_info_unregister);
+
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_LICENSE("GPL");
+
+/* FIXME remove later when arch/arm/common/dmabounce.c is updated */
+#endif /* !CONFIG_ARM */
-- 
1.6.3.3
