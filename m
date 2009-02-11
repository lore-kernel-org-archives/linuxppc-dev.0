Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D885DDDAF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:10:50 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1B6AiiR017957
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 00:10:45 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v5] powerpc: Unify opcode definitions and support
Date: Wed, 11 Feb 2009 00:10:44 -0600
Message-Id: <1234332644-7976-1-git-send-email-galak@kernel.crashing.org>
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
* Fixed license in header

 arch/powerpc/include/asm/code-patching.h |    4 +-
 arch/powerpc/include/asm/ppc-opcode.h    |   73 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/ppc_asm.h       |    6 +--
 arch/powerpc/kernel/crash_dump.c         |    2 +-
 arch/powerpc/kernel/entry_32.S           |    8 ++--
 arch/powerpc/kernel/ftrace.c             |    8 ++--
 arch/powerpc/kernel/head_booke.h         |    2 +-
 arch/powerpc/kernel/module_64.c          |    2 +-
 arch/powerpc/kernel/traps.c              |   58 +++++++----------------
 arch/powerpc/lib/feature-fixups.c        |    4 +-
 10 files changed, 106 insertions(+), 61 deletions(-)
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
index 0000000..f4a4db8
--- /dev/null
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2009 Freescale Semicondutor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
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
+#define PPC_INST_DCBA			0x7c0005ec
+#define PPC_INST_DCBA_MASK		0xfc0007fe
+#define PPC_INST_DCBAL			0x7c2005ec
+#define PPC_INST_DCBZL			0x7c2007ec
+#define PPC_INST_ISEL			0x7c00001e
+#define PPC_INST_ISEL_MASK		0xfc00003e
+#define PPC_INST_LSWI			0x7c0004aa
+#define PPC_INST_LSWX			0x7c00042a
+#define PPC_INST_LWSYNC			0x7c2004ac
+#define PPC_INST_MCRXR			0x7c000400
+#define PPC_INST_MCRXR_MASK		0xfc0007fe
+#define PPC_INST_MFSPR_PVR		0x7c1f42a6
+#define PPC_INST_MFSPR_PVR_MASK		0xfc1fffff
+#define PPC_INST_MSGSND			0x7c00019c
+#define PPC_INST_NOP			0x60000000
+#define PPC_INST_POPCNTB		0x7c0000f4
+#define PPC_INST_POPCNTB_MASK		0xfc0007fe
+#define PPC_INST_RFCI			0x4c000066
+#define PPC_INST_RFDI			0x4c00004e
+#define PPC_INST_RFMCI			0x4c00004c
+
+#define PPC_INST_STRING			0x7c00042a
+#define PPC_INST_STRING_MASK		0xfc0007fe
+#define PPC_INST_STRING_GEN_MASK	0xfc00067e
+
+#define PPC_INST_STSWI			0x7c0005aa
+#define PPC_INST_STSWX			0x7c00052a
+#define PPC_INST_TLBILX			0x7c000626
+#define PPC_INST_WAIT			0x7c00007c
+
+/* macros to insert fields into opcodes */
+#define __PPC_RA(a)	((a & 0x1f) << 16)
+#define __PPC_RB(b)	((b & 0x1f) << 11)
+#define __PPC_T_TLB(t)	((t & 0x3) << 21)
+#define __PPC_WC(w)	((w & 0x3) << 21)
+
+/* Deal with instructions that older assemblers aren't aware of */
+#define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
+					__PPC_RA(a) | __PPC_RB(b))
+#define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
+					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
+					__PPC_RB(b))
+#define PPC_RFCI		stringify_in_c(.long PPC_INST_RFCI)
+#define PPC_RFDI		stringify_in_c(.long PPC_INST_RFDI)
+#define PPC_RFMCI		stringify_in_c(.long PPC_INST_RFMCI)
+#define PPC_TLBILX(t, a, b)	stringify_in_c(.long PPC_INST_TLBILX | \
+					__PPC_T_TLB(t) | __PPC_RA(a) | __PPC_RB(b))
+#define PPC_TLBILX_ALL(a, b)	PPC_TLBILX(0, a, b)
+#define PPC_TLBILX_PID(a, b)	PPC_TLBILX(1, a, b)
+#define PPC_TLBILX_VA(a, b)	PPC_TLBILX(3, a, b)
+#define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
+					__PPC_WC(w))
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
index 19671ac..5fb667a 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -48,7 +48,7 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
-	patch_instruction(p, PPC_NOP_INSTR);
+	patch_instruction(p, PPC_INST_NOP);
 	patch_branch(++p, addr + PHYSICAL_START, 0);
 }
 
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 6f7eb7e..c35ddeb 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -956,7 +956,7 @@ ret_from_crit_exc:
 	lwz	r10,crit_srr1@l(r10);
 	mtspr	SPRN_SRR0,r9;
 	mtspr	SPRN_SRR1,r10;
