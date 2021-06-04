Return-Path: <SRS0=yrNn=K6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60774C07E94
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 14:55:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C082E6140B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jun 2021 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C082E6140B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FxQmM6jXNz3c4m
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jun 2021 00:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FxQlS4r7xz3084
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jun 2021 00:54:28 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4FxQlC3wR1zBCvy;
 Fri,  4 Jun 2021 16:54:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1F1mw8VolGXn; Fri,  4 Jun 2021 16:54:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FxQlC32qmzBCvw;
 Fri,  4 Jun 2021 16:54:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 610808B8A9;
 Fri,  4 Jun 2021 16:54:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KMfNGPxWtXFD; Fri,  4 Jun 2021 16:54:15 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 19A338B885;
 Fri,  4 Jun 2021 16:54:15 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E794C64BDB; Fri,  4 Jun 2021 14:54:14 +0000 (UTC)
Message-Id: <552e27fa09394a6bc70585fcdfa237f99a5d1267.1622818435.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5ab3a517bc883a2fc905fb2cb5ee9344f37b2cfa.1622818435.git.christophe.leroy@csgroup.eu>
References: <5ab3a517bc883a2fc905fb2cb5ee9344f37b2cfa.1622818435.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/4] powerpc/32: Reduce code duplication of system call entry
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  4 Jun 2021 14:54:14 +0000 (UTC)
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

booke and non booke do pretty similar things in SYSCALL_ENTRY macro
just before calling jumping to transfer_to_syscall().

Do them in transfer_to_syscall() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S   | 19 +++++++++++++++++++
 arch/powerpc/kernel/head_32.h    | 19 -------------------
 arch/powerpc/kernel/head_booke.h | 18 ------------------
 3 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9160285cb2f4..0f53f6d11865 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -32,6 +32,7 @@
 #include <asm/barrier.h>
 #include <asm/kup.h>
 #include <asm/bug.h>
+#include <asm/interrupt.h>
 
 #include "head_32.h"
 
@@ -74,6 +75,24 @@ _ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
 
 	.globl	transfer_to_syscall
 transfer_to_syscall:
+	stw	r11, GPR1(r1)
+	stw	r11, 0(r1)
+	mflr	r12
+	stw	r12, _LINK(r1)
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?) */
+#endif
+	lis	r12,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
+	SAVE_GPR(2, r1)
+	addi	r12,r12,STACK_FRAME_REGS_MARKER@l
+	stw	r9,_MSR(r1)
+	li	r2, INTERRUPT_SYSCALL
+	stw	r12,8(r1)
+	stw	r2,_TRAP(r1)
+	SAVE_GPR(0, r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
+	addi	r2,r10,-THREAD
 	SAVE_NVGPRS(r1)
 
 	/* Calling convention has r9 = orig r0, r10 = regs */
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 7ca25eb9bc75..6b1ec9e3541b 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -155,29 +155,10 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
 	rfi
 1:
-	stw	r11,GPR1(r1)
-	stw	r11,0(r1)
-	mr	r11, r1
 	stw	r12,_NIP(r1)
-	mflr	r12
-	stw	r12, _LINK(r11)
 	mfcr	r12
 	rlwinm	r12,r12,0,4,2	/* Clear SO bit in CR */
 	stw	r12,_CCR(r1)
-#ifdef CONFIG_40x
-	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?) */
-#endif
-	lis	r12,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
-	stw	r2,GPR2(r11)
-	addi	r12,r12,STACK_FRAME_REGS_MARKER@l
-	stw	r9,_MSR(r11)
-	li	r2, \trapno
-	stw	r12,8(r11)
-	stw	r2,_TRAP(r11)
-	SAVE_GPR(0, r11)
-	SAVE_4GPRS(3, r11)
-	SAVE_2GPRS(7, r11)
-	addi	r2,r10,-THREAD
 	b	transfer_to_syscall		/* jump to handler */
 .endm
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 4a2fad9f225e..10f31146b472 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -140,26 +140,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	rlwinm	r12,r12,0,4,2	/* Clear SO bit in CR */
 	ALLOC_STACK_FRAME(r1, THREAD_SIZE - INT_FRAME_SIZE)
 	stw	r12, _CCR(r1)
-	mflr	r12
-	stw	r12,_LINK(r1)
 	mfspr	r12,SPRN_SRR0
-	stw	r11, GPR1(r1)
-	stw	r11, 0(r1)
-	mr	r11, r1
 	stw	r12,_NIP(r1)
-	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?)	   */
-	lis	r12, STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
-	stw	r2,GPR2(r11)
-	addi	r12, r12, STACK_FRAME_REGS_MARKER@l
-	stw	r9,_MSR(r11)
-	li	r2, \trapno
-	stw	r12, 8(r11)
-	stw	r2,_TRAP(r11)
-	SAVE_GPR(0, r11)
-	SAVE_4GPRS(3, r11)
-	SAVE_2GPRS(7, r11)
-
-	addi	r2,r10,-THREAD
 	b	transfer_to_syscall	/* jump to handler */
 .endm
 
-- 
2.25.0

