Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 12 Dec 2007 16:45:12 +1100
Subject: [PATCH 1/2] Make setjmp/longjmp code generic
Message-Id: <20071212054512.882AC62C070@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	RAISCH@de.ibm.com, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the setjmp/longjmp code used by xmon, generically available
to other code.  It also removes the requirement for debugger hooks to
be only called on 0x300 (data storage) exception.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/misc_64.S |  124 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/fault.c       |    6 -
 arch/powerpc/xmon/Makefile    |    2 
 arch/powerpc/xmon/setjmp.S    |  135 ------------------------------------------
 arch/powerpc/xmon/xmon.c      |   10 ---
 include/asm-powerpc/setjmp.h  |   12 +++
 6 files changed, 142 insertions(+), 147 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
@@ -518,6 +518,130 @@ _GLOBAL(giveup_altivec)
 
 #endif /* CONFIG_ALTIVEC */
 
+_GLOBAL(setjmp)
+	mflr	r0
+	PPC_STL	r0,0(r3)
+	PPC_STL	r1,SZL(r3)
+	PPC_STL	r2,2*SZL(r3)
+	mfcr	r0
+	PPC_STL	r0,3*SZL(r3)
+	PPC_STL	r13,4*SZL(r3)
+	PPC_STL	r14,5*SZL(r3)
+	PPC_STL	r15,6*SZL(r3)
+	PPC_STL	r16,7*SZL(r3)
+	PPC_STL	r17,8*SZL(r3)
+	PPC_STL	r18,9*SZL(r3)
+	PPC_STL	r19,10*SZL(r3)
+	PPC_STL	r20,11*SZL(r3)
+	PPC_STL	r21,12*SZL(r3)
+	PPC_STL	r22,13*SZL(r3)
+	PPC_STL	r23,14*SZL(r3)
+	PPC_STL	r24,15*SZL(r3)
+	PPC_STL	r25,16*SZL(r3)
+	PPC_STL	r26,17*SZL(r3)
+	PPC_STL	r27,18*SZL(r3)
+	PPC_STL	r28,19*SZL(r3)
+	PPC_STL	r29,20*SZL(r3)
+	PPC_STL	r30,21*SZL(r3)
+	PPC_STL	r31,22*SZL(r3)
+	li	r3,0
+	blr
+
+_GLOBAL(longjmp)
+	PPC_LCMPI r4,0
+	bne	1f
+	li	r4,1
+1:	PPC_LL	r13,4*SZL(r3)
+	PPC_LL	r14,5*SZL(r3)
+	PPC_LL	r15,6*SZL(r3)
+	PPC_LL	r16,7*SZL(r3)
+	PPC_LL	r17,8*SZL(r3)
+	PPC_LL	r18,9*SZL(r3)
+	PPC_LL	r19,10*SZL(r3)
+	PPC_LL	r20,11*SZL(r3)
+	PPC_LL	r21,12*SZL(r3)
+	PPC_LL	r22,13*SZL(r3)
+	PPC_LL	r23,14*SZL(r3)
+	PPC_LL	r24,15*SZL(r3)
+	PPC_LL	r25,16*SZL(r3)
+	PPC_LL	r26,17*SZL(r3)
+	PPC_LL	r27,18*SZL(r3)
+	PPC_LL	r28,19*SZL(r3)
+	PPC_LL	r29,20*SZL(r3)
+	PPC_LL	r30,21*SZL(r3)
+	PPC_LL	r31,22*SZL(r3)
+	PPC_LL	r0,3*SZL(r3)
+	mtcrf	0x38,r0
+	PPC_LL	r0,0(r3)
+	PPC_LL	r1,SZL(r3)
+	PPC_LL	r2,2*SZL(r3)
+	mtlr	r0
+	mr	r3,r4
+	blr
+
+#ifdef CONFIG_XMON
+/*
+ * Grab the register values as they are now.
+ * This won't do a particularily good job because we really
+ * want our caller's caller's registers, and our caller has
+ * already executed its prologue.
+ * ToDo: We could reach back into the caller's save area to do
+ * a better job of representing the caller's state (note that
+ * that will be different for 32-bit and 64-bit, because of the
+ * different ABIs, though).
+ */
+_GLOBAL(xmon_save_regs)
+	PPC_STL	r0,0*SZL(r3)
+	PPC_STL	r2,2*SZL(r3)
+	PPC_STL	r3,3*SZL(r3)
+	PPC_STL	r4,4*SZL(r3)
+	PPC_STL	r5,5*SZL(r3)
+	PPC_STL	r6,6*SZL(r3)
+	PPC_STL	r7,7*SZL(r3)
+	PPC_STL	r8,8*SZL(r3)
+	PPC_STL	r9,9*SZL(r3)
+	PPC_STL	r10,10*SZL(r3)
+	PPC_STL	r11,11*SZL(r3)
+	PPC_STL	r12,12*SZL(r3)
+	PPC_STL	r13,13*SZL(r3)
+	PPC_STL	r14,14*SZL(r3)
+	PPC_STL	r15,15*SZL(r3)
+	PPC_STL	r16,16*SZL(r3)
+	PPC_STL	r17,17*SZL(r3)
+	PPC_STL	r18,18*SZL(r3)
+	PPC_STL	r19,19*SZL(r3)
+	PPC_STL	r20,20*SZL(r3)
+	PPC_STL	r21,21*SZL(r3)
+	PPC_STL	r22,22*SZL(r3)
+	PPC_STL	r23,23*SZL(r3)
+	PPC_STL	r24,24*SZL(r3)
+	PPC_STL	r25,25*SZL(r3)
+	PPC_STL	r26,26*SZL(r3)
+	PPC_STL	r27,27*SZL(r3)
+	PPC_STL	r28,28*SZL(r3)
+	PPC_STL	r29,29*SZL(r3)
+	PPC_STL	r30,30*SZL(r3)
+	PPC_STL	r31,31*SZL(r3)
+	/* go up one stack frame for SP */
+	PPC_LL	r4,0(r1)
+	PPC_STL	r4,1*SZL(r3)
+	/* get caller's LR */
+	PPC_LL	r0,LRSAVE(r4)
+	PPC_STL	r0,_NIP-STACK_FRAME_OVERHEAD(r3)
+	PPC_STL	r0,_LINK-STACK_FRAME_OVERHEAD(r3)
+	mfmsr	r0
+	PPC_STL	r0,_MSR-STACK_FRAME_OVERHEAD(r3)
+	mfctr	r0
+	PPC_STL	r0,_CTR-STACK_FRAME_OVERHEAD(r3)
+	mfxer	r0
+	PPC_STL	r0,_XER-STACK_FRAME_OVERHEAD(r3)
+	mfcr	r0
+	PPC_STL	r0,_CCR-STACK_FRAME_OVERHEAD(r3)
+	li	r0,0
+	PPC_STL	r0,_TRAP-STACK_FRAME_OVERHEAD(r3)
+	blr
+#endif
+
 /* kexec_wait(phys_cpu)
  *
  * wait for the flag to change, indicating this kernel is going away but
Index: linux-2.6-ozlabs/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/fault.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/fault.c
@@ -167,10 +167,8 @@ int __kprobes do_page_fault(struct pt_re
 	if (notify_page_fault(regs))
 		return 0;
 
-	if (trap == 0x300) {
-		if (debugger_fault_handler(regs))
-			return 0;
-	}
+	if (unlikely(debugger_fault_handler(regs)))
+		return 0;
 
 	/* On a kernel SLB miss we can only check for a valid exception entry */
 	if (!user_mode(regs) && (address >= TASK_SIZE))
