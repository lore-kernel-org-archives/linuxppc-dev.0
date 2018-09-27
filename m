Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42LgZ11qvQzF35g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 02:41:43 +1000 (AEST)
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
 <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
 <20180927162737.GA11974@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b87ef7ac-81fc-c649-7ffb-73017ec99790@arm.com>
Date: Thu, 27 Sep 2018 17:41:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180927162737.GA11974@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/09/18 17:27, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 05:14:56PM +0100, Robin Murphy wrote:
>>> This just seemed more readable to me than min_not_zero, but if others
>>> prefer min_not_zero I can switch.
>>
>> Nah, just checking whether there were any intentionally different
>> assumptions compared to the couple of other places in the patch where
>> min_not_zero() *is* used. If it's purely a style thing then no worries
>> (personally I'd have written it yet another way anyway).
> 
> I'm curious: how would you have written it?

Come to think of it, I actually already have, in iommu-dma:

	if (dev->bus_dma_mask)
		mask &= dev->bus_dma_mask;

but of course it's not so pretty for those cases where you don't already 
have the local variable ready to go.

Robin.
