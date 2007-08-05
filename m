Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 990EDDDE10
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 08:04:30 +1000 (EST)
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce 32bit
	DMA	mapping"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <46B5824B.1000103@s5r6.in-berlin.de>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca>  <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Mon, 06 Aug 2007 08:04:33 +1000
Message-Id: <1186351473.938.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	stable@kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-08-05 at 09:54 +0200, Stefan Richter wrote:
> Benjamin Herrenschmidt wrote:
> >>> If setting 32-bit DMA mask fails on ppc64, that sounds like a problem
> >>> with the DMA implementation on that architecture. There are enough cards
> >>> out there that only support 32-bit DMA that this really needs to work..
> >> Yes, could the PPC folks please have a look at it?  Thanks.
> > 
> > Smells like we may have a bug there. No worries though, all current PPC
> > machines have an iommu that will not give out addresses above 32 bits
> > anyway, but I'll double check what's up.
> > 
> > Do you see something in dmesg when that happens ?
> 
> There was nothing in Olaf's report, except for trouble in sbp2 _after_
> the failure.  http://lkml.org/lkml/2007/8/1/344  (I don't have a PMac.)

Hrm, allright, that's a bit weird. Olaf machine has only 256M of RAM
according to that dmesg, and thus, the kernel isn't enabling the iommu,
we use the "trivial" version of the dma mapping ops.

I suspect we have a bug in our imlementation of set_dma_mask though, in
that it does the "dma_supported" check using the previous mask and not
the one passed in :-)

The implementation of dma_supported that we hit in the no-iommu case
looks like that:

static int dma_direct_dma_supported(struct device *dev, u64 mask)
{
	/* Could be improved to check for memory though it better be
	 * done via some global so platforms can set the limit in case
	 * they have limited DMA windows
	 */
	return mask >= DMA_32BIT_MASK;
}

So that should have worked. (The comment is a bit obscure, just ignore
it for now).

However, as I said above, our dma_set_mask() wrapper uses the wrong
value (the old, not the new mask). But that still should have worked
since the default dma mask for a PCI device is 0xffffffff....

Thus at this stable, I'm a bit at a loss of why it didn't work, I'll
have to test on one of those machines with some printk's in when I
manage to get to work (dunno when, kid's sick so I may have to stay home
today).

BTW. Any reason why you don't set the DMA mask in the ohci driver rather
than the sbp2 one ?

Cheers,
Ben.
