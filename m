Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
In-reply-to: <F49F5B26-671F-4D3F-BAC3-67F852E03798@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
 <22874.1354859652@neuling.org>
 <F49F5B26-671F-4D3F-BAC3-67F852E03798@pobox.com>
Date: Mon, 10 Dec 2012 11:18:31 +1100
Message-ID: <1244.1355098711@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jimi Xenidis <jimix@pobox.com> wrote:

> 
> On Dec 6, 2012, at 11:54 PM, Michael Neuling <mikey@neuling.org> wrote:
> 
> >> commit 279c0615917b959a652e81f4ad0d886e2d426d85
> >> Author: Jimi Xenidis <jimix@pobox.com>
> >> Date:   Wed Dec 5 13:43:22 2012 -0500
> >> 
> >>    powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)
> >> 
> >>    This enables kernel support for the QPX extention and is intended for
> >>    processors that support it, usually an IBM Blue Gene processor.
> >>    Turning it on does not effect other processors but it does add code
> >>    and will quadruple the per thread save and restore area for the FPU
> >>    (hense the name).  If you have enabled VSX it will only double the
> >>    space.
> >> 
> >>    Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> > 
> > Can you give a diagram of how the QPX registers are layed out.
> > 
> > +#if defined(CONFIG_PPC_QPX)
> > +#define TS_FPRWIDTH 4
> > +#elif defined(CONFIG_VSX)
> > 
> > Are they 256 bits wide?
> 
> Yes, this is why we nicknamed it the "Quad Hummer" :)
>  - 4-wide double precision FPU SIMD
>  - 2-wide complex SIMD
>  - 4R/2W register file (32x256 bits per thread)
>  - 32B (256 bits) datapath to/from L1 cache

OK, can you add a comment like this to the commit log and to the code so
that people know what it looks like.

> 
> > 
> > 
> > +#define QVLFDXA(QRT,RA,RB)	\
> > +	.long (0x7c00048f | ((QRT) << 21) | ((RA) << 16) | ((RB) << 11))
> > 
> > Put this in ppc-opcode.h.
> > 
> > +#if defined(CONFIG_VSX) || defined(CONFIG_PPC_QPX)
> > +	/* they are the same MSR bit */
> > 
> > OMG!
> 
> Ooops, you are correct, this was in the original patch.
> I'll double check the work book, but it should be the architected VEC/SPV bit which is really for VMX.
> I'll track it down.
> 
> > 
> > 
> > +BEGIN_FTR_SECTION							\
> > +	SAVE_32VSRS(n,c,base);						\
> > +END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
> > +BEGIN_FTR_SECTION							\
> > +	SAVE_32QRS(n,c,base);						\
> > +END_FTR_SECTION_IFSET(CPU_FTR_QPX);	
> > 
> > I don't think we want to do this.  We are going to end up with 64
> > NOPS here somewhere.
> 
> Excellent point, NOPs are cheap on most processors but not A2 and a
> lot of embedded, I can wrap some branches with the FTR instead.  Do
> you have a concern on the code size?

Code size is not the issue.  Just running over 64NOPS for no reason.  In
the past, we've preferred a branch over a section of code.

> 
> > 
> > I'd like to see this patch broken into different parts.
> 
> I'm not sure how _this_ patch:
>   <https://github.com/jimix/linux-bgq/commit/279c0615917b959a652e81f4ad0d886e2d426d85>
> could be broken up, please advise.

Add it in reviewable chunks.  Add the infrastructure (instructions,
macros, config options) then hook it into the existing code.


> > Also, have you boot tested this change on a VSX enabled box?
> 
> I can try, I may bug you for help.  Is there a commonly test (or apps)
> I should run?

I have some tests squirred away when I did the initial VSX stuff.  I can
grab them. I suspect this will either completely blow up VSX context
switching or work perfectly well.  It's unlikely to introduce subtle
bugs.

Mikey 