-	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
+	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, PPC_RFCI)
 #endif /* CONFIG_40x */
 
 #ifdef CONFIG_BOOKE
@@ -967,7 +967,7 @@ ret_from_crit_exc:
 	stw	r10,KSP_LIMIT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
 	RESTORE_MMU_REGS;
-	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
+	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, PPC_RFCI)
 
 	.globl	ret_from_debug_exc
 ret_from_debug_exc:
@@ -981,7 +981,7 @@ ret_from_debug_exc:
 	RESTORE_xSRR(SRR0,SRR1);
 	RESTORE_xSRR(CSRR0,CSRR1);
 	RESTORE_MMU_REGS;
-	RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, RFDI)
+	RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)
 
 	.globl	ret_from_mcheck_exc
 ret_from_mcheck_exc:
@@ -992,7 +992,7 @@ ret_from_mcheck_exc:
 	RESTORE_xSRR(CSRR0,CSRR1);
 	RESTORE_xSRR(DSRR0,DSRR1);
 	RESTORE_MMU_REGS;
-	RET_FROM_EXC_LEVEL(SPRN_MCSRR0, SPRN_MCSRR1, RFMCI)
+	RET_FROM_EXC_LEVEL(SPRN_MCSRR0, SPRN_MCSRR1, PPC_RFMCI)
 #endif /* CONFIG_BOOKE */
 
 /*
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 5355244..5575ec5 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -26,7 +26,7 @@
 #define DEBUGP(fmt , ...)	do { } while (0)
 #endif
 
-static unsigned int ftrace_nop = PPC_NOP_INSTR;
+static unsigned int ftrace_nop = PPC_INST_NOP;
 
 #ifdef CONFIG_PPC32
 # define GET_ADDR(addr) addr
@@ -319,7 +319,7 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-	op = PPC_NOP_INSTR;
+	op = PPC_INST_NOP;
 
 	if (probe_kernel_write((void *)ip, &op, MCOUNT_INSN_SIZE))
 		return -EPERM;
@@ -391,7 +391,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 *  b +8; ld r2,40(r1)
 	 */
 	if (((op[0] != 0x48000008) || (op[1] != 0xe8410028)) &&
-	    ((op[0] != PPC_NOP_INSTR) || (op[1] != PPC_NOP_INSTR))) {
+	    ((op[0] != PPC_INST_NOP) || (op[1] != PPC_INST_NOP))) {
 		printk(KERN_ERR "Expected NOPs but have %x %x\n", op[0], op[1]);
 		return -EINVAL;
 	}
@@ -434,7 +434,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EFAULT;
 
 	/* It should be pointing to a nop */
