Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DD04DDFEB
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 22:30:38 +1000 (EST)
Subject: [PATCH] powermac: suspend to disk on G5
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1178195106.13233.108.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 03 May 2007 14:31:38 +0200
Message-Id: <1178195498.13233.116.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powermac G5 suspend to disk implementation. The code is platform
agnostic but only tested on powermac, no other 64-bit powerpc
machines.

Because nvidiafb still breaks suspend I have marked it EXPERIMENTAL on
powermac and because I can't test it and some lowlevel code will need
changes it is BROKEN on all other 64-bit platforms.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
WARNING: nvidiafb breaks suspend. I don't know why yet, but if it is
compiled and you try to suspend from X it all just freezes. The nvidiafb
suspend code looks a bit fishy but I shall have to understand first what
it's trying to achieve.

Other than that I'm really happy with this, it's good to finally be able to
hibernate the machine instead of keeping it up or shutting it down.

Tested on my powermac with forced preemption enabled.

---
 arch/powerpc/Kconfig               |    5 
 arch/powerpc/kernel/Makefile       |    1 
 arch/powerpc/kernel/asm-offsets.c  |    4 
 arch/powerpc/kernel/idle.c         |    5 
 arch/powerpc/kernel/swsusp.c       |    9 +
 arch/powerpc/kernel/swsusp_64.c    |   24 +++
 arch/powerpc/kernel/swsusp_asm64.S |  228 +++++++++++++++++++++++++++++++++++++
 include/linux/suspend.h            |    2 
 kernel/power/Kconfig               |    4 
 9 files changed, 276 insertions(+), 6 deletions(-)

--- wireless-dev.orig/arch/powerpc/kernel/Makefile	2007-05-03 14:21:02.139165535 +0200
+++ wireless-dev/arch/powerpc/kernel/Makefile	2007-05-03 14:21:10.859165535 +0200
@@ -38,6 +38,7 @@ obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6x
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
+obj64-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_64.o swsusp_asm64.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
--- wireless-dev.orig/kernel/power/Kconfig	2007-05-03 14:20:25.629165535 +0200
+++ wireless-dev/kernel/power/Kconfig	2007-05-03 14:21:10.869165535 +0200
@@ -79,7 +79,7 @@ config PM_SYSFS_DEPRECATED
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
+	depends on PM && SWAP && (((X86 || PPC64_SWSUSP) && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
 	---help---
 	  Enable the suspend to disk (STD) functionality.
 
@@ -134,7 +134,7 @@ config PM_STD_PARTITION
 
 config SUSPEND_SMP
 	bool
-	depends on HOTPLUG_CPU && X86 && PM
+	depends on HOTPLUG_CPU && (X86 || PPC64) && PM
 	default y
 
 config APM_EMULATION
--- wireless-dev.orig/include/linux/suspend.h	2007-05-03 14:21:06.929165535 +0200
+++ wireless-dev/include/linux/suspend.h	2007-05-03 14:21:10.869165535 +0200
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/arch/powerpc/kernel/swsusp_64.c	2007-05-03 14:21:10.869165535 +0200
@@ -0,0 +1,24 @@
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
+void do_after_copyback(void)
+{
+	iommu_restore();
+	touch_softlockup_watchdog();
+	mb();
+}
+
+void _iommu_save(void)
+{
+	iommu_save();
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/arch/powerpc/kernel/swsusp_asm64.S	2007-05-03 14:21:10.869165535 +0200
@@ -0,0 +1,228 @@
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
+	bl _iommu_save
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
--- wireless-dev.orig/arch/powerpc/kernel/asm-offsets.c	2007-05-03 14:20:25.519165535 +0200
+++ wireless-dev/arch/powerpc/kernel/asm-offsets.c	2007-05-03 14:21:10.869165535 +0200
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
--- wireless-dev.orig/arch/powerpc/kernel/idle.c	2007-05-03 14:20:25.539165535 +0200
+++ wireless-dev/arch/powerpc/kernel/idle.c	2007-05-03 14:21:10.869165535 +0200
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
--- wireless-dev.orig/arch/powerpc/kernel/swsusp.c	2007-05-03 14:21:02.139165535 +0200
+++ wireless-dev/arch/powerpc/kernel/swsusp.c	2007-05-03 14:21:10.869165535 +0200
@@ -32,6 +32,11 @@ void save_processor_state(void)
 #ifdef CONFIG_SPE
 	enable_kernel_spe();
 #endif
+
+#ifdef CONFIG_PPC64
+	hard_irq_disable();
+#endif
+
 }
 
 void restore_processor_state(void)
@@ -39,4 +44,8 @@ void restore_processor_state(void)
 #ifdef CONFIG_PPC32
 	set_context(current->active_mm->context.id, current->active_mm->pgd);
 #endif
+
+#ifdef CONFIG_PPC64
+	hard_irq_enable();
+#endif
 }
--- wireless-dev.orig/arch/powerpc/Kconfig	2007-05-03 14:21:03.969165535 +0200
+++ wireless-dev/arch/powerpc/Kconfig	2007-05-03 14:21:10.869165535 +0200
@@ -126,6 +126,11 @@ config DEFAULT_UIMAGE
 	  Used to allow a board to specify it wants a uImage built by default
 	default n
 
+config PPC64_SWSUSP
+	bool
+	depends on PPC64 && (BROKEN || (PPC_PMAC64 && EXPERIMENTAL))
+	default y
+
 menu "Processor support"
 choice
 	prompt "Processor Type"
