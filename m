Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 577A31A2EA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 17:37:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [RFC PATCH 08/12] powerpc: Change syscall_get_nr() to return int
Date: Wed, 15 Jul 2015 17:37:10 +1000
Message-Id: <1436945834-26660-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The documentation for syscall_get_nr() in asm-generic says:

 Note this returns int even on 64-bit machines. Only 32 bits of
 system call number can be meaningful. If the actual arch value
 is 64 bits, this truncates to 32 bits so 0xffffffff means -1.

However our implementation was never updated to reflect this.

Generally it's not important, but there is once case where it matters.

For seccomp filter with SECCOMP_RET_TRACE, the tracer will set
regs->gpr[0] to -1 to reject the syscall. When the task is a compat
task, this means we end up with 0xffffffff in r0 because ptrace will
zero extend the 32-bit value.

If syscall_get_nr() returns an unsigned long, then a 64-bit kernel will
see a positive value in r0 and will incorrectly allow the syscall
through seccomp.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/syscall.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 8d79a87c0511..ab9f3f0a8637 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -22,10 +22,15 @@
 extern const unsigned long sys_call_table[];
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
-static inline long syscall_get_nr(struct task_struct *task,
-				  struct pt_regs *regs)
+static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
-	return TRAP(regs) == 0xc00 ? regs->gpr[0] : -1L;
+	/*
+	 * Note that we are returning an int here. That means 0xffffffff, ie.
+	 * 32-bit negative 1, will be interpreted as -1 on a 64-bit kernel.
+	 * This is important for seccomp so that compat tasks can set r0 = -1
+	 * to reject the syscall.
+	 */
+	return TRAP(regs) == 0xc00 ? regs->gpr[0] : -1;
 }
 
 static inline void syscall_rollback(struct task_struct *task,
-- 
2.1.0
