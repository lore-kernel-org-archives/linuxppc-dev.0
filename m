Return-Path: <michael@ellerman.id.au>
Message-ID: <1347264790.6887.16.camel@concordia>
Subject: Re: [PATCH] powerpc: add denormalisation exception handling for
 POWER6/7
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Mon, 10 Sep 2012 18:13:10 +1000
In-Reply-To: <25882.1347260087@neuling.org>
References: <11738.1310363538@neuling.org>
 <5E6FBB75-BE97-4D97-AEA2-EC8EAF1E0ECF@kernel.crashing.org>
 <25882.1347260087@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 16:54 +1000, Michael Neuling wrote:
> On POWER6 and POWER7 if the input operand to an instruction is a
> denormalised single precision binary floating we can take a
                                               ^
                                               point value?



> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 4c25319..5f73ce6 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -126,6 +126,7 @@
>  #define PPC_INST_TLBIVAX		0x7c000624
>  #define PPC_INST_TLBSRX_DOT		0x7c0006a5
>  #define PPC_INST_XXLOR			0xf0000510
> +#define PPC_INST_XVCPSGNDP		0xf0000780
>  
>  #define PPC_INST_NAP			0x4c000364
>  #define PPC_INST_SLEEP			0x4c0003a4
> @@ -277,6 +278,8 @@
>  					       VSX_XX1((s), a, b))
>  #define XXLOR(t, a, b)		stringify_in_c(.long PPC_INST_XXLOR | \
>  					       VSX_XX3((t), a, b))
> +#define XVCPSGNDP(t, a, b)	stringify_in_c(.long (PPC_INST_XVCPSGNDP | \
> +					       VSX_XX3((t), (a), (b))))

If anyone else is wondering, yes the instruction really is "xvcpsgndp".


> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 334be34..d352aa4 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -524,6 +524,7 @@
>  
>  #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
>  #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
> +#define   HSRR1_DENORM		0x00100000 /* Denorm exception */
>  
>  #define SPRN_TBCTL	0x35f	/* PA6T Timebase control register */
>  #define   TBCTL_FREEZE		0x0000000000000000ull /* Freeze all tbs */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 39aa97d..6bbfbad 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -275,6 +275,31 @@ vsx_unavailable_pSeries_1:
>  	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
>  	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
>  
> +#ifdef CONFIG_PPC_DENORMALISATION
> +	. = 0x1500
> +	.global denorm_Hypervisor
> +denorm_Hypervisor:

The naming pattern seems to be "foo_exception_hv".

> +	HMT_MEDIUM
> +	mtspr	SPRN_SPRG_HSCRATCH0,r13
> +	mfspr	r13,SPRN_SPRG_HPACA
> +	std	r9,PACA_EXGEN+EX_R9(r13)
> +	std	r10,PACA_EXGEN+EX_R10(r13)
> +	std	r11,PACA_EXGEN+EX_R11(r13)
> +	std	r12,PACA_EXGEN+EX_R12(r13)
> +	mfspr	r9,SPRN_SPRG_HSCRATCH0
> +	std	r9,PACA_EXGEN+EX_R13(r13)
> +	mfcr	r9
> +
> +	mfspr	r10,SPRN_HSRR1
> +	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
> +	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
> +	addi	r11,r11,-4		/* HSRR0 is next instruction */
> +	bne+	denorm_assist

I think only this hunk should be inside the  #ifdef.

ie. we should always handle the exception but if we have no denorm
support you go to unknown_exception(), rather than just landing in fubar
land.

> +	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
> +	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1500)
> +#endif


> @@ -336,6 +361,103 @@ do_stab_bolted_pSeries:
>  	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x900)
>  	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x982)
>  
> +#ifdef CONFIG_PPC_DENORMALISATION
> +denorm_assist:
> +BEGIN_FTR_SECTION
> +/*
> + * To denormalise we need to move a copy of the register to itself.
> + * For POWER6 do that here for all FP regs.
> + */
> +	mfmsr	r10
> +	ori	r10,r10,(MSR_FP|MSR_FE0|MSR_FE1)
> +	xori	r10,r10,(MSR_FE0|MSR_FE1)
> +	mtmsrd	r10

