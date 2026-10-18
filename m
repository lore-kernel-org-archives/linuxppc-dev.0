Return-Path: <linuxppc-dev+bounces-29671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B327ECCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 21:34:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Bl75FQRz2xjP;
	Mon, 19 Oct 2026 08:34:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792336959;
	cv=none; b=I0XNhYp/SP0qmbZOnK8r7fSfkIwu5PWRLCDVfV/D6rUvyjC2eV/CG7nfJsEOm5NbMdwWYpv4IMx/SmB36uYYwjdv8GAXW2pcjIJRGyr9OdrFTxgc1L9dP9r/EUnU+F5IJ2OHp+VtDWS596pZ04XUxRRbghlsXmjrOJCZgBZMjIeuEPvC66xCwW0F0YxDyvk+kukl+9ttaRcjfd/mv84CS+VYb1Y93oBIBeFErG/aJ/kLIQ6EZ4As++FIshlIjbqLjugRXEMyuPvtl8kJlhN0glOAPQWw70lQdNVxIr1PDMyLcHv0J/3hSTUtKv+ylTjIEQKONtJdaxjAq7yBEIT18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792336959; c=relaxed/relaxed;
	bh=oWVkNLyxBpVR94z8Hp4DT7djOI+cUXbDcO0ARHoPGJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9Ug08DfqJjIrFV91J2r09Md8/FOJYFZ8pZxxaQVqYEwF7MXnPKtrEanD2f7eI91aaQcHlldX/GISjw7sKM5KEwiIMijA6/DHRfytqebEmQApgvf0Umd8DukqsE9xTCUtp1wJiE+dq7sH9U30z4uI2VpPmVmgrszKdJOKBg+ChKPI6zjvexK1AJRM9nND5vBI7Kgy4/ldpXRJBagE/faVGrZKvhVfLC10gZqexfGbQhtg8KouJzMrjbfKCw1pNvEuK6obyPsTaDsqjsEFw0JvqrpTnXtx7sK+Stkowhg3YslNIso+IELjCekZGyO1McmI0buNm4umMdVJPhLPR07NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=QRZr3vKy; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=QRZr3vKy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
X-Greylist: delayed 396 seconds by postgrey-1.37 at boromir; Mon, 19 Oct 2026 02:22:35 AEDT
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j72VM5zRlz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:22:35 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 23A301C007A;
	Sun, 18 Oct 2026 17:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792336553;
	bh=P13TJoe00kc6udm3KCSaNvlrXfjrcNvar4DnoqMgWKs=;
	h=From:To:Cc:Subject:Date:From;
	b=QRZr3vKy+trCv6l5OJFuzXmy9KjgkCb/g2dhU2mUOi69UPm04Ge6W0xED+Cvoulp8
	 LUPfGbKjKJaU//TOScNm72qH1AqHFcRyWEjNtcOOW4D8VH6d7uV0pdPTxMlv/PYHhv
	 r7oB7qvVdlTx0gw82MNVEx3ZZ8EU1SwgqRX7Y04k=
From: Renzo Davoli <renzo@cs.unibo.it>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Davide Berardi <berardi.dav@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Renzo Davoli <renzo@cs.unibo.it>,
	Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerpc/syscall: Return the preset value of skipped syscalls
Date: Sun, 18 Oct 2026 17:15:33 +0200
Message-ID: <20261018151539.440213-1-renzo@cs.unibo.it>
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

From: Davide Berardi <berardi.dav@gmail.com>

When ptrace or seccomp skip a system call, the return value they set in
regs->gpr[3] gets lost or the tracer is affected, since two recent
changes:

