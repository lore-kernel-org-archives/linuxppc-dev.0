Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJHlF3v2BzDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:38:49 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UDcgGf041344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:38:47 -0400
Message-Id: <201605301338.u4UDcgGf041344@mx0a-001b2d01.pphosted.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238k6un7wm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:38:47 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 30 May 2016 23:38:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DBA213578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:38:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UDcWcA64749586
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:38:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UDc70c003354
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:38:08 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 6/6] vfio-pci: Allow to expose MSI-X table to userspace if
 interrupt remapping is enabled
Date: Mon, 30 May 2016 21:32:13 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch tries to expose MSI-X tables to userspace if hardware
enables interrupt remapping. This capability can ensure that a
given PCI device can only shoot the MSIs assigned for it. That
means a userspace driver could never hurt other devices or system
by writing to the exposed MSI-X table directly.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c      |   17 ++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 188b1ff..6bae388 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -487,8 +487,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 
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
 
@@ -503,6 +507,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 			      struct vfio_region_info_cap_sparse_mmap, header);
 	sparse->nr_areas = nr_areas;
 
+	if (vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) {
+		sparse->areas[i].offset = 0;
+		sparse->areas[i].size = end;
+		return 0;
+	}
+
 	if (vdev->msix_offset & PAGE_MASK) {
 		sparse->areas[i].offset = 0;
 		sparse->areas[i].size = vdev->msix_offset & PAGE_MASK;
@@ -1061,7 +1071,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (index == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5ffd1d9..dbf9cd0 100644
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
1.7.9.5
