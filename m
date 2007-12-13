Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 13 Dec 2007 14:16:18 +1100
Subject: [PATCH 1/2] Make setjmp/longjmp code generic
In-Reply-To: <1197515777.834799.307108384755.qpush@coopers>
Message-Id: <20071213031618.A7CC2702F6@localhost.localdomain>
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
be only called on 0x300 (data storage) exception and adds some
documentation.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/misc.S   |  128 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/fault.c      |    6 -
 arch/powerpc/xmon/Makefile   |    2 
 arch/powerpc/xmon/setjmp.S   |  135 -------------------------------------------
 arch/powerpc/xmon/xmon.c     |   38 ++++--------
 include/asm-powerpc/setjmp.h |   19 ++++++
 6 files changed, 164 insertions(+), 164 deletions(-)

Index: clone3/arch/powerpc/kernel/misc.S
===================================================================
--- clone3.orig/arch/powerpc/kernel/misc.S
+++ clone3/arch/powerpc/kernel/misc.S
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
 
@@ -51,3 +55,127 @@ _GLOBAL(kernel_execve)
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
Index: clone3/arch/powerpc/mm/fault.c
===================================================================
--- clone3.orig/arch/powerpc/mm/fault.c
+++ clone3/arch/powerpc/mm/fault.c
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
Index: clone3/arch/powerpc/xmon/Makefile
===================================================================
--- clone3.orig/arch/powerpc/xmon/Makefile
+++ clone3/arch/powerpc/xmon/Makefile
@@ -4,7 +4,7 @@ ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
 
-obj-y			+= xmon.o setjmp.o start.o nonstdio.o
+obj-y			+= xmon.o start.o nonstdio.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
Index: clone3/arch/powerpc/xmon/setjmp.S
===================================================================
--- clone3.orig/arch/powerpc/xmon/setjmp.S
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
Index: clone3/arch/powerpc/xmon/xmon.c
===================================================================
--- clone3.orig/arch/powerpc/xmon/xmon.c
+++ clone3/arch/powerpc/xmon/xmon.c
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
@@ -1428,7 +1424,7 @@ void prregs(struct pt_regs *fp)
 			sync();
 			regs = *(struct pt_regs *)base;
 			sync();
-			__delay(200);
+			__delay(SETJMP_MACHINE_CHECK_DELAY);
 		} else {
 			catch_memory_errors = 0;
 			printf("*** Error reading registers from "REG"\n",
@@ -1497,8 +1493,7 @@ void cacheflush(void)
 				cinval((void *) adrs);
 		}
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 	}
 	catch_memory_errors = 0;
 }
@@ -1533,8 +1528,7 @@ read_spr(int n)
 		ret = code();
 
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 		n = size;
 	}
 
@@ -1569,8 +1563,7 @@ write_spr(int n, unsigned long val)
 		code(val);
 
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 		n = size;
 	}
 }
@@ -1676,8 +1669,7 @@ mread(unsigned long adrs, void *buf, int
 			}
 		}
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 		n = size;
 	}
 	catch_memory_errors = 0;
@@ -1713,8 +1705,7 @@ mwrite(unsigned long adrs, void *buf, in
 			}
 		}
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 		n = size;
 	} else {
 		printf("*** Error writing address %x\n", adrs + n);
@@ -2521,8 +2512,7 @@ static void xmon_print_symbol(unsigned l
 		name = kallsyms_lookup(address, &size, &offset, &modname,
 				       tmpstr);
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 	}
 
 	catch_memory_errors = 0;
@@ -2777,7 +2767,7 @@ static void stop_spus(void)
 			spu_mfc_sr1_set(spu, tmp);
 
 			sync();
-			__delay(200);
+			__delay(SETJMP_MACHINE_CHECK_DELAY);
 
 			spu_info[i].stopped_ok = 1;
 
@@ -2817,7 +2807,7 @@ static void restart_spus(void)
 					spu_info[i].saved_spu_runcntl_RW);
 
 			sync();
-			__delay(200);
+			__delay(SETJMP_MACHINE_CHECK_DELAY);
 
 			printf("Restarted spu %.2d\n", i);
 		} else {
@@ -2837,7 +2827,7 @@ do {									\
 		printf("  %-*s = "format"\n", DUMP_WIDTH,		\
 				#field, value);				\
 		sync();							\
-		__delay(200);						\
+		__delay(SETJMP_MACHINE_CHECK_DELAY);			\
 	} else {							\
 		catch_memory_errors = 0;				\
 		printf("  %-*s = *** Error reading field.\n",		\
@@ -2899,7 +2889,7 @@ static void dump_spu_ls(unsigned long nu
 		sync();
 		ls_addr = (unsigned long)spu_info[num].spu->local_store;
 		sync();
-		__delay(200);
+		__delay(SETJMP_MACHINE_CHECK_DELAY);
 	} else {
 		catch_memory_errors = 0;
 		printf("*** Error: accessing spu info for spu %d\n", num);
Index: clone3/include/asm-powerpc/setjmp.h
===================================================================
--- /dev/null
+++ clone3/include/asm-powerpc/setjmp.h
@@ -0,0 +1,19 @@
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
+#define SETJMP_BUF_LEN    23
+#define SETJMP_MACHINE_CHECK_DELAY    200
+
+extern long setjmp(long *);
+extern void longjmp(long *, long);
+
+#endif /* _ASM_POWERPC_SETJMP_H */
