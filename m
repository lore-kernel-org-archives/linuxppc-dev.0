Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAC8D1A0F7D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 15:30:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Work around gcc bug in current_thread_info()
Date: Thu,  8 Jan 2015 15:30:08 +1100
Message-Id: <1420691408-6334-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit a3e5b356b3ab "powerpc: Don't use local named register variable
in current_thread_info" Anton changed the way we did current_thread_info()
to accommodate LLVM, and it was not meant to have any effect elsewhere.

Unfortunately it has exposed a gcc bug, where r1 gets copied into
another register and then gcc uses that register to restore the toc
after a function call, even when that register is volatile and has been
clobbered by the function call.

We could revert Anton's patch, but it's not clear the original code is
safe either, we may just have been lucky.

The cleanest solution is to just use the existing CURRENT_THREAD_INFO()
asm macro, and call it using inline asm.

Fixes: a3e5b356b3ab ("powerpc: Don't use local named register variable in current_thread_info")
Reported-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/thread_info.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ebc4f165690a..cdafafe942e3 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -23,9 +23,9 @@
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
 #ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	clrrdi dest, sp, THREAD_SHIFT
+#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(clrrdi dest, sp, THREAD_SHIFT)
 #else
-#define CURRENT_THREAD_INFO(dest, sp)	rlwinm dest, sp, 0, 0, 31-THREAD_SHIFT
+#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(rlwinm dest, sp, 0, 0, 31-THREAD_SHIFT)
 #endif
 
 #ifndef __ASSEMBLY__
@@ -71,12 +71,13 @@ struct thread_info {
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
 /* how to get the thread information struct from C */
-register unsigned long __current_r1 asm("r1");
 static inline struct thread_info *current_thread_info(void)
 {
-	/* gcc4, at least, is smart enough to turn this into a single
-	 * rlwinm for ppc32 and clrrdi for ppc64 */
-	return (struct thread_info *)(__current_r1 & ~(THREAD_SIZE-1));
+	unsigned long val;
+
+	asm volatile(CURRENT_THREAD_INFO(%0,1) : "=r" (val));
+
+	return (struct thread_info *)val;
 }
 
 #endif /* __ASSEMBLY__ */
-- 
2.1.0
