Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 98AD26863A
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 05:00:37 +1100 (EST)
Date: Sun, 30 Oct 2005 11:59:56 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051030175956.GB7039@pb15.lixom.net>
References: <1130645036.29054.229.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130645036.29054.229.camel@gaston>
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

On Sun, Oct 30, 2005 at 03:03:55PM +1100, Benjamin Herrenschmidt wrote:

> However, what I can do is have the architecture code reserve a pool of
> memory at boot if the machine main RAM is bigger than 1Gb, to use for
> bounce-buffering. On the G5 with more than 2Gb, this is even easier
> since I already have to blow away a 16Mb page for use by the IOMMU, but
> the IOMMU only uses 2Mb in there, so I have about 14Mb that I could
> re-use for that. On 32 bits machine, I can just reserve something early
> during boot.

Keep in mind that those 16MB are cache inhibited. Not sure you'd want
that for the bounce buffer. And you can't map the same page as cacheable
or you'll end up in inconsistent state. I guess you could remap the 14MB
as 4K cacheable pages somewhere else.

> Now, how to actually make use of that pool. One way is to hack something
> specific inside the bcm43xx driver. The pool can then be easily cut in
> regions: the descriptor rings buffers, and 2 pools, one for Rx and one
> for Tx. The allocation inside of those pools can be done as simple ring
> buffer too due to the inherently ordered processing of packets.
> 
> However, the above would require arch specific hacks, and would only
> work for one card in the system (too bad if you plug a cardbus one).
> 
> Another possibility that might be more interesting is to use swiotlb.
> This is a somewhat generic bounce-buffering implementation of the DMA
> mapping routines that is used by ia64 and x86_64 when no IOMMU is
> available. It will automatically do nothing if the address fits the DMA
> mask so it shouldn't add much overhead to other drivers and would "make
> things work" transparently. In addition, for G5s with more than 2Gb of
> RAM (which have an iommu), I could modify the iommu code to take into
> account the DMA mask when allocating DMA virtual space. (The later would
> have a slight risk of failure, but I doubt it will happen in practice,
> as it would mean one has more than 1Gb of pending DMA at a given point
> in time).

Some of the Infiniband and Myrinet adapters like to map as much as they
possibly can. I'm not sure what the likeliness of them being used on a
machine at the same time as one of these crippled devices is though.
Besides, they usually back off a bit from allocating everything in the
system, so there should be some room.

> I tend to prefer the later solution ...

Sounds reasonable to me too. I guess time will tell how hairy it gets,
implementation-wise. The implementation could also be nicely abstracted
away and isolated thanks to Stephen's per-device-dma-ops stuff.


-Olof
