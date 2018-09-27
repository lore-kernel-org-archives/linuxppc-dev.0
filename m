Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Lf5Y6WthzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 01:35:28 +1000 (AEST)
Subject: Re: [PATCH 2/5] dma-direct: add an explicit
 dma_direct_get_required_mask
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-3-hch@lst.de>
 <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
 <20180927152818.GC10566@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9ce1c62-9e89-dc73-68e8-4e3025b5725f@arm.com>
Date: Thu, 27 Sep 2018 16:35:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180927152818.GC10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/09/18 16:28, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:12:25PM +0100, Robin Murphy wrote:
>>> +u64 dma_direct_get_required_mask(struct device *dev)
>>> +{
>>> +	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>>> +
>>> +	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>>
>> I think that may as well just use __fls64() - it seems reasonable to assume
>> max_dma > 0. Otherwise,
> 
> Is there any good reason to micro-optimize given that this isn't
> a fast path?

Not at all, I wasn't even thinking in terms of optimisation other than 
in terms of number of source characters and levels of parentheses.

But more importantly I was also being a big idiot because no matter how 
much I have the fls()/__fls() thing in mind, __fls64() doesn't actually 
exist. Nitpick rescinded!

Robin.
