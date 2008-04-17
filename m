Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 17 Apr 2008 14:34:59 +1000
Subject: [PATCH 1/3] [POWERPC] Move stackframe definitions to common header
Message-Id: <20080417043607.D3070DE1F5@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves various definitions used all over the place
to parse stack frames to ptrace.h so only one definition is
needed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/entry_64.S |    3 ++-
 arch/powerpc/kernel/head_32.S  |    5 +++--
 arch/powerpc/kernel/process.c  |   28 +++++++---------------------
 arch/powerpc/xmon/xmon.c       |   13 +++++--------
 include/asm-powerpc/ptrace.h   |    9 +++++++++
 5 files changed, 26 insertions(+), 32 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/process.c	2008-04-17 13:21:33.000000000 +1000
+++ linux-work/arch/powerpc/kernel/process.c	2008-04-17 13:22:29.000000000 +1000
@@ -919,20 +919,6 @@ int validate_sp(unsigned long sp, struct
 	return valid_irq_stack(sp, p, nbytes);
 }
 
-#ifdef CONFIG_PPC64
-#define MIN_STACK_FRAME	112	/* same as STACK_FRAME_OVERHEAD, in fact */
-#define FRAME_LR_SAVE	2
-#define INT_FRAME_SIZE	(sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD + 288)
-#define REGS_MARKER	0x7265677368657265ul
-#define FRAME_MARKER	12
-#else
-#define MIN_STACK_FRAME	16
-#define FRAME_LR_SAVE	1
-#define INT_FRAME_SIZE	(sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD)
-#define REGS_MARKER	0x72656773ul
-#define FRAME_MARKER	2
-#endif
-
 EXPORT_SYMBOL(validate_sp);
 
 unsigned long get_wchan(struct task_struct *p)
@@ -944,15 +930,15 @@ unsigned long get_wchan(struct task_stru
 		return 0;
 
 	sp = p->thread.ksp;
-	if (!validate_sp(sp, p, MIN_STACK_FRAME))
+	if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD))
 		return 0;
 
 	do {
 		sp = *(unsigned long *)sp;
-		if (!validate_sp(sp, p, MIN_STACK_FRAME))
+		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD))
 			return 0;
 		if (count > 0) {
-			ip = ((unsigned long *)sp)[FRAME_LR_SAVE];
+			ip = ((unsigned long *)sp)[STACK_FRAME_LR_SAVE];
 			if (!in_sched_functions(ip))
 				return ip;
 		}
@@ -981,12 +967,12 @@ void show_stack(struct task_struct *tsk,
 	lr = 0;
 	printk("Call Trace:\n");
 	do {
-		if (!validate_sp(sp, tsk, MIN_STACK_FRAME))
+		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
 			return;
 
 		stack = (unsigned long *) sp;
 		newsp = stack[0];
-		ip = stack[FRAME_LR_SAVE];
+		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
 			printk("["REG"] ["REG"] ", sp, ip);
 			print_symbol("%s", ip);
@@ -1000,8 +986,8 @@ void show_stack(struct task_struct *tsk,
 		 * See if this is an exception frame.
 		 * We look for the "regshere" marker in the current frame.
 		 */
-		if (validate_sp(sp, tsk, INT_FRAME_SIZE)
-		    && stack[FRAME_MARKER] == REGS_MARKER) {
+		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE)
+		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
 			printk("--- Exception: %lx", regs->trap);
Index: linux-work/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/powerpc/xmon/xmon.c	2008-04-17 13:23:21.000000000 +1000
+++ linux-work/arch/powerpc/xmon/xmon.c	2008-04-17 13:30:13.000000000 +1000
@@ -1244,15 +1244,12 @@ static void get_function_bounds(unsigned
 
 static int xmon_depth_to_print = 64;
 
-#ifdef CONFIG_PPC64
-#define LRSAVE_OFFSET		0x10
-#define REG_FRAME_MARKER	0x7265677368657265ul	/* "regshere" */
-#define MARKER_OFFSET		0x60
+#define LRSAVE_OFFSET		(STACK_FRAME_LR_SAVE * sizeof(unsigned long))
+#define MARKER_OFFSET		(STACK_FRAME_MARKER * sizeof(unsigned long))
+
+#ifdef __powerpc64__
 #define REGS_OFFSET		0x70
 #else
-#define LRSAVE_OFFSET		4
-#define REG_FRAME_MARKER	0x72656773
-#define MARKER_OFFSET		8
 #define REGS_OFFSET		16
 #endif
 
@@ -1318,7 +1315,7 @@ static void xmon_show_stack(unsigned lon
 		/* Look for "regshere" marker to see if this is
 		   an exception frame. */
 		if (mread(sp + MARKER_OFFSET, &marker, sizeof(unsigned long))
-		    && marker == REG_FRAME_MARKER) {
+		    && marker == STACK_FRAME_REGS_MARKER) {
 			if (mread(sp + REGS_OFFSET, &regs, sizeof(regs))
 			    != sizeof(regs)) {
 				printf("Couldn't read registers at %lx\n",
Index: linux-work/include/asm-powerpc/ptrace.h
===================================================================
--- linux-work.orig/include/asm-powerpc/ptrace.h	2008-04-17 13:19:04.000000000 +1000
+++ linux-work/include/asm-powerpc/ptrace.h	2008-04-17 13:33:06.000000000 +1000
@@ -58,6 +58,11 @@ struct pt_regs {
 #define __ARCH_WANT_COMPAT_SYS_PTRACE
 
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
+#define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
+#define STACK_FRAME_REGS_MARKER	ASM_CONST(0x7265677368657265)
+#define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + \
+					STACK_FRAME_OVERHEAD + 288)
+#define STACK_FRAME_MARKER	12
 
 /* Size of dummy stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	128
@@ -66,6 +71,10 @@ struct pt_regs {
 #else /* __powerpc64__ */
 
 #define STACK_FRAME_OVERHEAD	16	/* size of minimum stack frame */
+#define STACK_FRAME_LR_SAVE	1	/* Location of LR in stack frame */
+#define STACK_FRAME_REGS_MARKER	ASM_CONST(0x72656773)
+#define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD)
+#define STACK_FRAME_MARKER	2
 
 /* Size of stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	64
Index: linux-work/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2008-04-17 13:49:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2008-04-17 14:09:42.000000000 +1000
@@ -29,6 +29,7 @@
 #include <asm/cputable.h>
 #include <asm/firmware.h>
 #include <asm/bug.h>
+#include <asm/ptrace.h>
 
 /*
  * System calls.
@@ -39,7 +40,7 @@
 
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
-	.tc	ID_72656773_68657265[TC],0x7265677368657265
+	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
 
 	.section	".text"
 	.align 7
Index: linux-work/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-04-17 14:10:02.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_32.S	2008-04-17 14:23:22.000000000 +1000
@@ -30,6 +30,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/ptrace.h>
 
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
@@ -268,8 +269,8 @@ __secondary_hold_acknowledge:
 	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
 	MTMSRD(r10);			/* (except for mach check in rtas) */ \
 	stw	r0,GPR0(r11);	\
-	lis	r10,0x7265;		/* put exception frame marker */ \
-	addi	r10,r10,0x6773;	\
+	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
+	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
 	stw	r10,8(r11);	\
 	SAVE_4GPRS(3, r11);	\
 	SAVE_2GPRS(7, r11)
