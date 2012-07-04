Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B073D2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 00:29:58 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM kernel
 hooks
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 16:29:49 +0200
Message-Id: <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2012, at 14:26, Mihai Caraman wrote:

> Hook DO_KVM macro to 64-bit booke in a optimal way similar to 32-bit =
booke
> see head_fsl_booke.S file. Extend interrupt handlers' parameter list =
with
> interrupt vector numbers to accomodate the macro. Rework Guest =
Doorbell
> handler to use the proper GSRRx save/restore registers.
> Only the bolted version of tlb miss handers is addressed now.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kernel/exceptions-64e.S |  114 =
++++++++++++++++++++++++----------
> arch/powerpc/mm/tlb_low_64e.S        |   14 +++-
> 2 files changed, 92 insertions(+), 36 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64e.S =
b/arch/powerpc/kernel/exceptions-64e.S
> index 06f7aec..a60f81f 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -25,6 +25,8 @@
> #include <asm/ppc-opcode.h>
> #include <asm/mmu.h>
> #include <asm/hw_irq.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_booke_hv_asm.h>
>=20
> /* XXX This will ultimately add space for a special exception save
>  *     structure used to save things like SRR0/SRR1, SPRGs, MAS, =
etc...
> @@ -34,13 +36,24 @@
>  */
> #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
>=20
> +#ifdef CONFIG_KVM_BOOKE_HV
> +#define KVM_BOOKE_HV_MFSPR(reg, spr)				\
> +	BEGIN_FTR_SECTION					\
> +		mfspr	reg, spr;			  	\
> +	END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> +#else
> +#define KVM_BOOKE_HV_MFSPR(reg, spr)
> +#endif

Bleks - this is ugly. Do we really need to open-code the #ifdef here? =
Can't the feature section code determine that the feature is disabled =
and just always not include the code?

> +
> /* Exception prolog code for all exceptions */
> -#define EXCEPTION_PROLOG(n, type, srr0, srr1, addition)		 =
    	    \
> +#define EXCEPTION_PROLOG(n, intnum, type, srr0, srr1, addition)		=
    \
> 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers =
*/   \
> 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			 =
   \
> 	std	r10,PACA_EX##type+EX_R10(r13);				 =
   \
> 	std	r11,PACA_EX##type+EX_R11(r13);				 =
   \
> 	mfcr	r10;			/* save CR */			 =
   \
> +	KVM_BOOKE_HV_MFSPR(r11,srr1);			    		 =
   \
> +	DO_KVM	intnum,srr1;				    		 =
   \

So if DO_KVM already knows srr1, why explicitly do something with it the =
line above, and not in DO_KVM itself?

> 	addition;			/* additional code for that exc. =
*/ \
> 	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA =
*/  \
> 	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA =
*/ \
> @@ -69,17 +82,21 @@
> 	ld	r1,PACA_MC_STACK(r13);					 =
   \
> 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
>=20
> -#define NORMAL_EXCEPTION_PROLOG(n, addition)				 =
   \
