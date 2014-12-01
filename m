Return-Path: <paubert@iram.es>
Received: from navarro.puc.rediris.es (navarro.puc.rediris.es [130.206.18.139])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6371A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 08:35:49 +1100 (AEDT)
Date: Mon, 1 Dec 2014 22:35:27 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
Message-ID: <20141201213527.GA2278@visitor2.iram.es>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2014 at 05:48:40PM +0530, Madhavan Srinivasan wrote:
> This patch create the infrastructure to handle the CR based 
> local_* atomic operations. Local atomic operations are fast 
> and highly reentrant per CPU counters.  Used for percpu 
> variable updates. Local atomic operations only guarantee 
> variable modification atomicity wrt the CPU which owns the
> data and these needs to be executed in a preemption safe way. 
> 
> Here is the design of this patch. Since local_* operations 
> are only need to be atomic to interrupts (IIUC), patch uses 
> one of the Condition Register (CR) fields as a flag variable. When 
> entering the local_*, specific bit in the CR5 field is set
> and on exit, bit is cleared. CR bit checking is done in the
> interrupt return path. If CR5[EQ] bit set and if we return 
> to kernel, we reset to start of local_* operation.
> 
> Reason for this approach is that, currently l[w/d]arx/st[w/d]cx.
> instruction pair is used for local_* operations, which are heavy 
> on cycle count and they dont support a local variant. So to 
> see whether the new implementation helps, used a modified 
> version of Rusty's benchmark code on local_t.   
> 
> https://lkml.org/lkml/2008/12/16/450
> 
> Modifications: 
>  - increated the working set size from 1MB to 8MB,
>  - removed cpu_local_inc test.
> 
> Test ran 
>     - on POWER8 1S Scale out System 2.0GHz
>     - on OPAL v3 with v3.18-rc4 patch kernel as Host
> 
> Here are the values with the patch.
> 
> Time in ns per iteration
> 
> 		inc	add	read	add_return
> atomic_long	67	67	18	69
> irqsave/rest	39	39	23	39
> trivalue	39	39	29	49
> local_t		26	26	24	26
> 
> Since CR5 is used as a flag, have added CFLAGS to avoid CR5 
> for the kernel compilation and CR5 is zeroed at the kernel
> entry.  
> 
> Tested the patch in a 
>  - pSeries LPAR, 
>  - Host with patched/unmodified guest kernel 
> 
> To check whether userspace see any CR5 corruption, ran a simple
> test which does,
>  - set CR5 field,
>  - while(1)
>    - sleep or gettimeofday
>    - chk bit set
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
> - I really appreciate feedback on the patchset.
> - Kindly comment if I should try with any other benchmark or
>     workload to check the numbers.
> - Also, kindly recommand any know stress test for CR
> 
>  Makefile                                 |   6 ++
>  arch/powerpc/include/asm/exception-64s.h |  21 +++++-
>  arch/powerpc/kernel/entry_64.S           | 106 ++++++++++++++++++++++++++++++-
>  arch/powerpc/kernel/exceptions-64s.S     |   2 +-
>  arch/powerpc/kernel/head_64.S            |   8 +++
>  5 files changed, 138 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 00d618b..2e271ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -706,6 +706,12 @@ endif
>  
>  KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)
>  
> +ifdef	CONFIG_PPC64
> +# We need this flag to force compiler not to use CR5, since
> +# local_t type code is based on this.
> +KBUILD_CFLAGS   += -ffixed-cr5
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 77f52b2..c42919a 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -306,7 +306,26 @@ do_kvm_##n:								\
>  	std	r10,0(r1);		/* make stack chain pointer	*/ \
>  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
>  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
> -	beq	4f;			/* if from kernel mode		*/ \
> +BEGIN_FTR_SECTION;							   \
> +	lis	r9,4096;		/* Create a mask with HV and PR */ \
> +	rldicr	r9,r9,32,31;		/* bits, AND with the MSR       */ \
> +	mr	r10,r9;			/* to check for Hyp state       */ \
> +	ori	r9,r9,16384;						   \
> +	and	r9,r12,r9;						   \
> +	cmpd	cr3,r10,r9;							   \
> +	beq	cr3,66f;		/* Jump if we come from Hyp mode*/ \
> +	mtcrf	0x04,r10;		/* Clear CR5 if coming from usr */ \

I think you can do better than this, powerpc has a fantastic set
of rotate and mask instructions. If I understand correctly your
code you can replace it with the following:

	rldicl	r10,r12,4,63       /* Extract HV bit to LSB of r10*/
	rlwinm  r9,r12,19,0x02     /* Extract PR bit to 2nd to last bit of r9 */
	or	r9,r9,10
	cmplwi  cr3,r9,1           /* Check for HV=1 and PR=0 */		
	beq     cr3,66f
	mtcrf   0x04,r10           /* Bits going to cr5 bits are 0 in r10 */

and obviously similarly for the other instances of this code sequence.

This said, mtcrf is not necessarily the fastest way of setting cr5 if
you only want to clear the EQ bit. For example comparing the stack pointer
with 0 should have the same effect.

