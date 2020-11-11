Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC7C388F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 10:19:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8AB720679
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 10:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/A3Zn7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AB720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWLLB5663zDqJm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 21:18:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=O/A3Zn7W; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWKZW1XMpzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 20:44:34 +1100 (AEDT)
Received: by mail-pj1-x1041.google.com with SMTP id gv24so438179pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGGaVMN6M7ePThvDpqWyoqkqYlW0HAMEanLvzZa8I9E=;
 b=O/A3Zn7WykVLWTngW6aa8t6NW/Q2VECTRABmIdWDOeIJ2Xeow5in9oQYtiKVBiOG8B
 COEULMxy4FDd2O1KmQcwLtAq1No9O6l2o+qTMS5XY80OWSjF1Y7tkcbFbsv7gXVyeMgH
 IZ0IJVSW71dnLbaaoJkQP+enWV4CuSLzx8Tkg44f6rg1MdvOzXxu1aCblvlKKVOPZKae
 btbF/aGqoJhi3g1hvk4yMNb1lS2Jb0X7GjztQ4l42ZxAFekMMBfjKb145c2ObdF9KhND
 IM9Oh5/+cnmXPshyTA2az+0Bc8Y+J2+BVGrhu1+BMnan4N3YdXz4zem64i3+MA50v8Fy
 iRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGGaVMN6M7ePThvDpqWyoqkqYlW0HAMEanLvzZa8I9E=;
 b=c5OTmXHLIAp6wzqEUtbC1DKZy2Qc3haO2sFIV2VG2znh980YaHD63XadpD9k0v+Y2t
 tUXOept7CQ8BRQeXdd01+0UpdHREWtZ+YrsgH7gWCorGV7+Qezn5RhTLDlBiY6Brjip9
 1WDHqKiqCUhB/xB1WrgC5OfkvoUzXRVKwHRnHQk+eoDitf7OQ5Ebu7kqdyf+FDUh332U
 NkhvkXboCJS2+P0RJKNkgRG+7foKD5MAV4bc9VE1qRI/+7BhdJFhZD4QMItGqU1B9ydD
 CV2bw7IFjuVBALkXf0aYExo9gMiotXcCrENdAiKJhii16yn8Wk5Km1AtV0x5lgEhQmIa
 p1CQ==
X-Gm-Message-State: AOAM531W11HTSWfBVpJGdy+inS8dXukow5EtfiErFODCz800SBsi0B95
 xBDOHraqIvPLr/crV6xviHh5tG2vv5U=
X-Google-Smtp-Source: ABdhPJwSfJJ7RbfKharN089w0gTvIAVt0LD8xEcpNzqkkq4NWvBjzv2fTEx+ptAOenssgrZBZRt6RQ==
X-Received: by 2002:a17:90a:f317:: with SMTP id
 ca23mr3079035pjb.141.1605087871623; 
 Wed, 11 Nov 2020 01:44:31 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id a3sm2046129pfd.58.2020.11.11.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 01:44:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/19] powerpc: add interrupt_cond_local_irq_enable helper
Date: Wed, 11 Nov 2020 19:43:58 +1000
Message-Id: <20201111094410.3038123-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201111094410.3038123-1-npiggin@gmail.com>
References: <20201111094410.3038123-1-npiggin@gmail.com>
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

Simple helper for synchronous interrupt handlers to use to enable
interrupts if they were taken in interrupt-enabled context.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h |  7 +++++++
 arch/powerpc/kernel/traps.c          | 24 +++++++-----------------
 arch/powerpc/mm/fault.c              |  4 +---
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 3a94153ff0d4..021b7e383c97 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_INTERRUPT_H
 
 #include <linux/context_tracking.h>
+#include <linux/hardirq.h>
 #include <asm/ftrace.h>
 
 struct interrupt_state {
@@ -266,4 +267,10 @@ DECLARE_INTERRUPT_HANDLER_ASYNC(unknown_async_exception);
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
index 3fb5f5dbdb5d..e0d42bb7d73a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -343,8 +343,8 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 
 	show_signal_msg(signr, regs, code, addr);
 
-	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	if (arch_irqs_disabled())
+		interrupt_cond_local_irq_enable(regs);
 
 	current->thread.trap_nr = code;
 
@@ -1575,9 +1575,7 @@ DEFINE_INTERRUPT_HANDLER(program_check_exception)
 	if (!user_mode(regs))
 		goto sigill;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
@@ -1631,9 +1629,7 @@ DEFINE_INTERRUPT_HANDLER(alignment_exception)
 	int sig, code, fixed = 0;
 	unsigned long  reason;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	reason = get_reason(regs);
 
@@ -1794,9 +1790,7 @@ DEFINE_INTERRUPT_HANDLER(facility_unavailable_exception)
 		die("Unexpected facility unavailable exception", regs, SIGABRT);
 	}
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	if (status == FSCR_DSCR_LG) {
 		/*
@@ -2172,9 +2166,7 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	int code = FPE_FLTUNK;
 	int err;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	flush_spe_to_thread(current);
 
@@ -2221,9 +2213,7 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
 	extern int speround_handler(struct pt_regs *regs);
 	int err;
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	preempt_disable();
 	if (regs->msr & MSR_SPE)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d768329a950b..f04d6ef3e358 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -443,9 +443,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area_nosemaphore(regs, address);
 	}
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
+	interrupt_cond_local_irq_enable(regs);
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-- 
2.23.0

