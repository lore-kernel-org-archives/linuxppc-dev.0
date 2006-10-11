Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B4DC067BB7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 01:51:46 +1000 (EST)
Message-ID: <452D1223.4090403@am.sony.com>
Date: Wed, 11 Oct 2006 08:47:47 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
References: <20061010204946.GW4381@austin.ibm.com>
	<20061010212324.GR4381@austin.ibm.com>
	<452C2AAA.5070001@austin.ibm.com> <452C4CE0.5010607@am.sony.com>
	<20061011152016.GU4381@austin.ibm.com>
In-Reply-To: <20061011152016.GU4381@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: akpm@osdl.org, jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Tue, Oct 10, 2006 at 06:46:08PM -0700, Geoff Levand wrote:
>> > Linas Vepstas wrote:
>> >> The current driver code performs 512 DMA mappns of a bunch of 
>> >> 32-byte structures. This is silly, as they are all in contiguous 
>> >> memory. Ths patch changes the code to DMA map the entie area
>> >> with just one call.
>> 
>> Linas, 
>> 
>> Is the motivation for this change to improve performance by reducing the overhead
>> of the mapping calls?  
> 
> Yes.
> 
>> If so, there may be some benefit for some systems.  Could
>> you please elaborate?
> 
> I started writingthe patch thinking it will have some huge effect on
> performance, based on a false assumption on how i/o was done on this
> machine
> 
> *If* this were another pSeries system, then each call to 
> pci_map_single() chews up an actual hardware "translation 
> control entry" (TCE) that maps pci bus addresses into 
> system RAM addresses. These are somewhat limited resources,
> and so one shouldn't squander them.  Furthermore, I thouhght
> TCE's have TLB's associated with them (similar to how virtual
> memory page tables are backed by hardware page TLB's), of which 
> there are even less of. I was thinking that TLB thrashing would 
> have a big hit on performance. 
> 
> Turns out that there was no difference to performance at all, 
> and a quick look at "cell_map_single()" in arch/powerpc/platforms/cell
> made it clear why: there's no fancy i/o address mapping.

OK, thanks for the explanation.  Actually, the current cell DMA mapping
implementation uses a simple 'linear' mapping, in that, all of RAM is
mapped into the bus DMA address space at once, and in fact, it is all
just done at system startup.

There is ongoing work to implement 'dynamic' mapping, where DMA pages are
mapped into the bus DMA address space on demand.  I think a key point to
understand the benefit to this is that the cell processor's I/O controller
maps pages per device, so you can map one DMA page to one device.  I
currently have this working for my platform, but have not released that
work.  There is some overhead to managing the mapped buffers and to request
pages be mapped by the hypervisor, etc., so I was thinking that is this work
of yours to consolidate the memory buffers prior to requesting the mapping
could be of benefit if it was in an often executed code path.

-Geoff
