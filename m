Return-Path: <linuxppc-dev+bounces-23466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FB5C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs6036R19z2yDs;
	Fri, 03 Jul 2026 18:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783066275;
	cv=none; b=UvJTjGY+d73roteurTgZrk2DO9GFd52GV+Yx4AdZvk+l2aXCqAmpt1oIP0dExyym729EQACS1njzstP4OGq1cKoTsjoCyfLSmaVPBRCyXuJOxtYxGu1lR06XMRZ3bZiaGyTzXJHThGa045RV8Ys3PONOZbof03tq3PZsyqsNZmBfPDskSU2drhXwlJniZnWikP4rr/0BMw4tzLqEe6QdGg0Sp5guXbnMEk9sePwp8xmUFsHshcsCHrTW3kAzXeoAnktXM+0Dg75vPPzuyFZE4Hla3YEI9wQHK1FnWHL7kuyHWXDnRvalMSXqDogfWri++L32hy2KdgAZYzkDvlP2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783066275; c=relaxed/relaxed;
	bh=XonqW6TTEmhnxGieIs2nXvN/Lqh826qWlC2WpFQO6i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCa1Aq98yrn384smWhe2Aox4eBefvNSyX5QIgSpeDD/bwR9EKGI+P/6knD4EILUOfvtkMRfCc1YTb/ulPyNWgyDhF/vEuQ/3YDoML128TAdahe+8lf0R4l17ja57JAM3yFZZ25jjxeEedUKg8v7HO+sVlqrZCUyYO+Q+Baq6sC1y95rF6kzwM0FZi0wfy4di5rKqf5zFePbmCKMxEj6QS8IRZ+oMj3RW2/8laZk8/h0IZ0c2is6farpSQ+GaqjwQUI7Sqv5QmpUMbQ2UBfS/cfJMMj2B18GrK61+KnMyuCns3+RY3HVQ0/a1mlRk3Ro3A7iTLWyLFbeqUHaNpdriuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BxSqEsrX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BxSqEsrX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs6025vg3z2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 18:11:13 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c88cc025f54so215772a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783066272; x=1783671072; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XonqW6TTEmhnxGieIs2nXvN/Lqh826qWlC2WpFQO6i8=;
        b=BxSqEsrXSWQxedpPCuClPcdhKSFbmR12kep8BvGoW8CVx/l+SHCkIPTe3xX0cOi3GB
         n2Qf5j7L5D2+KDFIekcGT/+Eq35v/GKQ1ftctioz5bAljwCXeemaQTKC9L6l/xE0VXR9
         pxmqsuitdawSQL+chKwMpaSGAbzt1s/M/tXr1ivZ/QW3/BnHySyFFeRd9xzGKQ80ZBd3
         TViw3EncC5oorpknZBRv+fwV4/ygmzDg3eaZeqxaz3Fsmtqetd8Jx8OqvFIa7VjiRJwY
         tEpr7DtkUmkNbrP6jqZXb9uX+Y6/JXOMjfXjBrPlu3c7/+4AK+uu4N+pzyd8Ji0FZRET
         j/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066272; x=1783671072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XonqW6TTEmhnxGieIs2nXvN/Lqh826qWlC2WpFQO6i8=;
        b=Xs9u+V0TTSuCb98x2tnsqgHNPsqOWtCDBR1IhkUYSTqIPvJNAGmrfxd20A7xpCXRpS
         x5h2ndzxAbpKGKMr/mqiXrPBYLHDhwR4v/voDz+hc+AFBRMgOqKSwzXOKnghh+u8M9bJ
         Z9D5FaaqlvggDZaERFmDBmoxAvxXg196hRXrV6QAWeUYCS9Do41Ux0TtePt/FjdtdBRr
         RvxNbmzXkKi15adsBHAUXr/AsTx3JktrTZr0dq4Mc7ed2oy1X2Cbaiw/X/OsTHxTktx7
         p/AEBY46g4CnHw4ZpSeGA/XlVtAKyaIrCOKgKXMe2ctZT32gJIRfMEJgh2zr7oRgQ7T1
         N8ew==