1. Commit 05c033db7e9a ("entry, treewide: Make
   syscall_enter_from_user_mode[_work]() indicate syscall execution")
   made system_call_exception() return syscall_get_error() for a skipped
   system call.  syscall_get_error() is 0 for any non-error value, so a
   success value set by a tracer at a PTRACE_EVENT_SECCOMP stop (e.g.
   with PTRACE_POKEUSER), or by a SECCOMP_RET_USER_NOTIF listener, is
   replaced with 0.

2. Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
   seccomp and ptrace") made syscall_set_return_value() set
   TIF_SYSCALL_RET with set_thread_flag(), i.e. on current rather than on
   the task passed in.  When the caller is a tracer, as in
   PTRACE_SET_SYSCALL_INFO with op == PTRACE_SYSCALL_INFO_EXIT, the flag
   ends up on the tracer, and the next system call of the tracer is
   silently not executed.  Setting it on the right task would not be
   enough either: at a syscall-exit stop the flag would then skip the
   next system call of the tracee.

TIF_SYSCALL_RET is not needed anymore: after the change described in 1.
the generic entry code tells whether ptrace or seccomp skipped the
system call, and every in-kernel caller of syscall_set_return_value() on
the syscall entry path (SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE without a
tracer, SECCOMP_RET_USER_NOTIF) also makes it return false.  A user
calling syscall(-1) without tracer or seccomp still gets -ENOSYS.

Remove the flag and return regs->gpr[3] for a skipped system call, as
done before the conversion to GENERIC_ENTRY.  The syscall exit path
already converts a negative error value to the "sc" ABI, and
syscall_set_return_value() keeps CR0.SO in sync for positive error
values.

Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
(ppc_skip_repro.c, available on request) which

 - sets the getpid() return value at a syscall-exit stop with
   PTRACE_SET_SYSCALL_INFO, then makes a syscall in the tracer;
 - skips getpid() at a PTRACE_EVENT_SECCOMP stop with PTRACE_POKEUSER
   (r0 = -1, r3/CR0.SO = return value), with both "sc" and "scv 0".

                                             v7.3-rc6      with this patch
  tracer syscall after SET_SYSCALL_INFO      returns 0     correct
  skipped syscall, success value, sc/scv     returns 0     correct
  skipped syscall, error value, sc/scv       correct       correct
  selftests/ptrace set_syscall_info test    FAIL          pass
  selftests/seccomp/seccomp_bpf              11 failures   all pass (*)

  failing in v7.3-rc6: user_notification_{basic,child_pid_ns,
  sibling_pid_ns,fault_recv,addfd,addfd_rlimit,sync,fifo,wait_killable},
  TRACE_syscall.seccomp.syscall_faked, plus the timing-only one below.

(*) user_notification_wait_killable_after_reply (100000 notifications
    with a 1 ms itimer) can hit the 30 s harness timeout under emulation,
    with and without this patch.

Build-tested with W=1: ppc64le guest config, ppc64_defconfig (BE),
pmac32_defconfig.

 arch/powerpc/include/asm/syscall.h     |  6 ------
 arch/powerpc/include/asm/thread_info.h |  1 -
 arch/powerpc/kernel/syscall.c          | 15 ++++++++-------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 32be22b995cc..4b3c52ed6e9d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -98,12 +98,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
 			regs->gpr[3] = val;
 		}
 	}
-	/*
-	 * Mark that a return value has been explicitly set by seccomp or
-	 * ptrace so that system_call_exception() can skip the syscall
-	 * unconditionally, even when the user requested syscall(-1).
-	 */
-	set_thread_flag(TIF_SYSCALL_RET);
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1e069a2e7ce8..0487e94d3416 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -120,7 +120,6 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_RET		21	/* syscall error value set */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index fbefe1927b10..52ceff4ef41b 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,13 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
-	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
-		clear_thread_flag(TIF_SYSCALL_RET);
-		return syscall_get_error(current, regs);
-	}
-
-	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
-		return syscall_get_error(current, regs);
+	/*
+	 * If ptrace or seccomp decided to skip the syscall, regs->gpr[3] holds
+	 * the return value they set (or the unmodified first argument, e.g.
+	 * for PTRACE_SYSEMU). Return it as is, the exit path takes care of
+	 * the error encoding for the "sc" ABI.
+	 */
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
+		return regs->gpr[3];
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
-- 
2.55.0


