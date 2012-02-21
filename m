Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix program check handling when lockdep is enabled
Date: Tue, 21 Feb 2012 18:32:30 +1100
Message-Id: <1329809550-29336-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 54321242afe ("Disable interrupts early in Program Check"), we
switched from enabling to disabling interrupts in program_check_common.

Whereas ENABLE_INTS leaves r3 untouched, if lockdep is enabled DISABLE_INTS
calls into lockdep code and will clobber r3. That means we pass a bogus
struct pt_regs* into program_check_exception() and all hell breaks loose.

So load our regs pointer into r3 after we call DISABLE_INTS.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3844ca7..15c5a4f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -774,8 +774,8 @@ alignment_common:
 program_check_common:
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	.save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
 	DISABLE_INTS
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.program_check_exception
 	b	.ret_from_except
 
-- 
1.7.5.4
