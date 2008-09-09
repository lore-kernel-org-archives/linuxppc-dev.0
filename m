Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04CFDDDF87
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 06:45:46 +1000 (EST)
Date: Tue, 9 Sep 2008 22:45:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20080909204534.GA30975@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<20080908220349.GD1175@lst.de>
	<10D78C52-1FF1-4944-8689-4404ABE98CA1@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10D78C52-1FF1-4944-8689-4404ABE98CA1@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 09:39:20AM -0500, Becky Bruce wrote:
> .... because you asked me to have just map/unmap_page in your review  
> of an earlier rev of this patch series in May? :)  I don't actually  
> expect you to remember this, because it was a long time ago, but  
> here's the relevant chunk of the conversation:
> 
> On May 23, 2008, at 4:51 AM, Christoph Hellwig wrote:
> 
> >On Wed, Apr 30, 2008 at 06:36:43PM -0500, Becky Bruce wrote:
> >>In addition, the dma_map/unmap_page functions are added to dma_ops on
> >>HIGHMEM-enabled configs because we can't just fall back on map/ 
> >>unmap_single
> >>when HIGHMEM is enabled.  Adding these to dma_ops makes it cleaner to
> >>substitute different functionality once we have iommu/swiotlb  
> >>support.
> >
> >Maybe I'm missing something but we should only have the page ones.
> >virt_to_page is cheap and we'll most likely need the phys address  
> >which
> >we get from the page anyway.
> 
> 
> So I did that for the dma_direct_* ops, but discovered that doing it  
> for the iommu case (which I can't test and don't fully understand)  
> would be a bit more complicated.  The above code (in conjunction with  
> the same code for map_page) allows you to have map/unmap_page, map/ 
> unmap_single, or both.  I'm happy to change it again, though.  We  
> could just do the above in map_page/unmap_page, calling map/ 
> unmap_single if there is no map/unmap_page, and provide both a  
> dma_direct_map/unmap_single and a dma_direct_map/unmap_page for the  
> dma_direct* ops.

Yeah, the statement this time should be why do you keep _single :)
It don't really mind which one we keep, but having both and both
optional seems rather odd.
