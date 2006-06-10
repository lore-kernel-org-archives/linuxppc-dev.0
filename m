Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 21:25:21 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix shared processor and mdelay interaction
Message-ID: <20060610112521.GO23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul and Ben found an interaction with mdelay on shared processor where
mdelay can have large errors.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/include/asm-powerpc/delay.h
===================================================================
--- build.orig/include/asm-powerpc/delay.h	2006-06-08 10:57:41.000000000 +1000
+++ build/include/asm-powerpc/delay.h	2006-06-10 21:15:02.000000000 +1000
@@ -17,5 +17,18 @@
 extern void __delay(unsigned long loops);
 extern void udelay(unsigned long usecs);
 
+/*
+ * On shared processor machines the generic implementation of mdelay can
+ * result in large errors. While each iteration of the loop inside mdelay
+ * is supposed to take 1ms, the hypervisor could sleep our partition for
+ * longer (eg 10ms). With the right timing these errors can add up.
+ *
+ * Since there is no 32bit overflow issue on 64bit kernels, just call
+ * udelay directly.
+ */
+#ifdef CONFIG_PPC64
+#define mdelay(n)	udelay((n) * 1000)
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DELAY_H */
Index: build/include/linux/delay.h
===================================================================
--- build.orig/include/linux/delay.h	2006-06-08 10:57:41.000000000 +1000
+++ build/include/linux/delay.h	2006-06-10 21:04:58.000000000 +1000
@@ -25,10 +25,7 @@ extern unsigned long loops_per_jiffy;
 #define MAX_UDELAY_MS	5
 #endif
 
-#ifdef notdef
-#define mdelay(n) (\
-	{unsigned long __ms=(n); while (__ms--) udelay(1000);})
-#else
+#ifndef mdelay
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
 	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
