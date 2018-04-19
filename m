Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RVNy6MRjzF22g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 17:05:06 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3J74ODJ082361
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:05:04 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hen26bf3v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:05:04 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 19 Apr 2018 08:04:59 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v5 10/10] powerpc64/ftrace: Implement support for
 ftrace_regs_caller()
Date: Thu, 19 Apr 2018 12:34:09 +0530
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <2aa566c6068276a066401e3324c2200d142e3087.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With -mprofile-kernel, we always save the full register state in
ftrace_caller(). While this works, this is inefficient if we're not
interested in the register state, such as when we're using the function
tracer.

Rename the existing ftrace_caller() as ftrace_regs_caller() and provide
a simpler implementation for ftrace_caller() that is used when registers
are not required to be saved.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h             |   2 -
 arch/powerpc/include/asm/module.h             |   3 +
 arch/powerpc/kernel/module_64.c               |  28 ++-
 arch/powerpc/kernel/trace/ftrace.c            | 184 ++++++++++++++++--
 .../powerpc/kernel/trace/ftrace_64_mprofile.S |  71 ++++++-
 5 files changed, 262 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 3b5e85a72e10..f0806a2fd451 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -49,8 +49,6 @@
 extern void _mcount(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-# define FTRACE_ADDR ((unsigned long)ftrace_caller)
-# define FTRACE_REGS_ADDR FTRACE_ADDR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
        /* reloction of mcount call site is the same as the address */
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 4f6573934792..18f7214d68b7 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -53,6 +53,9 @@ struct mod_arch_specific {
 #ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned long toc;
 	unsigned long tramp;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	unsigned long tramp_regs;
+#endif
 #endif
 
 	/* For module function descriptor dereference */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8413be31d6a4..f7667e2ebfcb 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -280,6 +280,10 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/* make the trampoline to the ftrace_caller */
 	relocs++;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	/* an additional one for ftrace_regs_caller */
+	relocs++;
+#endif
 #endif
 
 	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
@@ -765,7 +769,8 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
  * via the paca (in r13). The target (ftrace_caller()) is responsible for
  * saving and restoring the toc before returning.
  */
-static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
+static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs,
+				struct module *me, unsigned long addr)
 {
 	struct ppc64_stub_entry *entry;
 	unsigned int i, num_stubs;
@@ -792,9 +797,10 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module
 	memcpy(entry->jump, stub_insns, sizeof(stub_insns));
 
 	/* Stub uses address relative to kernel toc (from the paca) */
-	reladdr = (unsigned long)ftrace_caller - kernel_toc_addr();
+	reladdr = addr - kernel_toc_addr();
 	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
-		pr_err("%s: Address of ftrace_caller out of range of kernel_toc.\n", me->name);
+		pr_err("%s: Address of %ps out of range of kernel_toc.\n",
+							me->name, (void *)addr);
 		return 0;
 	}
 
@@ -802,22 +808,30 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module
 	entry->jump[2] |= PPC_LO(reladdr);
 
 	/* Eventhough we don't use funcdata in the stub, it's needed elsewhere. */
-	entry->funcdata = func_desc((unsigned long)ftrace_caller);
+	entry->funcdata = func_desc(addr);
 	entry->magic = STUB_MAGIC;
 
 	return (unsigned long)entry;
 }
 #else
-static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
+static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs,
+				struct module *me, unsigned long addr)
 {
-	return stub_for_addr(sechdrs, (unsigned long)ftrace_caller, me);
+	return stub_for_addr(sechdrs, addr, me);
 }
 #endif
 
 int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
 {
 	mod->arch.toc = my_r2(sechdrs, mod);
-	mod->arch.tramp = create_ftrace_stub(sechdrs, mod);
+	mod->arch.tramp = create_ftrace_stub(sechdrs, mod,
+					(unsigned long)ftrace_caller);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	mod->arch.tramp_regs = create_ftrace_stub(sechdrs, mod,
+					(unsigned long)ftrace_regs_caller);
+	if (!mod->arch.tramp_regs)
+		return -ENOENT;
+#endif
 
 	if (!mod->arch.tramp)
 		return -ENOENT;
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 80667128db3d..79d2924e75d5 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -357,6 +357,8 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int op[2];
 	void *ip = (void *)rec->ip;
+	unsigned long entry, ptr, tramp;
+	struct module *mod = rec->arch.mod;
 
 	/* read where this goes */
 	if (probe_kernel_read(op, ip, sizeof(op)))
@@ -368,19 +370,44 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EINVAL;
 	}
 
