Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlNyz21ljzDqBR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 22:53:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 5/5] powerpc/livepatch: Add live patching support on ppc64le
Date: Wed, 13 Apr 2016 22:53:23 +1000
Message-Id: <1460552003-15409-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the kconfig logic & assembly support for handling live patched
functions. This depends on DYNAMIC_FTRACE_WITH_REGS, which in turn
depends on the new -mprofile-kernel ftrace ABI, which is only supported
currently on ppc64le.

Live patching is handled by a special ftrace handler. This means it runs
from ftrace_caller(). The live patch handler modifies the NIP so as to
redirect the return from ftrace_caller() to the new patched function.

However there is one particularly tricky case we need to handle.

If a function A calls another function B, and it is known at link time
that they share the same TOC, then A will not save or restore its TOC,
and will call the local entry point of B.

When we live patch B, we replace it with a new function C, which may
not have the same TOC as A. At live patch time it's too late to modify A
to do the TOC save/restore, so the live patching code must interpose
itself between A and C, and do the TOC save/restore that A omitted.

An additionaly complication is that the livepatch code can not create a
stack frame in order to save the TOC. That is because if C takes > 8
arguments, or is varargs, A will have written the arguments for C in
A's stack frame.

To solve this, we introduce a "livepatch stack" which grows upward from
the base of the regular stack, and is used to store the TOC & LR when
calling a live patched function.

When the patched function returns, we retrieve the real LR & TOC from
the livepatch stack, restore them, and pop the livepatch "stack frame".

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig              |  3 ++
 arch/powerpc/kernel/asm-offsets.c |  4 ++
 arch/powerpc/kernel/entry_64.S    | 97 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c038286..ed0603102442 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
+	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
@@ -1107,3 +1108,5 @@ config PPC_LIB_RHEAP
 	bool
 
 source "arch/powerpc/kvm/Kconfig"
+
+source "kernel/livepatch/Kconfig"
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0d0183d3180a..c9370d4e36bd 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -86,6 +86,10 @@ int main(void)
 	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_LIVEPATCH
+	DEFINE(TI_livepatch_sp, offsetof(struct thread_info, livepatch_sp));
+#endif
+
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 #ifdef CONFIG_BOOKE
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9916d150b28c..39a79c89a4b6 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -20,6 +20,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/magic.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -1248,6 +1249,9 @@ _GLOBAL(ftrace_caller)
 	addi	r3,r3,function_trace_op@toc@l
 	ld	r5,0(r3)
 
+#ifdef CONFIG_LIVEPATCH
+	mr	r14,r7		/* remember old NIP */
+#endif
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
 
@@ -1272,6 +1276,9 @@ ftrace_call:
 	/* Load ctr with the possibly modified NIP */
 	ld	r3, _NIP(r1)
 	mtctr	r3
+#ifdef CONFIG_LIVEPATCH
+	cmpd	r14,r3		/* has NIP been altered? */
+#endif
 
 	/* Restore gprs */
 	REST_8GPRS(0,r1)
@@ -1289,6 +1296,11 @@ ftrace_call:
 	ld	r0, LRSAVE(r1)
 	mtlr	r0
 
+#ifdef CONFIG_LIVEPATCH
+        /* Based on the cmpd above, if the NIP was altered handle livepatch */
+	bne-	livepatch_handler
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	stdu	r1, -112(r1)
 .globl ftrace_graph_call
@@ -1305,6 +1317,91 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
+
+#ifdef CONFIG_LIVEPATCH
+	/*
+	 * This function runs in the mcount context, between two functions. As
+	 * such it can only clobber registers which are volatile and used in
+	 * function linkage.
+	 *
+	 * We get here when a function A, calls another function B, but B has
+	 * been live patched with a new function C.
+	 *
+	 * On entry:
+	 *  - we have no stack frame and can not allocate one
+	 *  - LR points back to the original caller (in A)
+	 *  - CTR holds the new NIP in C
+	 *  - r0 & r12 are free
+	 *
+	 * r0 can't be used as the base register for a DS-form load or store, so
+	 * we temporarily shuffle r1 (stack pointer) into r0 and then put it back.
+	 */
+livepatch_handler:
+	CURRENT_THREAD_INFO(r12, r1)
+
+	/* Save stack pointer into r0 */
+	mr	r0, r1
+
+	/* Allocate 3 x 8 bytes */
+	ld	r1, TI_livepatch_sp(r12)
+	addi	r1, r1, 24
+	std	r1, TI_livepatch_sp(r12)
+
+	/* Save toc & real LR on livepatch stack */
+	std	r2,  -24(r1)
+	mflr	r12
+	std	r12, -16(r1)
+
+	/* Store stack end marker */
+	lis     r12, STACK_END_MAGIC@h
+	ori     r12, r12, STACK_END_MAGIC@l
+	std	r12, -8(r1)
+
+	/* Restore real stack pointer */
+	mr	r1, r0
+
+	/* Put ctr in r12 for global entry and branch there */
+	mfctr	r12
+	bctrl
+
+	/*
+	 * Now we are returning from the patched function to the original
+	 * caller A. We are free to use r0 and r12, and we can use r2 until we
+	 * restore it.
+	 */
+
+	CURRENT_THREAD_INFO(r12, r1)
+
+	/* Save stack pointer into r0 */
+	mr	r0, r1
+
+	ld	r1, TI_livepatch_sp(r12)
+
+	/* Check stack marker hasn't been trashed */
+	lis     r2,  STACK_END_MAGIC@h
+	ori     r2,  r2, STACK_END_MAGIC@l
+	ld	r12, -8(r1)
+1:	tdne	r12, r2
+	EMIT_BUG_ENTRY 1b, __FILE__, __LINE__ - 1, 0
+
+	/* Restore LR & toc from livepatch stack */
+	ld	r12, -16(r1)
+	mtlr	r12
+	ld	r2,  -24(r1)
+
+	/* Pop livepatch stack frame */
+	CURRENT_THREAD_INFO(r12, r0)
+	subi	r1, r1, 24
+	std	r1, TI_livepatch_sp(r12)
+
+	/* Restore real stack pointer */
+	mr	r1, r0
+
+	/* Return to original caller of live patched function */
+	blr
+#endif
+
+
 #else
 _GLOBAL_TOC(_mcount)
 	/* Taken from output of objdump from lib64/glibc */
-- 
2.5.0
