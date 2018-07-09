Return-Path: <srs0=v2pl=jz=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PVTx43ljzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 02:02:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41PVTx3ZXzz8vNM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 02:02:45 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41PVTw3cBcz9rvt
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2018 02:02:42 +1000 (AEST)
Date: Mon, 9 Jul 2018 18:02:39 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 8/8] powernv/pseries: consolidate code for mce early
 handling.
Message-ID: <20180709180239.3646bf39@kitsune.suse.cz>
In-Reply-To: <20180706194024.5282bf74@roar.ozlabs.ibm.com>
References: <153072695700.29016.8614312307132803349.stgit@jupiter.in.ibm.com>
 <153072717270.29016.18207683951100257477.stgit@jupiter.in.ibm.com>
 <20180706194024.5282bf74@roar.ozlabs.ibm.com>
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

On Fri, 6 Jul 2018 19:40:24 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Wed, 04 Jul 2018 23:30:12 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > Now that other platforms also implements real mode mce handler,
> > lets consolidate the code by sharing existing powernv machine check
> > early code. Rename machine_check_powernv_early to
> > machine_check_common_early and reuse the code.
> > 
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S |   56
> > +++++++--------------------------- 1 file changed, 11
> > insertions(+), 45 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S
> > b/arch/powerpc/kernel/exceptions-64s.S index
> > 0038596b7906..3e877ec55d50 100644 ---
> > a/arch/powerpc/kernel/exceptions-64s.S +++
> > b/arch/powerpc/kernel/exceptions-64s.S @@ -243,14 +243,13 @@
> > EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
> > SET_SCRATCH0(r13)		/* save r13 */
> > EXCEPTION_PROLOG_0(PACA_EXMC) BEGIN_FTR_SECTION
> > -	b	machine_check_powernv_early
> > +	b	machine_check_common_early
> >  FTR_SECTION_ELSE
> >  	b	machine_check_pSeries_0
> >  ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> >  EXC_REAL_END(machine_check, 0x200, 0x100)
> >  EXC_VIRT_NONE(0x4200, 0x100)
> > -TRAMP_REAL_BEGIN(machine_check_powernv_early)
> > -BEGIN_FTR_SECTION
> > +TRAMP_REAL_BEGIN(machine_check_common_early)
> >  	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> >  	/*
> >  	 * Register contents:
> > @@ -306,7 +305,9 @@ BEGIN_FTR_SECTION
> >  	/* Save r9 through r13 from EXMC save area to stack frame.
> > */ EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> >  	mfmsr	r11			/* get MSR value */
> > +BEGIN_FTR_SECTION
> >  	ori	r11,r11,MSR_ME		/* turn on ME bit
> > */ +END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> >  	ori	r11,r11,MSR_RI		/* turn on RI bit
> > */ LOAD_HANDLER(r12, machine_check_handle_early)
> >  1:	mtspr	SPRN_SRR0,r12
> > @@ -325,7 +326,6 @@ BEGIN_FTR_SECTION
> >  	andc	r11,r11,r10		/* Turn off MSR_ME
> > */ b	1b
> >  	b	.	/* prevent speculative execution */
> > -END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> >  
> >  TRAMP_REAL_BEGIN(machine_check_pSeries)
> >  	.globl machine_check_fwnmi
> > @@ -333,7 +333,7 @@ machine_check_fwnmi:
> >  	SET_SCRATCH0(r13)		/* save r13 */
> >  	EXCEPTION_PROLOG_0(PACA_EXMC)
> >  BEGIN_FTR_SECTION
> > -	b	machine_check_pSeries_early
> > +	b	machine_check_common_early
> >  END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
> >  machine_check_pSeries_0:
> >  	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
> > @@ -346,45 +346,6 @@ machine_check_pSeries_0:
> >  
> >  TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
> >  
> > -TRAMP_REAL_BEGIN(machine_check_pSeries_early)
> > -BEGIN_FTR_SECTION
> > -	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> > -	mr	r10,r1			/* Save r1 */
> > -	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency
> > stack */
> > -	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack
> > frame		*/
> > -	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
> > -	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
> > -	EXCEPTION_PROLOG_COMMON_1()
> > -	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> > -	EXCEPTION_PROLOG_COMMON_3(0x200)
> > -	addi	r3,r1,STACK_FRAME_OVERHEAD
> > -	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call
> > ABI */ -
> > -	/* Move original SRR0 and SRR1 into the respective regs */
> > -	ld	r9,_MSR(r1)
> > -	mtspr	SPRN_SRR1,r9
> > -	ld	r3,_NIP(r1)
> > -	mtspr	SPRN_SRR0,r3
> > -	ld	r9,_CTR(r1)
> > -	mtctr	r9
> > -	ld	r9,_XER(r1)
> > -	mtxer	r9
> > -	ld	r9,_LINK(r1)
> > -	mtlr	r9
> > -	REST_GPR(0, r1)
> > -	REST_8GPRS(2, r1)
> > -	REST_GPR(10, r1)
> > -	ld	r11,_CCR(r1)
> > -	mtcr	r11
> > -	REST_GPR(11, r1)
> > -	REST_2GPRS(12, r1)
> > -	/* restore original r1. */
> > -	ld	r1,GPR1(r1)
> > -	SET_SCRATCH0(r13)		/* save r13 */
> > -	EXCEPTION_PROLOG_0(PACA_EXMC)
> > -	b	machine_check_pSeries_0
> > -END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
> > -
> >  EXC_COMMON_BEGIN(machine_check_common)
> >  	/*
> >  	 * Machine check is different because we use a different
> > @@ -483,6 +444,9 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
> >  	bl	machine_check_early
> >  	std	r3,RESULT(r1)	/* Save result */
> >  	ld	r12,_MSR(r1)
> > +BEGIN_FTR_SECTION
> > +	bne	9f			/* pSeries: continue
> > to V mode. */ +END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)  
> 
> Should this be "b 9f" ? Although...
> 
> >  
> >  #ifdef	CONFIG_PPC_P7_NAP
> >  	/*
> > @@ -564,7 +528,9 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
> >  9:
> >  	/* Deliver the machine check to host kernel in V mode. */
> >  	MACHINE_CHECK_HANDLER_WINDUP
> > -	b	machine_check_pSeries
> > +	SET_SCRATCH0(r13)		/* save r13 */
> > +	EXCEPTION_PROLOG_0(PACA_EXMC)
> > +	b	machine_check_pSeries_0  
> 
> I'm not sure that's quite right. You're missing out testing the result
> of the early handler call? Is this buggy in existing code too? We
> should be testing that result in all cases, shouldn't we? But it
> doesn't seem like we are.

At least for the pSeries case the result of realmode handler is stored
in the MCE log data. Both the real and virtual part of the handler
should be called in any case. They do different and independent things.

Thanks

Michal
