Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VVPk4lT7zF1sY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 14:16:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] powerpc: Use barrier_nospec in copy_from_user()
Date: Tue, 24 Apr 2018 14:15:58 +1000
Message-Id: <20180424041559.32410-5-mpe@ellerman.id.au>
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on the x86 commit doing the same.

See commit 304ec1b05031 ("x86/uaccess: Use __uaccess_begin_nospec()
and uaccess_try_nospec") and b3bbfb3fb5d2 ("x86: Introduce
__uaccess_begin_nospec() and uaccess_try_nospec") for more detail.

In all cases we are ordering the load from the potentially
user-controlled pointer vs a previous branch based on an access_ok()
check or similar.

Base on a patch from Michal Suchanek.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/uaccess.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a62ee663b2c8..6dc3d2eeea4a 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -252,6 +252,7 @@ do {								\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -263,8 +264,10 @@ do {								\
 	unsigned long  __gu_val = 0;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
-	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
+	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
+		barrier_nospec();					\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
 })
@@ -275,6 +278,7 @@ do {								\
 	unsigned long __gu_val;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -302,15 +306,19 @@ static inline unsigned long raw_copy_from_user(void *to,
 
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret);
 			break;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret);
 			break;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret);
 			break;
 		case 8:
+			barrier_nospec();
 			__get_user_size(*(u64 *)to, from, 8, ret);
 			break;
 		}
@@ -318,6 +326,7 @@ static inline unsigned long raw_copy_from_user(void *to,
 			return 0;
 	}
 
+	barrier_nospec();
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 
-- 
2.14.1
