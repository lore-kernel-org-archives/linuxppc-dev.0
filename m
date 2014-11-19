Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CD601A09C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 18:57:38 +1100 (AEDT)
Message-ID: <1416383857.22760.1.camel@concordia>
Subject: Re: [PATCH] powerpc: Remove more traces of bootmem
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 19 Nov 2014 18:57:37 +1100
In-Reply-To: <1416374957.32483.3.camel@concordia>
References: <1416293575-1847-1-git-send-email-mpe@ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6D1C9F2964@AcuExch.aculab.com>
 <1416374957.32483.3.camel@concordia>
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

On Wed, 2014-11-19 at 16:29 +1100, Michael Ellerman wrote:
> On Tue, 2014-11-18 at 10:26 +0000, David Laight wrote:
> > From: Michael Ellerman
> > > Although we are now selecting NO_BOOTMEM, we still have some traces of
> > > bootmem lying around. That is because even with NO_BOOTMEM there is
> > > still a shim that converts bootmem calls into memblock calls, but
> > > ultimately we want to remove all traces of bootmem.
> > > 
> > > Most of the patch is conversions from alloc_bootmem() to
> > > memblock_alloc(). In general a call such as:
> > > 
> > >   p = (struct foo *)alloc_bootmem(x);
> > > 
> > > Becomes:
> > > 
> > >   p = __va(memblock_alloc(x, 0));
> > > 
> > > We need __va() because memblock returns a physical address. We don't
> > > need the cast because __va() returns a void *. The alignment value of
> > > zero tells memblock to use the default alignment, which is
> > > SMP_CACHE_BYTES, the same value alloc_bootmem() uses.
> > 
> > It doesn't seem right to me to replicate __va(memblock_alloc(x, 0))
> > that many times. I can imagine that the required code will change
> > again at to future time, and then all the same places would need changing.

After more grovelling through header files it turns out there is a wrapper that
does what we want - I think.

It's memblock_virt_alloc() (name reversed), and it's in bootmem.h, which is why
I didn't find it originally.

I'll try that instead.

cheers
