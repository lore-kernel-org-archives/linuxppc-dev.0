Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE3341A0F63
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:28:55 +1100 (AEDT)
In-Reply-To: <20151204152419.28E0D691D2@newverein.lst.de>
References: <20151204152419.28E0D691D2@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Fri, 4 Dec 2015 15:11:37 +0100
Subject: [PATCH v5 8/9] Implement kernel live patching for ppc64le (ABIv2)
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 Petr Mladek <pmladek@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151204152852.BF36B691D3@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  * create the appropriate files+functions
    arch/powerpc/include/asm/livepatch.h
        klp_check_compiler_support,
        klp_arch_set_pc
    arch/powerpc/kernel/livepatch.c with a stub for
        klp_write_module_reloc
    This is architecture-independent work in progress.
  * introduce a fixup in arch/powerpc/kernel/entry_64.S
    for local calls that are becoming global due to live patching.
    And of course do the main KLP thing: return to a maybe different
    address, possibly altered by the live patching ftrace op.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/include/asm/livepatch.h | 45 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/entry_64.S       | 51 +++++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/livepatch.c      | 38 +++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/include/asm/livepatch.h
 create mode 100644 arch/powerpc/kernel/livepatch.c

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
new file mode 100644
index 0000000..3200c11
--- /dev/null
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -0,0 +1,45 @@
+/*
+ * livepatch.h - powerpc-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _ASM_POWERPC64_LIVEPATCH_H
+#define _ASM_POWERPC64_LIVEPATCH_H
+
+#include <linux/module.h>
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_LIVEPATCH
+static inline int klp_check_compiler_support(void)
+{
+#if !defined(_CALL_ELF) || _CALL_ELF != 2 || !defined(CC_USING_MPROFILE_KERNEL)
+	return 1;
+#endif
+	return 0;
+}
+
+extern int klp_write_module_reloc(struct module *mod, unsigned long type,
+				   unsigned long loc, unsigned long value);
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->nip = ip;
+}
+#else
+#error Live patching support is disabled; check CONFIG_LIVEPATCH
+#endif
+
+#endif /* _ASM_POWERPC64_LIVEPATCH_H */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 294a9ca..09af904 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1265,6 +1265,9 @@ _GLOBAL(ftrace_caller)
 	mflr    r3
 	std     r3, _NIP(r1)
 	std	r3, 16(r1)
+#ifdef CONFIG_LIVEPATCH
+	mr	r14,r3		/* remember old NIP */
+#endif
 	subi    r3, r3, MCOUNT_INSN_SIZE
 	mfmsr   r4
 	std     r4, _MSR(r1)
@@ -1281,7 +1284,10 @@ ftrace_call:
 	nop
 
 	ld	r3, _NIP(r1)
-	mtlr	r3
+	mtctr	r3		/* prepare to jump there */
+#ifdef CONFIG_LIVEPATCH
+	cmpd	r14,r3		/* has NIP been altered? */
+#endif
 
 	REST_8GPRS(0,r1)
 	REST_8GPRS(8,r1)
@@ -1294,6 +1300,27 @@ ftrace_call:
 	mtlr	r12
 	mr	r2,r0		/* restore callee's TOC */
 
+#ifdef CONFIG_LIVEPATCH
+	beq+	4f		/* likely(old_NIP == new_NIP) */
+
+	/* For a local call, restore this TOC after calling the patch function.
+	 * For a global call, it does not matter what we restore here,
+	 * since the global caller does its own restore right afterwards,
+	 * anyway. Just insert a KLP_return_helper frame in any case,
+	 * so a patch function can always count on the changed stack offsets.
+	 */
+	stdu	r1,-32(r1)	/* open new mini stack frame */
+	std	r0,24(r1)	/* save TOC now, unconditionally. */
+	bl	5f
+5:	mflr	r12
+	addi	r12,r12,(KLP_return_helper+4-.)@l
+	std	r12,LRSAVE(r1)
+	mtlr	r12
+	mfctr	r12		/* allow for TOC calculation in newfunc */
+	bctr
+4:
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	stdu	r1, -112(r1)
 .globl ftrace_graph_call
@@ -1303,15 +1330,31 @@ _GLOBAL(ftrace_graph_stub)
 	addi	r1, r1, 112
 #endif
 
-	mflr	r0		/* move this LR to CTR */
-	mtctr	r0
-
 	ld	r0,LRSAVE(r1)	/* restore callee's lr at _mcount site */
 	mtlr	r0
 	bctr			/* jump after _mcount site */
 #endif /* CC_USING_MPROFILE_KERNEL */
 _GLOBAL(ftrace_stub)
 	blr
+
+#ifdef CONFIG_LIVEPATCH
+/* Helper function for local calls that are becoming global
+   due to live patching.
+   We can't simply patch the NOP after the original call,
+   because, depending on the consistency model, some kernel
+   threads may still have called the original, local function
+   *without* saving their TOC in the respective stack frame slot,
+   so the decision is made per-thread during function return by
+   maybe inserting a KLP_return_helper frame or not.
+*/
+KLP_return_helper:
+	ld	r2,24(r1)	/* restore TOC (saved by ftrace_caller) */
+	addi r1, r1, 32		/* destroy mini stack frame */
+	ld	r0,LRSAVE(r1)	/* get the real return address */
+	mtlr	r0
+	blr
+#endif
+
 #else
 _GLOBAL_TOC(_mcount)
 	/* Taken from output of objdump from lib64/glibc */
diff --git a/arch/powerpc/kernel/livepatch.c b/arch/powerpc/kernel/livepatch.c
new file mode 100644
index 0000000..564eafa
--- /dev/null
+++ b/arch/powerpc/kernel/livepatch.c
@@ -0,0 +1,38 @@
+/*
+ * livepatch.c - powerpc-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/module.h>
+#include <asm/livepatch.h>
+
+/**
+ * klp_write_module_reloc() - write a relocation in a module
+ * @mod:       module in which the section to be modified is found
+ * @type:      ELF relocation type (see asm/elf.h)
+ * @loc:       address that the relocation should be written to
+ * @value:     relocation value (sym address + addend)
+ *
+ * This function writes a relocation to the specified location for
+ * a particular module.
+ */
+int klp_write_module_reloc(struct module *mod, unsigned long type,
+			    unsigned long loc, unsigned long value)
+{
+	/* This requires infrastructure changes; we need the loadinfos. */
+	pr_err("lpc_write_module_reloc not yet supported\n");
+	return -ENOSYS;
+}
-- 
1.8.5.6
