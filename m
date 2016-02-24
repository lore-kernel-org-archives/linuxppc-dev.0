Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB1B51A03FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 07/12] powerpc/ftrace: FTRACE_WITH_REGS implementation for
 ppc64le
Date: Thu, 25 Feb 2016 01:28:30 +1100
Message-Id: <1456324115-21144-7-git-send-email-mpe@ellerman.id.au>
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

Implement FTRACE_WITH_REGS for powerpc64, on ELF ABI v2.
Initial work started by Vojtech Pavlik, used with permission.

  * arch/powerpc/kernel/entry_64.S:
    - Implement an effective ftrace_caller that works from
      within the kernel binary as well as from modules.
  * arch/powerpc/kernel/ftrace.c:
    - be prepared to deal with ppc64 ELF ABI v2, especially
      calls to _mcount that result from gcc -mprofile-kernel
    - a little more error verbosity
  * arch/powerpc/kernel/module_64.c:
    - do not save the TOC pointer on the trampoline when the
      destination is ftrace_caller. This trampoline jump happens from
      a function prologue before a new stack frame is set up, so bad
      things may happen otherwise...
    - relax is_module_trampoline() to recognise the modified
      trampoline.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ftrace.h |  5 +++
 arch/powerpc/kernel/entry_64.S    | 78 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ftrace.c      | 66 ++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/module_64.c   | 16 ++++++++
 4 files changed, 159 insertions(+), 6 deletions(-)

