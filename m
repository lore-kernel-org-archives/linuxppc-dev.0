Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D0E92C0156
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:46 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 05:28:29 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 81CAF2BB0053
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:43 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QJFUdn7733740
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:15:30 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7QJVgbD029344
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:43 +1000
Subject: [RFC PATCH v3 03/12] powerpc/book3s: handle machine check in Linux
 host.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 01:01:40 +0530
Message-ID: <20130826193140.2855.96452.stgit@mars>
In-Reply-To: <20130826192616.2855.18749.stgit@mars>
References: <20130826192616.2855.18749.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Move machine check entry point into Linux. So far we were dependent on
firmware to decode MCE error details and handover the high level info to OS.

This patch introduces early machine check routine that saves the MCE
information (srr1, srr0, dar and dsisr) to the emergency stack. We allocate
stack frame on emergency stack and set the r1 accordingly. This allows us to be
prepared to take another exception without loosing context. One thing to note
here that, if we get another machine check while ME bit is off then we risk a
checkstop. Hence we restrict ourselves to save only MCE information and turn
the ME bit on. We use paca->in_mce flag to differentiate between first entry
and nested machine check entry which helps proper use of emergency stack. We
increment paca->in_mce every time we enter in early machine check handler and
decrement it while leaving. When we enter machine check early handler first
time (paca->in_mce == 0), we are sure nobody is using MC emergency stack and
allocate a stack frame at the start of the emergency stack. During subsequent
entry (paca->in_mce > 0), we know that r1 points inside emergency stack and we
allocate separate stack frame accordingly. This prevents us from clobbering MCE
information during nested machine checks.

The early machine check handler changes are placed under CPU_FTR_HVMODE
section. This makes sure that the early machine check handler will get executed
only in hypervisor kernel.

This is the code flow:

		Machine Check Interrupt
			|
			V
		   0x200 vector				  ME=0, IR=0, DR=0
			|
			V
	+-----------------------------------------------+
	|machine_check_pSeries_early:			| ME=0, IR=0, DR=0
	|	Alloc frame on emergency stack		|
	|	Save srr1, srr0, dar and dsisr on stack |
	+-----------------------------------------------+
			|
		(ME=1, IR=0, DR=0, RFID)
			|
			V
		machine_check_handle_early		  ME=1, IR=0, DR=0
			|
			V
	+-----------------------------------------------+
	|	machine_check_early (r3=pt_regs)	| ME=1, IR=0, DR=0
	|	Things to do: (in next patches)		|
	|		Flush SLB for SLB errors	|
	|		Flush TLB for TLB errors	|
	|		Decode and save MCE info	|
	+-----------------------------------------------+
			|
	(Fall through existing exception handler routine.)
			|
			V
		machine_check_pSerie			  ME=1, IR=0, DR=0
			|
		(ME=1, IR=1, DR=1, RFID)
			|
			V
		machine_check_common			  ME=1, IR=1, DR=1
			.
			.
			.


Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/asm-offsets.c    |    4 +
 arch/powerpc/kernel/exceptions-64s.S |  109 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c          |   12 ++++
 3 files changed, 125 insertions(+)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8207459..e0e8ebb 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -238,6 +238,10 @@ int main(void)
 	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
+#ifdef CONFIG_PPC_BOOK3S_64
+	DEFINE(PACAMCEMERGSP, offsetof(struct paca_struct, mc_emergency_sp));
+	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
+#endif
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
 	DEFINE(PACA_STARTTIME, offsetof(struct paca_struct, starttime));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 902ca3c..651a213 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -156,7 +156,11 @@ machine_check_pSeries_1:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
+BEGIN_FTR_SECTION
+	b	machine_check_pSeries_early
+FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 
 	. = 0x300
 	.globl data_access_pSeries
@@ -404,6 +408,61 @@ denorm_exception_hv:
 
 	.align	7
 	/* moved from 0x200 */
