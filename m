Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A54441A0D21
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:37 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 17:09:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 044EC2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F79RQu27721736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F790OX012801
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:01 +1100
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 5/5] vfio-pci: Allow to mmap MSI-X table if host bridge
 supports filtering of MSIs
Date: Fri, 15 Jan 2016 15:06:14 +0800
Message-Id: <1452841574-2781-6-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

But we should allow to mmap these MSI-X tables if the PCI
host bridge supports filtering of MSIs.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 11fd0f0..4d68f6a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -555,7 +555,8 @@ static long vfio_pci_ioctl(void *device_data,
 			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
 			    info.index)) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
-				if (info.index == vdev->msix_bar) {
+				if (!pci_host_bridge_msi_filtered_enabled(pdev) &&
+				    info.index == vdev->msix_bar) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
 					if (ret)
 						return ret;
@@ -967,7 +968,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (!pci_host_bridge_msi_filtered_enabled(pdev) &&
+	    index == vdev->msix_bar) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
-- 
1.7.9.5
