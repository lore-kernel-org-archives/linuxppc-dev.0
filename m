Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg7mk1rSmzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 00:45:10 +1000 (AEST)
Date: Wed, 6 Apr 2016 08:45:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 eric.auger@linaro.org, will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 alistair@popple.id.au, ruscur@russell.cc
Subject: Re: [RFC v5 7/7] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Message-ID: <20160406084504.1a1cc16d@t450s.home>
In-Reply-To: <1459864004-2869-2-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1459864004-2869-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459864004-2869-2-git-send-email-xyjxie@linux.vnet.ibm.com>
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

On Tue,  5 Apr 2016 21:46:44 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> This patch enables mmapping MSI-X tables if
> hardware supports interrupt remapping which
> can ensure that a given pci device can only
> shoot the MSIs assigned for it.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |    9 +++++++--
>  drivers/vfio/pci/vfio_pci_private.h |    1 +
>  drivers/vfio/pci/vfio_pci_rdwr.c    |    2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index c60d790..ef02896 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -201,6 +201,10 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  	} else
>  		vdev->msix_bar = 0xFF;
>  
> +	if (iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) ||

This doesn't address the issue I raised earlier where ARM SMMU sets
this capability, but doesn't really provide per vector isolation.  ARM
either needs to be fixed or we need to consider the whole capability
tainted for this application and standardize around the bus flags.
It's not very desirable to have two different ways to test this anyway.

> +		pdev->bus->bus_flags | PCI_BUS_FLAGS_MSI_REMAP)

Perhaps some sort of wrapper for testing these flags would help avoid
this kind of coding error (| vs &)

> +		vdev->msi_remap = true;
> +
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> @@ -635,7 +639,8 @@ static long vfio_pci_ioctl(void *device_data,
>  				     VFIO_REGION_INFO_FLAG_WRITE;
>  			if (vdev->bar_mmap_supported[info.index]) {
>  				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
> -				if (info.index == vdev->msix_bar) {
> +				if (info.index == vdev->msix_bar &&
> +						!vdev->msi_remap) {
>  					ret = msix_sparse_mmap_cap(vdev, &caps);
>  					if (ret)
>  						return ret;
> @@ -1067,7 +1072,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	if (req_start + req_len > phys_len)
>  		return -EINVAL;
>  
> -	if (index == vdev->msix_bar) {
> +	if (index == vdev->msix_bar && !vdev->msi_remap) {
>  		/*
>  		 * Disallow mmaps overlapping the MSI-X table; users don't
>  		 * get to touch this directly.  We could find somewhere
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 0ea4c62..4f20963 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -78,6 +78,7 @@ struct vfio_pci_device {
>  	int			irq_type;
>  	int			num_regions;
>  	struct vfio_pci_region	*region;
> +	bool			msi_remap;
>  	u8			msi_qmax;
>  	u8			msix_bar;
>  	u16			msix_size;
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 5ffd1d9..606ee3c 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -164,7 +164,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
>  	} else
>  		io = vdev->barmap[bar];
>  
> -	if (bar == vdev->msix_bar) {
> +	if (bar == vdev->msix_bar && !vdev->msi_remap) {
>  		x_start = vdev->msix_offset;
>  		x_end = vdev->msix_offset + vdev->msix_size;
>  	}