-	if (op != PPC_NOP_INSTR) {
+	if (op != PPC_INST_NOP) {
 		printk(KERN_ERR "Expected NOP but have %x\n", op);
 		return -EINVAL;
 	}
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index bec1807..38e242e 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -279,7 +279,7 @@ label:
 	lwz	r11,GPR11(r8);						      \
 	mfspr	r8,DEBUG_SPRG;						      \
 									      \
-	RFDI;								      \
+	PPC_RFDI;								      \
 	b	.;							      \
 									      \
 	/* continue normal handling for a debug exception... */		      \
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8992b03..8fbb125 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -329,7 +329,7 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
-	if (*instruction != PPC_NOP_INSTR) {
+	if (*instruction != PPC_INST_NOP) {
 		printk("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5457e95..970d66e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -52,6 +52,7 @@
 #include <asm/processor.h>
 #endif
 #include <asm/kexec.h>
+#include <asm/ppc-opcode.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs);
@@ -637,29 +638,6 @@ static void parse_fpe(struct pt_regs *regs)
  * bits is faster and easier.
  *
  */
-#define INST_MFSPR_PVR		0x7c1f42a6
-#define INST_MFSPR_PVR_MASK	0xfc1fffff
-
-#define INST_DCBA		0x7c0005ec
-#define INST_DCBA_MASK		0xfc0007fe
-
-#define INST_MCRXR		0x7c000400
-#define INST_MCRXR_MASK		0xfc0007fe
-
-#define INST_STRING		0x7c00042a
-#define INST_STRING_MASK	0xfc0007fe
-#define INST_STRING_GEN_MASK	0xfc00067e
-#define INST_LSWI		0x7c0004aa
-#define INST_LSWX		0x7c00042a
-#define INST_STSWI		0x7c0005aa
-#define INST_STSWX		0x7c00052a
-
-#define INST_POPCNTB		0x7c0000f4
-#define INST_POPCNTB_MASK	0xfc0007fe
-
-#define INST_ISEL		0x7c00001e
-#define INST_ISEL_MASK		0xfc00003e
-
 static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 {
 	u8 rT = (instword >> 21) & 0x1f;
@@ -670,20 +648,20 @@ static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 	int pos = 0;
 
 	/* Early out if we are an invalid form of lswx */
-	if ((instword & INST_STRING_MASK) == INST_LSWX)
+	if ((instword & PPC_INST_STRING_MASK) == PPC_INST_LSWX)
 		if ((rT == rA) || (rT == NB_RB))
 			return -EINVAL;
 
 	EA = (rA == 0) ? 0 : regs->gpr[rA];
 
-	switch (instword & INST_STRING_MASK) {
-		case INST_LSWX:
-		case INST_STSWX:
+	switch (instword & PPC_INST_STRING_MASK) {
+		case PPC_INST_LSWX:
+		case PPC_INST_STSWX:
 			EA += NB_RB;
 			num_bytes = regs->xer & 0x7f;
 			break;
-		case INST_LSWI:
-		case INST_STSWI:
+		case PPC_INST_LSWI:
+		case PPC_INST_STSWI:
 			num_bytes = (NB_RB == 0) ? 32 : NB_RB;
 			break;
 		default:
@@ -695,9 +673,9 @@ static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 		u8 val;
 		u32 shift = 8 * (3 - (pos & 0x3));
 
-		switch ((instword & INST_STRING_MASK)) {
-			case INST_LSWX:
-			case INST_LSWI:
+		switch ((instword & PPC_INST_STRING_MASK)) {
+			case PPC_INST_LSWX:
+			case PPC_INST_LSWI:
 				if (get_user(val, (u8 __user *)EA))
 					return -EFAULT;
 				/* first time updating this reg,
@@ -706,8 +684,8 @@ static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 					regs->gpr[rT] = 0;
 				regs->gpr[rT] |= val << shift;
 				break;
-			case INST_STSWI:
-			case INST_STSWX:
+			case PPC_INST_STSWI:
+			case PPC_INST_STSWX:
 				val = regs->gpr[rT] >> shift;
 				if (put_user(val, (u8 __user *)EA))
 					return -EFAULT;
@@ -775,18 +753,18 @@ static int emulate_instruction(struct pt_regs *regs)
 		return -EFAULT;
 
 	/* Emulate the mfspr rD, PVR. */
-	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
+	if ((instword & PPC_INST_MFSPR_PVR_MASK) == PPC_INST_MFSPR_PVR) {
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(SPRN_PVR);
 		return 0;
 	}
 
 	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA)
+	if ((instword & PPC_INST_DCBA_MASK) == PPC_INST_DCBA)
 		return 0;
 
 	/* Emulate the mcrxr insn.  */
-	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
+	if ((instword & PPC_INST_MCRXR_MASK) == PPC_INST_MCRXR) {
 		int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
 
@@ -796,16 +774,16 @@ static int emulate_instruction(struct pt_regs *regs)
 	}
 
 	/* Emulate load/store string insn. */
-	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
+	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING)
 		return emulate_string_inst(regs, instword);
 
 	/* Emulate the popcntb (Population Count Bytes) instruction. */
-	if ((instword & INST_POPCNTB_MASK) == INST_POPCNTB) {
+	if ((instword & PPC_INST_POPCNTB_MASK) == PPC_INST_POPCNTB) {
 		return emulate_popcntb_inst(regs, instword);
 	}
 
 	/* Emulate isel (Integer Select) instruction */
-	if ((instword & INST_ISEL_MASK) == INST_ISEL) {
+	if ((instword & PPC_INST_ISEL_MASK) == PPC_INST_ISEL) {
 		return emulate_isel(regs, instword);
 	}
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 8c5a03b..7e8865b 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -85,7 +85,7 @@ static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
 	}
 
 	for (; dest < end; dest++)
-		patch_instruction(dest, PPC_NOP_INSTR);
+		patch_instruction(dest, PPC_INST_NOP);
 
 	return 0;
 }
@@ -122,7 +122,7 @@ void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 
 	for (; start < end; start++) {
 		dest = (void *)start + *start;
-		patch_instruction(dest, PPC_LWSYNC_INSTR);
+		patch_instruction(dest, PPC_INST_LWSYNC);
 	}
 }
 
-- 
1.5.6.6
