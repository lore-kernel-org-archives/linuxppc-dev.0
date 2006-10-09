Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C1D067B55
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 17:06:10 +1000 (EST)
Subject: Re: [PATCH] powerpc: Cell timebase bug workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061009165629.4fa5813a.sfr@canb.auug.org.au>
References: <1160370623.14601.42.camel@localhost.localdomain>
	<20061009165629.4fa5813a.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 17:05:17 +1000
Message-Id: <1160377517.14601.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-09 at 16:56 +1000, Stephen Rothwell wrote:
> On Mon, 09 Oct 2006 15:10:22 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Index: linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-06 13:47:54.000000000 +1000
> > +++ linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-09 13:28:54.000000000 +1000
> > @@ -11,6 +11,8 @@
> >   * as published by the Free Software Foundation; either version
> >   * 2 of the License, or (at your option) any later version.
> >   */
> > +
> > +#include <linux/config.h>
> 
> You don't need that (in fact someone just remoed them all).

Oops, leftover of a previous patch. I'll remove it.

> >  #ifdef __ASSEMBLY__
> >
> > -#define BEGIN_FTR_SECTION		98:
> > +#define BEGIN_FTR_SECTION_NESTED(label)	label:
> > +#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(98)
> >
> >  #ifndef __powerpc64__
> > -#define END_FTR_SECTION(msk, val)		\
> > +#define END_FTR_SECTION_NESTED(msk, val, label) \
> >  99:						\
> >  	.section __ftr_fixup,"a";		\
> >  	.align 2;				\
> >  	.long msk;				\
> >  	.long val;				\
> > -	.long 98b;				\
> > +	.long label##b;				\
> >  	.long 99b;				\
> >  	.previous
> >  #else /* __powerpc64__ */
> > -#define END_FTR_SECTION(msk, val)		\
> > +#define END_FTR_SECTION_NESTED(msk, val, label) \
> >  99:						\
> >  	.section __ftr_fixup,"a";		\
> >  	.align 3;				\
> >  	.llong msk;				\
> >  	.llong val;				\
> > -	.llong 98b;				\
> > +	.llong label##b;				\
> >  	.llong 99b;	 			\
> >  	.previous
> >  #endif /* __powerpc64__ */
> >
> > +#define END_FTR_SECTION(msk, val)		\
> > +	END_FTR_SECTION_NESTED(msk, val, 98)
> > +
> 
> The above should be in a separate patch.

Hrm... makes my life more complicated but I suppose I can split it.

> > +#ifdef CONFIG_PPC_CELL
> > +#define MFTB(dest)			\
> > +	mftb  dest;			\
> > +BEGIN_FTR_SECTION;			\
> > +	cmpwi dest,0;			\
> > +	bne+  97f;			\
> > +	mftb  dest;			\
> > +97:					\
> > +END_FTR_SECTION_IFSET(CPU_FTR_CELL_TB_BUG)
> 
> Why not branch back to the mftb if the lower word is zero (this would
> also take care of the very unlikely "hitting the bug more than once" case
> and the "normal" case would then not have to branch at all.  (And it uses
> one less instruction.)

Because that would cause us to spinloop for the whole duration of a tb
tick in that case, which is pretty bad when the timebase is slow (the
slower I've seen so far is 14Mhz).

Ben.
