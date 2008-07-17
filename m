Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b628cf76e1fd2b5b2e5d7e2119494891842349f7.1216279290.git.michael@ellerman.id.au>
In-Reply-To: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
References: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] powerpc: ftrace: Use ppc_function_entry() rather than
	hand-rolled macro
Date: Thu, 17 Jul 2008 17:21:31 +1000 (EST)
Cc: srostedt@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 78f4423..1d6f174 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -19,14 +19,6 @@
 #include <asm/ftrace.h>
 
 
-#ifdef CONFIG_PPC32
-# define GET_ADDR(addr) addr
-#else
-/* PowerPC64's functions are data that points to the functions */
-# define GET_ADDR(addr) *(unsigned long *)addr
-#endif
-
-
 static unsigned int notrace ftrace_calc_offset(long ip, long addr)
 {
 	return (int)(addr - ip);
@@ -49,7 +41,7 @@ notrace unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	 * instruction that is going to be modified, without modifying the
 	 * code.
 	 */
-	addr = GET_ADDR(addr);
+	addr = ppc_function_entry((void *)addr);
 
 	/* Set to "bl addr" */
 	op = 0x48000001 | (ftrace_calc_offset(ip, addr) & 0x03fffffc);
-- 
1.5.5
