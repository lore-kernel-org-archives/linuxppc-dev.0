Return-Path: <linuxppc-dev+bounces-27334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49768C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:32:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfy925cZz3bdD;
	Tue, 15 Sep 2026 21:32:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789471953;
	cv=none; b=NTztEnuBN7MB9cJyTC1+PkVrCrPJMM/ulniKxfOjf/d5F8OoXFZqXKbk+Y8bR1GgHA0iaZiizwMUKuLW+HI6zkd3d94UXOs3oBvWUB0Qk+K5G2XTDRxVMHUKuWXUKdN+iwH6BLWar97geYhVSuhFOVHH1zWKYKSaecU0+CqJMq6twoGFsXrsxr0XZf0fBJUhsM0sIjCOBY3/sQcjHjxEoumdHstgonFzyY3JnTBqE/juZJqyLk7u5mN3CELoCPMIsV6NKzVxOxUrHo65euELqBVeQZSTPNAUqToErBjJn97Z4BS2/O1x/pfecfTQN0lcNErcpHFSOtIetC2tbz2p4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789471953; c=relaxed/relaxed;
	bh=i7wVyaLFDwSh4RsQ7x/yFwVaLvEj62at9uwFUzmPLMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzdUtPWBl2N8Dj+8u8A4t+c6iGOqASPCUL2qENN8xZSatoexKwUrqHXoMVW1tTGq3ONvxtug3TsrJf7hsS2M1FbkYMVC0VMlaZwGkUDWUE6T/JxIaw5CCU0D3F4L09HrS2wqLZXtEDCcbNdYcKZm4yZkuUH4KYnGrR/OYtPT+2nPFC5DzX4ThP1jgsJm8QFOjxXxrMSir3tLZ/0kc2MKUNGfxAx216UooaKOIU/CCdnrcsVlwlyayGq5tJyt5e4O5+z2kHt8RRL/fZvc5TgyhLU4gPWXOBjBTUg3cd5mYl7NPwOsQqbntAHhbN8Urw/NYUAz96QPW4Ug0HpTVZ3Dsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+K2QXP/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+K2QXP/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkfy82sWZz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:32:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 49224600D1;
	Tue, 15 Sep 2026 11:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80221F000FF;
	Tue, 15 Sep 2026 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471950;
	bh=i7wVyaLFDwSh4RsQ7x/yFwVaLvEj62at9uwFUzmPLMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m+K2QXP/zbRGzsTYOiazh6maQXF3AuGZOI8kte5zBpS/uMcEZtnwlKYDvWPSx21mx
	 7TGqdB2C/asSsMklDxBThdjFd165iUvhBszGEb7vDKiAwqKwu88ALg4R3OQntDPmSy
	 pL009b1opBUWgVeuBuk7lGh4yrLHaVwvTc34V6si7vaZd9pMcP+QTIh2EpkZPCrPHa
	 roLy/D8FmA6vUFej8GssEIMuVEW8Xxbjc55QWU2ylDQo6Q1WZPwq27fmmdRMZbmLVP
	 oJ72BLK/Gp1V/aWXjwbp1rJsiSD2B/wSlHgBuF1q53c4nr7kcTHLIyN7mofScYlI7c
	 A/WVLIvzUUtlw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:55 +0200
Subject: [PATCH RFC POC 09/50] m68k: commit fds on syscall exit
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-9-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4471; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vs7iz3bKLJG7CXsTvZEBdGx9Li08YdT/8Wd/px3d4TY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnprokIqSkKVD/KZ/524Xdnh56o/lnaM35m5YhWv
 xThf2beUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJG4VkaGBu1Lkfsvr6ti2m+Q
 0zx3V73WWh1tb5Pp3pZGNvef1XwNY2Q4/KqPv1PzYdm70LqORZH7stbOZDNYK+obXGf+cLdIFAc
 jAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it on the untraced return from a system
