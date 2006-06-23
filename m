Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1115867B36
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 00:14:05 +1000 (EST)
Subject: release early... powermac g5 suspend to disk
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 12:16:50 +0200
Message-Id: <1151057810.7608.25.camel@localhost>
Mime-Version: 1.0
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wow. 2 days and a mostly destroyed XFS filesystem (it's still running
but I better not touch some directories or it goes belly up, xfs_repair
craps out too) I actually suspended my quad powermac a few times.

Half of the time I'll be told by the softlockup watchdog that it locked
up, but sometimes it actually works, that is, it suspends and resumes.

Issues: I don't save MPIC state. Hence, anything that is compiled in as
modules will no longer get IRQs after resume. Like USB on my system. So
I only ohci_hcd and ehci_hcd before suspend, reload later (from a
script) and I can still use the keyboard after ;)

Same goes for tg3 even though it is built-in. Well, I held off looking
at the MPIC because Ben said he was rewriting the whole interrupt stuff
anyway.

Other issues: yeah, this is extremely ugly. If you like your machine,
don't take a look.

There must be dozens of bad and undocumented assumptions too. Like
running with the same hashtables while copying back as before, etc. Not
restoring the MSR because, well, it crashes then ;) Very strange code to
flush caches, not sure it's even correct. Etc. etc. Oh and yes, I really
am that clueless and don't see the bigger issues ;)

Oh and as you can see in the first hunk here, I had to modify the
generic code too...

--- linux-2.6-git.orig/kernel/power/snapshot.c	2006-06-23 11:37:23.433885225 +0200
+++ linux-2.6-git/kernel/power/snapshot.c	2006-06-23 11:39:03.352985945 +0200
@@ -177,7 +177,13 @@
 		return 0;
 
 	page = pfn_to_page(pfn);
+/*
+    I currently mark the physical memory that we reserve
+    and _don't_ map for kernel access as Nosave so we won't
+    try to save it... Not sure what to do.
+
 	BUG_ON(PageReserved(page) && PageNosave(page));
+*/
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn))
@@ -185,7 +191,8 @@
 	if (PageNosaveFree(page))
 		return 0;
 
-	return 1;
+	/* we have a memory hole for PCI accesses! */
+	return page_is_ram(pfn);
 }
 
 unsigned int count_data_pages(void)
--- linux-2.6-git.orig/arch/powerpc/kernel/Makefile	2006-06-23 11:37:23.108888150 +0200
+++ linux-2.6-git/arch/powerpc/kernel/Makefile	2006-06-23 11:39:03.333986116 +0200
@@ -37,6 +37,7 @@
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
+obj64-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_64.o swsusp_asm64.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 obj-$(CONFIG_E500)		+= perfmon_fsl_booke.o
 
