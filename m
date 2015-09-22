Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 73C7A1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 06:38:09 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "scottwood@freescale.com" <scottwood@freescale.com>
CC: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
Date: Tue, 22 Sep 2015 20:38:05 +0000
Message-ID: <1442954285.29498.79.camel@transmode.se>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
 <1442945547.29498.50.camel@transmode.se>
 <1442948339.19102.270.camel@freescale.com>
 <1442950473.29498.54.camel@transmode.se>
 <1442950926.19102.280.camel@freescale.com>
 <1442951752.29498.58.camel@transmode.se>
 <1442952852.19102.281.camel@freescale.com>
 <1442953971.29498.76.camel@transmode.se>
 <1442954101.19102.286.camel@freescale.com>
In-Reply-To: <1442954101.19102.286.camel@freescale.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-22 at 15:35 -0500, Scott Wood wrote:
> On Tue, 2015-09-22 at 20:32 +0000, Joakim Tjernlund wrote:
> > On Tue, 2015-09-22 at 15:14 -0500, Scott Wood wrote:
> > > On Tue, 2015-09-22 at 19:55 +0000, Joakim Tjernlund wrote:
> > > > On Tue, 2015-09-22 at 14:42 -0500, Scott Wood wrote:
> > > > > On Tue, 2015-09-22 at 19:34 +0000, Joakim Tjernlund wrote:
> > > > > > On Tue, 2015-09-22 at 13:58 -0500, Scott Wood wrote:
> > > > > > > On Tue, 2015-09-22 at 18:12 +0000, Joakim Tjernlund wrote:
> > > > > > > > On Tue, 2015-09-22 at 18:51 +0200, Christophe Leroy wrote:
> > > > > > > > > flush/clean/invalidate _dcache_range() functions are all =
very
> > > > > > > > > similar and are quite short. They are mainly used in=20
> > > > > > > > > __dma_sync()
> > > > > > > > > perf_event locate them in the top 3 consumming functions=
=20
> > > > > > > > > during
> > > > > > > > > heavy ethernet activity
> > > > > > > > >=20
> > > > > > > > > They are good candidate for inlining, as __dma_sync() doe=
s
> > > > > > > > > almost nothing but calling them
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > > > > > > > ---
> > > > > > > > > New in v2
> > > > > > > > >=20
> > > > > > > > >  arch/powerpc/include/asm/cacheflush.h | 55=20
> > > > > > > > > +++++++++++++++++++++++++++--
> > > > > > > > >  arch/powerpc/kernel/misc_32.S         | 65 -------------=
-----
> > > > > > > > > ----
> > > > > > > > > ----
> > > > > > > > > ----
> > > > > > > > > -----
> > > > > > > > >  arch/powerpc/kernel/ppc_ksyms.c       |  2 ++
> > > > > > > > >  3 files changed, 54 insertions(+), 68 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/arch/powerpc/include/asm/cacheflush.h=20
> > > > > > > > > b/arch/powerpc/include/asm/cacheflush.h
> > > > > > > > > index 6229e6b..6169604 100644
> > > > > > > > > --- a/arch/powerpc/include/asm/cacheflush.h
> > > > > > > > > +++ b/arch/powerpc/include/asm/cacheflush.h
> > > > > > > > > @@ -47,12 +47,61 @@ static inline void=20
> > > > > > > > > __flush_dcache_icache_phys(unsigned long physaddr)
> > > > > > > > >  }
> > > > > > > > >  #endif
> > > > > > > > > =20
> > > > > > > > > -extern void flush_dcache_range(unsigned long start, unsi=
gned=20
> > > > > > > > > long=20
> > > > > > > > > stop);
> > > > > > > > >  #ifdef CONFIG_PPC32
> > > > > > > > > -extern void clean_dcache_range(unsigned long start, unsi=
gned=20
> > > > > > > > > long=20
> > > > > > > > > stop);
> > > > > > > > > -extern void invalidate_dcache_range(unsigned long start,=
=20
> > > > > > > > > unsigned=20
> > > > > > > > > long=20
> > > > > > > > > stop);
> > > > > > > > > +/*
> > > > > > > > > + * Write any modified data cache blocks out to memory an=
d=20
> > > > > > > > > invalidate=20
> > > > > > > > > them.
> > > > > > > > > + * Does not invalidate the corresponding instruction cac=
he=20
> > > > > > > > > blocks.
> > > > > > > > > + */
> > > > > > > > > +static inline void flush_dcache_range(unsigned long star=
t,=20
> > > > > > > > > unsigned=20
> > > > > > > > > long=20
> > > > > > > > > stop)
> > > > > > > > > +{
> > > > > > > > > +   void *addr =3D (void *)(start & ~(L1_CACHE_BYTES - 1)=
);
> > > > > > > > > +   unsigned int size =3D stop - (unsigned long)addr +=20
> > > > > > > > > (L1_CACHE_BYTES -
> > > > > > > > > 1);
> > > > > > > > > +   unsigned int i;
> > > > > > > > > +
> > > > > > > > > +   for (i =3D 0; i < size >> L1_CACHE_SHIFT; i++, addr +=
=3D=20
> > > > > > > > > L1_CACHE_BYTES)
> > > > > > > > > +           dcbf(addr);
> > > > > > > > > +   if (i)
> > > > > > > > > +           mb();   /* sync */
> > > > > > > > > +}
> > > > > > > >=20
> > > > > > > > This feels optimized for the uncommon case when there is no=
=20
> > > > > > > > invalidation.
> > > > > > >=20
> > > > > > > If you mean the "if (i)", yes, that looks odd.
> > > > > >=20
> > > > > > Yes.
> > > > > >=20
> > > > > > >=20
> > > > > > > > I THINK it would be better to bail early=20
> > > > > > >=20
> > > > > > > Bail under what conditions?
> > > > > >=20
> > > > > > test for "i =3D 0" and return.=20
> > > > >=20
> > > > > Why bother?
> > > >=20
> > > > I usally find it better to dela with special cases upfront s=E5 the=
 rest=20
> > > > doesn't need to
> > > > bother. i=3D0 is a NOP and it is clearer to show that upfront.
> > >=20
> > > No, I mean why bother special casing this at all?
> >=20
> > I just said why?=20
> > You to found the if(i) mb() a bit odd and it took a little time to see =
why=20
> > it was there.
> > Ahh, you mean just skip the if(i) and have mb() unconditionally?
>=20
> Yes.
>=20
> > That changes the semantics a little from the ASM version but perhaps th=
at=20
> > doesn't matter?
>=20
> Adding more barriers than strictly necessary is a performance concern, no=
t a=20
> semantic change.
Semantics :)

>   How often are we really calling this function over an empty=20
> range?

Never hopefully, it does not make much sense.

>=20
> Not that it matters much one way or another...
probably not.
