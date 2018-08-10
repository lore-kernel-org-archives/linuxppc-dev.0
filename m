Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n48f3sM7zDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 22:25:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/uaccess: Enable get_user(u64, *p) on 32-bit
Date: Fri, 10 Aug 2018 22:25:35 +1000
Message-Id: <20180810122535.11710-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if you build a 32-bit powerpc kernel and use get_user() to
load a u64 value it will fail to build with eg:

  kernel/rseq.o: In function `rseq_get_rseq_cs':
  kernel/rseq.c:123: undefined reference to `__get_user_bad'

This is hitting the check in __get_user_size() that makes sure the
size we're copying doesn't exceed the size of the destination:

  #define __get_user_size(x, ptr, size, retval)
  do {
  	retval = 0;
  	__chk_user_ptr(ptr);
  	if (size > sizeof(x))
  		(x) = __get_user_bad();

Which doesn't immediately make sense because the size of the
destination is u64, but it's not really, because __get_user_check()
etc. internally create an unsigned long and copy into that:

  #define __get_user_check(x, ptr, size)
  ({
  	long __gu_err = -EFAULT;
  	unsigned long  __gu_val = 0;

The problem being that on 32-bit unsigned long is not big enough to
hold a u64. We can fix this with a trick from hpa in the x86 code, we
statically check the type of x and set the type of __gu_val to either
unsigned long or unsigned long long.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/uaccess.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 643cfbd5bcb5..bac225bb7f64 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -249,10 +249,17 @@ do {								\
 	}							\
 } while (0)
 
+/*
+ * This is a type: either unsigned long, if the argument fits into
+ * that type, or otherwise unsigned long long.
+ */
+#define __long_type(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
+
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
-	unsigned long __gu_val;					\
+	__long_type(*(ptr)) __gu_val;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
@@ -266,7 +273,7 @@ do {								\
 #define __get_user_check(x, ptr, size)					\
 ({									\
 	long __gu_err = -EFAULT;					\
-	unsigned long  __gu_val = 0;					\
+	__long_type(*(ptr)) __gu_val = 0;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
@@ -280,7 +287,7 @@ do {								\
 #define __get_user_nosleep(x, ptr, size)			\
 ({								\
 	long __gu_err;						\
-	unsigned long __gu_val;					\
+	__long_type(*(ptr)) __gu_val;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	barrier_nospec();					\
-- 
2.14.1
