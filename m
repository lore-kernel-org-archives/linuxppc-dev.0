Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [RFC 2/2] powerpc: copy_4K_page tweaked for Cell - add CPU feature
Date: Fri, 15 Aug 2008 16:33:30 +1000
References: <200808141618.23818.markn@au1.ibm.com>
	<200808142148.57218.markn@au1.ibm.com>
	<1218715848.10673.33.camel@localhost>
In-Reply-To: <1218715848.10673.33.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808151633.30260.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Aug 2008 10:10:48 pm Michael Ellerman wrote:
> On Thu, 2008-08-14 at 21:48 +1000, Mark Nelson wrote:
> > Hi Michael,
> > 
> > On Thu, 14 Aug 2008 08:51:35 pm Michael Ellerman wrote:
> > > On Thu, 2008-08-14 at 16:18 +1000, Mark Nelson wrote:
> > > > Add a new CPU feature, CPU_FTR_CP_USE_DCBTZ, to be added to the CPUs that benefit
> > > > from having dcbt and dcbz instructions used in copy_4K_page(). So far Cell, PPC970
> > > > and Power4 benefit.
> > > > 
> > > > This way all the other 64bit powerpc chips will have the whole prefetching loop
> > > > nop'ed out.
> > > 
> > > > Index: upstream/arch/powerpc/lib/copypage_64.S
> > > > ===================================================================
> > > > --- upstream.orig/arch/powerpc/lib/copypage_64.S
> > > > +++ upstream/arch/powerpc/lib/copypage_64.S
> > > > @@ -18,6 +18,7 @@ PPC64_CACHES:
> > > >  
> > > >  _GLOBAL(copy_4K_page)
> > > >  	li	r5,4096		/* 4K page size */
> > > > +BEGIN_FTR_SECTION
> > > >  	ld      r10,PPC64_CACHES@toc(r2)
> > > >  	lwz	r11,DCACHEL1LOGLINESIZE(r10)	/* log2 of cache line size */
> > > >  	lwz     r12,DCACHEL1LINESIZE(r10)	/* Get cache line size */
> > > > @@ -30,7 +31,7 @@ setup:
> > > >  	dcbz	r9,r3
> > > >  	add	r9,r9,r12
> > > >  	bdnz	setup
> > > > -
> > > > +END_FTR_SECTION_IFSET(CPU_FTR_CP_USE_DCBTZ)
> > > >  	addi	r3,r3,-8
> > > >  	srdi    r8,r5,7		/* page is copied in 128 byte strides */
> > > >  	addi	r8,r8,-1	/* one stride copied outside loop */
> > > 
> > > Instead of nop'ing it out, we could use an alternative feature section
> > > to either run it or jump over it. It would look something like:
> > > 
> > > 
> > > _GLOBAL(copy_4K_page)
> > > BEGIN_FTR_SECTION
> > >         li      r5,4096         /* 4K page size */
> > >         ld      r10,PPC64_CACHES@toc(r2)
> > >         lwz     r11,DCACHEL1LOGLINESIZE(r10)    /* log2 of cache line size */
> > >         lwz     r12,DCACHEL1LINESIZE(r10)       /* Get cache line size */
> > >         li      r9,0
> > >         srd     r8,r5,r11
> > > 
> > >         mtctr   r8
> > > setup:
> > >         dcbt    r9,r4
> > >         dcbz    r9,r3
> > >         add     r9,r9,r12
> > >         bdnz    setup
> > > FTR_SECTION_ELSE
> > > 	b	1f
> > > ALT_FTR_SECTION_END_IFSET(CPU_FTR_CP_USE_DCBTZ)
> > > 1:
> > >         addi    r3,r3,-8
> > > 
> > > So in the no-dcbtz case you'd get a branch instead of 11 nops.
> > > 
> > > Of course you'd need to benchmark it to see if skipping the nops is
> > > better than executing them ;P
> > 
> > Thanks for looking through this.
> > 
> > That does look a lot better. In the first version there wasn't quite
> > as much to nop out (the cache line size was hardcoded to 128
> > bytes) so I wasn't so worried but I'll definitely try this with an
> > alternative section like you describe.
> > 
> > The jump probably will turn out to be better because I'd imagine
> > that the same chips that don't need the dcbt and dcbz because
> > they've got beefy enough hardware prefetchers also won't be
> > disturbed by the jump (but benchmarks tomorrow will confirm;
> > or prove me wrong :) )
> 
> Yeah, that would make sense. But you never know :)

It turns out that on Power6 using the alternative section doesn't
have any noticeable effect on performance. On Power5 though it
actually made the compile test a tiny bit slower:

with alternative feature section:

real    5m7.549s
user    17m24.256s
sys     1m0.621s

real    5m7.829s
user    17m24.879s
sys     1m0.465s

original implementation:

real    5m6.468s
user    17m22.891s
sys     0m59.765s

real    5m6.965s
user    17m23.160s
sys     0m59.844s

So I guess I'll leave it the way it is...

Thanks!

Mark
