Return-Path: <roland@redhat.com>
Received: from QMTA10.emeryville.ca.mail.comcast.net
	(qmta10.emeryville.ca.mail.comcast.net [76.96.30.17])
	by ozlabs.org (Postfix) with ESMTP id 1867FDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 19:26:09 +1100 (EST)
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc: user_regset PTRACE_SETREGS regression fix
Message-Id: <20080313082535.99DF226F992@magilla.localdomain>
Date: Thu, 13 Mar 2008 01:25:35 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The PTRACE_SETREGS request was only recently added on powerpc,
and gdb does not use it.  So it slipped through without getting
all the testing it should have had.

The user_regset changes had a simple bug in storing to all of
the 32-bit general registers block on 64-bit kernels.  This bug
only comes up with PTRACE_SETREGS, not PPC_PTRACE_SETREGS.
It causes a BUG_ON to hit, so this fix needs to go in ASAP.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7673e98..2a9fe97 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -530,15 +530,21 @@ static int gpr32_set(struct task_struct *target,
 		--count;
 	}
 
-	if (kbuf)
+	if (kbuf) {
 		for (; count > 0 && pos <= PT_MAX_PUT_REG; --count)
 			regs[pos++] = *k++;
-	else
+		for (; count > 0 && pos < PT_TRAP; --count, ++pos)
+			++k;
+	} else {
 		for (; count > 0 && pos <= PT_MAX_PUT_REG; --count) {
 			if (__get_user(reg, u++))
 				return -EFAULT;
 			regs[pos++] = reg;
 		}
+		for (; count > 0 && pos < PT_TRAP; --count, ++pos)
+			if (__get_user(reg, u++))
+				return -EFAULT;
+	}
 
 	if (count > 0 && pos == PT_TRAP) {
 		if (kbuf)
