Return-Path: <linuxppc-dev+bounces-20167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272BAFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:29:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42vB67HWz2ytJ;
	Mon, 27 Apr 2026 22:29:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292982;
	cv=none; b=RjGMVLomUzn7Li8wAivTj2mg5poup0QtYzUPoJVa6bIhR9yAtww2q55gAHGPoulGWWNre4gI+O+dOShOJulu74Kps3aYcFme2xgBXBc6hQZ5D0vtyeQdyr/PUAvUiooVsn7bTC4j1/6CNSRha0qFD4D1GWbHn9lNtPEKbCYK19lvOpT+5N01UJRgzwivlSV4docmILLYcnCZ5Lmfw5YyhMsvA+jNYcg8pveqEQ8oGmq5N/9E4kask+KF0X+83e8eNX5STy2VgGXOrPRM6O0eMFXJ7qXDpmWba7OnSv/MYxq57LVPCmvoybaaQdgzthJerqVh1TPy4d1EOjrdZ3xyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292982; c=relaxed/relaxed;
	bh=ZyVfwI3ylMQ0K4OSfnwdgKvqJxQMmT7QZ769NDzGoQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoXPAO+Q+iq/4gTCdWH+R3Ee73GjUBh0X6gktYwpfZkMWEZknTQ3NLCeYijOnxbhBL7p0lKbYv7hJmU/fg4JuxGuNYoqefhFkvRd/zlvqktQVtX9IS8AN8Rq22fdVJlhexJwcJfZqzwnhgctqj74s/Pb3oolbx8+kRMostEDyPnaoq72dlq0befiNBAjCe4ny/2Fo3rlDuBmbdRA44SwoMmSgvhsAw005V5pu5ocLc04BZWbzxNdfjkiZa2kkCIc87E4bqUkkv3y5GhKq50+70A4vi6miC9RnvfN98uCpCa1iAIyKzMc1kL5xaIQkywYXq8gICiO15uBzNZST6R8Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NZ61rtm7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NZ61rtm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42vB1bCkz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:29:42 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-83178c0f29cso2789256b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292980; x=1777897780; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyVfwI3ylMQ0K4OSfnwdgKvqJxQMmT7QZ769NDzGoQ0=;
        b=NZ61rtm7ivvpZRDKlqdkoDQyQvGl6KoSgiCkSYi/pwrneg7fNRzqi97UsXmEpRr+E2
         kYz+JoT6wfPDYBYC4M7RYgupbj+VK1r+z8H/fI1eAw+YXLNwBeLABc5LQVWVcWHgjNap
         mDQQ7x1Xzvg0Iuaw1C8R/jN9w6/XI34ke+Ngm1lC7/ToQkJBgUQbEF4CmgjMesZxjxHz
         uDs/El/yIUKdcALvWXm+WO3iOnAfE0tM+a3yFgKRVy1hGND9XnouX821xtSRPMkiuHEo
         PX9RBRaF8gb7P+IDcGWcnggulBkvCbOWlJSshbvzX3z0US4cL2boZubh+ho22A3Qalz/
         bX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292980; x=1777897780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyVfwI3ylMQ0K4OSfnwdgKvqJxQMmT7QZ769NDzGoQ0=;
        b=pOU0zBMUdQg31G0dE/AROtKPFhO0qDBe84IFbJzRnOsv5rKR6GejBypSB33s25b3f4
         R3jHPZpAnJHSAlBbVCOGD3N1P4+2uFBmKjtAFfuy6iz7CHjRpaMfykInq3qZkzuqIrbp
         fCVZmgWK8kqs8Etisia/Wl39mbvtdQeYpEFCCBiUnKAMz4oOtqzFuFbuUcYOrRudwid3
         vbs3tGLoQH4yoeUkZv8rYsVakDjy8JXWW64XwrvhcbYRANEWM1Rzu/huXohXPfOc+BTm
         wtx+4rEmdrQAR1d57fwywxNMcSKAUKQ/J9nWtzCelvZxgfGTo870LjljpXuKQ5LxFwga
         M1ig==
X-Forwarded-Encrypted: i=1; AFNElJ8UZAqRS8/HG4zaRQ6cOCBd+kix7HACMyedSQT4a6BmBynQME9NGOjmacxtFhU6vHQBGHdws4MsONQMubo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxmT3V9yqYsz8+yv/WkkuU5OB6+zpgWwOdNwjjsPSgv3FCKJy+K
	YM4Mr7EqLb4XH6bkZLgU93lBH60THDXqjgvH9QFSaQUDLITtExJ3qFRk
