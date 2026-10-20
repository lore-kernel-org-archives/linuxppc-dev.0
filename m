Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316C606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aD/pTPV3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j83BG0xlYz2yr0;
	Tue, 20 Oct 2026 17:57:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792479429;
	cv=none; b=Q3I/HssX97eD8FA8cOZ2jSNm7hzYRpCT7TC+i8JR/x0ERoiJm3Gn8+3+IT9bs5x96asFx0GFKW+rUYt52ojmamW1pOAq4F6VJ2UPPYxupdT6rJRoJ3oqd7X2abiWZN7eumgIAqzMbSqX2qndj7WAfj78+OtxS+Y48nDo7BxFH9J5sHa2lfAvCqxEmcXEuGFNyQ7uSYQeWKlb/WMTWX1u8gH8AgPxtQ3BNhy3E0V2wkfHE20SeMwFxhJM7nvVdNoJpAzLjXyqzzrZz1hdGpLL/tnPcYal2M6xWb7kproGhBlN33kLJUclm4s+afUmMz0hqzDPcbwasjRI7EHOXY9rew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792479429; c=relaxed/relaxed;
	bh=TUmyFYYtU5y2RV1uj+bzgwDMTfwhMJbH7+T2VkwKhwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh/0YBDOqQtWrPnfXbdsvBbKnT1XEF/a0gXfH45nb1hrFExaEVWmb9RiduVj+57Kqa00hTHJwFUKKwQ63yQVyLEXs8hox/G0623sbAjUEefKZ4U/W6+2ox6KZ2T9BSMSsljSZ6xqPGwjnRZaEu/luyum7WXNF7wNE9GoG2g5UDvpDl0cFbIiT2W8lXE24unNOdQoG31tTbjFBBoAjxU1xAUhO/Y8lOXoSYJPivUU77HZ00hpqRiuljH516hU2YqNO9VCZ2KOXGok7ciUFlklMParqf2UmwUDGsfk2gPnbiSzaR1dTCGR2Bj47LvceLAf0hWmfbTcJ/epF7lsqZ5+Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aD/pTPV3; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aD/pTPV3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j83B972c0z2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 17:57:03 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 30FFE1C025A;
	Tue, 20 Oct 2026 08:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792479421;
	bh=GKcVaiJ2uWs3/U/oO7CqqD6I8S0OT2zFALYg4nGKvh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aD/pTPV3X+R7HoHeYW+R6GsVuGiIZQ+RS8fuyuaJ3Z66tJBMmtZ888SJgY8IkG+vP
	 +i9TEB2JutNl7Sxw3rCnCEUr6Q+pznvoNYp07GybDQ5uDFr4lWQqswsE8NcGrkd6h9
	 7YzISdSOjEDeHY2a3YjQf76Id09ytT9PZUf4Fhj8=
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
Subject: [PATCH v8 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
Date: Tue, 20 Oct 2026 08:56:32 +0200
Message-ID: <20261020065635.490528-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020065635.490528-1-renzo@cs.unibo.it>
References: <20261020065635.490528-1-renzo@cs.unibo.it>
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

Once the system call has been skipped, a further PTRACE_SET_SYSCALL_INFO
with op == PTRACE_SYSCALL_INFO_SECCOMP during the same stop fails with
-EINVAL, as the return value may already have overwritten registers
holding the syscall number or arguments; op ==
PTRACE_SYSCALL_INFO_EXIT can still be used to change the return value.

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
Assisted-by: claude-opus-5-5
---
 kernel/ptrace.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d041645d9d17..e02434c30d4e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/seccomp.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1119,12 +1120,35 @@ ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
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
@@ -1141,8 +1165,25 @@ ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
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
+	 * return value.  Once that is done, the system call number and
+	 * arguments cannot be changed anymore during the same stop, as the
+	 * return value might share registers with them.
+	 */
+	if (op == PTRACE_SYSCALL_INFO_SECCOMP) {
+		if (info.op == PTRACE_SYSCALL_INFO_EXIT)
+			return ptrace_set_syscall_info_seccomp_skip(child, regs,
+								    &info);
+		if (seccomp_ptrace_syscall_skipped(child))
+			return -EINVAL;
+	}
+
+	if (op != info.op)
 		return -EINVAL;
 
 	switch (info.op) {
-- 
2.55.0


