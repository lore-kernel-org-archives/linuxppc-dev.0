Return-Path: <dja@axtens.net>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBfvW4nxmzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 17:42:15 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id f144so22684833pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 22:42:15 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/3] powerpc/sparse: constify the address pointer in
 __get_user_check
Date: Mon, 30 Jan 2017 17:41:53 +1100
Message-Id: <20170130064155.30281-2-dja@axtens.net>
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

In __get_user_check, we create an intermediate pointer for the
user address we're about to fetch. We currently don't tag this
pointer as const. Make it const, as we are simply dereferencing
it, and it's scope is limited to the __get_user_check macro.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

This fixes warnings outside arch/powerpc where people are passing
constified pointers into get_user(), such as:

linux/fs/exec.c:423:21: warning: incorrect type in initializer (different modifiers)
     expected unsigned int [noderef] <asn:1>*__gu_addr
     got unsigned int const [noderef] [usertype] <asn:1>*

linux/kernel/trace/trace.c:1219:15: warning: incorrect type in initializer (different modifiers)
     expected char [noderef] <asn:1>*__gu_addr
     got char const [noderef] <asn:1>*

A total of 14 warnings in my pseries build are squashed.
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a15d84d59356..71d81cbe3781 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -274,7 +274,7 @@ do {								\
 ({									\
 	long __gu_err = -EFAULT;					\
 	unsigned long  __gu_val = 0;					\
-	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-- 
2.9.3
