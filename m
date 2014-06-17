Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56DB31A0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:15:39 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/5] powerpc: Add ppc_global_function_entry()
Date: Tue, 17 Jun 2014 16:15:32 +1000
Message-Id: <1402985736-32180-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, dcb314@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ABIv2 has the concept of a global and local entry point to a function.
In most cases we are interested in the local entry point, and so that is
what ppc_function_entry() returns.

However we have a case in the ftrace code where we want the global entry
point, and there may be other places we need it too. Rather than special
casing each, add an accessor.

For ABIv1 and 32-bit there is only a single entry point, so we return
that. That means it's safe for the caller to use this without also
checking the ABI version.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/code-patching.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 37991e1..840a550 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -88,4 +88,15 @@ static inline unsigned long ppc_function_entry(void *func)
 #endif
 }
 
+static inline unsigned long ppc_global_function_entry(void *func)
+{
+#if defined(CONFIG_PPC64) && defined(_CALL_ELF) && _CALL_ELF == 2
+	/* PPC64 ABIv2 the global entry point is at the address */
+	return (unsigned long)func;
+#else
+	/* All other cases there is no change vs ppc_function_entry() */
+	return ppc_function_entry(func);
+#endif
+}
+
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
-- 
1.9.1
