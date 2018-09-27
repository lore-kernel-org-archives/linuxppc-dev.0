Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42LfzC2lLKzF371
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 02:15:01 +1000 (AEST)
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-5-hch@lst.de>
 <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
 <20180927153252.GE10566@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
Date: Thu, 27 Sep 2018 17:14:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180927153252.GE10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/09/18 16:32, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:58:04PM +0100, Robin Murphy wrote:
>>>    }
>>>    #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>>>    diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 3c404e33d946..64466b7ef67b 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -43,10 +43,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>>>    			return false;
>>>    		}
>>>    -		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
>>> +		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
>>
>> Hmm... say *dev->dma_mask is 31 bits and dev->bus_dma_mask is 40 bits due
>> to a global DT property, we'll now scream where we didn't before even
>> though the bus mask is almost certainly irrelevant - is that desirable?
> 
> This is just the reporting in the error case - we'll only hit this
> IFF dma_capable already returned false.  But if you don't want a message
> here we can probably drop this hunk.

It was only a question of consistency - whatever the reason was to avoid 
warning for small device masks before, it's not obvious why it wouldn't 
still apply in the presence of nonzero but larger bus mask. The fact 
that the current check is there at all implied to me that we're 
expecting less-capable device to hit this often and thus wanted to avoid 
being noisy. If that's not the case then it's fine as-is AFAIC.

>>> @@ -65,12 +66,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
>>>    {
>>>    	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>>>    +	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
>>> +		max_dma = dev->bus_dma_mask;
>>
>> Again, I think we could just do another min_not_zero() here. A device wired
>> to address only one single page of RAM isn't a realistic prospect (and we
>> could just flip the -1 and the shift in the max_dma calculation if we
>> *really* wanted to support such things).
> 
> This just seemed more readable to me than min_not_zero, but if others
> prefer min_not_zero I can switch.

Nah, just checking whether there were any intentionally different 
assumptions compared to the couple of other places in the patch where 
min_not_zero() *is* used. If it's purely a style thing then no worries 
(personally I'd have written it yet another way anyway).

Robin.
