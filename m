Return-Path: <SRS0=bT9L=FC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD97C64E7A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 14:53:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C677124689
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9XcYXM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C677124689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjvdY032VzDrNM
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 01:53:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=M9XcYXM6; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjvMQ3s57zDsGv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2020 01:41:38 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id x4so2319668pln.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EEx+v78bxX7ip5MB5LrvbtkDrNTgl+f+WgHGvGOpR74=;
 b=M9XcYXM6EO/T8EwgIstlxU/1qztA+Z3Ssmt8X8QubngOgDpm+MFSiHc1b08Zo8gEDx
 CxdHRq5bAIm7kfXX29AnfHezFdBlguvixM1y5C8+MUu3fdtwfzBesZ3428PTs1Tu6yuZ
 PtODcNEi9X50EapkcCp8kOkwhhMIW5rRV9B9ru4sVojqLj0gRkjbNsHxXExrWvGBzk/l
 1nCC6ukWpWdSBnEozvPYvT1F87XZherfyTTu8toXHfxd1edyP1nv8Fq+AVnw9miMiOEP
 w71Be1S/rl0iFA5BaYpVBQKdoEvwhw9kvBvxC0h5XUgNOudUGv331VV+xNm8ZebYCGWc
 T03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EEx+v78bxX7ip5MB5LrvbtkDrNTgl+f+WgHGvGOpR74=;
 b=hPVWSZfJrwpKRbltmFJ4F9yYPgDNj3dQNVf+SgHZhwqaHz/mftRHsm68g0D9DAW4D/
 LEUnyLKb51+O5mIJHQ7aaiMr6cx33vqdJGaxkkG9RnqfwSaaX+QyHu03CKRq8jS9A+4Z
 pQbrq+nsc6BMduktWCCWpMaX2GjvKBbdvwD26AkUGMSxc0vQEA6KKBB4tYESSuCQrClG
 J6QUILtDyDfUEyQkihEmylKXsDVkHJyC8hlqn1vvBWeowxJf+gfaB3kicNV5xaPyNvH/
 9g4IKvT9Hpb6WPIak7VN+aML4o0d2wd1JKvJFoRnB9xI+mbmNQJr5GMAcb6vPudNApqB
 92yg==
X-Gm-Message-State: AOAM530yTLd+1PfhBTI0lP/WkqSE7NobSwkBsqFcTFaHckYOTHMSUgGM
 1uk1N326gLi+2s+UzhTo1uHVI0+VH/Q=
X-Google-Smtp-Source: ABdhPJyhA6MF90WvFaFjAZ0mF6+E1JP81JWAk0divIYkioK1SXMeIRXiD0+Hu/zzgLu6XF4ZLkRrCQ==
X-Received: by 2002:a17:902:854a:b029:da:113b:2d3f with SMTP id
 d10-20020a170902854ab02900da113b2d3fmr11622502plo.49.1606574495502; 
 Sat, 28 Nov 2020 06:41:35 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-103-132.tpgi.com.au.
 [193.116.103.132])
 by smtp.gmail.com with ESMTPSA id y201sm10750764pfb.2.2020.11.28.06.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2020 06:41:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 06/19] powerpc: add interrupt wrapper entry / exit stub
 functions
Date: Sun, 29 Nov 2020 00:41:01 +1000
Message-Id: <20201128144114.944000-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128144114.944000-1-npiggin@gmail.com>
References: <20201128144114.944000-1-npiggin@gmail.com>
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

These will be used by subsequent patches.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 66 ++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 5f6eeb6d43f2..516b32f5b3cc 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -5,6 +5,50 @@
 #include <linux/context_tracking.h>
 #include <asm/ftrace.h>
 
+struct interrupt_state {
+};
+
+static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
+{
+}
+
+/*
+ * Care should be taken to note that interrupt_exit_prepare and
+ * interrupt_async_exit_prepare do not necessarily return immediately to
+ * regs context (e.g., if regs is usermode, we don't necessarily return to
+ * user mode). Other interrupts might be taken between here and return,
+ * context switch / preemption may occur in the exit path after this, or a
+ * signal may be delivered, etc.
+ *
+ * The real interrupt exit code is platform specific, e.g.,
+ * interrupt_exit_user_prepare / interrupt_exit_kernel_prepare for 64s.
+ *
+ * However interrupt_nmi_exit_prepare does return directly to regs, because
+ * NMIs do not do "exit work" or replay soft-masked interrupts.
+ */
+static inline void interrupt_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
+{
+}
+
+static inline void interrupt_async_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
+{
+}
+
+static inline void interrupt_async_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
+{
+}
+
+struct interrupt_nmi_state {
+};
+
+static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct interrupt_nmi_state *state)
+{
+}
+
+static inline void interrupt_nmi_exit_prepare(struct pt_regs *regs, struct interrupt_nmi_state *state)
+{
+}
+
 /**
  * DECLARE_INTERRUPT_HANDLER_RAW - Declare raw interrupt handler function
  * @func:	Function name of the entry point
@@ -59,7 +103,13 @@ static __always_inline void ___##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
+	struct interrupt_state state;					\
+									\
+	interrupt_enter_prepare(regs, &state);				\
+									\
 	___##func (regs);						\
+									\
+	interrupt_exit_prepare(regs, &state);				\
 }									\
 									\
 static __always_inline void ___##func(struct pt_regs *regs)
@@ -87,10 +137,15 @@ static __always_inline long ___##func(struct pt_regs *regs);		\
 									\
 __visible noinstr long func(struct pt_regs *regs)			\
 {									\
+	struct interrupt_state state;					\
 	long ret;							\
 									\
+	interrupt_enter_prepare(regs, &state);				\
+									\
 	ret = ___##func (regs);						\
 									\
+	interrupt_exit_prepare(regs, &state);				\
+									\
 	return ret;							\
 }									\
 									\
@@ -117,7 +172,13 @@ static __always_inline void ___##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
+	struct interrupt_state state;					\
+									\
+	interrupt_async_enter_prepare(regs, &state);			\
+									\
 	___##func (regs);						\
+									\
+	interrupt_async_exit_prepare(regs, &state);			\
 }									\
 									\
 static __always_inline void ___##func(struct pt_regs *regs)
@@ -145,10 +206,15 @@ static __always_inline long ___##func(struct pt_regs *regs);		\
 									\
 __visible noinstr long func(struct pt_regs *regs)			\
 {									\
+	struct interrupt_nmi_state state;				\
 	long ret;							\
 									\
+	interrupt_nmi_enter_prepare(regs, &state);			\
+									\
 	ret = ___##func (regs);						\
 									\
+	interrupt_nmi_exit_prepare(regs, &state);			\
+									\
 	return ret;							\
 }									\
 									\
-- 
2.23.0

