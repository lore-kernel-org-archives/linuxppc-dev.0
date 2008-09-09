Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 622D4DDF53
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 00:39:35 +1000 (EST)
Message-Id: <10D78C52-1FF1-4944-8689-4404ABE98CA1@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080908220349.GD1175@lst.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
Date: Tue, 9 Sep 2008 09:39:20 -0500
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<20080908220349.GD1175@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2008, at 5:03 PM, Christoph Hellwig wrote:

>> -	if (unlikely(dev == NULL || dev->archdata.dma_ops == NULL))
>> +
>> +	if (unlikely(dev == NULL) || dev->archdata.dma_ops == NULL) {
>> +#ifdef CONFIG_PPC64
>> 		return NULL;
>> +#else
>> +		/* Use default on 32-bit if dma_ops is not set up */
>> +		return &dma_direct_ops;
>> +#endif
>> +	}
>> +
>
> This is okay for the transition, but I think long-term it should
> be setup for all busses.

Agreed!

>
>
>> }
>>
>> @@ -132,7 +154,14 @@ static inline dma_addr_t  
>> dma_map_single_attrs(struct device *dev,
>> 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>>
>> 	BUG_ON(!dma_ops);
>> -	return dma_ops->map_single(dev, cpu_addr, size, direction, attrs);
>> +
>> +	if (dma_ops->map_single)
>> +		return dma_ops->map_single(dev, cpu_addr, size, direction,
>> +					   attrs);
>> +
>> +	return dma_ops->map_page(dev, virt_to_page(cpu_addr),
>> +				 (unsigned long)cpu_addr % PAGE_SIZE, size,
>> +				 direction, attrs);
>
> Why would a dma ops implementation not provide map_single/ 
> unmap_single?

.... because you asked me to have just map/unmap_page in your review  
of an earlier rev of this patch series in May? :)  I don't actually  
expect you to remember this, because it was a long time ago, but  
here's the relevant chunk of the conversation:

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


So I did that for the dma_direct_* ops, but discovered that doing it  
for the iommu case (which I can't test and don't fully understand)  
would be a bit more complicated.  The above code (in conjunction with  
the same code for map_page) allows you to have map/unmap_page, map/ 
unmap_single, or both.  I'm happy to change it again, though.  We  
could just do the above in map_page/unmap_page, calling map/ 
unmap_single if there is no map/unmap_page, and provide both a  
dma_direct_map/unmap_single and a dma_direct_map/unmap_page for the  
dma_direct* ops.

Thanks for taking the time to review - I appreciate it!
-Becky