> -	EXCEPTION_PROLOG(n, GEN, SPRN_SRR0, SPRN_SRR1, =
addition##_GEN(n))
> +#define NORMAL_EXCEPTION_PROLOG(n, intnum, addition)			 =
   \
> +	EXCEPTION_PROLOG(n, intnum, GEN, SPRN_SRR0, SPRN_SRR1,		 =
   \

We would we want to pass in 2 numbers? Let's please confine this onto a =
single ID per interrupt vector. Either we use the hardcoded ones =
available here in the KVM code or we use the KVM ones instead of the =
hardcoded ones here. But not both please. Just because it's like that on =
32bit doesn't count as an excuse :).

> +					 addition##_GEN(n))
>=20
> -#define CRIT_EXCEPTION_PROLOG(n, addition)				 =
   \
> -	EXCEPTION_PROLOG(n, CRIT, SPRN_CSRR0, SPRN_CSRR1, =
addition##_CRIT(n))
> +#define CRIT_EXCEPTION_PROLOG(n, intnum, addition)			 =
   \
> +	EXCEPTION_PROLOG(n, intnum, CRIT, SPRN_CSRR0, SPRN_CSRR1, 	 =
   \
> +					 addition##_CRIT(n))
>=20
> -#define DBG_EXCEPTION_PROLOG(n, addition)				 =
   \
> -	EXCEPTION_PROLOG(n, DBG, SPRN_DSRR0, SPRN_DSRR1, =
addition##_DBG(n))
> +#define DBG_EXCEPTION_PROLOG(n, intnum, addition)			 =
   \
> +	EXCEPTION_PROLOG(n, intnum, DBG, SPRN_DSRR0, SPRN_DSRR1, 	 =
   \
> +					 addition##_DBG(n))
>=20
> -#define MC_EXCEPTION_PROLOG(n, addition)				 =
   \
> -	EXCEPTION_PROLOG(n, MC, SPRN_MCSRR0, SPRN_MCSRR1, =
addition##_MC(n))
> +#define MC_EXCEPTION_PROLOG(n, intnum, addition)			 =
   \
> +	EXCEPTION_PROLOG(n, intnum, MC, SPRN_MCSRR0, SPRN_MCSRR1, 	 =
   \
> +					 addition##_MC(n))
>=20
>=20
> /* Variants of the "addition" argument for the prolog
> @@ -226,9 +243,9 @@ exc_##n##_bad_stack:					=
		    \
> 1:
>=20
>=20
> -#define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			=
\
> +#define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)		=
\
> 	START_EXCEPTION(label);						=
\
> -	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	=
\
> +	NORMAL_EXCEPTION_PROLOG(trapnum, intnum, =
PROLOG_ADDITION_MASKABLE)\
> 	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE)		=
\
> 	ack(r8);							=
\
> 	CHECK_NAPPING();						=
\
> @@ -279,7 +296,8 @@ interrupt_end_book3e:
>=20
> /* Critical Input Interrupt */
> 	START_EXCEPTION(critical_input);
> -	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
> +	CRIT_EXCEPTION_PROLOG(0x100, BOOKE_INTERRUPT_CRITICAL,
> +			      PROLOG_ADDITION_NONE)
> //	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
> //	bl	special_reg_save_crit
> //	CHECK_NAPPING();
> @@ -290,7 +308,8 @@ interrupt_end_book3e:
>=20
> /* Machine Check Interrupt */
> 	START_EXCEPTION(machine_check);
> -	MC_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
> +	MC_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_MACHINE_CHECK,
> +			    PROLOG_ADDITION_NONE)
> //	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
> //	bl	special_reg_save_mc
> //	addi	r3,r1,STACK_FRAME_OVERHEAD
> @@ -301,7 +320,8 @@ interrupt_end_book3e:
>=20
> /* Data Storage Interrupt */
> 	START_EXCEPTION(data_storage)
> -	NORMAL_EXCEPTION_PROLOG(0x300, PROLOG_ADDITION_2REGS)
> +	NORMAL_EXCEPTION_PROLOG(0x300, BOOKE_INTERRUPT_DATA_STORAGE,
> +				PROLOG_ADDITION_2REGS)
> 	mfspr	r14,SPRN_DEAR
> 	mfspr	r15,SPRN_ESR
> 	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_DISABLE)
> @@ -309,18 +329,21 @@ interrupt_end_book3e:
>=20
> /* Instruction Storage Interrupt */
> 	START_EXCEPTION(instruction_storage);
> -	NORMAL_EXCEPTION_PROLOG(0x400, PROLOG_ADDITION_2REGS)
> +	NORMAL_EXCEPTION_PROLOG(0x400, BOOKE_INTERRUPT_INST_STORAGE,
> +				PROLOG_ADDITION_2REGS)
> 	li	r15,0
> 	mr	r14,r10
> 	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_DISABLE)
> 	b	storage_fault_common
>=20
> /* External Input Interrupt */
> -	MASKABLE_EXCEPTION(0x500, external_input, .do_IRQ, ACK_NONE)
> +	MASKABLE_EXCEPTION(0x500, BOOKE_INTERRUPT_EXTERNAL,
> +			   external_input, .do_IRQ, ACK_NONE)
>=20
> /* Alignment */
> 	START_EXCEPTION(alignment);
> -	NORMAL_EXCEPTION_PROLOG(0x600, PROLOG_ADDITION_2REGS)
> +	NORMAL_EXCEPTION_PROLOG(0x600, BOOKE_INTERRUPT_ALIGNMENT,
> +				PROLOG_ADDITION_2REGS)
> 	mfspr	r14,SPRN_DEAR
> 	mfspr	r15,SPRN_ESR
> 	EXCEPTION_COMMON(0x600, PACA_EXGEN, INTS_KEEP)
> @@ -328,7 +351,8 @@ interrupt_end_book3e:
>=20
> /* Program Interrupt */
> 	START_EXCEPTION(program);
> -	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
> +	NORMAL_EXCEPTION_PROLOG(0x700, BOOKE_INTERRUPT_PROGRAM,
> +				PROLOG_ADDITION_1REG)
> 	mfspr	r14,SPRN_ESR
> 	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE)
> 	std	r14,_DSISR(r1)
> @@ -340,7 +364,8 @@ interrupt_end_book3e:
>=20
> /* Floating Point Unavailable Interrupt */
> 	START_EXCEPTION(fp_unavailable);
> -	NORMAL_EXCEPTION_PROLOG(0x800, PROLOG_ADDITION_NONE)
> +	NORMAL_EXCEPTION_PROLOG(0x800, BOOKE_INTERRUPT_FP_UNAVAIL,
> +				PROLOG_ADDITION_NONE)
> 	/* we can probably do a shorter exception entry for that one... =
*/
> 	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
> 	ld	r12,_MSR(r1)
> @@ -355,14 +380,17 @@ interrupt_end_book3e:
> 	b	.ret_from_except
>=20
> /* Decrementer Interrupt */
> -	MASKABLE_EXCEPTION(0x900, decrementer, .timer_interrupt, =
ACK_DEC)
> +	MASKABLE_EXCEPTION(0x900, BOOKE_INTERRUPT_DECREMENTER,
> +			   decrementer, .timer_interrupt, ACK_DEC)
>=20
> /* Fixed Interval Timer Interrupt */
> -	MASKABLE_EXCEPTION(0x980, fixed_interval, .unknown_exception, =
ACK_FIT)
> +	MASKABLE_EXCEPTION(0x980, BOOKE_INTERRUPT_FIT,
> +			   fixed_interval, .unknown_exception, ACK_FIT)
>=20
> /* Watchdog Timer Interrupt */
> 	START_EXCEPTION(watchdog);
> -	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
> +	CRIT_EXCEPTION_PROLOG(0x9f0, BOOKE_INTERRUPT_WATCHDOG,
> +			      PROLOG_ADDITION_NONE)
> //	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE)
> //	bl	special_reg_save_crit
> //	CHECK_NAPPING();
> @@ -381,7 +409,8 @@ interrupt_end_book3e:
>=20
> /* Auxiliary Processor Unavailable Interrupt */
> 	START_EXCEPTION(ap_unavailable);
> -	NORMAL_EXCEPTION_PROLOG(0xf20, PROLOG_ADDITION_NONE)
> +	NORMAL_EXCEPTION_PROLOG(0xf20, BOOKE_INTERRUPT_AP_UNAVAIL,
> +				PROLOG_ADDITION_NONE)
> 	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_DISABLE)
> 	bl	.save_nvgprs
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> @@ -390,7 +419,8 @@ interrupt_end_book3e:
>=20
> /* Debug exception as a critical interrupt*/
> 	START_EXCEPTION(debug_crit);
> -	CRIT_EXCEPTION_PROLOG(0xd00, PROLOG_ADDITION_2REGS)
> +	CRIT_EXCEPTION_PROLOG(0xd00, BOOKE_INTERRUPT_DEBUG,
> +			      PROLOG_ADDITION_2REGS)
>=20
> 	/*
> 	 * If there is a single step or branch-taken exception in an
> @@ -455,7 +485,8 @@ kernel_dbg_exc:
>=20
> /* Debug exception as a debug interrupt*/
> 	START_EXCEPTION(debug_debug);
> -	DBG_EXCEPTION_PROLOG(0xd08, PROLOG_ADDITION_2REGS)
> +	DBG_EXCEPTION_PROLOG(0xd00, BOOKE_INTERRUPT_DEBUG,
> +						 PROLOG_ADDITION_2REGS)
>=20
> 	/*
> 	 * If there is a single step or branch-taken exception in an
> @@ -516,18 +547,21 @@ kernel_dbg_exc:
> 	b	.ret_from_except
>=20
> 	START_EXCEPTION(perfmon);
> -	NORMAL_EXCEPTION_PROLOG(0x260, PROLOG_ADDITION_NONE)
> +	NORMAL_EXCEPTION_PROLOG(0x260, =
BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
> +				PROLOG_ADDITION_NONE)
> 	EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	bl	.performance_monitor_exception
> 	b	.ret_from_except_lite
>=20
> /* Doorbell interrupt */
> -	MASKABLE_EXCEPTION(0x280, doorbell, .doorbell_exception, =
ACK_NONE)
> +	MASKABLE_EXCEPTION(0x280, BOOKE_INTERRUPT_DOORBELL,
> +			   doorbell, .doorbell_exception, ACK_NONE)
>=20
> /* Doorbell critical Interrupt */
> 	START_EXCEPTION(doorbell_crit);
> -	CRIT_EXCEPTION_PROLOG(0x2a0, PROLOG_ADDITION_NONE)
> +	CRIT_EXCEPTION_PROLOG(0x2a0, BOOKE_INTERRUPT_DOORBELL_CRITICAL,
> +			      PROLOG_ADDITION_NONE)
> //	EXCEPTION_COMMON(0x2a0, PACA_EXCRIT, INTS_DISABLE)
> //	bl	special_reg_save_crit
> //	CHECK_NAPPING();
> @@ -536,12 +570,24 @@ kernel_dbg_exc:
> //	b	ret_from_crit_except
> 	b	.
>=20
> -/* Guest Doorbell */
> -	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, =
ACK_NONE)
> +/*
> + *	Guest doorbell interrupt
> + *	This general exception use GSRRx save/restore registers
> + */
> +	START_EXCEPTION(guest_doorbell);
> +	EXCEPTION_PROLOG(0x2c0, BOOKE_INTERRUPT_GUEST_DBELL, GEN,
> +			 SPRN_GSRR0, SPRN_GSRR1, PROLOG_ADDITION_NONE)
> +	EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_KEEP)
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	.save_nvgprs
> +	INTS_RESTORE_HARD
> +	bl	.unknown_exception
> +	b	.ret_from_except

This is independent of DO_KVM, right?

>=20
> /* Guest Doorbell critical Interrupt */
> 	START_EXCEPTION(guest_doorbell_crit);
> -	CRIT_EXCEPTION_PROLOG(0x2e0, PROLOG_ADDITION_NONE)
> +	CRIT_EXCEPTION_PROLOG(0x2e0, BOOKE_INTERRUPT_GUEST_DBELL_CRIT,
> +			      PROLOG_ADDITION_NONE)

Shouldn't this one also use GSRR?

> //	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT, INTS_DISABLE)
> //	bl	special_reg_save_crit
> //	CHECK_NAPPING();
> @@ -552,7 +598,8 @@ kernel_dbg_exc:
>=20
> /* Hypervisor call */
> 	START_EXCEPTION(hypercall);
> -	NORMAL_EXCEPTION_PROLOG(0x310, PROLOG_ADDITION_NONE)
> +	NORMAL_EXCEPTION_PROLOG(0x310, BOOKE_INTERRUPT_HV_SYSCALL,
> +			        PROLOG_ADDITION_NONE)
> 	EXCEPTION_COMMON(0x310, PACA_EXGEN, INTS_KEEP)
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	bl	.save_nvgprs
> @@ -562,7 +609,8 @@ kernel_dbg_exc:
>=20
> /* Embedded Hypervisor priviledged  */
> 	START_EXCEPTION(ehpriv);
> -	NORMAL_EXCEPTION_PROLOG(0x320, PROLOG_ADDITION_NONE)
> +	NORMAL_EXCEPTION_PROLOG(0x320, BOOKE_INTERRUPT_HV_PRIV,
> +			        PROLOG_ADDITION_NONE)
> 	EXCEPTION_COMMON(0x320, PACA_EXGEN, INTS_KEEP)
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	bl	.save_nvgprs
> diff --git a/arch/powerpc/mm/tlb_low_64e.S =
b/arch/powerpc/mm/tlb_low_64e.S
> index ff672bd..88feaaa 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -20,6 +20,8 @@
> #include <asm/pgtable.h>
> #include <asm/exception-64e.h>
> #include <asm/ppc-opcode.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_booke_hv_asm.h>
>=20
> #ifdef CONFIG_PPC_64K_PAGES
> #define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
> @@ -37,12 +39,18 @@
>  *                                                                    =
*
>  =
**********************************************************************/
>=20
> -.macro tlb_prolog_bolted addr
> +.macro tlb_prolog_bolted intnum addr
> 	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
> 	mfspr	r13,SPRN_SPRG_PACA
> 	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
> 	mfcr	r10
> 	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
> +#ifdef CONFIG_KVM_BOOKE_HV
> +BEGIN_FTR_SECTION
> +	mfspr	r11, SPRN_SRR1
> +END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> +#endif

This thing really should vanish behind DO_KVM :)

Alex

> +	DO_KVM	\intnum, SPRN_SRR1
> 	std	r16,PACA_EXTLB+EX_TLB_R16(r13)
> 	mfspr	r16,\addr		/* get faulting address */
> 	std	r14,PACA_EXTLB+EX_TLB_R14(r13)
> @@ -66,7 +74,7 @@
>=20
> /* Data TLB miss */
> 	START_EXCEPTION(data_tlb_miss_bolted)
> -	tlb_prolog_bolted SPRN_DEAR
> +	tlb_prolog_bolted BOOKE_INTERRUPT_DTLB_MISS SPRN_DEAR
>=20
> 	/* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
>=20
> @@ -214,7 +222,7 @@ itlb_miss_fault_bolted:
>=20
> /* Instruction TLB miss */
> 	START_EXCEPTION(instruction_tlb_miss_bolted)
> -	tlb_prolog_bolted SPRN_SRR0
> +	tlb_prolog_bolted BOOKE_INTERRUPT_ITLB_MISS SPRN_SRR0
>=20
> 	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
> 	srdi	r15,r16,60		/* get region */
> --=20
> 1.7.4.1
>=20
>=20
>=20
