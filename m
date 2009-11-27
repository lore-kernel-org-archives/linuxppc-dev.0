Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9ADD01007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 09:33:37 +1100 (EST)
Date: Sat, 28 Nov 2009 01:33:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 1/8] Rename uprobes_ppc64.c to uprobes_ppc.c, use it for ppc32
Message-ID: <20091127223336.GA21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code *looks* generic enough, so I think it can be used for ppc32
without modifications.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 runtime/uprobes/uprobes_arch.c  |    4 +-
 runtime/uprobes/uprobes_arch.h  |    4 +-
 runtime/uprobes/uprobes_ppc.c   |  147 +++++++++++++++++++++++++++++++++++++++
 runtime/uprobes/uprobes_ppc.h   |   82 ++++++++++++++++++++++
 runtime/uprobes/uprobes_ppc64.c |  147 ---------------------------------------
 runtime/uprobes/uprobes_ppc64.h |   82 ----------------------
 runtime/uprobes2/uprobes_arch.c |    4 +-
 runtime/uprobes2/uprobes_arch.h |    4 +-
 8 files changed, 237 insertions(+), 237 deletions(-)
 create mode 100644 runtime/uprobes/uprobes_ppc.c
 create mode 100644 runtime/uprobes/uprobes_ppc.h
 delete mode 100644 runtime/uprobes/uprobes_ppc64.c
 delete mode 100644 runtime/uprobes/uprobes_ppc64.h

diff --git a/runtime/uprobes/uprobes_arch.c b/runtime/uprobes/uprobes_arch.c
index 99ef54c..6c58d5f 100644
--- a/runtime/uprobes/uprobes_arch.c
+++ b/runtime/uprobes/uprobes_arch.c
@@ -2,8 +2,8 @@
 #include "uprobes_x86_64.c"
 #elif defined (__i386__)
 #include "uprobes_i386.c"
-#elif defined (__powerpc64__)
-#include "uprobes_ppc64.c"
+#elif defined (__powerpc__)
+#include "uprobes_ppc.c"
 #elif defined (__s390__) || defined (__s390x__)
 #include "uprobes_s390.c"
 #else
diff --git a/runtime/uprobes/uprobes_arch.h b/runtime/uprobes/uprobes_arch.h
index 0223e28..f642f52 100644
--- a/runtime/uprobes/uprobes_arch.h
+++ b/runtime/uprobes/uprobes_arch.h
@@ -2,8 +2,8 @@
 #include "uprobes_x86_64.h"
 #elif defined (__i386__)
 #include "uprobes_i386.h"
-#elif defined (__powerpc64__)
-#include "uprobes_ppc64.h"
+#elif defined (__powerpc__)
+#include "uprobes_ppc.h"
 #elif defined (__s390__) || defined (__s390x__)
 #include "uprobes_s390.h"
 #else
