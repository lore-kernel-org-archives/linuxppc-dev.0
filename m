Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Hijacking CPU_FTR_VSX for BGQ QPX
In-reply-to: <1352491029.23412.3.camel@pasglop>
References: <29970ED2-02E3-45F5-96FD-B4270385E3ED@pobox.com>
 <1352491029.23412.3.camel@pasglop>
Date: Sat, 10 Nov 2012 15:33:23 +1100
Message-ID: <3948.1352522003@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2012-11-09 at 11:43 -0600, Jimi Xenidis wrote:
> > The CPU_FTR_* values are pretty tight (a few bits left) yes I need to save and restore the QPX registers.
> > There are 32 QPX registers, each 32 bytes in size, it is otherwise managed by the FPSCR and MSR[FP]
> > 
> > I was thinking that I could hijack the VSX, since there is no plan to add it to embedded yet.
> > I could be explicit or create an alieas fo the same bit, but the basic effect (after increasing the save area size) would be something like the diff below.
> > Thoughts?
> 
> Don't. Use a different bit, we can always split the mask again if
> needed, move more bits to mmu_features etc...
> 
> > -#ifdef CONFIG_VSX
> > +#if defined (CONFIG_VSX) && defined(CONFIG_BGQ)
> > +# error "This code depends on CONFIG_VSX and CONFIG_BGQ being exclusive
> > +#elif defined (CONFIG_VSX)
> > +# define _REST_32VSRS(n,c,base) REST_32VSRS(n,c,base)
> > +# define _SAVE_32VSRS(n,c,base) SAVE_32VSRS(n,c,base)
> > +#elif defined(CONFIG_BGQ)
> 
> Make a CONFIG_PPC_QPX or something like that specifically for the QPX
> stuff that you can then "select" from CONFIG_PPC_BGQ (don't do just
> CONFIG_BGQ).
> 
> And don't just "hijack" stuff like that, it should be a runtime option,
> so add a new set etc... it should be possible to build a kernel that
> boots on a BGQ or a hypothetical BookE chip with VSX.

Yeah both bluegene and VSX are designed for HPC, so it's not completely
crazy that someone would put them together.

Also, we need to fix the CPU FTR issue.  With PPR (Haren's stuff) and
POWER8 we are going to blow CPU FTRs pretty soon anyway.  This just adds
to that.

Mikey

> 
> > +# define _REST_32VSRS(n,c,base) REST_32QRS(n,c,base)
> > +# define _SAVE_32VSRS(n,c,base) SAVE_32QRS(n,c,base)
> > +#endif
> > +
> > +#if defined (CONFIG_VSX) || defined(CONFIG_BGQ)
> >  #define REST_32FPVSRS(n,c,base)						\
> >  BEGIN_FTR_SECTION							\
> >  	b	2f;							\
> >  END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
> >  	REST_32FPRS(n,base);						\
> >  	b	3f;							\
> > -2:	REST_32VSRS(n,c,base);						\
> > +2:	_REST_32VSRS(n,c,base);						\
> >  3:
> >  
> >  #define SAVE_32FPVSRS(n,c,base)						\
> > @@ -41,7 +51,7 @@ BEGIN_FTR_SECTION							\
> >  END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
> >  	SAVE_32FPRS(n,base);						\
> >  	b	3f;							\
> > -2:	SAVE_32VSRS(n,c,base);						\
> > +2:	_SAVE_32VSRS(n,c,base);						\
> >  3:
> >  #else
> >  #define REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
> 
> Cheers,
> Ben.
> 
> 
