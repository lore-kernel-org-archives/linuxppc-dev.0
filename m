Return-Path: <SRS0=PlyA=GF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E8BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Jan 2021 12:49:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928E722283
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Jan 2021 12:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928E722283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D7MCY6VNmzDqsj
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Jan 2021 23:49:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430;
 helo=mail-pf1-x430.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=J7080pzm; dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7LhS0nphzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jan 2021 23:25:43 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id a188so898214pfa.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Jan 2021 04:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8KcSjITgs2OO7ns9CktxWulrx1kqEYm3P5mmQrnZx+I=;
 b=J7080pzm1lOTBcTcknCOTQJ4R/OuTMM02biW8fQaYT/qNxLy7q6cHkjfJYqgu6liVi
 w0LMDfNfAzlM3scoO10yE3Czc2RqLPrJLmNVb8/CE8kaTcpwzsVppw27mPXUkuRRcIJk
 Q5Dl2sJmBEZ48LPSm89evUj/vh+LhbyPeGx1FBglFF6hTezQon4eRux+g9uVcdCMSrCI
 EbzCt1oz1PDdg2dN0Q7djtHjykawDSAZeX8FJrRmx7hKBfHIXQ2Lv7aamgInex5ayz1a
 HsMfOC7G6i8unerPpQNM3PC3c+euQaTBoqEjWuVnC37dy5C/zTuvItvjpkpNdp7Cec/x
 FiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8KcSjITgs2OO7ns9CktxWulrx1kqEYm3P5mmQrnZx+I=;
 b=kM9I/c22fw37Ps0HZE4UddGhAT1i8IioOFgB5eP5FscUfPgNa2bWGO+OZ19g2quzLJ
 gERaTNhZXgGrvc5qJBb1LpNp/qR/OfDf0SS3kUdzPVYyJvNbhMiSIAgOE59gtHsLObdq
 CDw4dOOoQAQmu6RZLVHcmIPCq5P2AaqnbfmR9jpvNZPIgZYtCsEFogxVgiMxVuwpH/mm
 pa+lm4B9iQPPo309JBdCHC1DWSbiz6a/Lt3a65LYh5GBz44pKFO24M4/7aEmNhXBuWWk
 0TK467IzZU3D+wMrFlf/1GxVlidLwPf12ncnxGg219pAOKPMd0GJHn6RDIuCCBHKwVv3
 h2tg==
X-Gm-Message-State: AOAM533HqHB5DQI+WzgtCxmjawzqiXAb2uD+SO0pfdYxmQKK4CbG4gIJ
 DHY+aLFIWgZ5kN96f8YgrU6kBBm6H9k=
X-Google-Smtp-Source: ABdhPJyp+lljHmC9Jx6YjDX/2P74+Uxt8ctbjJxeusIeCIV0Qk9OLcM1WQbMaEZjMPTCJZ4231SU5g==
X-Received: by 2002:a65:5bc5:: with SMTP id o5mr31592617pgr.283.1609590340811; 
 Sat, 02 Jan 2021 04:25:40 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-97-30.tpgi.com.au. [193.116.97.30])
 by smtp.gmail.com with ESMTPSA id h4sm58501413pgp.8.2021.01.02.04.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jan 2021 04:25:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 08/21] powerpc: add interrupt_cond_local_irq_enable helper
Date: Sat,  2 Jan 2021 22:24:55 +1000
Message-Id: <20210102122508.1950592-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210102122508.1950592-1-npiggin@gmail.com>
References: <20210102122508.1950592-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Simple helper for synchronous interrupt handlers (i.e., process-context)
to enable interrupts if it was taken in an interrupts-enabled context.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h |  7 +++++++
 arch/powerpc/kernel/traps.c          | 24 +++++++-----------------
 arch/powerpc/mm/fault.c              |  4 +---
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 7c72c91c21ce..dfa846ebae43 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_INTERRUPT_H
 
 #include <linux/context_tracking.h>
+#include <linux/hardirq.h>
 #include <asm/ftrace.h>
 
 struct interrupt_state {
@@ -281,4 +282,10 @@ DECLARE_INTERRUPT_HANDLER_ASYNC(unknown_async_exception);
 void replay_system_reset(void);
 void replay_soft_interrupts(void);
 
+static inline void interrupt_cond_local_irq_enable(struct pt_regs *regs)
+{
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+}
+
 #endif /* _ASM_POWERPC_INTERRUPT_H */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f4462b481248..0b712c40272b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -343,8 +343,8 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 
 	show_signal_msg(signr, regs, code, addr);
 
-	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	if (arch_irqs_disabled())
+		interrupt_cond_local_irq_enable(regs);
 
 	current->thread.trap_nr = code;
 
@@ -1546,9 +1546,7 @@ DEFINE_INTERRUPT_HANDLER(program_check_exception)
 	if (!user_mode(regs))
 		goto sigill;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
@@ -1602,9 +1600,7 @@ DEFINE_INTERRUPT_HANDLER(alignment_exception)
 	int sig, code, fixed = 0;
 	unsigned long  reason;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	reason = get_reason(regs);
 
@@ -1765,9 +1761,7 @@ DEFINE_INTERRUPT_HANDLER(facility_unavailable_exception)
 		die("Unexpected facility unavailable exception", regs, SIGABRT);
 	}
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	if (status == FSCR_DSCR_LG) {
 		/*
@@ -2147,9 +2141,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	int code = FPE_FLTUNK;
 	int err;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	flush_spe_to_thread(current);
 
@@ -2196,9 +2188,7 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
 	extern int speround_handler(struct pt_regs *regs);
 	int err;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	preempt_disable();
 	if (regs->msr & MSR_SPE)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b4a221f0650c..81dbce473726 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -441,9 +441,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area_nosemaphore(regs, address);
 	}
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-- 
2.23.0