call in all three entry paths. A task that reserved descriptors calls
syscall_trace_leave(), which commits them before the ptrace exit stop.
The traced paths already end up there.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/m68k/68000/entry.S             | 10 ++++++++++
 arch/m68k/coldfire/entry.S          | 12 ++++++++++++
 arch/m68k/include/asm/thread_info.h |  2 ++
 arch/m68k/kernel/entry.S            |  2 ++
 arch/m68k/kernel/ptrace.c           |  3 +++
 5 files changed, 29 insertions(+)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index c257cc415c47..479032af2f2f 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -89,6 +89,16 @@ ENTRY(system_call)
 	jbsr	%a0@
 	movel	%d0,%sp@(PT_OFF_D0)	/* save the return value*/
 
+	/* descriptors reserved by the syscall are committed in syscall_trace_leave */
+	getthreadinfo
+	btst	#(TIF_FD_SLOTS%8),%a2@(TINFO_FLAGS+(31-TIF_FD_SLOTS)/8)
+	jeq	ret_from_exception
+	subql	#4,%sp			/* dummy return address */
+	SAVE_SWITCH_STACK
+	jbsr	syscall_trace_leave
+	RESTORE_SWITCH_STACK
+	addql	#4,%sp
+
 ret_from_exception:
 	btst	#5,%sp@(PT_OFF_SR)	/* check if returning to kernel*/
 	jeq	Luser_return		/* if so, skip resched, signals*/
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 4ea08336e2fb..43e47d4c0018 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -78,6 +78,18 @@ ENTRY(system_call)
 	movel	%d3,%a0
 	jbsr	%a0@
 	movel	%d0,%sp@(PT_OFF_D0)	/* save the return value */
+
+	/* descriptors reserved by the syscall are committed in syscall_trace_leave */
+	movel	%sp,%d2			/* get thread_info pointer */
+	andl	#-THREAD_SIZE,%d2	/* at start of kernel stack */
+	movel	%d2,%a0
+	btst	#(TIF_FD_SLOTS%8),%a0@(TINFO_FLAGS+(31-TIF_FD_SLOTS)/8)
+	jeq	ret_from_exception
+	subql	#4,%sp			/* dummy return address */
+	SAVE_SWITCH_STACK
+	jbsr	syscall_trace_leave
+	RESTORE_SWITCH_STACK
+	addql	#4,%sp
 	jra	ret_from_exception
 1:
 	movel	#-ENOSYS,%d2		/* strace needs -ENOSYS in PT_OFF_D0 */
diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index 5cb3ace55622..861b6f523bda 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -62,6 +62,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NOTIFY_RESUME	5	/* callback before returning to user */
 #define TIF_SIGPENDING		6	/* signal pending */
 #define TIF_NEED_RESCHED	7	/* rescheduling necessary */
+#define TIF_FD_SLOTS		12	/* syscall prepared descriptors */
 #define TIF_SECCOMP		13	/* seccomp syscall filtering active */
 #define TIF_DELAYED_TRACE	14	/* single step a syscall */
 #define TIF_SYSCALL_TRACE	15	/* syscall trace active */
@@ -71,6 +72,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_DELAYED_TRACE	(1 << TIF_DELAYED_TRACE)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 338b474910f7..9e4471f68165 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -229,6 +229,8 @@ ret_from_syscall:
 syscall_exit_work:
 	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
 	bnes	1b			| if so, skip resched, signals
+	btst	#4,%a1@(TINFO_FLAGS+2)	| TIF_FD_SLOTS: commit descriptors
+	jne	do_trace_exit
 	lslw	#1,%d0
 	jcs	do_trace_exit
 	jmi	do_delayed_trace
diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index 4575f6487a9a..07103e6ddeb0 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
@@ -289,6 +290,8 @@ asmlinkage int syscall_trace_enter(void)
 
 asmlinkage void syscall_trace_leave(void)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(task_pt_regs(current));
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ptrace_report_syscall_exit(task_pt_regs(current), 0);
 }

-- 
2.53.0


