Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9B021A056F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:56:39 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 11 Dec 2015 18:56:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9679C357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:56:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBB8uRBB43122884
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:56:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB8u2Pn018104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:56:03 +1100
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
Date: Fri, 11 Dec 2015 16:53:14 +0800
Message-Id: <1449823994-3356-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap MSI-X table in
case that user get to touch this directly.

However, EEH mechanism could ensure that a given pci device
can only shoot the MSIs assigned for its PE and guest kernel also
would not write to MSI-X table in pci_enable_msix() because
para-virtualization on PPC64 platform. So MSI-X table is safe to
access directly from the guest with EEH mechanism enabled.

This patch adds support for this case and allow to mmap MSI-X
table if EEH is supported on PPC64 platform.

And we also add a VFIO_DEVICE_FLAGS_PCI_MSIX_MMAP flag to notify
userspace that it's safe to mmap MSI-X table.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c         |    5 ++++-
 drivers/vfio/pci/vfio_pci_private.h |    5 +++++
 include/uapi/linux/vfio.h           |    2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index dbcad99..85d9980 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -446,6 +446,9 @@ static long vfio_pci_ioctl(void *device_data,
 		if (vfio_pci_bar_page_aligned())
 			info.flags |= VFIO_DEVICE_FLAGS_PCI_PAGE_ALIGNED;
 
+		if (vfio_msix_table_mmap_enabled())
+			info.flags |= VFIO_DEVICE_FLAGS_PCI_MSIX_MMAP;
+
 		info.num_regions = VFIO_PCI_NUM_REGIONS;
 		info.num_irqs = VFIO_PCI_NUM_IRQS;
 
@@ -871,7 +874,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (index == vdev->msix_bar && !vfio_msix_table_mmap_enabled()) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 319352a..835619e 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -74,6 +74,11 @@ static inline bool vfio_pci_bar_page_aligned(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+static inline bool vfio_msix_table_mmap_enabled(void)
+{
+	return IS_ENABLED(CONFIG_EEH);
+}
+
 extern void vfio_pci_intx_mask(struct vfio_pci_device *vdev);
 extern void vfio_pci_intx_unmask(struct vfio_pci_device *vdev);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1fc8066..289e662 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -173,6 +173,8 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 /* Platform support all PCI MMIO BARs to be page aligned */
 #define VFIO_DEVICE_FLAGS_PCI_PAGE_ALIGNED	(1 << 4)
+/* Platform support mmapping PCI MSI-X vector table */
+#define VFIO_DEVICE_FLAGS_PCI_MSIX_MMAP	(1 << 5)
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
-- 
1.7.9.5
