Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpQL86VNyzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:52 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 21:05:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 49BB52CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IB5SKv4456592
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IB535h014311
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:04 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 10/10] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Date: Mon, 18 Apr 2016 19:04:03 +0800
Message-Id: <1460977443-29405-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1460977443-29405-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1460977443-29405-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables mmapping MSI-X tables if hardware supports
interrupt remapping which can ensure that a given pci device
can only shoot the MSIs assigned for it.

With MSI-X table mmapped, we also need to expose the
read/write interface which will be used to access MSI-X table.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c      |    7 +++++--
 drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index dc1779c..b08abe0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -635,7 +635,9 @@ static long vfio_pci_ioctl(void *device_data,
 				     VFIO_REGION_INFO_FLAG_WRITE;
 			if (vdev->bar_mmap_supported[info.index]) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
-				if (info.index == vdev->msix_bar) {
+				if (info.index == vdev->msix_bar &&
+					!(pdev->bus->bus_flags &
+					PCI_BUS_FLAGS_MSI_REMAP)) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
 					if (ret)
 						return ret;
@@ -1067,7 +1069,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (req_start + req_len > phys_len)
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
