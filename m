Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82FB61A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 07:45:27 +1100 (AEDT)
Date: Thu, 19 Mar 2015 21:45:23 +0100
From: Torsten Duwe <duwe@lst.de>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v0 1/4] ppc64le: dynamic ftrace 
Message-ID: <20150319204523.GB19524@lst.de>
References: <20150319203522.GA19524@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150319203522.GA19524@lst.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm pretty sure not everything is ifdef'd properly,
and the FIXME needs to be solved in order to disable
ftracing again. Built upon some original code by
Vojtech Pavlik.

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index e366187..a69d47e 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -46,6 +46,8 @@
 extern void _mcount(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+# define FTRACE_ADDR ((unsigned long)ftrace_caller+8)
+# define FTRACE_REGS_ADDR FTRACE_ADDR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
        /* reloction of mcount call site is the same as the address */
@@ -57,6 +58,9 @@ struct dyn_arch_ftrace {
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5bbd1bc..9caf9af 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1159,32 +1170,107 @@ _GLOBAL(enter_prom)
 
 #ifdef CONFIG_FUNCTION_TRACER
 #ifdef CONFIG_DYNAMIC_FTRACE
-_GLOBAL(mcount)
+
+#define TOCSAVE 24
+
 _GLOBAL(_mcount)
-	blr
+	nop // REQUIRED for ftrace, to calculate local/global entry diff
+.localentry _mcount,.-_mcount
+	mflr	r0
+	mtctr	r0
+
+	LOAD_REG_ADDR_PIC(r12,ftrace_trace_function)
+	ld	r12,0(r12)
+	LOAD_REG_ADDR_PIC(r0,ftrace_stub)
+	cmpd	r0,r12
+	ld	r0,LRSAVE(r1)
+	bne-	2f
+
+	mtlr	r0
+	bctr
+
+2:	/* here we have (*ftrace_trace_function)() in r12,
+	   "selfpc" in CTR
+	   and "frompc" in r0 */
+
+	mtlr	r0
+	bctr
+
+_GLOBAL(ftrace_caller)
+	mr	r0,r2	// global (module) call: save module TOC
+	b	1f
+.localentry ftrace_caller,.-ftrace_caller
+	mr	r0,r2	// local call: callee's TOC == our TOC
+	b	2f
+
+1:	addis	r2,r12,(.TOC.-0b)@ha
+	addi	r2,r2,(.TOC.-0b)@l
+
+2:	// Here we have our proper TOC ptr in R2,
+	// and the one we need to restore on return in r0.
+
+	ld	r12, 16(r1)	// get caller's adress
+
+	stdu	r1,-SWITCH_FRAME_SIZE(r1)
+
+	std     r12, _LINK(r1)
+	SAVE_8GPRS(0,r1)
+	std	r0,TOCSAVE(r1)
+	SAVE_8GPRS(8,r1)
+	SAVE_8GPRS(16,r1)
+	SAVE_8GPRS(24,r1)
+
+
+	LOAD_REG_IMMEDIATE(r3,function_trace_op)
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
 
-_GLOBAL_TOC(ftrace_caller)
-	/* Taken from output of objdump from lib64/glibc */
-	mflr	r3
-	ld	r11, 0(r1)
-	stdu	r1, -112(r1)
-	std	r3, 128(r1)
-	ld	r4, 16(r11)
-	subi	r3, r3, MCOUNT_INSN_SIZE
 .globl ftrace_call
 ftrace_call:
 	bl	ftrace_stub
 	nop
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
+	ld	r12, 16(r1)	// get caller's adress
+	mr	r2,r0		// restore callee's TOC
+	mflr	r0		// move this LR to CTR
+	mtctr	r0
+	mr	r0,r12		// restore callee's lr at _mcount site
+	mtlr	r0
+	bctr			// jump after _mcount site
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 .globl ftrace_graph_call
 ftrace_graph_call:
 	b	ftrace_graph_stub
 _GLOBAL(ftrace_graph_stub)
 #endif
-	ld	r0, 128(r1)
-	mtlr	r0
-	addi	r1, r1, 112
+	
 _GLOBAL(ftrace_stub)
+	nop
+	nop
+.localentry ftrace_stub,.-ftrace_stub	
 	blr
 #else
 _GLOBAL_TOC(_mcount)
@@ -1218,20 +1304,17 @@ _GLOBAL(ftrace_stub)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
 	/* load r4 with local address */
-	ld	r4, 128(r1)
+	ld	r4, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	subi	r4, r4, MCOUNT_INSN_SIZE
 
 	/* get the parent address */
-	ld	r11, 112(r1)
-	addi	r3, r11, 16
+	ld	r11, SWITCH_FRAME_SIZE(r1)
+	addi	r3, r11, LRSAVE
 
 	bl	prepare_ftrace_return
 	nop
 
-	ld	r0, 128(r1)
-	mtlr	r0
-	addi	r1, r1, 112
-	blr
+	b ftrace_graph_stub
 
 _GLOBAL(return_to_handler)
 	/* need to save return values */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 390311c..4fe16fb 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -61,8 +61,11 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 		return -EFAULT;
 
 	/* Make sure it is what we expect it to be */
-	if (replaced != old)
+	if (replaced != old) {
+		printk(KERN_ERR "%p: replaced (%#x) != old (%#x)",
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
+		printk(KERN_ERR "Fetching opcode failed.\n");
 		return -EFAULT;
+	}
 
 	/* Make sure that that this is still a 24bit jump */
 	if (!is_bl_op(op)) {
@@ -158,10 +163,42 @@ __ftrace_make_nop(struct module *mod,
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
+		printk(KERN_ERR "Fetching op failed.\n");
+		return -EFAULT;
+	}
+
+	if (op != 0xe8410028) { /* ld r2,STACK_OFFSET(r1) */
+
+		if (probe_kernel_read(&op0, (void *)(ip-8), MCOUNT_INSN_SIZE)) {
+			printk(KERN_ERR "Fetching op0 failed.\n");
+			return -EFAULT;
+		}
+
+		if (probe_kernel_read(&op1, (void *)(ip-4), MCOUNT_INSN_SIZE)) {
+			printk(KERN_ERR "Fetching op1 failed.\n");
+			return -EFAULT;
+		}
+
+		if (op0 != 0x7c0802a6 && op1 != 0xf8010010) { /* mflr r0 ; std r0,LRSAVE(r1) */
+			printk(KERN_ERR "Unexpected instructions around bl when enabling dynamic ftrace! (%08x,%08x,bl,%08x)\n", op0, op1, op);
+			return -EINVAL;
+		}
+
+		pop = PPC_INST_NOP;	/* When using -mkernel_profile there is no load to jump over */
+	}
+
+	if (patch_instruction((unsigned int *)ip, pop)) {
+		printk(KERN_ERR "Patching NOP failed.\n");
 		return -EPERM;
+	}
 
 	return 0;
 }
@@ -251,7 +288,7 @@ int ftrace_make_nop(struct module *mod,
 	 */
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
-		old = ftrace_call_replace(ip, addr, 1);
+		old = ftrace_call_replace(ip, addr + 4, 1); /* FIXME */
 		new = PPC_INST_NOP;
 		return ftrace_modify_code(ip, old, new);
 	}
@@ -287,6 +324,13 @@ int ftrace_make_nop(struct module *mod,
 
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_PPC64
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+                               unsigned long addr)
+{
+       return ftrace_make_call(rec, addr);
+}
+#endif
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -306,11 +350,18 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 * The load offset is different depending on the ABI. For simplicity
 	 * just mask it out when doing the compare.
 	 */
+#if 0 // -pg, no -mprofile-kernel
 	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
-		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
+		pr_err("Unexpected call sequence at %p: %x %x\n", ip, op[0], op[1]);
 		return -EINVAL;
 	}
-
+#else
+	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
+        if ((op[0] != 0x60000000) ) {
+                pr_err("Unexpected call at %p: %x\n", ip, op[0]);
+                return -EINVAL;
+        }
+#endif
 	/* If we never set up a trampoline to ftrace_caller, then bail */
 	if (!rec->arch.mod->arch.tramp) {
 		pr_err("No ftrace trampoline\n");
@@ -330,7 +381,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	return 0;
 }
-#else
+#else  /* !CONFIG_PPC64: */
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index d807ee6..05b88d3 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -140,12 +140,22 @@ static u32 ppc64_stub_insns[] = {
 	0x4e800420			/* bctr */
 };
 
+/* In case of _mcount calls or dynamic ftracing, Do not save the
+   current callee's TOC (in R2) again into the original caller's stack
+   frame during this trampoline hop. The stack frame already holds
+   that of the original caller.  _mcount and ftrace_caller will take
+   care of this TOC value themselves.
+*/
+#define SQUASH_TOC_SAVE_INSN(trampoline_addr) \
+	((struct ppc64_stub_entry*)(trampoline_addr))-> \
+	jump[2] = PPC_INST_NOP;
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
@@ -172,6 +182,9 @@ bool is_module_trampoline(u32 *p)
 		if ((insna & mask) != (insnb & mask))
 			return false;
 	}
+	if (insns[2] != ppc64_stub_insns[2] &&
+	    insns[2] != PPC_INST_NOP )
+		return false;
 
 	return true;
 }
