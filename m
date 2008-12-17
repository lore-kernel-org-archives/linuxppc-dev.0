Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 022E7DDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:13:25 +1100 (EST)
Date: Wed, 17 Dec 2008 23:13:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/7] powerpc: Prepare xmon_save_regs for use with kdump
Message-ID: <20081217201323.GA4918@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
	<20081217200855.GA4624@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081217200855.GA4624@oksana.dev.rtsoft.ru>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Today the arch/powerpc/xmon/setjmp.S file contains only the
xmon_save_regs function. We want to use it for kdump purposes, so let's
move the file into arch/powerpc/kernel/ and give the function a more
generic name (ppc_save_regs).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

The same patch but suitable for patch(1), quilt users would
appreciate. ;-)

 arch/powerpc/include/asm/reg.h      |    4 ++
 arch/powerpc/kernel/Makefile        |    4 ++
 arch/powerpc/kernel/ppc_save_regs.S |   74 +++++++++++++++++++++++++++++++++++
 arch/powerpc/xmon/Makefile          |    2 +-
 arch/powerpc/xmon/setjmp.S          |   74 -----------------------------------
 arch/powerpc/xmon/xmon.c            |    5 +-
 6 files changed, 85 insertions(+), 78 deletions(-)
 create mode 100644 arch/powerpc/kernel/ppc_save_regs.S
 delete mode 100644 arch/powerpc/xmon/setjmp.S

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c6d1ab6..f484a34 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -783,6 +783,10 @@ extern void scom970_write(unsigned int address, unsigned long value);
 #define __get_SP()	({unsigned long sp; \
 			asm volatile("mr %0,1": "=r" (sp)); sp;})
 
+struct pt_regs;
+
+extern void ppc_save_regs(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_REG_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 92673b4..616c889 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -102,6 +102,10 @@ endif
 
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 
+ifneq ($(CONFIG_XMON),)
+obj-y				+= ppc_save_regs.o
+endif
+
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
 
diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
new file mode 100644
index 0000000..5113bd2
--- /dev/null
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 1996 Paul Mackerras.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ * NOTE: assert(sizeof(buf) > 23 * sizeof(long))
+ */
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
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
+_GLOBAL(ppc_save_regs)
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
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 51d9758..9cb03b7 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -4,7 +4,7 @@ ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
 
-obj-y			+= xmon.o setjmp.o start.o nonstdio.o
+obj-y			+= xmon.o start.o nonstdio.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
diff --git a/arch/powerpc/xmon/setjmp.S b/arch/powerpc/xmon/setjmp.S
deleted file mode 100644
index 04c0b30..0000000
--- a/arch/powerpc/xmon/setjmp.S
+++ /dev/null
@@ -1,74 +0,0 @@
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
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 076368c..8dfad7d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -41,6 +41,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
 #include <asm/setjmp.h>
+#include <asm/reg.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -159,8 +160,6 @@ static int xmon_no_auto_backtrace;
 extern void xmon_enter(void);
 extern void xmon_leave(void);
 
-extern void xmon_save_regs(struct pt_regs *);
-
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
 #define REGS_PER_LINE	4
@@ -532,7 +531,7 @@ int xmon(struct pt_regs *excp)
 	struct pt_regs regs;
 
 	if (excp == NULL) {
-		xmon_save_regs(&regs);
+		ppc_save_regs(&regs);
 		excp = &regs;
 	}
 
-- 
1.5.6.5
