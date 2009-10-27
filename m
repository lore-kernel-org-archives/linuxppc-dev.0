Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 15:50:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, benh@kernel.crashing.org
Subject: [PATCH 3/6] powerpc: tracing: Add hypervisor call tracepoints
Message-ID: <20091027045029.GD3085@kryten>
References: <20091027044742.GB3085@kryten>
 <20091027044914.GC3085@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091027044914.GC3085@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add hcall_entry and hcall_exit tracepoints. This replaces the inline
assembly HCALL_STATS code and converts it to use the new tracepoints.

To keep the disabled case as quick as possible, we embed a status word
in the TOC so we can get at it with a single load. By doing so we
keep the overhead at a minimum. Time taken for a null hcall:

No tracepoint code:	135.79 cycles
Disabled tracepoints:	137.95 cycles

For reference, before this patch enabling HCALL_STATS resulted in a null
hcall of 201.44 cycles!

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/hvCall.S	2009-10-27 13:36:05.000000000 +1100
+++ linux.trees.git/arch/powerpc/platforms/pseries/hvCall.S	2009-10-27 14:53:21.000000000 +1100
@@ -14,20 +14,54 @@
 	
 #define STK_PARM(i)     (48 + ((i)-3)*8)
 
-#ifdef CONFIG_HCALL_STATS
+#ifdef CONFIG_TRACEPOINTS
+
+	.section	".toc","aw"
+
+	.globl hcall_tracepoint_refcount
+hcall_tracepoint_refcount:
+	.llong	0
+
+	.section	".text"
+
 /*
  * precall must preserve all registers.  use unused STK_PARM()
- * areas to save snapshots and opcode.
+ * areas to save snapshots and opcode. We branch around this
+ * in early init (eg when populating the MMU hashtable) by using an
+ * unconditional cpu feature.
  */
 #define HCALL_INST_PRECALL					\
-	std	r3,STK_PARM(r3)(r1);	/* save opcode */	\
-	mftb	r0;			/* get timebase and */	\
-	std     r0,STK_PARM(r5)(r1);	/* save for later */	\
 BEGIN_FTR_SECTION;						\
-	mfspr	r0,SPRN_PURR;		/* get PURR and */	\
-	std	r0,STK_PARM(r6)(r1);	/* save for later */	\
-END_FTR_SECTION_IFSET(CPU_FTR_PURR);
-	
+	b	1f;						\
+END_FTR_SECTION(0, 1);						\
+	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
+	cmpdi	r12,0;						\
+	beq+	1f;						\
+	mflr	r0;						\
+	std	r3,STK_PARM(r3)(r1);				\
+	std	r4,STK_PARM(r4)(r1);				\
+	std	r5,STK_PARM(r5)(r1);				\
+	std	r6,STK_PARM(r6)(r1);				\
+	std	r7,STK_PARM(r7)(r1);				\
+	std	r8,STK_PARM(r8)(r1);				\
+	std	r9,STK_PARM(r9)(r1);				\
+	std	r10,STK_PARM(r10)(r1);				\
+	std	r0,16(r1);					\
+	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
+	bl	.__trace_hcall_entry;				\
+	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
+	ld	r0,16(r1);					\
+	ld	r3,STK_PARM(r3)(r1);				\
+	ld	r4,STK_PARM(r4)(r1);				\
+	ld	r5,STK_PARM(r5)(r1);				\
+	ld	r6,STK_PARM(r6)(r1);				\
+	ld	r7,STK_PARM(r7)(r1);				\
+	ld	r8,STK_PARM(r8)(r1);				\
+	ld	r9,STK_PARM(r9)(r1);				\
+	ld	r10,STK_PARM(r10)(r1);				\
+	mtlr	r0;						\
+1:
+
 /*
  * postcall is performed immediately before function return which
  * allows liberal use of volatile registers.  We branch around this
@@ -38,40 +72,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_PURR);
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
-	ld	r4,STK_PARM(r3)(r1);	/* validate opcode */	\
-	cmpldi	cr7,r4,MAX_HCALL_OPCODE;			\
-	bgt-	cr7,1f;						\
-								\
-	/* get time and PURR snapshots after hcall */		\
-	mftb	r7;			/* timebase after */	\
-BEGIN_FTR_SECTION;						\
-	mfspr	r8,SPRN_PURR;		/* PURR after */	\
-	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
-	subf	r6,r6,r8;		/* delta */		\
-END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
-	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
-	subf	r5,r5,r7;		/* time delta */	\
-								\
-	/* calculate address of stat structure r4 = opcode */	\
-	srdi	r4,r4,2;		/* index into array */	\
-	mulli	r4,r4,HCALL_STAT_SIZE;				\
-	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\
-	add	r4,r4,r7;					\
-	ld	r7,PACA_DATA_OFFSET(r13); /* per cpu offset */	\
-	add	r4,r4,r7;					\
-								\
-	/* update stats	*/					\
-	ld	r7,HCALL_STAT_CALLS(r4); /* count */		\
-	addi	r7,r7,1;					\
-	std	r7,HCALL_STAT_CALLS(r4);			\
-	ld      r7,HCALL_STAT_TB(r4);	/* timebase */		\
-	add	r7,r7,r5;					\
-	std	r7,HCALL_STAT_TB(r4);				\
-BEGIN_FTR_SECTION;						\
-	ld	r7,HCALL_STAT_PURR(r4);	/* PURR */		\
-	add	r7,r7,r6;					\
-	std	r7,HCALL_STAT_PURR(r4);				\
-END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
+	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
+	cmpdi	r12,0;						\
+	beq+	1f;						\
+	mflr	r0;						\
+	ld	r6,STK_PARM(r3)(r1);				\
+	std	r3,STK_PARM(r3)(r1);				\
+	mr	r4,r3;						\
+	mr	r3,r6;						\
+	std	r0,16(r1);					\
+	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
+	bl	.__trace_hcall_exit;				\
+	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
+	ld	r0,16(r1);					\
+	ld	r3,STK_PARM(r3)(r1);				\
+	mtlr	r0;						\
 1:
 #else
 #define HCALL_INST_PRECALL
