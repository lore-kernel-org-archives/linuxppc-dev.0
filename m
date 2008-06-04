Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54297DDF3F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 10:07:42 +1000 (EST)
In-Reply-To: <20080523095119.GA15722@lst.de>
References: <Pine.LNX.4.64.0804301815020.12768@monty.am.freescale.net>
	<20080523095119.GA15722@lst.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0834F441-4BB3-46C5-A505-A579B10A7A7F@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [RFC] POWERPC: Merge 32 and 64-bit dma code
Date: Tue, 3 Jun 2008 19:10:51 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 4:51 AM, Christoph Hellwig wrote:

> On Wed, Apr 30, 2008 at 06:36:43PM -0500, Becky Bruce wrote:
>> In addition, the dma_map/unmap_page functions are added to dma_ops on
>> HIGHMEM-enabled configs because we can't just fall back on map/ 
>> unmap_single
>> when HIGHMEM is enabled.  Adding these to dma_ops makes it cleaner to
>> substitute different functionality once we have iommu/swiotlb  
>> support.
>
> Maybe I'm missing something but we should only have the page ones.
> virt_to_page is cheap and we'll most likely need the phys address  
> which
> we get from the page anyway.

Thanks for taking the time to review this!  My apologies for the slow  
response - I just returned from a couple of weeks of being off-line  
on vacation.

If I understand your comment correctly, you're asking me to drop map/ 
unmap_single from the dma_ops, and change dma_map_single() to do  
virt_to_page() on the address, and then call dma_ops->map_page()?   
I'll look into doing that.  It sounds like it might be cleaner.

>> There will be other patches that precede this one - I plan to  
>> duplicate
>> dma_mapping.h into include/asm-ppc to avoid breakage there.  There  
>> will
>> also be a patch to rename dma_64.c to dma.c, and a series of  
>> patches to
>> modify drivers that pass NULL dev pointers.
>
> Note that NULL dev pointers are fine for the pci_ API and we need to
> handle those.  But if you're talking about NULL dev pointers to the  
> dma_
> API yes, those should be fixed.

I was talking about the DMA API, but I will double-check that I  
haven't overlooked something here.

>
>> +				   udbg.o misc.o io.o dma_64.o\
>
> Whitespace before the \ please.

Will fix....

>
>> +#ifdef CONFIG_PPC64
>> +#include <asm/iommu.h>
>> +
>>  /*
>>   * Generic iommu implementation
>>   */
>> @@ -108,6 +110,8 @@ struct dma_mapping_ops dma_iommu_ops = {
>>  	.dma_supported	= dma_iommu_dma_supported,
>>  };
>>  EXPORT_SYMBOL(dma_iommu_ops);
>> +#endif /* CONFIG_PPC64 */
>
> This should probably be split into a dma_iommu.c file

I'm happy to do that, unless any of the 64B guys have some objection.

>
>> +#ifndef CONFIG_NOT_COHERENT_CACHE
>>  static void *dma_direct_alloc_coherent(struct device *dev, size_t  
>> size,
>>  				       dma_addr_t *dma_handle, gfp_t flag)
>>  {
> The alloc_coherent ops probably should go into a dma-coherent.c file

Agreed.

>
>> -	struct page *page;
>>  	void *ret;
>> -	int node = dev->archdata.numa_node;
>> +	struct page *page;
>> +	int node = -1;
>> +#ifdef CONFIG_PPC64
>> +	node = dev->archdata.numa_node;
>> +#else
>
> Please convert 64bit powerpc to use the numa_node field directly in
> struct device and use the dev_to_node accessor.  That way it does
> the right thing and we save a field per struct device instance.

I'm also happy to do that (and your next couple of suggestions) if  
it's OK with the 64b folks  I was trying to mess with the 64B code as  
little as possible, since I have no means of testing it.

>
>
>> +	/* ignore region specifiers */
>> +	flag  &= ~(__GFP_DMA | __GFP_HIGHMEM);
>> +
>> +	/* Bust slacker drivers that pass a NULL dev ptr */
>> +	BUG_ON(dev == NULL);
>
> These should be done for 64bit, too.
>
>> +	if (dev->coherent_dma_mask < 0xffffffff)
>> +		flag |= GFP_DMA;
>
> This one probably aswell.
>
>> +#else /* CONFIG_NOT_COHERENT_CACHE */
>> +
>> +static void *dma_direct_alloc_noncoherent(struct device *dev,  
>> size_t size,
>> +				       dma_addr_t *dma_handle, gfp_t flag)
>> +{
>> +	return __dma_alloc_coherent(size, dma_handle, flag);
>> +}
>> +
>> +static void dma_direct_free_noncoherent(struct device *dev,  
>> size_t size,
>> +				     void *vaddr, dma_addr_t dma_handle)
>> +{
>> +	__dma_free_coherent(size, vaddr);
>> +}
>> +#endif /* CONFIG_NOT_COHERENT_CACHE */
>
> Should probably go into dma-noncoherent.c

Right-o.

>
>> @@ -180,20 +215,59 @@ static void dma_direct_unmap_sg(struct  
>> device *dev, struct scatterlist *sg,
>>
>>  static int dma_direct_dma_supported(struct device *dev, u64 mask)
>>  {
>> +#ifdef CONFIG_PPC64
>>  	/* Could be improved to check for memory though it better be
>>  	 * done via some global so platforms can set the limit in case
>>  	 * they have limited DMA windows
>>  	 */
>>  	return mask >= DMA_32BIT_MASK;
>> +#else
>> +	return 1;
>> +#endif
>
> I think this depends on the dma ops and thus should be turned into  
> one.

dma_supported *is* part of dma_ops.  Am I misunderstanding your comment?

Thanks!  I hope to have an updated version out in week or two - I'm  
in the middle of debugging the conglomeration of this patch, swiotlb,  
and 36-bit physical addressing support on 32bit powerpc right now,  
but as soon as I have that marginally working, I'm going to start  
cleaning up the pieces and pushing them out to get more eyeballs on  
them.

-Becky
