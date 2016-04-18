Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpQ966x5JzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:58:02 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 20:58:02 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 63C823578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:57:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IAvgsi49414352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:57:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IAvHY0013583
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:57:18 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 05/10] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio
 page is exclusive
Date: Mon, 18 Apr 2016 18:56:01 +0800
Message-Id: <1460976961-29328-5-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
page may be shared with other BARs.

But we should allow to mmap these sub-page MMIO BARs if we can
make sure these BARs' mmio page will not be shared with other BARs.

To acheive that, we firstly need to enforce all PCI MMIO BARs
to be page aligned like the commit "PCI: Add support for
enforcing all MMIO BARs to be page aligned" does. Most of PCI
BARs will be assigned into an exclusive page with a hole. Then,
we must make sure that hot-add device's BAR will never be assigned
into the hole. So we add shadow resources and put them into the
hole in this patch. With these two guarantees, I think it should
be safe to mmap sub-page BAR.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c         |   58 ++++++++++++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_private.h |    8 +++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 98059df..dc1779c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -110,13 +110,47 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+static bool vfio_pci_bar_mmap_supported(struct vfio_pci_device *vdev, int index)
+{
+	struct resource *res = vdev->pdev->resource + index;
+	struct vfio_pci_shadow_resource *shadow_res;
+
+	if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) && res->flags & IORESOURCE_MEM &&
+		resource_size(res) > 0) {
+		if (resource_size(res) >= PAGE_SIZE)
+			return true;
+
+		if (!(res->start & ~PAGE_MASK)) {
+			/*
+			 * Add shadow resource for sub-page bar whose mmio
+			 * page is exclusive in case that hot-add device's
+			 * bar is assigned into the mem hole.
+			 */
+			shadow_res = kzalloc(sizeof(*shadow_res), GFP_KERNEL);
+			shadow_res->resource.start = res->end + 1;
+			shadow_res->resource.end = res->start + PAGE_SIZE - 1;
+			shadow_res->resource.flags = res->flags;
+			if (request_resource(res->parent,
+					&shadow_res->resource)) {
+				kfree(shadow_res);
+				return false;
+			}
+			shadow_res->index = index;
+			list_add(&shadow_res->res_next,
+					&vdev->shadow_resources_list);
+			return true;
+		}
+	}
+	return false;
+}
+
 static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev);
 static void vfio_pci_disable(struct vfio_pci_device *vdev);
 
 static int vfio_pci_enable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	int ret;
+	int ret, bar;
 	u16 cmd;
 	u8 msix_pos;
 
@@ -183,12 +217,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		}
 	}
 
+	for (bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END; bar++) {
+		vdev->bar_mmap_supported[bar] =
+				vfio_pci_bar_mmap_supported(vdev, bar);
+	}
 	return 0;
 }
 
 static void vfio_pci_disable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_shadow_resource *shadow_res, *tmp;
 	int i, bar;
 
 	/* Stop the device from further DMA */
@@ -217,6 +256,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 		vdev->barmap[bar] = NULL;
 	}
 
+	list_for_each_entry_safe(shadow_res, tmp,
+				 &vdev->shadow_resources_list, res_next) {
+		list_del(&shadow_res->res_next);
+		release_resource(&shadow_res->resource);
+		kfree(shadow_res);
+	}
+
 	vdev->needs_reset = true;
 
 	/*
@@ -587,9 +633,7 @@ static long vfio_pci_ioctl(void *device_data,
 
 			info.flags = VFIO_REGION_INFO_FLAG_READ |
 				     VFIO_REGION_INFO_FLAG_WRITE;
-			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
-			    pci_resource_flags(pdev, info.index) &
-			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
+			if (vdev->bar_mmap_supported[info.index]) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
 				if (info.index == vdev->msix_bar) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
@@ -1011,16 +1055,16 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 		return -EINVAL;
 	if (index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -EINVAL;
-	if (!(pci_resource_flags(pdev, index) & IORESOURCE_MEM))
+	if (!vdev->bar_mmap_supported[index])
 		return -EINVAL;
 
-	phys_len = pci_resource_len(pdev, index);
+	phys_len = PAGE_ALIGN(pci_resource_len(pdev, index));
 	req_len = vma->vm_end - vma->vm_start;
 	pgoff = vma->vm_pgoff &
 		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
 	req_start = pgoff << PAGE_SHIFT;
 
-	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
+	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
 	if (index == vdev->msix_bar) {
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 8a7d546..0ea4c62 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -57,9 +57,16 @@ struct vfio_pci_region {
 	u32				flags;
 };
 
+struct vfio_pci_shadow_resource {
+	struct resource		resource;
+	int			index;
+	struct list_head	res_next;
+};
+
 struct vfio_pci_device {
 	struct pci_dev		*pdev;
 	void __iomem		*barmap[PCI_STD_RESOURCE_END + 1];
+	bool			bar_mmap_supported[PCI_STD_RESOURCE_END + 1];
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -87,6 +94,7 @@ struct vfio_pci_device {
 	int			refcnt;
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
+	struct list_head	shadow_resources_list;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
-- 
1.7.9.5
