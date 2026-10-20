Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2560A263F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=veAqQRvm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8GZ459DJz2ylj;
	Wed, 21 Oct 2026 02:30:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792510204;
	cv=none; b=gAO4g3nDxYxgYj4DQNRl/yPqcC5C6K/JzFtMypJsPFSA1s75iGvqmlhWDIdcDTXe8lr7CZE5MnIRfanu4gH85OSzCPZasYJCnfJU7LWFSxQtAdAmTYO/EyEBGyI99ypk3+4lXIRhXNT735wqDZf9+ICk5QWsSpmT0zq/lRIA9QCLdwptztcPW3X/sz+Ejdi+BVpUyzfc/eYS7VcBGf3Zb6kMusqoBW1Mca7e2NLNXyOu/B+j1J1TlwLgkHtNslBxxnoBMme7xhADqGj3MTm5fSyzskV/mAMwOiwSVnw1HTmZQhjoymYy23HI7e36+ffSInTlf+iDshb+YHUqltTH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792510204; c=relaxed/relaxed;
	bh=X7li7zppPfXAQDWIziNGfnEjMbFeJImmkhr9aLqumbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNTNDVg8YVuiIZyYTen6Hz4xPuC8PnVR8C8Z8DnLNYDl5bDXie+U8qezVJwDMvIU83eCjaog+cne2WWjjxd1NQ2ZAmmq9DKuD8nvMCmAxgg4jdOLrLlF9AhGeVBal85dEqEbu4qMs5DsvPgfra2l+yRo0CpftAEta8RrscguDP6DEUcvDFdJL2kzwBJzJWGzvUmlx0FQs0SdNFTeJ5zOJX6qVBcMUKta6NOz5fh6MG+mhV6VlOG5B8O3qMmLUQv2jdQqXzUOzqQbf6MdaY5MvcpJ+yqWFF0Blyc0zubrTm9By0o36TYdve+4rd/Tu41ELQ6/OtjuCtbKG7AAU4ZDWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=veAqQRvm; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=veAqQRvm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8GZ170TVz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 02:30:00 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 9DA8B1C0251;
	Tue, 20 Oct 2026 17:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792510198;
	bh=kecThFQauD5pORZjNAwNTrsBZzkWTRHw2R4hetODibc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=veAqQRvmf/f/cYUdyAWyB4Uey00XfxCpUsln+jiOijpHEIBrVJuv+RtjR0x4kDt6w
	 A3lZBmvae+xZhBiEc09i4SGQKNhlX6qNQnKOvja3s485mwJHbIPTRUE2i6450E8YSO
	 hZDqpGJbM0+fIPAbmM/JLGL8n89otuV1JnruMC+E=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Davide Berardi <berardi.dav@gmail.com>,
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io,
	Renzo Davoli <renzo@cs.unibo.it>
Subject: [PATCH v9 1/3] seccomp: let the tracer skip a syscall independently of its number
Date: Tue, 20 Oct 2026 17:29:41 +0200
Message-ID: <20261020152945.575664-2-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020152945.575664-1-renzo@cs.unibo.it>
References: <20261020152945.575664-1-renzo@cs.unibo.it>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Davide Berardi <berardi.dav@gmail.com>

At a PTRACE_EVENT_SECCOMP stop the tracer can only skip the system call
by setting its number to -1, which seccomp reads back with
syscall_get_nr().  This depends on how each architecture lays out the
syscall number and the return value in the registers:

 - on some architectures the syscall number shares a register with the
   return value (e.g. v0 on MIPS), so setting the return value after the
   number would overwrite the skip request, and each of them needs its
   own way to keep it (MIPS keeps a copy of the number in thread_info);

 - on s390 syscall_get_nr() returns the low 16 bits of int_code, so -1
   is read back as 65535: seccomp does not skip the call but runs the
   filters again on syscall 65535, which kills the task if the filter
   denies unknown syscalls.

Add a per-task flag which the tracer sets with
seccomp_ptrace_skip_syscall() while the tracee is stopped at the
PTRACE_EVENT_SECCOMP stop, after it has set the return value.  When the
tracee resumes, seccomp skips the system call like for
SECCOMP_RET_ERRNO, which every architecture already handles without
touching the return value.

