Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71412B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 05:04:48 +1100 (EST)
Subject: Re: [PATCH 12/38] powerpc/booke: Provide exception macros with
 interrupt name
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330474206-14794-13-git-send-email-agraf@suse.de>
Date: Wed, 21 Mar 2012 13:04:43 -0500
Message-Id: <29EC69C4-816F-4B9E-9834-71176D2DECB9@kernel.crashing.org>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
 <1330474206-14794-13-git-send-email-agraf@suse.de>
To: Alexander Graf <agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 28, 2012, at 6:09 PM, Alexander Graf wrote:

> From: Scott Wood <scottwood@freescale.com>
>=20
> DO_KVM will need to identify the particular exception type.
>=20
> There is an existing set of arbitrary numbers that Linux passes,
> but it's an undocumented mess that sort of corresponds to =
server/classic
> exception vectors but not really.

So what do the new names correspond to?  What header is defining =
MACHINE_CHECK, BOOKE_INTERRUPT_EXTERNAL, etc (asm/kvm_asm.h)?  If so we =
really should move these out of asm/kvm_asm.h and into something a bit =
more appropriate.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
> arch/powerpc/kernel/head_44x.S       |   23 +++++++++------
> arch/powerpc/kernel/head_booke.h     |   41 ++++++++++++++------------
> arch/powerpc/kernel/head_fsl_booke.S |   52 =
+++++++++++++++++++++-------------
> 3 files changed, 68 insertions(+), 48 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/head_44x.S =
b/arch/powerpc/kernel/head_44x.S
> index 7dd2981..d1192c5 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -248,10 +248,11 @@ _ENTRY(_start);
>=20
> interrupt_base:
> 	/* Critical Input Interrupt */
> -	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
> +	CRITICAL_EXCEPTION(0x0100, CRITICAL, CriticalInput, =
unknown_exception)
>=20
> 	/* Machine Check Interrupt */
> -	CRITICAL_EXCEPTION(0x0200, MachineCheck, =
machine_check_exception)
> +	CRITICAL_EXCEPTION(0x0200, MACHINE_CHECK, MachineCheck, \
> +			   machine_check_exception)
> 	MCHECK_EXCEPTION(0x0210, MachineCheckA, machine_check_exception)
>=20
> 	/* Data Storage Interrupt */
> @@ -261,7 +262,8 @@ interrupt_base:
> 	INSTRUCTION_STORAGE_EXCEPTION
>=20
> 	/* External Input Interrupt */
> -	EXCEPTION(0x0500, ExternalInput, do_IRQ, EXC_XFER_LITE)
> +	EXCEPTION(0x0500, BOOKE_INTERRUPT_EXTERNAL, ExternalInput, \
> +		  do_IRQ, EXC_XFER_LITE)
>=20
> 	/* Alignment Interrupt */
> 	ALIGNMENT_EXCEPTION
> @@ -273,29 +275,32 @@ interrupt_base:
> #ifdef CONFIG_PPC_FPU
> 	FP_UNAVAILABLE_EXCEPTION
> #else
> -	EXCEPTION(0x2010, FloatingPointUnavailable, unknown_exception, =
EXC_XFER_EE)
> +	EXCEPTION(0x2010, BOOKE_INTERRUPT_FP_UNAVAIL, \
> +		  FloatingPointUnavailable, unknown_exception, =
EXC_XFER_EE)
> #endif
> 	/* System Call Interrupt */
> 	START_EXCEPTION(SystemCall)
> -	NORMAL_EXCEPTION_PROLOG
> +	NORMAL_EXCEPTION_PROLOG(BOOKE_INTERRUPT_SYSCALL)
> 	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
>=20
> 	/* Auxiliary Processor Unavailable Interrupt */
> -	EXCEPTION(0x2020, AuxillaryProcessorUnavailable, =
unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0x2020, BOOKE_INTERRUPT_AP_UNAVAIL, \
> +		  AuxillaryProcessorUnavailable, unknown_exception, =
EXC_XFER_EE)
>=20
> 	/* Decrementer Interrupt */
> 	DECREMENTER_EXCEPTION
>=20
> 	/* Fixed Internal Timer Interrupt */
> 	/* TODO: Add FIT support */
> -	EXCEPTION(0x1010, FixedIntervalTimer, unknown_exception, =
EXC_XFER_EE)
> +	EXCEPTION(0x1010, BOOKE_INTERRUPT_FIT, FixedIntervalTimer, \
> +		  unknown_exception, EXC_XFER_EE)
>=20
> 	/* Watchdog Timer Interrupt */
> 	/* TODO: Add watchdog support */
> #ifdef CONFIG_BOOKE_WDT
> -	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, WatchdogException)
> +	CRITICAL_EXCEPTION(0x1020, WATCHDOG, WatchdogTimer, =
WatchdogException)
> #else
> -	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, unknown_exception)
> +	CRITICAL_EXCEPTION(0x1020, WATCHDOG, WatchdogTimer, =
unknown_exception)
> #endif
>=20
> 	/* Data TLB Error Interrupt */
> diff --git a/arch/powerpc/kernel/head_booke.h =
b/arch/powerpc/kernel/head_booke.h
> index fc921bf..06ab353 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -2,6 +2,8 @@
> #define __HEAD_BOOKE_H__
>=20
> #include <asm/ptrace.h>	/* for STACK_FRAME_REGS_MARKER */
> +#include <asm/kvm_asm.h>
> +
> /*
>  * Macros used for common Book-e exception handling
>  */
> @@ -28,7 +30,7 @@
>  */
> #define THREAD_NORMSAVE(offset)	(THREAD_NORMSAVES + (offset * =
4))
>=20
> -#define NORMAL_EXCEPTION_PROLOG						=
     \
