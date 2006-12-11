Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B94367CC7
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:28:09 +1100 (EST)
Message-Id: <20061211230754.979775000@sipsolutions.net>>
References: <20061211230208.526233000@sipsolutions.net>>
Date: Tue, 12 Dec 2006 00:02:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 3/3] suspend to disk on powermac G5
Mime-Version: 1.0
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org,
	Michael Buesch <mb@bu3sch.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements a very hacky suspend to disk for powermac G5 machines. I
know it's broken in many places.

Built and tested against the tree after commit
620034c84d1d939717bdfbe02c51a3fee43541c3.

For some reason usb doesn't survive suspend even if I try to restore
interrupts now... I use this script:

>>>>>>
#!/bin/sh

set -e

echo reboot > /sys/power/disk

rmmod ohci_hcd
rmmod ehci_hcd || true
sync
echo disk > /sys/power/state || true
modprobe ohci_hcd
modprobe ehci_hcd
sleep 30 && reboot -f
<<<<<

and simply press ctrl-c within 30 seconds if my keyboard comes back up :)

Oh and did I say this is hacky? MMIO save/restore, the need to hook many
places, no proper MPIC suspend/resume functionality, snd-aoa doesn't work
after resume (it plays but no sound comes out, interrupts are coming in
though... go figure, eh wait, since I wrote it I guess I'll check it too).

I also ifdef'ed out

	set_context(current->active_mm->context.id, current->active_mm->pgd);

because I didn't know what it is doing and it works without :)

I've suspended and resumed a few times in a row with this now, with and
without longer breaks with the machine up and with the machine off.

Ah who am I kidding... This is pretty much guaranteed to break. Parts of the
assembly code are quite old (written like half a year ago) so I don't
remember some things... Why, for example, the save area has holes. I shall
fix these some time I guess.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6-git.orig/arch/powerpc/kernel/Makefile	2006-12-11 23:34:46.458716759 +0100
+++ linux-2.6-git/arch/powerpc/kernel/Makefile	2006-12-11 23:38:00.127716759 +0100
@@ -36,6 +36,7 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
+obj64-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_64.o swsusp_asm64.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
--- linux-2.6-git.orig/kernel/power/Kconfig	2006-12-11 23:34:46.682716759 +0100
+++ linux-2.6-git/kernel/power/Kconfig	2006-12-11 23:38:00.129716759 +0100
@@ -78,7 +78,7 @@ config PM_SYSFS_DEPRECATED
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP) && !X86_PAE) || ((FRV || PPC32) && !SMP))
+	depends on PM && SWAP && (((X86 || PPC64) && (!SMP || SUSPEND_SMP) && !X86_PAE) || ((FRV || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need ACPI or APM.
@@ -128,5 +128,5 @@ config PM_STD_PARTITION
 
 config SUSPEND_SMP
 	bool
-	depends on HOTPLUG_CPU && X86 && PM
+	depends on HOTPLUG_CPU && (X86 || PPC64) && PM
 	default y
--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2006-12-11 23:37:54.974716759 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2006-12-11 23:38:00.132716759 +0100
@@ -455,8 +455,10 @@ static int pmac_pm_finish(suspend_state_
 {
 	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
 
+#ifdef CONFIG_PPC32
 	/* Restore userland MMU context */
 	set_context(current->active_mm->context.id, current->active_mm->pgd);
+#endif
 
 	return 0;
 }
@@ -488,6 +490,7 @@ static int pmac_late_init(void)
 {
 	initializing = 0;
 #ifdef CONFIG_SOFTWARE_SUSPEND
+	iommu_init_late();
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
 	/* this is udbg (which is __init) and we can later use it during
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/include/asm/suspend.h	2006-12-11 23:38:00.135716759 +0100
@@ -0,0 +1,9 @@
+#ifndef __ASM_POWERPC_SUSPEND_H
+#define __ASM_POWERPC_SUSPEND_H
+
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+#endif /* __ASM_POWERPC_SUSPEND_H */
--- linux-2.6-git.orig/include/linux/suspend.h	2006-12-11 23:34:46.802716759 +0100
+++ linux-2.6-git/include/linux/suspend.h	2006-12-11 23:38:00.136716759 +0100
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/arch/powerpc/kernel/swsusp_64.c	2006-12-11 23:38:00.138716759 +0100
@@ -0,0 +1,54 @@
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
+static void irqs_resume(void)
+{
+	int irq;
+
+	for (irq = 1; irq < NR_IRQS; irq++) {
+		irq_desc_t *desc = get_irq_desc(irq);
+		if (!desc->action || !desc->action->handler)
+			continue;
+		/* umm, this must be borked... */
+		if (desc->chip && desc->chip->set_type)
+			desc->chip->set_type(irq, (desc->status & IRQ_LEVEL) ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_FALLING);
+		if (desc->chip->startup)
+			desc->chip->startup(irq);
+		else
+			desc->chip->enable(irq);
+	}
+}
+
+void do_after_copyback(void)
+{
+#ifdef CONFIG_U3_DART
+	iommu_dart_restore();
+#endif
+	irqs_resume();
+	touch_softlockup_watchdog();
+	mb();
+	hard_irq_enable();
+	/* all that happens after this is a return
+	 * to the location restore_image() came from
+	 */
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/arch/powerpc/kernel/swsusp_asm64.S	2006-12-11 23:38:00.142716759 +0100
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
--- linux-2.6-git.orig/arch/powerpc/sysdev/dart_iommu.c	2006-12-11 23:34:46.639716759 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/dart_iommu.c	2006-12-11 23:38:00.144716759 +0100
@@ -54,6 +54,9 @@ static unsigned long dart_tablesize;
 
 /* Virtual base address of the DART table */
 static u32 *dart_vbase;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static u32 *dart_copy;
+#endif
 
 /* Mapped base address for the dart */
 static unsigned int __iomem *dart;
@@ -346,6 +349,45 @@ void iommu_init_early_dart(void)
 	pci_dma_ops = &dma_direct_ops;
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+void iommu_init_late(void)
+{
+	unsigned long i;
+	struct page *p;
+
+	/* phew. suckers. this 16MB area is left unmapped
+	 * at another place but they don't bother to mark it so */
+	for (i = 0; i < (1<<24); i+= PAGE_SIZE)
+		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i)));
+
+	if (dart_tablebase == 0 || dart_tablesize == 0)
+		return;
+
+	p = alloc_pages(GFP_KERNEL, 9);
+	BUG_ON(!p);
+	dart_copy = page_address(p);
+}
+
+void iommu_dart_save(void)
+{
+	if (dart_tablebase == 0 || dart_tablesize == 0)
+		return;
+
+	memcpy(dart_copy, dart_vbase, 2*1024*1024);
+	printk(KERN_INFO "dart copied\n");
+}
+
+void iommu_dart_restore(void)
+{
+	if (dart_tablebase == 0 || dart_tablesize == 0)
+		return;
+
+	printk("going to restore dart\n");
+	memcpy(dart_vbase, dart_copy, 2*1024*1024);
+	printk("copied over dart entries\n");
+	dart_tlb_invalidate_all();
+}
+#endif
 
 void __init alloc_dart_table(void)
 {
--- linux-2.6-git.orig/include/asm-powerpc/iommu.h	2006-12-11 23:34:46.861716759 +0100
+++ linux-2.6-git/include/asm-powerpc/iommu.h	2006-12-11 23:38:00.146716759 +0100
@@ -108,6 +108,11 @@ static inline void pci_iommu_init(void) 
 #endif
 
 extern void alloc_dart_table(void);
+#if defined(CONFIG_SOFTWARE_SUSPEND) && defined(CONFIG_U3_DART)
+extern void iommu_init_late(void);
+extern void iommu_dart_save(void);
+extern void iommu_dart_restore(void);
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
--- linux-2.6-git.orig/arch/powerpc/kernel/asm-offsets.c	2006-12-11 23:34:46.529716759 +0100
+++ linux-2.6-git/arch/powerpc/kernel/asm-offsets.c	2006-12-11 23:38:00.148716759 +0100
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
--- linux-2.6-git.orig/arch/powerpc/kernel/idle.c	2006-12-11 23:34:46.561716759 +0100
+++ linux-2.6-git/arch/powerpc/kernel/idle.c	2006-12-11 23:38:00.149716759 +0100
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
--- linux-2.6-git.orig/kernel/power/snapshot.c	2006-12-11 23:34:46.718716759 +0100
+++ linux-2.6-git/kernel/power/snapshot.c	2006-12-11 23:38:00.152716759 +0100
@@ -707,6 +707,8 @@ static struct page *saveable_page(unsign
 		return NULL;
 	if (PageNosaveFree(page))
 		return NULL;
+	if (!page_is_ram(pfn))
+		return NULL;
 
 	return page;
 }

--
