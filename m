Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8E8C1A0E24
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:28:25 +1100 (AEDT)
In-Reply-To: <20151204152419.28E0D691D2@newverein.lst.de>
References: <20151204152419.28E0D691D2@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Fri, 4 Dec 2015 14:38:11 +0100
Subject: [PATCH v5 2/9] ppc64le FTRACE_WITH_REGS implementation
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 Petr Mladek <pmladek@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151204152822.A7312691D3@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
 arch/powerpc/include/asm/ftrace.h |  5 +++
 arch/powerpc/kernel/entry_64.S    | 77 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ftrace.c      | 60 +++++++++++++++++++++++++++---
 arch/powerpc/kernel/module_64.c   | 25 ++++++++++++-
 4 files changed, 160 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index ef89b14..50ca758 100644
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
index c3b2e75..294a9ca 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1212,6 +1212,7 @@ _GLOBAL(_mcount)
 	mtlr	r0
 	bctr
 
+#ifndef CC_USING_MPROFILE_KERNEL
 _GLOBAL_TOC(ftrace_caller)
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
@@ -1233,6 +1234,82 @@ _GLOBAL(ftrace_graph_stub)
 	ld	r0, 128(r1)
 	mtlr	r0
 	addi	r1, r1, 112
+#else
+_GLOBAL(ftrace_caller)
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	mflr	r0
+	bl	2f
+2:	mflr	r12
+	mtlr	r0
+	mr      r0,r2   /* save callee's TOC */
+	addis	r2,r12,(.TOC.-ftrace_caller-8)@ha
+	addi    r2,r2,(.TOC.-ftrace_caller-8)@l
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
index 080c525..310137f 100644
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
@@ -106,14 +109,16 @@ static int
 __ftrace_make_nop(struct module *mod,
 		  struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned int op;
+	unsigned int op, op0, op1, pop;
 	unsigned long entry, ptr;
 	unsigned long ip = rec->ip;
 	void *tramp;
 
 	/* read where this goes */
-	if (probe_kernel_read(&op, (void *)ip, sizeof(int)))
+	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
+		pr_err("Fetching opcode failed.\n");
 		return -EFAULT;
+	}
 
 	/* Make sure that that this is still a 24bit jump */
 	if (!is_bl_op(op)) {
@@ -158,10 +163,46 @@ __ftrace_make_nop(struct module *mod,
 	 *
 	 * Use a b +8 to jump over the load.
 	 */
-	op = 0x48000008;	/* b +8 */
 
-	if (patch_instruction((unsigned int *)ip, op))
+	pop = 0x48000008;	/* b +8 */
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
+	if (op != 0xe8410028) { /* ld r2,STACK_OFFSET(r1) */
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
+		/* mflr r0 ; std r0,LRSAVE(r1) */
+		if (op0 != 0x7c0802a6 && op1 != 0xf8010010) {
+			pr_err("Unexpected instructions around bl\n"
+				"when enabling dynamic ftrace!\t"
+				"(%08x,%08x,bl,%08x)\n", op0, op1, op);
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
@@ -287,6 +328,13 @@ int ftrace_make_nop(struct module *mod,
 
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_PPC64
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	return ftrace_make_call(rec, addr);
+}
+#endif
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -338,7 +386,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	return 0;
 }
-#else
+#else  /* !CONFIG_PPC64: */
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 5312cd4..7218b37 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -138,12 +138,25 @@ static u32 ppc64_stub_insns[] = {
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
 
 static u32 ppc64_stub_mask[] = {
 	0xffff0000,
 	0xffff0000,
-	0xffffffff,
+	0x00000000,
 	0xffffffff,
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	0xffffffff,
@@ -170,6 +183,9 @@ bool is_module_trampoline(u32 *p)
 		if ((insna & mask) != (insnb & mask))
 			return false;
 	}
+	if (insns[2] != ppc64_stub_insns[2] &&
+	    insns[2] != PPC_INST_NOP)
+		return false;
 
 	return true;
 }
@@ -618,6 +634,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 					return -ENOENT;
 				if (!restore_r2((u32 *)location + 1, me))
 					return -ENOEXEC;
+				/* Squash the TOC saver for profiler calls */
+				if (!strcmp("_mcount", strtab+sym->st_name))
+					SQUASH_TOC_SAVE_INSN(value);
 			} else
 				value += local_entry_offset(sym);
 
@@ -678,6 +697,10 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	me->arch.tramp = stub_for_addr(sechdrs,
 				       (unsigned long)ftrace_caller,
 				       me);
+	/* ftrace_caller will take care of the TOC;
+	 * do not clobber original caller's value.
+	 */
+	SQUASH_TOC_SAVE_INSN(me->arch.tramp);
 #endif
 
 	return 0;
-- 
1.8.5.6
