Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA38E687DE
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2005 09:03:36 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <4885.1133513163@www38.gmx.net>
References: <1133481536.6100.32.camel@gaston> <4885.1133513163@www38.gmx.net>
Content-Type: text/plain; charset=utf-8
Date: Sat, 03 Dec 2005 08:56:30 +1100
Message-Id: <1133560590.6100.75.camel@gaston>
Mime-Version: 1.0
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

On Fri, 2005-12-02 at 09:46 +0100, Gerhard Pircher wrote:
> > --- Ursprüngliche Nachricht ---
> > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > Kopie: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
> > debian-powerpc@lists.debian.org
> > Betreff: Re: AmigaOne 2.6.x Linux kernel port
> > Datum: Fri, 02 Dec 2005 10:58:55 +1100
> > 
> > (I'm moving this to the linuxppc-dev list)
> > 
> > Well, you need consistent alloc functions to really provide you with
> > non-cached memory. Fushing is not enough. Flushing is fine for dma_map
> > etc..., not for consistent alloc.
> > 
> > So in theory, you should be able to re-use the existing consistent
> > allocation functions, except that the current implementation has
> > "issues":

> Well, as far as I could understand the code, you need to define a start and
> end address for the consistent memory, but as all the memory is managed by
> the kernel, it's not possible to do this (I hope that I don't write nonsense
> here ;-) ).

Nah, those are virtual addresses, they are defined in .config, the
default ones might just work.

> > I understand this is probably done to keep the TLB miss handler for the
> > kernel mapping as fast as possible. Unfortunately, it's also incorrect
> > if your processor is capable of any kind of prefetching accross a 4k
> > boundary.
>
> Well, the processor is a normal G3/G4 desktop CPU... 

I know and that's a problem.

> Okay, I think reserving memory outside of the BAT mapping, is the approach
> that is used in the arch/ppc/kernel/dma-mapping.c file. There you should
> define a consistent memory area (by it's start and end address), which is
> used for non-coherent DMA memory allocations, right? But as that isn't
> possible on the AmigaOne, we have to go the hard way.

No. This area is only used for virtual space allocation. Actual physical
pages are picked up anywhere using the page allocator.


> Well, after all the performance of the AmigaOne isn't that good (but
> acceptable) due to the ArticiaS northbridge, but I think it's more important
> to fix the real problem than doing a lot of workarounds. I'm going to study
> now the processor docs, otherwise I won't understand not even a single bit
> of the kernel code. :-)

The real problem is the northbridge being crap.

Ben.
