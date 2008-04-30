Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAA4BDE094
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 20:49:06 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3UAn2nh029067
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:49:02 -0500
Date: Wed, 30 Apr 2008 05:44:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Set lower flag bits in regs->trap to indicate
	debug level exception
Message-ID: <Pine.LNX.4.64.0804300544370.7714@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We use the low bits of regs->trap as flag bits.  We already indicate
critical and machine check level exceptions via this mechanism.  Extend it
to indicate debug level exceptions.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_booke.h |    2 +-
 include/asm-powerpc/ptrace.h     |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 5f5429f..24cc6b8 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -278,7 +278,7 @@ label:
 	/* continue normal handling for a critical exception... */	      \
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
+	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)

 #define DEBUG_CRIT_EXCEPTION						      \
 	START_EXCEPTION(DebugCrit);					      \
diff --git a/include/asm-powerpc/ptrace.h b/include/asm-powerpc/ptrace.h
index 39023dd..38d87e5 100644
--- a/include/asm-powerpc/ptrace.h
+++ b/include/asm-powerpc/ptrace.h
@@ -119,6 +119,7 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
 #ifndef __powerpc64__
 #define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) != 0)
 #define IS_MCHECK_EXC(regs)	(((regs)->trap & 4) != 0)
+#define IS_DEBUG_EXC(regs)	(((regs)->trap & 8) != 0)
 #endif /* ! __powerpc64__ */
 #define TRAP(regs)		((regs)->trap & ~0xF)
 #ifdef __powerpc64__
-- 
1.5.4.1