-	/* If we never set up a trampoline to ftrace_caller, then bail */
-	if (!rec->arch.mod->arch.tramp) {
+	/* If we never set up ftrace trampoline(s), then bail */
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (!mod->arch.tramp || !mod->arch.tramp_regs) {
+#else
+	if (!mod->arch.tramp) {
+#endif
 		pr_err("No ftrace trampoline\n");
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (rec->flags & FTRACE_FL_REGS)
+		tramp = mod->arch.tramp_regs;
+	else
+#endif
+		tramp = mod->arch.tramp;
+
+	if (module_trampoline_target(mod, tramp, &ptr)) {
+		pr_err("Failed to get trampoline target\n");
+		return -EFAULT;
+	}
+
+	pr_devel("trampoline target %lx", ptr);
+
+	entry = ppc_global_function_entry((void *)addr);
+	/* This should match what was called */
+	if (ptr != entry) {
+		pr_err("addr %lx does not match expected %lx\n", ptr, entry);
+		return -EINVAL;
+	}
+
 	/* Ensure branch is within 24 bits */
-	if (!create_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
+	if (!create_branch(ip, tramp, BRANCH_SET_LINK)) {
 		pr_err("Branch out of range\n");
 		return -EINVAL;
 	}
 
-	if (patch_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
+	if (patch_branch(ip, tramp, BRANCH_SET_LINK)) {
 		pr_err("REL24 out of range!\n");
 		return -EINVAL;
 	}
@@ -388,14 +415,6 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	return 0;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
-			unsigned long addr)
-{
-	return ftrace_make_call(rec, addr);
-}
-#endif
-
 #else  /* !CONFIG_PPC64: */
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
@@ -472,6 +491,137 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 #endif /* CONFIG_MODULES */
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_MODULES
+static int
+__ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+					unsigned long addr)
+{
+	unsigned int op;
+	unsigned long ip = rec->ip;
+	unsigned long entry, ptr, tramp;
+	struct module *mod = rec->arch.mod;
+
+	/* If we never set up ftrace trampolines, then bail */
+	if (!mod->arch.tramp || !mod->arch.tramp_regs) {
+		pr_err("No ftrace trampoline\n");
+		return -EINVAL;
+	}
+
+	/* read where this goes */
+	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
+		pr_err("Fetching opcode failed.\n");
+		return -EFAULT;
+	}
+
+	/* Make sure that that this is still a 24bit jump */
+	if (!is_bl_op(op)) {
+		pr_err("Not expected bl: opcode is %x\n", op);
+		return -EINVAL;
+	}
+
+	/* lets find where the pointer goes */
+	tramp = find_bl_target(ip, op);
+	entry = ppc_global_function_entry((void *)old_addr);
+
+	pr_devel("ip:%lx jumps to %lx", ip, tramp);
+
+	if (tramp != entry) {
+		/* old_addr is not within range, so we must have used a trampoline */
+		if (module_trampoline_target(mod, tramp, &ptr)) {
+			pr_err("Failed to get trampoline target\n");
+			return -EFAULT;
+		}
+
+		pr_devel("trampoline target %lx", ptr);
+
+		/* This should match what was called */
+		if (ptr != entry) {
+			pr_err("addr %lx does not match expected %lx\n", ptr, entry);
+			return -EINVAL;
+		}
+	}
+
+	/* The new target may be within range */
+	if (test_24bit_addr(ip, addr)) {
+		/* within range */
+		if (patch_branch((unsigned int *)ip, addr, BRANCH_SET_LINK)) {
+			pr_err("REL24 out of range!\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (rec->flags & FTRACE_FL_REGS)
+		tramp = mod->arch.tramp_regs;
+	else
+		tramp = mod->arch.tramp;
+
+	if (module_trampoline_target(mod, tramp, &ptr)) {
+		pr_err("Failed to get trampoline target\n");
+		return -EFAULT;
+	}
+
+	pr_devel("trampoline target %lx", ptr);
+
+	entry = ppc_global_function_entry((void *)addr);
+	/* This should match what was called */
+	if (ptr != entry) {
+		pr_err("addr %lx does not match expected %lx\n", ptr, entry);
+		return -EINVAL;
+	}
+
+	/* Ensure branch is within 24 bits */
+	if (!create_branch((unsigned int *)ip, tramp, BRANCH_SET_LINK)) {
+		pr_err("Branch out of range\n");
+		return -EINVAL;
+	}
+
+	if (patch_branch((unsigned int *)ip, tramp, BRANCH_SET_LINK)) {
+		pr_err("REL24 out of range!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#endif
+
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	unsigned long ip = rec->ip;
+	unsigned int old, new;
+
+	/*
+	 * If the calling address is more that 24 bits away,
+	 * then we had to use a trampoline to make the call.
+	 * Otherwise just update the call site.
+	 */
+	if (test_24bit_addr(ip, addr) && test_24bit_addr(ip, old_addr)) {
+		/* within range */
+		old = ftrace_call_replace(ip, old_addr, 1);
+		new = ftrace_call_replace(ip, addr, 1);
+		return ftrace_modify_code(ip, old, new);
+	}
+
+#ifdef CONFIG_MODULES
+	/*
+	 * Out of range jumps are called from modules.
+	 */
+	if (!rec->arch.mod) {
+		pr_err("No module loaded\n");
+		return -EINVAL;
+	}
+
+	return __ftrace_modify_call(rec, old_addr, addr);
+#else
+	/* We should not get here without modules */
+	return -EINVAL;
+#endif /* CONFIG_MODULES */
+}
+#endif
+
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned long ip = (unsigned long)(&ftrace_call);
@@ -482,6 +632,16 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	new = ftrace_call_replace(ip, (unsigned long)func, 1);
 	ret = ftrace_modify_code(ip, old, new);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	/* Also update the regs callback function */
+	if (!ret) {
+		ip = (unsigned long)(&ftrace_regs_call);
+		old = *(unsigned int *)&ftrace_regs_call;
+		new = ftrace_call_replace(ip, (unsigned long)func, 1);
+		ret = ftrace_modify_code(ip, old, new);
+	}
+#endif
+
 	return ret;
 }
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index ae1cbe783ab6..ed9d7a46c3af 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -20,8 +20,8 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
  *
- * ftrace_caller() is the function that replaces _mcount() when ftrace is
- * active.
+ * ftrace_caller()/ftrace_regs_caller() is the function that replaces _mcount()
+ * when ftrace is active.
  *
  * We arrive here after a function A calls function B, and we are the trace
  * function for B. When we enter r1 points to A's stack frame, B has not yet
@@ -37,7 +37,7 @@
  * Our job is to save the register state into a struct pt_regs (on the stack)
  * and then arrange for the ftrace function to be called.
  */
-_GLOBAL(ftrace_caller)
+_GLOBAL(ftrace_regs_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0,LRSAVE(r1)
 
@@ -100,8 +100,8 @@ _GLOBAL(ftrace_caller)
 	addi    r6, r1 ,STACK_FRAME_OVERHEAD
 
 	/* ftrace_call(r3, r4, r5, r6) */
-.globl ftrace_call
-ftrace_call:
+.globl ftrace_regs_call
+ftrace_regs_call:
 	bl	ftrace_stub
 	nop
 
@@ -162,6 +162,7 @@ ftrace_call:
 	bne-	livepatch_handler
 #endif
 
+ftrace_caller_common:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 .globl ftrace_graph_call
 ftrace_graph_call:
@@ -182,6 +183,66 @@ ftrace_no_trace:
 	mtlr	r0
 	bctr
 
+_GLOBAL(ftrace_caller)
+	/* Save the original return address in A's stack frame */
+	std	r0, LRSAVE(r1)
+
+	/* Create our stack frame + pt_regs */
+	stdu	r1, -SWITCH_FRAME_SIZE(r1)
+
+	/* Save all gprs to pt_regs */
+	SAVE_8GPRS(3, r1)
+
+	lbz	r3, PACA_FTRACE_ENABLED(r13)
+	cmpdi	r3, 0
+	beq	ftrace_no_trace
+
+	/* Get the _mcount() call site out of LR */
+	mflr	r7
+	std     r7, _NIP(r1)
+
+	/* Save callee's TOC in the ABI compliant location */
+	std	r2, 24(r1)
+	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
+
+	addis	r3, r2, function_trace_op@toc@ha
+	addi	r3, r3, function_trace_op@toc@l
+	ld	r5, 0(r3)
+
+	/* Calculate ip from nip-4 into r3 for call below */
+	subi    r3, r7, MCOUNT_INSN_SIZE
+
+	/* Put the original return address in r4 as parent_ip */
+	mr	r4, r0
+
+	/* Set pt_regs to NULL */
+	li	r6, 0
+
+	/* ftrace_call(r3, r4, r5, r6) */
+.globl ftrace_call
+ftrace_call:
+	bl	ftrace_stub
+	nop
+
+	ld	r3, _NIP(r1)
+	mtctr	r3
+
+	/* Restore gprs */
+	REST_8GPRS(3,r1)
+
+	/* Restore callee's TOC */
+	ld	r2, 24(r1)
+
+	/* Pop our stack frame */
+	addi	r1, r1, SWITCH_FRAME_SIZE
+
+	/* Reload original LR */
+	ld	r0, LRSAVE(r1)
+	mtlr	r0
+
+	/* Handle function_graph or go back */
+	b	ftrace_caller_common
+
 #ifdef CONFIG_LIVEPATCH
 	/*
 	 * This function runs in the mcount context, between two functions. As
-- 
2.17.0
