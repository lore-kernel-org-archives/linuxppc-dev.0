Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LdxL2zknzF35n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 01:28:21 +1000 (AEST)
Date: Thu, 27 Sep 2018 17:28:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] dma-direct: add an explicit
 dma_direct_get_required_mask
Message-ID: <20180927152818.GC10566@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-3-hch@lst.de>
 <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2018 at 03:12:25PM +0100, Robin Murphy wrote:
>> +u64 dma_direct_get_required_mask(struct device *dev)
>> +{
>> +	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>> +
>> +	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>
> I think that may as well just use __fls64() - it seems reasonable to assume 
> max_dma > 0. Otherwise,

Is there any good reason to micro-optimize given that this isn't
a fast path?
