Return-Path: <benh@ozlabs.org>
To: David Airlie <airlied@linux.ie>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Feb 2009 16:55:46 +1100
Subject: [PATCH 2/3] drm: Split drm_map and drm_local_map
Message-Id: <20090202055558.4F200DDF4B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Once upon a time, the DRM made the distinction between the drm_map
data structure exchanged with user space and the drm_local_map used
in the kernel.

For some reasons, while the BSD port still has that "feature", the
linux part abused drm_map for kernel internal usage as the local
map only existed as a typedef of the struct drm_map.

This patch fixes it by declaring struct drm_local_map separately
(though its content is currently identical to the userspace variant),
and changing the kernel code to only use that, except when it's a
user<->kernel interface (ie. ioctl).

This allows subsequent changes to the in-kernel format

I've also replaced the use of drm_local_map_t with struct drm_local_map
in a couple of places. Mostly by accident but they are the same (the
former is a typedef of the later) and I have some remote plans and
half finished patch to completely kill the drm_local_map_t typedef
so I left those bits in.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/gpu/drm/drm_bufs.c      |   46 ++++++++++++++++++++++-----------------
 drivers/gpu/drm/drm_context.c   |    4 +--
 drivers/gpu/drm/drm_drv.c       |    2 -
 drivers/gpu/drm/drm_gem.c       |    2 -
 drivers/gpu/drm/drm_memory.c    |    6 ++---
 drivers/gpu/drm/drm_proc.c      |    2 -
 drivers/gpu/drm/drm_vm.c        |   12 +++++-----
 drivers/gpu/drm/i810/i810_drv.h |    4 +--
 drivers/gpu/drm/i830/i830_drv.h |    4 +--
 drivers/gpu/drm/i915/i915_gem.c |    4 +--
 include/drm/drmP.h              |   47 +++++++++++++++++++++++++---------------
 11 files changed, 76 insertions(+), 57 deletions(-)