X-Gm-Gg: AeBDiesAfoC/MiYahph2y7/vsTivcj+PYumB6/mLzd3M39dX4+yMVbAYR3icFWBFyoZ
	O+DxJlq+iqXvabHeWLpiOjDagOtXGGhcKKred3wQS679vWYs9gKV32EnWNo2NLiJgLv/yJLoc3x
	Q2G+WrUdz3VqJ91fffm+ZJrmW09JoidG9HX7FsGpJfXR8il4c/2Nc+Qpg7iCYQ4uydxYZIvA51Q
	u0HU9iUOtQ7DRE/K1TPIrWJT0B52lovraoE0X+Kk0OSLxBRBxVAujksZV6ZSZzoUntzTYoYIqRp
	Ublv/CZpCv70Du4E74wRNvDXgGAc9XPq0Ml/FASZlx8IcUZtggWPfuWr9GR1jNMjKsXVcFD8rFt
	Pb9QVE4mjoD5zhDggKtJ+0xxSq8J1x/lqJrcn4DeGGkG08eRIt6/YxCGtUXm2jZUlq27p+HmR2T
	UNuKmL0it76zsQ2DOXByouXtpAV09aXEWl0Fd/YqImY/l+Yj3htmQJkitXrxWiUD4Bk/7FiWfCp
	dWwxw==
X-Received: by 2002:a05:6a00:8b0f:b0:82f:c1b4:8ba2 with SMTP id d2e1a72fcca58-82fc1b4931emr20644714b3a.47.1777292979936;
        Mon, 27 Apr 2026 05:29:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:29:39 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	oleg@redhat.com,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	mchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	ruanjinjie@huawei.com,
	akpm@linux-foundation.org,
	macro@orcam.me.uk,
	ldv@strace.io,
	charlie@rivosinc.com,
	deller@gmx.de,
	kevin.brodsky@arm.com,
	ritesh.list@gmail.com,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	segher@kernel.crashing.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Samir M <samir@linux.ibm.com>,
	David Gow <davidgow@google.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v5 8/8] powerpc: Remove unused functions
Date: Mon, 27 Apr 2026 17:57:42 +0530
Message-ID: <20260427122742.210074-9-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
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

From: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>

After enabling GENERIC_ENTRY some functions are left unused.
Cleanup all those functions which includes:
 - do_syscall_trace_enter
 - do_syscall_trace_leave
 - do_notify_resume
 - do_seccomp

Signed-off-by: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: David Gow <davidgow@google.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h   |   3 -
 arch/powerpc/include/asm/signal.h   |   1 -
 arch/powerpc/kernel/ptrace/ptrace.c | 138 ----------------------------
 arch/powerpc/kernel/signal.c        |  17 ----
 4 files changed, 159 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 2e741ea57b80..fdeb97421785 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -177,9 +177,6 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
 
