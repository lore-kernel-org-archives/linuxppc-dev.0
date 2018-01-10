Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zGwL3212bzDqmy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 04:02:34 +1100 (AEDT)
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
 linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>, Guan Xuetao
 <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-11-hch@lst.de>
 <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
 <20180110154649.GA18529@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
Date: Wed, 10 Jan 2018 17:02:30 +0000
MIME-Version: 1.0
In-Reply-To: <20180110154649.GA18529@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/18 15:46, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 12:22:18PM +0000, Robin Murphy wrote:
>>> +	if (phys_addr == SWIOTLB_MAP_ERROR)
>>> +		goto out_warn;
>>>    -		/* Confirm address can be DMA'd by device */
>>> -		if (dev_addr + size - 1 > dma_mask) {
>>> -			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
>>> -			       (unsigned long long)dma_mask,
>>> -			       (unsigned long long)dev_addr);
>>> +	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
>>
>> nit: this should probably go after the dma_coherent_ok() check (as with the
>> original logic).
> 
> But the originall logic also needs the dma_addr_t for the
> dma_coherent_ok check:
> 
> 		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
> 		/* Confirm address can be DMA'd by device */
> 		if (dev_addr + size - 1 > dma_mask) {
> 			...
> 			goto err_warn;
> 		}
> 
> or do you mean assining to *dma_handle?  The dma_handle is not
> valid for a failure return, so I don't think this should matter.

Yeah, only the assignment - as I said, it's just a stylistic nit; no big 
deal either way.

>>> +	if (ret) {
>>> +		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
>>> +		if (dma_coherent_ok(hwdev, *dma_handle, size)) {
>>> +			memset(ret, 0, size);
>>> +			return ret;
>>> +		}
>>
>> Aren't we leaking the pages here?
> 
> Yes, that free_pages got lost somewhere in the rebases, I've added
> it back.

Cool.

Robin.
