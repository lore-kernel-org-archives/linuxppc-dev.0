Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 15:51:09 +1100
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, benh@kernel.crashing.org
Subject: [PATCH 4/6] powerpc: tracing: Give hypervisor call tracepoints
	access to arguments
Message-ID: <20091027045109.GE3085@kryten>
References: <20091027044742.GB3085@kryten> <20091027044914.GC3085@kryten>
	<20091027045029.GD3085@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091027045029.GD3085@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


While most users of the hcall tracepoints will only want the opcode and return
code, some will want all the arguments. To avoid the complexity of using
varargs we pass a pointer to the register save area which contain all
arguments.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/hvCall.S	2009-10-27 14:29:09.000000000 +1100
+++ linux.trees.git/arch/powerpc/platforms/pseries/hvCall.S	2009-10-27 14:29:16.000000000 +1100
@@ -30,7 +30,7 @@ hcall_tracepoint_refcount:
  * in early init (eg when populating the MMU hashtable) by using an
  * unconditional cpu feature.
  */
-#define HCALL_INST_PRECALL					\
+#define HCALL_INST_PRECALL(FIRST_REG)				\
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
@@ -47,6 +47,7 @@ END_FTR_SECTION(0, 1);						\
 	std	r9,STK_PARM(r9)(r1);				\
 	std	r10,STK_PARM(r10)(r1);				\
 	std	r0,16(r1);					\
+	addi	r4,r1,STK_PARM(FIRST_REG);			\
 	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
 	bl	.__trace_hcall_entry;				\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
@@ -68,7 +69,7 @@ END_FTR_SECTION(0, 1);						\
  * in early init (eg when populating the MMU hashtable) by using an
  * unconditional cpu feature.
  */
-#define HCALL_INST_POSTCALL					\
+#define __HCALL_INST_POSTCALL					\
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
@@ -88,9 +89,19 @@ END_FTR_SECTION(0, 1);						\
 	ld	r3,STK_PARM(r3)(r1);				\
 	mtlr	r0;						\
 1:
+
+#define HCALL_INST_POSTCALL_NORETS				\
+	li	r5,0;						\
+	__HCALL_INST_POSTCALL
+
+#define HCALL_INST_POSTCALL(BUFREG)				\
+	mr	r5,BUFREG;					\
+	__HCALL_INST_POSTCALL
+
 #else
-#define HCALL_INST_PRECALL
-#define HCALL_INST_POSTCALL
+#define HCALL_INST_PRECALL(FIRST_ARG)
+#define HCALL_INST_POSTCALL_NORETS
+#define HCALL_INST_POSTCALL(BUFREG)
 #endif
 
 	.text
@@ -101,11 +112,11 @@ _GLOBAL(plpar_hcall_norets)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL
+	HCALL_INST_PRECALL(r4)
 
 	HVSC				/* invoke the hypervisor */
 
-	HCALL_INST_POSTCALL
+	HCALL_INST_POSTCALL_NORETS
 
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
@@ -117,7 +128,7 @@ _GLOBAL(plpar_hcall)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL
+	HCALL_INST_PRECALL(r5)
 
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
@@ -136,7 +147,7 @@ _GLOBAL(plpar_hcall)
 	std	r6, 16(r12)
 	std	r7, 24(r12)
 
-	HCALL_INST_POSTCALL
+	HCALL_INST_POSTCALL(r12)
 
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
@@ -183,7 +194,7 @@ _GLOBAL(plpar_hcall9)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL
+	HCALL_INST_PRECALL(r5)
 
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
@@ -211,7 +222,7 @@ _GLOBAL(plpar_hcall9)
 	std	r11,56(r12)
 	std	r0, 64(r12)
 
-	HCALL_INST_POSTCALL
+	HCALL_INST_POSTCALL(r12)
 
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
Index: linux.trees.git/arch/powerpc/include/asm/trace.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/trace.h	2009-10-27 14:28:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/trace.h	2009-10-27 14:29:16.000000000 +1100
@@ -81,9 +81,9 @@ extern void hcall_tracepoint_unregfunc(v
 
 TRACE_EVENT_FN(hcall_entry,
 
-	TP_PROTO(unsigned long opcode),
+	TP_PROTO(unsigned long opcode, unsigned long *args),
 
-	TP_ARGS(opcode),
+	TP_ARGS(opcode, args),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, opcode)
@@ -100,9 +100,10 @@ TRACE_EVENT_FN(hcall_entry,
 
 TRACE_EVENT_FN(hcall_exit,
 
-	TP_PROTO(unsigned long opcode, unsigned long retval),
+	TP_PROTO(unsigned long opcode, unsigned long retval,
+		unsigned long *retbuf),
 
-	TP_ARGS(opcode, retval),
+	TP_ARGS(opcode, retval, retbuf),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, opcode)
Index: linux.trees.git/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/lpar.c	2009-10-27 14:28:16.000000000 +1100
+++ linux.trees.git/arch/powerpc/platforms/pseries/lpar.c	2009-10-27 14:29:16.000000000 +1100
@@ -683,13 +683,14 @@ void hcall_tracepoint_unregfunc(void)
 	hcall_tracepoint_refcount--;
 }
 
-void __trace_hcall_entry(unsigned long opcode)
+void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
 {
-	trace_hcall_entry(opcode);
+	trace_hcall_entry(opcode, args);
 }
 
-void __trace_hcall_exit(long opcode, unsigned long retval)
+void __trace_hcall_exit(long opcode, unsigned long retval,
+			unsigned long *retbuf)
 {
-	trace_hcall_exit(opcode, retval);
+	trace_hcall_exit(opcode, retval, retbuf);
 }
 #endif
Index: linux.trees.git/arch/powerpc/platforms/pseries/hvCall_inst.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/hvCall_inst.c	2009-10-27 14:28:16.000000000 +1100
+++ linux.trees.git/arch/powerpc/platforms/pseries/hvCall_inst.c	2009-10-27 14:29:16.000000000 +1100
@@ -102,7 +102,7 @@ static const struct file_operations hcal
 #define CPU_NAME_BUF_SIZE	32
 
 
-static void probe_hcall_entry(unsigned long opcode)
+static void probe_hcall_entry(unsigned long opcode, unsigned long *args)
 {
 	struct hcall_stats *h;
 
@@ -114,7 +114,8 @@ static void probe_hcall_entry(unsigned l
 	h->purr_start = mfspr(SPRN_PURR);
 }
 
-static void probe_hcall_exit(unsigned long opcode, unsigned long retval)
+static void probe_hcall_exit(unsigned long opcode, unsigned long retval,
+			     unsigned long *retbuf)
 {
 	struct hcall_stats *h;
 