So we're enabling FP, and switching the FP exception mode to "ignore".
Which is OK because we are going to switch it all back the way it was on
the way out when we rfid?

> +	sync
> +	fmr	0,0
> +	fmr	1,1
> +	fmr	2,2
> +	fmr	3,3
> +	fmr	4,4
> +	fmr	5,5
> +	fmr	6,6
> +	fmr	7,7
> +	fmr	8,8
> +	fmr	9,9
> +	fmr	10,10
> +	fmr	11,11
> +	fmr	12,12
> +	fmr	13,13
> +	fmr	14,14
> +	fmr	15,15
> +	fmr	16,16
> +	fmr	17,17
> +	fmr	18,18
> +	fmr	19,19
> +	fmr	20,20
> +	fmr	21,21
> +	fmr	22,22
> +	fmr	23,23
> +	fmr	24,24
> +	fmr	25,25
> +	fmr	26,26
> +	fmr	27,27
> +	fmr	28,28
> +	fmr	29,29
> +	fmr	30,30
> +	fmr	31,31
> +FTR_SECTION_ELSE
> +/*
> + * To denormalise we need to move a copy of the register to itself.
> + * For POWER7 do that here for the first 32 VSX registers only.
> + */

Why only the first 32?

> +	mfmsr	r10
> +	oris	r10,r10,MSR_VSX@h
> +	mtmsrd	r10

Here we just enable VSX and exceptions be damned?

> +	sync
> +	XVCPSGNDP(0,0,0)
> +	XVCPSGNDP(1,1,1)
> +	XVCPSGNDP(2,2,2)
> +	XVCPSGNDP(3,3,3)
> +	XVCPSGNDP(4,4,4)
> +	XVCPSGNDP(5,5,5)
> +	XVCPSGNDP(6,6,6)
> +	XVCPSGNDP(7,7,7)
> +	XVCPSGNDP(8,8,8)
> +	XVCPSGNDP(9,9,9)
> +	XVCPSGNDP(10,10,10)
> +	XVCPSGNDP(11,11,11)
> +	XVCPSGNDP(12,12,12)
> +	XVCPSGNDP(13,13,13)
> +	XVCPSGNDP(14,14,14)
> +	XVCPSGNDP(15,15,15)
> +	XVCPSGNDP(16,16,16)
> +	XVCPSGNDP(17,17,17)
> +	XVCPSGNDP(18,18,18)
> +	XVCPSGNDP(19,19,19)
> +	XVCPSGNDP(20,20,20)
> +	XVCPSGNDP(21,21,21)
> +	XVCPSGNDP(22,22,22)
> +	XVCPSGNDP(23,23,23)
> +	XVCPSGNDP(24,24,24)
> +	XVCPSGNDP(25,25,25)
> +	XVCPSGNDP(26,26,26)
> +	XVCPSGNDP(27,27,27)
> +	XVCPSGNDP(28,28,28)
> +	XVCPSGNDP(29,29,29)
> +	XVCPSGNDP(30,30,30)
> +	XVCPSGNDP(31,31,31)
> +ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
> +	mtspr	SPRN_HSRR0,r11

Do we not need to restore HSRR1 too?

> +	mtcrf	0x80,r9
> +	ld	r9,PACA_EXGEN+EX_R9(r13)
> +	ld	r10,PACA_EXGEN+EX_R10(r13)
> +	ld	r11,PACA_EXGEN+EX_R11(r13)
> +	ld	r12,PACA_EXGEN+EX_R12(r13)
> +	ld	r13,PACA_EXGEN+EX_R13(r13)
> +	HRFID
> +	b	.
> +#endif
> +
>  	.align	7
>  	/* moved from 0xe00 */
>  	STD_EXCEPTION_HV(., 0xe02, h_data_storage)
> @@ -495,6 +617,9 @@ machine_check_common:
>          STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
>  	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
>  	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
> +#ifdef CONFIG_PPC_DENORMALISATION
> +	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
> +#endif
>  #ifdef CONFIG_ALTIVEC
>  	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
>  #else


Looking forward to your response in 2014 ;)

cheers