Probably squash.

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index ef89b1465573..50ca7585abe2 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -46,6 +46,8 @@
 extern void _mcount(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+# define FTRACE_ADDR ((unsigned long)ftrace_caller)
+# define FTRACE_REGS_ADDR FTRACE_ADDR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
        /* reloction of mcount call site is the same as the address */
@@ -58,6 +60,9 @@ struct dyn_arch_ftrace {
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9e77a2c8f218..149b659a25d9 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1148,6 +1148,7 @@ _GLOBAL(_mcount)
 	mtlr	r0
 	bctr
 
+#ifndef CC_USING_MPROFILE_KERNEL
 _GLOBAL_TOC(ftrace_caller)
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
@@ -1169,6 +1170,83 @@ _GLOBAL(ftrace_graph_stub)
 	ld	r0, 128(r1)
 	mtlr	r0
 	addi	r1, r1, 112
+#else
+_GLOBAL(ftrace_caller)
+	std	r0,LRSAVE(r1)
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	mflr	r0
+	bl	2f
+2:	mflr	r12
+	mtlr	r0
+	mr      r0,r2   /* save callee's TOC */
+	addis	r2,r12,(.TOC.-ftrace_caller-12)@ha
+	addi    r2,r2,(.TOC.-ftrace_caller-12)@l
+#else
+	mr	r0,r2
+#endif
+	ld	r12,LRSAVE(r1)	/* get caller's address */
+
+	stdu	r1,-SWITCH_FRAME_SIZE(r1)
+
+	std     r12, _LINK(r1)
+	SAVE_8GPRS(0,r1)
+	std	r0, 24(r1)	/* save TOC */
+	SAVE_8GPRS(8,r1)
+	SAVE_8GPRS(16,r1)
+	SAVE_8GPRS(24,r1)
+
+	addis	r3,r2,function_trace_op@toc@ha
+	addi	r3,r3,function_trace_op@toc@l
+	ld	r5,0(r3)
+
+	mflr    r3
+	std     r3, _NIP(r1)
+	std	r3, 16(r1)
+	subi    r3, r3, MCOUNT_INSN_SIZE
+	mfmsr   r4
+	std     r4, _MSR(r1)
+	mfctr   r4
+	std     r4, _CTR(r1)
+	mfxer   r4
+	std     r4, _XER(r1)
+	mr	r4, r12
+	addi    r6, r1 ,STACK_FRAME_OVERHEAD
+
+.globl ftrace_call
+ftrace_call:
+	bl	ftrace_stub
+	nop
+
+	ld	r3, _NIP(r1)
+	mtlr	r3
+
+	REST_8GPRS(0,r1)
+	REST_8GPRS(8,r1)
+	REST_8GPRS(16,r1)
+	REST_8GPRS(24,r1)
+
+	addi r1, r1, SWITCH_FRAME_SIZE
+
+	ld	r12, LRSAVE(r1)  /* get caller's address */
+	mtlr	r12
+	mr	r2,r0		/* restore callee's TOC */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	stdu	r1, -112(r1)
+.globl ftrace_graph_call
+ftrace_graph_call:
+	b	ftrace_graph_stub
+_GLOBAL(ftrace_graph_stub)
+	addi	r1, r1, 112
+#endif
+
+	mflr	r0		/* move this LR to CTR */
+	mtctr	r0
+
+	ld	r0,LRSAVE(r1)	/* restore callee's lr at _mcount site */
+	mtlr	r0
+	bctr			/* jump after _mcount site */
+#endif /* CC_USING_MPROFILE_KERNEL */
 _GLOBAL(ftrace_stub)
 	blr
 #else
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index a1d95f20b017..c6408a399ac6 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -61,8 +61,11 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 		return -EFAULT;
 
 	/* Make sure it is what we expect it to be */
-	if (replaced != old)
+	if (replaced != old) {
+		pr_err("%p: replaced (%#x) != old (%#x)",
+		(void *)ip, replaced, old);
 		return -EINVAL;
+	}
 
 	/* replace the text with the new text */
 	if (patch_instruction((unsigned int *)ip, new))
@@ -108,11 +111,13 @@ __ftrace_make_nop(struct module *mod,
 {
 	unsigned long entry, ptr, tramp;
 	unsigned long ip = rec->ip;
-	unsigned int op;
+	unsigned int op, pop;
 
 	/* read where this goes */
-	if (probe_kernel_read(&op, (void *)ip, sizeof(int)))
+	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
+		pr_err("Fetching opcode failed.\n");
 		return -EFAULT;
+	}
 
 	/* Make sure that that this is still a 24bit jump */
 	if (!is_bl_op(op)) {
@@ -152,10 +157,51 @@ __ftrace_make_nop(struct module *mod,
 	 *
 	 * Use a b +8 to jump over the load.
 	 */
-	op = 0x48000008;	/* b +8 */
 
-	if (patch_instruction((unsigned int *)ip, op))
+	pop = PPC_INST_BRANCH | 8;	/* b +8 */
+
+	/*
+	 * Check what is in the next instruction. We can see ld r2,40(r1), but
+	 * on first pass after boot we will see mflr r0.
+	 */
+	if (probe_kernel_read(&op, (void *)(ip+4), MCOUNT_INSN_SIZE)) {
+		pr_err("Fetching op failed.\n");
+		return -EFAULT;
+	}
+
+	if (op != PPC_INST_LD_TOC)
+	{
+		unsigned int op0, op1;
+
+		if (probe_kernel_read(&op0, (void *)(ip-8), MCOUNT_INSN_SIZE)) {
+			pr_err("Fetching op0 failed.\n");
+			return -EFAULT;
+		}
+
+		if (probe_kernel_read(&op1, (void *)(ip-4), MCOUNT_INSN_SIZE)) {
+			pr_err("Fetching op1 failed.\n");
+			return -EFAULT;
+		}
+
+		/* mflr r0 ; [ std r0,LRSAVE(r1) ]? */
+		if ( (op0 != PPC_INST_MFLR ||
+		      op1 != PPC_INST_STD_LR)
+		     && op1 != PPC_INST_MFLR )
+		{
+			pr_err("Unexpected instructions around bl _mcount\n"
+			       "when enabling dynamic ftrace!\t"
+			       "(%08x,%08x,bl,%08x)\n", op0, op1, op);
+			return -EINVAL;
+		}
+
+		/* When using -mkernel_profile there is no load to jump over */
+		pop = PPC_INST_NOP;
+	}
+
+	if (patch_instruction((unsigned int *)ip, pop)) {
+		pr_err("Patching NOP failed.\n");
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -281,6 +327,14 @@ int ftrace_make_nop(struct module *mod,
 
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_PPC64
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	return ftrace_make_call(rec, addr);
+}
+#endif
+
 /* Examine the existing instructions for __ftrace_make_call.
  * They should effectively be a NOP, and follow formal constraints,
  * depending on the ABI. Return false if they don't.
@@ -348,7 +402,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	return 0;
 }
-#else
+#else  /* !CONFIG_PPC64: */
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 495df4340623..a3a13fcfc99c 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -139,6 +139,19 @@ static u32 ppc64_stub_insns[] = {
 	0x4e800420			/* bctr */
 };
 
+#ifdef CC_USING_MPROFILE_KERNEL
+/* In case of _mcount calls or dynamic ftracing, Do not save the
+ * current callee's TOC (in R2) again into the original caller's stack
+ * frame during this trampoline hop. The stack frame already holds
+ * that of the original caller.  _mcount and ftrace_caller will take
+ * care of this TOC value themselves.
+ */
+#define SQUASH_TOC_SAVE_INSN(trampoline_addr) \
+	(((struct ppc64_stub_entry *)(trampoline_addr))->jump[2] = PPC_INST_NOP)
+#else
+#define SQUASH_TOC_SAVE_INSN(trampoline_addr)
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 int module_trampoline_target(struct module *mod, unsigned long addr,
 			     unsigned long *target)
@@ -608,6 +621,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 					return -ENOENT;
 				if (!restore_r2((u32 *)location + 1, me))
 					return -ENOEXEC;
+				/* Squash the TOC saver for profiler calls */
+				if (!strcmp("_mcount", strtab+sym->st_name))
+					SQUASH_TOC_SAVE_INSN(value);
 			} else
 				value += local_entry_offset(sym);
 
-- 
2.5.0
