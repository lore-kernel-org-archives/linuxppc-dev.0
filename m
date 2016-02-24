Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 957201A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 04/12] powerpc/ftrace: Prepare for -mprofile-kernel
Date: Thu, 25 Feb 2016 01:28:27 +1100
Message-Id: <1456324115-21144-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Torsten Duwe <duwe@lst.de>

The gcc switch -mprofile-kernel, available for ppc64 on gcc > 4.8.5,
allows to call _mcount very early in the function, which low-level
ASM code and code patching functions need to consider.
Especially the link register and the parameter registers are still
alive and not yet saved into a new stack frame.

  * arch/powerpc/kernel/entry_64.S:
    - modify the default _mcount to be prepared for such call sites
    - have the ftrace_graph_caller save function arguments before
      calling its C helper prepare_ftrace_return
  * arch/powerpc/include/asm/code-patching.h:
    - define some common macros to make things readable.
    - pull the R2 stack location definition from
      arch/powerpc/kernel/module_64.c
  * arch/powerpc/kernel/module_64.c:
    - enhance binary code examination to handle the new patterns.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/code-patching.h | 24 ++++++++++++++++
 arch/powerpc/kernel/entry_64.S           | 48 +++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/ftrace.c             | 44 ++++++++++++++++++++++-------
 arch/powerpc/kernel/module_64.c          | 31 +++++++++++++++++++--
 4 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 840a5509b3f1..7820b32515de 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -99,4 +99,28 @@ static inline unsigned long ppc_global_function_entry(void *func)
 #endif
 }
 
+#ifdef CONFIG_PPC64
+/* Some instruction encodings commonly used in dynamic ftracing
+ * and function live patching:
+ */
+
+/* This must match the definition of STK_GOT in <asm/ppc_asm.h> */
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define R2_STACK_OFFSET         24
+#else
+#define R2_STACK_OFFSET         40
+#endif
+
+/* load / store the TOC from / into the stack frame */
+#define PPC_INST_LD_TOC		(PPC_INST_LD  | ___PPC_RT(__REG_R2) | \
+				 ___PPC_RA(__REG_R1) | R2_STACK_OFFSET)
+#define PPC_INST_STD_TOC	(PPC_INST_STD | ___PPC_RS(__REG_R2) | \
+				 ___PPC_RA(__REG_R1) | R2_STACK_OFFSET)
+
+/* usually preceded by a mflr r0 */
+#define PPC_INST_STD_LR		(PPC_INST_STD | ___PPC_RS(__REG_R0) | \
+				 ___PPC_RA(__REG_R1) | PPC_LR_STKOFF)
+
+#endif /* CONFIG_PPC64 */
+
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0d525ce3717f..2a7313cfbc7d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1143,7 +1143,10 @@ _GLOBAL(enter_prom)
 #ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL(mcount)
 _GLOBAL(_mcount)
-	blr
+	mflr	r12
+	mtctr	r12
+	mtlr	r0
+	bctr
 
 _GLOBAL_TOC(ftrace_caller)
 	/* Taken from output of objdump from lib64/glibc */
@@ -1198,6 +1201,7 @@ _GLOBAL(ftrace_stub)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifndef CC_USING_MPROFILE_KERNEL
 _GLOBAL(ftrace_graph_caller)
 	/* load r4 with local address */
 	ld	r4, 128(r1)
@@ -1222,6 +1226,48 @@ _GLOBAL(ftrace_graph_caller)
 	addi	r1, r1, 112
 	blr
 
