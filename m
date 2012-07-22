Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: SMT priority (PPR) save and restore
In-reply-to: <1342863499.28370.41.camel@hbabu-laptop>
References: <1342259024.11305.38.camel@hbabu-laptop>
 <31198.1342410079@neuling.org> <1342863499.28370.41.camel@hbabu-laptop>
Date: Mon, 23 Jul 2012 08:04:49 +1000
Message-ID: <14399.1342994689@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Haren Myneni <haren@linux.vnet.ibm.com> wrote:
> On Mon, 2012-07-16 at 13:41 +1000, Michael Neuling wrote:
> > Heaven Myneni <haren@linux.vnet.ibm.com> wrote:
> > 
> > > powerpc: SMT priority (PPR) save and restore

<snip>

> > Can you break this patch into a few parts that are easier to review than
> > one giant patch.  Start by adding the PPR ftr bits, then the extra space
> > in the paca, then the new macros, then use the new infrastructure.  I'm
> > sure you can get 5 or so patches which will be much easier to review.
> > 
> > Also this has been white space munged.  See here:
> >   http://patchwork.ozlabs.org/patch/170993/
> > All the #defines are broken.
> > 
> > Also, do you know what the impacts of this are on null syscall/page
> > faults etc on machines which need the PPR switched?  If it's big, we
> > might want to have this as a CONFIG option for those who don't care and
> > want the speed bump.
> 
> Thanks for your comments. Sure will split this patch in to 5/6 patches. 
> With Anton's num_syscall test  -
> http://ozlabs.org/~anton/junkcode/null_syscall.c, noticed 6% overhead.
> As you suggested, will add CONFIG option for this feature. 

Eek.. 6%.. yes, definitely a CONFIG option then.

> Sorry, my e-mail client messed-up some tabs. will post next time
> properly.
> 
> Please see my responses below. 

ok

> > > +
> > >  #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
> > >  	GET_PACA(r13);							\
> > > -	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
> > > -	std	r10,area+EX_R10(r13);					\
> > > +	std	r9,area+EX_R9(r13);	/* save r9 */			\
> > > +	HMT_FTR_HAS_PPR(area,r9); 					\
> > > +	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
> > >  	BEGIN_FTR_SECTION_NESTED(66);					\
> > >  	mfspr	r10,SPRN_CFAR;						\
> > >  	std	r10,area+EX_CFAR(r13);					\
> > > @@ -176,8 +213,10 @@ do_kvm_##n:								\
> > >  	std	r10,0(r1);		/* make stack chain pointer	*/ \
> > >  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
> > >  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
> > > +	beq	4f;							   \
> > >  	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
> > > -	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
> > > +	SAVE_PPR(area, r9, r10);					   \
> > > +4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
> > 
> > why are we no longer doing ACCOUNT_CPU_USER_ENTRY here?
> 
> No, we still doing ACCOUNT_CPU_USER_ENTRY for the user level exceptions.
> The existing code (ACCOUNT_CPU_USER_ENTRY macro) has the same branch
> instruction and skipping for exceptions coming from kernel. I just
> removed 'beq' in ACCOUNT_CPU_USER_ENTRY macro and added here since PPR
> saving will be done only for user level exceptions. 
> 
> Adding comment for this branch instruction and create a separate patch
> just for the related changes should make it more clear. 

OK.

This is why it's good to split the patch into multiple parts so that you
can explain these in the associated checking comments.

> > > -	HMT_MEDIUM;
> > > +	HMT_FTR_NO_PPR  
> > 
> > Can we call this something else like HMT_MEDIUM_NO_PPR?
> 
> I will make the change. Similarly HMT_FTR_HAS_PPR should be changed to
> HMT_MEDIUM_HAS_PPR. 

Cool, bike shedding complete :-)

Mikey

> 
> 
> > 
> > 
> > 
> > >  	SET_SCRATCH0(r13)
> > >  #ifdef CONFIG_PPC_P7_NAP
> > >  BEGIN_FTR_SECTION
> > > @@ -94,7 +94,7 @@ machine_check_pSeries_1:
> > >  	. = 0x300
> > >  	.globl data_access_pSeries
> > >  data_access_pSeries:
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR
> > >  	SET_SCRATCH0(r13)
> > >  BEGIN_FTR_SECTION
> > >  	b	data_access_check_stab
> > > @@ -106,7 +106,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
> > >  	. = 0x380
> > >  	.globl data_access_slb_pSeries
> > >  data_access_slb_pSeries:
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR  
> > >  	SET_SCRATCH0(r13)
> > >  	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
> > >  	std	r3,PACA_EXSLB+EX_R3(r13)
> > > @@ -137,7 +137,7 @@ data_access_slb_pSeries:
> > >  	. = 0x480
> > >  	.globl instruction_access_slb_pSeries
> > >  instruction_access_slb_pSeries:
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR  
> > >  	SET_SCRATCH0(r13)
> > >  	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
> > >  	std	r3,PACA_EXSLB+EX_R3(r13)
> > > @@ -197,7 +197,7 @@ hardware_interrupt_hv:
> > >  	. = 0xc00
> > >  	.globl	system_call_pSeries
> > >  system_call_pSeries:
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR  
> > >  #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
> > >  	SET_SCRATCH0(r13)
> > >  	GET_PACA(r13)
> > > @@ -213,6 +213,7 @@ BEGIN_FTR_SECTION
> > >  END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
> > >  	mr	r9,r13
> > >  	GET_PACA(r13)
> > > +	HMT_FTR_HAS_PPR(PACA_EXGEN,r10)
> > >  	mfspr	r11,SPRN_SRR0
> > >  	mfspr	r12,SPRN_SRR1
> > >  	ld	r10,PACAKBASE(r13)
> > > @@ -295,7 +296,7 @@ vsx_unavailable_pSeries_1:
> > >  machine_check_pSeries:
> > >  	.globl machine_check_fwnmi
> > >  machine_check_fwnmi:
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR  
> > >  	SET_SCRATCH0(r13)		/* save r13 */
> > >  	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
> > >  				 EXC_STD, KVMTEST, 0x200)
> > > @@ -417,7 +418,7 @@ _GLOBAL(__replay_interrupt)
> > >  	.globl system_reset_fwnmi
> > >        .align 7
> > >  system_reset_fwnmi:
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR  
> > >  	SET_SCRATCH0(r13)		/* save r13 */
> > >  	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> > >  				 NOTEST, 0x100)
> > > @@ -717,7 +718,8 @@ _GLOBAL(slb_miss_realmode)
> > >  	mtcrf	0x80,r9
> > >  	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
> > >  .machine	pop
> > > -
> > > +	
> > 
> > Random whitespace change.
> > 
> > > +	RESTORE_PPR_PACA(PACA_EXSLB,r9)		
> > >  	ld	r9,PACA_EXSLB+EX_R9(r13)
> > >  	ld	r10,PACA_EXSLB+EX_R10(r13)
> > >  	ld	r11,PACA_EXSLB+EX_R11(r13)
> > > @@ -1048,7 +1050,7 @@ initial_stab:
> > >  
> > >  #ifdef CONFIG_PPC_POWERNV
> > >  _GLOBAL(opal_mc_secondary_handler)
> > > -	HMT_MEDIUM
> > > +	HMT_FTR_NO_PPR  
> > >  	SET_SCRATCH0(r13)
> > >  	GET_PACA(r13)
> > >  	clrldi	r3,r3,2
> > > 
> > > 
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 
> 
