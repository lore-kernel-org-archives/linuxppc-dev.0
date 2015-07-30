Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D30D1A0C0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 16:08:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: keescook@chromium.org
Subject: [PATCH v2] powerpc/kernel: Enable seccomp filter
Date: Thu, 30 Jul 2015 15:56:48 +1000
Message-Id: <1438235808-6438-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1437646871-3195-9-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-9-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit enables seccomp filter on powerpc, now that we have all the
necessary pieces in place.

To support seccomp's desire to modify the syscall return value under
some circumstances, we use a different ABI to the ptrace ABI. That is we
use r3 as the syscall return value, and orig_gpr3 is the first syscall
parameter.

This means the seccomp code, or a ptracer via SECCOMP_RET_TRACE, will
see -ENOSYS preloaded in r3. This is identical to the behaviour on x86,
and allows seccomp or the ptracer to either leave the -ENOSYS or change
it to something else, as well as rejecting or not the syscall by
modifying r0.

If seccomp does not reject the syscall, we restore the register state to
match what ptrace and audit expect, ie. r3 is the first syscall
parameter again. We do this restore using orig_gpr3, which may have been
modified by seccomp, which allows seccomp to modify the first syscall
paramater and allow the syscall to proceed.

We need to #ifdef the the additional handling of r3 for seccomp, so move
it all out of line.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/Kconfig         |  1 +
 arch/powerpc/kernel/ptrace.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)


v2: The previous version didn't compile for CONFIG_SECCOMP=n. To fix it up I
    moved the logic out of line and #ifdef'ed that. It gets inlined by the compiler
    so the end result is the same.

    Kees I kept your Reviewed-by on the basis that the interesting logic is the
    same, hope that's OK by you.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fe2f2c595fd9..4139644030fb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -159,6 +159,7 @@ config PPC
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select HAVE_ARCH_SECCOMP_FILTER
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7484221bb3f8..737c0d0b53ac 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1762,6 +1762,44 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
+#ifdef CONFIG_SECCOMP
+static int do_seccomp(struct pt_regs *regs)
+{
+	if (!test_thread_flag(TIF_SECCOMP))
+		return 0;
+
+	/*
+	 * The ABI we present to seccomp tracers is that r3 contains
+	 * the syscall return value and orig_gpr3 contains the first
+	 * syscall parameter. This is different to the ptrace ABI where
+	 * both r3 and orig_gpr3 contain the first syscall parameter.
+	 */
+	regs->gpr[3] = -ENOSYS;
+
+	/*
+	 * We use the __ version here because we have already checked
+	 * TIF_SECCOMP. If this fails, there is nothing left to do, we
+	 * have already loaded -ENOSYS into r3, or seccomp has put
+	 * something else in r3 (via SECCOMP_RET_ERRNO/TRACE).
+	 */
+	if (__secure_computing())
+		return -1;
+
+	/*
+	 * The syscall was allowed by seccomp, restore the register
+	 * state to what ptrace and audit expect.
+	 * Note that we use orig_gpr3, which means a seccomp tracer can
+	 * modify the first syscall parameter (in orig_gpr3) and also
+	 * allow the syscall to proceed.
+	 */
+	regs->gpr[3] = regs->orig_gpr3;
+
+	return 0;
+}
+#else
+static inline int do_seccomp(struct pt_regs *regs) { return 0; }
+#endif /* CONFIG_SECCOMP */
+
 /**
  * do_syscall_trace_enter() - Do syscall tracing on kernel entry.
  * @regs: the pt_regs of the task to trace (current)
@@ -1787,7 +1825,8 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	user_exit();
 
-	secure_computing_strict(regs->gpr[0]);
+	if (do_seccomp(regs))
+		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		/*
-- 
2.1.4