--- linux-2.6-git.orig/kernel/power/Kconfig	2006-06-23 11:37:23.391885603 +0200
+++ linux-2.6-git/kernel/power/Kconfig	2006-06-23 11:39:03.335986098 +0200
@@ -38,7 +38,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
+	depends on PM && SWAP && ((X86 || PPC64) && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need ACPI or APM.
@@ -96,5 +96,5 @@
 
 config SUSPEND_SMP
 	bool
-	depends on HOTPLUG_CPU && X86 && PM
+	depends on HOTPLUG_CPU && (X86 || PPC64) && PM
 	default y
--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2006-06-23 11:38:31.484272766 +0200
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2006-06-23 11:39:16.652866245 +0200
@@ -457,8 +457,10 @@
 {
 	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
 
+#ifdef CONFIG_PPC32
 	/* Restore userland MMU context */
 	set_context(current->active_mm->context, current->active_mm->pgd);
+#endif
 
 	return 0;
 }
@@ -490,6 +492,7 @@
 {
 	initializing = 0;
 #ifdef CONFIG_SOFTWARE_SUSPEND
+	iommu_init_late();
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
 	/* this is udbg (which is __init) and we can later use it during
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/include/asm/suspend.h	2006-06-23 11:39:03.341986044 +0200
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
Index: linux-2.6-git/include/linux/suspend.h
===================================================================
--- linux-2.6-git.orig/include/linux/suspend.h	2006-06-23 11:37:23.502884604 +0200
+++ linux-2.6-git/include/linux/suspend.h	2006-06-23 11:39:03.343986026 +0200
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/arch/powerpc/kernel/swsusp_64.c	2006-06-23 11:39:03.345986008 +0200
@@ -0,0 +1,37 @@
+/*
+ * PowerPC 64-bit swsusp implementation
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <asm/system.h>
+
+void save_processor_state(void)
+{
+}
+
+void restore_processor_state(void)
+{
+}
+
+static int set_up_temporary_mappings(void)
+{
+	/* uh oh. we should do something here! */
+	return 0;
+}
+
+/* in swsusp_asm64.S */
+extern int restore_image(void);
+
+int swsusp_arch_resume(void)
+{
+	int err;
+
+	err = set_up_temporary_mappings();
+	if (err)
+		return err;
+	/* well, in reality, restore_image() won't return (to here) */
+	return restore_image();
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/arch/powerpc/kernel/swsusp_asm64.S	2006-06-23 11:39:03.348985981 +0200
@@ -0,0 +1,218 @@
+/*
+ * PowerPC 64-bit swsusp implementation
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <linux/config.h>
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
+#define SL_r2		0x48	/* 'current' (I think) */
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
+pagedir_nosave_ptr:
+	.tc	pagedir_nosave[TC],pagedir_nosave
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
+	bl dart_save
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
+_GLOBAL(restore_image)
+	/* Stop pending alitvec streams and memory accesses */
+BEGIN_FTR_SECTION
+	DSSALL
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	sync
+
+	ld	r12,pagedir_nosave_ptr@toc(r2)
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
+#if 1
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
+#endif
+	sync
+
+	tlbia
+
+	ld	r11,swsusp_save_area_ptr@toc(r2)
+
+	RESTORE_SPECIAL(CR)
+	ld	r0, SL_TB(r11)
+	mttbl	r0
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
+//	ld	r0, SL_MSR(r11)
+//	mtmsrd	r0,0
+	RESTORE_SPECIAL(SDR1)
+	RESTORE_SPECIAL(XER)
+
+	addi	r1,r1,-128
+	bl	dart_restore
+	bl	touch_softlockup_watchdog
+	addi	r1,r1,128
+
+	ld	r11,swsusp_save_area_ptr@toc(r2)
+	RESTORE_SPECIAL(LR)
+
+	li	r3, 0
+	blr
--- linux-2.6-git.orig/arch/powerpc/sysdev/dart_iommu.c	2006-06-23 11:37:23.357885909 +0200
+++ linux-2.6-git/arch/powerpc/sysdev/dart_iommu.c	2006-06-23 11:39:03.350985963 +0200
@@ -58,6 +58,9 @@
 
 /* Virtual base address of the DART table */
 static u32 *dart_vbase;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static u32 *dart_copy;
+#endif
 
 /* Mapped base address for the dart */
 static unsigned int __iomem *dart;
@@ -368,6 +371,45 @@
 	pci_direct_iommu_init();
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
+void dart_save(void)
+{
+	if (dart_tablebase == 0 || dart_tablesize == 0)
+		return;
+
+	memcpy(dart_copy, dart_vbase, 2*1024*1024);
+	printk(KERN_INFO "dart copied\n");
+}
+
+void dart_restore(void)
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
--- linux-2.6-git.orig/include/asm-powerpc/iommu.h	2006-06-23 11:37:23.548884190 +0200
+++ linux-2.6-git/include/asm-powerpc/iommu.h	2006-06-23 11:39:03.354985927 +0200
@@ -97,6 +97,9 @@
 #endif
 
 extern void alloc_dart_table(void);
+#ifdef CONFIG_SOFTWARE_SUSPEND
+extern void iommu_init_late(void);
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
--- linux-2.6-git.orig/arch/powerpc/kernel/asm-offsets.c	2006-06-23 11:37:23.197887349 +0200
+++ linux-2.6-git/arch/powerpc/kernel/asm-offsets.c	2006-06-23 11:39:03.356985909 +0200
@@ -22,12 +22,12 @@
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
@@ -243,11 +243,11 @@
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
-#ifndef CONFIG_PPC64
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
 	DEFINE(pbe_next, offsetof(struct pbe, next));
 
+#ifndef CONFIG_PPC64
 	DEFINE(TASK_SIZE, TASK_SIZE);
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 #endif /* ! CONFIG_PPC64 */
--- linux-2.6-git.orig/arch/powerpc/kernel/idle.c	2006-06-23 11:37:23.234887016 +0200
+++ linux-2.6-git/arch/powerpc/kernel/idle.c	2006-06-23 11:39:03.357985900 +0200
@@ -34,8 +34,11 @@
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
