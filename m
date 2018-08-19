Return-Path: <srs0=hvng=lc=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tk1G0KjZzF0yB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41tk1F5QFdz8vq5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:49 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41tk1F10ztz9s5c
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 03:08:48 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7JH3Qbr065492
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2018 13:08:46 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ky0pe95dh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2018 13:08:46 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 19 Aug 2018 18:08:45 +0100
Subject: [PATCH v8 5/5] powernv/pseries: consolidate code for mce early
 handling.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Ananth Narayan <ananth@in.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 19 Aug 2018 22:38:39 +0530
In-Reply-To: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
References: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153469851942.21878.15396539991879060950.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Now that other platforms also implements real mode mce handler,
lets consolidate the code by sharing existing powernv machine check
early code. Rename machine_check_powernv_early to
machine_check_common_early and reuse the code.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |  155 ++++++----------------------------
 1 file changed, 28 insertions(+), 127 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 12f056179112..2f85a7baf026 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -243,14 +243,13 @@ EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 BEGIN_FTR_SECTION
-	b	machine_check_powernv_early
+	b	machine_check_common_early
 FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_REAL_END(machine_check, 0x200, 0x100)
 EXC_VIRT_NONE(0x4200, 0x100)
-TRAMP_REAL_BEGIN(machine_check_powernv_early)
-BEGIN_FTR_SECTION
+TRAMP_REAL_BEGIN(machine_check_common_early)
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
 	/*
 	 * Register contents:
@@ -306,7 +305,9 @@ BEGIN_FTR_SECTION
 	/* Save r9 through r13 from EXMC save area to stack frame. */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
 	mfmsr	r11			/* get MSR value */
+BEGIN_FTR_SECTION
 	ori	r11,r11,MSR_ME		/* turn on ME bit */
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	ori	r11,r11,MSR_RI		/* turn on RI bit */
 	LOAD_HANDLER(r12, machine_check_handle_early)
 1:	mtspr	SPRN_SRR0,r12
@@ -325,7 +326,6 @@ BEGIN_FTR_SECTION
 	andc	r11,r11,r10		/* Turn off MSR_ME */
 	b	1b
 	b	.	/* prevent speculative execution */
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
 TRAMP_REAL_BEGIN(machine_check_pSeries)
 	.globl machine_check_fwnmi
@@ -333,7 +333,7 @@ machine_check_fwnmi:
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 BEGIN_FTR_SECTION
-	b	machine_check_pSeries_early
+	b	machine_check_common_early
 END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
@@ -346,103 +346,6 @@ machine_check_pSeries_0:
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
-TRAMP_REAL_BEGIN(machine_check_pSeries_early)
-BEGIN_FTR_SECTION
-	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
-	mr	r10,r1			/* Save r1 */
-	lhz	r11,PACA_IN_MCE(r13)
-	cmpwi	r11,0			/* Are we in nested machine check */
-	bne	0f			/* Yes, we are. */
-	/* First machine check entry */
-	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
-0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
-	addi	r11,r11,1		/* increment paca->in_mce */
-	sth	r11,PACA_IN_MCE(r13)
-	/* Limit nested MCE to level 4 to avoid stack overflow */
-	cmpwi	r11,MAX_MCE_DEPTH
-	bgt	1f			/* Check if we hit limit of 4 */
-	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
-	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
-	EXCEPTION_PROLOG_COMMON_1()
-	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
-	EXCEPTION_PROLOG_COMMON_3(0x200)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call ABI */
-	ld	r12,_MSR(r1)
-	andi.	r11,r12,MSR_PR		/* See if coming from user. */
-	bne	2f			/* continue in V mode if we are. */
-
-	/*
-	 * At this point we are not sure about what context we come from.
-	 * We may be in the middle of swithing stack. r1 may not be valid.
-	 * Hence stay on emergency stack, call machine_check_exception and
-	 * return from the interrupt.
-	 * But before that, check if this is an un-recoverable exception.
-	 * If yes, then stay on emergency stack and panic.
-	 */
-	andi.	r11,r12,MSR_RI
-	beq	1f
-
-	/*
-	 * Check if we have successfully handled/recovered from error, if not
-	 * then stay on emergency stack and panic.
-	 */
-	cmpdi	r3,0		/* see if we handled MCE successfully */
-	beq	1f		/* if !handled then panic */
-
-	/* Stay on emergency stack and return from interrupt. */
-	LOAD_HANDLER(r10,mce_return)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.
-
-1:	LOAD_HANDLER(r10,unrecover_mce)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	/*
-	 * We are going down. But there are chances that we might get hit by
-	 * another MCE during panic path and we may run into unstable state
-	 * with no way out. Hence, turn ME bit off while going down, so that
-	 * when another MCE is hit during panic path, hypervisor will
-	 * power cycle the lpar, instead of getting into MCE loop.
-	 */
-	li	r3,MSR_ME
-	andc	r10,r10,r3		/* Turn off MSR_ME */
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.
-
-	/* Move original SRR0 and SRR1 into the respective regs */
-2:	ld	r9,_MSR(r1)
-	mtspr	SPRN_SRR1,r9
-	ld	r3,_NIP(r1)
-	mtspr	SPRN_SRR0,r3
-	ld	r9,_CTR(r1)
-	mtctr	r9
-	ld	r9,_XER(r1)
-	mtxer	r9
-	ld	r9,_LINK(r1)
-	mtlr	r9
-	REST_GPR(0, r1)
-	REST_8GPRS(2, r1)
-	REST_GPR(10, r1)
-	ld	r11,_CCR(r1)
-	mtcr	r11
-	/* Decrement paca->in_mce. */
-	lhz	r12,PACA_IN_MCE(r13)
-	subi	r12,r12,1
-	sth	r12,PACA_IN_MCE(r13)
-	REST_GPR(11, r1)
-	REST_2GPRS(12, r1)
-	/* restore original r1. */
-	ld	r1,GPR1(r1)
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
-	b	machine_check_pSeries_0
-END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
-
 EXC_COMMON_BEGIN(machine_check_common)
 	/*
 	 * Machine check is different because we use a different
@@ -541,6 +444,9 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	bl	machine_check_early
 	std	r3,RESULT(r1)	/* Save result */
 	ld	r12,_MSR(r1)