Index: linux-2.6-ozlabs/arch/powerpc/xmon/Makefile
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/xmon/Makefile
+++ linux-2.6-ozlabs/arch/powerpc/xmon/Makefile
@@ -4,7 +4,7 @@ ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
 
-obj-y			+= xmon.o setjmp.o start.o nonstdio.o
+obj-y			+= xmon.o start.o nonstdio.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
Index: linux-2.6-ozlabs/arch/powerpc/xmon/setjmp.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/xmon/setjmp.S
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- * Copyright (C) 1996 Paul Mackerras.
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- *
- * NOTE: assert(sizeof(buf) > 23 * sizeof(long))
- */
-#include <asm/processor.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-_GLOBAL(xmon_setjmp)
-	mflr	r0
-	PPC_STL	r0,0(r3)
-	PPC_STL	r1,SZL(r3)
-	PPC_STL	r2,2*SZL(r3)
-	mfcr	r0
-	PPC_STL	r0,3*SZL(r3)
-	PPC_STL	r13,4*SZL(r3)
-	PPC_STL	r14,5*SZL(r3)
-	PPC_STL	r15,6*SZL(r3)
-	PPC_STL	r16,7*SZL(r3)
-	PPC_STL	r17,8*SZL(r3)
-	PPC_STL	r18,9*SZL(r3)
-	PPC_STL	r19,10*SZL(r3)
-	PPC_STL	r20,11*SZL(r3)
-	PPC_STL	r21,12*SZL(r3)
-	PPC_STL	r22,13*SZL(r3)
-	PPC_STL	r23,14*SZL(r3)
-	PPC_STL	r24,15*SZL(r3)
-	PPC_STL	r25,16*SZL(r3)
-	PPC_STL	r26,17*SZL(r3)
-	PPC_STL	r27,18*SZL(r3)
-	PPC_STL	r28,19*SZL(r3)
-	PPC_STL	r29,20*SZL(r3)
-	PPC_STL	r30,21*SZL(r3)
-	PPC_STL	r31,22*SZL(r3)
-	li	r3,0
-	blr
-
-_GLOBAL(xmon_longjmp)
-	PPC_LCMPI r4,0
-	bne	1f
-	li	r4,1
-1:	PPC_LL	r13,4*SZL(r3)
-	PPC_LL	r14,5*SZL(r3)
-	PPC_LL	r15,6*SZL(r3)
-	PPC_LL	r16,7*SZL(r3)
-	PPC_LL	r17,8*SZL(r3)
-	PPC_LL	r18,9*SZL(r3)
-	PPC_LL	r19,10*SZL(r3)
-	PPC_LL	r20,11*SZL(r3)
-	PPC_LL	r21,12*SZL(r3)
-	PPC_LL	r22,13*SZL(r3)
-	PPC_LL	r23,14*SZL(r3)
-	PPC_LL	r24,15*SZL(r3)
-	PPC_LL	r25,16*SZL(r3)
-	PPC_LL	r26,17*SZL(r3)
-	PPC_LL	r27,18*SZL(r3)
-	PPC_LL	r28,19*SZL(r3)
-	PPC_LL	r29,20*SZL(r3)
-	PPC_LL	r30,21*SZL(r3)
-	PPC_LL	r31,22*SZL(r3)
-	PPC_LL	r0,3*SZL(r3)
-	mtcrf	0x38,r0
-	PPC_LL	r0,0(r3)
-	PPC_LL	r1,SZL(r3)
-	PPC_LL	r2,2*SZL(r3)
-	mtlr	r0
-	mr	r3,r4
-	blr
-
-/*
- * Grab the register values as they are now.
- * This won't do a particularily good job because we really
- * want our caller's caller's registers, and our caller has
- * already executed its prologue.
- * ToDo: We could reach back into the caller's save area to do
- * a better job of representing the caller's state (note that
- * that will be different for 32-bit and 64-bit, because of the
- * different ABIs, though).
- */
-_GLOBAL(xmon_save_regs)
-	PPC_STL	r0,0*SZL(r3)
-	PPC_STL	r2,2*SZL(r3)
-	PPC_STL	r3,3*SZL(r3)
-	PPC_STL	r4,4*SZL(r3)
-	PPC_STL	r5,5*SZL(r3)
-	PPC_STL	r6,6*SZL(r3)
-	PPC_STL	r7,7*SZL(r3)
-	PPC_STL	r8,8*SZL(r3)
-	PPC_STL	r9,9*SZL(r3)
-	PPC_STL	r10,10*SZL(r3)
-	PPC_STL	r11,11*SZL(r3)
-	PPC_STL	r12,12*SZL(r3)
-	PPC_STL	r13,13*SZL(r3)
-	PPC_STL	r14,14*SZL(r3)
-	PPC_STL	r15,15*SZL(r3)
-	PPC_STL	r16,16*SZL(r3)
-	PPC_STL	r17,17*SZL(r3)
-	PPC_STL	r18,18*SZL(r3)
-	PPC_STL	r19,19*SZL(r3)
-	PPC_STL	r20,20*SZL(r3)
-	PPC_STL	r21,21*SZL(r3)
-	PPC_STL	r22,22*SZL(r3)
-	PPC_STL	r23,23*SZL(r3)
-	PPC_STL	r24,24*SZL(r3)
-	PPC_STL	r25,25*SZL(r3)
-	PPC_STL	r26,26*SZL(r3)
-	PPC_STL	r27,27*SZL(r3)
-	PPC_STL	r28,28*SZL(r3)
-	PPC_STL	r29,29*SZL(r3)
-	PPC_STL	r30,30*SZL(r3)
-	PPC_STL	r31,31*SZL(r3)
-	/* go up one stack frame for SP */
-	PPC_LL	r4,0(r1)
-	PPC_STL	r4,1*SZL(r3)
-	/* get caller's LR */
-	PPC_LL	r0,LRSAVE(r4)
-	PPC_STL	r0,_NIP-STACK_FRAME_OVERHEAD(r3)
-	PPC_STL	r0,_LINK-STACK_FRAME_OVERHEAD(r3)
-	mfmsr	r0
-	PPC_STL	r0,_MSR-STACK_FRAME_OVERHEAD(r3)
-	mfctr	r0
-	PPC_STL	r0,_CTR-STACK_FRAME_OVERHEAD(r3)
-	mfxer	r0
-	PPC_STL	r0,_XER-STACK_FRAME_OVERHEAD(r3)
-	mfcr	r0
-	PPC_STL	r0,_CCR-STACK_FRAME_OVERHEAD(r3)
-	li	r0,0
-	PPC_STL	r0,_TRAP-STACK_FRAME_OVERHEAD(r3)
-	blr
Index: linux-2.6-ozlabs/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6-ozlabs/arch/powerpc/xmon/xmon.c
@@ -40,6 +40,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
+#include <asm/setjmp.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -71,12 +72,9 @@ static unsigned long ncsum = 4096;
 static int termch;
 static char tmpstr[128];
 
