Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <8e59964be84e85d2ca8c08db3fdd979db61fb0f6.1243575200.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/3] powerpc/ftrace: Use ppc_function_entry() instead of
	GET_ADDR
Date: Fri, 29 May 2009 15:33:34 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use ppc_function_entry() from code-patching.h.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 70e2a73..8585217 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -23,12 +23,6 @@
 #include <asm/code-patching.h>
 #include <asm/ftrace.h>
 
-#ifdef CONFIG_PPC32
-# define GET_ADDR(addr) addr
-#else
-/* PowerPC64's functions are data that points to the functions */
-# define GET_ADDR(addr) (*(unsigned long *)addr)
-#endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static unsigned int ftrace_nop_replace(void)
@@ -41,7 +35,7 @@ ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
 	unsigned int op;
 
-	addr = GET_ADDR(addr);
+	addr = ppc_function_entry((void *)addr);
 
 	/* if (link) set op to 'bl' else 'b' */
 	op = create_branch((unsigned int *)ip, addr, link ? 1 : 0);
@@ -197,7 +191,7 @@ __ftrace_make_nop(struct module *mod,
 	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];
 
 	/* This should match what was called */
-	if (ptr != GET_ADDR(addr)) {
+	if (ptr != ppc_function_entry((void *)addr)) {
 		printk(KERN_ERR "addr does not match %lx\n", ptr);
 		return -EINVAL;
 	}
@@ -570,7 +564,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return_hooker = (unsigned long)&mod_return_to_handler;
 #endif
 
-	return_hooker = GET_ADDR(return_hooker);
+	return_hooker = ppc_function_entry((void *)return_hooker);
 
 	/*
 	 * Protect against fault, even if it shouldn't
-- 
1.6.2.1
