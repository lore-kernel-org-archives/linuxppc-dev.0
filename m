Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id F070867A3D
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:33:53 +1000 (EST)
Date: Thu, 20 Apr 2006 23:33:50 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1145567025.17087.77.camel@localhost.localdomain>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20080.1145568830@www088.gmx.net>
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
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Fri, 21 Apr 2006 07:03:45 +1000
> 
> On Thu, 2006-04-20 at 20:57 +0200, Gerhard Pircher wrote:
> 
> > 1. The AmigaOne is similar to the PREP platform, i.e. DMA can only be
> > performed in the first 16MB for ISA devices (there's only a VIA
> > southbridge, no other SuperI/O IC with 32bit capable DMA controller).
> > I guess the first 16MB cannot be reserved for not coherent DMA
> > operation, because this memory area is occupied by kernel data? (not to
> > talk about the performance loss, if the kernel data area would be
> > excluded from the BAT mapping).
> 
> Yeah that would suck. Are you sure you need ISA DMA ? You can do pseudo
> DMA like pegasos for the floppy. Anything else should be able to do 32
> bits DMA unless you have a very broken chipset.

I hope not. But I think the AmigaOne floppy driver is copied from the i386
architecture and this one uses DMA IIRC. On the side: who uses floppy drives
these days?

> > 2. I'm not sure how to allocate memory for DMA operation. I think
> > alloc_pages() will not do the job for me, as the page tables for not
> > coherent DMA are reserved (SetPageReserved()) and removed from the
> > available lowmem.
> 
> alloc_pages() ? How so ? No, you want to allocate from your reserved
> pool, you'll have to implement your own allocator. Easiest is a running
> bitmap, look at ppc64 iommu code for an example.
Thanks! I was searching a while for an example, but couldn't found one. 

> >  Also memory fragmentation may be a problem, if a lot DMA operations
> > with different buffer sizes are performed. Therefore a system could
> > quickly run out of memory for not coherent DMA operation, right?
> > Is there a way to minimize fragmentation?
> 
> Best you can do is have separate pools for small and big allocations I
> suppose.
Okay. Or is there a general slab allocator implementation in the Linux
kernel?

> > 3. How are DMA buffers used outside the kernel? Do user programs get a
> > pointer to the DMA buffer (in theory) from the device driver or is the
> > data copied to another buffer allocated by an user program?
> 
> There are cases where some drivers try that but you should ignore it for
> the moment. Won't happen in most cases.
That's good to hear. Makes my life a little bit easier. ;-)
 
Thanks,

Gerhard

-- 
Analog-/ISDN-Nutzer sparen mit GMX SmartSurfer bis zu 70%!
Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer
