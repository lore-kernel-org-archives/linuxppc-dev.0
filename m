Return-Path: <linuxppc-dev+bounces-27342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8888FC982C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfzK4RCcz30VV;
	Tue, 15 Sep 2026 21:33:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472013;
	cv=none; b=nhVYq0JPql61U+t/1ATz+FBk0kq0YbtGnOJdWf5PLCR7BhnauMmFshX1ATjRaodeLTiQCb73LJA7f1MUEYzrClgf1IbQerQ6SQdk8ccZ6QE9o+MJcxpuukXo+gj1+/hkALqiIATB+DxQZySp13CzAvwO8BPiDph1PSlNqowN1zjHUqgypGrxuC9udWTJBLsvH9byJMFnDxjIPxowkJmLw4HZqzc7E9qvQ7b3rBz3nHEqj8m1GjMpcHtbA0qKOWrvmCbmAbfJ+GCIvTRte6qZpwIs6AO7+Ivd7SrLVDFvEO8ZAco3v73JKYO5IMEUBssDLiZuZqeJDWoe+1YGL5q2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472013; c=relaxed/relaxed;
	bh=LsNpEFA01NMLmoDGH+WQ2k5w2caYKI3aFXCKnW6fq4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Itou2EGMSofBAsU1HWC7g3/QtFck0Tf8dbJpHED6w2ftMK8/0iTcbt0z04TkTwEyCVhgTPuGsKkSnfdPoFjwnUN2b3x7ww6b12xqYHxGyOa3pHJ+UhZIlqE8H4sZ358ftmJixGXQxidguv12dcwX2Zuh8hw5NqwIcnUVNlYqTT0HV4qimDMDI4+rpgS4rP9+/qKTv1kp95K8+KNZgoZKR0DnFK2RJVWkjbWL01BB77P3kxmoM9HZKuKMFAUlJ5yXhATPQiaDfy5fCD7D+hG7uE732P8kgCrnH3XiabTwbAeo/bShPxNe+tBKENPqehP+ppj6+ddp1EGbWtIufdm1bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUmSavNi; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUmSavNi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkfzJ5LRHz30VT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:33:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 432C0437CE;
	Tue, 15 Sep 2026 11:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8D71F00898;
	Tue, 15 Sep 2026 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472011;
	bh=LsNpEFA01NMLmoDGH+WQ2k5w2caYKI3aFXCKnW6fq4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jUmSavNiamqp7sEiSGUpt1XZfKBJkPkcG/PFCGuuE8ULC/JC+9Uv/jivWwgpx6a/O
	 ndFuFYQRnEyeD6+NTxQCHA1WQfYk7Jmw39axkxPneZ0ZlWHflWnPtQntegHAjSQOHr
	 qvPuy2KIMTAU8QpGMIZajMcBNJZLx1KDydcGwu/7Fq4Sm2suht1GMp/5OShBghjByJ
	 Wo0vc/D/MORpmKTNOKDNlY4+TTriFUPTu4Y02yC+j0UyASaEIruvlKlSwBV+MXdIZL
	 vi9GUupn2o56nWtYus7diY/kBIvVMBlvyHSKLH2hV7NTFX1VBgWRv0lAAGJXCHoiGT
	 eaCHwlU6HAvXg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:03 +0200
Subject: [PATCH RFC POC 17/50] um: commit fds on syscall exit
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-17-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S9sXo+/yQO9aORTIGU5zP9aw99mbVPSatnA1JIW5H/M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KldP/NzGWPyQ7vZ1w8Z91Y4Xry4dOW/w5ekHD1Nn
 i1f3lHo1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnzMY/tdevWsc17Pol1js
 drW1Ndl3Uj4rJ6jNqM1Qvbkzdcr/kFkM//PT/U4ukVght9Iz6NLyeqmVG29b1dz/x+3x4GR56M6
 Uan4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS. handle_syscall() calls syscall_trace_leave() after
every system call, so test the flag there and commit the reservations
before audit and the ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 7a6f4dc99fa1..7140516ee0b6 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -44,6 +44,7 @@ struct thread_info {
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SINGLESTEP		10	/* single stepping userspace */
 #define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
+#define TIF_FD_SLOTS		12	/* syscall prepared descriptors */
 
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -55,6 +56,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL | \
 				 _TIF_NOTIFY_RESUME)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 7da0a5223aa6..f1f89181fb7e 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
@@ -142,6 +143,9 @@ void syscall_trace_leave(struct pt_regs *regs)
 {
 	int ptraced = current->ptrace;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	/* Fake a debug trap */

-- 
2.53.0


