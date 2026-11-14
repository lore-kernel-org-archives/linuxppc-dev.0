Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B41606A8AF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=r/BUEFN3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRj8J5t8Dz3c85;
	Sun, 15 Nov 2026 05:19:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794680384;
	cv=none; b=BFfu1MvkXfFXwIF1DscVxytnm/KbbhmQs8CPDgqVPnFyQrhaB3cT1zGvPKwdBBKUmopRe1Dg6Rj2N8HuVKTPxIG7Rl499H76n12A6YsqwsN72J7oKxevV6BBA4/Ro1BocGCjrghx1X4RhQ53d6Z7dOxCTrUqqLgZv935nZ56P8HFJMtKrtTXDcUO/d5h964xT0sx3skk7WFWZTrJ1YDjfL8R0Rod2F57XLv4A2m436+Z79ay3JV2zN1dEccwCVu0LtjPlPUzHFjyEfi6L4/v6HTD1WXt72jLwV4efWWkDx600NZkluOfW4l0Zl90697trfj3mDaW331v8XeglSkppw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794680384; c=relaxed/relaxed;
	bh=8oBfLZwpv/eoCOouXMcqz9arLxlB4tNECMdtXo018iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMyK2wzvFuWe7EkmfrbxMIi58Af0XShE7UUNv1+ORJINm8H7I/0KQ+wE6l3ScKET6RZHyY9DC1xBqE5schgta0tSB1afQD9l8zpZ9mh/X4XxnZ+kKQa2m7ajLwTDsAplNQL/YHhNGelzHI+8jA7cXutMfKqEXWGNQqynQUdlsAt1dR9FNU/zgJCCfcmNIg9uxiTGyOKhyTwrjistZ1rfA5PlRtDUae4qYIy2zlW2Cvx9oOy2R2ggF354xtH3z3hd66elMlD8azIdIKVs2dGfERZZy/yh2/y6rBd2j0wI8zXDt3DYu1rLjDztL7q/qJVl1viiU+NFq9L/C7qks8tmKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=r/BUEFN3; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=r/BUEFN3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRj8F3Q59z3c5M
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 05:19:39 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 5C6261C025E;
	Sat, 14 Nov 2026 19:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794680377;
	bh=g7Apg1OBV/LXyn2CMuiTxd1+ckmMVyFB32J11ItkIOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/BUEFN3g+e1tPE1F/WZU45cdCm4VBkkYqCWFysuVE5n+ItS0Pi3u3ZkImdimkrc2
	 qfLm1N4dttTWIMsLoFdMHJPvdb/qbhJhMU/57PEdg9fWVD+plvc6CeLs/3mvM2Dykn
	 hdu16fLYWtzKhM08RCg9nuOgvi7ESPCzoHjarvdI=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Oleg Nesterov <oleg@redhat.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io
