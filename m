Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F25AE100830
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:02 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696DRlS012028
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:13:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H2FD1659026
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H1bk011433
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/13] powerpc/book3e: Add generic 64-bit idle powersave
	support
Date: Fri,  9 Jul 2010 16:16:51 +1000
Message-Id: <1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use a similar technique to ppc32: We set a thread local flag
to indicate that we are about to enter or have entered the stop
state, and have fixup code in the async interrupt entry code that
reacts to this flag to make us return to a different location
(sets NIP to LINK in our case).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h   |    1 +
 arch/powerpc/kernel/Makefile         |    2 +-
 arch/powerpc/kernel/exceptions-64e.S |   23 ++++++++++
 arch/powerpc/kernel/idle_book3e.S    |   81 ++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_book3e.S

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2bad6e5..adc8e6c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -278,6 +278,7 @@ extern void e500_idle(void);
 extern void power4_idle(void);
 extern void power4_cpu_offline_powersave(void);
 extern void ppc6xx_idle(void);
+extern void book3e_idle(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8a33318..77d831a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
-obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index a42637c..316465a 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -204,11 +204,30 @@ exc_##n##_bad_stack:							    \
 	lis	r,TSR_FIS@h;						\
 	mtspr	SPRN_TSR,r
 
+/* Used by asynchronous interrupt that may happen in the idle loop.
+ *
+ * This check if the thread was in the idle loop, and if yes, returns
+ * to the caller rather than the PC. This is to avoid a race if
+ * interrupts happen before the wait instruction.
+ */
+#define CHECK_NAPPING()							\
+	clrrdi	r11,r1,THREAD_SHIFT;					\
+	ld	r10,TI_LOCAL_FLAGS(r11);				\
+	andi.	r9,r10,_TLF_NAPPING;					\
+	beq+	1f;							\
+	ld	r8,_LINK(r1);						\
+	rlwinm	r7,r10,0,~_TLF_NAPPING;					\
+	std	r8,_NIP(r1);						\
+	std	r7,TI_LOCAL_FLAGS(r11);					\
+1:
+
+
 #define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
 	START_EXCEPTION(label);						\
 	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
 	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE_ALL)		\
 	ack(r8);							\
+	CHECK_NAPPING();						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
 	bl	hdlr;							\
 	b	.ret_from_except_lite;
@@ -257,6 +276,7 @@ interrupt_end_book3e:
 	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE_ALL)
 //	bl	special_reg_save_crit
+//	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	bl	.critical_exception
 //	b	ret_from_crit_except
@@ -268,6 +288,7 @@ interrupt_end_book3e:
 //	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE_ALL)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	CHECK_NAPPING();
 //	bl	.machine_check_exception
 //	b	ret_from_mc_except
 	b	.
@@ -338,6 +359,7 @@ interrupt_end_book3e:
 	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE_ALL)
 //	bl	special_reg_save_crit
+//	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	bl	.unknown_exception
 //	b	ret_from_crit_except
@@ -434,6 +456,7 @@ kernel_dbg_exc:
 	CRIT_EXCEPTION_PROLOG(0x2080, PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x2080, PACA_EXCRIT, INTS_DISABLE_ALL)
 //	bl	special_reg_save_crit
+//	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	bl	.doorbell_critical_exception
 //	b	ret_from_crit_except
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
new file mode 100644
index 0000000..3150804
--- /dev/null
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -0,0 +1,81 @@
+/*
+ * Copyright 2010 IBM Corp, Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * Generic idle routine for Book3E processors
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/threads.h>
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ppc-opcode.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+
+/* 64-bit version only for now */
+#ifdef CONFIG_PPC64
+
+_GLOBAL(book3e_idle)
+	/* Save LR for later */
+	mflr	r0
+	std	r0,16(r1)
+
+	/* Hard disable interrupts */
+	wrteei	0
+
+	/* Now check if an interrupt came in while we were soft disabled
+	 * since we may otherwise lose it (doorbells etc...). We know
+	 * that since PACAHARDIRQEN will have been cleared in that case.
+	 */
+	lbz	r3,PACAHARDIRQEN(r13)
+	cmpwi	cr0,r3,0
+	beqlr
+
+	/* Now we are going to mark ourselves as soft and hard enables in
+	 * order to be able to take interrupts while asleep. We inform lockdep
+	 * of that. We don't actually turn interrupts on just yet tho.
+	 */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_on
+#endif
+	li	r0,1
+	stb	r0,PACASOFTIRQEN(r13)
+	stb	r0,PACAHARDIRQEN(r13)
+	
+	/* Interrupts will make use return to LR, so get something we want
+	 * in there
+	 */
+	bl	1f
+
+	/* We are back from the interrupt, the caller will local_irq_enable()
+	 * so to avoid stupid warning, let's turn them off here if irqtrace
+	 * is enabled.
+	 */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	li	r0,0
+	stb	r0,PACASOFTIRQEN(r13)
+	bl	.trace_hardirqs_off
+#endif
+	ld	r0,16(r1)
+	mtlr	r0
+	blr
+
+1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
+	 * to the right spot
+	*/
+	clrrdi	r11,r1,THREAD_SHIFT
+	ld	r10,TI_LOCAL_FLAGS(r11)
+	ori	r10,r10,_TLF_NAPPING
+	std	r10,TI_LOCAL_FLAGS(r11)
+
+	/* We can now re-enable hard interrupts and go to sleep */
+	wrteei	1
+1:	PPC_WAIT(0)
+	b	1b
+
+#endif /* CONFIG_PPC64 */
\ No newline at end of file
-- 
1.6.3.3
