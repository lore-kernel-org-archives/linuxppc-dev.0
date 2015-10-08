Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EE2C1A025E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 06:13:03 +1100 (AEDT)
Message-ID: <1444331568.5336.328.camel@freescale.com>
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 8 Oct 2015 14:12:48 -0500
In-Reply-To: <561514D4.9090406@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
 <20150929002935.GK6161@home.buserror.net> <561514D4.9090406@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-07 at 14:49 +0200, Christophe Leroy wrote:
> Le 29/09/2015 02:29, Scott Wood a écrit :
> > On Tue, Sep 22, 2015 at 06:51:13PM +0200, Christophe Leroy wrote:
> > > flush/clean/invalidate _dcache_range() functions are all very
> > > similar and are quite short. They are mainly used in __dma_sync()
> > > perf_event locate them in the top 3 consumming functions during
> > > heavy ethernet activity
> > > 
> > > They are good candidate for inlining, as __dma_sync() does
> > > almost nothing but calling them
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > > New in v2
> > > 
> > >   arch/powerpc/include/asm/cacheflush.h | 55 
> > > +++++++++++++++++++++++++++--
> > >   arch/powerpc/kernel/misc_32.S         | 65 ---------------------------
> > > --------
> > >   arch/powerpc/kernel/ppc_ksyms.c       |  2 ++
> > >   3 files changed, 54 insertions(+), 68 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/cacheflush.h 
> > > b/arch/powerpc/include/asm/cacheflush.h
> > > index 6229e6b..6169604 100644
> > > --- a/arch/powerpc/include/asm/cacheflush.h
> > > +++ b/arch/powerpc/include/asm/cacheflush.h
> > > @@ -47,12 +47,61 @@ static inline void 
> > > __flush_dcache_icache_phys(unsigned long physaddr)
> > >   }
> > >   #endif
> > >   
> > > -extern void flush_dcache_range(unsigned long start, unsigned long 
> > > stop);
> > >   #ifdef CONFIG_PPC32
> > > -extern void clean_dcache_range(unsigned long start, unsigned long 
> > > stop);
> > > -extern void invalidate_dcache_range(unsigned long start, unsigned long 
> > > stop);
> > > +/*
> > > + * Write any modified data cache blocks out to memory and invalidate 
> > > them.
> > > + * Does not invalidate the corresponding instruction cache blocks.
> > > + */
> > > +static inline void flush_dcache_range(unsigned long start, unsigned 
> > > long stop)
> > > +{
> > > + void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
> > > + unsigned int size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
> > > + unsigned int i;
> > > +
> > > + for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
> > > +         dcbf(addr);
> > > + if (i)
> > > +         mb();   /* sync */
> > > +}
> > I know this is 32-bit-specific code, but it's still bad practice to use
> > "unsigned int" for addresses or sizes thereof.
> > 
> > 
> Ok, I can fix size, but what about start and stop ? If I change that, it 
> means I also have to fix all caller. Do you expect me to do that ?

start and stop are already unsigned long.

> And it is very unlykely, but what if for some reason someone wants to 
> invalidate the entire user address space which is 3Gbytes size ? A 
> signed size would be negative here.

Why would size be signed?

-Scott
