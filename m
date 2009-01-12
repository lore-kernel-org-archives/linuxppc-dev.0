Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7987BDDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 08:17:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n0CLGxt8024745
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 15:17:00 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Unify opcode definitions and support
Date: Mon, 12 Jan 2009 15:16:59 -0600
Message-Id: <1231795019-10907-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Create a new header that becomes a single location for defining PowerPC
opcodes used by code that is either generationg instructions
at runtime (fixups, debug, etc.), emulating instructions, or just
compiling instructions old assemblers don't know about.

We currently don't handle the floating point emulation or alignment decode
as both are better handled by the specific decode support they already
have.

Added support for the new dcbzl, dcbal, msgsnd, tlbilx, & wait instructions
since older assemblers don't know about them.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/code-patching.h |    4 +-
 arch/powerpc/include/asm/ppc-opcode.h    |   66 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/ppc_asm.h       |    6 +--
 arch/powerpc/kernel/crash_dump.c         |    2 +-
 arch/powerpc/kernel/ftrace.c             |    8 ++--
 arch/powerpc/kernel/module_64.c          |    2 +-
 arch/powerpc/kernel/traps.c              |    1 +
 arch/powerpc/lib/feature-fixups.c        |    4 +-
 8 files changed, 77 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/include/asm/ppc-opcode.h

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 107d9b9..37c32ab 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -11,9 +11,7 @@
  */
 
 #include <asm/types.h>
-
-#define PPC_NOP_INSTR		0x60000000
-#define PPC_LWSYNC_INSTR	0x7c2004ac
+#include <asm/ppc-opcode.h>
 
 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
new file mode 100644
index 0000000..299348f
--- /dev/null
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2009 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * provides masks and opcode images for use by code generation, emulation
+ * and for instructions that older assemblers might not know about
+ */
+#ifndef _ASM_POWERPC_PPC_OPCODE_H
+#define _ASM_POWERPC_PPC_OPCODE_H
+
+#include <linux/stringify.h>
+#include <asm/asm-compat.h>
+
+/* sorted alphabetically */
+#define INST_DCBA		0x7c0005ec
+#define INST_DCBA_MASK		0xfc0007fe
+#define INST_DCBAL		0x7c2005ec
+#define INST_DCBZL		0x7c2007ec
+#define INST_ISEL		0x7c00001e
+#define INST_ISEL_MASK		0xfc00003e
+#define INST_LSWI		0x7c0004aa
+#define INST_LSWX		0x7c00042a
+#define INST_LWSYNC		0x7c2004ac
+#define INST_MCRXR		0x7c000400
+#define INST_MCRXR_MASK		0xfc0007fe
+#define INST_MFSPR_PVR		0x7c1f42a6
+#define INST_MFSPR_PVR_MASK	0xfc1fffff
+#define INST_MSGSND		0x7c00019c
+#define INST_NOP		0x60000000
+#define INST_POPCNTB		0x7c0000f4
+#define INST_POPCNTB_MASK	0xfc0007fe
+#define INST_RFCI		0x4c000066
+#define INST_RFDI		0x4c00004e
+#define INST_RFMCI		0x4c00004c
+
+#define INST_STRING		0x7c00042a
+#define INST_STRING_MASK	0xfc0007fe
+#define INST_STRING_GEN_MASK	0xfc00067e
+
+#define INST_STSWI		0x7c0005aa
+#define INST_STSWX		0x7c00052a
+#define INST_TLBILX		0x7c000626
+#define INST_WAIT		0x7c00007c
+
+/* macros to insert fields into opcodes */
+#define __PPC_RA(a)	((a & 0x1f) << 16)
+#define __PPC_RB(b)	((b & 0x1f) << 11)
+#define __PPC_T_TLB(t)	((t & 0x3) << 21)
+
+/* Deal with instructions that older assemblers aren't aware of
+ * use PPC_ prefix if we might have a conflict */
+#define	DCBAL(a, b)		stringify_in_c(.long INST_DCBAL | \
+					__PPC_RA(a) | __PPC_RB(b))
+#define	DCBZL(a, b)		stringify_in_c(.long INST_DCBZL | \
+					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_MSGSND(b)		stringify_in_c(.long INST_MSGSND | __PPC_RB(b))
+#define RFCI			stringify_in_c(.long INST_RFCI)
+#define RFDI			stringify_in_c(.long INST_RFDI)
+#define RFMCI			stringify_in_c(.long INST_RFMCI)
+#define TLBILX(t, a, b)		stringify_in_c(.long INST_TLBILX | \
+					__T_TLB(t) | __PPC_RA(a) | __PPC_RB(b))
+#define TLBILX_ALL(a, b)	TLBILX(0, a, b)
+#define TLBILX_PID(a, b)	TLBILX(1, a, b)
+#define TLBILX_VA(a, b)		TLBILX(3, a, b)
+#define PPC_WAIT		stringify_in_c(.long INST_WAIT)
+
+#endif /* _ASM_POWERPC_PPC_OPCODE_H */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 1a0d628..f59a666 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -7,6 +7,7 @@
 #include <linux/stringify.h>
 #include <asm/asm-compat.h>
 #include <asm/processor.h>
