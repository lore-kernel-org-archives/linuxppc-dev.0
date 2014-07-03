Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF251A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 15:52:11 +1000 (EST)
Date: Thu, 3 Jul 2014 15:52:03 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc/pseries: Use jump labels for hcall tracepoints
Message-ID: <20140703155203.33af5387@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hcall tracepoints add quite a few instructions to our hcall path:

plpar_hcall:
	mr      r2,r2
	mfcr    r0
	stw     r0,8(r1)
	b       164		<---- start
	ld      r12,0(r2)
	std     r12,32(r1)
	cmpdi   r12,0
	beq     164		<---- end
...

We have an unconditional branch that gets noped out during boot and
a load/compare/branch. We also store the tracepoint value to the
stack for the hcall_exit path to use.

By using jump labels we can simplify this to just a single nop that
gets replaced with a branch when the tracepoint is enabled:

plpar_hcall:
	mr      r2,r2
	mfcr    r0
	stw     r0,8(r1)
	nop			<----
...

If jump labels are not enabled, we fall back to the old method.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/jump_label.h
===================================================================
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -10,6 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#ifndef __ASSEMBLY__
 #include <linux/types.h>
 
 #include <asm/feature-fixups.h>
@@ -42,4 +43,12 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+#else
+#define ARCH_STATIC_BRANCH(LABEL, KEY)		\
+1098:	nop;					\
+	.pushsection __jump_table, "aw";	\
+	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
+	.popsection
+#endif
+
 #endif /* _ASM_POWERPC_JUMP_LABEL_H */
Index: b/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -12,9 +12,13 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/jump_label.h>
+
+	.section	".text"
 	
 #ifdef CONFIG_TRACEPOINTS
 
+#ifndef CONFIG_JUMP_LABEL
 	.section	".toc","aw"
 
 	.globl hcall_tracepoint_refcount
@@ -22,21 +26,13 @@ hcall_tracepoint_refcount:
 	.llong	0
 
 	.section	".text"
+#endif
 
 /*
  * precall must preserve all registers.  use unused STK_PARAM()
- * areas to save snapshots and opcode. We branch around this
- * in early init (eg when populating the MMU hashtable) by using an
- * unconditional cpu feature.
+ * areas to save snapshots and opcode.
  */
 #define HCALL_INST_PRECALL(FIRST_REG)				\
-BEGIN_FTR_SECTION;						\
-	b	1f;						\
-END_FTR_SECTION(0, 1);						\
-	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
-	std	r12,32(r1);					\
-	cmpdi	r12,0;						\
-	beq+	1f;						\
 	mflr	r0;						\
 	std	r3,STK_PARAM(R3)(r1);				\
 	std	r4,STK_PARAM(R4)(r1);				\
@@ -60,22 +56,13 @@ END_FTR_SECTION(0, 1);						\
 	ld	r8,STK_PARAM(R8)(r1);				\
 	ld	r9,STK_PARAM(R9)(r1);				\
 	ld	r10,STK_PARAM(R10)(r1);				\
-	mtlr	r0;						\
-1:
+	mtlr	r0
 
 /*
  * postcall is performed immediately before function return which
- * allows liberal use of volatile registers.  We branch around this
- * in early init (eg when populating the MMU hashtable) by using an
- * unconditional cpu feature.
+ * allows liberal use of volatile registers.
  */
 #define __HCALL_INST_POSTCALL					\
-BEGIN_FTR_SECTION;						\
-	b	1f;						\
-END_FTR_SECTION(0, 1);						\
-	ld      r12,32(r1);					\
-	cmpdi	r12,0;						\
-	beq+	1f;						\
 	mflr	r0;						\
 	ld	r6,STK_PARAM(R3)(r1);				\
 	std	r3,STK_PARAM(R3)(r1);				\
@@ -87,8 +74,7 @@ END_FTR_SECTION(0, 1);						\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
 	ld	r0,16(r1);					\
 	ld	r3,STK_PARAM(R3)(r1);				\
-	mtlr	r0;						\
-1:
+	mtlr	r0
 
 #define HCALL_INST_POSTCALL_NORETS				\
 	li	r5,0;						\
@@ -98,37 +84,62 @@ END_FTR_SECTION(0, 1);						\
 	mr	r5,BUFREG;					\
 	__HCALL_INST_POSTCALL
 
+#ifdef CONFIG_JUMP_LABEL
+#define HCALL_BRANCH(LABEL)					\
+	ARCH_STATIC_BRANCH(LABEL, hcall_tracepoint_key)
+#else
+
+/*
+ * We branch around this in early init (eg when populating the MMU
+ * hashtable) by using an unconditional cpu feature.
+ */
+#define HCALL_BRANCH(LABEL)					\
+BEGIN_FTR_SECTION;						\
+	b	1f;						\
+END_FTR_SECTION(0, 1);						\
+	ld	r12,hcall_tracepoint_refcount@toc(r2);		\
+	std	r12,32(r1);					\
+	cmpdi	r12,0;						\
+	bne-	LABEL;						\
+1:
+#endif
+
 #else
 #define HCALL_INST_PRECALL(FIRST_ARG)
 #define HCALL_INST_POSTCALL_NORETS
 #define HCALL_INST_POSTCALL(BUFREG)
+#define HCALL_BRANCH(LABEL)
 #endif
 