X-Forwarded-Encrypted: i=1; AFNElJ/B+xfPyEMaGmhuFnP0i7tpK8qPy86cmIZpPmbblk83R4s8kPvoVm+Sb6dj12q2SQB0OzLnk2hazQ1jqYw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/Zk2TEP0LtgnGtrBqxqDJ0X1ZZ6IYyDwyFCm8kifsM2RopKMt
	1khoL7+J/x8HPIj/nzh/PBf+fU1Dc2fnikRyoDz818ZAZj2BZQ8uyadP
X-Gm-Gg: AfdE7cnYVX2PufUw70twd3yxWvQY2lC2ObRCMWyAKzT7bpVGGS0vE+i6SsipyGQ7Uyl
	4mY9UwWpVDiFnLDrvtp7kSox/kyH83Jn/XTJP6/CYKgVeQMH+/+G5DdRqVRHlb4lAzYBQAjoDHB
	7n5TBBv9s/mAWFEWaMCFo2le6zv4++aijTX7EcjD469KpmX6U7QhmvvUlMfZ2UxyNRX2q8rC56d
	1owZCpqf4cUNjjt0JSiy0G+9FVsD0SxQy7HupJb2+pCwS6jbptgIEJQUYrX9Kt0IB759rPWQhxb
	7MaU8jn/xva562gEXem03n9z5Ghxfl2elNfyQBBNgBtUYt7YyeGc5jG1x6R+CI3IAqRKobJTGg6
	/Qkgo09LziO/NfrbAjDEF7XbdQi/yepdmwr0ajSvkDUEcYh69A9Ie0A8PnGezlqJ/oeapHKCYVy
	I1M3I3d0s5TwuNL+T/GGuN8xRd3XchZkCLEaVISYhAvlOy0uchqxPpEOk7Ft3AlapALg==
X-Received: by 2002:a05:6a21:48d:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3bfed29d324mr10405838637.20.1783066271547;
        Fri, 03 Jul 2026 01:11:11 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm25932409eec.15.2026.07.03.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:11:11 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: oleg@redhat.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	mkchauras@gmail.com,
	mchauras@linux.ibm.com,
	thuth@redhat.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	ruanjinjie@huawei.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH V3] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
Date: Fri,  3 Jul 2026 13:41:00 +0530
Message-ID: <20260703081100.1681924-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling GENERIC_ENTRY on PowerPC, syscall_enter_from_user_mode()
returns -1 as a sentinel to signal that seccomp or ptrace has intercepted
the syscall and already set a return value via syscall_set_return_value().
system_call_exception() was not handling this sentinel, and since -1UL
is >= NR_syscalls, the code fell into the out-of-range path and returned
-ENOSYS, overwriting the errno already placed in regs->gpr[3].

The naive fix of checking r0 == -1L before the NR_syscalls bounds check
is ambiguous: a user legitimately calling syscall(-1) also produces r0 ==
-1L, and a tracer intercepting such a call would have its injected return
value silently discarded.

Fix this properly by introducing regs->entry_flags, a kernel-internal
field in struct pt_regs (consuming one slot of the existing __pt_regs_pad
so the ABI is preserved), with SYSCALL_ENTRY_RET_SET as an out-of-band
flag. syscall_set_return_value() sets this flag whenever seccomp or ptrace
injects a return value. system_call_exception() zeros entry_flags before
calling syscall_enter_from_user_mode(), then checks and clears the flag
afterwards: if set, it returns regs->gpr[3] directly regardless of what
syscall number the user originally requested.

This handles all seccomp actions correctly:

  - SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE (no tracer), SECCOMP_RET_USER_NOTIF:
    all call syscall_set_return_value(), flag is set, injected value returned.
  - SECCOMP_RET_TRAP, SECCOMP_RET_KILL: call syscall_rollback() and deliver
    a signal; flag is not set, but the process is dying so the return value
    is irrelevant.

The fix covers both ppc32 and ppc64 with no #ifdefs.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
v2 -> v3:
 - Last fix is not working for -1 syscall. Fixed that with this.
v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com

v1 -> v2:
 - Fix issues in the previous fix (Michal)
v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com

 arch/powerpc/include/asm/ptrace.h      | 22 +++++++++++++++++++++-
 arch/powerpc/include/asm/syscall.h     |  6 ++++++
 arch/powerpc/include/uapi/asm/ptrace.h |  6 ++++--
 arch/powerpc/kernel/ptrace/ptrace.c    |  2 ++
 arch/powerpc/kernel/syscall.c          | 18 ++++++++++++++++++
 5 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index fdeb97421785..1a53d5cfa8db 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -54,8 +54,9 @@ struct pt_regs
 			};
 			unsigned long result;
 			unsigned long exit_flags;
