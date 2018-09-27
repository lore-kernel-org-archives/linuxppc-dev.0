Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ldzq4H0yzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 01:30:31 +1000 (AEST)
Date: Thu, 27 Sep 2018 17:30:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Message-ID: <20180927153028.GD10566@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
 <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>>   +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 
>> dma_mask,
>> +		u64 *phys_mask)
>> +{
>> +	if (force_dma_unencrypted())
>> +		*phys_mask = __dma_to_phys(dev, dma_mask);
>> +	else
>> +		*phys_mask = dma_to_phys(dev, dma_mask);
>
> Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we can 
> reuse it here?

This is a dma_to_phys and not a phys_to_dma.