+#include <asm/ppc-opcode.h>
 
 #ifndef __ASSEMBLY__
 #error __FILE__ should only be used in assembler files
@@ -167,11 +168,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
 #define HMT_MEDIUM_HIGH or	5,5,5		# medium high priority
 #define HMT_HIGH	or	3,3,3
 
-/* handle instructions that older assemblers may not know */
-#define RFCI		.long 0x4c000066	/* rfci instruction */
-#define RFDI		.long 0x4c00004e	/* rfdi instruction */
-#define RFMCI		.long 0x4c00004c	/* rfmci instruction */
-
 #ifdef __KERNEL__
 #ifdef CONFIG_PPC64
 
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 19671ac..1f9d1bf 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -48,7 +48,7 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
-	patch_instruction(p, PPC_NOP_INSTR);
+	patch_instruction(p, INST_NOP);
 	patch_branch(++p, addr + PHYSICAL_START, 0);
 }
 
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 5355244..1114295 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -26,7 +26,7 @@
 #define DEBUGP(fmt , ...)	do { } while (0)
 #endif
 
-static unsigned int ftrace_nop = PPC_NOP_INSTR;
+static unsigned int ftrace_nop = INST_NOP;
 
 #ifdef CONFIG_PPC32
 # define GET_ADDR(addr) addr
@@ -319,7 +319,7 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-	op = PPC_NOP_INSTR;
+	op = INST_NOP;
 
 	if (probe_kernel_write((void *)ip, &op, MCOUNT_INSN_SIZE))
 		return -EPERM;
@@ -391,7 +391,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 *  b +8; ld r2,40(r1)
 	 */
 	if (((op[0] != 0x48000008) || (op[1] != 0xe8410028)) &&
-	    ((op[0] != PPC_NOP_INSTR) || (op[1] != PPC_NOP_INSTR))) {
+	    ((op[0] != INST_NOP) || (op[1] != INST_NOP))) {
 		printk(KERN_ERR "Expected NOPs but have %x %x\n", op[0], op[1]);
 		return -EINVAL;
 	}
@@ -434,7 +434,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EFAULT;
 
 	/* It should be pointing to a nop */
-	if (op != PPC_NOP_INSTR) {
+	if (op != INST_NOP) {
 		printk(KERN_ERR "Expected NOP but have %x\n", op);
 		return -EINVAL;
 	}
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8992b03..c4b5a1f 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -329,7 +329,7 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
-	if (*instruction != PPC_NOP_INSTR) {
+	if (*instruction != INST_NOP) {
 		printk("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5457e95..53b2687 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -52,6 +52,7 @@
 #include <asm/processor.h>
 #endif
 #include <asm/kexec.h>
+#include <asm/ppc-opcode.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs);
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 8c5a03b..b6712c6 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -85,7 +85,7 @@ static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
 	}
 
 	for (; dest < end; dest++)
-		patch_instruction(dest, PPC_NOP_INSTR);
+		patch_instruction(dest, INST_NOP);
 
 	return 0;
 }
@@ -122,7 +122,7 @@ void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 
 	for (; start < end; start++) {
 		dest = (void *)start + *start;
-		patch_instruction(dest, PPC_LWSYNC_INSTR);
+		patch_instruction(dest, INST_LWSYNC);
 	}
 }
 
-- 
1.5.6.5
