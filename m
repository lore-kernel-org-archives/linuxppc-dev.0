Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Apr 2007 16:13:19 +1000
Subject: [PATCH 1/2] powerpc: Add inatomic versions of __get_user and
	__put_user
Message-Id: <20070411061755.5F48DDDF15@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Those are needed by things like alignment exception fixup handlers
since those can now be triggered by copy_tofrom_user_inatomic.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Might be possible to simplify things in this file a bit more by having
only one version of the __get/put_user_xxxx() with if's and relying more
on the compiler to do the right thing, what do you think ?

 include/asm-powerpc/uaccess.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: linux-work/include/asm-powerpc/uaccess.h
===================================================================
--- linux-work.orig/include/asm-powerpc/uaccess.h	2007-04-11 10:17:44.000000000 +1000
+++ linux-work/include/asm-powerpc/uaccess.h	2007-04-11 10:24:38.000000000 +1000
@@ -110,12 +110,18 @@
 	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
+
 #ifndef __powerpc64__
 #define __get_user64(x, ptr) \
 	__get_user64_nocheck((x), (ptr), sizeof(*(ptr)))
 #define __put_user64(x, ptr) __put_user(x, ptr)
 #endif
 
+#define __get_user_inatomic(x, ptr) \
+	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
+#define __put_user_inatomic(x, ptr) \
+	__put_user_nosleep((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
+
 #define __get_user_unaligned __get_user
 #define __put_user_unaligned __put_user
 
@@ -198,6 +204,16 @@
 	__pu_err;							\
 })
 
+#define __put_user_nosleep(x, ptr, size)			\
+({								\
+	long __pu_err;						\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
+	__chk_user_ptr(ptr);					\
+	__put_user_size((x), __pu_addr, (size), __pu_err);	\
+	__pu_err;						\
+})
+
+
 extern long __get_user_bad(void);
 
 #define __get_user_asm(x, addr, err, op)		\
@@ -297,6 +313,18 @@
 	__gu_err;							\
 })
 
+#define __get_user_nosleep(x, ptr, size)			\
+({								\
+	long __gu_err;						\
+	unsigned long __gu_val;					\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__chk_user_ptr(ptr);					\
+	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	(x) = (__typeof__(*(ptr)))__gu_val;			\
+	__gu_err;						\
+})
+
+
 /* more complex routines */
 
 extern unsigned long __copy_tofrom_user(void __user *to,