> +#define NORMAL_EXCEPTION_PROLOG(intno)					=
	     \
> 	mtspr	SPRN_SPRG_WSCRATCH0, r10;	/* save one register */	 =
    \
> 	mfspr	r10, SPRN_SPRG_THREAD;					 =
    \
> 	stw	r11, THREAD_NORMSAVE(0)(r10);				 =
    \
> @@ -113,7 +115,7 @@
>  * registers as the normal prolog above. Instead we use a portion of =
the
>  * critical/machine check exception stack at low physical addresses.
>  */
> -#define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, =
exc_level_srr1) \
> +#define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, intno, exc_level_srr0, =
exc_level_srr1) \
> 	mtspr	SPRN_SPRG_WSCRATCH_##exc_level,r8;			 =
    \
> 	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the =
exc_level stack*/ \
> 	stw	r9,GPR9(r8);		/* save various registers	 =
  */\
> @@ -162,12 +164,13 @@
> 	SAVE_4GPRS(3, r11);						 =
    \
> 	SAVE_2GPRS(7, r11)
>=20
> -#define CRITICAL_EXCEPTION_PROLOG \
> -		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1)
> +#define CRITICAL_EXCEPTION_PROLOG(intno) \
> +		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, intno, SPRN_CSRR0, =
SPRN_CSRR1)
> #define DEBUG_EXCEPTION_PROLOG \
> -		EXC_LEVEL_EXCEPTION_PROLOG(DBG, SPRN_DSRR0, SPRN_DSRR1)
> +		EXC_LEVEL_EXCEPTION_PROLOG(DBG, DEBUG, SPRN_DSRR0, =
SPRN_DSRR1)
> #define MCHECK_EXCEPTION_PROLOG \
> -		EXC_LEVEL_EXCEPTION_PROLOG(MC, SPRN_MCSRR0, SPRN_MCSRR1)
> +		EXC_LEVEL_EXCEPTION_PROLOG(MC, MACHINE_CHECK, \
> +			SPRN_MCSRR0, SPRN_MCSRR1)
>=20
> /*
>  * Exception vectors.
> @@ -181,16 +184,16 @@ label:
> 	.long	func;						\
> 	.long	ret_from_except_full
>=20
> -#define EXCEPTION(n, label, hdlr, xfer)				=
\
> +#define EXCEPTION(n, intno, label, hdlr, xfer)			=
\
> 	START_EXCEPTION(label);					\
> -	NORMAL_EXCEPTION_PROLOG;				\
> +	NORMAL_EXCEPTION_PROLOG(intno);				\
> 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
> 	xfer(n, hdlr)
>=20
> -#define CRITICAL_EXCEPTION(n, label, hdlr)			\
> -	START_EXCEPTION(label);					\
> -	CRITICAL_EXCEPTION_PROLOG;				\
> -	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
> +#define CRITICAL_EXCEPTION(n, intno, label, hdlr)			=
\
> +	START_EXCEPTION(label);						=
\
> +	CRITICAL_EXCEPTION_PROLOG(intno);				=
\
> +	addi	r3,r1,STACK_FRAME_OVERHEAD;				=
\
> 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & =
~(MSR_ME|MSR_DE|MSR_CE)), \
> 			  NOCOPY, crit_transfer_to_handler, \
> 			  ret_from_crit_exc)
> @@ -302,7 +305,7 @@ label:
>=20
> #define DEBUG_CRIT_EXCEPTION						 =
     \
> 	START_EXCEPTION(DebugCrit);					 =
     \
> -	CRITICAL_EXCEPTION_PROLOG;					 =
     \
> +	CRITICAL_EXCEPTION_PROLOG(DEBUG);				 =
     \
> 									 =
     \
> 	/*								 =
     \
> 	 * If there is a single step or branch-taken exception in an	 =
     \
> @@ -355,7 +358,7 @@ label:
>=20
> #define DATA_STORAGE_EXCEPTION						=
      \
> 	START_EXCEPTION(DataStorage)					 =
     \
> -	NORMAL_EXCEPTION_PROLOG;					 =
     \
> +	NORMAL_EXCEPTION_PROLOG(DATA_STORAGE);		      \
> 	mfspr	r5,SPRN_ESR;		/* Grab the ESR and save it */	 =
     \
