Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6120368862
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 19:46:05 +1100 (EST)
Date: Fri, 2 Dec 2005 09:46:03 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1133481536.6100.32.camel@gaston>
Message-ID: <4885.1133513163@www38.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: AmigaOne 2.6.x Linux kernel port
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
> Kopie: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
> debian-powerpc@lists.debian.org
> Betreff: Re: AmigaOne 2.6.x Linux kernel port
> Datum: Fri, 02 Dec 2005 10:58:55 +1100
> 
> (I'm moving this to the linuxppc-dev list)
> 
> Well, you need consistent alloc functions to really provide you with
> non-cached memory. Fushing is not enough. Flushing is fine for dma_map
> etc..., not for consistent alloc.
> 
> So in theory, you should be able to re-use the existing consistent
> allocation functions, except that the current implementation has
> "issues":
Well, as far as I could understand the code, you need to define a start and
end address for the consistent memory, but as all the memory is managed by
the kernel, it's not possible to do this (I hope that I don't write nonsense
here ;-) ).

> The main problem I see with the implementation is that it just allocates
> pages out of the normal kernel allocator and maps them in the
> "consistent" virtual range without ever unmapping them from the kernel
> linear mapping. That means that those pages end up being mapped twice:
> cacheable and non-cacheable, which is absolutely wrong and will explode
> in colorful ways on a number of CPUs. The pages should at least be
> unmapped from the kernel linear (& cacheable) mapping.
> 
> I understand this is probably done to keep the TLB miss handler for the
> kernel mapping as fast as possible. Unfortunately, it's also incorrect
> if your processor is capable of any kind of prefetching accross a 4k
> boundary.
Well, the processor is a normal G3/G4 desktop CPU... 

> Then, remains the BAT mapping problem. In order to improve performances,
> the kernel uses BATs to map the main memory (to know more about BATs,
> look at the proccessor docs). That means that unmapping the memory from
> the linear mapping will not work if that memory happens to be covered by
> a BAT (there aren't even page tables entries for those pages anyway).
> Thus, in order to be able to reliably unmap things from the linear
> mapping (or individually change page attributes) you need to disable BAT
> mapping of memory, either completely, or by preallocating (and thus
> actually reserving) memory outside of the BAT mapping for use in the
> consistent allocator.
Okay, I think reserving memory outside of the BAT mapping, is the approach
that is used in the arch/ppc/kernel/dma-mapping.c file. There you should
define a consistent memory area (by it's start and end address), which is
used for non-coherent DMA memory allocations, right? But as that isn't
possible on the AmigaOne, we have to go the hard way.

> However, the exception handling of the kernel is designed with the
> assumption that it will not take hash faults in some critical locations,
> and this assumption is correct thanks to ... the BAT mapping. You are
> lucky though that recent kernels have been fixed to be able to recover
> from such faults provided the instructions are still BAT mapped, so you
> can probably hack the initialisation of the memory on ppc to not use
> data BATs but only instruction BATs and still create the page tables for
> the entire memory. That will allow you to implement proper unmapping of
> pages in the consistent allocator. However, it will also impact your
> overall performances ...
Well, after all the performance of the AmigaOne isn't that good (but
acceptable) due to the ArticiaS northbridge, but I think it's more important
to fix the real problem than doing a lot of workarounds. I'm going to study
now the processor docs, otherwise I won't understand not even a single bit
of the kernel code. :-)

Thanks again!

Gerhard

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner
