Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A217C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:17:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07655214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="iUlBFPnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07655214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p6Xx6CgdzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 22:17:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="iUlBFPnm"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p6Py3L0GzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 22:11:18 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43p6Pm65B7z9v1q9;
 Mon, 28 Jan 2019 12:11:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=iUlBFPnm; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GIwWHlo7jFC7; Mon, 28 Jan 2019 12:11:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Pm4xgCz9v1q3;
 Mon, 28 Jan 2019 12:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548673868; bh=saDUtT7Lj1sgUMJR3xoCpkLtsLLCZYhVQci4j5PR0Fc=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=iUlBFPnmgQCD3DnRzstzCJl3o5JeO5aiRSRTWuS2obL2e3Z1eb9Ei8HyZVbnz9OLe
 9jRW8EpksAKIYCSsgSPnayS5L5VWUaetLN/pa6vBJsV7csU71rYyFDCyxcgfPB6aE3
 +Ra5SSsv/fpRFlevs+81ogQWGmYJDLLUht7Jh2vY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AF1F8B79D;
 Mon, 28 Jan 2019 12:11:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KusHfSiIWmY8; Mon, 28 Jan 2019 12:11:15 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EECDF8B796;
 Mon, 28 Jan 2019 12:11:14 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F3E6072DE6; Mon, 28 Jan 2019 11:11:14 +0000 (UTC)
Message-Id: <b5a30e51c0a65e810a19d22064249ee56e28dbca.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 02/11] powerpc/32: Refactor EXCEPTION entry macros for
 head_8xx.S and head_32.S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 28 Jan 2019 11:11:14 +0000 (UTC)
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

EXCEPTION_PROLOG is similar in head_8xx.S and head_32.S

This patch creates head_32.h and moves EXCEPTION_PROLOG macro
into it.

It also moves EXCEPTION() and EXC_XFER_XXXX() macros which are also
similar. For that, the 8xx needs to define a dummy DO_KVM asm macro.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  |  99 +--------------------------------------
 arch/powerpc/kernel/head_32.h  | 104 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_8xx.S | 101 ++-------------------------------------
 3 files changed, 111 insertions(+), 193 deletions(-)
 create mode 100644 arch/powerpc/kernel/head_32.h

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 9268e5e87949..a5efcdc78e8e 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -37,6 +37,8 @@
 #include <asm/export.h>
 #include <asm/feature-fixups.h>
 
+#include "head_32.h"
+
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
 	/* see the comment for clear_bats() -- Cort */ \
@@ -242,103 +244,6 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.long	-1
 
-/*
- * Exception entry code.  This code runs with address translation
- * turned off, i.e. using physical addresses.
- * We assume sprg3 has the physical address of the current
- * task's thread_struct.
- */
-#define EXCEPTION_PROLOG	\
-	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
-	mtspr	SPRN_SPRG_SCRATCH1,r11;	\
-	mfcr	r10;		\
-	EXCEPTION_PROLOG_1;	\
-	EXCEPTION_PROLOG_2
-
-#define EXCEPTION_PROLOG_1	\
-	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
-	andi.	r11,r11,MSR_PR;	\
-	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
-	beq	1f;		\
-	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,TASK_STACK-THREAD(r11);	\
-	addi	r11,r11,THREAD_SIZE;	\
-	tophys(r11,r11);	\
-1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
-
-
-#define EXCEPTION_PROLOG_2	\
-	stw	r10,_CCR(r11);		/* save registers */ \
-	stw	r12,GPR12(r11);	\
-	stw	r9,GPR9(r11);	\
-	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
-	stw	r10,GPR10(r11);	\
-	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
-	stw	r12,GPR11(r11);	\
-	mflr	r10;		\
-	stw	r10,_LINK(r11);	\
-	mfspr	r12,SPRN_SRR0;	\
-	mfspr	r9,SPRN_SRR1;	\
-	stw	r1,GPR1(r11);	\
-	stw	r1,0(r11);	\
-	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	MTMSRD(r10);			/* (except for mach check in rtas) */ \
-	stw	r0,GPR0(r11);	\
-	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
-	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
-	stw	r10,8(r11);	\
-	SAVE_4GPRS(3, r11);	\
-	SAVE_2GPRS(7, r11)
-
-/*
- * Note: code which follows this uses cr0.eq (set if from kernel),
- * r11, r12 (SRR0), and r9 (SRR1).
- *
- * Note2: once we have set r1 we are in a position to take exceptions
- * again, and we could thus set MSR:RI at that point.
- */
-
-/*
- * Exception vectors.
- */
-#define EXCEPTION(n, label, hdlr, xfer)		\
-	. = n;					\
-	DO_KVM n;				\
-label:						\
-	EXCEPTION_PROLOG;			\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
-	xfer(n, hdlr)
-
-#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
-	li	r10,trap;					\
-	stw	r10,_TRAP(r11);					\
-	li	r10,MSR_KERNEL;					\
-	copyee(r10, r9);					\
-	bl	tfer;						\
-i##n:								\
-	.long	hdlr;						\
-	.long	ret
-
-#define COPY_EE(d, s)		rlwimi d,s,0,16,16
-#define NOCOPY(d, s)
-
-#define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
-			  ret_from_except_full)
-
-#define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
-			  ret_from_except)
-
-#define EXC_XFER_EE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
-			  ret_from_except_full)
-
-#define EXC_XFER_EE_LITE(n, hdlr)	\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
-			  ret_from_except)
-
 /* System reset */
 /* core99 pmac starts the seconary here by changing the vector, and
    putting it back to what it was (unknown_exception) when done.  */
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
new file mode 100644
index 000000000000..7356c27d2136
--- /dev/null
+++ b/arch/powerpc/kernel/head_32.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HEAD_32_H__
+#define __HEAD_32_H__
+
+#include <asm/ptrace.h>	/* for STACK_FRAME_REGS_MARKER */
+
+/*
+ * Exception entry code.  This code runs with address translation
+ * turned off, i.e. using physical addresses.
+ * We assume sprg3 has the physical address of the current
+ * task's thread_struct.
+ */
+#define EXCEPTION_PROLOG	\
+	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
+	mtspr	SPRN_SPRG_SCRATCH1,r11;	\
+	mfcr	r10;		\
+	EXCEPTION_PROLOG_1;	\
+	EXCEPTION_PROLOG_2
+
+#define EXCEPTION_PROLOG_1	\
+	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
+	andi.	r11,r11,MSR_PR;	\
+	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
+	beq	1f;		\
+	mfspr	r11,SPRN_SPRG_THREAD;	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
+	addi	r11,r11,THREAD_SIZE;	\
+	tophys(r11,r11);	\
+1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
+
+
+#define EXCEPTION_PROLOG_2	\
+	stw	r10,_CCR(r11);		/* save registers */ \
+	stw	r12,GPR12(r11);	\
+	stw	r9,GPR9(r11);	\
+	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
+	stw	r10,GPR10(r11);	\
+	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
+	stw	r12,GPR11(r11);	\
+	mflr	r10;		\
+	stw	r10,_LINK(r11);	\
+	mfspr	r12,SPRN_SRR0;	\
+	mfspr	r9,SPRN_SRR1;	\
+	stw	r1,GPR1(r11);	\
+	stw	r1,0(r11);	\
+	tovirt(r1,r11);			/* set new kernel sp */	\
+	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
+	MTMSRD(r10);			/* (except for mach check in rtas) */ \
+	stw	r0,GPR0(r11);	\
+	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
+	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
+	stw	r10,8(r11);	\
+	SAVE_4GPRS(3, r11);	\
+	SAVE_2GPRS(7, r11)
+
+/*
+ * Note: code which follows this uses cr0.eq (set if from kernel),
+ * r11, r12 (SRR0), and r9 (SRR1).
+ *
+ * Note2: once we have set r1 we are in a position to take exceptions
+ * again, and we could thus set MSR:RI at that point.
+ */
+
+/*
+ * Exception vectors.
+ */
+#define EXCEPTION(n, label, hdlr, xfer)		\
+	. = n;					\
+	DO_KVM n;				\
+label:						\
+	EXCEPTION_PROLOG;			\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
+	xfer(n, hdlr)
+
+#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
+	li	r10,trap;					\
+	stw	r10,_TRAP(r11);					\
+	li	r10,MSR_KERNEL;					\
+	copyee(r10, r9);					\
+	bl	tfer;						\
+i##n:								\
+	.long	hdlr;						\
+	.long	ret
+
+#define COPY_EE(d, s)		rlwimi d,s,0,MSR_EE
+#define NOCOPY(d, s)
+
+#define EXC_XFER_STD(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
+			  ret_from_except_full)
+
+#define EXC_XFER_LITE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
+#define EXC_XFER_EE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
+			  ret_from_except_full)
+
+#define EXC_XFER_EE_LITE(n, hdlr)	\
+	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
+			  ret_from_except)
+
+#endif /* __HEAD_32_H__ */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index ca9207013579..d9c5bc48bef0 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -33,6 +33,11 @@
 #include <asm/export.h>
 #include <asm/code-patching-asm.h>
 
