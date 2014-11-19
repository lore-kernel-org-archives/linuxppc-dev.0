Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 865B11A0668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 16:29:18 +1100 (AEDT)
Message-ID: <1416374957.32483.3.camel@concordia>
Subject: Re: [PATCH] powerpc: Remove more traces of bootmem
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 19 Nov 2014 16:29:17 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9F2964@AcuExch.aculab.com>
References: <1416293575-1847-1-git-send-email-mpe@ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6D1C9F2964@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-18 at 10:26 +0000, David Laight wrote:
> From: Michael Ellerman
> > Although we are now selecting NO_BOOTMEM, we still have some traces of
> > bootmem lying around. That is because even with NO_BOOTMEM there is
> > still a shim that converts bootmem calls into memblock calls, but
> > ultimately we want to remove all traces of bootmem.
> > 
> > Most of the patch is conversions from alloc_bootmem() to
> > memblock_alloc(). In general a call such as:
> > 
> >   p = (struct foo *)alloc_bootmem(x);
> > 
> > Becomes:
> > 
> >   p = __va(memblock_alloc(x, 0));
> > 
> > We need __va() because memblock returns a physical address. We don't
> > need the cast because __va() returns a void *. The alignment value of
> > zero tells memblock to use the default alignment, which is
> > SMP_CACHE_BYTES, the same value alloc_bootmem() uses.
> 
> It doesn't seem right to me to replicate __va(memblock_alloc(x, 0))
> that many times. I can imagine that the required code will change
> again at to future time, and then all the same places would need changing.

Yeah it's a bit ugly. Actually most of that code has never changed, which is
the problem, no one has bothered to update it.

> Wouldn't it be better to use:
> #define alloc_bootmem(x) __va(memblock_alloc(x, 0))
> possibly with a rename, or as a static inline.

Well that's essentially what the existing shim does. So we can't use that name.

My plan is to add a memblock_alloc_virt() which does the __va() for you. But I
didn't want the powerpc changes to get backed up behind that.

> If __va() is non-trivial you want a real function.

It can't be a function because we use it on void * as well as unsigned long,
phys_addr_t etc.

phys_to_virt() is the nicer version, though it only takes unsigned long.

cheers
