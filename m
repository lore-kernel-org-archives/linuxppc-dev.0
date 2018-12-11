Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40252C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:33:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF3C2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dd976zRRzDr0N
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:32:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dcym4HlRzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 22:24:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Dcyh4wWczB09bG;
 Tue, 11 Dec 2018 12:23:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fDeMGUhXhSs4; Tue, 11 Dec 2018 12:23:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Dcyh4P2HzB09b7;
 Tue, 11 Dec 2018 12:23:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9593A8B7EB;
 Tue, 11 Dec 2018 12:23:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jMxaIqWbF60M; Tue, 11 Dec 2018 12:23:57 +0100 (CET)
Received: from PO15451.localdomain (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 544128B7E7;
 Tue, 11 Dec 2018 12:23:57 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id A2CC171702; Tue, 11 Dec 2018 11:23:56 +0000 (UTC)
Message-Id: <eee4cf5ade9e3fd7dd9e5069e7094299b40ea5cc.1544519035.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1544519035.git.christophe.leroy@c-s.fr>
References: <cover.1544519035.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 3/3] powerpc/8xx: Enable CONFIG_VMAP_STACK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 11 Dec 2018 11:23:56 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch enables CONFIG_VMAP_STACK. For that, a few changes are
done in head_8xx.S to re-activation DATA MMU Translation before
accessing to the stack.

Due to the growing of exception prolog, a few rearrangement is also
done in a few exception handlers.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/kernel/head_8xx.S | 87 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 94b46624068d..323b8a1efb3e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -180,6 +180,7 @@ config PPC
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_VMAP_STACK		if PPC_8xx
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
 	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 48996a424075..ded66a6fdfeb 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -136,6 +136,53 @@ instruction_counter:
 	EXCEPTION_PROLOG_1;	\
 	EXCEPTION_PROLOG_2
 
+#ifdef CONFIG_VMAP_STACK
+#define EXCEPTION_PROLOG_1	\
+	mtspr	SPRN_SPRG_SCRATCH2, r12;	\
+	mfspr	r12, SPRN_SPRG_THREAD;	\
+	mfspr	r11, SPRN_SRR0;	\
+	stw	r11, SRR0(r12);	\
+	mfspr	r11, SPRN_DAR;	\
+	stw	r11, DAR(r12);	\
+	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
+	stw	r11, SRR1(r12);	\
+	andi.	r11,r11,MSR_PR
+
+#define EXCEPTION_PROLOG_2	\
+	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI); /* can take DTLB miss */ \
+	mtmsr	r11;		\
+	tovirt(r12, r12);	\
+	subi	r11, r1, INT_FRAME_SIZE;	/* use r1 if kernel */ \
+	beq	1f;		\
+	lwz	r11, TASK_STACK-THREAD(r12);	\
+	addi	r11, r11, THREAD_SIZE - INT_FRAME_SIZE;	\
+1:	stw	r10,_CCR(r11);		/* save registers */ \
+	stw	r9,GPR9(r11);	\
+	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
+	stw	r10,GPR10(r11);	\
+	mfspr	r10,SPRN_SPRG_SCRATCH1;	\
+	stw	r10,GPR11(r11);	\
+	mfspr	r10,SPRN_SPRG_SCRATCH2;	\
+	stw	r10,GPR12(r11);	\
+	mflr	r10;		\
+	stw	r10,_LINK(r11);	\
+	lwz	r10, DAR(r12);	\
+	stw	r10, _DAR(r11);	\
+	lwz	r9, SRR1(r12);	\
+	lwz	r12, SRR0(r12);	\
+	stw	r1,GPR1(r11);	\
+	stw	r1,0(r11);	\
+	mr	r1, r11;			/* set new kernel sp */	\
+	li	r10,MSR_KERNEL & ~MSR_IR; /* can take exceptions */ \
+	mtmsr	r10;		\
+	stw	r0,GPR0(r11);	\
+	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l; \
+	stw	r10, 8(r11);	\
+	SAVE_4GPRS(3, r11);	\
+	SAVE_2GPRS(7, r11)
+
+#else
 #define EXCEPTION_PROLOG_1	\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
 	andi.	r11,r11,MSR_PR;	\
@@ -172,6 +219,8 @@ instruction_counter:
 	SAVE_4GPRS(3, r11);	\
 	SAVE_2GPRS(7, r11)
 
+#endif
+
 /*
  * Note: code which follows this uses cr0.eq (set if from kernel),
  * r11, r12 (SRR0), and r9 (SRR1).
@@ -226,8 +275,12 @@ i##n:								\
 	. = 0x200
 MachineCheck:
 	EXCEPTION_PROLOG
+#ifdef CONFIG_VMAP_STACK
+	lwz r4, _DAR(r11)
+#else
 	mfspr r4,SPRN_DAR
 	stw r4,_DAR(r11)
+#endif
 	li r5,RPN_PATTERN
 	mtspr SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
 	mfspr r5,SPRN_DSISR
@@ -254,8 +307,12 @@ InstructionAccess:
 	. = 0x600
 Alignment:
 	EXCEPTION_PROLOG
+#ifdef CONFIG_VMAP_STACK
+	lwz r4, _DAR(r11)
+#else
 	mfspr	r4,SPRN_DAR
 	stw	r4,_DAR(r11)
+#endif
 	li	r5,RPN_PATTERN
 	mtspr	SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
 	mfspr	r5,SPRN_DSISR
@@ -573,20 +630,31 @@ DataTLBError:
 	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
 DARFixed:/* Return from dcbx instruction bug workaround */
 	EXCEPTION_PROLOG_1
+#ifdef CONFIG_VMAP_STACK
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR, to be used in DTLB Error */
+#endif
 	EXCEPTION_PROLOG_2
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
+#ifdef CONFIG_VMAP_STACK
+	lwz r4, _DAR(r11)
+#else
 	mfspr	r4,SPRN_DAR
+#endif
 	andis.	r10,r5,DSISR_NOHPTE@h
 	beq+	1f
 	tlbie	r4
 dtlbie:
-1:	li	r10,RPN_PATTERN
+1:
+#ifndef CONFIG_VMAP_STACK
+	li	r10, RPN_PATTERN
 	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
+#endif
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
-	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
+/*	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)*/
 	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
@@ -598,6 +666,12 @@ dtlbie:
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
+11:
+	mtcr	r10
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+
 	. = 0x1c00
 DataBreakpoint:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
@@ -606,8 +680,8 @@ DataBreakpoint:
 	mfspr	r11, SPRN_SRR0
 	cmplwi	cr0, r11, (dtlbie - PAGE_OFFSET)@l
 	cmplwi	cr7, r11, (itlbie - PAGE_OFFSET)@l
-	beq-	cr0, 11f
-	beq-	cr7, 11f
+	beq-	cr0, 11b
+	beq-	cr7, 11b
 	EXCEPTION_PROLOG_1
 	EXCEPTION_PROLOG_2
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -615,11 +689,6 @@ DataBreakpoint:
 	stw	r4,_DAR(r11)
 	mfspr	r5,SPRN_DSISR
 	EXC_XFER_EE(0x1c00, do_break)
-11:
-	mtcr	r10
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
 
 #ifdef CONFIG_PERF_EVENTS
 	. = 0x1d00
-- 
2.13.3