+.macro DO_KVM intno
+.endm
+
+#include "head_32.h"
+
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
 /* By simply checking Address >= 0x80000000, we know if its a kernel address */
 #define SIMPLE_KERNEL_ADDRESS		1
@@ -123,102 +128,6 @@ instruction_counter:
 	.space	4
 #endif
 
-/*
- * Exception entry code.  This code runs with address translation
- * turned off, i.e. using physical addresses.
- * We assume sprg3 has the physical address of the current
- * task's thread_struct.
- */
-#define EXCEPTION_PROLOG	\
-	mtspr	SPRN_SPRG_SCRATCH0, r10;	\
-	mtspr	SPRN_SPRG_SCRATCH1, r11;	\
-	mfcr	r10;		\
-	EXCEPTION_PROLOG_1;	\
-	EXCEPTION_PROLOG_2
-
-#define EXCEPTION_PROLOG_1	\
-	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
-	andi.	r11,r11,MSR_PR;	\
-	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
-	beq	1f;		\
-	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,TASK_STACK-THREAD(r11);	\
-	addi	r11,r11,THREAD_SIZE;	\
-	tophys(r11,r11);	\
-1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
-
-
-#define EXCEPTION_PROLOG_2	\
-	stw	r10,_CCR(r11);		/* save registers */ \
-	stw	r12,GPR12(r11);	\
-	stw	r9,GPR9(r11);	\
-	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
-	stw	r10,GPR10(r11);	\
-	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
-	stw	r12,GPR11(r11);	\
-	mflr	r10;		\
-	stw	r10,_LINK(r11);	\
-	mfspr	r12,SPRN_SRR0;	\
-	mfspr	r9,SPRN_SRR1;	\
-	stw	r1,GPR1(r11);	\
-	stw	r1,0(r11);	\
-	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	mtmsr	r10;		\
-	stw	r0,GPR0(r11);	\
-	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l; \
-	stw	r10, 8(r11);	\
-	SAVE_4GPRS(3, r11);	\
-	SAVE_2GPRS(7, r11)
-
-/*
- * Note: code which follows this uses cr0.eq (set if from kernel),
- * r11, r12 (SRR0), and r9 (SRR1).
- *
- * Note2: once we have set r1 we are in a position to take exceptions
- * again, and we could thus set MSR:RI at that point.
- */
-
-/*
- * Exception vectors.
- */
-#define EXCEPTION(n, label, hdlr, xfer)		\
-	. = n;					\
-label:						\
-	EXCEPTION_PROLOG;			\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
-	xfer(n, hdlr)
-
-#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
-	li	r10,trap;					\
-	stw	r10,_TRAP(r11);					\
-	li	r10,MSR_KERNEL;					\
-	copyee(r10, r9);					\
-	bl	tfer;						\
-i##n:								\
-	.long	hdlr;						\
-	.long	ret
-
-#define COPY_EE(d, s)		rlwimi d,s,0,16,16
-#define NOCOPY(d, s)
-
-#define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
-			  ret_from_except_full)
-
-#define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
-			  ret_from_except)
-
-#define EXC_XFER_EE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
-			  ret_from_except_full)
-
-#define EXC_XFER_EE_LITE(n, hdlr)	\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
-			  ret_from_except)
-
 /* System reset */
 	EXCEPTION(0x100, Reset, system_reset_exception, EXC_XFER_STD)
 
-- 
2.13.3

