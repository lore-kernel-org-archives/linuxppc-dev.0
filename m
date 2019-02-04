Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA70C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C872082F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df/zsn43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C872082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVmT37tNzDq6Q
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:42:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Df/zsn43"; 
 dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFP0Df7zDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:04 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id d72so6324885pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RmypbQRPZFHlf2IQAf+rnrPzSxsLKOEHDidvumWG628=;
 b=Df/zsn43KP+qd6xKPKg2Jcvqk2D1mHee/fA5hMde7y81sSkmghOQ3sdDboKWqHLuwq
 gsVPv8iqEF964jA6M8ikMeBIi97CxPqCqlD32So9N75fy3GPXHSZzqz1gAXoBRrluWws
 sNt+XgtWhZgTUvYcR6XX3wZGEV0p3cx3nh9RMhSGT2rN/6WIvaapXmgiBo8KHtbXIekE
 r2Jw9VWd5GkCiz5bphK95dTceaoEc5Aa4n6lGFk6iua/gFgMYBVvNibTad/g2GJc8r58
 5lyqFB53CvHBOvc33zBJ7gHE/HlplZobKGPOrGBiMsVWEtkR5n7icrz33f0iKW0kd0SX
 dT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RmypbQRPZFHlf2IQAf+rnrPzSxsLKOEHDidvumWG628=;
 b=LUKSWdYG+FLYezPSrGSi70SizrWh1jw+yhthrTjJuDsanGhSg13UZc1n+NkEe8GcB+
 meSKNUxIFZcvDeDa0ruf23J2R4AtB4r0i9jYTeT/o+NLSUWuiEqDbVRqE3H7J/fzXgA2
 W5yJsf/FaUxa4oUvA53zCUOHL24JrwsxDTqzNDoiAYkjSSKWpIU10T0eb6L1Qvuf65VP
 zXdy5ai9FUgmqn/jVXE6I9aN4zRlqZUF2c1XDrd06A1T/SUDQtK/Ofc+eHP11uu6Tvl0
 8BdfKhpkZ0sYlnHknEK91MKM6zrepotTiW/INFCJvya/taaNSawGJNN6mh+YtSJfiAUI
 clTw==
X-Gm-Message-State: AHQUAua4aFLZRI/3J3ng1dzypI6A3F1RtCP3j4nqLOwcXT0Lc0djwu0m
 7JbiDmqjbZq7YmTlOqENo6bl8MF9
X-Google-Smtp-Source: AHgI3IYnNE+wGMzmsxf2Rp3dG3+dwG4lqMjqLx1J6XfMGQl1q+YA/sZDr0nz+xXqklZuKTu5gYFIdw==
X-Received: by 2002:a63:3f89:: with SMTP id
 m131mr10551113pga.115.1549289942831; 
 Mon, 04 Feb 2019 06:19:02 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.19.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/17] powerpc/64s/exception: Move EXCEPTION_COMMON additions
 into callers
Date: Tue,  5 Feb 2019 00:18:22 +1000
Message-Id: <20190204141828.13043-12-npiggin@gmail.com>
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

More cases of code insertion via macros that does not add a great
deal. All the additions have to be specified in the macro arguments,
so they can just as well go after the macro.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 42 +++++++---------------
 arch/powerpc/include/asm/head-64.h       |  4 +--
 arch/powerpc/kernel/exceptions-64s.S     | 45 +++++++++++++-----------
 3 files changed, 39 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 676c877f6190..05e8aff58d96 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -638,21 +638,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_VIRT label, EXC_HV
 
-/*
- * Our exception common code can be passed various "additions"
- * to specify the behaviour of interrupts, whether to kick the
- * runlatch, etc...
- */
-
-/*
- * This addition reconciles our actual IRQ state with the various software
- * flags that track it. This may call C code.
- */
-#define ADD_RECONCILE	RECONCILE_IRQ_STATE(r10,r11)
-
-#define ADD_NVGPRS				\
-	bl	save_nvgprs
-
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
 	CURRENT_THREAD_INFO(r3, r1);		\
@@ -661,24 +646,21 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
-#define EXCEPTION_COMMON(area, trap, label, additions)		\
+#define EXCEPTION_COMMON(area, trap)				\
 	EXCEPTION_PROLOG_COMMON(trap, area);			\
-	/* Volatile regs are potentially clobbered here */	\
-	additions
 
 /*
- * Exception where stack is already set in r1, r1 is saved in r10, and it
- * continues rather than returns.
+ * Exception where stack is already set in r1, r1 is saved in r10
  */
-#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, additions) \
+#define EXCEPTION_COMMON_STACK(area, trap)			\
 	EXCEPTION_PROLOG_COMMON_1();				\
 	EXCEPTION_PROLOG_COMMON_2(area);			\