-long do_syscall_trace_enter(struct pt_regs *regs);
-void do_syscall_trace_leave(struct pt_regs *regs);
-
 static inline void set_return_regs_changed(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/signal.h b/arch/powerpc/include/asm/signal.h
index 922d43700fb4..21af92cdb237 100644
--- a/arch/powerpc/include/asm/signal.h
+++ b/arch/powerpc/include/asm/signal.h
@@ -7,7 +7,6 @@
 #include <uapi/asm/ptrace.h>
 
 struct pt_regs;
-void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags);
 
 unsigned long get_min_sigframe_size_32(void);
 unsigned long get_min_sigframe_size_64(void);
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index f006a03a0211..316d4f5ead8e 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -192,144 +192,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifdef CONFIG_SECCOMP
-static int do_seccomp(struct pt_regs *regs)
-{
-	if (!test_thread_flag(TIF_SECCOMP))
-		return 0;
-
-	/*
-	 * The ABI we present to seccomp tracers is that r3 contains
-	 * the syscall return value and orig_gpr3 contains the first
-	 * syscall parameter. This is different to the ptrace ABI where
-	 * both r3 and orig_gpr3 contain the first syscall parameter.
-	 */
-	regs->gpr[3] = -ENOSYS;
-
-	/*
-	 * We use the __ version here because we have already checked
-	 * TIF_SECCOMP. If this fails, there is nothing left to do, we
-	 * have already loaded -ENOSYS into r3, or seccomp has put
-	 * something else in r3 (via SECCOMP_RET_ERRNO/TRACE).
-	 */
-	if (__secure_computing())
-		return -1;
-
-	/*
-	 * The syscall was allowed by seccomp, restore the register
-	 * state to what audit expects.
-	 * Note that we use orig_gpr3, which means a seccomp tracer can
-	 * modify the first syscall parameter (in orig_gpr3) and also
-	 * allow the syscall to proceed.
-	 */
-	regs->gpr[3] = regs->orig_gpr3;
-
-	return 0;
-}
-#else
-static inline int do_seccomp(struct pt_regs *regs) { return 0; }
-#endif /* CONFIG_SECCOMP */
-
-/**
- * do_syscall_trace_enter() - Do syscall tracing on kernel entry.
- * @regs: the pt_regs of the task to trace (current)
- *
- * Performs various types of tracing on syscall entry. This includes seccomp,
- * ptrace, syscall tracepoints and audit.
- *
- * The pt_regs are potentially visible to userspace via ptrace, so their
- * contents is ABI.
- *
- * One or more of the tracers may modify the contents of pt_regs, in particular
- * to modify arguments or even the syscall number itself.
- *
- * It's also possible that a tracer can choose to reject the system call. In
- * that case this function will return an illegal syscall number, and will put
- * an appropriate return value in regs->r3.
- *
- * Return: the (possibly changed) syscall number.
- */
-long do_syscall_trace_enter(struct pt_regs *regs)
-{
-	u32 flags;
-
-	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
-
-	if (flags) {
-		int rc = ptrace_report_syscall_entry(regs);
-
-		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
-			/*
-			 * A nonzero return code from
-			 * ptrace_report_syscall_entry() tells us to prevent
-			 * the syscall execution, but we are not going to
-			 * execute it anyway.
-			 *
-			 * Returning -1 will skip the syscall execution. We want
-			 * to avoid clobbering any registers, so we don't goto
-			 * the skip label below.
-			 */
-			return -1;
-		}
-
-		if (rc) {
-			/*
-			 * The tracer decided to abort the syscall. Note that
-			 * the tracer may also just change regs->gpr[0] to an
-			 * invalid syscall number, that is handled below on the
-			 * exit path.
-			 */
-			goto skip;
-		}
-	}
-
-	/* Run seccomp after ptrace; allow it to set gpr[3]. */
-	if (do_seccomp(regs))
-		return -1;
-
-	/* Avoid trace and audit when syscall is invalid. */
-	if (regs->gpr[0] >= NR_syscalls)
-		goto skip;
-
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_enter(regs, regs->gpr[0]);
-
-	if (!is_32bit_task())
-		audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
-				    regs->gpr[5], regs->gpr[6]);
-	else
-		audit_syscall_entry(regs->gpr[0],
-				    regs->gpr[3] & 0xffffffff,
-				    regs->gpr[4] & 0xffffffff,
-				    regs->gpr[5] & 0xffffffff,
-				    regs->gpr[6] & 0xffffffff);
-
-	/* Return the possibly modified but valid syscall number */
-	return regs->gpr[0];
-
-skip:
-	/*
-	 * If we are aborting explicitly, or if the syscall number is
-	 * now invalid, set the return value to -ENOSYS.
-	 */
-	regs->gpr[3] = -ENOSYS;
-	return -1;
-}
-
-void do_syscall_trace_leave(struct pt_regs *regs)
-{
-	int step;
-
-	audit_syscall_exit(regs);
-
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_exit(regs, regs->result);
-
-	step = test_thread_flag(TIF_SINGLESTEP);
-	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		ptrace_report_syscall_exit(regs, step);
-}
-
 void __init pt_regs_check(void);
 
 /*
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 9f1847b4742e..bb42a8b6c642 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -293,23 +293,6 @@ static void do_signal(struct task_struct *tsk)
 	signal_setup_done(ret, &ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
-void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
-{
-	if (thread_info_flags & _TIF_UPROBE)
-		uprobe_notify_resume(regs);
-
-	if (thread_info_flags & _TIF_PATCH_PENDING)
-		klp_update_patch_state(current);
-
-	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-		BUG_ON(regs != current->thread.regs);
-		do_signal(current);
-	}
-
-	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		resume_user_mode_work(regs);
-}
-
 static unsigned long get_tm_stackpointer(struct task_struct *tsk)
 {
 	/* When in an active transaction that takes a signal, we need to be
-- 
2.53.0


