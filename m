Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC0241A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 04:28:58 +1100 (AEDT)
In-Reply-To: <20151125172608.9588569260@newverein.lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Wed, 25 Nov 2015 17:23:32 +0100
Subject: [PATCH v4 1/9] ppc64 (le): prepare for -mprofile-kernel
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151125172855.49E3469260@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The gcc switch -mprofile-kernel, available for ppc64 on gcc > 4.8.5,
allows to call _mcount very early in the function, which low-level
ASM code and code patching functions need to consider.
Especially the link register and the parameter registers are still
alive and not yet saved into a new stack frame.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/kernel/entry_64.S  | 44 +++++++++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/ftrace.c    | 12 +++++++++--
 arch/powerpc/kernel/module_64.c | 13 ++++++++++++
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a94f155..8d56b16 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1206,7 +1206,11 @@ _GLOBAL(enter_prom)
 #ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL(mcount)
 _GLOBAL(_mcount)
-	blr
+	mflr	r0
+	mtctr	r0
+	ld	r0,LRSAVE(r1)
+	mtlr	r0
+	bctr
 
 _GLOBAL_TOC(ftrace_caller)
 	/* Taken from output of objdump from lib64/glibc */
@@ -1262,13 +1266,28 @@ _GLOBAL(ftrace_stub)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 _GLOBAL(ftrace_graph_caller)
+#ifdef CC_USING_MPROFILE_KERNEL
+	// with -mprofile-kernel, parameter regs are still alive at _mcount
+	std	r10, 104(r1)
+	std	r9, 96(r1)
+	std	r8, 88(r1)
+	std	r7, 80(r1)
+	std	r6, 72(r1)
+	std	r5, 64(r1)
+	std	r4, 56(r1)
+	std	r3, 48(r1)
+	mfctr	r4		// ftrace_caller has moved local addr here
+	std	r4, 40(r1)
+	mflr	r3		// ftrace_caller has restored LR from stack
+#else
 	/* load r4 with local address */
 	ld	r4, 128(r1)
-	subi	r4, r4, MCOUNT_INSN_SIZE
 
 	/* Grab the LR out of the caller stack frame */
 	ld	r11, 112(r1)
 	ld	r3, 16(r11)
+#endif
+	subi	r4, r4, MCOUNT_INSN_SIZE
 
 	bl	prepare_ftrace_return
 	nop
@@ -1277,6 +1296,26 @@ _GLOBAL(ftrace_graph_caller)
 	 * prepare_ftrace_return gives us the address we divert to.
 	 * Change the LR in the callers stack frame to this.
 	 */
+
+#ifdef CC_USING_MPROFILE_KERNEL
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
+#else
 	ld	r11, 112(r1)
 	std	r3, 16(r11)
 
@@ -1284,6 +1323,7 @@ _GLOBAL(ftrace_graph_caller)
 	mtlr	r0
 	addi	r1, r1, 112
 	blr
+#endif
 
 _GLOBAL(return_to_handler)
 	/* need to save return values */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 44d4d8e..080c525 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -306,11 +306,19 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 * The load offset is different depending on the ABI. For simplicity
 	 * just mask it out when doing the compare.
 	 */
+#ifndef CC_USING_MPROFILE_KERNEL
 	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
-		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
+		pr_err("Unexpected call sequence at %p: %x %x\n",
+		ip, op[0], op[1]);
 		return -EINVAL;
 	}
-
+#else
+	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
+	if (op[0] != 0x60000000) {
+		pr_err("Unexpected call at %p: %x\n", ip, op[0]);
+		return -EINVAL;
+	}
+#endif
 	/* If we never set up a trampoline to ftrace_caller, then bail */
 	if (!rec->arch.mod->arch.tramp) {
 		pr_err("No ftrace trampoline\n");
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6838451..0819ce7 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -475,6 +475,19 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
 static int restore_r2(u32 *instruction, struct module *me)
 {
 	if (*instruction != PPC_INST_NOP) {
+#ifdef CC_USING_MPROFILE_KERNEL
+		/* -mprofile_kernel sequence starting with
+		 * mflr r0; std r0, LRSAVE(r1)
+		 */
+		if (instruction[-3] == 0x7c0802a6 &&
+		    instruction[-2] == 0xf8010010) {
+			/* Nothing to be done here, it's an _mcount
+			 * call location and r2 will have to be
+			 * restored in the _mcount function.
+			 */
+			return 2;
+		};
+#endif
 		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
-- 
1.8.5.6
