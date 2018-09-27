Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42LdTl2nbvzF36p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 01:07:54 +1000 (AEST)
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory
 size
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-6-hch@lst.de>
 <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
 <20180927134954.GB8281@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7a34c74f-7c83-84bb-441b-a729adce2beb@arm.com>
Date: Thu, 27 Sep 2018 16:07:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180927134954.GB8281@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ oops, I should have looked at the replies first, now I see Ben already 
had the same thing to say about #3... ]

On 27/09/18 14:49, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 11:50:14AM +1000, Benjamin Herrenschmidt wrote:
>>> -	 * to be able to satisfy them - either by not supporting more physical
>>> -	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>>> -	 * architecture needs to use an IOMMU instead of the direct mapping.
>>> -	 */
>>> -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
>>> +	u64 min_mask;
>>> +
>>> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
>>> +		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
>>> +	else
>>> +		min_mask = min_t(u64, DMA_BIT_MASK(32),
>>> +				 (max_pfn - 1) << PAGE_SHIFT);
>>> +
>>> +	if (mask >= phys_to_dma(dev, min_mask))
>>>   		return 0;
>>
>> nitpick ... to be completely "correct", I would have written
>>
>> 	if (IS_ENABLED(CONFIG_ZONE_DMA))
>> 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
>> 	else
>> 		min_mask = DMA_BIT_MASK(32);
>>
>> 	min_mask = min_t(u64, min_mask,	(max_pfn - 1) << PAGE_SHIFT);
>>
>> In "theory" it's also ok to have a mask < ZONE_DMA_BITS as long as it's
>> big enough to fit all memory :-)
> 
> Yeah, we could do that.

FWIW I like it even if just for looking slightly more readable. With 
that fixup,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
