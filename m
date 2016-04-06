Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfmBQ5vXVzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 10:02:38 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 10:02:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 05A892CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 10:02:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3602C9W56426654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 10:02:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3601lsv015875
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 10:01:48 +1000
Date: Wed, 6 Apr 2016 10:00:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 eric.auger@linaro.org, will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 alistair@popple.id.au, ruscur@russell.cc
Subject: Re: [RFC v5 7/7] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Message-ID: <20160406000052.GA4545@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459864004-2869-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459864004-2869-2-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459864004-2869-2-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2016 at 09:46:44PM +0800, Yongji Xie wrote:
>This patch enables mmapping MSI-X tables if
>hardware supports interrupt remapping which
>can ensure that a given pci device can only
>shoot the MSIs assigned for it.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/vfio/pci/vfio_pci.c         |    9 +++++++--
> drivers/vfio/pci/vfio_pci_private.h |    1 +
> drivers/vfio/pci/vfio_pci_rdwr.c    |    2 +-
> 3 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>index c60d790..ef02896 100644
>--- a/drivers/vfio/pci/vfio_pci.c
>+++ b/drivers/vfio/pci/vfio_pci.c
>@@ -201,6 +201,10 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
> 	} else
> 		vdev->msix_bar = 0xFF;
>
>+	if (iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>+		pdev->bus->bus_flags | PCI_BUS_FLAGS_MSI_REMAP)
>+		vdev->msi_remap = true;
>+

I guess you probably need a "&" here. Otherwise, the condition
is always true.

> 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
> 		vdev->has_vga = true;
>
>@@ -635,7 +639,8 @@ static long vfio_pci_ioctl(void *device_data,
> 				     VFIO_REGION_INFO_FLAG_WRITE;
> 			if (vdev->bar_mmap_supported[info.index]) {
> 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
>-				if (info.index == vdev->msix_bar) {
>+				if (info.index == vdev->msix_bar &&
>+						!vdev->msi_remap) {
> 					ret = msix_sparse_mmap_cap(vdev, &caps);
> 					if (ret)
> 						return ret;
>@@ -1067,7 +1072,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
> 	if (req_start + req_len > phys_len)
> 		return -EINVAL;
>
>-	if (index == vdev->msix_bar) {
>+	if (index == vdev->msix_bar && !vdev->msi_remap) {
> 		/*
> 		 * Disallow mmaps overlapping the MSI-X table; users don't
> 		 * get to touch this directly.  We could find somewhere
>diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
>index 0ea4c62..4f20963 100644
>--- a/drivers/vfio/pci/vfio_pci_private.h
>+++ b/drivers/vfio/pci/vfio_pci_private.h
>@@ -78,6 +78,7 @@ struct vfio_pci_device {
> 	int			irq_type;
> 	int			num_regions;
> 	struct vfio_pci_region	*region;
>+	bool			msi_remap;
> 	u8			msi_qmax;
> 	u8			msix_bar;
> 	u16			msix_size;
>diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>index 5ffd1d9..606ee3c 100644
>--- a/drivers/vfio/pci/vfio_pci_rdwr.c
>+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>@@ -164,7 +164,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
> 	} else
> 		io = vdev->barmap[bar];
>
>-	if (bar == vdev->msix_bar) {
>+	if (bar == vdev->msix_bar && !vdev->msi_remap) {
> 		x_start = vdev->msix_offset;
> 		x_end = vdev->msix_offset + vdev->msix_size;
> 	}

When PCI_BUS_FLAGS_MSI_REMAP is set, the MSIx table can be accessed by
read/write interface except mmap(). The commit log doesn't mention it.
It would be better if you have some words about it.

Thanks,
Gavin


>-- 
>1.7.9.5
>