The flag is cleared by the tracee before the stop and written by the
tracer only while the tracee is stopped, so it needs no locking: the
wake-up of the tracee orders it like the registers written by the
tracer.

The next patch uses this in PTRACE_SET_SYSCALL_INFO.

Suggested-by: Michal Suchánek <msuchanek@suse.de>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 include/linux/seccomp.h       | 33 +++++++++++++++++++++++++++++++++
 include/linux/seccomp_types.h |  4 ++++
 kernel/seccomp.c              | 11 ++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index fcb3eb9825e5..ee31857f3ba6 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -75,6 +75,32 @@ static inline int seccomp_mode(struct seccomp *s)
 #ifdef CONFIG_SECCOMP_FILTER
 extern void seccomp_filter_release(struct task_struct *tsk);
 extern void get_seccomp_filter(struct task_struct *tsk);
+
+/**
+ * seccomp_ptrace_skip_syscall - make a tracee skip the current system call
+ * @tsk: tracee stopped at a PTRACE_EVENT_SECCOMP stop
+ *
+ * Must only be called by the tracer of @tsk while @tsk is stopped at a
+ * PTRACE_EVENT_SECCOMP stop, after it has set the return value of the system
+ * call.  When the tracee resumes, the system call is skipped and the return
+ * value is left untouched, like with SECCOMP_RET_ERRNO.
+ */
+static inline void seccomp_ptrace_skip_syscall(struct task_struct *tsk)
+{
+	tsk->seccomp.ptrace_skip = true;
+}
+
+/**
+ * seccomp_ptrace_syscall_skipped - check for seccomp_ptrace_skip_syscall()
+ * @tsk: tracee stopped at a PTRACE_EVENT_SECCOMP stop
+ *
+ * Return: true if the tracer requested to skip the system call during the
+ * current PTRACE_EVENT_SECCOMP stop of @tsk.
+ */
+static inline bool seccomp_ptrace_syscall_skipped(struct task_struct *tsk)
+{
+	return tsk->seccomp.ptrace_skip;
+}
 #else  /* CONFIG_SECCOMP_FILTER */
 static inline void seccomp_filter_release(struct task_struct *tsk)
 {
@@ -84,6 +110,13 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
 {
 	return;
 }
+static inline void seccomp_ptrace_skip_syscall(struct task_struct *tsk)
+{
+}
+static inline bool seccomp_ptrace_syscall_skipped(struct task_struct *tsk)
+{
+	return false;
+}
 #endif /* CONFIG_SECCOMP_FILTER */
 
 #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
diff --git a/include/linux/seccomp_types.h b/include/linux/seccomp_types.h
index cf0a0355024f..4bdb8424055b 100644
--- a/include/linux/seccomp_types.h
+++ b/include/linux/seccomp_types.h
@@ -18,11 +18,15 @@ struct seccomp_filter;
  *
  *          @filter must only be accessed from the context of current as there
  *          is no read locking.
+ * @ptrace_skip: set by the tracer while the task is stopped at a
+ *               PTRACE_EVENT_SECCOMP stop to request that the system call is
+ *               skipped, after it has set the return value.
  */
 struct seccomp {
 	int mode;
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
+	bool ptrace_skip;
 };
 
 #else
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 86cf4460d69e..edeb21fa3e23 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1306,6 +1306,7 @@ static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		}
 
 		/* Allow the BPF to provide the event message */
+		current->seccomp.ptrace_skip = false;
 		ptrace_event(PTRACE_EVENT_SECCOMP, data);
 		/*
 		 * The delivery of a fatal signal during event
@@ -1319,7 +1320,15 @@ static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		 */
 		if (fatal_signal_pending(current))
 			goto skip;
-		/* Check if the tracer forced the syscall to be skipped. */
+		/*
+		 * Check if the tracer forced the syscall to be skipped, either
+		 * with seccomp_ptrace_skip_syscall(), which does not depend on
+		 * how the architecture encodes the syscall number and the
+		 * return value in the registers, or by setting the syscall
+		 * number to -1.
+		 */
+		if (current->seccomp.ptrace_skip)
+			goto skip;
 		this_syscall = syscall_get_nr(current, current_pt_regs());
 		if (this_syscall < 0)
 			goto skip;
-- 
2.55.0


