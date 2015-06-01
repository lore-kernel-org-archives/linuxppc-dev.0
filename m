Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 528061A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:38:01 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix duplicate const clang warning in user access code
Date: Mon,  1 Jun 2015 16:37:58 +1000
Message-Id: <1433140678-31638-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We see a large number of duplicate const errors in the user access
code when building with llvm/clang:

include/linux/pagemap.h:576:8: warning: duplicate 'const' declaration specifier
      [-Wduplicate-decl-specifier]
        ret = __get_user(c, uaddr);

The problem is we are doing const __typeof__(*(ptr)), which will hit the
warning if ptr is marked const.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a0c071d..2a8ebae 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -265,7 +265,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	unsigned long __gu_val;					\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
@@ -279,7 +279,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	long long __gu_val;					\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
@@ -293,7 +293,7 @@ do {								\
 ({									\
 	long __gu_err = -EFAULT;					\
 	unsigned long  __gu_val = 0;					\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
@@ -305,7 +305,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	unsigned long __gu_val;					\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-- 
2.1.4