+BEGIN_FTR_SECTION
+	b	4f
+END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
 
 #ifdef	CONFIG_PPC_P7_NAP
 	/*
@@ -564,10 +470,11 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	 */
 	rldicl.	r11,r12,4,63		/* See if MC hit while in HV mode. */
 	beq	5f
-	andi.	r11,r12,MSR_PR		/* See if coming from user. */
+4:	andi.	r11,r12,MSR_PR		/* See if coming from user. */
 	bne	9f			/* continue in V mode if we are. */
 
 5:
+BEGIN_FTR_SECTION
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	/*
 	 * We are coming from kernel context. Check if we are coming from
@@ -578,6 +485,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	cmpwi	r11,0			/* Check if coming from guest */
 	bne	9f			/* continue if we are. */
 #endif
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	/*
 	 * At this point we are not sure about what context we come from.
 	 * Queue up the MCE event and return from the interrupt.
@@ -611,6 +519,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	cmpdi	r3,0		/* see if we handled MCE successfully */
 
 	beq	1b		/* if !handled then panic */
+BEGIN_FTR_SECTION
 	/*
 	 * Return from MC interrupt.
 	 * Queue up the MCE event so that we can log it later, while
@@ -619,10 +528,24 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
 	RFI_TO_USER_OR_KERNEL
+FTR_SECTION_ELSE
+	/*
+	 * pSeries: Return from MC interrupt. Before that stay on emergency
+	 * stack and call machine_check_exception to log the MCE event.
+	 */
+	LOAD_HANDLER(r10,mce_return)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	RFI_TO_KERNEL
+	b	.
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 9:
 	/* Deliver the machine check to host kernel in V mode. */
 	MACHINE_CHECK_HANDLER_WINDUP
-	b	machine_check_pSeries
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_0(PACA_EXMC)
+	b	machine_check_pSeries_0
 
 EXC_COMMON_BEGIN(unrecover_mce)
 	/* Invoke machine_check_exception to print MCE event and panic. */
@@ -640,29 +563,7 @@ EXC_COMMON_BEGIN(mce_return)
 	/* Invoke machine_check_exception to print MCE event and return. */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	machine_check_exception
-	ld	r9,_MSR(r1)
-	mtspr	SPRN_SRR1,r9
-	ld	r3,_NIP(r1)
-	mtspr	SPRN_SRR0,r3
-	ld	r9,_CTR(r1)
-	mtctr	r9
-	ld	r9,_XER(r1)
-	mtxer	r9
-	ld	r9,_LINK(r1)
-	mtlr	r9
-	REST_GPR(0, r1)
-	REST_8GPRS(2, r1)
-	REST_GPR(10, r1)
-	ld	r11,_CCR(r1)
-	mtcr	r11
-	/* Decrement paca->in_mce. */
-	lhz	r12,PACA_IN_MCE(r13)
-	subi	r12,r12,1
-	sth	r12,PACA_IN_MCE(r13)
-	REST_GPR(11, r1)
-	REST_2GPRS(12, r1)
-	/* restore original r1. */
-	ld	r1,GPR1(r1)
+	MACHINE_CHECK_HANDLER_WINDUP
 	RFI_TO_KERNEL
 	b	.
 
