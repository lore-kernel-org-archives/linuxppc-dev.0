Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41J46G3FgTzF2Z7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jul 2018 05:56:53 +1000 (AEST)
Date: Sat, 30 Jun 2018 13:56:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Paul Mackerras
 <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 1/2] vfio/spapr: Use IOMMU pageshift rather
 than pagesize
Message-ID: <20180630135648.2e717432@t450s.home>
In-Reply-To: <20180626055926.27703-2-aik@ozlabs.ru>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-2-aik@ozlabs.ru>
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

On Tue, 26 Jun 2018 15:59:25 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The size is always equal to 1 page so let's use this. Later on this will
> be used for other checks which use page shifts to check the granularity
> of access.
> 
> This should cause no behavioral change.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I assume a v3+ will go in through the ppc tree since the bulk of the
series is there.  For this,

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 759a5bd..2da5f05 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -457,13 +457,13 @@ static void tce_iommu_unuse_page(struct tce_container *container,
>  }
>  
>  static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
> -		unsigned long tce, unsigned long size,
> +		unsigned long tce, unsigned long shift,
>  		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	long ret = 0;
>  	struct mm_iommu_table_group_mem_t *mem;
>  
> -	mem = mm_iommu_lookup(container->mm, tce, size);
> +	mem = mm_iommu_lookup(container->mm, tce, 1ULL << shift);
>  	if (!mem)
>  		return -EINVAL;
>  
> @@ -487,7 +487,7 @@ static void tce_iommu_unuse_page_v2(struct tce_container *container,
>  	if (!pua)
>  		return;
>  
> -	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl),
> +	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, tbl->it_page_shift,
>  			&hpa, &mem);
>  	if (ret)
>  		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
> @@ -611,7 +611,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
>  				entry + i);
>  
>  		ret = tce_iommu_prereg_ua_to_hpa(container,
> -				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
> +				tce, tbl->it_page_shift, &hpa, &mem);
>  		if (ret)
>  			break;
>  
