Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Lf976xYnzDrJD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 01:38:35 +1000 (AEST)
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
 <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
 <20180927153028.GD10566@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2b98d7b2-bf74-ccc9-881a-a91e2c9949c3@arm.com>
Date: Thu, 27 Sep 2018 16:38:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180927153028.GD10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/09/18 16:30, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>>>    +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64
>>> dma_mask,
>>> +		u64 *phys_mask)
>>> +{
>>> +	if (force_dma_unencrypted())
>>> +		*phys_mask = __dma_to_phys(dev, dma_mask);
>>> +	else
>>> +		*phys_mask = dma_to_phys(dev, dma_mask);
>>
>> Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we can
>> reuse it here?
> 
> This is a dma_to_phys and not a phys_to_dma.

Ugh, clearly it's time to stop reviewing patches for today... sorry :(

Robin.
