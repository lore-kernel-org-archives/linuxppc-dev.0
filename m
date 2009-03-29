Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 51189DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 05:04:19 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4BF301C15236
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 19:59:12 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 0C034901C9
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 19:56:22 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new,
	port 10024) with ESMTP id HU7Udl3PRmGf for <linuxppc-dev@ozlabs.org>;
	Sun, 29 Mar 2009 19:56:20 +0200 (CEST)
Received: from igel.home (DSL01.83.171.146.241.ip-pool.NEFkom.net
	[83.171.146.241]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 19:56:20 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix ptrace compat wrapper for fpu register access
Date: Sun, 29 Mar 2009 19:56:19 +0200
Message-ID: <m2k568xlfg.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ptrace compat wrapper mishandles access to the fpu registers.  The
PTRACE_PEEKUSR and PTRACE_POKEUSR requests miscalculate the index into
the fpr array due to the broken FPINDEX macro.  The
PPC_PTRACE_PEEKUSR_3264 request needs to use the same formula that the
native ptrace interface uses when operating on the register number (as
opposed to the 4-byte offset).  The PPC_PTRACE_POKEUSR_3264 request
didn't take TS_FPRWIDTH into account.

This was tested with the gdb testsuite on a G5.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

---
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index 197d49c..f992eaf 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -67,7 +67,7 @@ static long compat_ptrace_old(struct task_struct *child, long request,
 /* Macros to workout the correct index for the FPR in the thread struct */
 #define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
 #define FPRHALF(i) (((i) - PT_FPR0) & 1)
-#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) + FPRHALF(i)
+#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) * 2 + FPRHALF(i)
 
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
@@ -169,7 +169,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		if (numReg >= PT_FPR0) {
 			flush_fp_to_thread(child);
 			tmp = ((unsigned long int *)child->thread.fpr)
-				[FPRINDEX(numReg)];
+				[TS_FPRWIDTH * (numReg - PT_FPR0)];
 		} else { /* register within PT_REGS struct */
 			tmp = ptrace_get_reg(child, numReg);
 		} 
@@ -263,7 +263,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			ret = ptrace_put_reg(child, numReg, freg);
 		} else {
 			flush_fp_to_thread(child);
-			((unsigned int *)child->thread.regs)[index] = data;
+			((unsigned int *)child->thread.regs)
+				[FPRINDEX(index)] = data;
 			ret = 0;
 		}
 		break;

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
