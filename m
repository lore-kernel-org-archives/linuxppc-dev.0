Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2e3c13ddbf80969f086c92f40b1ca6cf891a738f.1216279070.git.michael@ellerman.id.au>
In-Reply-To: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
References: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/3] powerpc: Use PPC_LONG_ALIGN in uaccess.h
Date: Thu, 17 Jul 2008 17:17:52 +1000 (EST)
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
 include/asm-powerpc/uaccess.h |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/asm-powerpc/uaccess.h b/include/asm-powerpc/uaccess.h
index 1a0736f..bd0fb84 100644
--- a/include/asm-powerpc/uaccess.h
+++ b/include/asm-powerpc/uaccess.h
@@ -6,6 +6,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <asm/asm-compat.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 
@@ -141,12 +142,11 @@ extern long __put_user_bad(void);
 		"	b 2b\n"					\
 		".previous\n"					\
 		".section __ex_table,\"a\"\n"			\
-		"	.balign %5\n"				\
+			PPC_LONG_ALIGN "\n"			\
 			PPC_LONG "1b,3b\n"			\
 		".previous"					\
 		: "=r" (err)					\
-		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err),\
-		  "i"(sizeof(unsigned long)))
+		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
 
 #ifdef __powerpc64__
 #define __put_user_asm2(x, ptr, retval)				\
@@ -162,13 +162,12 @@ extern long __put_user_bad(void);
 		"	b 3b\n"					\
 		".previous\n"					\
 		".section __ex_table,\"a\"\n"			\
-		"	.balign %5\n"				\
+			PPC_LONG_ALIGN "\n"			\
 			PPC_LONG "1b,4b\n"			\
 			PPC_LONG "2b,4b\n"			\
 		".previous"					\
 		: "=r" (err)					\
-		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err),\
-		  "i"(sizeof(unsigned long)))
+		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
 #endif /* __powerpc64__ */
 
 #define __put_user_size(x, ptr, size, retval)			\
@@ -226,12 +225,11 @@ extern long __get_user_bad(void);
 		"	b 2b\n"				\
 		".previous\n"				\
 		".section __ex_table,\"a\"\n"		\
-		"	.balign %5\n"			\
+			PPC_LONG_ALIGN "\n"		\
 			PPC_LONG "1b,3b\n"		\
 		".previous"				\
 		: "=r" (err), "=r" (x)			\
-		: "b" (addr), "i" (-EFAULT), "0" (err),	\
-		  "i"(sizeof(unsigned long)))
+		: "b" (addr), "i" (-EFAULT), "0" (err))
 
 #ifdef __powerpc64__
 #define __get_user_asm2(x, addr, err)			\
@@ -249,13 +247,12 @@ extern long __get_user_bad(void);
 		"	b 3b\n"				\
 		".previous\n"				\
 		".section __ex_table,\"a\"\n"		\
-		"	.balign %5\n"			\
+			PPC_LONG_ALIGN "\n"		\
 			PPC_LONG "1b,4b\n"		\
 			PPC_LONG "2b,4b\n"		\
 		".previous"				\
 		: "=r" (err), "=&r" (x)			\
-		: "b" (addr), "i" (-EFAULT), "0" (err),	\
-		  "i"(sizeof(unsigned long)))
+		: "b" (addr), "i" (-EFAULT), "0" (err))
 #endif /* __powerpc64__ */
 
 #define __get_user_size(x, ptr, size, retval)			\
-- 
1.5.5
