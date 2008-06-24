Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 01/14] powerpc: Move code patching code into
	arch/powerpc/lib/code-patching.c
Date: Tue, 24 Jun 2008 11:32:21 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We currently have a few routines for patching code in asm/system.h, because
they didn't fit anywhere else. I'd like to clean them up a little and add
some more, so first move them into a dedicated C file - they don't need to
be inlined.

While we're moving the code, drop create_function_call(), it's intended
caller never got merged and will be replaced in future with something
different.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

This series is also in my git tree:
http://git.kernel.org/?p=linux/kernel/git/mpe/linux-2.6.git


 arch/powerpc/kernel/crash_dump.c          |    1 +
 arch/powerpc/lib/Makefile                 |    2 +
 arch/powerpc/lib/code-patching.c          |   33 ++++++++++++++++++++
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |    1 +
 arch/powerpc/platforms/powermac/smp.c     |    1 +
 include/asm-powerpc/code-patching.h       |   25 +++++++++++++++
 include/asm-powerpc/system.h              |   48 -----------------------------
 7 files changed, 63 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 9ee3c52..35b9a66 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -14,6 +14,7 @@
 #include <linux/crash_dump.h>
 #include <linux/bootmem.h>
 #include <linux/lmb.h>
+#include <asm/code-patching.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/firmware.h>
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c71d37d..305c7df 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_SMP)	+= locks.o
 endif
 
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
+
+obj-y			+= code-patching.o
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
new file mode 100644
index 0000000..7afae88
--- /dev/null
+++ b/arch/powerpc/lib/code-patching.c
@@ -0,0 +1,33 @@
+/*
+ *  Copyright 2008 Michael Ellerman, IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <asm/code-patching.h>
+
+
+void create_instruction(unsigned long addr, unsigned int instr)
+{
+	unsigned int *p;
+	p  = (unsigned int *)addr;
+	*p = instr;
+	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (p));
+}
+
+void create_branch(unsigned long addr, unsigned long target, int flags)
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
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index ba55b0f..63f5585 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
+#include <asm/code-patching.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index cb2d894..bf202f7 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -36,6 +36,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
+#include <asm/code-patching.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
new file mode 100644
index 0000000..0b91fdf
--- /dev/null
+++ b/include/asm-powerpc/code-patching.h
@@ -0,0 +1,25 @@
+#ifndef _ASM_POWERPC_CODE_PATCHING_H
+#define _ASM_POWERPC_CODE_PATCHING_H
+
+/*
+ * Copyright 2008, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
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
+extern void create_branch(unsigned long addr, unsigned long target, int flags);
+extern void create_instruction(unsigned long addr, unsigned int instr);
+
+#endif /* _ASM_POWERPC_CODE_PATCHING_H */
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index df781ad..d141e48 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -519,54 +519,6 @@ extern void reloc_got2(unsigned long);
 
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
-- 
1.5.5