Index: linux.trees.git/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/lpar.c	2009-10-27 13:36:05.000000000 +1100
+++ linux.trees.git/arch/powerpc/platforms/pseries/lpar.c	2009-10-27 14:53:21.000000000 +1100
@@ -39,6 +39,7 @@
 #include <asm/cputable.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
+#include <asm/trace.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -661,3 +662,34 @@ void arch_free_page(struct page *page, i
 EXPORT_SYMBOL(arch_free_page);
 
 #endif
+
+#ifdef CONFIG_TRACEPOINTS
+/*
+ * We optimise our hcall path by placing hcall_tracepoint_refcount
+ * directly in the TOC so we can check if the hcall tracepoints are
+ * enabled via a single load.
+ */
+
+/* NB: reg/unreg are called while guarded with the tracepoints_mutex */
+extern long hcall_tracepoint_refcount;
+
+void hcall_tracepoint_regfunc(void)
+{
+	hcall_tracepoint_refcount++;
+}
+
+void hcall_tracepoint_unregfunc(void)
+{
+	hcall_tracepoint_refcount--;
+}
+
+void __trace_hcall_entry(unsigned long opcode)
+{
+	trace_hcall_entry(opcode);
+}
+
+void __trace_hcall_exit(long opcode, unsigned long retval)
+{
+	trace_hcall_exit(opcode, retval);
+}
+#endif
Index: linux.trees.git/arch/powerpc/include/asm/trace.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/trace.h	2009-10-27 13:36:30.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/trace.h	2009-10-27 14:56:38.000000000 +1100
@@ -76,6 +76,51 @@ TRACE_EVENT(timer_interrupt_exit,
 	TP_printk("pt_regs=%p", __entry->regs)
 );
 
