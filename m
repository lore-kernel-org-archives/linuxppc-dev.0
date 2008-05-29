Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <95ea86b673d9f1093abe4a54bc4ecc34a4ebcfac.1212042061.git.michael@ellerman.id.au>
In-Reply-To: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/6] Add ppc_function_entry() which gets the entry point for a
	function
Date: Thu, 29 May 2008 16:20:59 +1000 (EST)
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
index 41ecae8..0213a48 100644
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
@@ -23,4 +25,18 @@ unsigned int create_branch(unsigned long addr, unsigned long target, int flags);
 void patch_branch(unsigned long addr, unsigned long target, int flags);
 void patch_instruction(unsigned long addr, unsigned int instr);
 
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
