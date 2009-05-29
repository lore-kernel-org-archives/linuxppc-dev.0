Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2f000af3c9826e0b4d21f890e9e2a5d20ca048f4.1243575200.git.michael@ellerman.id.au>
In-Reply-To: <8e59964be84e85d2ca8c08db3fdd979db61fb0f6.1243575200.git.michael@ellerman.id.au>
References: <8e59964be84e85d2ca8c08db3fdd979db61fb0f6.1243575200.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/3] powerpc/ftrace: Use PPC_INST_NOP directly
Date: Fri, 29 May 2009 15:33:36 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no need to wrap PPC_INST_NOP in a static inline.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 8620ecb..f4ad248 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -25,11 +25,6 @@
 
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-static unsigned int ftrace_nop_replace(void)
-{
-	return PPC_INST_NOP;
-}
-
 static unsigned int
 ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
@@ -314,7 +309,7 @@ int ftrace_make_nop(struct module *mod,
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
 		old = ftrace_call_replace(ip, addr, 1);
-		new = ftrace_nop_replace();
+		new = PPC_INST_NOP;
 		return ftrace_modify_code(ip, old, new);
 	}
 
@@ -452,7 +447,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 */
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
-		old = ftrace_nop_replace();
+		old = PPC_INST_NOP;
 		new = ftrace_call_replace(ip, addr, 1);
 		return ftrace_modify_code(ip, old, new);
 	}
-- 
1.6.2.1
