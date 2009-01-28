Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F8E7DE04A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 01:48:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0SEn73U005596
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 09:49:07 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0SEmffF171236
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 09:48:41 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0SEliWv010135
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 09:47:44 -0500
Message-ID: <49806FF9.9060307@linux.vnet.ibm.com>
Date: Wed, 28 Jan 2009 08:47:21 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Correct VIO bus accounting problem in CMO env.
References: <20090122194000.GA14767@austin.ibm.com>
In-Reply-To: <20090122194000.GA14767@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked by: Brian King <brking@linux.vnet.ibm.com>

Robert Jennings wrote:
> In the VIO bus code the wrappers for dma alloc_coherent and free_coherent
> calls are rounding to IOMMU_PAGE_SIZE.  Taking a look at the underlying
> calls, the actual mapping is promoted to PAGE_SIZE.  Changing the
> rounding in these two functions fixes under-reporting the entitlement
> used by the system.  Without this change, the system could run out of
> entitlement before it believes it has and incur mapping failures at the
> firmware level.
> 
> Also in the VIO bus code, the wrapper for dma map_sg is not exiting in
> an error path where it should.  Rather than fall through to code for the
> success case, this patch adds the return that is needed in the error path.
> 
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/kernel/vio.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: b/arch/powerpc/kernel/vio.c
> ===================================================================
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -492,14 +492,14 @@ static void *vio_dma_iommu_alloc_coheren
>  	struct vio_dev *viodev = to_vio_dev(dev);
>  	void *ret;
> 
> -	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE))) {
> +	if (vio_cmo_alloc(viodev, roundup(size, PAGE_SIZE))) {
>  		atomic_inc(&viodev->cmo.allocs_failed);
>  		return NULL;
>  	}
> 
>  	ret = dma_iommu_ops.alloc_coherent(dev, size, dma_handle, flag);
>  	if (unlikely(ret == NULL)) {
> -		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
> +		vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
>  		atomic_inc(&viodev->cmo.allocs_failed);
>  	}
> 
> @@ -513,7 +513,7 @@ static void vio_dma_iommu_free_coherent(
> 
>  	dma_iommu_ops.free_coherent(dev, size, vaddr, dma_handle);
> 
> -	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
> +	vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
>  }
> 
>  static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
> @@ -572,6 +572,7 @@ static int vio_dma_iommu_map_sg(struct d
>  	if (unlikely(!ret)) {
>  		vio_cmo_dealloc(viodev, alloc_size);
>  		atomic_inc(&viodev->cmo.allocs_failed);
> +		return ret;
>  	}
> 
>  	for (sgl = sglist, count = 0; count < ret; count++, sgl++)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
