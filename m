Return-Path: <linuxppc-dev+bounces-24190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49198C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 07:59:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzsCp4VxQz2y71;
	Tue, 14 Jul 2026 17:59:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784015990;
	cv=none; b=ohZOswi5Bxj+1H06Oc28uvzkX/SE9tcouElOUvJb1K7B94AbB1benrRQlVHj8+EYP4cCk0ZojedLqEiJjbwNvb5rOZCBJo1wmP3Y1STcXMbh0jwxG1VtSIWyH24g6w/Wj3c9jSjDWm6OWteOG8vq2YZp4ls1B+COxhYpfrztPpWwNk9OK1kssG+QGcQWgmkll7gESDqi3pdT5NC/cnmmdGHsTM/NaI/+0AzaQlOMNKETbszWuEI44IW65mn2HpFs1l832VY4pZFswqzAPJ2FOrY4bCZy6hOF+BlHLTbhX08Zq0zEDDPof5nLEStNd4WEarGr5iadDVUE4ves3ceBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784015990; c=relaxed/relaxed;
	bh=yj5ApoHt9xXhC677bK+ujyDHWz19Ntuz1e97qTuHnZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=moWTxvJTVGWqh6Laazc1ROXwEHSuSbwkJy475U8ronNA+UKY49IjKiw1fJ7zR+/+HCGnQzk6gVN96RGpOL+AVWHdAyzXV3ZJNGvZOmKhzj7P0B9TkKDqNJI4W4UK0L5xBKSKE/+RUxUMH1C1FPEo8fMLdbvocPY/BNbQfdZ1IEKNg2adkFWBYim5iO0kiJC05CXDD3JDbeWsZruJ5UiPdVn+jq2uhCW9iquP7+nIYQp0YuQlMREDymSItlEgRnSLeOmyFUrsnb3as8VRLmoRnLid5rQYRMPdaf7ZQoKI1bj/vaA0LJXu3SlpGzvM+5tGafkWT2d6lpx4uvNMOupVUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P3nYVUec; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P3nYVUec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzsCn1dVvz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 17:59:48 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-ca80d708489so495179a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784015986; x=1784620786; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yj5ApoHt9xXhC677bK+ujyDHWz19Ntuz1e97qTuHnZM=;
        b=P3nYVUecYoAm2z1L5pP3qPcD4/si4H61h7sGP88jr1RhMwL4wtkeRv2v6ce4OtVYjH
         877/0Clw/fFOhrUA/AUoH9X4/CaK+NbGQHvQdW+CS8qtLhJtspSLDaMD0LVNpwtDld7U
         chf52TIMMd6A215WW+scLX7I/v1m7SS2PumxacrDiHnKZuClSm/JYjNlfkXf404ARaLn
         fJ8MV7DkSZLbGSfQYh2U7HJQizoKfJ5OnLdOFn98LUPpCebvwb7ycf/SEWgAkQWCf7lG
         JWtHONbFQH1eDRSeMwt5Q3UJVBQ1AMVe4jO6L36F8+M5sZuPwwbFvpeWM7gBofE7LVbg
         x73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015986; x=1784620786;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yj5ApoHt9xXhC677bK+ujyDHWz19Ntuz1e97qTuHnZM=;
        b=iDc6UeeuPv7HlDgnLJqq7bbU0zYVfHmeKrfe7Kn43WCBAboiZFQZkLzagyep/haPEY
         /VoikiABJBAF8FEmakl18DagS19no01k9yfAYmmYyI9AaRjoOb5l/wpyipE7OkHYMQLY
         mP5lQdjsYsd0TnchYm78vOfUHbtCWXkfbrhH3g+9BHQIZIzoLUPEHCi3gj7cGagKTNp9
         2cRRxbPOkKvuMRLkBaXWmxf7/t7UEGl55rTUwwKPQmMvrSBU+grzifqYNwE3q75lm8Zi
         X3g9TVHH9XqqCu/A3TYdojinOUDluwU3zHHZ1JOHBpLzZrew6f5577ezahJibni4LOSN
         BwcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrB2pZWs6fu1q5nyfdu+aaH3RnwHZYmzrMSk8CE38s0cf55wdEi7qSjmvQeqO0BOpFQO+E4M3VZ2RZxHDQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzU+Nfmn/jC1cLRoHGIEtbUDWRpXpLT7Z9Ta9oSnjHNNJzAW7T+
	mZcOWG0DeiL41974+jhtvjCmbrMG8n6nAFBKj5FRjRpjoW6oW9N090OE
X-Gm-Gg: AfdE7cmfUqFJI68r9zUA3CIklVlozoQY1/VnAxBvGGNn+/88N5KMxD5dRBk4Bd4i9E5
	vsEQIRc/ua171iuR4BYwkTs7Tszh91VPTvwn4J1jvvMWK0bji5EhZzUOCdLQVeSj26wki8/gw7K
	2N28kAq4GllNBKgzGckdS5MchF9mDfvXCy3oWJi30j6xYL211ur8xKKG71XGcjLQJE4QRMaql07
	5bEFffJfZe1Q3PFE8Flse157tighm2+Dmq1VYWIMWX7mY5uzOTC+2d3E0AaBOgoH3E/P2vnRyaw
	D13OSk/o3+P2uXnRhWmFeQjArMmoJEKxfs9VNWENU9XdrhnFwDQNx+xPnNQSKmKkIrIPQ2EQcp0
	WeqK515t4pqwI6bZrwtR4EPDNO+RAmJI47vUcrTk/bcOo2NuoVdP+xRGxENhxkm9MuJw/9Nf9FY
	MsTEM3fIsSFpd1pPF4ayqTGuHjF8T35F98Q93a0YsJKTQS+e4hH1Wyp8EwaGIjKxxMsLrYc7qPc
	3h+
X-Received: by 2002:a05:6a20:748e:b0:3c0:2808:4732 with SMTP id adf61e73a8af0-3c112c5fec5mr10483937637.16.1784015985376;
        Tue, 14 Jul 2026 00:59:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm80362644eec.30.2026.07.14.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:59:45 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: oleg@redhat.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	msuchanek@suse.de,
	mchauras@linux.ibm.com,
	mkchauras@gmail.com,
	sshegde@linux.ibm.com,
	segher@kernel.crashing.org,
	thuth@redhat.com,
	kees@kernel.org,
	ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
Date: Tue, 14 Jul 2026 13:29:35 +0530
Message-ID: <20260714075935.1830145-1-mkchauras@gmail.com>
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
v4 -> v5:
 - Fixed build failure where BITS macro is not available
v3 -> v4:
 - Use syscall_get_error (Michal)
v2 -> v3:
 - Last fix is not working for -1 syscall. Fixed that with this.
v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com

v1 -> v2:
 - Fix issues in the previous fix (Michal)
v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com


 arch/powerpc/include/asm/ptrace.h      | 23 ++++++++++++++++++++++-
 arch/powerpc/include/asm/syscall.h     |  6 ++++++
 arch/powerpc/include/uapi/asm/ptrace.h |  6 ++++--
 arch/powerpc/kernel/ptrace/ptrace.c    |  2 ++
 arch/powerpc/kernel/syscall.c          | 18 ++++++++++++++++++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index fdeb97421785..363a89787f1c 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -19,6 +19,7 @@
 #ifndef _ASM_POWERPC_PTRACE_H
 #define _ASM_POWERPC_PTRACE_H
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <uapi/asm/ptrace.h>
 #include <asm/asm-const.h>
@@ -54,8 +55,9 @@ struct pt_regs
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
@@ -233,6 +235,25 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
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