+			unsigned long entry_flags;
 			/* Maintain 16 byte interrupt stack alignment */
-			unsigned long __pt_regs_pad[3];
+			unsigned long __pt_regs_pad[2];
 		};
 	};
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
@@ -233,6 +234,25 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
 #define current_pt_regs() \
 	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
 
+/*
+ * SYSCALL_ENTRY_RET_SET: seccomp or ptrace called syscall_set_return_value()
+ * and wants the syscall skipped; regs->gpr[3] already holds the return value.
+ */
+#define SYSCALL_ENTRY_RET_SET	BIT(0)
+
+static inline void set_syscall_entry_ret(struct pt_regs *regs)
+{
+	regs->entry_flags |= SYSCALL_ENTRY_RET_SET;
+}
+
+static inline bool test_and_clear_syscall_entry_ret(struct pt_regs *regs)
+{
+	bool set = !!(regs->entry_flags & SYSCALL_ENTRY_RET_SET);
+
+	regs->entry_flags &= ~SYSCALL_ENTRY_RET_SET;
+	return set;
+}
+
 /*
  * The 4 low bits (0xf) are available as flags to overload the trap word,
  * because interrupt vectors have minimum alignment of 0x10. TRAP_FLAGS_MASK
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 834fcc4f7b54..9ae79326abe3 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -98,6 +98,12 @@ static inline void syscall_set_return_value(struct task_struct *task,
 			regs->gpr[3] = val;
 		}
 	}
+	/*
+	 * Mark that a return value has been explicitly set by seccomp or
+	 * ptrace so that system_call_exception() can skip the syscall
+	 * unconditionally, even when the user requested syscall(-1).
+	 */
+	set_syscall_entry_ret(regs);
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index a393b7f2760a..2f2a43414fe6 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -56,7 +56,8 @@ struct pt_regs
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
 	unsigned long exit_flags;	/* System call exit flags */
-	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
+	unsigned long entry_flags;	/* System call entry flags */
+	unsigned long __pt_regs_pad[2];	/* Maintain 16 byte interrupt stack alignment */
 };
 
 #endif /* __ASSEMBLER__ */
@@ -117,7 +118,8 @@ struct pt_regs
 #define PT_DSISR 42
 #define PT_RESULT 43
 #define PT_EXIT_FLAGS 44
-#define PT_PAD 47 /* 3 times */
+#define PT_ENTRY_FLAGS 45
+#define PT_PAD 46 /* 2 times */
 #define PT_DSCR 48
 #define PT_REGS_COUNT 48
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 316d4f5ead8e..440d00690cf2 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -235,6 +235,8 @@ void __init pt_regs_check(void)
 		     offsetof(struct user_pt_regs, dsisr));
 	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
 		     offsetof(struct user_pt_regs, result));
+	BUILD_BUG_ON(offsetof(struct pt_regs, entry_flags) !=
+		     offsetof(struct user_pt_regs, entry_flags));
 
 	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
 
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index a9da2af6efa8..c7458aae199d 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -19,9 +19,27 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
+	/*
+	 * Zero entry_flags before syscall_enter_from_user_mode() so that
+	 * syscall_set_return_value() can set SYSCALL_ENTRY_RET_SET as an
+	 * unambiguous out-of-band signal.  The field is not initialised by
+	 * the entry assembly.
+	 */
+	regs->entry_flags = 0;
 	add_random_kstack_offset();
 	r0 = syscall_enter_from_user_mode(regs, r0);
 
+	/*
+	 * Seccomp or ptrace may have set a return value and requested that
+	 * the syscall be skipped. syscall_set_return_value() sets
+	 * SYSCALL_ENTRY_RET_SET in regs->entry_flags as an
+	 * unambiguous out-of-band signal. This avoids the ambiguity of
+	 * using r0 == -1 as the skip sentinel when the user themselves
+	 * called syscall(-1).
+	 */
+	if (unlikely(test_and_clear_syscall_entry_ret(regs)))
+		return regs->gpr[3];
+
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
-- 
2.55.0


