Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE8EA2C030C
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 19:41:21 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 8 Aug 2013 06:36:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AB0D72BB0055
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 19:38:25 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r779MZmN7078286
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 19:22:36 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r779cOoO017008
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 19:38:24 +1000
Subject: [RFC PATCH 2/9] powerpc: handle machine check in Linux host.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 07 Aug 2013 15:08:15 +0530
Message-ID: <20130807093815.5389.7668.stgit@mars.in.ibm.com>
In-Reply-To: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
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
stack frame on emergency stack and set the r1 accordingly. This allows us
to be prepared to take another exception without loosing context. One thing
to note here that, if we get another machine check while ME bit is off then
we risk a checkstop. Hence we restrict ourselves to save only MCE information
and turn the ME bit on.

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
 arch/powerpc/include/asm/exception-64s.h |   43 ++++++++++++++++++++++++++
 arch/powerpc/kernel/exceptions-64s.S     |   50 +++++++++++++++++++++++++++++-
 arch/powerpc/kernel/traps.c              |   12 +++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 2386d40..c5d2cbc 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -174,6 +174,49 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
 	__EXCEPTION_PROLOG_1(area, extra, vec)
 
+/*
+ * Register contents:
+ * R12		= interrupt vector
+ * R13		= PACA
+ * R9		= CR
+ * R11 & R12 is saved on PACA_EXMC
+ *
+ * Swicth to emergency stack and handle re-entrancy (though we currently
+ * don't test for overflow). Save MCE registers srr1, srr0, dar and
+ * dsisr and then turn the ME bit on.
+ */
+#define __EARLY_MACHINE_CHECK_HANDLER(area, label)			\
+	/* Check if we are laready using emergency stack. */		\
+	ld	r10,PACAEMERGSP(r13);					\
+	subi	r10,r10,THREAD_SIZE;					\
+	rldicr	r10,r10,0,(63 - THREAD_SHIFT);				\
+	rldicr	r11,r1,0,(63 - THREAD_SHIFT);				\
+	cmpd	r10,r11;	/* Are we using emergency stack? */	\
+	mr	r11,r1;			/* Save current stack pointer */\
+	beq	0f;							\
+	ld	r1,PACAEMERGSP(r13);	/* Use emergency stack */	\
+0:	subi	r1,r1,INT_FRAME_SIZE;	/* alloc stack frame */		\
+	std	r11,GPR1(r1);						\
+	std	r11,0(r1);		/* make stack chain pointer */	\
+	mfspr	r11,SPRN_SRR0;		/* Save SRR0 */			\
+	std	r11,_NIP(r1);						\
+	mfspr	r11,SPRN_SRR1;		/* Save SRR1 */			\
+	std	r11,_MSR(r1);						\
+	mfspr	r11,SPRN_DAR;		/* Save DAR */			\
+	std 	r11,_DAR(r1);						\
+	mfspr	r11,SPRN_DSISR;		/* Save DSISR */		\
+	std	r11,_DSISR(r1);						\
+	mfmsr	r11;			/* get MSR value */		\
+	ori	r11,r11,MSR_ME;		/* turn on ME bit */		\
+	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
+	LOAD_HANDLER(r12,label)						\
+	mtspr	SPRN_SRR0,r12;						\
+	mtspr	SPRN_SRR1,r11;						\
+	rfid;								\
+	b	.	/* prevent speculative execution */
+#define EARLY_MACHINE_CHECK_HANDLER(area, label)			\
+	__EARLY_MACHINE_CHECK_HANDLER(area, label)
+
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4e00d22..66d2a71 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -156,7 +156,7 @@ machine_check_pSeries_1:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
-	b	machine_check_pSeries_0
+	b	machine_check_pSeries_early
 
 	. = 0x300
 	.globl data_access_pSeries
@@ -404,6 +404,9 @@ denorm_exception_hv:
 
 	.align	7
 	/* moved from 0x200 */
+machine_check_pSeries_early:
+	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	EARLY_MACHINE_CHECK_HANDLER(PACA_EXMC, machine_check_handle_early)
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
@@ -681,6 +684,51 @@ machine_check_common:
 	bl	.machine_check_exception
 	b	.ret_from_except
 
+	/*
+	 * Handle machine check early in real mode. We come here with
+	 * ME bit on with MMU (IR and DR) off and using emergency stack.
+	 */
+	.align	7
+	.globl machine_check_handle_early
+machine_check_handle_early:
+	std	r9,_CCR(r1)	/* Save CR in stackframe */
+	std	r0,GPR0(r1)	/* Save r0, r2 - r10 */
+	EXCEPTION_PROLOG_COMMON_2(0x200, PACA_EXMC)
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.machine_check_early
+	cmpdi	r3,0			/* Did we handle it? */
+	ld	r9,_MSR(r1)
+	beq	1f
+	ori	r9,r9,MSR_RI		/* Yes we have handled it. */
+	/* Move original SRR0 and SRR1 into the respective regs */
+1:	mtspr	SPRN_SRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_SRR0,r3
+	REST_NVGPRS(r1)
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_CCR(r1)
+	mtcr	r9
+BEGIN_FTR_SECTION
+	ld	r9,ORIG_GPR3(r1)
+	mtspr	SPRN_CFAR,r9
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_2GPRS(10, r1)
+	REST_GPR(12, r1)
+	/*
+	 * restore orig stack pointer. We have already saved MCE info
+	 * to per cpu MCE event buffer.
+	 */
+	ld	r1,GPR1(r1)
+	b	machine_check_pSeries
+
 	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
 	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
 	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bf33c22..1720e08 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -286,6 +286,18 @@ void system_reset_exception(struct pt_regs *regs)
 
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
