Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 32F796862A
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 08:37:03 +1100 (EST)
Date: Sun, 30 Oct 2005 15:35:17 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051030213517.GA11327@pb15.lixom.net>
References: <1130645036.29054.229.camel@gaston>
	<20051030175956.GB7039@pb15.lixom.net>
	<1130706859.29054.283.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130706859.29054.283.camel@gaston>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bcm43xx-dev@lists.berlios.de
Subject: Re: 30 bits DMA and ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 31, 2005 at 08:14:18AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Keep in mind that those 16MB are cache inhibited. Not sure you'd want
> > that for the bounce buffer. And you can't map the same page as cacheable
> > or you'll end up in inconsistent state. I guess you could remap the 14MB
> > as 4K cacheable pages somewhere else.
> 
> Euh... I think that's exactly what we do :) We _unmap_ the 16Mb page
> from the linear mapping, and we remap a part of it using ioremap() (thus
> as 4k pages) in the DART driver... The remaining bits are thus not
> mapped at all, there is no problem using __ioremap() to get a cacheable
> mapping there.

Sure, that would work.

> > Some of the Infiniband and Myrinet adapters like to map as much as they
> > possibly can. I'm not sure what the likeliness of them being used on a
> > machine at the same time as one of these crippled devices is though.
> 
> Why would this be a problem ? The infiniband driver would hopefully have
> a sane dma_mask, and thus it's mapping requests wouldn't hit the swiotlb
> code path.

Not a problem, I was just thinking out loud. IOMMU pressure might be
higher on these systems than the average one, but there should still be
enough room.

> > Sounds reasonable to me too. I guess time will tell how hairy it gets,
> > implementation-wise. The implementation could also be nicely abstracted
> > away and isolated thanks to Stephen's per-device-dma-ops stuff.
> 
> Yes, though that's not strictly necessary. The dma_mask should be enough
> to tell us wether to use the normal code path or the swiotlb one. So if
> swiotlb is enabled, it could just be added to the normal code path for
> the non-iommu case.

The non-iommu case might want to do that for other devices as well,
i.e. 32-bit limited ones on 64-bit machines.

> For the iommu case, I'm not sure. I think we don't
> need bounce buffering. I could fairly easily have the DART code limit
> allocations to a given DMA mask. The TCE one may have more issues since
> the DMA window of a given slot may not fit the requirements, but in that
> case, it's probably just a matter of failing all mapping requests.

Yep, the table is already split once, and I'm not sure in retrospect how
useful that split was anyway, it can maybe go away. Switching it around
shouldn't be a big issue.


-Olof
