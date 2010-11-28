Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9D0EBB70A7
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 03:33:21 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
	[192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A1023186DEE9
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 17:33:15 +0100 (CET)
Received: from igel.home (ppp-88-217-110-40.dynamic.mnet-online.de
	[88.217.110.40])
	by mail.mnet-online.de (Postfix) with ESMTP id 4B96C1C004DD
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 17:33:15 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: update compat_arch_ptrace
Date: Sun, 28 Nov 2010 17:33:14 +0100
Message-ID: <m2tyj18l2t.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update compat_arch_ptrace to follow recent changes in
PTRACE_GET_DEBUGREG and the addition of
PPC_PTRACE_{GETHWDBGINFO|{SET|DEL}HWDEBUG}.  The latter three can be
forwarded to arch_ptrace unchanged.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/ptrace32.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index 8a6daf4..69c4be9 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -280,7 +280,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		/* We only support one DABR and no IABRS at the moment */
 		if (addr > 0)
 			break;
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+		ret = put_user(child->thread.dac1, (u32 __user *)data);
+#else
 		ret = put_user(child->thread.dabr, (u32 __user *)data);
+#endif
 		break;
 	}
 
@@ -312,6 +316,9 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	case PTRACE_SET_DEBUGREG:
 	case PTRACE_SYSCALL:
 	case PTRACE_CONT:
+	case PPC_PTRACE_GETHWDBGINFO:
+	case PPC_PTRACE_SETHWDEBUG:
+	case PPC_PTRACE_DELHWDEBUG:
 		ret = arch_ptrace(child, request, addr, data);
 		break;
 
-- 
1.7.3.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
