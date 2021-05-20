Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A6BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 11:20:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6D0613AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 11:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6D0613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm6jD5qQKz3brv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 21:20:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=hs45u5zA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hs45u5zA; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm6hg1VGVz2yXy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 21:19:45 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id i5so11660772pgm.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jan3e2V7UdV9x3Y5d3mN0k+AUXkPQgUEbibLS8Yd1d4=;
 b=hs45u5zAJRnhB7jDd+9tnuktZ1eX3cg0LfWKz75YiLc++Z9YxK1fw1zuHH/nauB7rn
 BCzKy909ivHiTy96GikEA88nhQS2xL8DpUl1UrNd41BcUOcF4K5nynKlhybp7uSryA5U
 8ryPQOKD0m+FfQ5dNbcjI3L4peY4Xwv7HJTo3aRmeIkuxWa/vJEFOVzIQIrJCLPAAreJ
 O9dRcGnqkxA3Kvv5umD93dVf12Ls4b72ZVPkZO0d4ex6QlG40XzopPu5VRxsg5nEHpgg
 9XLJ+QhRzSJEskdZ9adc54XkIR3d54cmUAj7SrReSh5l3aY87TmuASOFNeHCN39xnscq
 6o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jan3e2V7UdV9x3Y5d3mN0k+AUXkPQgUEbibLS8Yd1d4=;
 b=C23qik0AnxWx56UMcntJ2p0b5e/yixXwaulfaHlyVfCCRp7t0L6gcnOo5q1gHD541Z
 jWLD8K1YkJCV0HkVt7WIoKeudoZLh04sEN8+3RWilKuociQqiwsJPLaiZZoDNTUAcJFH
 /M/Jc/wXrrCegA3IdBErOTsG6weMVTbGjd7+Q+gPTeWWjcCA8y1B6XSt0Eilcd2Q6opn
 pBSxmzq2YOBSsJJ6gIFpryY9zqG5kz4JNeiRqCtI+9enPFWgvOKHBUBNKHDRgI9IK6j1
 UfWR3qwgUlXKo1yokIsSnLFEycbLV+n9xlnEBs7PCfs0bExsNX6j1LtCNoTgLQqKdhRk
 gOBQ==
X-Gm-Message-State: AOAM533AjrpoVAjM0OQk8h2GWLCDOu99+UaHvy2hEql7A/XfKLJYJeHe
 inSafONzLRuG6WjjH9/5mnz0/tTCe6w=
X-Google-Smtp-Source: ABdhPJyHLNr0umfv3oBdpUWlE4zBgpCKkp1BfVW6VyCG06vG3cI8ZT88yAHnpeX/j9GF+Ez4S89wog==
X-Received: by 2002:a63:5049:: with SMTP id q9mr4183006pgl.123.1621509583193; 
 Thu, 20 May 2021 04:19:43 -0700 (PDT)
Received: from bobo.ibm.com (60-241-27-127.tpgi.com.au. [60.241.27.127])
 by smtp.gmail.com with ESMTPSA id y24sm1856310pfn.81.2021.05.20.04.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 04:19:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/64s/syscall: Fix ptrace syscall info with scv
 syscalls
Date: Thu, 20 May 2021 21:19:31 +1000
Message-Id: <20210520111931.2597127-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210520111931.2597127-1-npiggin@gmail.com>
References: <20210520111931.2597127-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>, "Dmitry V. Levin" <ldv@altlinux.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The scv implementation missed updating syscall return value and error
value get/set functions to deal with the changed register ABI. This
broke ptrace PTRACE_GET_SYSCALL_INFO as well as some kernel auditing
and tracing functions.

Fix. tools/testing/selftests/ptrace/get_syscall_info now passes when
scv is used.

Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
Reported-by: "Dmitry V. Levin" <ldv@altlinux.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h  | 45 +++++++++++++++++-------------
 arch/powerpc/include/asm/syscall.h | 42 +++++++++++++++++-----------
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 9c9ab2746168..b476a685f066 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -19,6 +19,7 @@
 #ifndef _ASM_POWERPC_PTRACE_H
 #define _ASM_POWERPC_PTRACE_H
 
+#include <linux/err.h>
 #include <uapi/asm/ptrace.h>
 #include <asm/asm-const.h>
 
@@ -152,25 +153,6 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 long do_syscall_trace_enter(struct pt_regs *regs);
 void do_syscall_trace_leave(struct pt_regs *regs);
 
-#define kernel_stack_pointer(regs) ((regs)->gpr[1])
-static inline int is_syscall_success(struct pt_regs *regs)
-{
-	return !(regs->ccr & 0x10000000);
-}
-
-static inline long regs_return_value(struct pt_regs *regs)
-{
-	if (is_syscall_success(regs))
-		return regs->gpr[3];
-	else
-		return -regs->gpr[3];
-}
-
-static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
-{
-	regs->gpr[3] = rc;
-}
-
 #ifdef __powerpc64__
 #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
 #else
@@ -235,6 +217,31 @@ static __always_inline void set_trap_norestart(struct pt_regs *regs)
 	regs->trap |= 0x1;
 }
 
+#define kernel_stack_pointer(regs) ((regs)->gpr[1])
+static inline int is_syscall_success(struct pt_regs *regs)
+{
+	if (trap_is_scv(regs))
+		return !IS_ERR_VALUE((unsigned long)regs->gpr[3]);
+	else
+		return !(regs->ccr & 0x10000000);
+}
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	if (trap_is_scv(regs))
+		return regs->gpr[3];
+
+	if (is_syscall_success(regs))
+		return regs->gpr[3];
+	else
+		return -regs->gpr[3];
+}
+
+static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+{
+	regs->gpr[3] = rc;
+}
+
 #define arch_has_single_step()	(1)
 #define arch_has_block_step()	(true)
 #define ARCH_HAS_USER_SINGLE_STEP_REPORT
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index fd1b518eed17..ba0f88f3a30d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -41,11 +41,17 @@ static inline void syscall_rollback(struct task_struct *task,
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	/*
-	 * If the system call failed,
-	 * regs->gpr[3] contains a positive ERRORCODE.
-	 */
-	return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
+	if (trap_is_scv(regs)) {
+		unsigned long error = regs->gpr[3];
+
+		return IS_ERR_VALUE(error) ? error : 0;
+	} else {
+		/*
+		 * If the system call failed,
+		 * regs->gpr[3] contains a positive ERRORCODE.
+		 */
+		return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
+	}
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
@@ -58,18 +64,22 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	/*
-	 * In the general case it's not obvious that we must deal with CCR
-	 * here, as the syscall exit path will also do that for us. However
-	 * there are some places, eg. the signal code, which check ccr to
-	 * decide if the value in r3 is actually an error.
-	 */
-	if (error) {
-		regs->ccr |= 0x10000000L;
-		regs->gpr[3] = error;
+	if (trap_is_scv(regs)) {
+		regs->gpr[3] = (long) error ?: val;
 	} else {
-		regs->ccr &= ~0x10000000L;
-		regs->gpr[3] = val;
+		/*
+		 * In the general case it's not obvious that we must deal with
+		 * CCR here, as the syscall exit path will also do that for us.
+		 * However there are some places, eg. the signal code, which
+		 * check ccr to decide if the value in r3 is actually an error.
+		 */
+		if (error) {
+			regs->ccr |= 0x10000000L;
+			regs->gpr[3] = error;
+		} else {
+			regs->ccr &= ~0x10000000L;
+			regs->gpr[3] = val;
+		}
 	}
 }
 
-- 
2.23.0

