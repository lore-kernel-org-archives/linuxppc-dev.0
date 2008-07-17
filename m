Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <c83b4f179d07710f3592ddbc310b55f1ef274147.1216279290.git.michael@ellerman.id.au>
In-Reply-To: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
References: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] powerpc: ftrace: Use create_branch() and cope with errors
Date: Thu, 17 Jul 2008 17:21:32 +1000 (EST)
Cc: srostedt@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use create_branch() rather than doing it by hand. It's possible that
we are unable to create a branch to the address, if it's too far away,
in which case just return a nop. This will break the tracing, but
shouldn't crash the kernel at least.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 1d6f174..49a2049 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -19,11 +19,6 @@
 #include <asm/ftrace.h>
 
 
-static unsigned int notrace ftrace_calc_offset(long ip, long addr)
-{
-	return (int)(addr - ip);
-}
-
 notrace unsigned char *ftrace_nop_replace(void)
 {
 	static unsigned int ftrace_nop = PPC_NOP_INSTR;
@@ -35,16 +30,17 @@ notrace unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
 	static unsigned int op;
 
-	/*
-	 * It would be nice to just use create_function_call, but that will
-	 * update the code itself. Here we need to just return the
-	 * instruction that is going to be modified, without modifying the
-	 * code.
-	 */
 	addr = ppc_function_entry((void *)addr);
 
 	/* Set to "bl addr" */
-	op = 0x48000001 | (ftrace_calc_offset(ip, addr) & 0x03fffffc);
+	op = create_branch((unsigned int *)ip, addr, BRANCH_SET_LINK);
+
+	/*
+	 * This routine is not allowed to fail, but create_branch() can.
+	 * In that case, just return nop and cross our fingers.
+	 */
+	if (!op)
+		return ftrace_nop_replace();
 
 	/*
 	 * No locking needed, this must be called via kstop_machine
-- 
1.5.5
