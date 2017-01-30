Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBfvc4D0tzDqCR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 17:42:20 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 75so30757917pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 22:42:20 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/3] powerpc/sparse: constify the address pointer in
 __get_user_nosleep
Date: Mon, 30 Jan 2017 17:41:55 +1100
Message-Id: <20170130064155.30281-4-dja@axtens.net>
In-Reply-To: <20170130064155.30281-1-dja@axtens.net>
References: <20170130064155.30281-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __get_user_nosleep, we create an intermediate pointer for the
user address we're about to fetch. We currently don't tag this
pointer as const. Make it const, as we are simply dereferencing
it, and it's scope is limited to the __get_user_nosleep macro.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

This is sparse neutral:

-arch/powerpc/kernel/hw_breakpoint.c:XX:14: warning: incorrect type in initializer (different address spaces)
-     expected unsigned int [noderef] <asn:1>*__gu_addr
-     got unsigned int *<noident>

+arch/powerpc/kernel/hw_breakpoint.c:XX:14: warning: incorrect type in initializer (different address spaces)
+     expected unsigned int const [noderef] <asn:1>*__gu_addr
+     got unsigned int *<noident>

It looks like a pointer not tagged with __user is being passed in.
That will need to be fixed in a follow-up patch.

However this is still worth doing, as it makes the __get_user_*
macros consistent.
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 44ded4193001..0e6add3187bc 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -286,7 +286,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	unsigned long __gu_val;					\
-	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-- 
2.9.3
