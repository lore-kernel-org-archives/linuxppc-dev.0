Return-Path: <dja@axtens.net>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBfvY5qXNzDqB6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 17:42:17 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id e4so22616500pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 22:42:17 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/3] powerpc/sparse: constify the address pointer in
 __get_user_nocheck
Date: Mon, 30 Jan 2017 17:41:54 +1100
Message-Id: <20170130064155.30281-3-dja@axtens.net>
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

In __get_user_nocheck, we create an intermediate pointer for the
user address we're about to fetch. We currently don't tag this
pointer as const. Make it const, as we are simply dereferencing
it, and it's scope is limited to the __get_user_nocheck macro.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

This squashes 52 sparse warnings in my pseries build. They're
similar to the ones squashed in the previous patch.
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 71d81cbe3781..44ded4193001 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -261,7 +261,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	unsigned long __gu_val;					\
-	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
-- 
2.9.3
