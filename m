Return-Path: <linuxppc-dev+bounces-27338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A592C88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfyl1gdtz30TY;
	Tue, 15 Sep 2026 21:33:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789471983;
	cv=none; b=ZTdjaaLipEkw44g342nhOQUqh+L8hR6YHLW6wxLReXyCNCShP/VEWw/xFv0y4KlRU7QeeFHrZk/5ig3UwyRiXCbWyEW7d0CQJ5DFgcORdp2ESD4h2WNq91tJbtFQEUuLjRvh2q/tsuViD75ZqJ8ANay/euUZSKsqAEp9dtWKKZtCJwWHQ9rZYemBldIRUTu/6D7/OlJDM603oHA+yJBcA/7mikrUO1N8fTOthRtivyYspwjI3ZVetqV/eNrlZFKI+Ezj0yt0Cd1RDcyBwf/C/nBr7r/jkrSPpbMg/8Dbr45pLj5zKMFb+MdTIcGbg9rpdfD2i3yT4be5kngYA2j9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789471983; c=relaxed/relaxed;
	bh=ieBZ+PGa/U2dHjvXYIOcBUNNdmn+mkwIOuOFCXOxPNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACo2pQZUI5fTELTkuP0jT9NxSE0n3T0oNvZ8wsaW0NPWVJoHnpjrfL8KTuHTMykFHyl3uFUVtpqck1o/pxFjoMlqjA6LuNJ/Ry1kQb7iujcXTBlKv5Mqn3Lmf7ANvyBu8jLpQUV1coLtP+IWutZh4rWcLMc4CD37Mb//G7O6MGpn/xoyNTf12lnT3oxRx46TiEmLg/YjUeB1JNkG4GVztQLBnqsAbcC4scX86ooAv5FF30UppwkgBSuAufItcXurvJArjCmEcM7eRzFg5QHBNb419UrFh8tGq5uHkxqIwkzGYdaiJtZg0zs+feIPZNW5mFV9l8ZNsg5VI+d0LaMkbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lW4XDrSS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lW4XDrSS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkfyk2MXlz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:33:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4555415D0;
	Tue, 15 Sep 2026 11:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C55A1F000FF;
	Tue, 15 Sep 2026 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471980;
	bh=ieBZ+PGa/U2dHjvXYIOcBUNNdmn+mkwIOuOFCXOxPNU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lW4XDrSSE4zqGk0C0CruQFmX6so8N2FOL23Fl09c5bnPSxQl0BFCz51k8cI+0dFfJ
	 dXQThH7z1OdW1butHdlIf/Qob4isTZGHfU/nhc+unhvj37uVwPwqTZHeYk/FuGa0RN
	 aDMtnc4VxYzhvYriaex23gOScyvu/sWWOUrxEFEJ+nQmrms5SkE4/CUmg2GfphSCuj
	 JXVFYRknoQ6WmHDbHxR3xnX/Fm8hP0qkS8zTMO9w9Kxgckeg/VeZIeJThmFkiQBpT6
	 FVu61jYIIv6ceWPTvf1QMFe5gj978J8MMjetxPLjPfZjoZhoGLBPKY5OnkDnZixiDS
	 91SUSK7z6ECBg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:59 +0200
Subject: [PATCH RFC POC 13/50] openrisc: commit fds on syscall exit
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-13-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WIP/DigF70AMhhxkwNBY6vdiLcTH+iv+tPMUDAZ9Ays=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kn9GjAhwFHx+sY/XeefqrdOfq2R3HC8f2v+1Q5lg
 UcXTzCZdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkAiMjw2k/PoanKkdD5bZf
 KxfaVXVqje/CGY+/+MbO+vL4QxvPmgRGhoe1GR3WZn18c8xOi7JUnRHY2W96ZGnXoxWdvoqFr4M
 SOQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it together with TIF_SYSCALL_TRACE on the
way out of a system call. The check used to rely on the flags r30 had
been loaded with before the call. Reload them. The syscall may have set
the new bit. A task that reserved descriptors calls
do_syscall_trace_leave() which commits them before audit and the ptrace
exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/openrisc/include/asm/thread_info.h | 5 ++++-
 arch/openrisc/kernel/entry.S            | 5 +++--
 arch/openrisc/kernel/ptrace.c           | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index e338fff7efb0..3d8a710a809d 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -92,6 +92,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
 					 * mode
 					 */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_FD_SLOTS		6	/* syscall prepared descriptors */
 #define TIF_SYSCALL_TRACEPOINT  8       /* for ftrace syscall instrumentation */
 #define TIF_RESTORE_SIGMASK     9
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling						 * TIF_NEED_RESCHED
@@ -104,12 +105,14 @@ register struct thread_info *current_thread_info_reg asm("r10");
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 
 /* Work to do when returning from interrupt/exception */
 /* For OpenRISC, this is anything in the LSW other than syscall trace */
-#define _TIF_WORK_MASK (0xff & ~(_TIF_SYSCALL_TRACE|_TIF_SINGLESTEP))
+#define _TIF_WORK_MASK (0xff & ~(_TIF_SYSCALL_TRACE|_TIF_SINGLESTEP| \
+				 _TIF_FD_SLOTS))
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 18e68680471e..c70265c4fe55 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -701,10 +701,11 @@ _syscall_show_regs:
 #endif
 
 _syscall_check_trace_leave:
-	/* r30 is a callee-saved register so this should still hold the
-	 * _TIF_SYSCALL_TRACE flag from _syscall_check_trace_enter above...
+	/* Reload the flags, the syscall may have set TIF_FD_SLOTS.
 	 * _syscall_trace_leave expects syscall result to be in pt_regs->r11.
 	 */
+	l.lwz	r30,TI_FLAGS(r10)
+	l.andi	r30,r30,(_TIF_SYSCALL_TRACE|_TIF_FD_SLOTS)
 	l.sfne	r30,r0
 	l.bf	_syscall_trace_leave
 	 l.nop
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 287a9718f0c6..71614b36e516 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/string.h>
@@ -311,6 +312,9 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	step = test_thread_flag(TIF_SINGLESTEP);

-- 
2.53.0