-	.text
-
 _GLOBAL_TOC(plpar_hcall_norets)
 	HMT_MEDIUM
 
 	mfcr	r0
 	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL(R4)
-
+	HCALL_BRANCH(plpar_hcall_norets_trace)
 	HVSC				/* invoke the hypervisor */
 
-	HCALL_INST_POSTCALL_NORETS
-
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
 
+#ifdef CONFIG_TRACEPOINTS
+plpar_hcall_norets_trace:
+	HCALL_INST_PRECALL(R4)
+	HVSC
+	HCALL_INST_POSTCALL_NORETS
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+	blr
+#endif
+
 _GLOBAL_TOC(plpar_hcall)
 	HMT_MEDIUM
 
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL(R5)
+	HCALL_BRANCH(plpar_hcall_trace)
 
 	std     r4,STK_PARAM(R4)(r1)     /* Save ret buffer */
 
@@ -147,12 +158,40 @@ _GLOBAL_TOC(plpar_hcall)
 	std	r6, 16(r12)
 	std	r7, 24(r12)
 
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+#ifdef CONFIG_TRACEPOINTS
+plpar_hcall_trace:
+	HCALL_INST_PRECALL(R5)
+
+	std	r4,STK_PARAM(R4)(r1)
+	mr	r0,r4
+
+	mr	r4,r5
+	mr	r5,r6
+	mr	r6,r7
+	mr	r7,r8
+	mr	r8,r9
+	mr	r9,r10
+
+	HVSC
+
+	ld	r12,STK_PARAM(R4)(r1)
+	std	r4,0(r12)
+	std	r5,8(r12)
+	std	r6,16(r12)
+	std	r7,24(r12)
+
 	HCALL_INST_POSTCALL(r12)
 
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
-	blr				/* return r3 = status */
+	blr
+#endif
 
 /*
  * plpar_hcall_raw can be called in real mode. kexec/kdump need some
@@ -194,7 +233,7 @@ _GLOBAL_TOC(plpar_hcall9)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL(R5)
+	HCALL_BRANCH(plpar_hcall9_trace)
 
 	std     r4,STK_PARAM(R4)(r1)     /* Save ret buffer */
 
@@ -222,12 +261,49 @@ _GLOBAL_TOC(plpar_hcall9)
 	std	r11,56(r12)
 	std	r0, 64(r12)
 
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+#ifdef CONFIG_TRACEPOINTS
+plpar_hcall9_trace:
+	HCALL_INST_PRECALL(R5)
+
+	std	r4,STK_PARAM(R4)(r1)
+	mr	r0,r4
+
+	mr	r4,r5
+	mr	r5,r6
+	mr	r6,r7
+	mr	r7,r8
+	mr	r8,r9
+	mr	r9,r10
+	ld	r10,STK_PARAM(R11)(r1)
+	ld	r11,STK_PARAM(R12)(r1)
+	ld	r12,STK_PARAM(R13)(r1)
+
+	HVSC
+
+	mr	r0,r12
+	ld	r12,STK_PARAM(R4)(r1)
+	std	r4,0(r12)
+	std	r5,8(r12)
+	std	r6,16(r12)
+	std	r7,24(r12)
+	std	r8,32(r12)
+	std	r9,40(r12)
+	std	r10,48(r12)
+	std	r11,56(r12)
+	std	r0,64(r12)
+
 	HCALL_INST_POSTCALL(r12)
 
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
-	blr				/* return r3 = status */
+	blr
+#endif
 
 /* See plpar_hcall_raw to see why this is needed */
 _GLOBAL(plpar_hcall9_raw)
Index: b/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/console.h>
 #include <linux/export.h>
+#include <linux/static_key.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -649,6 +650,19 @@ EXPORT_SYMBOL(arch_free_page);
 #endif
 
 #ifdef CONFIG_TRACEPOINTS
+#ifdef CONFIG_JUMP_LABEL
+struct static_key hcall_tracepoint_key = STATIC_KEY_INIT;
+
+void hcall_tracepoint_regfunc(void)
+{
+	static_key_slow_inc(&hcall_tracepoint_key);
+}
+
+void hcall_tracepoint_unregfunc(void)
+{
+	static_key_slow_dec(&hcall_tracepoint_key);
+}
+#else
 /*
  * We optimise our hcall path by placing hcall_tracepoint_refcount
  * directly in the TOC so we can check if the hcall tracepoints are
@@ -658,13 +672,6 @@ EXPORT_SYMBOL(arch_free_page);
 /* NB: reg/unreg are called while guarded with the tracepoints_mutex */
 extern long hcall_tracepoint_refcount;
 
-/* 
- * Since the tracing code might execute hcalls we need to guard against
- * recursion. One example of this are spinlocks calling H_YIELD on
- * shared processor partitions.
- */
-static DEFINE_PER_CPU(unsigned int, hcall_trace_depth);
-
 void hcall_tracepoint_regfunc(void)
 {
 	hcall_tracepoint_refcount++;
@@ -674,6 +681,15 @@ void hcall_tracepoint_unregfunc(void)
 {
 	hcall_tracepoint_refcount--;
 }
+#endif
+
+/*
+ * Since the tracing code might execute hcalls we need to guard against
+ * recursion. One example of this are spinlocks calling H_YIELD on
+ * shared processor partitions.
+ */
+static DEFINE_PER_CPU(unsigned int, hcall_trace_depth);
+
 
 void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
 {
