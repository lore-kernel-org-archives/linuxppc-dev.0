Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C64C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 10:47:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34E064FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34E064FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F093g1cf5z3dlg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 21:47:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=c3b1VyyX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f;
 helo=mail-pg1-x52f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=c3b1VyyX; dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F08yR4162z30B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 21:43:11 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id w34so21259176pga.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I3Ah3oz2aTxULj+x6daaGEf0aY8vZIOZAoSytA9Ic10=;
 b=c3b1VyyXVkBINe+Ia97aIR3w5IQztyH/VWwiVEWVoU4Cr7AU8y9r7xlrk3HNoNp+qB
 jBlsCoD0sdcZ4EOHieP1Lgd/BTvxqifGL4qKB6ZAa2b9dWRRSefWk+A6cZ4LBOOPypmM
 NJcYmnvUTJ3nUgmtTU9RNIFAOqX9yFtlwrrAkgzogWqsm/8SbFz30RcAMZm4soIVPTK4
 Yyt5Jpn91n2USZULnvQq6nzGyNVl0kfCVPnUIhmuDPkb9DXsWYWP4KOiCHSuGqlIXtJf
 bbLm1kpJHqzA0QM+QIKFF19GGp6fc8prRtu/UZv5yL9OMr8YOgNWYDcsPwAYGx0LFtXc
 z97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I3Ah3oz2aTxULj+x6daaGEf0aY8vZIOZAoSytA9Ic10=;
 b=Nn+vwUy0miyOb5bhcrxutnmHgPBkqKQLtdg/lFY0EEwFyBP9SKjNTsQ1EMjopBgnnB
 3wp/ulDji8cFXghx6oSolkSOnIOMe8iR8dB7wztnN/0StVND7zXCZZzMFPD5kLLg+uT2
 iXzYeGDI32lvBrzUFvFH49fuqVBYQF6yf0r3H5ASf45ydheucmd5NIabxP3UT8OoVrug
 fyNnqx5/6hjtj22o/U9iDTja2j0jDYe6zfhag4duX4fNezjuifzFGw0x5u2TGQZnFGig
 r9nrV1Ty5/xnF2ZY89qpNmlCtvuWBK6F/TWvup5KV6RI6gTxrvWegzNqc76vxNPsJp5Z
 AVxg==
X-Gm-Message-State: AOAM532RY9fHtUtc/FD1MiRNOnRwuQ7x4ArDUFU7dFCNGYT0u4fSmawb
 wZUfwIE4g/Sv8kZ0ApixlFlU6zHCxCs=
X-Google-Smtp-Source: ABdhPJxnjm7RvVE5xCtJkDMOko/Clyq73CSvuADUkTLDV831HslwPqkAqLDp6Y1I1dkAW+ktyy8C1A==
X-Received: by 2002:a63:c4c:: with SMTP id 12mr3510658pgm.320.1615891389329;
 Tue, 16 Mar 2021 03:43:09 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id
 r30sm15828489pgu.86.2021.03.16.03.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 03:43:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/11] powerpc: move norestart trap flag to bit 0
Date: Tue, 16 Mar 2021 20:42:05 +1000
Message-Id: <20210316104206.407354-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210316104206.407354-1-npiggin@gmail.com>
References: <20210316104206.407354-1-npiggin@gmail.com>
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

Compact the trap flags down to use the low 4 bits of regs.trap.

A few 64e interrupt trap numbers set bit 4. Although they tended to be
trivial so it wasn't a real problem[1], it is not the right thing to do,
and confusing.

[*] E.g., 0x310 hypercall goes to unknown_exception, which prints
    regs->trap directly so 0x310 will appear fine, and only the syscall
    interrupt will test norestart, so it won't be confused by 0x310.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 91194fdd5d01..1e34791b9f80 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -185,20 +185,25 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 #define current_pt_regs() \
 	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
 
+/*
+ * The 4 low bits (0xf) are available as flags to overload the trap word,
+ * because interrupt vectors have minimum alignment of 0x10. TRAP_FLAGS_MASK
+ * must cover the bits used as flags, including bit 0 which is used as the
+ * "norestart" bit.
+ */
 #ifdef __powerpc64__
-#define TRAP_FLAGS_MASK		0x10
-#define TRAP(regs)		((regs)->trap & ~TRAP_FLAGS_MASK)
+#define TRAP_FLAGS_MASK		0x1
 #else
 /*
  * On 4xx we use bit 1 in the trap word to indicate whether the exception
  * is a critical exception (1 means it is).
  */
-#define TRAP_FLAGS_MASK		0x1E
-#define TRAP(regs)		((regs)->trap & ~TRAP_FLAGS_MASK)
+#define TRAP_FLAGS_MASK		0xf
 #define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) != 0)
 #define IS_MCHECK_EXC(regs)	(((regs)->trap & 4) != 0)
 #define IS_DEBUG_EXC(regs)	(((regs)->trap & 8) != 0)
 #endif /* __powerpc64__ */
+#define TRAP(regs)		((regs)->trap & ~TRAP_FLAGS_MASK)
 
 static inline void set_trap(struct pt_regs *regs, unsigned long val)
 {
@@ -222,12 +227,12 @@ static inline bool trap_is_syscall(struct pt_regs *regs)
 
 static inline bool trap_norestart(struct pt_regs *regs)
 {
-	return regs->trap & 0x10;
+	return regs->trap & 0x1;
 }
 
 static inline void set_trap_norestart(struct pt_regs *regs)
 {
-	regs->trap |= 0x10;
+	regs->trap |= 0x1;
 }
 
 #define arch_has_single_step()	(1)
-- 
2.23.0

