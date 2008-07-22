Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.27216.228641.108772@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 15:04:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/16 v3] [v2] powerpc: iommu enablement for CMO
In-Reply-To: <20080708204813.GC20206@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125459.GM1310@linux.vnet.ibm.com>
	<20080708204813.GC20206@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>,
	David Darrington <ddarring@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> From: Robert Jennings <rcj@linux.vnet.ibm.com>
> 
> Minor change to add a call to align the return from the device's
> get_desired_dma() function with IOMMU_PAGE_ALIGN().  Also removed a
> comment referring to a non-existent structure member.
> 
> This is a large patch but the normal code path is not affected.  For
> non-pSeries platforms the code is ifdef'ed out and for non-CMO enabled
> pSeries systems this does not affect the normal code path.  Devices that
> do not perform DMA operations do not need modification with this patch.
> The function get_desired_dma was renamed from get_io_entitlement for
> clarity.

This patch is actually a new version of [PATCH 11/16 v3] powerpc: vio
bus support for CMO, not a new version of [PATCH 10/16 v3] powerpc:
iommu enablement for CMO as the subject would indicate, which tripped
me up.  Anyway, my first comment is that the first paragraph of the
description ("Minor change to ...") is not appropriate for the git
tree and will have to be edited before the patch is applied.  If the
extra changes are worth describing, describe them (in stand-alone
fashion) in the description; otherwise put things like this after the
line of three dashes, which terminates the description.

> +static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
> +                                int nelems, enum dma_data_direction direction)

This function, and the related unmap_sg, map_single and unmap_single
functions, now take an extra "struct dma_attrs *attrs" argument since
Mark Nelson's patch "powerpc/dma: implement new dma_*map*_attrs()
interfaces" went in (and it's now in Linus' tree).  You need to roll
something like the patch below in with the 11/16 patch.

Paul.

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index ad818d1..e05baea 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -518,7 +518,8 @@ static void vio_dma_iommu_free_coherent(struct device *dev, size_t size,
 
 static dma_addr_t vio_dma_iommu_map_single(struct device *dev, void *vaddr,
                                            size_t size,
-                                           enum dma_data_direction direction)
+                                           enum dma_data_direction direction,
+					   struct dma_attrs *attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	dma_addr_t ret = DMA_ERROR_CODE;
@@ -528,7 +529,7 @@ static dma_addr_t vio_dma_iommu_map_single(struct device *dev, void *vaddr,
 		return ret;
 	}
 
-	ret = dma_iommu_ops.map_single(dev, vaddr, size, direction);
+	ret = dma_iommu_ops.map_single(dev, vaddr, size, direction, attrs);
 	if (unlikely(dma_mapping_error(ret))) {
 		vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 		atomic_inc(&viodev->cmo.allocs_failed);
@@ -539,17 +540,18 @@ static dma_addr_t vio_dma_iommu_map_single(struct device *dev, void *vaddr,
 
 static void vio_dma_iommu_unmap_single(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
+		enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 
-	dma_iommu_ops.unmap_single(dev, dma_handle, size, direction);
+	dma_iommu_ops.unmap_single(dev, dma_handle, size, direction, attrs);
 
 	vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 }
 
 static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
-                                int nelems, enum dma_data_direction direction)
+                                int nelems, enum dma_data_direction direction,
+				struct dma_attrs *attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct scatterlist *sgl;
@@ -564,7 +566,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 		return 0;
 	}
 
-	ret = dma_iommu_ops.map_sg(dev, sglist, nelems, direction);
+	ret = dma_iommu_ops.map_sg(dev, sglist, nelems, direction, attrs);
 
 	if (unlikely(!ret)) {
 		vio_cmo_dealloc(viodev, alloc_size);
@@ -581,7 +583,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void vio_dma_iommu_unmap_sg(struct device *dev,
 		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction direction)
+		enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct scatterlist *sgl;
@@ -591,7 +593,7 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 	for (sgl = sglist; count < nelems; count++, sgl++)
 		alloc_size += roundup(sgl->dma_length, PAGE_SIZE);
 
-	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction);
+	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction, attrs);
 
 	vio_cmo_dealloc(viodev, alloc_size);
 }
