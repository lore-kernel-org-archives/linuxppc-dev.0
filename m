Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94120DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:10:35 +1100 (EST)
Message-Id: <20070205185838.407013000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 09/10] powermac: suspend to disk on G5
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Next revision of my powermac G5 suspend to disk implementation. This part
didn't really change much except for fixes and cleanups.

I still have

	set_context(current->active_mm->context.id, current->active_mm->pgd);

ifdef'ed out because I didn't know what it is doing and it works without :)
Can somebody explain what this is about and what the 64-bit equivalent would
be?

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- mb-wireless.orig/arch/powerpc/kernel/Makefile	2007-02-05 14:24:04.414526864 +0100
+++ mb-wireless/arch/powerpc/kernel/Makefile	2007-02-05 14:24:40.674526864 +0100
@@ -36,6 +36,7 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
+obj64-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_64.o swsusp_asm64.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
--- mb-wireless.orig/kernel/power/Kconfig	2007-02-05 14:24:04.864526864 +0100
+++ mb-wireless/kernel/power/Kconfig	2007-02-05 14:24:40.674526864 +0100
@@ -79,7 +79,7 @@ config PM_SYSFS_DEPRECATED
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
+	depends on PM && SWAP && (((X86 || PPC64) && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need ACPI or APM.
@@ -129,5 +129,5 @@ config PM_STD_PARTITION
 
 config SUSPEND_SMP
 	bool
-	depends on HOTPLUG_CPU && X86 && PM
+	depends on HOTPLUG_CPU && (X86 || PPC64) && PM
 	default y
--- mb-wireless.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-05 14:24:40.054526864 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/setup.c	2007-02-05 14:24:40.674526864 +0100
@@ -455,8 +455,10 @@ static int pmac_pm_finish(suspend_state_
 {
 	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
 
+#ifdef CONFIG_PPC32
 	/* Restore userland MMU context */
 	set_context(current->active_mm->context.id, current->active_mm->pgd);
+#endif
 
 	return 0;
 }
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/include/asm-powerpc/suspend.h	2007-02-05 14:24:40.684526864 +0100
@@ -0,0 +1,17 @@
+#ifndef __ASM_POWERPC_SUSPEND_H
+#define __ASM_POWERPC_SUSPEND_H
+
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PPC32
+static inline void save_processor_state(void) {}
+static inline void restore_processor_state(void) {}
+#else
+void save_processor_state(void);
+void restore_processor_state(void);
+#endif
+
+#endif /* __ASM_POWERPC_SUSPEND_H */
--- mb-wireless.orig/include/linux/suspend.h	2007-02-05 14:24:05.094526864 +0100
+++ mb-wireless/include/linux/suspend.h	2007-02-05 14:24:40.684526864 +0100
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/kernel/swsusp_64.c	2007-02-05 14:24:40.684526864 +0100
@@ -0,0 +1,32 @@
+/*
+ * PowerPC 64-bit swsusp implementation
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <asm/system.h>
+#include <asm/iommu.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+void save_processor_state(void)
+{
+	hard_irq_disable();
+}
+
+void restore_processor_state(void)
+{
+	hard_irq_enable();
+}
+
+void do_after_copyback(void)
+{
+#ifdef CONFIG_U3_DART
+	iommu_dart_restore();
+#endif
+	touch_softlockup_watchdog();
+	mb();
+	hard_irq_enable();
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/kernel/swsusp_asm64.S	2007-02-05 14:24:40.684526864 +0100
@@ -0,0 +1,231 @@
+/*
+ * PowerPC 64-bit swsusp implementation
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+/*
+ * Structure for storing CPU registers on the save area.
+ */
+#define SL_r1		0x00	/* stack pointer */
+#define SL_PC		0x08
+#define SL_MSR		0x10
+#define SL_SDR1		0x18
+#define SL_XER		0x20
+#define SL_TB		0x40
+#define SL_r2		0x48
+#define SL_CR		0x50
+#define SL_LR		0x58
+#define SL_r12		0x60
+#define SL_r13		0x68
+#define SL_r14		0x70
+#define SL_r15		0x78
+#define SL_r16		0x80
+#define SL_r17		0x88
+#define SL_r18		0x90
+#define SL_r19		0x98
+#define SL_r20		0xa0
+#define SL_r21		0xa8
+#define SL_r22		0xb0
+#define SL_r23		0xb8
+#define SL_r24		0xc0
+#define SL_r25		0xc8
+#define SL_r26		0xd0
+#define SL_r27		0xd8
+#define SL_r28		0xe0
+#define SL_r29		0xe8
+#define SL_r30		0xf0
+#define SL_r31		0xf8
+#define SL_SIZE		SL_r31+8
+
+/* these macros rely on the save area being
+ * pointed to by r11 */
+#define SAVE_SPECIAL(special)		\
+	mf##special	r0		;\
+	std	r0, SL_##special(r11)
+#define RESTORE_SPECIAL(special)	\
+	ld	r0, SL_##special(r11)	;\
+	mt##special	r0
+#define SAVE_REGISTER(reg)		\
+	std	reg, SL_##reg(r11)
+#define RESTORE_REGISTER(reg)		\
+	ld	reg, SL_##reg(r11)
+
+/* space for storing cpu state */
+	.section .data
+	.align  5
+swsusp_save_area:
+	.space SL_SIZE
+
+	.section ".toc","aw"
+swsusp_save_area_ptr:
+	.tc	swsusp_save_area[TC],swsusp_save_area
+restore_pblist_ptr:
+	.tc	restore_pblist[TC],restore_pblist
+
+	.section .text
+	.align  5
+_GLOBAL(swsusp_arch_suspend)
+	ld	r11,swsusp_save_area_ptr@toc(r2)
+	SAVE_SPECIAL(LR)
+	SAVE_REGISTER(r1)
+	SAVE_SPECIAL(CR)
+	SAVE_SPECIAL(TB)
+	SAVE_REGISTER(r2)
+	SAVE_REGISTER(r12)
+	SAVE_REGISTER(r13)
+	SAVE_REGISTER(r14)
+	SAVE_REGISTER(r15)
+	SAVE_REGISTER(r16)
+	SAVE_REGISTER(r17)
+	SAVE_REGISTER(r18)
+	SAVE_REGISTER(r19)
+	SAVE_REGISTER(r20)
+	SAVE_REGISTER(r21)
+	SAVE_REGISTER(r22)
+	SAVE_REGISTER(r23)
+	SAVE_REGISTER(r24)
+	SAVE_REGISTER(r25)
+	SAVE_REGISTER(r26)
+	SAVE_REGISTER(r27)
+	SAVE_REGISTER(r28)
+	SAVE_REGISTER(r29)
+	SAVE_REGISTER(r30)
+	SAVE_REGISTER(r31)
+	SAVE_SPECIAL(MSR)
+	SAVE_SPECIAL(SDR1)
+	SAVE_SPECIAL(XER)
+
+	/* we push the stack up 128 bytes but don't store the
+	 * stack pointer on the stack like a real stackframe */
+	addi	r1,r1,-128
+
+#ifdef	CONFIG_U3_DART
+	bl iommu_dart_save
+#endif
+
+	bl swsusp_save
+
+	/* restore LR */
+	ld	r11,swsusp_save_area_ptr@toc(r2)
+	RESTORE_SPECIAL(LR)
+	addi	r1,r1,128
+
+	blr
+
+/* Resume code */
+_GLOBAL(swsusp_arch_resume)
+	/* Stop pending alitvec streams and memory accesses */
+BEGIN_FTR_SECTION
+	DSSALL
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	sync
+
+	ld	r12,restore_pblist_ptr@toc(r2)
+	ld	r12,0(r12)
+
+	cmpdi	r12,0
+	beq-	nothing_to_copy
+	li	r15,512
+copyloop:
+	ld	r13,pbe_address(r12)
+	ld	r14,pbe_orig_address(r12)
+
+	mtctr	r15
+	li	r10,0
+copy_page_loop:
+	ldx	r0,r10,r13
+	stdx	r0,r10,r14
+	addi	r10,r10,8
+	bdnz copy_page_loop
+
+	ld	r12,pbe_next(r12)
+	cmpdi	r12,0
+	bne+	copyloop
+nothing_to_copy:
+
+	/* flush caches */
+	lis	r3, 0x10
+	mtctr	r3
+	li	r3, 0
+	ori	r3, r3, CONFIG_KERNEL_START>>48
+	li	r0, 48
+	sld	r3, r3, r0
+	li	r0, 0
+1:
+	dcbf	r0,r3
+	addi	r3,r3,0x20
+	bdnz	1b
+
+	sync
+
+	tlbia
+
+	ld	r11,swsusp_save_area_ptr@toc(r2)
+
+	RESTORE_SPECIAL(CR)
+
+	/* restore timebase */
+	/* load saved tb */
+	ld	r1, SL_TB(r11)
+	/* get upper 32 bits of it */
+	srdi	r2, r1, 32
+	/* clear tb lower to avoid wrap */
+	li	r0, 0
+	mttbl	r0
+	/* set tb upper */
+	mttbu	r2
+	/* set tb lower */
+	mttbl	r1
+
+	/* restore registers */
+	RESTORE_REGISTER(r1)
+	RESTORE_REGISTER(r2)
+	RESTORE_REGISTER(r12)
+	RESTORE_REGISTER(r13)
+	RESTORE_REGISTER(r14)
+	RESTORE_REGISTER(r15)
+	RESTORE_REGISTER(r16)
+	RESTORE_REGISTER(r17)
+	RESTORE_REGISTER(r18)
+	RESTORE_REGISTER(r19)
+	RESTORE_REGISTER(r20)
+	RESTORE_REGISTER(r21)
+	RESTORE_REGISTER(r22)
+	RESTORE_REGISTER(r23)
+	RESTORE_REGISTER(r24)
+	RESTORE_REGISTER(r25)
+	RESTORE_REGISTER(r26)
+	RESTORE_REGISTER(r27)
+	RESTORE_REGISTER(r28)
+	RESTORE_REGISTER(r29)
+	RESTORE_REGISTER(r30)
+	RESTORE_REGISTER(r31)
+	/* can't use RESTORE_SPECIAL(MSR) */
+	ld	r0, SL_MSR(r11)
+	mtmsrd	r0, 0
+	RESTORE_SPECIAL(SDR1)
+	RESTORE_SPECIAL(XER)
+
+	sync
+
+	addi	r1,r1,-128
+	bl	slb_flush_and_rebolt
+	bl	do_after_copyback
+	addi	r1,r1,128
+
+	ld	r11,swsusp_save_area_ptr@toc(r2)
+	RESTORE_SPECIAL(LR)
+
+	li	r3, 0
+	blr
--- mb-wireless.orig/arch/powerpc/kernel/asm-offsets.c	2007-02-05 14:24:04.574526864 +0100
+++ mb-wireless/arch/powerpc/kernel/asm-offsets.c	2007-02-05 14:24:40.684526864 +0100
@@ -21,12 +21,12 @@
 #include <linux/types.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/suspend.h>
 #ifdef CONFIG_PPC64
 #include <linux/time.h>
 #include <linux/hardirq.h>
 #else
 #include <linux/ptrace.h>
-#include <linux/suspend.h>
 #endif
 
 #include <asm/io.h>
@@ -257,11 +257,11 @@ int main(void)
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 	DEFINE(CPU_SPEC_RESTORE, offsetof(struct cpu_spec, cpu_restore));
 
-#ifndef CONFIG_PPC64
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
 	DEFINE(pbe_next, offsetof(struct pbe, next));
 
+#ifndef CONFIG_PPC64
 	DEFINE(TASK_SIZE, TASK_SIZE);
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 #endif /* ! CONFIG_PPC64 */
--- mb-wireless.orig/arch/powerpc/kernel/idle.c	2007-02-05 14:24:04.684526864 +0100
+++ mb-wireless/arch/powerpc/kernel/idle.c	2007-02-05 14:24:40.684526864 +0100
@@ -33,8 +33,11 @@
 #include <asm/smp.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
+/* this is used for software suspend, and that shuts down
+ * CPUs even while the system is still booting... */
 #define cpu_should_die()	(cpu_is_offline(smp_processor_id()) && \
-				 system_state == SYSTEM_RUNNING)
+				   (system_state == SYSTEM_RUNNING     \
+				 || system_state == SYSTEM_BOOTING))
 #else
 #define cpu_should_die()	0
 #endif

--
