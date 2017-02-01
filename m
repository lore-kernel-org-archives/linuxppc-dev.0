Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD8gB0wcWzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 04:06:46 +1100 (AEDT)
Date: Wed, 1 Feb 2017 10:06:42 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel] vfio/spapr: Fix missing mutex unlock when
 creating a window
Message-ID: <20170201100642.02d9c1e6@t450s.home>
In-Reply-To: <20170201032616.23350-1-aik@ozlabs.ru>
References: <20170201032616.23350-1-aik@ozlabs.ru>
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

On Wed,  1 Feb 2017 14:26:16 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> d9c728949ddc: "vfio/spapr: Postpone default window creation" added
> an additional exit to the VFIO_IOMMU_SPAPR_TCE_CREATE case and made it
> possible to return from tce_iommu_ioctl() without unlocking
> container->lock; this fixes the issue.
> 
> Fixes: d9c728949ddc
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applies to for-linus branch for v4.10-rc7 w/ David's R-b.  Thanks,

Alex
 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 128d10282d16..7690e5bf3cf1 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1123,12 +1123,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		mutex_lock(&container->lock);
>  
>  		ret = tce_iommu_create_default_window(container);
> -		if (ret)
> -			return ret;
> -
> -		ret = tce_iommu_create_window(container, create.page_shift,
> -				create.window_size, create.levels,
> -				&create.start_addr);
> +		if (!ret)
> +			ret = tce_iommu_create_window(container,
> +					create.page_shift,
> +					create.window_size, create.levels,
> +					&create.start_addr);
>  
>  		mutex_unlock(&container->lock);
>  
