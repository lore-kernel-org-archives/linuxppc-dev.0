Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXx40FpnzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:47 +1000 (AEST)
Message-Id: <84c91953e3f80f7d6def45fdb5512c098ba854a2.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 03/12] powerpc/8xx: Remove SoftwareEmulation()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:44 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit aa42c69c67f82 ("[POWERPC] Add support for FP emulation
for the e300c2 core"), program_check_exception() can be called for
math emulation. In that case, 'reason' is 0.

On the 8xx, there is a Software Emulation interrupt which is
called for all unimplemented and illegal instructions. This
interrupt calls SoftwareEmulation() which does almost the
same as program_check_exception() called with reason = 0.

The Software Emulation interrupt sets all reason bits to 0,
it is therefore possible to call program_check_exception()
directly from the interrupt handler.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S |  2 +-
 arch/powerpc/kernel/traps.c    | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 07ddced6bab3..778a0e11d0e6 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -300,7 +300,7 @@ SystemCall:
 /* On the MPC8xx, this is a software emulation interrupt.  It occurs
  * for all unimplemented and illegal instructions.
  */
-	EXCEPTION(0x1000, SoftEmu, SoftwareEmulation, EXC_XFER_STD)
+	EXCEPTION(0x1000, SoftEmu, program_check_exception, EXC_XFER_STD)
 
 	. = 0x1100
 /*
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b328ca2aef9c..9d1f600bda08 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1518,24 +1518,6 @@ void performance_monitor_exception(struct pt_regs *regs)
 	perf_irq(regs);
 }
 
-#ifdef CONFIG_8xx
-void SoftwareEmulation(struct pt_regs *regs)
-{
-	CHECK_FULL_REGS(regs);
-
-	if (!user_mode(regs)) {
-		debugger(regs);
-		die("Kernel Mode Unimplemented Instruction or SW FPU Emulation",
-			regs, SIGFPE);
-	}
-
-	if (!emulate_math(regs))
-		return;
-
-	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-}
-#endif /* CONFIG_8xx */
-
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 static void handle_debug(struct pt_regs *regs, unsigned long debug_status)
 {
-- 
2.13.3
