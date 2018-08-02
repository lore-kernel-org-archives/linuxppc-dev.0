Return-Path: <srs0=c2be=kr=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h2R84NsrzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 17:50:44 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41h2R83wdyz8tQV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 17:50:44 +1000 (AEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41h2R660GRz9s3q
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2018 17:50:42 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id k19-v6so831580pfi.1
 for <linuxppc-dev@ozlabs.org>; Thu, 02 Aug 2018 00:50:42 -0700 (PDT)
Date: Thu, 2 Aug 2018 17:50:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, Michal Suchanek <msuchanek@suse.com>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 5/8] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
Message-ID: <20180802175030.08765af0@roar.ozlabs.ibm.com>
In-Reply-To: <69168845-6353-a0bc-47ab-24818eb6c661@linux.vnet.ibm.com>
References: <153072695700.29016.8614312307132803349.stgit@jupiter.in.ibm.com>
 <153072708065.29016.482194584457257883.stgit@jupiter.in.ibm.com>
 <20180801155853.3af801c2@roar.ozlabs.ibm.com>
 <69168845-6353-a0bc-47ab-24818eb6c661@linux.vnet.ibm.com>
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

On Thu, 2 Aug 2018 10:30:08 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 08/01/2018 11:28 AM, Nicholas Piggin wrote:
> > On Wed, 04 Jul 2018 23:28:21 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >   
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> On pseries, as of today system crashes if we get a machine check
> >> exceptions due to SLB errors. These are soft errors and can be fixed by
> >> flushing the SLBs so the kernel can continue to function instead of
> >> system crash. We do this in real mode before turning on MMU. Otherwise
> >> we would run into nested machine checks. This patch now fetches the
> >> rtas error log in real mode and flushes the SLBs on SLB errors.
> >>
> >> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 
> >>  arch/powerpc/include/asm/machdep.h            |    1 
> >>  arch/powerpc/kernel/exceptions-64s.S          |   42 +++++++++++++++++++++
> >>  arch/powerpc/kernel/mce.c                     |   16 +++++++-
> >>  arch/powerpc/mm/slb.c                         |    6 +++
> >>  arch/powerpc/platforms/pseries/pseries.h      |    1 
> >>  arch/powerpc/platforms/pseries/ras.c          |   51 +++++++++++++++++++++++++
> >>  arch/powerpc/platforms/pseries/setup.c        |    1 
> >>  8 files changed, 116 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> >> index 50ed64fba4ae..cc00a7088cf3 100644
> >> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> >> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> >> @@ -487,6 +487,7 @@ extern void hpte_init_native(void);
> >>  
> >>  extern void slb_initialize(void);
> >>  extern void slb_flush_and_rebolt(void);
> >> +extern void slb_flush_and_rebolt_realmode(void);
> >>  
> >>  extern void slb_vmalloc_update(void);
> >>  extern void slb_set_size(u16 size);
> >> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> >> index ffe7c71e1132..fe447e0d4140 100644
> >> --- a/arch/powerpc/include/asm/machdep.h
> >> +++ b/arch/powerpc/include/asm/machdep.h
> >> @@ -108,6 +108,7 @@ struct machdep_calls {
> >>  
> >>  	/* Early exception handlers called in realmode */
> >>  	int		(*hmi_exception_early)(struct pt_regs *regs);
> >> +	int		(*machine_check_early)(struct pt_regs *regs);
> >>  
> >>  	/* Called during machine check exception to retrive fixup address. */
> >>  	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
> >> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> >> index f283958129f2..0038596b7906 100644
> >> --- a/arch/powerpc/kernel/exceptions-64s.S
> >> +++ b/arch/powerpc/kernel/exceptions-64s.S
> >> @@ -332,6 +332,9 @@ TRAMP_REAL_BEGIN(machine_check_pSeries)
> >>  machine_check_fwnmi:
> >>  	SET_SCRATCH0(r13)		/* save r13 */
> >>  	EXCEPTION_PROLOG_0(PACA_EXMC)
> >> +BEGIN_FTR_SECTION
> >> +	b	machine_check_pSeries_early
> >> +END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
> >>  machine_check_pSeries_0:
> >>  	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
> >>  	/*
> >> @@ -343,6 +346,45 @@ machine_check_pSeries_0:
> >>  
> >>  TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
> >>  
> >> +TRAMP_REAL_BEGIN(machine_check_pSeries_early)
> >> +BEGIN_FTR_SECTION
> >> +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> >> +	mr	r10,r1			/* Save r1 */
> >> +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
> >> +	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
> >> +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
> >> +	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
> >> +	EXCEPTION_PROLOG_COMMON_1()
> >> +	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> >> +	EXCEPTION_PROLOG_COMMON_3(0x200)
> >> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> >> +	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call ABI */
> >> +
> >> +	/* Move original SRR0 and SRR1 into the respective regs */
> >> +	ld	r9,_MSR(r1)
> >> +	mtspr	SPRN_SRR1,r9
> >> +	ld	r3,_NIP(r1)
> >> +	mtspr	SPRN_SRR0,r3
> >> +	ld	r9,_CTR(r1)
> >> +	mtctr	r9
> >> +	ld	r9,_XER(r1)
> >> +	mtxer	r9
> >> +	ld	r9,_LINK(r1)
> >> +	mtlr	r9
> >> +	REST_GPR(0, r1)
> >> +	REST_8GPRS(2, r1)
> >> +	REST_GPR(10, r1)
> >> +	ld	r11,_CCR(r1)
> >> +	mtcr	r11
> >> +	REST_GPR(11, r1)
> >> +	REST_2GPRS(12, r1)
> >> +	/* restore original r1. */
> >> +	ld	r1,GPR1(r1)
> >> +	SET_SCRATCH0(r13)		/* save r13 */
> >> +	EXCEPTION_PROLOG_0(PACA_EXMC)
> >> +	b	machine_check_pSeries_0
> >> +END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
> >> +
> >>  EXC_COMMON_BEGIN(machine_check_common)
> >>  	/*
> >>  	 * Machine check is different because we use a different
> >> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> >> index efdd16a79075..221271c96a57 100644
> >> --- a/arch/powerpc/kernel/mce.c
> >> +++ b/arch/powerpc/kernel/mce.c
> >> @@ -488,9 +488,21 @@ long machine_check_early(struct pt_regs *regs)
> >>  {
> >>  	long handled = 0;
> >>  
> >> -	__this_cpu_inc(irq_stat.mce_exceptions);
> >> +	/*
> >> +	 * For pSeries we count mce when we go into virtual mode machine
> >> +	 * check handler. Hence skip it. Also, We can't access per cpu
> >> +	 * variables in real mode for LPAR.
> >> +	 */
> >> +	if (early_cpu_has_feature(CPU_FTR_HVMODE))
> >> +		__this_cpu_inc(irq_stat.mce_exceptions);
> >>  
> >> -	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
> >> +	/*
> >> +	 * See if platform is capable of handling machine check.
> >> +	 * Otherwise fallthrough and allow CPU to handle this machine check.
> >> +	 */
> >> +	if (ppc_md.machine_check_early)
> >> +		handled = ppc_md.machine_check_early(regs);
> >> +	else if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
> >>  		handled = cur_cpu_spec->machine_check_early(regs);
> >>  	return handled;
> >>  }  
> > 
> > This looks fine to me after Michal's patch. Not sure if you want to
> > fold them or add his immediately after this one in your series.  
> 
> I am planning to fold Michal's patch into this patch itself.
> 
> >   
> >> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> >> index 66577cc66dc9..5b1813b98358 100644
> >> --- a/arch/powerpc/mm/slb.c
> >> +++ b/arch/powerpc/mm/slb.c
> >> @@ -145,6 +145,12 @@ void slb_flush_and_rebolt(void)
> >>  	get_paca()->slb_cache_ptr = 0;
> >>  }
> >>  
> >> +void slb_flush_and_rebolt_realmode(void)
> >> +{
> >> +	__slb_flush_and_rebolt();
> >> +	get_paca()->slb_cache_ptr = 0;
> >> +}  
> > 
> > 
> > I think this should do something more like flush_and_reload_slb from
> > powernv machine check code. We are real mode so should invalidate all
> > SLBs.  
> 
> Yes, and I think even powernv code should use this one instead. But that
> can be a separate patch.

Well I've already got one written for the idle code, so I'll split that
out and send that to powerpc next first, so both our patches can use it.

> > It happens I also need very similar code (without the initial
> > invalidate) for implementing idle wakeup code in C, so we should move
> > that function and variants into mm/slb.c IMO.  
> 
> So, you looking for only rebolt part ?

Yes it's already flushed after we come back from deep idle state, so
no need for another flush.

Thanks,
Nick
