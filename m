Return-Path: <linuxppc-dev+bounces-24747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4F2C531CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 19:48:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5hWH1Rzdz2ygm;
	Fri, 24 Jul 2026 05:48:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784836107;
	cv=none; b=PNWDNzpFxmuH1X6Bj8WDVxwj/FKUJyWTRp103MY8qtngYfoUnQbi8/ycDf2XxdHaBDENs4HTSyyo7Je5QOpaln3G6DhM5iIZCJ0YNqUG9VQEZ5wc3isYHraV7cuDEWuLjzH4Ms1+GxC+ORMDtuaiAFJnsfp/yN/pDH2mBN4ecrY8X04/4LP3F0zz8MklOoD1G3aqPp4s1CJRHiY661WsgnVrY+zovbQ2Zq34BCTlQbtByuF6POk8B/KLB0riZiPRf9lqg9mKg0HIwj3zQVtiJftv8cSHujpyM/nmrppw6F3PukOCQBvDi4o+unOHmKLbcArplHwPU46lmCEAN4mqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784836107; c=relaxed/relaxed;
	bh=82blV+dT5OnUWyd6TkFWGn1GRoH4qwiyQgL3yxF/4aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PO0Tp30YmObple8ttedrzwukDFIRVilNfNQ2WvGwgrootr9vD9G23iic1MKAcoGDDTSDgkgkBzcqEokJszXi5esFUEacQa1HScXtzncaKhan2JfQhPrMBsvXa8xMdmp/4hBh2ywiax/gmjEdiWiz9oy1+QhgxqNucRQqSSTEahQJtHeNa0sULXnwpMPnBf7tT5tIaHn8CmiN8uHl3TszB5zx2whR+uNEhSQeCRrNwWMmHJYBQhyhUmtDJW3Fbpno8FJYRVPriUH52NfLUzFEwORJiSPctz8m8rYr6QuKl3stcFUt5pwxeSU9UVj6JdramBsr7W/YcOUTbsWHA7rAOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s8wa3JsY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s8wa3JsY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5hWF36gnz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 05:48:24 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1073906b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836101; x=1785440901; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=82blV+dT5OnUWyd6TkFWGn1GRoH4qwiyQgL3yxF/4aM=;
        b=s8wa3JsYmdHmAE5dh7lOtVtPKCWSdmmjhTak6c1yH9lRdIjnGCQSRbkXXDtAoVtZ21
         S6LJ4bb1Xe7+MND2qXl1U6BaSVk15zfYObUKt1/XUbSCv4J8hppBvnMZM3u/w5LJspDb
         YKDezQGlmNyPTNV7cyOg3UbpUaOjIuWrGxsxgRTF9YxilnqrN8ctrd698q1kCskHGsh1
         36F0EGXrceNOUDTgBEFOtoTGXnh/p+FJCNo4pX5DVTY8MZN7kvZ55xxWfS5EL9FYVy77
         XYkKF3HgoxzJKj92Bf0+3REGDz1kBmu70prrtFDw62olBMWS5FNnW5GsDtrXMdscuHBx
         XrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836101; x=1785440901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82blV+dT5OnUWyd6TkFWGn1GRoH4qwiyQgL3yxF/4aM=;
        b=D5Rzi/jddSRLosagRGc/EERiGkW9t9jxgH00HprfHSwDMism76UPeG7yjsdTp6MonI
         advXj8VJSctIm7OlI4HEmg0H4XZeLLr6d82kBKvoszKgjhpmuESuxoSDJBN+JLj9TGnJ
         3KoBkwrug+B9CnxQOQaaqTHYXlHcxiuASNH6v8eTbmZMIQeDfQLx6ECxkXJONqPfdIUR
         a1n+d/hphMdoihFyfRHBuQYMlsjDwEY5otcyHqn5u8gwAFJOhJv12n5ymmV0ieqb2Bor
         9m1sxa64H+bJXivTAKzPxv+996YnPS2fKHq1cSe/x0Fm3sxnWG0enypwSll89whTxc4E
         jw1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKC+GdN7aAdfK+I3E+ZqKAjCv+980fqMZG971hxiej/VR2KsWDJIhXRu57sZtt4V5wW9bIcBMkQUwhK7c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3/JUO2HPU8HcUvLF50EU+MLwdlJzesCND3MuqhRAubiqXjtsG
	+eameWBg0vE1fzV4GL5QR7k0d8AD/K5TWQO/hyNQv5FM1Ju6RBG2DysL
