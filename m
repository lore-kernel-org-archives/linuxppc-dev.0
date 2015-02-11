Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0107.outbound.protection.outlook.com [65.55.169.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E83211A086D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 19:36:34 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 1/3] powerpc: Don't force ENOSYS as error on syscall fail
Date: Wed, 11 Feb 2015 08:36:16 +0000
Message-ID: <1423643778-32525-2-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In certain scenarios - e.g. seccomp filtering with ERRNO as default action -
the system call fails for other reasons than the syscall not being available.
The seccomp filter can be configured to store a user-defined error code on
return from a blacklisted syscall. Don't always set ENOSYS on
do_syscall_trace_enter failure.

v2:
- move setting ENOSYS as errno from the syscall entry assembly to
  do_syscall_trace_enter, only in the specific case

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/kernel/entry_32.S | 2 +-
 arch/powerpc/kernel/entry_64.S | 1 -
 arch/powerpc/kernel/ptrace.c   | 4 +++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 10a0935..d2c58a3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -425,7 +425,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	b	1b
 #endif  /* CONFIG_44x */
 
-66:	li	r3,-ENOSYS
+66:
 	b	ret_from_syscall
 
 	.globl	ret_from_fork
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 194e46d..0111e04 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -269,7 +269,6 @@ syscall_dotrace:
 	b	.Lsyscall_dotrace_cont
 
 syscall_enosys:
-	li	r3,-ENOSYS
 	b	syscall_exit
 	
 syscall_exit_work:
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f21897b..d82fd0b 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1775,13 +1775,15 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	secure_computing_strict(regs->gpr[0]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    tracehook_report_syscall_entry(regs)) {
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
 		 * error, but leave the original number in regs->gpr[0].
 		 */
 		ret = -1L;
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
+	}
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gpr[0]);
-- 
2.1.4
