Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411sNW17PzzF35D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 03:04:59 +1000 (AEST)
Date: Thu, 7 Jun 2018 11:04:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Ram Pai <linuxram@us.ibm.com>,
 kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 4/5] vfio_pci: Allow mapping extra regions
Message-ID: <20180607110455.0bea1acd@w520.home>
In-Reply-To: <20180607084420.29513-5-aik@ozlabs.ru>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607084420.29513-5-aik@ozlabs.ru>
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

On Thu,  7 Jun 2018 18:44:19 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

What's an "extra region", -ENOCOMMITLOG

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/pci/vfio_pci_private.h |  3 +++
>  drivers/vfio/pci/vfio_pci.c         | 10 ++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index cde3b5d..86aab05 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -59,6 +59,9 @@ struct vfio_pci_regops {
>  		      size_t count, loff_t *ppos, bool iswrite);
>  	void	(*release)(struct vfio_pci_device *vdev,
>  			   struct vfio_pci_region *region);
> +	int	(*mmap)(struct vfio_pci_device *vdev,
> +			struct vfio_pci_region *region,
> +			struct vm_area_struct *vma);
>  };
>  
>  struct vfio_pci_region {
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 3729937..7bddf1e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1123,10 +1123,16 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
> +	if (index >= VFIO_PCI_NUM_REGIONS) {
> +		int regnum = index - VFIO_PCI_NUM_REGIONS;
> +		struct vfio_pci_region *region = vdev->region + regnum;
> +
> +		if (region && region->ops && region->ops->mmap)
> +			return region->ops->mmap(vdev, region, vma);
> +		return -EINVAL;
> +	}
>  	if (index >= VFIO_PCI_ROM_REGION_INDEX)
>  		return -EINVAL;
> -	if (!vdev->bar_mmap_supported[index])
> -		return -EINVAL;

This seems unrelated.  Thanks,

Alex
  
>  	phys_len = PAGE_ALIGN(pci_resource_len(pdev, index));
>  	req_len = vma->vm_end - vma->vm_start;