X-Gm-Gg: AR+sD10bMTMu5ffmAH2sddDyW+wfzdc8QPuTScbFbJoIiX9x3NBfuQKpaNQjQ2tCHzz
	col/Zs9irqWB1MPtvH1XR34iLo4llGdP30KnemS0W8wxzvw4aI4wza7/KLONEvFL0jc6e+fK7Kr
	D2UZ4r0gM2ECJEwkMaLNsNd59p5tqG6064sLzNrNM6N0GfmYKxw/SgsT5zNh6j+xWiuyxVIOa8k
	WYIWRW+QxGJGGns7cAK4W8jmjzKZG9PyNdp5MO2RL60zfhOrXX/o7Kp08hnZelOJ1BXyH51AaOM
	V9YPOtq8+0wQd9XNZblaMIw1w3kmX24MYQb+bGXVJCaArxd3SRTRRJXGMqD4B2XB1XoVI4VoKnv
	MsfQS8ScyKf7hgFB6stE23f3m0QaRosonF4FJBBxD8iT+TIuBUgIy9c68n98bFqBFmA115wOPBA
	QTL9d6nWH+eI2rNnyqSLJNZ0J0rQQJgFZgGotIFntp5R8r/buvi3xVAA==
X-Received: by 2002:a05:6a21:689:b0:3c3:b57b:6455 with SMTP id adf61e73a8af0-3c44b18dd50mr4639060637.49.1784836101152;
        Thu, 23 Jul 2026 12:48:21 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm12047139eec.8.2026.07.23.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:20 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: oleg@redhat.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	yeoreum.yun@arm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	agordeev@linux.ibm.com,
	mchauras@linux.ibm.com,
	mkchauras@gmail.com,
	segher@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: "Dmitry V. Levin" <ldv@strace.io>
Subject: [PATCH] powerpc: Fix exit_flags field placement in pt_regs for ptrace
Date: Fri, 24 Jul 2026 01:18:09 +0530
Message-ID: <20260723194809.4046600-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d7a6797e0bc1 ("powerpc: add exit_flags field in pt_regs") added
the exit_flags field to struct pt_regs to pass internal exit control
flags (e.g. _TIF_RESTOREALL) from syscall_exit_prepare() to the
low-level assembly exit path.

However, the field was placed in a way that was visible to userspace
tools such as strace via PTRACE_GETREGS, or caused a struct layout or
size regression observable through ptrace. The field is purely
kernel-internal and must not be exposed beyond the user_pt_regs
boundary.

Move exit_flags into struct thread_info where it is only accessible to
the kernel, and keep it out of the ptrace-visible register window
entirely.

Fixes: d7a6797e0bc1 ("powerpc: add exit_flags field in pt_regs")
Reported-by: "Dmitry V. Levin" <ldv@strace.io>
Closes: https://lore.kernel.org/all/20260722070155.GA11808@strace.io/
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h      |  3 ---
 arch/powerpc/include/asm/thread_info.h |  1 +
 arch/powerpc/include/uapi/asm/ptrace.h | 14 ++++-------
 arch/powerpc/kernel/interrupt.c        | 32 +++++++++++++++-----------
 arch/powerpc/kernel/ptrace/ptrace.c    |  1 -
 arch/powerpc/kernel/signal.c           |  2 +-
 6 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index fdeb97421785..d53c4dd4d8b6 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -53,9 +53,6 @@ struct pt_regs
 				unsigned long esr;
 			};
 			unsigned long result;
-			unsigned long exit_flags;
-			/* Maintain 16 byte interrupt stack alignment */
-			unsigned long __pt_regs_pad[3];
 		};
 	};
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ee3b9adb5b67..0487e94d3416 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -57,6 +57,7 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
+	unsigned long	exit_flags;		/* Exit Flags for entry/exit */
 	unsigned long	syscall_work;		/* SYSCALL_WORK_ flags */
 	unsigned long	local_flags;		/* private flags for thread */
 #ifdef CONFIG_LIVEPATCH_64
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index a393b7f2760a..01e630149d48 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -55,8 +55,6 @@ struct pt_regs
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
-	unsigned long exit_flags;	/* System call exit flags */
-	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
 };
 
 #endif /* __ASSEMBLER__ */
@@ -116,12 +114,10 @@ struct pt_regs
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
-#define PT_EXIT_FLAGS 44
-#define PT_PAD 47 /* 3 times */
-#define PT_DSCR 48
-#define PT_REGS_COUNT 48
+#define PT_DSCR 44
+#define PT_REGS_COUNT 44
 
-#define PT_FPR0	(PT_REGS_COUNT + 4)	/* each FP reg occupies 2 slots in this space */
+#define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
 
 #ifndef __powerpc64__
 