> 	stw	r5,_ESR(r11);						 =
     \
> 	mfspr	r4,SPRN_DEAR;		/* Grab the DEAR */		 =
     \
> @@ -363,7 +366,7 @@ label:
>=20
> #define INSTRUCTION_STORAGE_EXCEPTION					 =
     \
> 	START_EXCEPTION(InstructionStorage)				 =
     \
> -	NORMAL_EXCEPTION_PROLOG;					 =
     \
> +	NORMAL_EXCEPTION_PROLOG(INST_STORAGE);		      \
> 	mfspr	r5,SPRN_ESR;		/* Grab the ESR and save it */	 =
     \
> 	stw	r5,_ESR(r11);						 =
     \
> 	mr      r4,r12;                 /* Pass SRR0 as arg2 */		 =
     \
> @@ -372,7 +375,7 @@ label:
>=20
> #define ALIGNMENT_EXCEPTION						 =
     \
> 	START_EXCEPTION(Alignment)					 =
     \
> -	NORMAL_EXCEPTION_PROLOG;					 =
     \
> +	NORMAL_EXCEPTION_PROLOG(ALIGNMENT);		      \
> 	mfspr   r4,SPRN_DEAR;           /* Grab the DEAR and save it */	 =
     \
> 	stw     r4,_DEAR(r11);						 =
     \
> 	addi    r3,r1,STACK_FRAME_OVERHEAD;				 =
     \
> @@ -380,7 +383,7 @@ label:
>=20
> #define PROGRAM_EXCEPTION						 =
     \
> 	START_EXCEPTION(Program)					 =
     \
> -	NORMAL_EXCEPTION_PROLOG;					 =
     \
> +	NORMAL_EXCEPTION_PROLOG(PROGRAM);		      \
> 	mfspr	r4,SPRN_ESR;		/* Grab the ESR and save it */	 =
     \
