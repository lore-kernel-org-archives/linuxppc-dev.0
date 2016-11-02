Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t81P25bZ6zDt2g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:24:54 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA28NfQh029706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 04:24:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26fc9x92jh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 04:24:52 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 18:24:49 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 71DB63578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:24:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA28Om7v5046648
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 19:24:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA28OmWA031449
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 19:24:48 +1100
Date: Wed, 2 Nov 2016 13:54:43 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
Reply-To: mahesh@linux.vnet.ibm.com
References: <20161013021714.6624-1-npiggin@gmail.com>
 <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
 <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
Message-Id: <20161102082433.GA17365@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-11-02 17:57:01 Wed, Nicholas Piggin wrote:
> On Wed, 2 Nov 2016 11:34:59 +0530
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> > On 10/13/2016 07:47 AM, Nicholas Piggin wrote:
> > > This patch does a couple of things. First of all, powernv immediately
> > > explodes when running a relocated kernel, because the system reset
> > > exception for handling sleeps does not do correct relocated branches.
> > > 
> > > Secondly, the sleep handling code trashes the condition and cfar
> > > registers, which we would like to preserve for debugging purposes (for
> > > non-sleep case exception).
> > > 
> > > This patch changes the exception to use the standard format that saves
> > > registers before any tests or branches are made. It adds the test for
> > > idle-wakeup as an "extra" to break out of the normal exception path.
> > > Then it branches to a relocated idle handler that calls the various
> > > idle handling functions.
> > > 
> > > After this patch, POWER8 CPU simulator now boots powernv kernel that is
> > > running at non-zero.
> > > 
> > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> > > Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >  arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
> > >  arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
> > >  2 files changed, 45 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> > > index 2e4e7d8..84d49b1 100644
> > > --- a/arch/powerpc/include/asm/exception-64s.h
> > > +++ b/arch/powerpc/include/asm/exception-64s.h
> > > @@ -93,6 +93,10 @@
> > >  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
> > >  	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> > > 
> > > +#define __LOAD_HANDLER(reg, label)					\
> > > +	ld	reg,PACAKBASE(r13);					\
> > > +	ori	reg,reg,(ABS_ADDR(label))@l;
> > > +
> > >  /* Exception register prefixes */
> > >  #define EXC_HV	H
> > >  #define EXC_STD
> > > @@ -208,6 +212,18 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
> > >  #define kvmppc_interrupt kvmppc_interrupt_pr
> > >  #endif
> > > 
> > > +#ifdef CONFIG_RELOCATABLE
> > > +#define BRANCH_TO_COMMON(reg, label)					\
> > > +	__LOAD_HANDLER(reg, label);					\
> > > +	mtctr	reg;							\
> > > +	bctr
> > > +
> > > +#else
> > > +#define BRANCH_TO_COMMON(reg, label)					\
> > > +	b	label
> > > +
> > > +#endif
> > > +
> > >  #define __KVM_HANDLER_PROLOG(area, n)					\
> > >  	BEGIN_FTR_SECTION_NESTED(947)					\
> > >  	ld	r10,area+EX_CFAR(r13);					\
> > > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > > index 08992f8..e680e84 100644
> > > --- a/arch/powerpc/kernel/exceptions-64s.S
> > > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > > @@ -95,19 +95,35 @@ __start_interrupts:
> > >  /* No virt vectors corresponding with 0x0..0x100 */
> > >  EXC_VIRT_NONE(0x4000, 0x4100)
> > > 
> > > -EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> > > -	SET_SCRATCH0(r13)
> > > +
> > >  #ifdef CONFIG_PPC_P7_NAP
> > > -BEGIN_FTR_SECTION
> > > -	/* Running native on arch 2.06 or later, check if we are
> > > -	 * waking up from nap/sleep/winkle.
> > > +	/*
> > > +	 * If running native on arch 2.06 or later, check if we are waking up
> > > +	 * from nap/sleep/winkle, and branch to idle handler.
> > >  	 */
> > > -	mfspr	r13,SPRN_SRR1
> > > -	rlwinm.	r13,r13,47-31,30,31
> > > -	beq	9f
> > > +#define IDLETEST(n)							\
> > > +	BEGIN_FTR_SECTION ;						\
> > > +	mfspr	r10,SPRN_SRR1 ;						\
> > > +	rlwinm.	r10,r10,47-31,30,31 ;					\
> > > +	beq-	1f ;							\
> > > +	cmpwi	cr3,r10,2 ;						\
> > > +	BRANCH_TO_COMMON(r10, system_reset_idle_common) ;		\
> > > +1:									\
> > > +	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> > > +#else
> > > +#define IDLETEST NOTEST
> > > +#endif
> > > 
> > > -	cmpwi	cr3,r13,2
> > > -	GET_PACA(r13)
> > > +EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> > > +	SET_SCRATCH0(r13)
> > > +	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> > > +				 IDLETEST, 0x100)  
> > 
> > Very sorry for late review. On arch 2.07 and less if we wakeup from
> > winkle then last bit of HSPGR0 would be set to 1. Hence before we access
> > paca we need to fix it by clearing that bit and that is done in
> > pnv_restore_hyp_resource(). But with this patch, we would end up there
> > after going through EXCEPTION_PROLOG_PSERIES(). This macro gets the paca
> > using GET_PACA(r13) and all the EXCEPTION_PROLOG_* starts
> > using/accessing r13/paca without fixing it. Wouldn't this break things
> > badly on arch 2.07 and less ? Am I missing anything ?
> 
> Arg, that's a stupid bug :( Thanks for catching it.
> 
> Would something like the following do the trick, do you think? I obviously
> was not reaching winkle state in my testing.