--- linux-work.orig/drivers/gpu/drm/drm_bufs.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_bufs.c	2009-02-02 16:00:35.000000000 +1100
@@ -50,7 +50,7 @@ resource_size_t drm_get_resource_len(str
 EXPORT_SYMBOL(drm_get_resource_len);
 
 static struct drm_map_list *drm_find_matching_map(struct drm_device *dev,
-					     drm_local_map_t *map)
+						  struct drm_local_map *map)
 {
 	struct drm_map_list *entry;
 	list_for_each_entry(entry, &dev->maplist, head) {
@@ -89,13 +89,8 @@ static int drm_map_handle(struct drm_dev
 }
 
 /**
- * Ioctl to specify a range of memory that is available for mapping by a non-root process.
- *
- * \param inode device inode.
- * \param file_priv DRM file private.
- * \param cmd command.
- * \param arg pointer to a drm_map structure.
- * \return zero on success or a negative value on error.
+ * Core function to create a range of memory available for mapping by a
+ * non-root process.
  *
  * Adjusts the memory offset to its absolute value according to the mapping
  * type.  Adds the map to the map list drm_device::maplist. Adds MTRR's where
@@ -106,7 +101,7 @@ static int drm_addmap_core(struct drm_de
 			   enum drm_map_flags flags,
 			   struct drm_map_list ** maplist)
 {
-	struct drm_map *map;
+	struct drm_local_map *map;
 	struct drm_map_list *list;
 	drm_dma_handle_t *dmah;
 	unsigned long user_token;
@@ -329,7 +324,7 @@ static int drm_addmap_core(struct drm_de
 
 int drm_addmap(struct drm_device * dev, unsigned int offset,
 	       unsigned int size, enum drm_map_type type,
-	       enum drm_map_flags flags, drm_local_map_t ** map_ptr)
+	       enum drm_map_flags flags, struct drm_local_map ** map_ptr)
 {
 	struct drm_map_list *list;
 	int rc;
@@ -342,6 +337,17 @@ int drm_addmap(struct drm_device * dev, 
 
 EXPORT_SYMBOL(drm_addmap);
 
+/**
+ * Ioctl to specify a range of memory that is available for mapping by a
+ * non-root process.
+ *
+ * \param inode device inode.
+ * \param file_priv DRM file private.
+ * \param cmd command.
+ * \param arg pointer to a drm_map structure.
+ * \return zero on success or a negative value on error.
+ *
+ */
 int drm_addmap_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *file_priv)
 {
@@ -367,19 +373,13 @@ int drm_addmap_ioctl(struct drm_device *
  * Remove a map private from list and deallocate resources if the mapping
  * isn't in use.
  *
- * \param inode device inode.
- * \param file_priv DRM file private.
- * \param cmd command.
- * \param arg pointer to a struct drm_map structure.
- * \return zero on success or a negative value on error.
- *
  * Searches the map on drm_device::maplist, removes it from the list, see if
  * its being used, and free any associate resource (such as MTRR's) if it's not
  * being on use.
  *
  * \sa drm_addmap
  */
-int drm_rmmap_locked(struct drm_device *dev, drm_local_map_t *map)
+int drm_rmmap_locked(struct drm_device *dev, struct drm_local_map *map)
 {
 	struct drm_map_list *r_list = NULL, *list_t;
 	drm_dma_handle_t dmah;
@@ -442,7 +442,7 @@ int drm_rmmap_locked(struct drm_device *
 }
 EXPORT_SYMBOL(drm_rmmap_locked);
 
-int drm_rmmap(struct drm_device *dev, drm_local_map_t *map)
+int drm_rmmap(struct drm_device *dev, struct drm_local_map *map)
 {
 	int ret;
 
@@ -462,12 +462,18 @@ EXPORT_SYMBOL(drm_rmmap);
  * One use case might be after addmap is allowed for normal users for SHM and
  * gets used by drivers that the server doesn't need to care about.  This seems
  * unlikely.
+ *
+ * \param inode device inode.
+ * \param file_priv DRM file private.
+ * \param cmd command.
+ * \param arg pointer to a struct drm_map structure.
+ * \return zero on success or a negative value on error.
  */
 int drm_rmmap_ioctl(struct drm_device *dev, void *data,
 		    struct drm_file *file_priv)
 {
 	struct drm_map *request = data;
-	drm_local_map_t *map = NULL;
+	struct drm_local_map *map = NULL;
 	struct drm_map_list *r_list;
 	int ret;
 
@@ -1534,7 +1540,7 @@ int drm_mapbufs(struct drm_device *dev, 
 			&& (dma->flags & _DRM_DMA_USE_SG))
 		    || (drm_core_check_feature(dev, DRIVER_FB_DMA)
 			&& (dma->flags & _DRM_DMA_USE_FB))) {
-			struct drm_map *map = dev->agp_buffer_map;
+			struct drm_local_map *map = dev->agp_buffer_map;
 			unsigned long token = dev->agp_buffer_token;
 
 			if (!map) {
Index: linux-work/drivers/gpu/drm/drm_context.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_context.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_context.c	2009-02-02 15:29:36.000000000 +1100
@@ -143,7 +143,7 @@ int drm_getsareactx(struct drm_device *d
 		    struct drm_file *file_priv)
 {
 	struct drm_ctx_priv_map *request = data;
-	struct drm_map *map;
+	struct drm_local_map *map;
 	struct drm_map_list *_entry;
 
 	mutex_lock(&dev->struct_mutex);
@@ -186,7 +186,7 @@ int drm_setsareactx(struct drm_device *d
 		    struct drm_file *file_priv)
 {
 	struct drm_ctx_priv_map *request = data;
-	struct drm_map *map = NULL;
+	struct drm_local_map *map = NULL;
 	struct drm_map_list *r_list = NULL;
 
 	mutex_lock(&dev->struct_mutex);
Index: linux-work/drivers/gpu/drm/drm_drv.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_drv.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_drv.c	2009-02-02 15:29:36.000000000 +1100
@@ -530,7 +530,7 @@ int drm_ioctl(struct inode *inode, struc
 
 EXPORT_SYMBOL(drm_ioctl);
 
-drm_local_map_t *drm_getsarea(struct drm_device *dev)
+struct drm_local_map *drm_getsarea(struct drm_device *dev)
 {
 	struct drm_map_list *entry;
 
Index: linux-work/drivers/gpu/drm/drm_gem.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_gem.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_gem.c	2009-02-02 15:29:36.000000000 +1100
@@ -479,7 +479,7 @@ int drm_gem_mmap(struct file *filp, stru
 	struct drm_file *priv = filp->private_data;
 	struct drm_device *dev = priv->minor->dev;
 	struct drm_gem_mm *mm = dev->mm_private;
-	struct drm_map *map = NULL;
+	struct drm_local_map *map = NULL;
 	struct drm_gem_object *obj;
 	struct drm_hash_item *hash;
 	unsigned long prot;
Index: linux-work/drivers/gpu/drm/drm_memory.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_memory.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_memory.c	2009-02-02 15:29:36.000000000 +1100
@@ -159,7 +159,7 @@ static inline void *agp_remap(unsigned l
 
 #endif				/* debug_memory */
 
-void drm_core_ioremap(struct drm_map *map, struct drm_device *dev)
+void drm_core_ioremap(struct drm_local_map *map, struct drm_device *dev)
 {
 	if (drm_core_has_AGP(dev) &&
 	    dev->agp && dev->agp->cant_use_aperture && map->type == _DRM_AGP)
@@ -169,12 +169,12 @@ void drm_core_ioremap(struct drm_map *ma
 }
 EXPORT_SYMBOL(drm_core_ioremap);
 
-void drm_core_ioremap_wc(struct drm_map *map, struct drm_device *dev)
+void drm_core_ioremap_wc(struct drm_local_map *map, struct drm_device *dev)
 {
 	map->handle = ioremap_wc(map->offset, map->size);
 }
 EXPORT_SYMBOL(drm_core_ioremap_wc);
-void drm_core_ioremapfree(struct drm_map *map, struct drm_device *dev)
+void drm_core_ioremapfree(struct drm_local_map *map, struct drm_device *dev)
 {
 	if (!map->handle || !map->size)
 		return;
Index: linux-work/drivers/gpu/drm/drm_proc.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_proc.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_proc.c	2009-02-02 16:00:35.000000000 +1100
@@ -247,7 +247,7 @@ static int drm__vm_info(char *buf, char 
 	struct drm_minor *minor = (struct drm_minor *) data;
 	struct drm_device *dev = minor->dev;
 	int len = 0;
-	struct drm_map *map;
+	struct drm_local_map *map;
 	struct drm_map_list *r_list;
 
 	/* Hardcoded from _DRM_FRAME_BUFFER,
Index: linux-work/drivers/gpu/drm/drm_vm.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/drm_vm.c	2009-02-02 15:27:55.000000000 +1100
+++ linux-work/drivers/gpu/drm/drm_vm.c	2009-02-02 16:00:35.000000000 +1100
@@ -91,7 +91,7 @@ static int drm_do_vm_fault(struct vm_are
 {
 	struct drm_file *priv = vma->vm_file->private_data;
 	struct drm_device *dev = priv->minor->dev;
-	struct drm_map *map = NULL;
+	struct drm_local_map *map = NULL;
 	struct drm_map_list *r_list;
 	struct drm_hash_item *hash;
 
@@ -176,7 +176,7 @@ static int drm_do_vm_fault(struct vm_are
  */
 static int drm_do_vm_shm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct drm_map *map = (struct drm_map *) vma->vm_private_data;
+	struct drm_local_map *map = vma->vm_private_data;
 	unsigned long offset;
 	unsigned long i;
 	struct page *page;
@@ -209,7 +209,7 @@ static void drm_vm_shm_close(struct vm_a
 	struct drm_file *priv = vma->vm_file->private_data;
 	struct drm_device *dev = priv->minor->dev;
 	struct drm_vma_entry *pt, *temp;
-	struct drm_map *map;
+	struct drm_local_map *map;
 	struct drm_map_list *r_list;
 	int found_maps = 0;
 
@@ -322,7 +322,7 @@ static int drm_do_vm_dma_fault(struct vm
  */
 static int drm_do_vm_sg_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct drm_map *map = (struct drm_map *) vma->vm_private_data;
+	struct drm_local_map *map = vma->vm_private_data;
 	struct drm_file *priv = vma->vm_file->private_data;
 	struct drm_device *dev = priv->minor->dev;
 	struct drm_sg_mem *entry = dev->sg;
@@ -512,7 +512,7 @@ static int drm_mmap_dma(struct file *fil
 	return 0;
 }
 
-unsigned long drm_core_get_map_ofs(struct drm_map * map)
+unsigned long drm_core_get_map_ofs(struct drm_local_map * map)
 {
 	return map->offset;
 }
@@ -547,7 +547,7 @@ int drm_mmap_locked(struct file *filp, s
 {
 	struct drm_file *priv = filp->private_data;
 	struct drm_device *dev = priv->minor->dev;
-	struct drm_map *map = NULL;
+	struct drm_local_map *map = NULL;
 	unsigned long offset = 0;
 	struct drm_hash_item *hash;
 
Index: linux-work/include/drm/drmP.h
===================================================================
--- linux-work.orig/include/drm/drmP.h	2009-02-02 15:27:56.000000000 +1100
+++ linux-work/include/drm/drmP.h	2009-02-02 16:00:35.000000000 +1100
@@ -523,19 +523,32 @@ struct drm_mm {
 
 
 /**
+ * Kernel side of a mapping
+ */
+struct drm_local_map {
+	unsigned long offset;	 /**< Requested physical address (0 for SAREA)*/
+	unsigned long size;	 /**< Requested physical size (bytes) */
+	enum drm_map_type type;	 /**< Type of memory to map */
+	enum drm_map_flags flags;	 /**< Flags */
+	void *handle;		 /**< User-space: "Handle" to pass to mmap() */
+				 /**< Kernel-space: kernel-virtual address */
+	int mtrr;		 /**< MTRR slot used */
+};
+
+typedef struct drm_local_map drm_local_map_t;
+
+/**
  * Mappings list
  */
 struct drm_map_list {
 	struct list_head head;		/**< list head */
 	struct drm_hash_item hash;
-	struct drm_map *map;			/**< mapping */
+	struct drm_local_map *map;	/**< mapping */
 	uint64_t user_token;
 	struct drm_master *master;
 	struct drm_mm_node *file_offset_node;	/**< fake offset */
 };
 
-typedef struct drm_map drm_local_map_t;
-
 /**
  * Context handle list
  */
@@ -560,7 +573,7 @@ struct drm_ati_pcigart_info {
 	dma_addr_t bus_addr;
 	dma_addr_t table_mask;
 	struct drm_dma_handle *table_handle;
-	drm_local_map_t mapping;
+	struct drm_local_map mapping;
 	int table_size;
 };
 
@@ -747,7 +760,7 @@ struct drm_driver {
 					struct drm_file *file_priv);
 	void (*reclaim_buffers_idlelocked) (struct drm_device *dev,
 					    struct drm_file *file_priv);
-	unsigned long (*get_map_ofs) (struct drm_map * map);
+	unsigned long (*get_map_ofs) (struct drm_local_map * map);
 	unsigned long (*get_reg_ofs) (struct drm_device *dev);
 	void (*set_version) (struct drm_device *dev,
 			     struct drm_set_version *sv);
@@ -932,7 +945,7 @@ struct drm_device {
 	sigset_t sigmask;
 
 	struct drm_driver *driver;
-	drm_local_map_t *agp_buffer_map;
+	struct drm_local_map *agp_buffer_map;
 	unsigned int agp_buffer_token;
 	struct drm_minor *control;		/**< Control node for card */
 	struct drm_minor *primary;		/**< render type primary screen head */
@@ -1049,7 +1062,7 @@ extern int drm_release(struct inode *ino
 extern int drm_mmap(struct file *filp, struct vm_area_struct *vma);
 extern int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma);
 extern void drm_vm_open_locked(struct vm_area_struct *vma);
-extern unsigned long drm_core_get_map_ofs(struct drm_map * map);
+extern unsigned long drm_core_get_map_ofs(struct drm_local_map * map);
 extern unsigned long drm_core_get_reg_ofs(struct drm_device *dev);
 extern unsigned int drm_poll(struct file *filp, struct poll_table_struct *wait);
 
@@ -1155,11 +1168,11 @@ extern int drm_addbufs_agp(struct drm_de
 extern int drm_addbufs_pci(struct drm_device *dev, struct drm_buf_desc * request);
 extern int drm_addmap(struct drm_device *dev, unsigned int offset,
 		      unsigned int size, enum drm_map_type type,
-		      enum drm_map_flags flags, drm_local_map_t ** map_ptr);
+		      enum drm_map_flags flags, struct drm_local_map **map_ptr);
 extern int drm_addmap_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv);
-extern int drm_rmmap(struct drm_device *dev, drm_local_map_t *map);
-extern int drm_rmmap_locked(struct drm_device *dev, drm_local_map_t *map);
+extern int drm_rmmap(struct drm_device *dev, struct drm_local_map *map);
+extern int drm_rmmap_locked(struct drm_device *dev, struct drm_local_map *map);
 extern int drm_rmmap_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv);
 extern int drm_addbufs(struct drm_device *dev, void *data,
@@ -1261,7 +1274,7 @@ extern struct proc_dir_entry *drm_proc_r
 
 extern struct idr drm_minors_idr;
 
-extern drm_local_map_t *drm_getsarea(struct drm_device *dev);
+extern struct drm_local_map *drm_getsarea(struct drm_device *dev);
 
 				/* Proc support (drm_proc.h) */
 extern int drm_proc_init(struct drm_minor *minor, int minor_id,
@@ -1376,12 +1389,12 @@ int drm_gem_open_ioctl(struct drm_device
 void drm_gem_open(struct drm_device *dev, struct drm_file *file_private);
 void drm_gem_release(struct drm_device *dev, struct drm_file *file_private);
 
-extern void drm_core_ioremap(struct drm_map *map, struct drm_device *dev);
-extern void drm_core_ioremap_wc(struct drm_map *map, struct drm_device *dev);
-extern void drm_core_ioremapfree(struct drm_map *map, struct drm_device *dev);
+extern void drm_core_ioremap(struct drm_local_map *map, struct drm_device *dev);
+extern void drm_core_ioremap_wc(struct drm_local_map *map, struct drm_device *dev);
+extern void drm_core_ioremapfree(struct drm_local_map *map, struct drm_device *dev);
 
-static __inline__ struct drm_map *drm_core_findmap(struct drm_device *dev,
-						   unsigned int token)
+static __inline__ struct drm_local_map *drm_core_findmap(struct drm_device *dev,
+							 unsigned int token)
 {
 	struct drm_map_list *_entry;
 	list_for_each_entry(_entry, &dev->maplist, head)
@@ -1408,7 +1421,7 @@ static __inline__ int drm_device_is_pcie
 	return pci_find_capability(dev->pdev, PCI_CAP_ID_EXP);
 }
 
-static __inline__ void drm_core_dropmap(struct drm_map *map)
+static __inline__ void drm_core_dropmap(struct drm_local_map *map)
 {
 }
 
Index: linux-work/drivers/gpu/drm/i810/i810_drv.h
===================================================================
--- linux-work.orig/drivers/gpu/drm/i810/i810_drv.h	2009-02-02 16:00:49.000000000 +1100
+++ linux-work/drivers/gpu/drm/i810/i810_drv.h	2009-02-02 16:00:53.000000000 +1100
@@ -77,8 +77,8 @@ typedef struct _drm_i810_ring_buffer {
 } drm_i810_ring_buffer_t;
 
 typedef struct drm_i810_private {
-	struct drm_map *sarea_map;
-	struct drm_map *mmio_map;
+	struct drm_local_map *sarea_map;
+	struct drm_local_map *mmio_map;
 
 	drm_i810_sarea_t *sarea_priv;
 	drm_i810_ring_buffer_t ring;
Index: linux-work/drivers/gpu/drm/i830/i830_drv.h
===================================================================
--- linux-work.orig/drivers/gpu/drm/i830/i830_drv.h	2009-02-02 16:01:25.000000000 +1100
+++ linux-work/drivers/gpu/drm/i830/i830_drv.h	2009-02-02 16:01:29.000000000 +1100
@@ -84,8 +84,8 @@ typedef struct _drm_i830_ring_buffer {
 } drm_i830_ring_buffer_t;
 
 typedef struct drm_i830_private {
-	struct drm_map *sarea_map;
-	struct drm_map *mmio_map;
+	struct drm_local_map *sarea_map;
+	struct drm_local_map *mmio_map;
 
 	drm_i830_sarea_t *sarea_priv;
 	drm_i830_ring_buffer_t ring;
Index: linux-work/drivers/gpu/drm/i915/i915_gem.c
===================================================================
--- linux-work.orig/drivers/gpu/drm/i915/i915_gem.c	2009-02-02 16:01:58.000000000 +1100
+++ linux-work/drivers/gpu/drm/i915/i915_gem.c	2009-02-02 16:02:09.000000000 +1100
@@ -627,7 +627,7 @@ i915_gem_create_mmap_offset(struct drm_g
 	struct drm_gem_mm *mm = dev->mm_private;
 	struct drm_i915_gem_object *obj_priv = obj->driver_private;
 	struct drm_map_list *list;
-	struct drm_map *map;
+	struct drm_local_map *map;
 	int ret = 0;
 
 	/* Set the object up for mmap'ing */
@@ -2857,7 +2857,7 @@ void i915_gem_free_object(struct drm_gem
 	struct drm_device *dev = obj->dev;
 	struct drm_gem_mm *mm = dev->mm_private;
 	struct drm_map_list *list;
-	struct drm_map *map;
+	struct drm_local_map *map;
 	struct drm_i915_gem_object *obj_priv = obj->driver_private;
 
 	while (obj_priv->pin_count > 0)