> +FTR_SECTION_ELSE;							   \
> +	beq	4f;			/* if kernel mode branch        */ \
> +	li	r10,0;			/* Clear CR5 incase of coming   */ \
> +	mtcrf	0x04,r10;		/* from user.                   */ \
> +	nop;				/* This part of code is for     */ \
> +	nop;				/* kernel with MSR[HV]=0,       */ \
> +	nop;				/* MSR[PR]=0, so just chk for   */ \
> +	nop;				/* MSR[PR]                      */ \
> +	nop;								   \
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE);				   \
> +66:	beq	4f;			/* if from kernel mode		*/ \
>  	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
>  	SAVE_PPR(area, r9, r10);					   \
>  4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 0905c8d..e42bb99 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -68,7 +68,26 @@ system_call_common:
>  2:	std	r2,GPR2(r1)
>  	std	r3,GPR3(r1)
>  	mfcr	r2
> -	std	r4,GPR4(r1)
> +BEGIN_FTR_SECTION
> +	lis	r10,4096
> +	rldicr	r10,r10,32,31
> +	mr	r11,r10
> +	ori	r10,r10,16384
> +	and	r10,r12,r10
> +	cmpd	r11,r10
> +	beq	67f
> +	mtcrf	0x04,r11
> +FTR_SECTION_ELSE
> +	beq	67f
> +	li	r11,0
> +	mtcrf	0x04,r11
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> +67:	std	r4,GPR4(r1)
>  	std	r5,GPR5(r1)
>  	std	r6,GPR6(r1)
>  	std	r7,GPR7(r1)
> @@ -224,8 +243,26 @@ syscall_exit:
>  BEGIN_FTR_SECTION
>  	stdcx.	r0,0,r1			/* to clear the reservation */
>  END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
> +BEGIN_FTR_SECTION
> +	lis	r4,4096
> +	rldicr	r4,r4,32,31
> +	mr	r6,r4
> +	ori	r4,r4,16384
> +	and	r4,r8,r4
> +	cmpd	cr3,r6,r4
> +	beq	cr3,65f
> +	mtcr	r5
> +FTR_SECTION_ELSE
>  	andi.	r6,r8,MSR_PR
> -	ld	r4,_LINK(r1)
> +	beq	65f
> +	mtcr	r5
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> +65:	ld	r4,_LINK(r1)
>  
>  	beq-	1f
>  	ACCOUNT_CPU_USER_EXIT(r11, r12)
> @@ -234,7 +271,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
>  1:	ld	r2,GPR2(r1)
>  	ld	r1,GPR1(r1)
>  	mtlr	r4
> +#ifdef	CONFIG_PPC64
> +	mtcrf	0xFB,r5
> +#else
>  	mtcr	r5
> +#endif
>  	mtspr	SPRN_SRR0,r7
>  	mtspr	SPRN_SRR1,r8
>  	RFI
> @@ -804,7 +845,66 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
>  	 */
>  	.globl	fast_exception_return
>  fast_exception_return:
> -	ld	r3,_MSR(r1)
> +
> +	/*
> +	 * Now that we are about to exit from interrupt, lets check for
> +	 * cr5 eq bit. If it is set, then we may be in the middle of
> +	 * local_t update. In this case, we should rewind the NIP
> +	 * accordingly.
> +	 */
> +	mfcr	r3
> +	andi.	r4,r3,0x200
> +	beq	63f

I believe that someonw has already mentioned that this is a very
convoluted way of testing a cr bit. This can be optimized to bne cr5,63f

> +
> +	/*
> +	 * Now that the bit is set, lets check for return to User
> +	 */
> +	ld	r4,_MSR(r1)
> +BEGIN_FTR_SECTION
> +	li	r3,4096
> +	rldicr	r3,r3,32,31
> +	mr	r5,r3
> +	ori	r3,r3,16384
> +	and	r3,r4,r3
> +	cmpd	r5,r3
> +	bne	63f
> +FTR_SECTION_ELSE
> +	andi.	r3,r4,MSR_PR
> +	bne	63f
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> +
> +	/*
> +	 * Looks like we are returning to Kernel, so
> +	 * lets get the NIP and search the ex_table.
> +	 * Change the NIP based on the return value
> +	 */
> +lookup_ex_table:
> +	ld	r3,_NIP(r1)
> +	bl	search_exception_tables	
> +	cmpli	0,1,r3,0
> +	bne	62f
> +
> +	/*
> +	 * This is a panic case. Reason is that, we
> +	 * have the CR5 bit set, but we are not in
> +	 * local_* code and we are returning to Kernel.
> +	 */
> +	ld	r3,_NIP(r1)
> +	mfcr	r4
> +	EMIT_BUG_ENTRY lookup_ex_table, __FILE__,__LINE__,BUGFLAG_WARNING
> +
> +	/*
> +	 * Now save the return fixup address as NIP
> +	 */
> +62:	ld	r4,8(r3)
> +	std	r4,_NIP(r1)
> +	crclr	22
> +63:	ld	r3,_MSR(r1)
>  	ld	r4,_CTR(r1)
>  	ld	r0,_LINK(r1)
>  	mtctr	r4
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 72e783e..edb75a9 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -637,7 +637,7 @@ masked_##_H##interrupt:					\
>  	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
>  	rotldi	r10,r10,16;				\
>  	mtspr	SPRN_##_H##SRR1,r10;			\
> -2:	mtcrf	0x80,r9;				\
> +2:	mtcrf	0x90,r9;				\
>  	ld	r9,PACA_EXGEN+EX_R9(r13);		\
>  	ld	r10,PACA_EXGEN+EX_R10(r13);		\
>  	ld	r11,PACA_EXGEN+EX_R11(r13);		\
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index d48125d..02e49b3 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -347,6 +347,14 @@ __mmu_off:
>   *
>   */
>  __start_initialization_multiplatform:
> +
> +	/*
> +	 * Before we do anything, lets clear CR5 field,
> +	 * so that we will have a clean start at entry
> +	 */
> +	li	r11,0
> +	mtcrf	0x04,r11
> +
>  	/* Make sure we are running in 64 bits mode */
>  	bl	enable_64b_mode
>  


	Regards,
	Gabriel
