Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <45fbc3cd7f6ce404d1e25bf01695fb629d86189d.1289189560.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Add jump label support
Date: Mon,  8 Nov 2010 15:12:46 +1100 (EST)
Cc: jbaron@redhat.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	"David S. Miller" <davem@davemloft.net>, Anton Blanchard <anton@samba.org>,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for the new "jump label" feature.

Built for 64 & 32 bit, tested on 64 bit. Survives a kernel build under
perf with all tracepoints enabled, and manual inspection of the patched
code looks right. But still, lightly tested, YMMV.

Unlike x86 and sparc we just merrily patch the code with no locks etc,
as far as I know this is safe, but I'm not really sure what the x86/sparc
code is protecting against so maybe it's not.

I also don't see any reason for us to implement the poke_early() routine,
even though sparc does.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig                  |    1 +
 arch/powerpc/include/asm/jump_label.h |   46 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile          |    1 +
 arch/powerpc/kernel/jump_label.c      |   23 ++++++++++++++++
 4 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b644719..301c5b7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -136,6 +136,7 @@ config PPC
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
+	select HAVE_ARCH_JUMP_LABEL
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
new file mode 100644
index 0000000..feffb86
--- /dev/null
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -0,0 +1,46 @@
+#ifndef _ASM_POWERPC_JUMP_LABEL_H
+#define _ASM_POWERPC_JUMP_LABEL_H
+
+/*
+ * Copyright 2010 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <asm/feature-fixups.h>
+
+#define JUMP_ENTRY_TYPE	stringify_in_c(FTR_ENTRY_LONG)
+
+#define JUMP_LABEL_NOP_SIZE 4
+
+#define JUMP_LABEL(key, label)					\
+do {								\
+	asm goto("1:\n\t"					\
+		 "nop\n\t"					\
+		 ".pushsection __jump_table,  \"a\"\n\t"	\
+		 JUMP_ENTRY_TYPE "1b, %l[" #label "], %c0\n\t"	\
+		 ".popsection \n\t"				\
+		 : :  "i" (key) :  : label);			\
+} while (0)
+
+#ifdef CONFIG_PPC64
+typedef u64 jump_label_t;
+#else
+typedef u32 jump_label_t;
+#endif
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_POWERPC_JUMP_LABEL_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 36c30f3..315e933 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o dbell.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= dbell.o
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 extra-y				:= head_$(CONFIG_WORD_SIZE).o
 extra-$(CONFIG_PPC_BOOK3E_32)	:= head_new_booke.o
diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
new file mode 100644
index 0000000..368d158
--- /dev/null
+++ b/arch/powerpc/kernel/jump_label.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2010 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+#include <asm/code-patching.h>
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	u32 *addr = (u32 *)(unsigned long)entry->code;
+
+	if (type == JUMP_LABEL_ENABLE)
+		patch_branch(addr, entry->target, 0);
+	else
+		patch_instruction(addr, PPC_INST_NOP);
+}
-- 
1.7.1