+#else /* CC_USING_MPROFILE_KERNEL */
+_GLOBAL(ftrace_graph_caller)
+	/* with -mprofile-kernel, parameter regs are still alive at _mcount */
+	std	r10, 104(r1)
+	std	r9, 96(r1)
+	std	r8, 88(r1)
+	std	r7, 80(r1)
+	std	r6, 72(r1)
+	std	r5, 64(r1)
+	std	r4, 56(r1)
+	std	r3, 48(r1)
+	mfctr	r4		/* ftrace_caller has moved local addr here */
+	std	r4, 40(r1)
+	mflr	r3		/* ftrace_caller has restored LR from stack */
+	subi	r4, r4, MCOUNT_INSN_SIZE
+
+	bl	prepare_ftrace_return
+	nop
+
+	/*
+	 * prepare_ftrace_return gives us the address we divert to.
+	 * Change the LR to this.
+	 */
+	mtlr	r3
+
+	ld	r0, 40(r1)
+	mtctr	r0
+	ld	r10, 104(r1)
+	ld	r9, 96(r1)
+	ld	r8, 88(r1)
+	ld	r7, 80(r1)
+	ld	r6, 72(r1)
+	ld	r5, 64(r1)
+	ld	r4, 56(r1)
+	ld	r3, 48(r1)
+
+	addi	r1, r1, 112
+	mflr	r0
+	std	r0, LRSAVE(r1)
+	bctr
+#endif /* CC_USING_MPROFILE_KERNEL */
+
 _GLOBAL(return_to_handler)
 	/* need to save return values */
 	std	r4,  -32(r1)
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 4505cbfd0e13..a1d95f20b017 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -281,16 +281,14 @@ int ftrace_make_nop(struct module *mod,
 
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_PPC64
+/* Examine the existing instructions for __ftrace_make_call.
+ * They should effectively be a NOP, and follow formal constraints,
+ * depending on the ABI. Return false if they don't.
+ */
+#ifndef CC_USING_MPROFILE_KERNEL
 static int
-__ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+expected_nop_sequence(void *ip, unsigned int op0, unsigned int op1)
 {
-	unsigned int op[2];
-	void *ip = (void *)rec->ip;
-
-	/* read where this goes */
-	if (probe_kernel_read(op, ip, sizeof(op)))
-		return -EFAULT;
-
 	/*
 	 * We expect to see:
 	 *
@@ -300,8 +298,34 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 * The load offset is different depending on the ABI. For simplicity
 	 * just mask it out when doing the compare.
 	 */
-	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
-		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
+	if ((op0 != 0x48000008) || ((op1 & 0xffff0000) != 0xe8410000))
+		return 0;
+	return 1;
+}
+#else
+static int
+expected_nop_sequence(void *ip, unsigned int op0, unsigned int op1)
+{
+	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
+	if (op0 != PPC_INST_NOP)
+		return 0;
+	return 1;
+}
+#endif
+
+static int
+__ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned int op[2];
+	void *ip = (void *)rec->ip;
+
+	/* read where this goes */
+	if (probe_kernel_read(op, ip, sizeof(op)))
+		return -EFAULT;
+
+	if (!expected_nop_sequence(ip, op[0], op[1])) {
+		pr_err("Unexpected call sequence at %p: %x %x\n",
+		ip, op[0], op[1]);
 		return -EINVAL;
 	}
 
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index e711d40a3b8f..32c10e0d2aa5 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -41,7 +41,6 @@
    --RR.  */
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
-#define R2_STACK_OFFSET 24
 
 /* An address is simply the address of the function. */
 typedef unsigned long func_desc_t;
@@ -73,7 +72,6 @@ static unsigned int local_entry_offset(const Elf64_Sym *sym)
 	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
 }
 #else
-#define R2_STACK_OFFSET 40
 
 /* An address is address of the OPD entry, which contains address of fn. */
 typedef struct ppc64_opd_entry func_desc_t;
@@ -450,17 +448,44 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 	return (unsigned long)&stubs[i];
 }
 
+#ifdef CC_USING_MPROFILE_KERNEL
+static int is_early_mcount_callsite(u32 *instruction)
+{
+	/* -mprofile-kernel sequence starting with
+	 * mflr r0 and maybe std r0, LRSAVE(r1).
+	 */
+	if ((instruction[-3] == PPC_INST_MFLR &&
+	     instruction[-2] == PPC_INST_STD_LR) ||
+	    instruction[-2] == PPC_INST_MFLR) {
+		/* Nothing to be done here, it's an _mcount
+		 * call location and r2 will have to be
+		 * restored in the _mcount function.
+		 */
+		return 1;
+	}
+	return 0;
+}
+#else
+/* without -mprofile-kernel, mcount calls are never early */
+static int is_early_mcount_callsite(u32 *instruction)
+{
+	return 0;
+}
+#endif
+
 /* We expect a noop next: if it is, replace it with instruction to
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
 	if (*instruction != PPC_INST_NOP) {
+		if (is_early_mcount_callsite(instruction))
+			return 1;
 		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
 	}
 	/* ld r2,R2_STACK_OFFSET(r1) */
-	*instruction = 0xe8410000 | R2_STACK_OFFSET;
+	*instruction = PPC_INST_LD_TOC;
 	return 1;
 }
 
-- 
2.5.0