> 	stw	r4,_ESR(r11);						 =
     \
> 	addi	r3,r1,STACK_FRAME_OVERHEAD;				 =
     \
> @@ -388,7 +391,7 @@ label:
>=20
> #define DECREMENTER_EXCEPTION						 =
     \
> 	START_EXCEPTION(Decrementer)					 =
     \
> -	NORMAL_EXCEPTION_PROLOG;					 =
     \
> +	NORMAL_EXCEPTION_PROLOG(DECREMENTER);		      \
> 	lis     r0,TSR_DIS@h;           /* Setup the DEC interrupt mask =
*/    \
> 	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	 =
     \
> 	addi    r3,r1,STACK_FRAME_OVERHEAD;				 =
     \
> @@ -396,7 +399,7 @@ label:
>=20
> #define FP_UNAVAILABLE_EXCEPTION					 =
     \
> 	START_EXCEPTION(FloatingPointUnavailable)			 =
     \
> -	NORMAL_EXCEPTION_PROLOG;					 =
     \
> +	NORMAL_EXCEPTION_PROLOG(FP_UNAVAIL);		      \
> 	beq	1f;							 =
     \
> 	bl	load_up_fpu;		/* if from user, just load it up =
*/   \
> 	b	fast_exception_return;					 =
     \
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =
b/arch/powerpc/kernel/head_fsl_booke.S
> index d5d78c4..418931f 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -301,19 +301,20 @@ _ENTRY(__early_start)
>=20
> interrupt_base:
> 	/* Critical Input Interrupt */
> -	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
> +	CRITICAL_EXCEPTION(0x0100, CRITICAL, CriticalInput, =
unknown_exception)
>=20
> 	/* Machine Check Interrupt */
> #ifdef CONFIG_E200
> 	/* no RFMCI, MCSRRs on E200 */
> -	CRITICAL_EXCEPTION(0x0200, MachineCheck, =
machine_check_exception)
> +	CRITICAL_EXCEPTION(0x0200, MACHINE_CHECK, MachineCheck, \
> +			   machine_check_exception)
> #else
> 	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
> #endif
>=20
> 	/* Data Storage Interrupt */
> 	START_EXCEPTION(DataStorage)
> -	NORMAL_EXCEPTION_PROLOG
> +	NORMAL_EXCEPTION_PROLOG(DATA_STORAGE)
> 	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass =
arg3 */
> 	stw	r5,_ESR(r11)
> 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass =
arg2 */
> @@ -328,7 +329,7 @@ interrupt_base:
> 	INSTRUCTION_STORAGE_EXCEPTION
>=20
> 	/* External Input Interrupt */
> -	EXCEPTION(0x0500, ExternalInput, do_IRQ, EXC_XFER_LITE)
> +	EXCEPTION(0x0500, EXTERNAL, ExternalInput, do_IRQ, =
EXC_XFER_LITE)
>=20
> 	/* Alignment Interrupt */
> 	ALIGNMENT_EXCEPTION
> @@ -342,32 +343,36 @@ interrupt_base:
> #else
> #ifdef CONFIG_E200
> 	/* E200 treats 'normal' floating point instructions as FP =
Unavail exception */
> -	EXCEPTION(0x0800, FloatingPointUnavailable, =
program_check_exception, EXC_XFER_EE)
> +	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, \
> +		  program_check_exception, EXC_XFER_EE)
> #else
> -	EXCEPTION(0x0800, FloatingPointUnavailable, unknown_exception, =
EXC_XFER_EE)
> +	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, \
> +		  unknown_exception, EXC_XFER_EE)
> #endif
> #endif
>=20
> 	/* System Call Interrupt */
> 	START_EXCEPTION(SystemCall)
> -	NORMAL_EXCEPTION_PROLOG
> +	NORMAL_EXCEPTION_PROLOG(SYSCALL)
> 	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
>=20
> 	/* Auxiliary Processor Unavailable Interrupt */
> -	EXCEPTION(0x2900, AuxillaryProcessorUnavailable, =
unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
> +		  unknown_exception, EXC_XFER_EE)
>=20
> 	/* Decrementer Interrupt */
> 	DECREMENTER_EXCEPTION
>=20
> 	/* Fixed Internal Timer Interrupt */
> 	/* TODO: Add FIT support */
> -	EXCEPTION(0x3100, FixedIntervalTimer, unknown_exception, =
EXC_XFER_EE)
> +	EXCEPTION(0x3100, FIT, FixedIntervalTimer, \
> +		  unknown_exception, EXC_XFER_EE)
>=20
> 	/* Watchdog Timer Interrupt */
> #ifdef CONFIG_BOOKE_WDT
> -	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, WatchdogException)
> +	CRITICAL_EXCEPTION(0x3200, WATCHDOG, WatchdogTimer, =
WatchdogException)
> #else
> -	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, unknown_exception)
> +	CRITICAL_EXCEPTION(0x3200, WATCHDOG, WatchdogTimer, =
unknown_exception)
> #endif
>=20
> 	/* Data TLB Error Interrupt */
> @@ -538,31 +543,38 @@ interrupt_base:
> #ifdef CONFIG_SPE
> 	/* SPE Unavailable */
> 	START_EXCEPTION(SPEUnavailable)
> -	NORMAL_EXCEPTION_PROLOG
> +	NORMAL_EXCEPTION_PROLOG(SPE_UNAVAIL)
> 	bne	load_up_spe
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
> #else
> -	EXCEPTION(0x2020, SPEUnavailable, unknown_exception, =
EXC_XFER_EE)
> +	EXCEPTION(0x2020, SPE_UNAVAIL, SPEUnavailable, \
> +		  unknown_exception, EXC_XFER_EE)
> #endif /* CONFIG_SPE */
>=20
> 	/* SPE Floating Point Data */
> #ifdef CONFIG_SPE
> -	EXCEPTION(0x2030, SPEFloatingPointData, =
SPEFloatingPointException, EXC_XFER_EE);
> +	EXCEPTION(0x2030, SPE_FP_DATA, SPEFloatingPointData, \
> +		  SPEFloatingPointException, EXC_XFER_EE);
>=20
> 	/* SPE Floating Point Round */
> -	EXCEPTION(0x2050, SPEFloatingPointRound, =
SPEFloatingPointRoundException, EXC_XFER_EE)
> +	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
> +		  SPEFloatingPointRoundException, EXC_XFER_EE)
> #else
> -	EXCEPTION(0x2040, SPEFloatingPointData, unknown_exception, =
EXC_XFER_EE)
> -	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception, =
EXC_XFER_EE)
> +	EXCEPTION(0x2040, SPE_FP_DATA, SPEFloatingPointData, \
> +		  unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
> +		  unknown_exception, EXC_XFER_EE)
> #endif /* CONFIG_SPE */
>=20
> 	/* Performance Monitor */
> -	EXCEPTION(0x2060, PerformanceMonitor, =
performance_monitor_exception, EXC_XFER_STD)
> +	EXCEPTION(0x2060, PERFORMANCE_MONITOR, PerformanceMonitor, \
> +		  performance_monitor_exception, EXC_XFER_STD)
>=20
> -	EXCEPTION(0x2070, Doorbell, doorbell_exception, EXC_XFER_STD)
> +	EXCEPTION(0x2070, DOORBELL, Doorbell, doorbell_exception, =
EXC_XFER_STD)
>=20
> -	CRITICAL_EXCEPTION(0x2080, CriticalDoorbell, unknown_exception)
> +	CRITICAL_EXCEPTION(0x2080, DOORBELL_CRITICAL, \
> +			   CriticalDoorbell, unknown_exception)
>=20
> 	/* Debug Interrupt */
> 	DEBUG_DEBUG_EXCEPTION
> --=20
> 1.6.0.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
