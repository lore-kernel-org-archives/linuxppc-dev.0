Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40msqf0PmmzF25f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:39:57 +1000 (AEST)
Message-ID: <9b9d6fbf928d4d8e239cb7e3c82d5ac1e3d59973.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc/32be: use stmw/lmw for registers
 save/restore in asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 17 May 2018 23:39:38 +1000
In-Reply-To: <87zi0ymqj6.fsf@concordia.ellerman.id.au>
References: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
 <a94e38e1dbe0c38ce5b363fac29ab6e65fd9985a.1523984745.git.christophe.leroy@c-s.fr>
 <87zi0ymqj6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-17 at 22:10 +1000, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > arch/powerpc/Makefile activates -mmultiple on BE PPC32 configs
> > in order to use multiple word instructions in functions entry/exit
> 
> True, though that could be a lot simpler because the MULTIPLEWORD value
> is only used for PPC32, which is always big endian. I'll send a patch
> for that.

There have been known cases of 4xx LE ports though none ever made it
upstream ...

> > The patch does the same for the asm parts, for consistency
> > 
> > On processors like the 8xx on which insn fetching is pretty slow,
> > this speeds up registers save/restore
> 
> OK. I've always heard that they should be avoided, but that's coming
> from 64-bit land.
> 
> I guess we've been enabling this for all 32-bit targets for ever so it
> must be a reasonable option.
> 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >  v2: Swapped both patches in the serie to reduce number of impacted
> >      lines and added the same modification in ppc_save_regs()
> > 
> >  arch/powerpc/include/asm/ppc_asm.h  |  5 +++++
> >  arch/powerpc/kernel/misc.S          | 10 ++++++++++
> >  arch/powerpc/kernel/ppc_save_regs.S |  4 ++++
> >  3 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> > index 13f7f4c0e1ea..4bb765d0b758 100644
> > --- a/arch/powerpc/include/asm/ppc_asm.h
> > +++ b/arch/powerpc/include/asm/ppc_asm.h
> > @@ -80,11 +80,16 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
> >  #else
> >  #define SAVE_GPR(n, base)	stw	n,GPR0+4*(n)(base)
> >  #define REST_GPR(n, base)	lwz	n,GPR0+4*(n)(base)
> > +#ifdef CONFIG_CPU_BIG_ENDIAN
> > +#define SAVE_NVGPRS(base)	stmw	13, GPR0+4*13(base)
> > +#define REST_NVGPRS(base)	lmw	13, GPR0+4*13(base)
> > +#else
> >  #define SAVE_NVGPRS(base)	SAVE_GPR(13, base); SAVE_8GPRS(14, base); \
> >  				SAVE_10GPRS(22, base)
> >  #define REST_NVGPRS(base)	REST_GPR(13, base); REST_8GPRS(14, base); \
> >  				REST_10GPRS(22, base)
> 
> There is no 32-bit little endian, so this is basically dead code now.
> 
> Maybe there'll be a 32-bit LE port one day, but if so we can put the
> code back then.
> 
> So I'll just drop the else case.
> 
> >  #endif
> > +#endif
> >  
> >  #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
> >  #define SAVE_4GPRS(n, base)	SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
> > diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
> > index 746ee0320ad4..a316d90a5c26 100644
> > --- a/arch/powerpc/kernel/misc.S
> > +++ b/arch/powerpc/kernel/misc.S
> > @@ -49,6 +49,10 @@ _GLOBAL(setjmp)
> >  	PPC_STL	r0,0(r3)
> >  	PPC_STL	r1,SZL(r3)
> >  	PPC_STL	r2,2*SZL(r3)
> > +#if defined(CONFIG_PPC32) && defined(CONFIG_CPU_BIG_ENDIAN)
> 
> And this could just be:
> 
> #ifdef CONFIG_PPC32
> 
> > +	mfcr	r12
> > +	stmw	r12, 3*SZL(r3)
> > +#else
> >  	mfcr	r0
> >  	PPC_STL	r0,3*SZL(r3)
> >  	PPC_STL	r13,4*SZL(r3)
> > @@ -70,10 +74,15 @@ _GLOBAL(setjmp)
> >  	PPC_STL	r29,20*SZL(r3)
> >  	PPC_STL	r30,21*SZL(r3)
> >  	PPC_STL	r31,22*SZL(r3)
> > +#endif
> 
> It's a pity to end up with this basically split in half by ifdefs for
> 32/64-bit, but maybe we can clean that up later.
> 
> cheers
