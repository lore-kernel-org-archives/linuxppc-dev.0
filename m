Return-Path: <benh@ozlabs.org>
To: David Airlie <airlied@linux.ie>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Feb 2009 16:55:47 +1100
Subject: [PATCH 3/3] drm: Make drm_local_map use a resource_size_t offset
Message-Id: <20090202055559.8D600DDF51@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This changes drm_local_map to use a resource_size for its "offset"
member instead of an unsigned long, thus allowing 32-bit machines
with a >32-bit physical address space to be able to store there
their register or framebuffer addresses when those are above 4G,
such as when using a PCI video card on a recent AMCC 440 SoC.

This patch isn't as "trivial" as it sounds: A few functions needed
to have some unsigned long/int changed to resource_size_t and a few
printk's had to be adjusted.

But also, because userspace isn't capable of passing such offsets,
I had to modify drm_find_matching_map() to ignore the offset passed
in for maps of type _DRM_FRAMEBUFFER or _DRM_REGISTERS.

If we ever support multiple _DRM_FRAMEBUFFER or _DRM_REGISTERS maps
for a given device, we might have to change that trick, but I don't
think that happens on any current driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/gpu/drm/drm_bufs.c         |   33 ++++++++++++++++++++++++---------
 drivers/gpu/drm/drm_proc.c         |    4 ++--
 drivers/gpu/drm/drm_vm.c           |   22 ++++++++++++----------
 drivers/gpu/drm/mga/mga_dma.c      |   17 +++++++++--------
 drivers/gpu/drm/mga/mga_drv.h      |    4 ++--
 drivers/gpu/drm/r128/r128_cce.c    |    7 ++++---
 drivers/gpu/drm/radeon/radeon_cp.c |    9 +++++----
 include/drm/drmP.h                 |   12 ++++++------
 8 files changed, 64 insertions(+), 44 deletions(-)

