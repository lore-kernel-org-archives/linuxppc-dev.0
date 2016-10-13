Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svq093WQmzDt0n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:54:33 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id os4so644841pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 04:54:33 -0700 (PDT)
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161013021714.6624-1-npiggin@gmail.com>
Cc: "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <25f4c10b-c961-6ed4-f2e1-437bcfba5321@gmail.com>
Date: Thu, 13 Oct 2016 22:54:32 +1100
MIME-Version: 1.0
In-Reply-To: <20161013021714.6624-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/10/16 13:17, Nicholas Piggin wrote:
> This patch does a couple of things. First of all, powernv immediately
> explodes when running a relocated kernel, because the system reset
> exception for handling sleeps does not do correct relocated branches.
> 
> Secondly, the sleep handling code trashes the condition and cfar
> registers, which we would like to preserve for debugging purposes (for
> non-sleep case exception).

Agreed, that is a good side, we also save the PPR in r9 and set the
PPR to HMT_MEDIUM

> 
> This patch changes the exception to use the standard format that saves
> registers before any tests or branches are made. It adds the test for
> idle-wakeup as an "extra" to break out of the normal exception path.
> Then it branches to a relocated idle handler that calls the various
> idle handling functions.
> 
> After this patch, POWER8 CPU simulator now boots powernv kernel that is
> running at non-zero.
> 

Yep, a much required fixup. I had done a version before your changes

> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
>  arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
>  2 files changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 2e4e7d8..84d49b1 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -93,6 +93,10 @@
>  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
>  	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
>  
> +#define __LOAD_HANDLER(reg, label)					\

I wonder if it is a good idea to trap

.if (reg == 13);
.error "Don't use r13";
.abort;
.endif;

> +	ld	reg,PACAKBASE(r13);					\
> +	ori	reg,reg,(ABS_ADDR(label))@l;
> +
>  /* Exception register prefixes */
>  #define EXC_HV	H
>  #define EXC_STD
> @@ -208,6 +212,18 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  #define kvmppc_interrupt kvmppc_interrupt_pr
>  #endif
>  
> +#ifdef CONFIG_RELOCATABLE
> +#define BRANCH_TO_COMMON(reg, label)					\
> +	__LOAD_HANDLER(reg, label);					\
> +	mtctr	reg;							\
> +	bctr
> +
> +#else
> +#define BRANCH_TO_COMMON(reg, label)					\
> +	b	label
> +
> +#endif
> +
>  #define __KVM_HANDLER_PROLOG(area, n)					\
>  	BEGIN_FTR_SECTION_NESTED(947)					\
>  	ld	r10,area+EX_CFAR(r13);					\
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 08992f8..e680e84 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -95,19 +95,35 @@ __start_interrupts:
>  /* No virt vectors corresponding with 0x0..0x100 */
>  EXC_VIRT_NONE(0x4000, 0x4100)
>  
> -EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> -	SET_SCRATCH0(r13)
> +
>  #ifdef CONFIG_PPC_P7_NAP
> -BEGIN_FTR_SECTION
> -	/* Running native on arch 2.06 or later, check if we are
> -	 * waking up from nap/sleep/winkle.
> +	/*
> +	 * If running native on arch 2.06 or later, check if we are waking up
> +	 * from nap/sleep/winkle, and branch to idle handler.
>  	 */
> -	mfspr	r13,SPRN_SRR1
> -	rlwinm.	r13,r13,47-31,30,31
> -	beq	9f
> +#define IDLETEST(n)							\
> +	BEGIN_FTR_SECTION ;						\
> +	mfspr	r10,SPRN_SRR1 ;						\
> +	rlwinm.	r10,r10,47-31,30,31 ;					\
> +	beq-	1f ;							\
> +	cmpwi	cr3,r10,2 ;						\
> +	BRANCH_TO_COMMON(r10, system_reset_idle_common) ;		\
> +1:									\
> +	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> +#else
> +#define IDLETEST NOTEST
> +#endif
>  
> -	cmpwi	cr3,r13,2
> -	GET_PACA(r13)
> +EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> +	SET_SCRATCH0(r13)
> +	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> +				 IDLETEST, 0x100)
> +
> +EXC_REAL_END(system_reset, 0x100, 0x200)
> +EXC_VIRT_NONE(0x4100, 0x4200)
> +
> +#ifdef CONFIG_PPC_P7_NAP
> +EXC_COMMON_BEGIN(system_reset_idle_common)
>  	bl	pnv_restore_hyp_resource
>  
>  	li	r0,PNV_THREAD_RUNNING
> @@ -130,14 +146,8 @@ BEGIN_FTR_SECTION
>  	blt	cr3,2f
>  	b	pnv_wakeup_loss
>  2:	b	pnv_wakeup_noloss
> +#endif
>  
> -9:
> -END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> -#endif /* CONFIG_PPC_P7_NAP */
> -	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> -				 NOTEST, 0x100)
> -EXC_REAL_END(system_reset, 0x100, 0x200)
> -EXC_VIRT_NONE(0x4100, 0x4200)
>  EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
>  
>  #ifdef CONFIG_PPC_PSERIES
> @@ -817,10 +827,8 @@ EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
>  TRAMP_KVM(PACA_EXGEN, 0xb00)
>  EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
>  
> -
> -#define LOAD_SYSCALL_HANDLER(reg)				\
> -	ld	reg,PACAKBASE(r13);				\
> -	ori	reg,reg,(ABS_ADDR(system_call_common))@l;
> +#define LOAD_SYSCALL_HANDLER(reg)					\
> +	__LOAD_HANDLER(reg, system_call_common)
>  
>  /* Syscall routine is used twice, in reloc-off and reloc-on paths */
>  #define SYSCALL_PSERIES_1 					\
> 

Acked-by: Balbir Singh <bsingharora@gmail.com>
