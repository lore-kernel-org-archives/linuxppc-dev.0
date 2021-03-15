Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A8DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:20:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507C564E2E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507C564E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzMBD085Cz3dDZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 14:20:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Wmp0OMVB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Wmp0OMVB; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzM6y0Ngbz3cQL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 14:17:45 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id q5so6980981pgk.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 20:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8ZV+oQn+wr9kHUXjXwTVWlziOrFwS6+PqNBUa0e3h90=;
 b=Wmp0OMVBKM6V8IfJ+ZdlsUg97FDrxR/hWy+EuRKuc4ICrAGxZKFZ6v0sg1M3fXxZRY
 IDAkZoF3eRHwcCZUFjokC0DcD9dVLklPJOpeRWpPQKRNtHchFXvqQYlL+awHL2yenNuy
 D/vBWmsvfvW7obEPqSE+bs6qZx9w2C7xkWwvEbG1BYMZ0J0RopzqfbSn0iF7RUYx52l4
 qsVM9BvcrPJzLvi73/K64qntGHDJHk53wzuZKHlo3DJWrz2dg3jBhKeUZTsYcSimVtdY
 lHDdwg2qeDte0fat6O0M/P/LpR9QTADzfw4tUuxUDsAjS9YuXXkYDAtaRxKosMjJSjiw
 /meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ZV+oQn+wr9kHUXjXwTVWlziOrFwS6+PqNBUa0e3h90=;
 b=glzFUKYdAzJaO+bSOZXmNTdW5b5HixMKjhAEIZzkX543fmVGx4OyLjb1hZ9evtDBhX
 uKWqGgViBLB3z4CPsEaGof5EJaSFnJz/j3NaT7FpylE+bB3IksT6HBv9bol/rrZjK4r0
 /9/QQMx9QPXKWbKWFdUsXPwNPfCuTJRxYaovDLqR1J+q62N1OVSC/uji0IeG26rJ5O3z
 y0mkuRoOzaBzeqGeptohVd54m7FXIviCLD60uVQyz2c8n2c2+5iiMtRL7OacWMsZN+tr
 QaAJ5sxNp0jW6T9G+lvov3U9MxfGKpaoztax5EtICVTyoKaWv6N2CPFJzjPrErHDXOp8
 qvhg==
X-Gm-Message-State: AOAM533vLIQZHaVMgBoZdToPXc0ywcRgNsykLB3+Q+h2rbrv5rUHmjAM
 b5WvhiDTNK1w6Gk3nnch2No/nElHqNw=
X-Google-Smtp-Source: ABdhPJzatzdomwnXLIHN3ARC5yRn929F+/ET91Bv/pHJarVg5WKSYdrL0GLiRvqy/rQKk+436BiTMg==
X-Received: by 2002:a63:1d0b:: with SMTP id d11mr21277816pgd.190.1615778263456; 
 Sun, 14 Mar 2021 20:17:43 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id
 j22sm8517740pjz.3.2021.03.14.20.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 20:17:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/10] powerpc/64e/interrupt: Use new interrupt context
 tracking scheme
Date: Mon, 15 Mar 2021 13:17:12 +1000
Message-Id: <20210315031716.3940350-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210315031716.3940350-1-npiggin@gmail.com>
References: <20210315031716.3940350-1-npiggin@gmail.com>
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
Cc: Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With the new interrupt exit code, context tracking can be managed
more precisely, so remove the last of the 64e workarounds and switch
to the new context tracking code already used by 64s.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 28 ----------------------------
 arch/powerpc/kernel/interrupt.c      | 12 ------------
 2 files changed, 40 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 29b48d083156..94fd8e1ff52c 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -10,9 +10,6 @@
 #include <asm/runlatch.h>
 
 struct interrupt_state {
-#ifdef CONFIG_PPC_BOOK3E_64
-	enum ctx_state ctx_state;
-#endif
 };
 
 static inline void booke_restore_dbcr0(void)
@@ -45,9 +42,7 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	if (irq_soft_mask_set_return(IRQS_ALL_DISABLED) == IRQS_ENABLED)
 		trace_hardirqs_off();
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
-#endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
 	if (user_mode(regs)) {
 		CT_WARN_ON(ct_state() != CONTEXT_USER);
 		user_exit_irqoff();
@@ -64,12 +59,6 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	}
 #endif
 
-#ifdef CONFIG_PPC_BOOK3E_64
-	state->ctx_state = exception_enter();
-	if (user_mode(regs))
-		account_cpu_user_entry();
-#endif
-
 	booke_restore_dbcr0();
 }
 
@@ -89,25 +78,8 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
  */
 static inline void interrupt_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
 {
-#ifdef CONFIG_PPC_BOOK3E_64
-	exception_exit(state->ctx_state);
-#endif
-
 	if (user_mode(regs))
 		kuep_unlock();
-	/*
-	 * Book3S exits to user via interrupt_exit_user_prepare(), which does
-	 * context tracking, which is a cleaner way to handle PREEMPT=y
-	 * and avoid context entry/exit in e.g., preempt_schedule_irq()),
-	 * which is likely to be where the core code wants to end up.
-	 *
-	 * The above comment explains why we can't do the
-	 *
-	 *     if (user_mode(regs))
-	 *         user_exit_irqoff();
-	 *
-	 * sequence here.
-	 */
 }
 
 static inline void interrupt_async_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index ae7b058b2970..2a017d98973a 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -235,10 +235,6 @@ static notrace void booke_load_dbcr0(void)
 #endif
 }
 
-/* temporary hack for context tracking, removed in later patch */
-#include <linux/sched/debug.h>
-asmlinkage __visible void __sched schedule_user(void);
-
 /*
  * This should be called after a syscall returns, with r3 the return value
  * from the syscall. If this function returns non-zero, the system call
@@ -296,11 +292,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
 		if (ti_flags & _TIF_NEED_RESCHED) {
-#ifdef CONFIG_PPC_BOOK3E_64
-			schedule_user();
-#else
 			schedule();
-#endif
 		} else {
 			/*
 			 * SIGPENDING must restore signal handler function
@@ -396,11 +388,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable(); /* returning to user: may enable */
 		if (ti_flags & _TIF_NEED_RESCHED) {
-#ifdef CONFIG_PPC_BOOK3E_64
-			schedule_user();
-#else
 			schedule();
-#endif
 		} else {
 			if (ti_flags & _TIF_SIGPENDING)
 				ret |= _TIF_RESTOREALL;
-- 
2.23.0