+#ifdef CONFIG_PPC_PSERIES
+extern void hcall_tracepoint_regfunc(void);
+extern void hcall_tracepoint_unregfunc(void);
+
+TRACE_EVENT_FN(hcall_entry,
+
+	TP_PROTO(unsigned long opcode),
+
+	TP_ARGS(opcode),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, opcode)
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+	),
+
+	TP_printk("opcode=%lu", __entry->opcode),
+
+	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
+);
+
+TRACE_EVENT_FN(hcall_exit,
+
+	TP_PROTO(unsigned long opcode, unsigned long retval),
+
+	TP_ARGS(opcode, retval),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, opcode)
+		__field(unsigned long, retval)
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+		__entry->retval = retval;
+	),
+
+	TP_printk("opcode=%lu retval=%lu", __entry->opcode, __entry->retval),
+
+	hcall_tracepoint_regfunc, hcall_tracepoint_unregfunc
+);
+#endif
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
Index: linux.trees.git/arch/powerpc/include/asm/hvcall.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/hvcall.h	2009-10-27 13:36:05.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/hvcall.h	2009-10-27 14:53:21.000000000 +1100
@@ -274,6 +274,8 @@ struct hcall_stats {
 	unsigned long	num_calls;	/* number of calls (on this CPU) */
 	unsigned long	tb_total;	/* total wall time (mftb) of calls. */
 	unsigned long	purr_total;	/* total cpu time (PURR) of calls. */
+	unsigned long	tb_start;
+	unsigned long	purr_start;
 };
 #define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
 
Index: linux.trees.git/arch/powerpc/platforms/pseries/hvCall_inst.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/hvCall_inst.c	2009-10-27 13:36:05.000000000 +1100
+++ linux.trees.git/arch/powerpc/platforms/pseries/hvCall_inst.c	2009-10-27 14:53:21.000000000 +1100
@@ -26,6 +26,7 @@
 #include <asm/hvcall.h>
 #include <asm/firmware.h>
 #include <asm/cputable.h>
+#include <asm/trace.h>
 
 DEFINE_PER_CPU(struct hcall_stats[HCALL_STAT_ARRAY_SIZE], hcall_stats);
 
@@ -100,6 +101,34 @@ static const struct file_operations hcal
 #define	HCALL_ROOT_DIR		"hcall_inst"
 #define CPU_NAME_BUF_SIZE	32
 
+
+static void probe_hcall_entry(unsigned long opcode)
+{
+	struct hcall_stats *h;
+
+	if (opcode > MAX_HCALL_OPCODE)
+		return;
+
+	h = &get_cpu_var(hcall_stats)[opcode / 4];
+	h->tb_start = mftb();
+	h->purr_start = mfspr(SPRN_PURR);
+}
+
+static void probe_hcall_exit(unsigned long opcode, unsigned long retval)
+{
+	struct hcall_stats *h;
+
+	if (opcode > MAX_HCALL_OPCODE)
+		return;
+
+	h = &__get_cpu_var(hcall_stats)[opcode / 4];
+	h->num_calls++;
+	h->tb_total = mftb() - h->tb_start;
+	h->purr_total = mfspr(SPRN_PURR) - h->purr_start;
+
+	put_cpu_var(hcall_stats);
+}
+
 static int __init hcall_inst_init(void)
 {
 	struct dentry *hcall_root;
@@ -110,6 +139,14 @@ static int __init hcall_inst_init(void)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
+	if (register_trace_hcall_entry(probe_hcall_entry))
+		return -EINVAL;
+
+	if (register_trace_hcall_exit(probe_hcall_exit)) {
+		unregister_trace_hcall_entry(probe_hcall_entry);
+		return -EINVAL;
+	}
+
 	hcall_root = debugfs_create_dir(HCALL_ROOT_DIR, NULL);
 	if (!hcall_root)
 		return -ENOMEM;
Index: linux.trees.git/arch/powerpc/Kconfig.debug
===================================================================
--- linux.trees.git.orig/arch/powerpc/Kconfig.debug	2009-10-27 13:36:05.000000000 +1100
+++ linux.trees.git/arch/powerpc/Kconfig.debug	2009-10-27 13:36:30.000000000 +1100
@@ -46,7 +46,7 @@ config DEBUG_STACK_USAGE
 
 config HCALL_STATS
 	bool "Hypervisor call instrumentation"
-	depends on PPC_PSERIES && DEBUG_FS
+	depends on PPC_PSERIES && DEBUG_FS && TRACEPOINTS
 	help
 	  Adds code to keep track of the number of hypervisor calls made and
 	  the amount of time spent in hypervisor calls.  Wall time spent in
