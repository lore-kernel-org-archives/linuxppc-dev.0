Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3D0BDDFC4
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 19:51:38 +1000 (EST)
Date: Fri, 23 May 2008 11:51:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <bgill@freescale.com>
Subject: Re: [RFC] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20080523095119.GA15722@lst.de>
References: <Pine.LNX.4.64.0804301815020.12768@monty.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804301815020.12768@monty.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 06:36:43PM -0500, Becky Bruce wrote:
> In addition, the dma_map/unmap_page functions are added to dma_ops on
> HIGHMEM-enabled configs because we can't just fall back on map/unmap_single
> when HIGHMEM is enabled.  Adding these to dma_ops makes it cleaner to
> substitute different functionality once we have iommu/swiotlb support.

Maybe I'm missing something but we should only have the page ones.
virt_to_page is cheap and we'll most likely need the phys address which
we get from the page anyway.

> There will be other patches that precede this one - I plan to duplicate 
> dma_mapping.h into include/asm-ppc to avoid breakage there.  There will 
> also be a patch to rename dma_64.c to dma.c, and a series of patches to 
> modify drivers that pass NULL dev pointers.

Note that NULL dev pointers are fine for the pci_ API and we need to
handle those.  But if you're talking about NULL dev pointers to the dma_
API yes, those should be fixed.

> +				   udbg.o misc.o io.o dma_64.o\

Whitespace before the \ please.

> +#ifdef CONFIG_PPC64
> +#include <asm/iommu.h>
> +
>  /*
>   * Generic iommu implementation
>   */
> @@ -108,6 +110,8 @@ struct dma_mapping_ops dma_iommu_ops = {
>  	.dma_supported	= dma_iommu_dma_supported,
>  };
>  EXPORT_SYMBOL(dma_iommu_ops);
> +#endif /* CONFIG_PPC64 */

This should probably be split into a dma_iommu.c file

> +#ifndef CONFIG_NOT_COHERENT_CACHE
>  static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  				       dma_addr_t *dma_handle, gfp_t flag)
>  {
The alloc_coherent ops probably should go into a dma-coherent.c file

> -	struct page *page;
>  	void *ret;
> -	int node = dev->archdata.numa_node;
> +	struct page *page;
> +	int node = -1;
> +#ifdef CONFIG_PPC64
> +	node = dev->archdata.numa_node;
> +#else

Please convert 64bit powerpc to use the numa_node field directly in
struct device and use the dev_to_node accessor.  That way it does
the right thing and we save a field per struct device instance.


> +	/* ignore region specifiers */
> +	flag  &= ~(__GFP_DMA | __GFP_HIGHMEM);
> +
> +	/* Bust slacker drivers that pass a NULL dev ptr */
> +	BUG_ON(dev == NULL);

These should be done for 64bit, too.

> +	if (dev->coherent_dma_mask < 0xffffffff)
> +		flag |= GFP_DMA;

This one probably aswell.

> +#else /* CONFIG_NOT_COHERENT_CACHE */
> +
> +static void *dma_direct_alloc_noncoherent(struct device *dev, size_t size,
> +				       dma_addr_t *dma_handle, gfp_t flag)
> +{
> +	return __dma_alloc_coherent(size, dma_handle, flag);
> +}
> +
> +static void dma_direct_free_noncoherent(struct device *dev, size_t size,
> +				     void *vaddr, dma_addr_t dma_handle)
> +{
> +	__dma_free_coherent(size, vaddr);
> +}
> +#endif /* CONFIG_NOT_COHERENT_CACHE */

Should probably go into dma-noncoherent.c

> @@ -180,20 +215,59 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
>  
>  static int dma_direct_dma_supported(struct device *dev, u64 mask)
>  {
> +#ifdef CONFIG_PPC64
>  	/* Could be improved to check for memory though it better be
>  	 * done via some global so platforms can set the limit in case
>  	 * they have limited DMA windows
>  	 */
>  	return mask >= DMA_32BIT_MASK;
> +#else
> +	return 1;
> +#endif

I think this depends on the dma ops and thus should be turned into one.
