Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d66e1bcc6428a3fde7665e09ded9a9331f5b480d.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 04/14] powerpc: Add ppc_function_entry() which gets the entry
	point for a function
Date: Tue, 24 Jun 2008 11:32:28 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because function pointers point to different things on 32-bit vs 64-bit,
add a macro that deals with dereferencing the OPD on 64-bit. The soon to
be merged ftrace wants this, as well as other code I am working on.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/code-patching.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index fdb187c..a45a7ff 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -10,6 +10,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <asm/types.h>
+
 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
  * "ba"  == create_branch(addr, target, BRANCH_ABSOLUTE);
@@ -24,4 +26,18 @@ unsigned int create_branch(const unsigned int *addr,
 void patch_branch(unsigned int *addr, unsigned long target, int flags);
 void patch_instruction(unsigned int *addr, unsigned int instr);
 
+static inline unsigned long ppc_function_entry(void *func)
+{
+#ifdef CONFIG_PPC64
+	/*
+	 * On PPC64 the function pointer actually points to the function's
+	 * descriptor. The first entry in the descriptor is the address
+	 * of the function text.
+	 */
+	return ((func_descr_t *)func)->entry;
+#else
+	return (unsigned long)func;
+#endif
+}
+
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
-- 
1.5.5
