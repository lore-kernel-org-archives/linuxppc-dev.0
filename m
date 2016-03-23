Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVZ4S1v36zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 02:59:04 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qVZ4R3qJRz9s4x
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 02:59:02 +1100 (AEDT)
Date: Wed, 23 Mar 2016 16:58:58 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>, jeyu@redhat.com, jkosina@suse.cz,
 jikos@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: [PATCH/RFC] ppc64 livepatch: frameless klp_return_helper using odd TOC
Message-ID: <20160323155858.GB27110@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Since nobody liked the extra stack frame nor its workarounds, here is
the next attempt. Assumptions:

1. Heuristics are bad. The better they are, the more subtly the
   way they might fail.

2. The TOC pointer is usually dividable by 4, if not by 8. An odd
   value never occurs.

Conclusively, this patch unambiguously creates an odd TOC value when
an ftraced function's global entry point is used. Ftrace_caller will
then immediately fix it, and alongside gather the information whether
the made call was local or global.

In case of live patching this information is furthermore used to decide
whether a klp_return_helper needs to be inserted or not.
CAVEAT: any frameless klp_return_helper does not play well with
sibling calls! There's an emergency exit that might work, at worst
it will cause an oops, but it surely avoids a lockup.
At least the live patching modules on ppc64le will need to be compiled
using the -fno-optimize-sibling-calls compiler flag!

Thanks go to Michael Matz and Richard Biener for reassurance about
heuristics and pointers to the compiler flag.

Signed-off-by: Torsten Duwe <duwe@suse.de>


diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9916d15..449c22a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1240,6 +1240,16 @@ _GLOBAL(ftrace_caller)
 	std     r7, _NIP(r1)
 	std     r7, _LINK(r1)
 
+#ifdef CONFIG_LIVEPATCH
+	mr	r14,r7		/* remember old NIP */
+
+	/* Test whether R2 is odd */
+	andi.	r3,r2,1
+	xor	r2,r2,r3
+	mfcr	r3		/* remember CR0 */
+	stw	r3,8(r1)
+#endif
+
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, 24(r1)
 	ld	r2,PACATOC(r13)	/* get kernel TOC in r2 */
@@ -1273,8 +1283,16 @@ ftrace_call:
 	ld	r3, _NIP(r1)
 	mtctr	r3
 
+#ifdef CONFIG_LIVEPATCH
+	lwa	r0,8(r1)
+	mtcr	r0		/* recall "global call" info in CR0 */
+
+	cmp	5,1,r14,r3	/* has NIP been altered? */
+#endif
+
 	/* Restore gprs */
-	REST_8GPRS(0,r1)
+	REST_GPR(3,r1)		/* 0:scratch, 1:SP, 2:manually below */
+	REST_4GPRS(4,r1)
 	REST_8GPRS(8,r1)
 	REST_8GPRS(16,r1)
 	REST_8GPRS(24,r1)
@@ -1289,6 +1307,30 @@ ftrace_call:
 	ld	r0, LRSAVE(r1)
 	mtlr	r0
 
+#ifdef CONFIG_LIVEPATCH
+	beq+	cr5,4f		/* likely(old_NIP == new_NIP) */
+	bne	6f		/* It was a global call already */
+
+	/* find klp_return_helper's address from here */
+	bl	5f
+5:	mflr	r12
+	addi	r12, r12, (klp_return_helper + 4 - .)@l
+
+	cmpd    r12,r0		/* sibling call? bail out! */
+	beq-	6f
+
+	subf    r0,r0,r2	/* calculate TOC - LR */
+	stw     r0,12(r1)	/* and save the delta in the reserved field */
+	std	r12, LRSAVE(r1)
+	std	r2, 24(r1)	/* save TOC now, unconditionally. */
+	mtlr	r12
+	mr	r0,r12
+6:
+	mfctr	r12		/* allow for TOC calculation in newfunc */
+	bctr
+4:
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	stdu	r1, -112(r1)
 .globl ftrace_graph_call
@@ -1305,6 +1347,24 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
+#ifdef CONFIG_LIVEPATCH
+/* Helper function for local calls that are becoming global
+ * due to live patching.
+ * We can't simply patch the NOP after the original call,
+ * because, depending on the consistency model, some kernel
+ * threads may still have called the original, local function
+ * *without* saving their TOC in the respective stack frame slot,
+ * so the decision is made per-thread during function return by
+ * maybe inserting a klp_return_helper or not.
+*/
+klp_return_helper:
+	ld	r2, 24(r1)	/* restore TOC (saved by ftrace_caller) */
+	lwa	r0,12(r1)	/* get TOC - LR */
+	subf    r0,r0,r2	/* and calculate the real return address */
+	mtlr	r0
+	blr
+#endif
+
 #else
 _GLOBAL_TOC(_mcount)
 	/* Taken from output of objdump from lib64/glibc */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 9dac18d..30b550a 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -41,6 +41,59 @@ ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 	return op;
 }
 
+#ifdef CONFIG_LIVEPATCH
+static int
+odd_TOC(unsigned long ip, bool enable)
+{
+	unsigned int *addi_loc = 0;
+	unsigned int new, replaced;
+
+	/* In case of DYNAMIC_FTRACE, mark the global entry with an odd TOC
+	 * value for live patching. 2 instructions later (what we just patched)
+	 * we'll be in ftrace_caller anyway, which will straighten it up again.
+	 */
+
+	/* This test should only succeed when a "leaf+" function
+	 * is at the beginning of a page. Those functions need no global
+	 * call indicator anyway. All (other) functions are aligned 16 bytes.
+	 */
+	if ( (ip & 0xFFFF) < 12 ) /* ip too close to beginning of a page? */
+		return 0;
+
+	addi_loc = (unsigned int *)ip;
+	addi_loc -= 2;		/* ip - 8 */
+
+	if (probe_kernel_read(&replaced, addi_loc, MCOUNT_INSN_SIZE))
+		return -EFAULT;
+
+	/* look for the 2nd 16-bit add that calculates the TOC */
+	if ( (replaced & 0xFFFF0000) != 0x38420000) { /* "addi r2,r2,#UI" */
+		addi_loc--;	/* ip - 12, older GCCs */
+
+		if (probe_kernel_read(&replaced, addi_loc, MCOUNT_INSN_SIZE))
+			return -EFAULT;
+
+		/* So is this a -mprofile-kernel _mcount site at all? */
+		if ( (replaced & 0xFFFF0000) != 0x38420000)
+			return 0;
+	}
+
+	/* Did we enable or disable ftracing here? clear or set the odd bit
+	 * accordingly.
+	 */
+	if (enable)
+		new = replaced | 1;
+	else
+		new = replaced & ~1;
+	
+	if (patch_instruction(addi_loc, new))
+		return -EPERM;
+	return 0;
+}
+#else
+static int odd_TOC(unsigned long ip, bool enable) {return 0;}
+#endif
+
 static int
 ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 {
@@ -71,7 +124,7 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 	if (patch_instruction((unsigned int *)ip, new))
 		return -EPERM;
 
-	return 0;
+	return odd_TOC(ip, (new != PPC_INST_NOP));
 }
 
 /*
@@ -194,7 +247,7 @@ __ftrace_make_nop(struct module *mod,
 		return -EPERM;
 	}
 
-	return 0;
+	return odd_TOC(ip, false);
 }
 
 #else /* !PPC64 */
@@ -384,7 +437,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EINVAL;
 	}
 
-	return 0;
+	return odd_TOC((unsigned long)ip, true);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