Subject: [PATCH v11 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
Date: Sat, 14 Nov 2026 19:19:21 +0100
Message-ID: <20261114181923.370930-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114181923.370930-1-renzo@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend PTRACE_SET_SYSCALL_INFO to support skipping a system call
triggered via seccomp.

When a tracer retrieves a ptrace_syscall_info structure with 'op' set to
PTRACE_SYSCALL_INFO_SECCOMP, it can now choose to skip the system call.
To do this, the tracer changes 'op' to PTRACE_SYSCALL_INFO_EXIT and
populates the exit union fields (rval and is_error) to define the return
value and error status for the tracee.

The skip request is passed to seccomp with seccomp_ptrace_skip_syscall()
rather than by setting the system call number to -1, so that it does not
depend on how the architecture lays out the syscall number and the
return value in the registers.  The tracee then skips the system call
the same way as for SECCOMP_RET_ERRNO.

Once the system call has been skipped, PTRACE_GET_SYSCALL_INFO reports
the stop as a PTRACE_SYSCALL_INFO_EXIT one, as the return value may
already have overwritten registers holding the syscall number or
arguments.  Accordingly, a further PTRACE_SET_SYSCALL_INFO with op ==
PTRACE_SYSCALL_INFO_SECCOMP during the same stop fails with -EINVAL,
while op == PTRACE_SYSCALL_INFO_EXIT can still be used to change the
return value.

System call suppression via PTRACE_SYSCALL_INFO_ENTRY is currently not
implemented.  On some architectures (e.g. MIPS), when a system call is
skipped by setting the syscall number to -1 at the entry stop, the
architecture entry path unconditionally overwrites the return value
register with -ENOSYS, clobbering any custom return value set by the
tracer at the entry stop.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
[v8: skip via seccomp_ptrace_skip_syscall() instead of syscall_set_nr(-1),
 separate ptrace_set_syscall_info_seccomp_skip(), reject later
 PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop]
[v11: report the stop as PTRACE_SYSCALL_INFO_EXIT once the syscall is
 skipped, instead of rejecting PTRACE_SYSCALL_INFO_SECCOMP explicitly]
Assisted-by: claude-opus-5-5
---
 kernel/ptrace.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3f2fe68ccb14..ab6f5dab0223 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/seccomp.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1010,6 +1011,14 @@ ptrace_get_syscall_info_op(struct task_struct *child)
 			return PTRACE_SYSCALL_INFO_NONE;
 		}
 	case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
+		/*
+		 * Once the tracer has skipped the system call, the stop is
+		 * reported as a PTRACE_SYSCALL_INFO_EXIT one, as the return
+		 * value might have overwritten the registers holding the
+		 * system call number and arguments.
+		 */
+		if (seccomp_ptrace_syscall_skipped(child))
+			return PTRACE_SYSCALL_INFO_EXIT;
 		return PTRACE_SYSCALL_INFO_SECCOMP;
 	default:
 		return PTRACE_SYSCALL_INFO_NONE;
@@ -1119,12 +1128,35 @@ ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
 	return 0;
 }
 
+/*
+ * Skip the system call at a PTRACE_SYSCALL_INFO_SECCOMP stop and set its
+ * return value as specified by info->exit.
+ *
+ * The skip request is passed to seccomp out of band instead of by setting
+ * the system call number to -1: on some architectures the syscall number,
+ * or the register seccomp reads it from, shares a register with the return
+ * value, and on others -1 cannot be represented as a syscall number.
+ */
+static int
+ptrace_set_syscall_info_seccomp_skip(struct task_struct *child,
+				     struct pt_regs *regs,
+				     struct ptrace_syscall_info *info)
+{
+	int ret = ptrace_set_syscall_info_exit(child, regs, info);
+
+	if (!ret)
+		seccomp_ptrace_skip_syscall(child);
+
+	return ret;
+}
+
 static int
 ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
 			const void __user *datavp)
 {
 	struct pt_regs *regs = task_pt_regs(child);
 	struct ptrace_syscall_info info;
+	int op;
 
 	if (user_size < sizeof(info))
 		return -EINVAL;
@@ -1141,8 +1173,21 @@ ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
 	if (info.flags || info.reserved)
 		return -EINVAL;
 
-	/* Changing the type of the system call stop is not supported yet. */
-	if (ptrace_get_syscall_info_op(child) != info.op)
+	op = ptrace_get_syscall_info_op(child);
+
+	/*
+	 * Changing the type of the system call stop is not supported, except
+	 * that a PTRACE_SYSCALL_INFO_SECCOMP stop can be turned into a
+	 * PTRACE_SYSCALL_INFO_EXIT one to skip the system call and set its
+	 * return value.  Once that is done, the stop is reported as a
+	 * PTRACE_SYSCALL_INFO_EXIT one, so only the return value can be
+	 * changed anymore during the same stop.
+	 */
+	if (op == PTRACE_SYSCALL_INFO_SECCOMP &&
+	    info.op == PTRACE_SYSCALL_INFO_EXIT)
+		return ptrace_set_syscall_info_seccomp_skip(child, regs, &info);
+
+	if (op != info.op)
 		return -EINVAL;
 
 	switch (info.op) {
-- 
2.47.3