@@ -133,7 +129,7 @@ struct pt_regs
 #define PT_FPSCR (PT_FPR0 + 32)	/* each FP reg occupies 1 slot in 64-bit space */
 
 
-#define PT_VR0	(PT_FPSCR + 2)	/* <82> each Vector reg occupies 2 slots in 64-bit */
+#define PT_VR0 82	/* each Vector reg occupies 2 slots in 64-bit */
 #define PT_VSCR (PT_VR0 + 32*2 + 1)
 #define PT_VRSAVE (PT_VR0 + 33*2)
 
@@ -141,7 +137,7 @@ struct pt_regs
 /*
  * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
  */
-#define PT_VSR0	(PT_VRSAVE + 2)	/* each VSR reg occupies 2 slots in 64-bit */
+#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
 #define PT_VSR31 (PT_VSR0 + 2*31)
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index f04978080837..5b88bf72786c 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -89,15 +89,17 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 					   long scv)
 {
 	unsigned long ti_flags;
+	unsigned long ret = 0;
 	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
 
 	kuap_assert_locked();
 
 	regs->result = r3;
-	regs->exit_flags = 0;
 
-	ti_flags = read_thread_flags();
+	/* Clear exit_flags so only flags set during this exit are visible */
+	current->thread_info.exit_flags = 0;
 
+	ti_flags = read_thread_flags();
 	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
 		if (likely(!(ti_flags & (_TIF_NOERROR | _TIF_RESTOREALL)))) {
 			r3 = -r3;
@@ -107,7 +109,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	if (unlikely(ti_flags & _TIF_PERSYSCALL_MASK)) {
 		if (ti_flags & _TIF_RESTOREALL)
-			regs->exit_flags = _TIF_RESTOREALL;
+			ret = _TIF_RESTOREALL;
 		else
 			regs->gpr[3] = r3;
 		clear_bits(_TIF_PERSYSCALL_MASK, &current_thread_info()->flags);
@@ -116,7 +118,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	}
 
 	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
-		regs->exit_flags |= _TIF_RESTOREALL;
+		ret |= _TIF_RESTOREALL;
 	}
 
 	syscall_exit_to_user_mode(regs);
@@ -132,17 +134,19 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-
+	ret |= current->thread_info.exit_flags;
 #ifdef CONFIG_PPC64
-	regs->exit_result = regs->exit_flags;
+	regs->exit_result = ret;
 #endif
 
-	return regs->exit_flags;
+	return ret;
 }
 
 #ifdef CONFIG_PPC64
 notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *regs)
 {
+	unsigned long ret;
+
 	/*
 	 * This is called when detecting a soft-pending interrupt as well as
 	 * an alternate-return interrupt. So we can't just have the alternate
@@ -167,9 +171,11 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 	}
 
 	kuap_user_restore(regs);
-	regs->exit_result |= regs->exit_flags;
+	ret = current_thread_info()->exit_flags & _TIF_RESTOREALL;
+	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
+	regs->exit_result |= ret;
 
-	return regs->exit_result;
+	return ret;
 }
 #endif
 
@@ -186,8 +192,10 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 	 */
 	kuap_assert_locked();
 
+	/* Clear exit_flags so only flags set during this exit are visible */
+	current_thread_info()->exit_flags = 0;
+
 	local_irq_disable();
-	regs->exit_flags = 0;
 again:
 	check_return_regs_valid(regs);
 	user_enter_irqoff();
@@ -200,9 +208,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-
-	ret = regs->exit_flags;
-
+	ret = current_thread_info()->exit_flags & _TIF_RESTOREALL;
 #ifdef CONFIG_PPC64
 	regs->exit_result = ret;
 #endif
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 316d4f5ead8e..6cd180bc36ab 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -291,7 +291,6 @@ void __init pt_regs_check(void)
 	CHECK_REG(PT_DAR, dar);
 	CHECK_REG(PT_DSISR, dsisr);
 	CHECK_REG(PT_RESULT, result);
-	CHECK_REG(PT_EXIT_FLAGS, exit_flags);
 	#undef CHECK_REG
 
 	BUILD_BUG_ON(PT_REGS_COUNT != sizeof(struct user_pt_regs) / sizeof(unsigned long));
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index bb42a8b6c642..cc6498501610 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -356,6 +356,6 @@ void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
 void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	BUG_ON(regs != current->thread.regs);
-	regs->exit_flags |= _TIF_RESTOREALL;
+	current_thread_info()->exit_flags |= _TIF_RESTOREALL;
 	do_signal(current);
 }
-- 
2.55.0