Yup, that will work.

> 
> Thanks,
> Nick
> 
> ---
>  arch/powerpc/include/asm/exception-64s.h | 13 +++++++++++--
>  arch/powerpc/kernel/exceptions-64s.S     | 11 ++++++++---
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 84d49b1..3ce4366 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -158,14 +158,17 @@ BEGIN_FTR_SECTION_NESTED(943)						\
>  	std	ra,offset(r13);						\
>  END_FTR_SECTION_NESTED(ftr,ftr,943)
> 
> -#define EXCEPTION_PROLOG_0(area)					\
> -	GET_PACA(r13);							\
> +#define EXCEPTION_PROLOG_0_PACA(area)					\
>  	std	r9,area+EX_R9(r13);	/* save r9 */			\
>  	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
>  	HMT_MEDIUM;							\
>  	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
>  	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
> 
> +#define EXCEPTION_PROLOG_0(area)					\
> +	GET_PACA(r13);							\
> +	EXCEPTION_PROLOG_0_PACA(area)
> +
>  #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
>  	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
>  	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
> @@ -196,6 +199,12 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  	EXCEPTION_PROLOG_1(area, extra, vec);				\
>  	EXCEPTION_PROLOG_PSERIES_1(label, h);
> 
> +/* Have the PACA in r13 already */
> +#define EXCEPTION_PROLOG_PSERIES_PACA(area, label, h, extra, vec)	\
> +	EXCEPTION_PROLOG_0_PACA(area);					\
> +	EXCEPTION_PROLOG_1(area, extra, vec);				\
> +	EXCEPTION_PROLOG_PSERIES_1(label, h);
> +
>  #define __KVMTEST(h, n)							\
>  	lbz	r10,HSTATE_IN_GUEST(r13);				\
>  	cmpwi	r10,0;							\
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 08ba447..1ba82ea 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -116,7 +116,9 @@ EXC_VIRT_NONE(0x4000, 0x4100)
> 
>  EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
>  	SET_SCRATCH0(r13)
> -	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> +	GET_PACA(r13)
> +	clrrdi	r13,r13,1 /* Last bit of HSPRG0 is set if waking from winkle */
> +	EXCEPTION_PROLOG_PSERIES_PACA(PACA_EXGEN, system_reset_common, EXC_STD,
>  				 IDLETEST, 0x100)
> 
>  EXC_REAL_END(system_reset, 0x100, 0x200)
> @@ -124,6 +126,9 @@ EXC_VIRT_NONE(0x4100, 0x4200)
> 
>  #ifdef CONFIG_PPC_P7_NAP
>  EXC_COMMON_BEGIN(system_reset_idle_common)
> +BEGIN_FTR_SECTION
> +	GET_PACA(r13) /* Restore HSPRG0 to get the winkle bit in r13 */
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  	bl	pnv_restore_hyp_resource
> 
>  	li	r0,PNV_THREAD_RUNNING
> @@ -169,7 +174,7 @@ EXC_REAL_BEGIN(machine_check, 0x200, 0x300)
>  	SET_SCRATCH0(r13)		/* save r13 */
>  	/*
>  	 * Running native on arch 2.06 or later, we may wakeup from winkle
> -	 * inside machine check. If yes, then last bit of HSPGR0 would be set
> +	 * inside machine check. If yes, then last bit of HSPRG0 would be set
>  	 * to 1. Hence clear it unconditionally.
>  	 */
>  	GET_PACA(r13)
> @@ -388,7 +393,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
>  	/*
>  	 * Go back to winkle. Please note that this thread was woken up in
>  	 * machine check from winkle and have not restored the per-subcore
> -	 * state. Hence before going back to winkle, set last bit of HSPGR0
> +	 * state. Hence before going back to winkle, set last bit of HSPRG0
>  	 * to 1. This will make sure that if this thread gets woken up
>  	 * again at reset vector 0x100 then it will get chance to restore
>  	 * the subcore state.
> -- 
> 2.9.3
> 

-- 
Mahesh J Salgaonkar
