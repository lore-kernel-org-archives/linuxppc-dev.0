Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xQqRK1kpzzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 17:49:00 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 5/5] vfio-pci: Allow to expose MSI-X table to userspace
 when safe
Date: Mon,  7 Aug 2017 17:25:48 +1000
Message-Id: <20170807072548.3023-6-aik@ozlabs.ru>
In-Reply-To: <20170807072548.3023-1-aik@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some devices have a MSIX BAR not aligned to the system page size
greater than 4K (like 64k for ppc64) which at the moment prevents
such MMIO pages from being mapped to the userspace for the sake of
the MSIX BAR content protection. If such page happens to share
the same system page with some frequently accessed registers,
the entire system page will be emulated which can seriously affect
performance.

This allows mapping of MSI-X tables to userspace if hardware provides
MSIX isolation via interrupt remapping or filtering; in other words
allowing direct access to the MSIX BAR won't do any harm to other devices
or cause spurious interrupts visible to the kernel.

This adds a wrapping helper to check if a capability is supported by
an IOMMU group.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/vfio.h             |  1 +
 drivers/vfio/pci/vfio_pci.c      | 20 +++++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c |  5 ++++-
 drivers/vfio/vfio.c              | 15 +++++++++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 586809abb273..7110bca2fb60 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -46,6 +46,7 @@ struct vfio_device_ops {
 
 extern struct iommu_group *vfio_iommu_group_get(struct device *dev);
 extern void vfio_iommu_group_put(struct iommu_group *group, struct device *dev);
+extern bool vfio_iommu_group_is_capable(struct device *dev, unsigned long cap);
 
 extern int vfio_add_group_dev(struct device *dev,
 			      const struct vfio_device_ops *ops,
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index d87a0a3cda14..c4c39ed64b1e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -561,11 +561,17 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 	struct vfio_region_info_cap_sparse_mmap *sparse;
 	size_t end, size;
 	int nr_areas = 2, i = 0, ret;
+	bool is_msix_isolated = vfio_iommu_group_is_capable(&vdev->pdev->dev,
+			IOMMU_GROUP_CAP_ISOLATE_MSIX);
 
 	end = pci_resource_len(vdev->pdev, vdev->msix_bar);
 
-	/* If MSI-X table is aligned to the start or end, only one area */
-	if (((vdev->msix_offset & PAGE_MASK) == 0) ||
+	/*
+	 * If MSI-X table is allowed to mmap because of the capability
+	 * of IRQ remapping or aligned to the start or end, only one area
+	 */
+	if (is_msix_isolated ||
+	    ((vdev->msix_offset & PAGE_MASK) == 0) ||
 	    (PAGE_ALIGN(vdev->msix_offset + vdev->msix_size) >= end))
 		nr_areas = 1;
 
@@ -577,6 +583,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 
 	sparse->nr_areas = nr_areas;
 
+	if (is_msix_isolated) {
+		sparse->areas[i].offset = 0;
+		sparse->areas[i].size = end;
+		return 0;
+	}
+
 	if (vdev->msix_offset & PAGE_MASK) {
 		sparse->areas[i].offset = 0;
 		sparse->areas[i].size = vdev->msix_offset & PAGE_MASK;
@@ -1094,6 +1106,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
 	int ret;
+	bool is_msix_isolated = vfio_iommu_group_is_capable(&vdev->pdev->dev,
+			IOMMU_GROUP_CAP_ISOLATE_MSIX);
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1115,7 +1129,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (index == vdev->msix_bar && !is_msix_isolated) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 357243d76f10..7514206a5ea7 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vgaarb.h>
+#include <linux/vfio.h>
 
 #include "vfio_pci_private.h"
 
@@ -123,6 +124,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 	resource_size_t end;
 	void __iomem *io;
 	ssize_t done;
+	bool is_msix_isolated = vfio_iommu_group_is_capable(&vdev->pdev->dev,
+			IOMMU_GROUP_CAP_ISOLATE_MSIX);
 
 	if (pci_resource_start(pdev, bar))
 		end = pci_resource_len(pdev, bar);
@@ -164,7 +167,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 	} else
 		io = vdev->barmap[bar];
 
-	if (bar == vdev->msix_bar) {
+	if (bar == vdev->msix_bar && !is_msix_isolated) {
 		x_start = vdev->msix_offset;
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 330d50582f40..5292c4a5ae8f 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -169,6 +169,21 @@ void vfio_iommu_group_put(struct iommu_group *group, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(vfio_iommu_group_put);
 
+bool vfio_iommu_group_is_capable(struct device *dev, unsigned long cap)
+{
+	bool ret = false;
+	struct iommu_group *group = vfio_iommu_group_get(dev);
+
+	if (group) {
+		ret = iommu_group_is_capable(group, cap);
+
+		vfio_iommu_group_put(group, dev);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_group_is_capable);
+
 #ifdef CONFIG_VFIO_NOIOMMU
 static void *vfio_noiommu_open(unsigned long arg)
 {
-- 
2.11.0
