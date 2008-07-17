Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <79d244f87af70706e70f02a045ef21b1d8e60ed9.1216279290.git.michael@ellerman.id.au>
In-Reply-To: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
References: <d452d52afbde7001bf85070ee528d21bfa814d8d.1216279290.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] powerpc: ftrace: Use PPC_LONG and PPC_LONG_ALIGN asm
	macros
Date: Thu, 17 Jul 2008 17:21:33 +1000 (EST)
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
 arch/powerpc/kernel/ftrace.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 49a2049..0e9fc10 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 
+#include <asm/asm-compat.h>
 #include <asm/cacheflush.h>
 #include <asm/code-patching.h>
 #include <asm/ftrace.h>
@@ -49,14 +50,6 @@ notrace unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	return (unsigned char *)&op;
 }
 
-#ifdef CONFIG_PPC64
-# define _ASM_ALIGN	" .align 3 "
-# define _ASM_PTR	" .llong "
-#else
-# define _ASM_ALIGN	" .align 2 "
-# define _ASM_PTR	" .long "
-#endif
-
 notrace int
 ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 		   unsigned char *new_code)
@@ -85,8 +78,8 @@ ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 		"	b 2b\n"
 		".previous\n"
 		".section __ex_table,\"a\"\n"
-		_ASM_ALIGN "\n"
-		_ASM_PTR "1b, 3b\n"
+		PPC_LONG_ALIGN "\n"
+		PPC_LONG "1b, 3b\n"
 		".previous"
 		: "=r"(faulted), "=r"(replaced)
 		: "r"(ip), "r"(new),
-- 
1.5.5
