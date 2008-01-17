Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 17 Jan 2008 15:45:42 +1100
Subject: [PATCH 1/2] Make setjmp/longjmp code generic
In-Reply-To: <1200545142.37022.89292279731.qpush@coopers>
Message-Id: <20080117044542.2F6CD70006@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, THEMANN@de.ibm.com
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

 arch/powerpc/kernel/misc.S   |   65 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/fault.c      |    6 +--
 arch/powerpc/xmon/setjmp.S   |   61 ----------------------------------------
 arch/powerpc/xmon/xmon.c     |    6 ---
 include/asm-powerpc/setjmp.h |   18 +++++++++++
 5 files changed, 86 insertions(+), 70 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
@@ -8,6 +8,8 @@
  * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
  * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
  *
+ * setjmp/longjmp and xmon_save_regs code by Paul Mackerras.
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -15,6 +17,8 @@
  */
 #include <asm/ppc_asm.h>
 #include <asm/unistd.h>
+#include <asm/asm-compat.h>
+#include <asm/asm-offsets.h>
 
 	.text
 
@@ -51,3 +55,64 @@ _GLOBAL(kernel_execve)
 	bnslr
 	neg	r3,r3
 	blr
+
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
Index: linux-2.6-ozlabs/arch/powerpc/xmon/setjmp.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/xmon/setjmp.S
+++ linux-2.6-ozlabs/arch/powerpc/xmon/setjmp.S
@@ -12,67 +12,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 
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
 /*
  * Grab the register values as they are now.
  * This won't do a particularily good job because we really
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
 static long bus_error_jmp[JMP_BUF_LEN];
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
Index: linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
===================================================================
--- /dev/null
+++ linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2007 Michael Neuling
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ */
+#ifndef _ASM_POWERPC_SETJMP_H
+#define _ASM_POWERPC_SETJMP_H
+
+#define JMP_BUF_LEN    23
+
+extern long setjmp(long *);
+extern void longjmp(long *, long);
+
+#endif /* _ASM_POWERPC_SETJMP_H */
