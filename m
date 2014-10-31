Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB7891A0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 14:47:28 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ulrich.weigand@de.ibm.com
Subject: [PATCH 1/3] powerpc: Don't use local named register variable in
 current_thread_info
Date: Fri, 31 Oct 2014 14:47:25 +1100
Message-Id: <1414727247-31838-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LLVM doesn't support local named register variables and is unlikely
to. current_thread_info is using one, fix it by moving it out and
calling it __current_r1().

I gave it a bit of an obscure name because we don't want anyone else
using it - they should use current_stack_pointer(). This specific
case is performance critical and we can't afford to call a function
to get it. Furthermore it isn't important to know exactly where in
the stack we are since we mask the lower bits.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/thread_info.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index b034ecd..ebc4f16 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -71,13 +71,12 @@ struct thread_info {
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
 /* how to get the thread information struct from C */
+register unsigned long __current_r1 asm("r1");
 static inline struct thread_info *current_thread_info(void)
 {
-	register unsigned long sp asm("r1");
-
 	/* gcc4, at least, is smart enough to turn this into a single
 	 * rlwinm for ppc32 and clrrdi for ppc64 */
-	return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
+	return (struct thread_info *)(__current_r1 & ~(THREAD_SIZE-1));
 }
 
 #endif /* __ASSEMBLY__ */
-- 
1.9.1
