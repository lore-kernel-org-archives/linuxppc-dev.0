Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E13E7B6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 15:17:10 +1000 (EST)
Subject: [PATCH v2] powerpc: Add jump label support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jun 2011 15:16:59 +1000
Message-ID: <1309411019.14501.204.camel@pasglop>
Mime-Version: 1.0
Cc: Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

This patch adds support for the new "jump label" feature.

Unlike x86 and sparc we just merrily patch the code with no locks etc,
as far as I know this is safe, but I'm not really sure what the x86/sparc
code is protecting against so maybe it's not.

I also don't see any reason for us to implement the poke_early() routine,
even though sparc does.

[BenH: Updated the patch to upstream generic changes]

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

If no objection I'll stick that in powerpc -next tomorrow, it's been around
for a while, and it seems to just work so ...

 arch/powerpc/Kconfig                  |    1 +
 arch/powerpc/include/asm/jump_label.h |   47 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile          |    1 +
 arch/powerpc/kernel/jump_label.c      |   23 ++++++++++++++++
 4 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/jump_label.h
 create mode 100644 arch/powerpc/kernel/jump_label.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2729c66..c15f2e6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select GENERIC_IRQ_SHOW_LEVEL
 	select HAVE_RCU_TABLE_FREE if SMP
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_ARCH_JUMP_LABEL
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
new file mode 100644
index 0000000..1f780b9
--- /dev/null
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -0,0 +1,47 @@
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
+#include <linux/types.h>
+
+#include <asm/feature-fixups.h>
+
+#define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
+#define JUMP_LABEL_NOP_SIZE	4
+
+static __always_inline bool arch_static_branch(struct jump_label_key *key)
+{
+	asm goto("1:\n\t"
+		 "nop\n\t"
+		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".align 4\n\t"
+		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
+		 ".popsection \n\t"
+		 : :  "i" (key) : : l_yes);
+	return false;
+l_yes:
+	return true;
+}
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
+	jump_label_t pad;
+};
+
+#endif /* _ASM_POWERPC_JUMP_LABEL_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index e8b9818..ce4f7f1 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o dbell.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= dbell.o
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 extra-y				:= head_$(CONFIG_WORD_SIZE).o
 extra-$(CONFIG_40x)		:= head_40x.o
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
