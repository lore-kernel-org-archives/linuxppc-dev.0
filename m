Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 093B81A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 10:36:53 +1100 (AEDT)
Message-ID: <1426030609.25026.88.camel@redhat.com>
Subject: Re: [PATCH v5 07/29] vfio: powerpc/spapr: Moving pinning/unpinning
 to helpers
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 10 Mar 2015 17:36:49 -0600
In-Reply-To: <1425910045-26167-8-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
 <1425910045-26167-8-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-10 at 01:07 +1100, Alexey Kardashevskiy wrote:
> This is a pretty mechanical patch to make next patches simpler.
> 
> New tce_iommu_unuse_page() helper does put_page() now but it might skip
> that after the memory registering patch applied.
> 
> As we are here, this removes unnecessary checks for a value returned
> by pfn_to_page() as it cannot possibly return NULL.
> 
> This moves tce_iommu_disable() later to let tce_iommu_clear() know if
> the container has been enabled because if it has not been, then
> put_page() must not be called on TCEs from the TCE table. This situation
> is not yet possible but it will after KVM acceleration patchset is
> applied.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 70 ++++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index d3ab34f..ca396e5 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -204,7 +204,6 @@ static void tce_iommu_release(void *iommu_data)
>  	struct iommu_table *tbl = container->tbl;
>  
>  	WARN_ON(tbl && !tbl->it_group);
> -	tce_iommu_disable(container);
>  
>  	if (tbl) {
>  		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
> @@ -212,63 +211,102 @@ static void tce_iommu_release(void *iommu_data)
>  		if (tbl->it_group)
>  			tce_iommu_detach_group(iommu_data, tbl->it_group);
>  	}
> +
> +	tce_iommu_disable(container);
> +
>  	mutex_destroy(&container->lock);
>  
>  	kfree(container);
>  }
>  
> +static void tce_iommu_unuse_page(struct tce_container *container,
> +		unsigned long oldtce)
> +{
> +	struct page *page;
> +
> +	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
> +		return;
> +
> +	/*
> +	 * VFIO cannot map/unmap when a container is not enabled so
> +	 * we would not need this check but KVM could map/unmap and if
> +	 * this happened, we must not put pages as KVM does not get them as
> +	 * it expects memory pre-registation to do this part.
> +	 */
> +	if (!container->enabled)
> +		return;
> +
> +	page = pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
> +
> +	if (oldtce & TCE_PCI_WRITE)
> +		SetPageDirty(page);
> +
> +	put_page(page);
> +}
> +
>  static int tce_iommu_clear(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long pages)
>  {
>  	unsigned long oldtce;
> -	struct page *page;
>  
>  	for ( ; pages; --pages, ++entry) {
>  		oldtce = iommu_clear_tce(tbl, entry);
>  		if (!oldtce)
>  			continue;
>  
> -		page = pfn_to_page(oldtce >> PAGE_SHIFT);
> -		WARN_ON(!page);
> -		if (page) {
> -			if (oldtce & TCE_PCI_WRITE)
> -				SetPageDirty(page);
> -			put_page(page);
> -		}
> +		tce_iommu_unuse_page(container, (unsigned long) __va(oldtce));
>  	}
>  
>  	return 0;
>  }
>  
> +static unsigned long tce_get_hva(struct tce_container *container,
> +		unsigned page_shift, unsigned long tce)
> +{
> +	long ret;
> +	struct page *page = NULL;
> +	unsigned long hva;
> +	enum dma_data_direction direction = iommu_tce_direction(tce);
> +
> +	ret = get_user_pages_fast(tce & PAGE_MASK, 1,
> +			direction != DMA_TO_DEVICE, &page);
> +	if (unlikely(ret != 1))
> +		return -1;
> +
> +	hva = (unsigned long) page_address(page);
> +
> +	return hva;
> +}


It's a bit crude to return -1 for an unsigned long function.  You might
want to later think about cleaning this up to return int with a proper
error code and return hva via a pointer.  We don't really need to store
'ret' here either.

> +
>  static long tce_iommu_build(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long tce, unsigned long pages)
>  {
>  	long i, ret = 0;
> -	struct page *page = NULL;
> +	struct page *page;
>  	unsigned long hva;
>  	enum dma_data_direction direction = iommu_tce_direction(tce);
>  
>  	for (i = 0; i < pages; ++i) {
> -		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
> -				direction != DMA_TO_DEVICE, &page);
> -		if (unlikely(ret != 1)) {
> +		hva = tce_get_hva(container, tbl->it_page_shift, tce);
> +		if (hva == -1) {
>  			ret = -EFAULT;
>  			break;
>  		}
>  
> +		page = pfn_to_page(__pa(hva) >> PAGE_SHIFT);
>  		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
>  			ret = -EPERM;
>  			break;
>  		}
>  
> -		hva = (unsigned long) page_address(page) +
> -			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
> +		/* Preserve offset within IOMMU page */
> +		hva |= tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
>  
>  		ret = iommu_tce_build(tbl, entry + i, hva, direction);
>  		if (ret) {
> -			put_page(page);
> +			tce_iommu_unuse_page(container, hva);
>  			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
