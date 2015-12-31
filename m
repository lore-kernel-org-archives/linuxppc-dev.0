Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21421A00EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 19:52:13 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 31 Dec 2015 14:22:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3952B3940061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 14:22:10 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBV8qA405701912
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 14:22:10 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBV8q9et003131
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 14:22:09 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
Date: Thu, 31 Dec 2015 16:50:44 +0800
Message-Id: <1451551844-11732-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vfio-pci implementation disallows to mmap MSI-X
table in case that user get to touch this directly.

However, EEH mechanism can ensure that a given pci device
can only shoot the MSIs assigned for its PE. So we think
it's safe to expose the MSI-X table to userspace because
the exposed MSI-X table can't be used to do harm to other
memory space.

And with MSI-X table mmapped, some performance issues which
are caused when PCI adapters have critical registers in the
same page as the MSI-X table also can be resolved.

So this patch adds a Kconfig option, VFIO_PCI_MMAP_MSIX,
to support for mmapping MSI-X table.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/Kconfig    |    4 ++++
 drivers/vfio/pci/vfio_pci.c |    6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 02912f1..67b0a2c 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -23,6 +23,10 @@ config VFIO_PCI_MMAP
 	depends on VFIO_PCI
 	def_bool y if !S390
 
+config VFIO_PCI_MMAP_MSIX
+	depends on VFIO_PCI_MMAP
+	def_bool y if EEH
+
 config VFIO_PCI_INTX
 	depends on VFIO_PCI
 	def_bool y if !S390
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 09b3805..d536985 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -555,7 +555,8 @@ static long vfio_pci_ioctl(void *device_data,
 			    IORESOURCE_MEM && (info.size >= PAGE_SIZE ||
 			    pci_resource_page_aligned)) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
-				if (info.index == vdev->msix_bar) {
+				if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP_MSIX) &&
+				    info.index == vdev->msix_bar) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
 					if (ret)
 						return ret;
@@ -967,7 +968,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP_MSIX) &&
+	    index == vdev->msix_bar) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
-- 
1.7.9.5
