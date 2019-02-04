Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED1C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:40:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F592083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxQhuwrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F592083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVk83zGZzDqKS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:40:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxQhuwrF"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFL4TNmzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:02 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id q1so6818542pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=POYvH8w7uRzVxOIY7M9s5cHhLUlr2LJlCwubpXkNKo8=;
 b=kxQhuwrFaLj2+DMarMTdPtcNkrABZRz6YvZNvmaoHUPUVLBzGm1RlXpWTWyLqpUgQy
 RcwqvabnMFkOnQkzV46fQUH6ETzKH40JChKgFwb2D4KPpbO8/PjAWY6eGikfTMsNUQw4
 XrSX7a+bK+iWy+sf6BEF4p+gNVsZjWt+oSqmYqYN9iHfqy+Gmt+3iAIx8RIs4Uaqio5z
 OVCInSmAMu8ee9WssdToxtoqv8D1GieWnag6jn+W1hhVRfhkj3AZVqMJw0ZYLPeQJFOp
 YBfOw/99F/QBVmh6vu6xl07UfNYl8oNaMB9NF0IQAFp7/TtcN/qrRrHPUy6DgmboJBCx
 QKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=POYvH8w7uRzVxOIY7M9s5cHhLUlr2LJlCwubpXkNKo8=;
 b=A0Oeob/rJFQ27UBwTPE/6ghAgxo8SGr5px8MzOz4AX6VKkVG9sud2JSEArSQveC0Tk
 ltZ3SueIYZSzvBPbAdfojY5uR+vicSD9Wk4IJ2tD49X734mPvVHBR++oS0WprbCPUP5z
 wfecPRBugR9aBgJByGc0R+51kM8W4ZjpFDTunYYXz7efwP1JF/dqxm28dF2MHcBJbl2m
 +9P7Dl7JXZXuIFesWdfnZntItBI1PejBbkJIWSFOcM5moEXiEjF3038p4nSSjLXikSpI
 I4V15orpNBVvqtspTnuqM1RWPyU7RoxdOGb3t1k2vq8a+gVN+AewODtTiCh3gpNkZmvQ
 xWDQ==
X-Gm-Message-State: AHQUAuYvpUy0MYFyroNiRlrS2bS889GRXOeLOtOwxIyhy5Ew94b/YGvY
 cY/DwA1+soIme1uyq2ZXtvGmFEPU
X-Google-Smtp-Source: AHgI3IZsukpzULjvIfbZY1lBq3pCaTTCoPUYUvxsBAkNDy1BBBX9m57Zi7OhguMCZgRVQmULpXtrIg==
X-Received: by 2002:a63:e554:: with SMTP id z20mr235131pgj.394.1549289940620; 
 Mon, 04 Feb 2019 06:19:00 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/17] powerpc/64s/exception: Move EXCEPTION_COMMON handler
 and return branches into callers
Date: Tue,  5 Feb 2019 00:18:21 +1000
Message-Id: <20190204141828.13043-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204141828.13043-1-npiggin@gmail.com>
References: <20190204141828.13043-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The aim is to reduce the amount of indirection it takes to get through
the exception handler macros, particularly where it provides little
code sharing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 26 ++++++++++++------------
 arch/powerpc/kernel/exceptions-64s.S     | 21 +++++++++++--------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 35efb46c6f5f..676c877f6190 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -661,30 +661,27 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
-#define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
+#define EXCEPTION_COMMON(area, trap, label, additions)		\
 	EXCEPTION_PROLOG_COMMON(trap, area);			\
 	/* Volatile regs are potentially clobbered here */	\
-	additions;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr;						\
-	b	ret
+	additions
 
 /*
  * Exception where stack is already set in r1, r1 is saved in r10, and it
  * continues rather than returns.
  */
-#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
+#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, additions) \
 	EXCEPTION_PROLOG_COMMON_1();				\
 	EXCEPTION_PROLOG_COMMON_2(area);			\
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
-	additions;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr
+	additions
 
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
-		ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label, ADD_NVGPRS;ADD_RECONCILE); \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr;						\
+	b	ret_from_except
 
 /*
  * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
@@ -692,8 +689,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  * (finish nap and runlatch)
  */
 #define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
-		ret_from_except_lite, FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label,		\
+		FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON);		\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr;						\
+	b	ret_from_except_lite
 
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d6316725a43b..6f0c270f45e4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -180,9 +180,10 @@ EXC_COMMON_BEGIN(system_reset_common)
 	mr	r10,r1
 	ld	r1,PACA_NMI_EMERG_SP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100,
-			system_reset, system_reset_exception,
-			ADD_NVGPRS;ADD_RECONCILE_NMI)
+	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100, system_reset,
+					ADD_NVGPRS;ADD_RECONCILE_NMI)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	system_reset_exception
 
 	/* This (and MCE) can be simplified with mtmsrd L=1 */
 	/* Clear MSR_RI before setting SRR0 and SRR1. */
@@ -1090,8 +1091,11 @@ hmi_exception_after_realmode:
 	b	tramp_real_hmi_exception
 
 EXC_COMMON_BEGIN(hmi_exception_common)
-EXCEPTION_COMMON(PACA_EXGEN, 0xe60, hmi_exception_common, handle_hmi_exception,
-        ret_from_except, FINISH_NAP;ADD_NVGPRS;ADD_RECONCILE;RUNLATCH_ON)
+EXCEPTION_COMMON(PACA_EXGEN, 0xe60, hmi_exception_common,
+			FINISH_NAP;ADD_NVGPRS;ADD_RECONCILE;RUNLATCH_ON)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	handle_hmi_exception
+	b	ret_from_except
 
 EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0x20, IRQS_DISABLED)
 EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x20, 0xe80, IRQS_DISABLED)
@@ -1386,9 +1390,10 @@ EXC_COMMON_BEGIN(soft_nmi_common)
 	mr	r10,r1
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900,
-			system_reset, soft_nmi_interrupt,
-			ADD_NVGPRS;ADD_RECONCILE)
+	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900, system_reset,
+					ADD_NVGPRS;ADD_RECONCILE)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	soft_nmi_interrupt
 	b	ret_from_except
 
 #else /* CONFIG_PPC_WATCHDOG */
-- 
2.18.0

