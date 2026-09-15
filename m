Return-Path: <linuxppc-dev+bounces-27335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA90C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:32:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfyJ2Krkz30RT;
	Tue, 15 Sep 2026 21:32:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789471960;
	cv=none; b=Azx50gGlewYylyV7SE3+jVzw+DXrzALyo2uj/jx5CzCCKaWUDJzITzTiLYaI4fb6JZPElIvmVkwK5Bo1TIpXrzJRl4BT2yfW3AxQzLail6hDsMQH8S8F8t4BW5O3lHcjTTSBqjv32S3aWezKADrat2PKWup+xFsSJ8P/nhCLxleG0Im+kAx1iA0jNlLbhmGjwBRqeJLTglBLtQoqVPS4puxX/bYoyEQbqGnPH+ryKPuP+R1ggPkzRGl2uq6awa8LcOS5c4Y+lkQfdVsZ5kre7AZcPKnat2CFS5ACx2Znw9QIkLJUF0K9loygrI4qAWsvCPD38Dm83s7GxuWjpBY2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789471960; c=relaxed/relaxed;
	bh=tg5h99+rXwPUOCpAK+cpKxSGhPsqw2qIAApb6RMTrZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg0NqtxrHG0mvjVPE9yEXR4DdJWL7qUxAIJ/l4DtvzudHzn7n9z29UnsLxp2mAPqhVEmfgQmAEgyJwBOqZxqPe0Au+C31/XulnefTLeaPJ+i32fQ0SdYhfkbAUyvDMEsXfnzjqcmXqoAlbBIXpvzWhKy1W8vxaRxofCYorZ5xDMHUOPmqAHLXBxLl8pqEq/vNk1O3mE706AqgCFP36gV2676K1rcGgklQenrOOrGQyN7NcYdmSh7Un3wSyB1JeHEbz+BUjjcPCgB0IR0ZmwiEBFB4uOdG1ziiHkkQdKWRmAthYDvcFENALj8B22cg1zvpMV+0npSHY31ku6+mTU5pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOdqCs6F; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOdqCs6F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkfyH3W8rz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:32:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D114043CB1;
	Tue, 15 Sep 2026 11:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726AF1F00898;
	Tue, 15 Sep 2026 11:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471957;
	bh=tg5h99+rXwPUOCpAK+cpKxSGhPsqw2qIAApb6RMTrZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SOdqCs6FFc+m85zKG65RFoiI3OX0TKhMSKuOGs5mjQ4eozA6DlIsvYCrD/FPZMCya
	 K5qpA/W9zCpRVyaXCWr3ds/VJdxhjZpyZLD3Mkij4zr7pNA3EzYnKrukqu7tQxRSqi
	 awcZPh3/KgPK/8y13mc/r6QIcT0xahYOLE6UWC72R99aPngllw7ccPTc2jgUwYcOi7
	 U74GTjJbNoQ41gpF7hzYmntvuz0kqC5olR/d01x9OdjbXM1vPyPMxQK1LCxZgEa3FG
	 WTQ0xmcaX8BwZ3dvqAm6+xxz2psYUrOreD8islOMqgvBbrNJc0rwt/o9saf69osrsb
	 1/GNM2HBy3hbw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:56 +0200
Subject: [PATCH RFC POC 10/50] microblaze: commit fds on syscall exit
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nXh3DWWigUzaDKpK2QrpbR3RoNJlzLOS8WiJE98yT14=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnZ7yrddCzxyY2/Tpa2vz6x/Nq//Y/DVseZ581KJ
 U5sMTtwtaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiZXcYGfaG5Cl1dp6Z4vGN
 heGfRKcz571g7fAA9V1NlYVnC00jGBkZbjv+T3n9aZpP9I+Lez8pxBz2mPT/3UPhvvRP08XYkut
 MuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS to the syscall work mask. The return path rereads
the flags after the system call and calls do_syscall_trace_leave()
for any of them which commits the reservations before audit and the
ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/microblaze/include/asm/thread_info.h | 5 ++++-
 arch/microblaze/kernel/ptrace.c           | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index 0153f7c2717c..ee2f76589696 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -103,6 +103,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		4
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
+#define TIF_FD_SLOTS		7	/* syscall prepared descriptors */
 #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
 #define TIF_SECCOMP		10      /* secure computing */
 
@@ -118,10 +119,12 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 /* work to do in syscall trace */
 #define _TIF_WORK_SYSCALL_MASK  (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
-				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)
+				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
+				 _TIF_FD_SLOTS)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK		0x0000FFFE
diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 236264e932d6..e6951fea8593 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -156,6 +157,9 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	step = test_thread_flag(TIF_SINGLESTEP);

-- 
2.53.0


