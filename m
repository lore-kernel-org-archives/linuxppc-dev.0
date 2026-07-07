Return-Path: <linuxppc-dev+bounces-23674-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09801C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 06:37:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvWkJ5KMQz3brc;
	Tue, 07 Jul 2026 16:37:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783406264;
	cv=none; b=I/5NzMC1oOP5pxZIUcEQFa6ZCj0ZHRl2PdIKhfXzAgHailufAF8YXM9QLJIzbi9YEPN+QMv4e6zwASuLWOC7D6DE5LzUehJwseZZpwkQP9AYvO/opO/9JQtTPfdNrQeQ00jBG1TAakUBM6lz4eZT8AYrnm8CWtIgb80FOEUNubfr63HD+IJzDH/HSxe5lyyK1UiGJsVLvQ1GVJa6xCGEdvUgc+qh+qV5aQIAAPUK9+AOZa7zIzOD5eUQ+XhfvLagp5cKsdqtJclrh795tQYZgCOSRwOeIDfN9pEY9hhCrkfG9/H/S10KM5Q6TM5udWoNNipUOHAiBNfATFFsxrRhow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783406264; c=relaxed/relaxed;
	bh=kOQ8rJdnaLlYyfsujfvhTomKPZ31Ydzu6crJCE3qtlM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPdaFUv5TQ2+tIGcJ9iKG76V/T3YxRSsdg9dJYVImvPFUQ1i/Toz9UKApIZURWvsSuFrKWiHFmymxcimQuCIf67QcLaVc1aa6J4gNDH1JGjDP0+8Gv1DOFd/3y/CGKq8yeEaRysOYtpRaXo5IRnnzt6ytYoyhuemjf3WBEAPPjV4FuXeJgw2tpBWAk6wz1ofnMf0uY3tOS8JNfCrxBVSy80hycCafI+Uh8eibCjAhAacVOK2RTJ/AcUccnxroMz30scjK8yAeeWCqizTkSi8q6W0wLk8riqNl9Kq5Oro07RUraoDKiInFd7waqq5aLjJq2Gmb3kbf4N5aSZV6jFmrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MJdmuWKu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MJdmuWKu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvWkH4bqCz3brN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 16:37:42 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cca24023edso24459805ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783406260; x=1784011060; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOQ8rJdnaLlYyfsujfvhTomKPZ31Ydzu6crJCE3qtlM=;
        b=MJdmuWKuFvwTJd2GY7TLYzLZoPOktMEdk2RuUArQ8xkvWO6YOL60ZxUdHsX8tIdtCc
         9YfPCHnDtOnGJNDRumeRuIJPvPGskMpwuAzJxk7FoHqyclCB4uNithoBFJs6okxjE280
         8f9Yqys7+PlYKOKdMWWpMewxlcdMjGE5IZZ8G8PHBOHNXg3G4Gv4lNRUdxnYpqc3G+Fp
         zI/XHqiYuLfC+7Ia8/XsECbxvBzGw0YoBQtFGadZvrYikgF92MDrwz5VwoCyVeTmgd7+
         qyZbP2Erq9Zsix2v3/5hQyyXbJUJ+ps5WgdW1fAVugBatE5KrMcbNSVouUjA95+wnmP+
         Mv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406260; x=1784011060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOQ8rJdnaLlYyfsujfvhTomKPZ31Ydzu6crJCE3qtlM=;
        b=NBL7yLIQj/4xPomX0GKwyt3tY5XNYggRfD3IwkhRf9uxVXn7KsrbZz4ls8pGJoxMZM
         Z6XPrq1Jb+vD8hjOczQGMNul0xNjkHDQd3sqQtRzrfTBbEVejEzH3bTlcedJaUZGlNDw
         PJeGDXOfAVea9T4jZzXnIUe6zWxr+WrfQpwe34scG7pdFVdxexK77S+VScLOegncga5P
         MG0TXboFc+G+ntXIRe43M4J8XE0ZC5kBT/y6lTOGvNWfFTXPahJgHnbcLPbX5ksWoq6F
         xaeGpOlWYRgE/j8TnsJIDbNe8V1TFIlgs7sNCf6oj83hi+MU3eAPbd3kmOOp7KZp1Fdf
         42Vw==
X-Forwarded-Encrypted: i=1; AHgh+RpdPkin12/i2kOxQ2tEKY9UjQ0c5c0Yz/CkykQp4o9n9EPhcP4ECGni4+FleNV/0ERbZMPZ+tPFd5kDZjM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyfDASFHl2QlOM/sMhwSEEiqGU59vyNYJjEKwfEFb/RfV/8HuyK
	zMvCKTdbvTilTt4kDJeMUd8mWqe69JV86l35e8ZkF385MfQe28Bvm6Xr
X-Gm-Gg: AfdE7clAQivjgai3eRRz0SRBmX1uiLq69I3eo7PJetPkJt1mFHgJDzna0+H0LMtcg8n
	HmTzyGHhJsHplSMMZLSR7KhBzPQzckd1BPR6JS2pzqyu842G/cDKukv6Ermq219EnIW9Z5p4WxC
	GeYGb+pWLgHbEgqNkdoE1vnjFbZT5yXzwvvh79DL5N0Y3Afe08LrGydCk/d2JLIASGxk4KWWUMR
	35WHitqUGLXsTR3CIvOTDxSsF/yo1mZRA+GqYbsbxE0Ac2oTV+EoXNmgcTO0aH5JDeg3tmeAakn
	2TqwjOmJIzM1/+Bs9rx2V6Ul4VYCiv3k0UhIcg4DSZ6jOJVG9rdJ/82WlsTu48bLzFF1b58RYnE
	IiLGMALFows4JHhfcFRyPM6UACpMwQdS2E7eNAW4FC62SN8hIQC59edY2fc9yzagc6bou4zJ4ol
	RDZpfBAGzdnPccg/SlviOBpzH9GUrLAPWYkTDgeG9F/p7vBu5Fwxifo0pLM+itpdyWNwvAJvK7J
	Q0A
X-Received: by 2002:a05:6a21:8886:b0:3c0:9c18:d5af with SMTP id adf61e73a8af0-3c09c18d774mr1685920637.76.1783406260383;
        Mon, 06 Jul 2026 23:37:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm6719733c88.14.2026.07.06.23.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:37:40 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: oleg@redhat.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	msuchanek@suse.de,
	sshegde@linux.ibm.com,
	mkchauras@gmail.com,
	mchauras@linux.ibm.com,
	thuth@redhat.com,
	segher@kernel.crashing.org,
	kees@kernel.org,
	ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
Date: Tue,  7 Jul 2026 12:07:29 +0530
Message-ID: <20260707063729.387129-1-mkchauras@gmail.com>
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
Tested-by: Michal Suchánek <msuchanek@suse.de>
Reviewed-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
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
index a9da2af6efa8..a43d3a9428cc 100644
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
+		return syscall_get_error(current, regs);
+
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
-- 
2.55.0


