Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] powerpc: ftrace: Use PPC_NOP_INSTR #define for NOP
Date: Thu, 17 Jul 2008 17:21:30 +1000 (EST)
Cc: srostedt@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

And move ftrace_nop into the only function it's used in.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 3855ceb..78f4423 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -15,11 +15,10 @@
 #include <linux/list.h>
 
 #include <asm/cacheflush.h>
+#include <asm/code-patching.h>
 #include <asm/ftrace.h>
 
 
-static unsigned int ftrace_nop = 0x60000000;
-
 #ifdef CONFIG_PPC32
 # define GET_ADDR(addr) addr
 #else
@@ -35,6 +34,8 @@ static unsigned int notrace ftrace_calc_offset(long ip, long addr)
 
 notrace unsigned char *ftrace_nop_replace(void)
 {
+	static unsigned int ftrace_nop = PPC_NOP_INSTR;
+
 	return (char *)&ftrace_nop;
 }
 
-- 
1.5.5
