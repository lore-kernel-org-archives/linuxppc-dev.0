Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 14:52:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 03/12] powerpc/book3s: handle machine check in
 Linux host.
Message-ID: <20130909045237.GC6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193140.2855.96452.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193140.2855.96452.stgit@mars>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 01:01:40AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Move machine check entry point into Linux. So far we were dependent on
> firmware to decode MCE error details and handover the high level info to OS.
> 
> This patch introduces early machine check routine that saves the MCE
> information (srr1, srr0, dar and dsisr) to the emergency stack. We allocate
> stack frame on emergency stack and set the r1 accordingly. This allows us to be
> prepared to take another exception without loosing context. One thing to note
> here that, if we get another machine check while ME bit is off then we risk a
> checkstop. Hence we restrict ourselves to save only MCE information and turn
> the ME bit on. We use paca->in_mce flag to differentiate between first entry
> and nested machine check entry which helps proper use of emergency stack. We
> increment paca->in_mce every time we enter in early machine check handler and
> decrement it while leaving. When we enter machine check early handler first
> time (paca->in_mce == 0), we are sure nobody is using MC emergency stack and
> allocate a stack frame at the start of the emergency stack. During subsequent
> entry (paca->in_mce > 0), we know that r1 points inside emergency stack and we
> allocate separate stack frame accordingly. This prevents us from clobbering MCE
> information during nested machine checks.
> 
> The early machine check handler changes are placed under CPU_FTR_HVMODE
> section. This makes sure that the early machine check handler will get executed
> only in hypervisor kernel.

I have a few comments on this patch...

>  	.align	7
>  	/* moved from 0x200 */
> +machine_check_pSeries_early:
> +BEGIN_FTR_SECTION
> +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> +	/*
> +	 * Register contents:
> +	 * R12		= interrupt vector

Actually r12 doesn't contain anything except the value it had when the
machine check occurred.

> +	 * R13		= PACA
> +	 * R9		= CR
> +	 * R11 & R12 is saved on PACA_EXMC

All of r9 to r12 are saved in the PACA_EXMC save area.

> +	 *
> +	 * Switch to mc_emergency stack and handle re-entrancy (though we
> +	 * currently don't test for overflow). Save MCE registers srr1,
> +	 * srr0, dar and dsisr and then set ME=1
> +	 *
> +	 * We use paca->in_mce to check whether this is the first entry or
> +	 * nested machine check. We increment paca->in_mce to track nested
> +	 * machine checks.
> +	 *
> +	 * If this is the first entry then set stack pointer to
> +	 * paca->mc_emergency_sp, otherwise r1 is already pointing to
> +	 * stack frame on mc_emergency stack.
> +	 *
> +	 * NOTE: We are here with MSR_ME=0 (off), which means we risk a
> +	 * checkstop if we get another machine check exception before we do
> +	 * rfid with MSR_ME=1.
> +	 */
> +	mr	r11,r1			/* Save r1 */
> +	lhz	r10,PACA_IN_MCE(r13)
> +	cmpwi	r10,0			/* Are we in nested machine check */
> +	bne	0f			/* Yes, we are. */
> +	/* First machine check entry */
> +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
> +0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
> +	addi	r10,r10,1		/* increment paca->in_mce */
> +	sth	r10,PACA_IN_MCE(r13)
> +	std	r11,GPR1(r1)		/* Save r1 on the stack. */
> +	std	r11,0(r1)		/* make stack chain pointer */
> +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
> +	std	r11,_NIP(r1)
> +	mfspr	r11,SPRN_SRR1		/* Save SRR1 */
> +	std	r11,_MSR(r1)
> +	mfspr	r11,SPRN_DAR		/* Save DAR */
> +	std	r11,_DAR(r1)
> +	mfspr	r11,SPRN_DSISR		/* Save DSISR */
> +	std	r11,_DSISR(r1)
> +	mfmsr	r11			/* get MSR value */
> +	ori	r11,r11,MSR_ME		/* turn on ME bit */

At this point you should turn on MSR_RI as well, so that if we get
another machine check after the rfid we don't consider it
unrecoverable.  Also, since we could in principle get another machine
check soon after the rfid, and that would use the EX_MC save area,
we need to copy everything out of the EX_MC save area onto the
stack before turning on ME.

> +	ld	r12,PACAKBASE(r13)	/* get high part of &label */
> +	LOAD_HANDLER(r12, machine_check_handle_early)
> +	mtspr	SPRN_SRR0,r12
> +	mtspr	SPRN_SRR1,r11
> +	rfid
> +	b	.	/* prevent speculative execution */
> +END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> +
>  machine_check_pSeries:
>  	.globl machine_check_fwnmi
>  machine_check_fwnmi:
> @@ -681,6 +740,56 @@ machine_check_common:
>  	bl	.machine_check_exception
>  	b	.ret_from_except
>  
> +#define MACHINE_CHECK_HANDLER_WINDUP			\
> +	/* Move original SRR0 and SRR1 into the respective regs */	\
> +	ld	r9,_MSR(r1);				\
> +	mtspr	SPRN_SRR1,r9;				\
> +	ld	r3,_NIP(r1);				\
> +	mtspr	SPRN_SRR0,r3;				\
> +	REST_NVGPRS(r1);				\
> +	ld	r9,_CTR(r1);				\
> +	mtctr	r9;					\
> +	ld	r9,_XER(r1);				\
> +	mtxer	r9;					\
> +BEGIN_FTR_SECTION_NESTED(66);				\
> +	ld	r9,ORIG_GPR3(r1);			\
> +	mtspr	SPRN_CFAR,r9;				\
> +END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);	\
> +	ld	r9,_LINK(r1);				\
> +	mtlr	r9;					\
> +	REST_GPR(0, r1);				\
> +	REST_8GPRS(2, r1);				\
> +	REST_GPR(10, r1);				\
> +	ld	r11,_CCR(r1);				\
> +	mtcr	r11;					\
> +	/* Decrement paca->in_mce. */			\
> +	lhz	r12,PACA_IN_MCE(r13);			\
> +	subi	r12,r12,1;				\
> +	sth	r12,PACA_IN_MCE(r13);			\
> +	REST_GPR(11, r1);				\
> +	REST_2GPRS(12, r1);				\
> +	/* restore original r1. */			\
> +	ld	r1,GPR1(r1)

This is basically fast_exception_return without the rfid, and with the
decrementing of paca->in_mce.  You forgot to clear MSR_RI before
setting SRR0 and SRR1.  Also, there's no point restoring CFAR if the
next thing you are going to do is either an rfid or a branch, both of
which will set CFAR.  Further, you don't need the REST_NVGPRS unless
you are expecting that your machine check handler will want to modify
some of the GPR values in regs->gpr[14 ... 31], which I don't believe
is the case.

Paul.
