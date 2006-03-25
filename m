Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10C7367A63
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 11:20:41 +1100 (EST)
Subject: RE: memory with __get_free_pages and disabling caching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
In-Reply-To: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 11:20:34 +1100
Message-Id: <1143246035.3710.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-03-24 at 15:44 -0800, Kallol Biswas wrote:
> Thank you.
> 
> I wonder how consistent ptes are used if all kernel memory is mapped with large tlb.
> In the __dma_alloc_coherent() routine pages are allocated with alloc_pages(), new virtual address is created in consistent region,
> then consistent ptes are populated. Looks like that the routine creates a new virtual mapping. The memory is addressed with the new address. 
> 
> Do we have two mappings in the TLB for the same physical address?

Yes, it seems like we do... the consistent DMA stuff assumes that is
safe to do, which is not the case on 6xx CPUs but might be on 4xx.

> When I find it out, I will do a posting. 
> 
> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> Sent: Friday, March 24, 2006 2:31 PM
> To: Kallol Biswas
> Cc: linuxppc-dev@ozlabs.org
> Subject: RE: memory with __get_free_pages and disabling caching
> 
> On Fri, 2006-03-24 at 11:13 -0800, Kallol Biswas wrote:
> > We have a little endian device on a PPC 440GX based system.
> > The descriptors need to be swapped. With E bit turned on we can save swapping time.
> > 
> > May be all the pages with _get_free_page already are mapped with large tlb entry.
> > 
> > How about making a window (ptes) like consistent memory?
> 
> If you allocate with consistent allocator on 4xx, you should be able to hack the PTEs to set the E bit, but I think it's not necessary. We've been swapping descriptor for ages without any noticeable performance loss since pretty much all network devices have little endian descriptor rings :) Look into using the {ld,st}_le{16,32} inlines, they use the native swapped load/store instructions of the CPU to store things in little endian format. They shouldn't cost more or at least not significantly more than normal load/stores.
> 
> Ben.
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: Thursday, March 23, 2006 7:06 PM
> > To: Kallol Biswas
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: memory with __get_free_pages and disabling caching
> > 
> > On Thu, 2006-03-23 at 18:15 -0800, Kallol Biswas wrote:
> > > Hello,
> > >        Is there an easy way to set page table attributes for the 
> > > memory returned by __get_free_pages()?
> > >  
> > > I need to be able to turn off caching and turn on E bit for these 
> > > pages.
> > 
> > The Evil bit ? heh ! what are you trying to do ? here ... you can always create a virtual mapping to those pages with different attributes but that's nor recommended as some processors will shoke pretty badly if you end up with both cacheable and non-cacheable mappings for the same page.
> > However, it's not always possible to unmap the initial mapping since it's common to use things like large pages, BATs, large TLB entries etc... to map kernel memory..
> > 
> > > I tried to walk through the page tables data structures to get the 
> > > pte, but it seems that the pmd is not present for the pages. If 
> > > someone has done investigation on this before please send me a reply.
> > >  
> > Kernel linear memory isn't necessarily mapped by the page tables. What are you trying to do and with what processor ?
> > 
> > 
> > 
> > Ben.
> > 
