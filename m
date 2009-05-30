Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
	by ozlabs.org (Postfix) with ESMTP id BCBA6DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 23:02:37 +1000 (EST)
Subject: Re: [PATCH 8/9] swiotlb: support HIGHMEM in swiotlb_bus_to_virt
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4A20060C.2050701@goop.org>
References: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
	<1243586643-5554-9-git-send-email-ian.campbell@citrix.com>
	<4A20060C.2050701@goop.org>
Content-Type: text/plain
Date: Sat, 30 May 2009 14:02:27 +0100
Message-ID: <1243688547.4399.65.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-29 at 08:58 -0700, Jeremy Fitzhardinge wrote:
> Ian Campbell wrote:

> > -void * __weak swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
> > +#ifdef CONFIG_HIGHMEM
> > +static void * swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
> >   
> 
> I think it would be better to put the #ifdef within the function body so 
> that there's no chance of prototype-drift.

Yes, good idea.

> > +{
> > +	unsigned long pfn = PFN_DOWN(dma_to_phys(hwdev, addr));
> > +	void *pageaddr = page_address(pfn_to_page(pfn));
> > +
> > +	if (pageaddr != NULL)
> > +		return pageaddr + (addr % PAGE_SIZE);
> >   
> Is there an arch-independent test to see if a pfn is considered highmem 
> or not (which returns a constant on non-highmem configurations)?  If so, 
> then I think this could be common without having to go via a struct page.

I'm not aware of a way apart from PageHighMem -- which needs the struct
page. Highmem is a property of the zone, I think, so you have to go
through the struct page back to the zone to find out if it is high or
not.

At first glance it looks like many of the callers of bus_to_virt
eventually end up in swiotlb_bounce which converts to a struct page
anyway. I'll take a look next week whether it makes any sense to go to
struct page further up the call chain and pass that around instead.

Ian.
