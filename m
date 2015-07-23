Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78A201A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 20:21:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [PATCH 09/11] powerpc/kernel: Enable seccomp filter
Date: Thu, 23 Jul 2015 20:21:09 +1000
Message-Id: <1437646871-3195-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
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

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig         |  1 +
 arch/powerpc/kernel/ptrace.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5ef27113b898..b6cb6a87b7a2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -155,6 +155,7 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI if PPC64
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
+	select HAVE_ARCH_SECCOMP_FILTER
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7484221bb3f8..de79eb5218c6 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1787,7 +1787,33 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	user_exit();
 
-	secure_computing_strict(regs->gpr[0]);
+	if (test_thread_flag(TIF_SECCOMP)) {
+		/*
+		 * The ABI we present to seccomp tracers is that r3 contains
+		 * the syscall return value and orig_gpr3 contains the first
+		 * syscall parameter. This is different to the ptrace ABI where
+		 * both r3 and orig_gpr3 contain the first syscall parameter.
+		 */
+		regs->gpr[3] = -ENOSYS;
+
+		/*
+		 * We use the __ version here because we have already checked
+		 * TIF_SECCOMP. If this fails, there is nothing left to do, we
+		 * have already loaded -ENOSYS into r3, or seccomp has put
+		 * something else in r3 (via SECCOMP_RET_ERRNO/TRACE).
+		 */
+		if (__secure_computing())
+			return -1;
+
+		/*
+		 * The syscall was allowed by seccomp, restore the register
+		 * state to what ptrace and audit expect.
+		 * Note that we use orig_gpr3, which means a seccomp tracer can
+		 * modify the first syscall parameter (in orig_gpr3) and also
+		 * allow the syscall to proceed.
+		 */
+		regs->gpr[3] = regs->orig_gpr3;
+	}
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		/*
-- 
2.1.0
