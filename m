Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 30 Mar 2006 17:12:59 +1100
Subject: [PATCH 3/5] powerpc: Move create_(instruction|branch|function_call)
	into util.h
In-Reply-To: <1143699173.339118.857634197021.qpush@concordia>
Message-Id: <20060330061300.0B12567B6C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These functions don't really belong in system.h, and they can't be there if
the next patch is going to work. So create util.h for them.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/crash_dump.c      |    1 
 arch/powerpc/platforms/powermac/smp.c |    1 
 include/asm-powerpc/system.h          |   48 -----------------------------
 include/asm-powerpc/util.h            |   56 ++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 48 deletions(-)

Index: to-merge/arch/powerpc/kernel/crash_dump.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash_dump.c
+++ to-merge/arch/powerpc/kernel/crash_dump.c
@@ -17,6 +17,7 @@
 #include <asm/lmb.h>
 #include <asm/firmware.h>
 #include <asm/uaccess.h>
+#include <asm/util.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
Index: to-merge/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/smp.c
+++ to-merge/arch/powerpc/platforms/powermac/smp.c
@@ -53,6 +53,7 @@
 #include <asm/keylargo.h>
 #include <asm/pmac_low_i2c.h>
 #include <asm/pmac_pfunc.h>
+#include <asm/util.h>
 
 #define DEBUG
 
Index: to-merge/include/asm-powerpc/system.h
===================================================================
--- to-merge.orig/include/asm-powerpc/system.h
+++ to-merge/include/asm-powerpc/system.h
@@ -378,54 +378,6 @@ extern void reloc_got2(unsigned long);
 
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
 
-static inline void create_instruction(unsigned long addr, unsigned int instr)
-{
-	unsigned int *p;
-	p  = (unsigned int *)addr;
-	*p = instr;
-	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (p));
-}
-
-/* Flags for create_branch:
- * "b"   == create_branch(addr, target, 0);
- * "ba"  == create_branch(addr, target, BRANCH_ABSOLUTE);
- * "bl"  == create_branch(addr, target, BRANCH_SET_LINK);
- * "bla" == create_branch(addr, target, BRANCH_ABSOLUTE | BRANCH_SET_LINK);
- */
-#define BRANCH_SET_LINK	0x1
-#define BRANCH_ABSOLUTE	0x2
-
-static inline void create_branch(unsigned long addr,
-		unsigned long target, int flags)
-{
-	unsigned int instruction;
-
-	if (! (flags & BRANCH_ABSOLUTE))
-		target = target - addr;
-
-	/* Mask out the flags and target, so they don't step on each other. */
-	instruction = 0x48000000 | (flags & 0x3) | (target & 0x03FFFFFC);
-
-	create_instruction(addr, instruction);
-}
-
-static inline void create_function_call(unsigned long addr, void * func)
-{
-	unsigned long func_addr;
-
-#ifdef CONFIG_PPC64
-	/*
-	 * On PPC64 the function pointer actually points to the function's
-	 * descriptor. The first entry in the descriptor is the address
-	 * of the function text.
-	 */
-	func_addr = *(unsigned long *)func;
-#else
-	func_addr = (unsigned long)func;
-#endif
-	create_branch(addr, func_addr, BRANCH_SET_LINK);
-}
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void account_system_vtime(struct task_struct *);
 #endif
Index: to-merge/include/asm-powerpc/util.h
===================================================================
--- /dev/null
+++ to-merge/include/asm-powerpc/util.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2005,2006 IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_UTIL_H
+#define _ASM_POWERPC_UTIL_H
+
+static inline void create_instruction(unsigned long addr, unsigned int instr)
+{
+	unsigned int *p;
+	p  = (unsigned int *)addr;
+	*p = instr;
+	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (p));
+}
+
+/* Flags for create_branch:
+ * "b"   == create_branch(addr, target, 0);
+ * "ba"  == create_branch(addr, target, BRANCH_ABSOLUTE);
+ * "bl"  == create_branch(addr, target, BRANCH_SET_LINK);
+ * "bla" == create_branch(addr, target, BRANCH_ABSOLUTE | BRANCH_SET_LINK);
+ */
+#define BRANCH_SET_LINK	0x1
+#define BRANCH_ABSOLUTE	0x2
+
+static inline void create_branch(unsigned long addr,
+		unsigned long target, int flags)
+{
+	unsigned int instruction;
+
+	if (! (flags & BRANCH_ABSOLUTE))
+		target = target - addr;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	instruction = 0x48000000 | (flags & 0x3) | (target & 0x03FFFFFC);
+
+	create_instruction(addr, instruction);
+}
+
+static inline void create_function_call(unsigned long addr, void *func)
+{
+	unsigned long func_addr;
+
+#ifdef CONFIG_PPC64
+	/*
+	 * On PPC64 the function pointer actually points to the function's
+	 * descriptor. The first entry in the descriptor is the address
+	 * of the function text.
+	 */
+	func_addr = *(unsigned long *)func;
+#else
+	func_addr = (unsigned long)func;
+#endif
+	create_branch(addr, func_addr, BRANCH_SET_LINK);
+}
+
+#endif /* _ASM_POWERPC_UTIL_H */
