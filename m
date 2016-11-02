Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t81fW4vwbzDt3Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:36:35 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so1144223pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 01:36:35 -0700 (PDT)
Date: Wed, 2 Nov 2016 19:36:24 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Shreyas B . Prabhu"
 <shreyas@linux.vnet.ibm.com>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
Message-ID: <20161102193624.7f0cbfee@roar.ozlabs.ibm.com>
In-Reply-To: <20161102082433.GA17365@in.ibm.com>
References: <20161013021714.6624-1-npiggin@gmail.com>
 <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
 <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
 <20161102082433.GA17365@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2 Nov 2016 13:54:43 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 2016-11-02 17:57:01 Wed, Nicholas Piggin wrote:
> > On Wed, 2 Nov 2016 11:34:59 +0530
> > Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >   
> > > On 10/13/2016 07:47 AM, Nicholas Piggin wrote:  
> > > > This patch does a couple of things. First of all, powernv immediately
> > > > explodes when running a relocated kernel, because the system reset
> > > > exception for handling sleeps does not do correct relocated branches.
> > > > 
> > > > Secondly, the sleep handling code trashes the condition and cfar
> > > > registers, which we would like to preserve for debugging purposes (for
> > > > non-sleep case exception).
> > > > 
> > > > This patch changes the exception to use the standard format that saves
> > > > registers before any tests or branches are made. It adds the test for
> > > > idle-wakeup as an "extra" to break out of the normal exception path.
> > > > Then it branches to a relocated idle handler that calls the various
> > > > idle handling functions.
> > > > 
> > > > After this patch, POWER8 CPU simulator now boots powernv kernel that is
> > > > running at non-zero.
> > > > 
> > > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > > Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> > > > Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > ---
> > > >  arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
> > > >  arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
> > > >  2 files changed, 45 insertions(+), 21 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> > > > index 2e4e7d8..84d49b1 100644
> > > > --- a/arch/powerpc/include/asm/exception-64s.h
> > > > +++ b/arch/powerpc/include/asm/exception-64s.h
> > > > @@ -93,6 +93,10 @@
> > > >  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
> > > >  	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> > > > 
> > > > +#define __LOAD_HANDLER(reg, label)					\
> > > > +	ld	reg,PACAKBASE(r13);					\
> > > > +	ori	reg,reg,(ABS_ADDR(label))@l;
> > > > +
> > > >  /* Exception register prefixes */
> > > >  #define EXC_HV	H
> > > >  #define EXC_STD
> > > > @@ -208,6 +212,18 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
> > > >  #define kvmppc_interrupt kvmppc_interrupt_pr
> > > >  #endif
> > > > 
> > > > +#ifdef CONFIG_RELOCATABLE
> > > > +#define BRANCH_TO_COMMON(reg, label)					\
> > > > +	__LOAD_HANDLER(reg, label);					\
> > > > +	mtctr	reg;							\
> > > > +	bctr
> > > > +
> > > > +#else
> > > > +#define BRANCH_TO_COMMON(reg, label)					\
> > > > +	b	label
> > > > +
> > > > +#endif
> > > > +
> > > >  #define __KVM_HANDLER_PROLOG(area, n)					\
> > > >  	BEGIN_FTR_SECTION_NESTED(947)					\
> > > >  	ld	r10,area+EX_CFAR(r13);					\
> > > > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > > > index 08992f8..e680e84 100644
> > > > --- a/arch/powerpc/kernel/exceptions-64s.S
> > > > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > > > @@ -95,19 +95,35 @@ __start_interrupts:
> > > >  /* No virt vectors corresponding with 0x0..0x100 */
> > > >  EXC_VIRT_NONE(0x4000, 0x4100)
> > > > 
> > > > -EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> > > > -	SET_SCRATCH0(r13)
> > > > +
> > > >  #ifdef CONFIG_PPC_P7_NAP
> > > > -BEGIN_FTR_SECTION
> > > > -	/* Running native on arch 2.06 or later, check if we are
> > > > -	 * waking up from nap/sleep/winkle.
> > > > +	/*
> > > > +	 * If running native on arch 2.06 or later, check if we are waking up
> > > > +	 * from nap/sleep/winkle, and branch to idle handler.
> > > >  	 */
> > > > -	mfspr	r13,SPRN_SRR1
> > > > -	rlwinm.	r13,r13,47-31,30,31
> > > > -	beq	9f
> > > > +#define IDLETEST(n)							\
> > > > +	BEGIN_FTR_SECTION ;						\
> > > > +	mfspr	r10,SPRN_SRR1 ;						\
> > > > +	rlwinm.	r10,r10,47-31,30,31 ;					\
> > > > +	beq-	1f ;							\
> > > > +	cmpwi	cr3,r10,2 ;						\
> > > > +	BRANCH_TO_COMMON(r10, system_reset_idle_common) ;		\
> > > > +1:									\
> > > > +	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> > > > +#else
> > > > +#define IDLETEST NOTEST
> > > > +#endif
> > > > 
> > > > -	cmpwi	cr3,r13,2
> > > > -	GET_PACA(r13)
> > > > +EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> > > > +	SET_SCRATCH0(r13)
> > > > +	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> > > > +				 IDLETEST, 0x100)    
> > > 
> > > Very sorry for late review. On arch 2.07 and less if we wakeup from
> > > winkle then last bit of HSPGR0 would be set to 1. Hence before we access
> > > paca we need to fix it by clearing that bit and that is done in
> > > pnv_restore_hyp_resource(). But with this patch, we would end up there
> > > after going through EXCEPTION_PROLOG_PSERIES(). This macro gets the paca
> > > using GET_PACA(r13) and all the EXCEPTION_PROLOG_* starts
> > > using/accessing r13/paca without fixing it. Wouldn't this break things
> > > badly on arch 2.07 and less ? Am I missing anything ?  
> > 
> > Arg, that's a stupid bug :( Thanks for catching it.
> > 
> > Would something like the following do the trick, do you think? I obviously
> > was not reaching winkle state in my testing.  
> 
> Yup, that will work.

Okay, I'll work with that. What's the best way to make a P8 do winkle sleeps?

Thanks,
Nick