@@ -477,6 +490,14 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
 static int restore_r2(u32 *instruction, struct module *me)
 {
 	if (*instruction != PPC_INST_NOP) {
+
+		/* -mprofile_kernel sequence starting with mflr r0; std r0, LRSAVE(r1) */
+		if (instruction[-3] == 0x7c0802a6 && instruction[-2] == 0xf8010010) {
+			/* Nothing to be done here, it's a _mcount call location
+			   and r2 will have to be restored in the _mcount function */
+			return 2;
+		};
+
 		printk("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
@@ -492,7 +513,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       unsigned int relsec,
 		       struct module *me)
 {
-	unsigned int i;
+	unsigned int i, r2;
 	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	unsigned long *location;
@@ -605,8 +626,11 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				value = stub_for_addr(sechdrs, value, me);
 				if (!value)
 					return -ENOENT;
-				if (!restore_r2((u32 *)location + 1, me))
+				if (!(r2 = restore_r2((u32 *)location + 1, me)))
 					return -ENOEXEC;
+				/* Squash the TOC saver for profiler calls */
+				if (!strcmp("_mcount", strtab+sym->st_name))
+					SQUASH_TOC_SAVE_INSN(value);
 			} else
 				value += local_entry_offset(sym);
 
@@ -667,6 +691,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	me->arch.tramp = stub_for_addr(sechdrs,
 				       (unsigned long)ftrace_caller,
 				       me);
+	/* ftrace_caller will take care of the TOC;
+	   do not clobber original caller's value. */
+	SQUASH_TOC_SAVE_INSN(me->arch.tramp);
 #endif
 
 	return 0;