--- linux-work.orig/drivers/gpu/drm/drm_bufs.c	2009-02-02 16:29:54.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_bufs.c	2009-02-02 16:29:54.000000000 +1100
@@ -54,11 +54,25 @@ static struct drm_map_list *drm_find_mat
 {
 	struct drm_map_list *entry;
 	list_for_each_entry(entry, &dev->maplist, head) {
-		if (entry->map && (entry->master == dev->primary->master) && (map->type == entry->map->type) &&
-		    ((entry->map->offset == map->offset) ||
-		     ((map->type == _DRM_SHM) && (map->flags&_DRM_CONTAINS_LOCK)))) {
+		/* Due to userspace API breakage, we ignore the map offset
+		 * for maps of type _DRM_FRAMEBUFFER or _DRM_REGISTERS
+		 */
+		if (!entry->map ||
+		    map->type != entry->map->type ||
+		    entry->master != dev->primary->master)
+			continue;
+		switch (map->type) {
+		case _DRM_SHM:
+			if (map->flags != _DRM_CONTAINS_LOCK)
+				break;
+		case _DRM_REGISTERS:
+		case _DRM_FRAME_BUFFER:
 			return entry;
+		default: /* Make gcc happy */
+			;
 		}
+		if (entry->map->offset == map->offset)
+			return entry;
 	}
 
 	return NULL;
@@ -96,7 +110,7 @@ static int drm_map_handle(struct drm_dev
  * type.  Adds the map to the map list drm_device::maplist. Adds MTRR's where
  * applicable and if supported by the kernel.
  */
-static int drm_addmap_core(struct drm_device * dev, unsigned int offset,
+static int drm_addmap_core(struct drm_device * dev, resource_size_t offset,
 			   unsigned int size, enum drm_map_type type,
 			   enum drm_map_flags flags,
 			   struct drm_map_list ** maplist)
@@ -124,9 +138,9 @@ static int drm_addmap_core(struct drm_de
 		drm_free(map, sizeof(*map), DRM_MEM_MAPS);
 		return -EINVAL;
 	}
-	DRM_DEBUG("offset = 0x%08lx, size = 0x%08lx, type = %d\n",
-		  map->offset, map->size, map->type);
-	if ((map->offset & (~PAGE_MASK)) || (map->size & (~PAGE_MASK))) {
+	DRM_DEBUG("offset = 0x%08llx, size = 0x%08lx, type = %d\n",
+		  (unsigned long long)map->offset, map->size, map->type);
+	if ((map->offset & (~(resource_size_t)PAGE_MASK)) || (map->size & (~PAGE_MASK))) {
 		drm_free(map, sizeof(*map), DRM_MEM_MAPS);
 		return -EINVAL;
 	}
@@ -254,7 +268,8 @@ static int drm_addmap_core(struct drm_de
 			drm_free(map, sizeof(*map), DRM_MEM_MAPS);
 			return -EPERM;
 		}
-		DRM_DEBUG("AGP offset = 0x%08lx, size = 0x%08lx\n", map->offset, map->size);
+		DRM_DEBUG("AGP offset = 0x%08llx, size = 0x%08lx\n",
+			  (unsigned long long)map->offset, map->size);
 
 		break;
 	case _DRM_GEM:
@@ -322,7 +337,7 @@ static int drm_addmap_core(struct drm_de
 	return 0;
 	}
 
-int drm_addmap(struct drm_device * dev, unsigned int offset,
+int drm_addmap(struct drm_device * dev, resource_size_t offset,
 	       unsigned int size, enum drm_map_type type,
 	       enum drm_map_flags flags, struct drm_local_map ** map_ptr)
 {
Index: linux-work/drivers/gpu/drm/drm_proc.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_proc.c	2009-02-02 16:29:54.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_proc.c	2009-02-02 16:29:54.000000000 +1100
@@ -276,9 +276,9 @@ static int drm__vm_info(char *buf, char 
 			type = "??";
 		else
 			type = types[map->type];
-		DRM_PROC_PRINT("%4d 0x%08lx 0x%08lx %4.4s  0x%02x 0x%08lx ",
+		DRM_PROC_PRINT("%4d 0x%08llx 0x%08lx %4.4s  0x%02x 0x%08lx ",
 			       i,
-			       map->offset,
+			       (unsigned long long)map->offset,
 			       map->size, type, map->flags,
 			       (unsigned long) r_list->user_token);
 		if (map->mtrr < 0) {
Index: linux-work/drivers/gpu/drm/drm_vm.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_vm.c	2009-02-02 16:29:54.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_vm.c	2009-02-02 16:29:54.000000000 +1100
@@ -115,9 +115,9 @@ static int drm_do_vm_fault(struct vm_are
 		 * Using vm_pgoff as a selector forces us to use this unusual
 		 * addressing scheme.
 		 */
-		unsigned long offset = (unsigned long)vmf->virtual_address -
-								vma->vm_start;
-		unsigned long baddr = map->offset + offset;
+		resource_size_t offset = (unsigned long)vmf->virtual_address -
+			vma->vm_start;
+		resource_size_t baddr = map->offset + offset;
 		struct drm_agp_mem *agpmem;
 		struct page *page;
 
@@ -149,8 +149,10 @@ static int drm_do_vm_fault(struct vm_are
 		vmf->page = page;
 
 		DRM_DEBUG
-		    ("baddr = 0x%lx page = 0x%p, offset = 0x%lx, count=%d\n",
-		     baddr, __va(agpmem->memory->memory[offset]), offset,
+		    ("baddr = 0x%llx page = 0x%p, offset = 0x%llx, count=%d\n",
+		     (unsigned long long)baddr,
+		     __va(agpmem->memory->memory[offset]),
+		     (unsigned long long)offset,
 		     page_count(page));
 		return 0;
 	}
@@ -512,14 +514,14 @@ static int drm_mmap_dma(struct file *fil
 	return 0;
 }
 
-unsigned long drm_core_get_map_ofs(struct drm_local_map * map)
+resource_size_t drm_core_get_map_ofs(struct drm_local_map * map)
 {
 	return map->offset;
 }
 
 EXPORT_SYMBOL(drm_core_get_map_ofs);
 
-unsigned long drm_core_get_reg_ofs(struct drm_device *dev)
+resource_size_t drm_core_get_reg_ofs(struct drm_device *dev)
 {
 #ifdef __alpha__
 	return dev->hose->dense_mem_base - dev->hose->mem_space->start;
@@ -548,7 +550,7 @@ int drm_mmap_locked(struct file *filp, s
 	struct drm_file *priv = filp->private_data;
 	struct drm_device *dev = priv->minor->dev;
 	struct drm_local_map *map = NULL;
-	unsigned long offset = 0;
+	resource_size_t offset = 0;
 	struct drm_hash_item *hash;
 
 	DRM_DEBUG("start = 0x%lx, end = 0x%lx, page offset = 0x%lx\n",
@@ -623,9 +625,9 @@ int drm_mmap_locked(struct file *filp, s
 				       vma->vm_page_prot))
 			return -EAGAIN;
 		DRM_DEBUG("   Type = %d; start = 0x%lx, end = 0x%lx,"
-			  " offset = 0x%lx\n",
+			  " offset = 0x%llx\n",
 			  map->type,
-			  vma->vm_start, vma->vm_end, map->offset + offset);
+			  vma->vm_start, vma->vm_end, (unsigned long long)(map->offset + offset));
 		vma->vm_ops = &drm_vm_ops;
 		break;
 	case _DRM_CONSISTENT:
Index: linux-work/drivers/gpu/drm/mga/mga_dma.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/mga/mga_dma.c	2009-02-02 16:29:50.000000000 +1100
+++ linux-work/drivers/gpu/drm/mga/mga_dma.c	2009-02-02 16:29:54.000000000 +1100
@@ -148,8 +148,8 @@ void mga_do_dma_flush(drm_mga_private_t 
 		primary->space = head - tail;
 	}
 
-	DRM_DEBUG("   head = 0x%06lx\n", head - dev_priv->primary->offset);
-	DRM_DEBUG("   tail = 0x%06lx\n", tail - dev_priv->primary->offset);
+	DRM_DEBUG("   head = 0x%06lx\n", (unsigned long)(head - dev_priv->primary->offset));
+	DRM_DEBUG("   tail = 0x%06lx\n", (unsigned long)(tail - dev_priv->primary->offset));
 	DRM_DEBUG("  space = 0x%06x\n", primary->space);
 
 	mga_flush_write_combine();
@@ -187,7 +187,7 @@ void mga_do_dma_wrap_start(drm_mga_priva
 		primary->space = head - dev_priv->primary->offset;
 	}
 
-	DRM_DEBUG("   head = 0x%06lx\n", head - dev_priv->primary->offset);
+	DRM_DEBUG("   head = 0x%06lx\n", (unsigned long)(head - dev_priv->primary->offset));
 	DRM_DEBUG("   tail = 0x%06x\n", primary->tail);
 	DRM_DEBUG("   wrap = %d\n", primary->last_wrap);
 	DRM_DEBUG("  space = 0x%06x\n", primary->space);
@@ -239,7 +239,7 @@ static void mga_freelist_print(struct dr
 	for (entry = dev_priv->head->next; entry; entry = entry->next) {
 		DRM_INFO("   %p   idx=%2d  age=0x%x 0x%06lx\n",
 			 entry, entry->buf->idx, entry->age.head,
-			 entry->age.head - dev_priv->primary->offset);
+			 (unsigned long)(entry->age.head - dev_priv->primary->offset));
 	}
 	DRM_INFO("\n");
 }
@@ -340,10 +340,10 @@ static struct drm_buf *mga_freelist_get(
 
 	DRM_DEBUG("   tail=0x%06lx %d\n",
 		  tail->age.head ?
-		  tail->age.head - dev_priv->primary->offset : 0,
+		  (unsigned long)(tail->age.head - dev_priv->primary->offset) : 0,
 		  tail->age.wrap);
 	DRM_DEBUG("   head=0x%06lx %d\n",
-		  head - dev_priv->primary->offset, wrap);
+		  (unsigned long)(head - dev_priv->primary->offset), wrap);
 
 	if (TEST_AGE(&tail->age, head, wrap)) {
 		prev = dev_priv->tail->prev;
@@ -366,8 +366,9 @@ int mga_freelist_put(struct drm_device *
 	drm_mga_freelist_t *head, *entry, *prev;
 
 	DRM_DEBUG("age=0x%06lx wrap=%d\n",
-		  buf_priv->list_entry->age.head -
-		  dev_priv->primary->offset, buf_priv->list_entry->age.wrap);
+		  (unsigned long)(buf_priv->list_entry->age.head -
+				  dev_priv->primary->offset),
+		  buf_priv->list_entry->age.wrap);
 
 	entry = buf_priv->list_entry;
 	head = dev_priv->head;
Index: linux-work/drivers/gpu/drm/mga/mga_drv.h
===================================================================
--- linux-work.orig/drivers/gpu/drm/mga/mga_drv.h	2009-02-02 16:29:54.000000000 +1100
+++ linux-work/drivers/gpu/drm/mga/mga_drv.h	2009-02-02 16:29:54.000000000 +1100
@@ -317,8 +317,8 @@ do {									\
 		DRM_INFO( "\n" );					\
 		DRM_INFO( "   tail=0x%06x head=0x%06lx\n",		\
 			  dev_priv->prim.tail,				\
-			  MGA_READ( MGA_PRIMADDRESS ) -			\
-			  dev_priv->primary->offset );			\
+			  (unsigned long)(MGA_READ(MGA_PRIMADDRESS) -	\
+					  dev_priv->primary->offset));	\
 	}								\
 	if ( !test_bit( 0, &dev_priv->prim.wrapped ) ) {		\
 		if ( dev_priv->prim.space <				\
Index: linux-work/drivers/gpu/drm/r128/r128_cce.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/r128/r128_cce.c	2009-02-02 16:29:50.000000000 +1100
+++ linux-work/drivers/gpu/drm/r128/r128_cce.c	2009-02-02 16:29:54.000000000 +1100
@@ -525,11 +525,12 @@ static int r128_do_init_cce(struct drm_d
 	} else
 #endif
 	{
-		dev_priv->cce_ring->handle = (void *)dev_priv->cce_ring->offset;
+		dev_priv->cce_ring->handle =
+			(void *)(unsigned long)dev_priv->cce_ring->offset;
 		dev_priv->ring_rptr->handle =
-		    (void *)dev_priv->ring_rptr->offset;
+			(void *)(unsigned long)dev_priv->ring_rptr->offset;
 		dev->agp_buffer_map->handle =
-		    (void *)dev->agp_buffer_map->offset;
+			(void *)(unsigned long)dev->agp_buffer_map->offset;
 	}
 
 #if __OS_HAS_AGP
Index: linux-work/drivers/gpu/drm/radeon/radeon_cp.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/radeon/radeon_cp.c	2009-02-02 16:29:50.000000000 +1100
+++ linux-work/drivers/gpu/drm/radeon/radeon_cp.c	2009-02-02 16:29:54.000000000 +1100
@@ -1052,11 +1052,12 @@ static int radeon_do_init_cp(struct drm_
 	} else
 #endif
 	{
-		dev_priv->cp_ring->handle = (void *)dev_priv->cp_ring->offset;
+		dev_priv->cp_ring->handle =
+			(void *)(unsigned long)dev_priv->cp_ring->offset;
 		dev_priv->ring_rptr->handle =
-		    (void *)dev_priv->ring_rptr->offset;
+			(void *)(unsigned long)dev_priv->ring_rptr->offset;
 		dev->agp_buffer_map->handle =
-		    (void *)dev->agp_buffer_map->offset;
+			(void *)(unsigned long)dev->agp_buffer_map->offset;
 
 		DRM_DEBUG("dev_priv->cp_ring->handle %p\n",
 			  dev_priv->cp_ring->handle);
@@ -1167,7 +1168,7 @@ static int radeon_do_init_cp(struct drm_
 		/* if we have an offset set from userspace */
 		if (dev_priv->pcigart_offset_set) {
 			dev_priv->gart_info.bus_addr =
-			    dev_priv->pcigart_offset + dev_priv->fb_location;
+				(resource_size_t)dev_priv->pcigart_offset + dev_priv->fb_location;
 			dev_priv->gart_info.mapping.offset =
 			    dev_priv->pcigart_offset + dev_priv->fb_aper_offset;
 			dev_priv->gart_info.mapping.size =
Index: linux-work/include/drm/drmP.h
===================================================================
--- linux-work.orig/include/drm/drmP.h	2009-02-02 16:29:54.000000000 +1100
+++ linux-work/include/drm/drmP.h	2009-02-02 16:29:54.000000000 +1100
@@ -526,7 +526,7 @@ struct drm_mm {
  * Kernel side of a mapping
  */
 struct drm_local_map {
-	unsigned long offset;	 /**< Requested physical address (0 for SAREA)*/
+	resource_size_t offset;	 /**< Requested physical address (0 for SAREA)*/
 	unsigned long size;	 /**< Requested physical size (bytes) */
 	enum drm_map_type type;	 /**< Type of memory to map */
 	enum drm_map_flags flags;	 /**< Flags */
@@ -760,8 +760,8 @@ struct drm_driver {
 					struct drm_file *file_priv);
 	void (*reclaim_buffers_idlelocked) (struct drm_device *dev,
 					    struct drm_file *file_priv);
-	unsigned long (*get_map_ofs) (struct drm_local_map * map);
-	unsigned long (*get_reg_ofs) (struct drm_device *dev);
+	resource_size_t (*get_map_ofs) (struct drm_local_map * map);
+	resource_size_t (*get_reg_ofs) (struct drm_device *dev);
 	void (*set_version) (struct drm_device *dev,
 			     struct drm_set_version *sv);
 
@@ -1062,8 +1062,8 @@ extern int drm_release(struct inode *ino
 extern int drm_mmap(struct file *filp, struct vm_area_struct *vma);
 extern int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma);
 extern void drm_vm_open_locked(struct vm_area_struct *vma);
-extern unsigned long drm_core_get_map_ofs(struct drm_local_map * map);
-extern unsigned long drm_core_get_reg_ofs(struct drm_device *dev);
+extern resource_size_t drm_core_get_map_ofs(struct drm_local_map * map);
+extern resource_size_t drm_core_get_reg_ofs(struct drm_device *dev);
 extern unsigned int drm_poll(struct file *filp, struct poll_table_struct *wait);
 
 				/* Memory management support (drm_memory.h) */
@@ -1166,7 +1166,7 @@ extern int drm_i_have_hw_lock(struct drm
 				/* Buffer management support (drm_bufs.h) */
 extern int drm_addbufs_agp(struct drm_device *dev, struct drm_buf_desc * request);
 extern int drm_addbufs_pci(struct drm_device *dev, struct drm_buf_desc * request);
-extern int drm_addmap(struct drm_device *dev, unsigned int offset,
+extern int drm_addmap(struct drm_device *dev, resource_size_t offset,
 		      unsigned int size, enum drm_map_type type,
 		      enum drm_map_flags flags, struct drm_local_map **map_ptr);
 extern int drm_addmap_ioctl(struct drm_device *dev, void *data,
