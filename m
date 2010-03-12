Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25])
	by ozlabs.org (Postfix) with ESMTP id 672B4B7D4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Mar 2010 10:21:45 +1100 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] use correct ccr bit for syscall error status
Date: Fri, 12 Mar 2010 17:16:02 -0600
Message-Id: <1268435762-25788-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc implementations of syscall_get_error and
syscall_set_return_value should use CCR0:S0 (0x10000000) for testing
and setting syscall error status.  Fortunately these APIs don't seem
to be used at the moment.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/include/asm/syscall.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index efa7f0b..23913e9 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -30,7 +30,7 @@ static inline void syscall_rollback(struct task_struct *task,
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	return (regs->ccr & 0x1000) ? -regs->gpr[3] : 0;
+	return (regs->ccr & 0x10000000) ? -regs->gpr[3] : 0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
@@ -44,10 +44,10 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    int error, long val)
 {
 	if (error) {
-		regs->ccr |= 0x1000L;
+		regs->ccr |= 0x10000000L;
 		regs->gpr[3] = -error;
 	} else {
-		regs->ccr &= ~0x1000L;
+		regs->ccr &= ~0x10000000L;
 		regs->gpr[3] = val;
 	}
 }
-- 
1.6.0.6
