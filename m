Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wpBMM5V4JzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 15:07:27 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 3/3] vfio-pci: Allow to expose MSI-X table to userspace
 if interrupt remapping is enabled
Date: Thu, 15 Jun 2017 15:06:42 +1000
Message-Id: <20170615050642.8197-4-aik@ozlabs.ru>
In-Reply-To: <20170615050642.8197-1-aik@ozlabs.ru>
References: <20170615050642.8197-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yongji Xie <xyjxie@linux.vnet.ibm.com>

This patch tries to expose MSI-X tables to userspace if hardware
enables interrupt remapping which can ensure that a given PCI
device can only shoot the MSIs assigned for it. So we could
never worry that userspace driver can hurt other devices by
writing to the exposed MSI-X table directly.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci.c      | 18 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c |  3 ++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 324c52e3a1a4..700e9d04dab5 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -564,8 +564,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 
 	end = pci_resource_len(vdev->pdev, vdev->msix_bar);
 
-	/* If MSI-X table is aligned to the start or end, only one area */
-	if (((vdev->msix_offset & PAGE_MASK) == 0) ||
+	/*
+	 * If MSI-X table is allowed to mmap because of the capability
+	 * of IRQ remapping or aligned to the start or end, only one area
+	 */
+	if ((vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) ||
+	    ((vdev->msix_offset & PAGE_MASK) == 0) ||
 	    (PAGE_ALIGN(vdev->msix_offset + vdev->msix_size) >= end))
 		nr_areas = 1;
 
@@ -577,6 +581,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 
 	sparse->nr_areas = nr_areas;
 
+	if (vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) {
+		sparse->areas[i].offset = 0;
+		sparse->areas[i].size = end;
+		goto out;
+	}
+
 	if (vdev->msix_offset & PAGE_MASK) {
 		sparse->areas[i].offset = 0;
 		sparse->areas[i].size = vdev->msix_offset & PAGE_MASK;
@@ -590,6 +600,7 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 		i++;
 	}
 
+out:
 	ret = vfio_info_add_capability(caps, VFIO_REGION_INFO_CAP_SPARSE_MMAP,
 				       sparse);
 	kfree(sparse);
@@ -1115,7 +1126,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (index == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 357243d76f10..5378f2c3ac8e 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -164,7 +164,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 	} else
 		io = vdev->barmap[bar];
 
-	if (bar == vdev->msix_bar) {
+	if (bar == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		x_start = vdev->msix_offset;
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
-- 
2.11.0