diff --git a/runtime/uprobes/uprobes_ppc.c b/runtime/uprobes/uprobes_ppc.c
new file mode 100644
index 0000000..819ac73
--- /dev/null
+++ b/runtime/uprobes/uprobes_ppc.c
@@ -0,0 +1,147 @@
+/*
+ * Userspace Probes (UProbes) for PowerPC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright IBM Corporation, 2007
+ */
+/*
+ * In versions of uprobes built in the SystemTap runtime, this file
+ * is #included at the end of uprobes.c.
+ */
+
+/*
+ * Replace the return address with the trampoline address.  Returns
+ * the original return address.
+ */
+static
+unsigned long arch_hijack_uret_addr(unsigned long trampoline_address,
+		struct pt_regs *regs, struct uprobe_task *utask)
+{
+	unsigned long orig_ret_addr = regs->link;
+
+	regs->link = trampoline_address;
+	return orig_ret_addr;
+}
+
+/*
+ * Get an instruction slot from the process's SSOL area, containing the
+ * instruction at ppt's probepoint.  Point the eip at that slot, in preparation
+ * for single-stepping out of line.
+ */
+static
+void uprobe_pre_ssout(struct uprobe_task *utask, struct uprobe_probept *ppt,
+		struct pt_regs *regs)
+{
+	struct uprobe_ssol_slot *slot;
+
+	slot = uprobe_get_insn_slot(ppt);
+	if (!slot) {
+		utask->doomed = 1;
+		return;
+	}
+	regs->nip = (long)slot->insn;
+}
+
+
+static inline void calc_offset(struct uprobe_probept *ppt,
+	       struct pt_regs *regs)
+{
+	int offset = 0;
+	unsigned int opcode = 0;
+	unsigned int insn = *ppt->insn;
+
+	opcode = insn >> 26;
+	switch (opcode) {
+	case 16:	/* bc */
+		if ((insn & 2) == 0) {
+			offset = (signed short)(insn & 0xfffc);
+			regs->nip = ppt->vaddr + offset;
+		}
+		if (insn & 1)
+			regs->link = ppt->vaddr + MAX_UINSN_BYTES;
+		break;
+	case 17:	/* sc */
+		/* Do we need to do anything */
+		break;
+	case 18:	/* b */
+		if ((insn & 2) == 0) {
+			offset = insn & 0x03fffffc;
+			if (offset & 0x02000000)
+				offset -= 0x04000000;
+			regs->nip = ppt->vaddr + offset;
+		}
+		if (insn & 1)
+			regs->link = ppt->vaddr + MAX_UINSN_BYTES;
+		break;
+	}
+#ifdef UPROBES_DEBUG
+	printk (KERN_ERR "ppt->vaddr=%p, regs->nip=%p, offset=%ld\n",
+			ppt->vaddr, regs->nip, offset);
+	if (insn & 1)
+		printk (KERN_ERR "regs->link=%p \n", regs->link);
+#endif
+	return;
+}
+
+/*
+ * Called after single-stepping.  ppt->vaddr is the address of the
+ * instruction which was replaced by a breakpoint instruction.  To avoid
+ * the SMP problems that can occur when we temporarily put back the
+ * original opcode to single-step, we single-stepped a copy of the
+ * instruction.
+ *
+ * This function prepares to return from the post-single-step
+ * interrupt.
+ *
+ * 1) Typically, the new nip is relative to the copied instruction.  We
+ * need to make it relative to the original instruction.  Exceptions are
+ * branch instructions.
+ *
+ * 2) For branch instructions, update the nip if the branch uses
+ * relative addressing.  Update the link instruction to the instruction
+ * following the original instruction address.
+ */
+
+static
+void uprobe_post_ssout(struct uprobe_task *utask, struct uprobe_probept *ppt,
+		struct pt_regs *regs)
+{
+	unsigned long copy_nip;
+
+	copy_nip = (unsigned long) ppt->slot->insn;
+	up_read(&ppt->slot->rwsem);
+
+	/*
+	 * If the single stepped instruction is non-branch instruction
+	 * then update the IP to be relative to probepoint.
+	 */
+	if (regs->nip == copy_nip + MAX_UINSN_BYTES)
+		regs->nip = ppt->vaddr + MAX_UINSN_BYTES;
+	else
+		calc_offset(ppt,regs);
+}
+
+static
+int arch_validate_probed_insn(struct uprobe_probept *ppt,
+		 struct task_struct *tsk)
+{
+	if ((unsigned long)ppt->vaddr & 0x03) {
+		printk(KERN_WARNING
+			"Attempt to register uprobe at an unaligned addr\n");
+		return -EINVAL;
+	}
+	return 0;
+}
diff --git a/runtime/uprobes/uprobes_ppc.h b/runtime/uprobes/uprobes_ppc.h
new file mode 100644
index 0000000..5604635
--- /dev/null
+++ b/runtime/uprobes/uprobes_ppc.h
@@ -0,0 +1,82 @@
+#ifndef _ASM_UPROBES_H
+#define _ASM_UPROBES_H
+/*
+ * Userspace Probes (UProbes) for PowerPC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright IBM Corporation, 2007
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/signal.h>
+
+#define BREAKPOINT_SIGNAL SIGTRAP
+#define SSTEP_SIGNAL SIGTRAP
+
+/* Normally defined in Kconfig */
+#define CONFIG_UPROBES_SSOL
+#define CONFIG_URETPROBES 1
+
+typedef unsigned int uprobe_opcode_t;
+#define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
+#define BP_INSN_SIZE 4
+#define MAX_UINSN_BYTES 4
+#define SLOT_IP(tsk) 32	/* instruction pointer slot from include/asm/elf.h */
+
+struct uprobe_probept_arch_info {};
+struct uprobe_task_arch_info {};
+
+/* Architecture specific switch for where the IP points after a bp hit */
+#define ARCH_BP_INST_PTR(inst_ptr)	(inst_ptr)
+
+struct uprobe_probept;
+struct uprobe_task;
+struct task_struct;
+
+/* On powerpc, nip points to the trap. */
+static inline unsigned long arch_get_probept(struct pt_regs *regs)
+{
+	return (unsigned long)(regs->nip);
+}
+
+static inline void arch_reset_ip_for_sstep(struct pt_regs *regs)
+{
+}
+
+static inline int arch_validate_probed_insn(struct uprobe_probept *ppt,
+						struct task_struct *tsk);
+
+static unsigned long arch_hijack_uret_addr(unsigned long trampoline_addr,
+		struct pt_regs *regs, struct uprobe_task *utask);
+
+static inline void arch_restore_uret_addr(unsigned long ret_addr,
+		struct pt_regs *regs)
+{
+	regs->nip = ret_addr;
+}
+
+static unsigned long arch_get_cur_sp(struct pt_regs *regs)
+{
+	return (unsigned long)(regs->gpr[1]);
+}
+
+static unsigned long arch_predict_sp_at_ret(struct pt_regs *regs,
+		struct task_struct *tsk)
+{
+	return (unsigned long)(regs->gpr[1]);
+}
+
+#endif				/* _ASM_UPROBES_H */
diff --git a/runtime/uprobes/uprobes_ppc64.c b/runtime/uprobes/uprobes_ppc64.c
deleted file mode 100644
index 819ac73..0000000
--- a/runtime/uprobes/uprobes_ppc64.c
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * Userspace Probes (UProbes) for PowerPC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright IBM Corporation, 2007
- */
-/*
- * In versions of uprobes built in the SystemTap runtime, this file
- * is #included at the end of uprobes.c.
- */
-
-/*
- * Replace the return address with the trampoline address.  Returns
- * the original return address.
- */
-static
-unsigned long arch_hijack_uret_addr(unsigned long trampoline_address,
-		struct pt_regs *regs, struct uprobe_task *utask)
-{
-	unsigned long orig_ret_addr = regs->link;
-
-	regs->link = trampoline_address;
-	return orig_ret_addr;
-}
-
-/*
- * Get an instruction slot from the process's SSOL area, containing the
- * instruction at ppt's probepoint.  Point the eip at that slot, in preparation
- * for single-stepping out of line.
- */
-static
-void uprobe_pre_ssout(struct uprobe_task *utask, struct uprobe_probept *ppt,
-		struct pt_regs *regs)
-{
-	struct uprobe_ssol_slot *slot;
-
-	slot = uprobe_get_insn_slot(ppt);
-	if (!slot) {
-		utask->doomed = 1;
-		return;
-	}
-	regs->nip = (long)slot->insn;
-}
-
-
-static inline void calc_offset(struct uprobe_probept *ppt,
-	       struct pt_regs *regs)
-{
-	int offset = 0;
-	unsigned int opcode = 0;
-	unsigned int insn = *ppt->insn;
-
-	opcode = insn >> 26;
-	switch (opcode) {
-	case 16:	/* bc */
-		if ((insn & 2) == 0) {
-			offset = (signed short)(insn & 0xfffc);
-			regs->nip = ppt->vaddr + offset;
-		}
-		if (insn & 1)
-			regs->link = ppt->vaddr + MAX_UINSN_BYTES;
-		break;
-	case 17:	/* sc */
-		/* Do we need to do anything */
-		break;
-	case 18:	/* b */
-		if ((insn & 2) == 0) {
-			offset = insn & 0x03fffffc;
-			if (offset & 0x02000000)
-				offset -= 0x04000000;
-			regs->nip = ppt->vaddr + offset;
-		}
-		if (insn & 1)
-			regs->link = ppt->vaddr + MAX_UINSN_BYTES;
-		break;
-	}
-#ifdef UPROBES_DEBUG
-	printk (KERN_ERR "ppt->vaddr=%p, regs->nip=%p, offset=%ld\n",
-			ppt->vaddr, regs->nip, offset);
-	if (insn & 1)
-		printk (KERN_ERR "regs->link=%p \n", regs->link);
-#endif
-	return;
-}
-
-/*
- * Called after single-stepping.  ppt->vaddr is the address of the
- * instruction which was replaced by a breakpoint instruction.  To avoid
- * the SMP problems that can occur when we temporarily put back the
- * original opcode to single-step, we single-stepped a copy of the
- * instruction.
- *
- * This function prepares to return from the post-single-step
- * interrupt.
- *
- * 1) Typically, the new nip is relative to the copied instruction.  We
- * need to make it relative to the original instruction.  Exceptions are
- * branch instructions.
- *
- * 2) For branch instructions, update the nip if the branch uses
- * relative addressing.  Update the link instruction to the instruction
- * following the original instruction address.
- */
-
-static
-void uprobe_post_ssout(struct uprobe_task *utask, struct uprobe_probept *ppt,
-		struct pt_regs *regs)
-{
-	unsigned long copy_nip;
-
-	copy_nip = (unsigned long) ppt->slot->insn;
-	up_read(&ppt->slot->rwsem);
-
-	/*
-	 * If the single stepped instruction is non-branch instruction
-	 * then update the IP to be relative to probepoint.
-	 */
-	if (regs->nip == copy_nip + MAX_UINSN_BYTES)
-		regs->nip = ppt->vaddr + MAX_UINSN_BYTES;
-	else
-		calc_offset(ppt,regs);
-}
-
-static
-int arch_validate_probed_insn(struct uprobe_probept *ppt,
-		 struct task_struct *tsk)
-{
-	if ((unsigned long)ppt->vaddr & 0x03) {
-		printk(KERN_WARNING
-			"Attempt to register uprobe at an unaligned addr\n");
-		return -EINVAL;
-	}
-	return 0;
-}
diff --git a/runtime/uprobes/uprobes_ppc64.h b/runtime/uprobes/uprobes_ppc64.h
deleted file mode 100644
index 5604635..0000000
--- a/runtime/uprobes/uprobes_ppc64.h
+++ /dev/null
@@ -1,82 +0,0 @@
-#ifndef _ASM_UPROBES_H
-#define _ASM_UPROBES_H
-/*
- * Userspace Probes (UProbes) for PowerPC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright IBM Corporation, 2007
- */
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/signal.h>
-
-#define BREAKPOINT_SIGNAL SIGTRAP
-#define SSTEP_SIGNAL SIGTRAP
-
-/* Normally defined in Kconfig */
-#define CONFIG_UPROBES_SSOL
-#define CONFIG_URETPROBES 1
-
-typedef unsigned int uprobe_opcode_t;
-#define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
-#define BP_INSN_SIZE 4
-#define MAX_UINSN_BYTES 4
-#define SLOT_IP(tsk) 32	/* instruction pointer slot from include/asm/elf.h */
-
-struct uprobe_probept_arch_info {};
-struct uprobe_task_arch_info {};
-
-/* Architecture specific switch for where the IP points after a bp hit */
-#define ARCH_BP_INST_PTR(inst_ptr)	(inst_ptr)
-
-struct uprobe_probept;
-struct uprobe_task;
-struct task_struct;
-
-/* On powerpc, nip points to the trap. */
-static inline unsigned long arch_get_probept(struct pt_regs *regs)
-{
-	return (unsigned long)(regs->nip);
-}
-
-static inline void arch_reset_ip_for_sstep(struct pt_regs *regs)
-{
-}
-
-static inline int arch_validate_probed_insn(struct uprobe_probept *ppt,
-						struct task_struct *tsk);
-
-static unsigned long arch_hijack_uret_addr(unsigned long trampoline_addr,
-		struct pt_regs *regs, struct uprobe_task *utask);
-
-static inline void arch_restore_uret_addr(unsigned long ret_addr,
-		struct pt_regs *regs)
-{
-	regs->nip = ret_addr;
-}
-
-static unsigned long arch_get_cur_sp(struct pt_regs *regs)
-{
-	return (unsigned long)(regs->gpr[1]);
-}
-
-static unsigned long arch_predict_sp_at_ret(struct pt_regs *regs,
-		struct task_struct *tsk)
-{
-	return (unsigned long)(regs->gpr[1]);
-}
-
-#endif				/* _ASM_UPROBES_H */
diff --git a/runtime/uprobes2/uprobes_arch.c b/runtime/uprobes2/uprobes_arch.c
index 3c86804..a91d5b6 100644
--- a/runtime/uprobes2/uprobes_arch.c
+++ b/runtime/uprobes2/uprobes_arch.c
@@ -1,7 +1,7 @@
 #if defined (__x86_64__) || defined(__i386)
 #include "uprobes_x86.c"
-#elif defined (__powerpc64__)
-#include "../uprobes/uprobes_ppc64.c"
+#elif defined (__powerpc__)
+#include "../uprobes/uprobes_ppc.c"
 #elif defined (__s390__) || defined (__s390x__)
 #include "../uprobes/uprobes_s390.c"
 #elif defined (__ia64__)
diff --git a/runtime/uprobes2/uprobes_arch.h b/runtime/uprobes2/uprobes_arch.h
index 87e0cc8..cce5775 100644
--- a/runtime/uprobes2/uprobes_arch.h
+++ b/runtime/uprobes2/uprobes_arch.h
@@ -1,7 +1,7 @@
 #if defined (__x86_64__) || defined(__i386)
 #include "uprobes_x86.h"
-#elif defined (__powerpc64__)
-#include "../uprobes/uprobes_ppc64.h"
+#elif defined (__powerpc__)
+#include "../uprobes/uprobes_ppc.h"
 #elif defined (__s390__) || defined (__s390x__)
 #include "../uprobes/uprobes_s390.h"
 #elif defined (__ia64__)
-- 
1.6.3.3
