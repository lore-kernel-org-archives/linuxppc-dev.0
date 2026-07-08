Return-Path: <linuxppc-dev+bounces-23779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127E2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:17:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw9tZ5YFvz308X;
	Wed, 08 Jul 2026 18:17:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783498630;
	cv=none; b=kl74pDieOurqTbcEf3wV4DKC1UMnBm3NihQPdXInBZgEjI2rPkvb7iiXB6UJ5/5nbGOiFxiQbH/iqDKgcdkPRHSxxnMps1DoJcUPp/8glxmlfxL1CMqprQVY5JOWSi2/QL29cSms/f7KJS+iPBRv9JJleN3NQRHWRzHT+FoiH8sTAanYE5zLiU+HKFyvvqvIFUjHP970Yj+Iy68HqPzPQw9xHJohL3CXaATnvIHviShncLd3SFBcTKQkaYbESbhdASFt4+HJ7Hi1G/DLSXjzJMIlP994l1YXd46nnnVArn0qYcAxTbSY9azozDeTCzRXysyfAkFeFokxlIEB1U+/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783498630; c=relaxed/relaxed;
	bh=kOQ8rJdnaLlYyfsujfvhTomKPZ31Ydzu6crJCE3qtlM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6fOLDt4xNqD3SZAwUcLHakmlSnLEKlvbuJ9iFMP52PpsaYHzAssrVlnWdBbcbfgMH+Zd7r3nLJeyvdHvtzWbZGA0xaF+FKishBVfdCj24XqZYdH39nbBG4iLQnaOPBJiiLCHruYWppu4Vu0VZzZaKy5cu6EvvLzBUIt4+vYORtPr3tTsnyrawdrc2z6deNP7AjRMaS57QLDYlpoGGVMvlr47//dvKvDT1J3fMDHW9sZE+ihc0IC/LCFCG6B488QYG2ULydS5Q23hPuTLeZm3d8Tsdf+ny16IqmyhMM061Hp3kVxZFsz+/8BR6WaaDpQMvehHvsfZbB7qtf0Puj2uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LdfRE//r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LdfRE//r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9tZ15bvz3046
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:17:10 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso327191a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783498628; x=1784103428; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kOQ8rJdnaLlYyfsujfvhTomKPZ31Ydzu6crJCE3qtlM=;
        b=LdfRE//rV2gbJ+PN8lJDiY0EhLWur8ZUGBUxNh7cj+72kO4+C92EpPX8LjXjFmfg4p
         ZEjXi0xJjsBgC+QMOiP6vXPkL20209jvDcqK5nyRFdb2hberv/bwsCEDIRu9emV5Djbs
         i+7zYQhuJDMwusEnWon8HrOJyY4PPwQOKl1kKUgFG6PVjCpEOopPOcB02046tcXl59MT
         ABh6yjUbDzvGH3bp0dQbp9Gmzv971/RteyEBrGkfbWBVVC3jNpsETrIGOLcGs87OpnvJ
         Zlf3H1hXmhTYAFgS01zTfspPbm1dLGDNMctHtboeE+CBdXGgGaBCSuimC0QMvleIRr+K
         4twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783498628; x=1784103428;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOQ8rJdnaLlYyfsujfvhTomKPZ31Ydzu6crJCE3qtlM=;
        b=PXSBTc011nYWMsHCHCr2xHfh9bRIBna8Kh1grZ/K2Jxxzw6Q4jDySM2C4EgpF8EdYP
         TzBvZuY28NutTITbi1AB3TOfuVr7BWzrQm+QBLGipPbE2EoqZanCm23qkBCDjTs4/4XL
         4fOO5ZIOvn1HzrkWgKSXqml+d1ONCCE0YxQY/msBJ3VrYQnCWTPTPjsywDE666NMK15N
         kiyJv0dqaUR0IHpVEjD/W1sAnjFwqBBLx2PF+UngcouGttRt3FD94UkebuFD5UetxfDV
         0IpyrvCUIT0gDPE0UTGC6+l8OL1WBSsbhmzyL/oQwM0/6MzuIWcub4w0LtIvVcTKhUph
         uaXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpf/uApfy/vBrPPe7tRKKfo/ykMA+aFpyle9J1J1mTVq2QKIT8JXb7auxCbfwqgOiU7MbL/eynIjQZtxy0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygSfICzPZEH6yi/dpI6GKNE2R1YYr+2F/FGMfTzT0/uDnTiolV
	FYOwnpFyFAUJPqb5WZzug/JcYV+B9rtK3r8guxRhZaRCVRjqXRHiYU9o
X-Gm-Gg: AfdE7ckog887LvqX5NcT4969GpJMdEWg2FFGyL3EhWjl2tK4r8vC31XiIkt08yoesVC
	kpRq1TWr9hg2ZfOiRAhz1tC16zigd27gGgLPH46hQB4CSWKHLzNUO4kZPTgAj6grV6cxILNmcxa
	PG3IlQSNLizZ/xyPvR5uOSm0GbPkNRX3jt/SrncMwUa0sUklqpwl5Zl4ULEK78104FZizLYyN8l
	347mSk5V+XL591s4oaJ9hcWZC7HL4d+j2YOr6krlgp0rhWnGbr8RfuyOZotCJY5dgUhfzGiFtvj
	C/tw29YiLD4M8u4pXwRTvGqBrbQwYMQ8W/KKOwLtJxVDOXJJvTL/Pj/MjbnqxV17eVZMLx1PUkX
	QiWJjWJH+Ss3IUUquzFc89CHuk8rQ2Ry8gZRtI1FsmA6qL9g/mqulj+JGn3T3SBYVfl5+JmUY/n
	4rTqF0ShlZAZisZToe7XyzZnn0deBbu2V7LqejooBqOeMLrX0qpZ8E/kAoEIITn2bWSw08xdA7d
	AUY
X-Received: by 2002:a17:90b:5603:b0:387:e0bb:57fa with SMTP id 98e67ed59e1d1-389421ae993mr1439396a91.43.1783498627957;
        Wed, 08 Jul 2026 01:17:07 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483e0a2sm16346132eec.12.2026.07.08.01.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:17:07 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	oleg@redhat.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	msuchanek@suse.de,
	mkchauras@gmail.com,
	sshegde@linux.ibm.com,
	mchauras@linux.ibm.com,
	thuth@redhat.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	nsc@kernel.org,
	japo@linux.ibm.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V17 1/8] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
Date: Wed,  8 Jul 2026 13:46:26 +0530
Message-ID: <20260708081633.1248382-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708081633.1248382-1-mkchauras@gmail.com>
References: <20260708081633.1248382-1-mkchauras@gmail.com>
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


