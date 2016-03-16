Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQH7b1510zDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 03:31:54 +1100 (AEDT)
Date: Wed, 16 Mar 2016 10:31:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Eric Auger <eric.auger@linaro.org>, Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v4 6/7] vfio-pci: Allow to mmap MSI-X table if
 IOMMU_CAP_INTR_REMAP was set
Message-ID: <20160316103137.49e7a171@t450s.home>
In-Reply-To: <1457336918-3893-7-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-7-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc+ Eric, Will]

On Mon,  7 Mar 2016 15:48:37 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> Current vfio-pci implementation disallows to mmap MSI-X
> table in case that user get to touch this directly.
> 
> But we should allow to mmap these MSI-X tables if IOMMU
> supports interrupt remapping which can ensure that a
> given pci device can only shoot the MSIs assigned for it.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c      |    8 +++++---
>  drivers/vfio/pci/vfio_pci_rdwr.c |    4 +++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 49d7a69..d6f4788 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -592,13 +592,14 @@ static long vfio_pci_ioctl(void *device_data,
>  			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
>  			    info.index)) {
>  				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
> -				if (info.index == vdev->msix_bar) {
> +				if (!iommu_capable(pdev->dev.bus,
> +					IOMMU_CAP_INTR_REMAP) &&
> +					info.index == vdev->msix_bar) {

We only need to test the IOMMU capability if it's the msix BAR, so why
test these in the reverse order?  It should be:

                                    info.index == vdev->msix_bar &&
                                    !iommu_capable(pdev->dev.bus,
                                                   IOMMU_CAP_INTR_REMAP)

Same below.

I think we also have the problem that ARM SMMU is setting this
capability when it's really not doing anything at all to provide
interrupt isolation.  Adding Eric and Will to the Cc for comment.

I slightly dislike using an IOMMU API interface here to determine if
it's safe to allow user access to the MSIx vector table, but it seems
like the best option we have at this point, if it's actually true for
all the IOMMU drivers participating in the IOMMU API.

>  					ret = msix_sparse_mmap_cap(vdev, &caps);
>  					if (ret)
>  						return ret;
>  				}
>  			}
> -
>  			break;
>  		case VFIO_PCI_ROM_REGION_INDEX:
>  		{
> @@ -1029,7 +1030,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
>  		return -EINVAL;
>  
> -	if (index == vdev->msix_bar) {
> +	if (!iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) &&
> +		index == vdev->msix_bar) {
>  		/*
>  		 * Disallow mmaps overlapping the MSI-X table; users don't
>  		 * get to touch this directly.  We could find somewhere
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 5ffd1d9..1c46c29 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -18,6 +18,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
>  #include <linux/vgaarb.h>
> +#include <linux/iommu.h>
>  
>  #include "vfio_pci_private.h"
>  
> @@ -164,7 +165,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
>  	} else
>  		io = vdev->barmap[bar];
>  
> -	if (bar == vdev->msix_bar) {
> +	if (!iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) &&
> +		bar == vdev->msix_bar) {

Do we really want to test this on *every* read/write to any BAR (order
of tests matter)?  Even in the case of the MSIx BAR, should we cache
this when the device is first opened?

>  		x_start = vdev->msix_offset;
>  		x_end = vdev->msix_offset + vdev->msix_size;
>  	}
