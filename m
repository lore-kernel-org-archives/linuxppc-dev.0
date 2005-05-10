Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id D8D35679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 23:47:25 +1000 (EST)
Date: Tue, 10 May 2005 06:47:04 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20050510064702.B21835@cox.net>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
	<f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
	<20050510062744.A21835@cox.net> <4280B3CB.8030007@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4280B3CB.8030007@intracom.gr>;
	from panto@intracom.gr on Tue, May 10, 2005 at 04:14:51PM +0300
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 10, 2005 at 04:14:51PM +0300, Pantelis Antoniou wrote:
> Matt Porter wrote:
> > On Tue, May 10, 2005 at 08:13:48AM -0400, Dan Malek wrote:
> > 
> >>On May 10, 2005, at 7:17 AM, Pantelis Antoniou wrote:
> >>
> >>
> >>>This patch replace iopa use with virt_to_phys.
> >>
> >>Not gonna work .....
> >>
> >>When you map uncached on 8xx you get a new vmalloc()
> >>space.  The virt_to_xxx macros don't work on those addresses.
> >>You need to use the dma_consistent() function, stash the
> >>real physical address it returns and then use it where
> >>appropriate.
> > 
> > 
> > That and the use of virt_to_* and friends is deprecated by
> > the DMA API. You'll never get that upstream even if it were
> > a case where it did work.  That's a good thing to know for
> > anybody doing other drivers...
> > 
> > -Matt
> > 
> > 
> 
> OK then.
> 
> What's the recommended function to call to go from a
> virtual -> physical address, but without doing a cache
> flush/invalidate?

There is no generic function to do that in a driver since
no mainstream drivers in the kernel need to do it. Generally
you can rework the driver such that you cache the DMA address
as Dan suggested already.  I don't know your exact usage, however,
you can allocate memory with dma_alloc_noncoherent() that is
cached on ppc32 NOT_CACHE_COHERENT prcoessors and stash the
dma_addr_t/void * for later use. The other way is to kmalloc and
dma_map_single() (stashing the same way) which is basically the
same thing.

Do you have a case where this doesn't work?

-Matt
