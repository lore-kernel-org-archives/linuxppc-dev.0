Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9A3B6B6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 17:42:29 +1100 (EST)
Message-ID: <1329201738.3772.3.camel@pasglop>
Subject: [PATCH] powerpc: Disable interrupts early in Program Check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 14 Feb 2012 17:42:18 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Program Check exceptions are the result of WARNs, BUGs, some
type of breakpoints, kprobe, and other illegal instructions.

We want interrupts (and thus preemption) to remain disabled
while doing the initial stage of testing the reason and
branching off to a debugger or kprobe, so we are still on
the original CPU which makes debugging easier in various cases.

This is how the code was intended, hence the local_irq_enable()
right in the middle of program_check_exception().

However, the assembly exception prologue for that exception was
incorrectly marked as enabling interrupts, which defeats that
(and records a redundant enable with lockdep).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d4be7bb..3844ca7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -775,7 +775,7 @@ program_check_common:
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
+	DISABLE_INTS
 	bl	.program_check_exception
 	b	.ret_from_except
 