-	EXCEPTION_PROLOG_COMMON_3(trap);			\
-	/* Volatile regs are potentially clobbered here */	\
-	additions
+	EXCEPTION_PROLOG_COMMON_3(trap)
 
-#define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label, ADD_NVGPRS;ADD_RECONCILE); \
+#define STD_EXCEPTION_COMMON(trap, hdlr)			\
+	EXCEPTION_COMMON(PACA_EXGEN, trap);			\
+	bl	save_nvgprs;					\
+	RECONCILE_IRQ_STATE(r10, r11);				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr;						\
 	b	ret_from_except
@@ -688,9 +670,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  * in the idle task and therefore need the special idle handling
  * (finish nap and runlatch)
  */
-#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		\
-	EXCEPTION_COMMON(PACA_EXGEN, trap, label,		\
-		FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON);		\
+#define STD_EXCEPTION_COMMON_ASYNC(trap, hdlr)			\
+	EXCEPTION_COMMON(PACA_EXGEN, trap);			\
+	FINISH_NAP;						\
+	RECONCILE_IRQ_STATE(r10, r11);				\
+	RUNLATCH_ON;						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr;						\
 	b	ret_from_except_lite
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index bdd67a26e959..acd94fcf9f40 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -403,11 +403,11 @@ end_##sname:
 
 #define EXC_COMMON(name, realvec, hdlr)					\
 	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON(realvec, name, hdlr)
+	STD_EXCEPTION_COMMON(realvec, hdlr)
 
 #define EXC_COMMON_ASYNC(name, realvec, hdlr)				\
 	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON_ASYNC(realvec, name, hdlr)
+	STD_EXCEPTION_COMMON_ASYNC(realvec, hdlr)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6f0c270f45e4..346df79dca6a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -149,21 +149,6 @@ EXC_COMMON_BEGIN(system_reset_idle_common)
 	b	pnv_powersave_wakeup
 #endif
 
-/*
- * Set IRQS_ALL_DISABLED unconditionally so arch_irqs_disabled does
- * the right thing. We do not want to reconcile because that goes
- * through irq tracing which we don't want in NMI.
- *
- * Save PACAIRQHAPPENED because some code will do a hard disable
- * (e.g., xmon). So we want to restore this back to where it was
- * when we return. DAR is unused in the stack, so save it there.
- */
-#define ADD_RECONCILE_NMI						\
-	li	r10,IRQS_ALL_DISABLED;					\
-	stb	r10,PACAIRQSOFTMASK(r13);				\
-	lbz	r10,PACAIRQHAPPENED(r13);				\
-	std	r10,_DAR(r1)
-
 EXC_COMMON_BEGIN(system_reset_common)
 	/*
 	 * Increment paca->in_nmi then enable MSR_RI. SLB or MCE will be able
@@ -180,8 +165,22 @@ EXC_COMMON_BEGIN(system_reset_common)
 	mr	r10,r1
 	ld	r1,PACA_NMI_EMERG_SP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100, system_reset,
-					ADD_NVGPRS;ADD_RECONCILE_NMI)
+	EXCEPTION_COMMON_STACK(PACA_EXNMI, 0x100)
+	bl	save_nvgprs
+	/*
+	 * Set IRQS_ALL_DISABLED unconditionally so arch_irqs_disabled does
+	 * the right thing. We do not want to reconcile because that goes
+	 * through irq tracing which we don't want in NMI.
+	 *
+	 * Save PACAIRQHAPPENED because some code will do a hard disable
+	 * (e.g., xmon). So we want to restore this back to where it was
+	 * when we return. DAR is unused in the stack, so save it there.
+	 */
+	li	r10,IRQS_ALL_DISABLED
+	stb	r10,PACAIRQSOFTMASK(r13)
+	lbz	r10,PACAIRQHAPPENED(r13)
+	std	r10,_DAR(r1)
+
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	system_reset_exception
 
@@ -1091,8 +1090,11 @@ hmi_exception_after_realmode:
 	b	tramp_real_hmi_exception
 
 EXC_COMMON_BEGIN(hmi_exception_common)
-EXCEPTION_COMMON(PACA_EXGEN, 0xe60, hmi_exception_common,
-			FINISH_NAP;ADD_NVGPRS;ADD_RECONCILE;RUNLATCH_ON)
+	EXCEPTION_COMMON(PACA_EXGEN, 0xe60)
+	FINISH_NAP
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	RUNLATCH_ON
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	handle_hmi_exception
 	b	ret_from_except
@@ -1390,8 +1392,9 @@ EXC_COMMON_BEGIN(soft_nmi_common)
 	mr	r10,r1
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
-	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900, system_reset,
-					ADD_NVGPRS;ADD_RECONCILE)
+	EXCEPTION_COMMON_STACK(PACA_EXGEN, 0x900)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	soft_nmi_interrupt
 	b	ret_from_except
-- 
2.18.0