+machine_check_pSeries_early:
+BEGIN_FTR_SECTION
+	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	/*
+	 * Register contents:
+	 * R12		= interrupt vector
+	 * R13		= PACA
+	 * R9		= CR
+	 * R11 & R12 is saved on PACA_EXMC
+	 *
+	 * Switch to mc_emergency stack and handle re-entrancy (though we
+	 * currently don't test for overflow). Save MCE registers srr1,
+	 * srr0, dar and dsisr and then set ME=1
+	 *
+	 * We use paca->in_mce to check whether this is the first entry or
+	 * nested machine check. We increment paca->in_mce to track nested
+	 * machine checks.
+	 *
+	 * If this is the first entry then set stack pointer to
+	 * paca->mc_emergency_sp, otherwise r1 is already pointing to
+	 * stack frame on mc_emergency stack.
+	 *
+	 * NOTE: We are here with MSR_ME=0 (off), which means we risk a
+	 * checkstop if we get another machine check exception before we do
+	 * rfid with MSR_ME=1.
+	 */
+	mr	r11,r1			/* Save r1 */
+	lhz	r10,PACA_IN_MCE(r13)
+	cmpwi	r10,0			/* Are we in nested machine check */
+	bne	0f			/* Yes, we are. */
+	/* First machine check entry */
+	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
+0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
+	addi	r10,r10,1		/* increment paca->in_mce */
+	sth	r10,PACA_IN_MCE(r13)
+	std	r11,GPR1(r1)		/* Save r1 on the stack. */
+	std	r11,0(r1)		/* make stack chain pointer */
+	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
+	std	r11,_NIP(r1)
+	mfspr	r11,SPRN_SRR1		/* Save SRR1 */
+	std	r11,_MSR(r1)
+	mfspr	r11,SPRN_DAR		/* Save DAR */
+	std	r11,_DAR(r1)
+	mfspr	r11,SPRN_DSISR		/* Save DSISR */
+	std	r11,_DSISR(r1)
+	mfmsr	r11			/* get MSR value */
+	ori	r11,r11,MSR_ME		/* turn on ME bit */
+	ld	r12,PACAKBASE(r13)	/* get high part of &label */
+	LOAD_HANDLER(r12, machine_check_handle_early)
+	mtspr	SPRN_SRR0,r12
+	mtspr	SPRN_SRR1,r11
+	rfid
+	b	.	/* prevent speculative execution */
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
@@ -681,6 +740,56 @@ machine_check_common:
 	bl	.machine_check_exception
 	b	.ret_from_except
 
+#define MACHINE_CHECK_HANDLER_WINDUP			\
+	/* Move original SRR0 and SRR1 into the respective regs */	\
+	ld	r9,_MSR(r1);				\
+	mtspr	SPRN_SRR1,r9;				\
+	ld	r3,_NIP(r1);				\
+	mtspr	SPRN_SRR0,r3;				\
+	REST_NVGPRS(r1);				\
+	ld	r9,_CTR(r1);				\
+	mtctr	r9;					\
+	ld	r9,_XER(r1);				\
+	mtxer	r9;					\
+BEGIN_FTR_SECTION_NESTED(66);				\
+	ld	r9,ORIG_GPR3(r1);			\
+	mtspr	SPRN_CFAR,r9;				\
+END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);	\
+	ld	r9,_LINK(r1);				\
+	mtlr	r9;					\
+	REST_GPR(0, r1);				\
+	REST_8GPRS(2, r1);				\
+	REST_GPR(10, r1);				\
+	ld	r11,_CCR(r1);				\
+	mtcr	r11;					\
+	/* Decrement paca->in_mce. */			\
+	lhz	r12,PACA_IN_MCE(r13);			\
+	subi	r12,r12,1;				\
+	sth	r12,PACA_IN_MCE(r13);			\
+	REST_GPR(11, r1);				\
+	REST_2GPRS(12, r1);				\
+	/* restore original r1. */			\
+	ld	r1,GPR1(r1)
+
+	/*
+	 * Handle machine check early in real mode. We come here with
+	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
+	 */
+	.align	7
+	.globl machine_check_handle_early
+machine_check_handle_early:
+BEGIN_FTR_SECTION
+	std	r9,_CCR(r1)	/* Save CR in stackframe */
+	std	r0,GPR0(r1)	/* Save r0 */
+	EXCEPTION_PROLOG_COMMON_2(0x200, PACA_EXMC)
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.machine_check_early
+	/* Deliver the machine check to host kernel in V mode. */
+	MACHINE_CHECK_HANDLER_WINDUP
+	b	machine_check_pSeries
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+
 	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
 	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
 	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e435bc0..e8d6bf1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -284,6 +284,18 @@ void system_reset_exception(struct pt_regs *regs)
 
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
+
+/*
+ * This function is called in real mode. Strictly no printk's please.
+ *
+ * regs->nip and regs->msr contains srr0 and ssr1.
+ */
+long machine_check_early(struct pt_regs *regs)
+{
+	/* TODO: handle/decode machine check reason */
+	return 0;
+}
+
 #endif
 
 /*
