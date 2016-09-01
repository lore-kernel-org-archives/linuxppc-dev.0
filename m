Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQ3Tl4llWzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 23:47:23 +1000 (AEST)
Date: Thu, 1 Sep 2016 15:39:37 +0200
From: Torsten Duwe <duwe@lst.de>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, jthumshirn@suse.com
Subject: Re: [PATCH] powerpc: add kernel parameter iommu_alloc_quiet
Message-ID: <20160901133937.GA8644@lst.de>
References: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 01, 2016 at 09:56:42AM -0300, Mauricio Faria de Oliveira wrote:
> This patch introduces the 'iommu_alloc_quiet=driver_name' parameter
> to suppress the 'iommu_alloc failures' messages for that one driver.
> 
> This is an additional approach for this 'problem' of flooding logs,
> not as fine-grained and not enabled by default as DMA_ATTR_NO_WARN,
> but it has the advantage that it doesn't introduce any ABI changes.
> 
> That is important/requirement for the distribution kernels - where
> the DMA_ATTR_NO_WARN changes to 'enum dma_attr' are not acceptable
> because it breaks the kernel ABI.
> 
[...]
> @@ -479,8 +496,8 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
>  
>  		/* Handle failure */
>  		if (unlikely(entry == DMA_ERROR_CODE)) {
> -			if (!(attrs & DMA_ATTR_NO_WARN) &&
> -			    printk_ratelimit())
> +			if (strncmp(iommu_alloc_quiet, dev->driver->name, IOMMU_ALLOC_QUIET_LEN) &&
> +			    !(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>  				dev_info(dev, "iommu_alloc failed, tbl %p "
>  					 "vaddr %lx npages %lu\n", tbl, vaddr,
>  					 npages);
> @@ -777,8 +794,8 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
>  					 mask >> tbl->it_page_shift, align,
>  					 attrs);
>  		if (dma_handle == DMA_ERROR_CODE) {
> -			if (!(attrs & DMA_ATTR_NO_WARN) &&
> -			    printk_ratelimit())  {
> +			if (strncmp(iommu_alloc_quiet, dev->driver->name, IOMMU_ALLOC_QUIET_LEN) &&
> +			    !(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
>  				dev_info(dev, "iommu_alloc failed, tbl %p "
>  					 "vaddr %p npages %d\n", tbl, vaddr,
>  					 npages);

JFYI, my strongly preferred solution would still be to just dev_dbg() the whole thing.
Which group of people would be interested in these messages, after all?

	Torsten