-#define JMP_BUF_LEN	23
-static long bus_error_jmp[JMP_BUF_LEN];
+static long bus_error_jmp[SETJMP_BUF_LEN];
 static int catch_memory_errors;
 static long *xmon_fault_jmp[NR_CPUS];
-#define setjmp xmon_setjmp
-#define longjmp xmon_longjmp
 
 /* Breakpoint stuff */
 struct bpt {
@@ -162,8 +160,6 @@ int xmon_no_auto_backtrace;
 extern void xmon_enter(void);
 extern void xmon_leave(void);
 
-extern long setjmp(long *);
-extern void longjmp(long *, long);
 extern void xmon_save_regs(struct pt_regs *);
 
 #ifdef CONFIG_PPC64
@@ -338,7 +334,7 @@ static int xmon_core(struct pt_regs *reg
 {
 	int cmd = 0;
 	struct bpt *bp;
-	long recurse_jmp[JMP_BUF_LEN];
+	long recurse_jmp[SETJMP_BUF_LEN];
 	unsigned long offset;
 	unsigned long flags;
 #ifdef CONFIG_SMP
Index: linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
===================================================================
--- /dev/null
+++ linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
@@ -0,0 +1,12 @@
+/*
+ * Copyright (C) 2007 Michael Neuling
+ */
+#ifndef _ASM_POWERPC_SETJMP_H
+#define _ASM_POWERPC_SETJMP_H
+
+#define SETJMP_BUF_LEN    23
+
+extern long setjmp(long *);
+extern void longjmp(long *, long);
+
+#endif /* _ASM_POWERPC_SETJMP_H */
