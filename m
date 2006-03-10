Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D17DE679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2006 20:09:59 +1100 (EST)
Date: Fri, 10 Mar 2006 10:09:57 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1141942301.3603.12.camel@localhost.localdomain>
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM	support
Message-ID: <22544.1141981797@www088.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Unmapping pages from the linear addressing without
> HIGHMEM support
> Datum: Fri, 10 Mar 2006 09:11:41 +1100
> 
> On Thu, 2006-03-09 at 14:51 +0100, Gerhard Pircher wrote:
> > Hi,
> > 
> > I'm trying to implement non-coherent DMA for PPC desktop systems (like
> > the AmigaOne with G3/G4 CPU). For this I want to use the code in
> > arch/ppc/kernel/dma-mapping.c. The DMA memory allocation function
> > implemented in this file allocates pages with alloc_pages() and maps
> > them to its own linear address space, but without unmapping the
> > allocated pages from the kernel linear addressing. Due to this the
> > pages are mapped twice, which results in a conflict between the
> > different WIMG settings of the pages.
> > 
> > Is there an API that can be used to unmap the allocated pages from the
> > kernel linear addressing? I thought about using kunmap() and
> > flush_all_zero_pkmaps(), but I'm not sure if this is the right approach
> > and HIGHMEM doesn't work on the AmigaOne too (the highmem base is
> > occupied by the PCI/ISA I/O space!). Wouldn't it be possible to just
> > clear the valid (V) bit of the PTE and do a TLB cache flush?
> 
> The main problem is that the mappings may be covered by a BAT and thus
> pages may not be unmappable individually...
> 
> What I would suggest is that your dig in the low level RAM mapping code
> and limit it at boot to RAM minus a pool of the size you want.
That would mean I cannot reuse the code in dma-mapping.c, right? Killing the
BAT mappings or limiting the memory size covered by the BATs seems to be
fairly easy, but I guess I have to setup my own page table for the reserved
DMA memory area and implement my own alloc_pages() function!?

Thanks!

Gerhard

-- 
Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
