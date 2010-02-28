Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id 15D01B7D74
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:24 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 3/9] dma-coherent: fix bitmap access races
Date: Sun, 28 Feb 2010 15:07:56 +0100
Message-Id: <1267366082-15248-4-git-send-email-albert_herranz@yahoo.es>
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

The coherent per-device memory handling functions use the in-kernel
bitmap library to account for the allocated regions.

The bitmap functions, though, do not protect the bitmap structure from
being modified concurrently. This can lead, for example, to double
allocations if dma_alloc_from_coherent() is called while another
dma_alloc_from_coherent() is already in progress.

Fix those races by protecting concurrent modifications of the allocation
bitmap. spin_lock_irqsave()/spin_unlock_irqrestore() is used as the
allocation/release functions are planned to be used in interrupt context
for streaming DMA mappings/unmappings via bounce buffers.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/base/dma-coherent.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 962a3b5..9d27d63 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -11,6 +11,7 @@ struct dma_coherent_mem {
 	int		size;
 	int		flags;
 	unsigned long	*bitmap;
+	spinlock_t	lock;	/* protect bitmap operations */
 };
 
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
@@ -44,6 +45,7 @@ int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 	dev->dma_mem->device_base = device_addr;
 	dev->dma_mem->size = pages;
 	dev->dma_mem->flags = flags;
+	spin_lock_init(&dev->dma_mem->lock);
 
 	if (flags & DMA_MEMORY_MAP)
 		return DMA_MEMORY_MAP;
@@ -77,6 +79,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 {
 	struct dma_coherent_mem *mem = dev->dma_mem;
 	int pos, err;
+	unsigned long flags;
 
 	size += device_addr & ~PAGE_MASK;
 
@@ -84,7 +87,9 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 		return ERR_PTR(-EINVAL);
 
 	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
+	spin_lock_irqsave(&mem->lock, flags);
 	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
+	spin_unlock_irqrestore(&mem->lock, flags);
 	if (err != 0)
 		return ERR_PTR(err);
 	return mem->virt_base + (pos << PAGE_SHIFT);
@@ -112,6 +117,7 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 	struct dma_coherent_mem *mem;
 	int order = get_order(size);
 	int pageno;
+	unsigned long flags;
 
 	if (!dev)
 		return 0;
@@ -124,7 +130,9 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 	if (unlikely(size > (mem->size << PAGE_SHIFT)))
 		goto err;
 
+	spin_lock_irqsave(&mem->lock, flags);
 	pageno = bitmap_find_free_region(mem->bitmap, mem->size, order);
+	spin_unlock_irqrestore(&mem->lock, flags);
 	if (unlikely(pageno < 0))
 		goto err;
 
@@ -163,12 +171,15 @@ EXPORT_SYMBOL(dma_alloc_from_coherent);
 int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
 {
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+	unsigned long flags;
 
 	if (mem && vaddr >= mem->virt_base && vaddr <
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
 		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
 
+		spin_lock_irqsave(&mem->lock, flags);
 		bitmap_release_region(mem->bitmap, page, order);
+		spin_unlock_irqrestore(&mem->lock, flags);
 		return 1;
 	}
 	return 0;
-- 
1.6.3.3
