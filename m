Date: Mon, 12 Jul 2004 08:59:52 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: pmdisk infrastructure
Message-ID: <20040712065951.GB9536@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
the attached patch adds the infrastructure needed for pmdisk on ppc.
Most of it was done by Benjamin with some modifications by me. These are
the parts that don't affect anything else. The full patch is here:
 http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/pmdisk-2.6.7.diff
Patch is against 2.6.7 but applies without problems against 2.6.7-bk20.
Please apply,
 -- Guido

singed-off-by: Guido Guenther <agx@sigxcpu.org>

diff -ub -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/Makefile linux-2.6.7-rc2/arch/ppc/kernel/Makefile
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/Makefile	2004-05-30 11:39:26.000000000 -0300
+++ linux-2.6.7-rc2/arch/ppc/kernel/Makefile	2004-05-30 11:43:50.000000000 -0300
@@ -22,6 +22,7 @@
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_PM_DISK)		+= pmdisk.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
diff -ub -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/pmdisk.S linux-2.6.7-rc2/arch/ppc/kernel/pmdisk.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/pmdisk.S	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6.7-rc2/arch/ppc/kernel/pmdisk.S	2004-05-30 11:43:50.000000000 -0300
@@ -0,0 +1,358 @@
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+
+
+/*
+ * Structure for storing CPU registers on the save area.
+ */
+#define SL_SP		0
+#define SL_PC		4
+#define SL_MSR		8
+#define SL_SDR1		0xc
+#define SL_SPRG0	0x10	/* 4 sprg's */
+#define SL_DBAT0	0x20
+#define SL_IBAT0	0x28
+#define SL_DBAT1	0x30
+#define SL_IBAT1	0x38
+#define SL_DBAT2	0x40
+#define SL_IBAT2	0x48
+#define SL_DBAT3	0x50
+#define SL_IBAT3	0x58
+#define SL_TB		0x60
+#define SL_R2		0x68
+#define SL_CR		0x6c
+#define SL_LR		0x70
+#define SL_R12		0x74	/* r12 to r31 */
+#define SL_SIZE		(SL_R12 + 80)
+
+	.section .data
+	.align	5
+
+_GLOBAL(pmdisk_save_area)
+	.space	SL_SIZE
+
+
+	.section .text
+	.align	5
+
+_GLOBAL(pmdisk_arch_suspend)
+	cmpi	0,r3,0
+	bne	do_resume
+
+	lis	r11,pmdisk_save_area@h
+	ori	r11,r11,pmdisk_save_area@l
+
+	mflr	r0
+	stw	r0,SL_LR(r11)
+	mfcr	r0
+	stw	r0,SL_CR(r11)
+	stw	r1,SL_SP(r11)
+	stw	r2,SL_R2(r11)
+	stmw	r12,SL_R12(r11)
+
+	/* Save MSR & SDR1 */
+	mfmsr	r4
+	stw	r4,SL_MSR(r11)
+	mfsdr1	r4
+	stw	r4,SL_SDR1(r11)
+
+	/* Get a stable timebase and save it */
+1:	mftbu	r4
+	stw	r4,SL_TB(r11)
+	mftb	r5
+	stw	r5,SL_TB+4(r11)
+	mftbu	r3
+	cmpw	r3,r4
+	bne	1b
+
+	/* Save SPRGs */
+	mfsprg	r4,0
+	stw	r4,SL_SPRG0(r11)
+	mfsprg	r4,1
+	stw	r4,SL_SPRG0+4(r11)
+	mfsprg	r4,2
+	stw	r4,SL_SPRG0+8(r11)
+	mfsprg	r4,3
+	stw	r4,SL_SPRG0+12(r11)
+
+	/* Save BATs */
+	mfdbatu	r4,0
+	stw	r4,SL_DBAT0(r11)
+	mfdbatl	r4,0
+	stw	r4,SL_DBAT0+4(r11)
+	mfdbatu	r4,1
+	stw	r4,SL_DBAT1(r11)
+	mfdbatl	r4,1
+	stw	r4,SL_DBAT1+4(r11)
+	mfdbatu	r4,2
+	stw	r4,SL_DBAT2(r11)
+	mfdbatl	r4,2
+	stw	r4,SL_DBAT2+4(r11)
+	mfdbatu	r4,3
+	stw	r4,SL_DBAT3(r11)
+	mfdbatl	r4,3
+	stw	r4,SL_DBAT3+4(r11)
+	mfibatu	r4,0
+	stw	r4,SL_IBAT0(r11)
+	mfibatl	r4,0
+	stw	r4,SL_IBAT0+4(r11)
+	mfibatu	r4,1
+	stw	r4,SL_IBAT1(r11)
+	mfibatl	r4,1
+	stw	r4,SL_IBAT1+4(r11)
+	mfibatu	r4,2
+	stw	r4,SL_IBAT2(r11)
+	mfibatl	r4,2
+	stw	r4,SL_IBAT2+4(r11)
+	mfibatu	r4,3
+	stw	r4,SL_IBAT3(r11)
+	mfibatl	r4,3
+	stw	r4,SL_IBAT3+4(r11)
+
+#if  0
+	/* Backup various CPU config stuffs */
+	bl	__save_cpu_setup
+#endif
+	/* Call the low level suspend stuff (we should probably have made
+	 * a stackframe...
+	 */
+	bl	pmdisk_suspend
+
+	/* Restore LR from the save area */
+	lis	r11,pmdisk_save_area@h
+	ori	r11,r11,pmdisk_save_area@l
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	blr
+
+
+/* Resume code */
+do_resume:
+
+	/* Stop pending alitvec streams and memory accesses */
+BEGIN_FTR_SECTION
+	DSSALL
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+ 	sync
+
+	/* Disable MSR:DR to make sure we don't take a TLB or
+	 * hash miss during the copy, as our hash table will
+	 * for a while be unuseable. For .text, we assume we are
+	 * covered by a BAT. This works only for non-G5 at this
+	 * point. G5 will need a better approach, possibly using
+	 * a small temporary hash table filled with large mappings,
+	 * disabling the MMU completely isn't a good option for
+	 * performance reasons.
+	 * (Note that 750's may have the same performance issue as
+	 * the G5 in this case, we should investigate using moving
+	 * BATs for these CPUs)
+	 */
+	mfmsr	r0
+	sync
+	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */
+	mtmsr	r0
+	sync
+	isync
+
+	/* Load ptr the list of pages to copy in r3 */
+	lis	r11,(pm_pagedir_nosave - KERNELBASE)@h
+	ori	r11,r11,pm_pagedir_nosave@l
+	lwz	r10,0(r11)
+	tophys(r3,r10)
+
+	/* Load the count of pages to copy in r4 */
+	lis	r11,(pmdisk_pages - KERNELBASE)@h
+	ori	r11,r11,pmdisk_pages@l
+	lwz	r4,0(r11)
+
+
+	/* Copy the pages. This is a very basic implementation, to
+	 * be replaced by something more cache efficient */
+1:
+	li	r0,256
+	mtctr	r0
+	lwz	r11,0(r3)	/* source */
+	tophys(r5,r11)
+	lwz	r10,4(r3)	/* destination */
+	tophys(r6,r10)
+2:
+	lwz	r8,0(r5)
+	lwz	r9,4(r5)
+	lwz	r10,8(r5)
+	lwz	r11,12(r5)
+	addi	r5,r5,16
+	stw	r8,0(r6)
+	stw	r9,4(r6)
+	stw	r10,8(r6)
+	stw	r11,12(r6)
+	addi	r6,r6,16
+	bdnz	2b
+	addi	r3,r3,16
+	subi	r4,r4,1
+	cmpwi	0,r4,0
+	bne	1b
+
+	/* Do a very simple cache flush/inval of the L1 to ensure
+	 * coherency of the icache
+	 */
+	lis	r3,0x0002
+	mtctr	r3
+	li	r3, 0
+1:
+	lwz	r0,0(r3)
+	addi	r3,r3,0x0020
+	bdnz	1b
+	isync
+	sync
+
+	/* Now flush those cache lines */
+	lis	r3,0x0002
+	mtctr	r3
+	li	r3, 0
+1:
+	dcbf	0,r3
+	addi	r3,r3,0x0020
+	bdnz	1b
+	sync
+
+	/* Ok, we are now running with the kernel data of the old
+	 * kernel fully restored. We can get to the save area
+	 * easily now. As for the rest of the code, it assumes the
+	 * loader kernel and the booted one are exactly identical
+	 */
+	lis	r11,pmdisk_save_area@h
+	ori	r11,r11,pmdisk_save_area@l
+	tophys(r11,r11)
+
+#if 0
+	/* Restore various CPU config stuffs */
+	bl	__restore_cpu_setup
+#endif
+	/* Restore the BATs, and SDR1.  Then we can turn on the MMU.
+	 * This is a bit hairy as we are running out of those BATs,
+	 * but first, our code is probably in the icache, and we are
+	 * writing the same value to the BAT, so that should be fine,
+	 * though a better solution will have to be found long-term
+	 */
+	lwz	r4,SL_SDR1(r11)
+	mtsdr1	r4
+	lwz	r4,SL_SPRG0(r11)
+	mtsprg	0,r4
+	lwz	r4,SL_SPRG0+4(r11)
+	mtsprg	1,r4
+	lwz	r4,SL_SPRG0+8(r11)
+	mtsprg	2,r4
+	lwz	r4,SL_SPRG0+12(r11)
+	mtsprg	3,r4
+
+#if 0
+	lwz	r4,SL_DBAT0(r11)
+	mtdbatu	0,r4
+	lwz	r4,SL_DBAT0+4(r11)
+	mtdbatl	0,r4
+	lwz	r4,SL_DBAT1(r11)
+	mtdbatu	1,r4
+	lwz	r4,SL_DBAT1+4(r11)
+	mtdbatl	1,r4
+	lwz	r4,SL_DBAT2(r11)
+	mtdbatu	2,r4
+	lwz	r4,SL_DBAT2+4(r11)
+	mtdbatl	2,r4
+	lwz	r4,SL_DBAT3(r11)
+	mtdbatu	3,r4
+	lwz	r4,SL_DBAT3+4(r11)
+	mtdbatl	3,r4
+	lwz	r4,SL_IBAT0(r11)
+	mtibatu	0,r4
+	lwz	r4,SL_IBAT0+4(r11)
+	mtibatl	0,r4
+	lwz	r4,SL_IBAT1(r11)
+	mtibatu	1,r4
+	lwz	r4,SL_IBAT1+4(r11)
+	mtibatl	1,r4
+	lwz	r4,SL_IBAT2(r11)
+	mtibatu	2,r4
+	lwz	r4,SL_IBAT2+4(r11)
+	mtibatl	2,r4
+	lwz	r4,SL_IBAT3(r11)
+	mtibatu	3,r4
+	lwz	r4,SL_IBAT3+4(r11)
+	mtibatl	3,r4
+#endif
+
+BEGIN_FTR_SECTION
+	li	r4,0
+	mtspr	SPRN_DBAT4U,r4
+	mtspr	SPRN_DBAT4L,r4
+	mtspr	SPRN_DBAT5U,r4
+	mtspr	SPRN_DBAT5L,r4
+	mtspr	SPRN_DBAT6U,r4
+	mtspr	SPRN_DBAT6L,r4
+	mtspr	SPRN_DBAT7U,r4
+	mtspr	SPRN_DBAT7L,r4
+	mtspr	SPRN_IBAT4U,r4
+	mtspr	SPRN_IBAT4L,r4
+	mtspr	SPRN_IBAT5U,r4
+	mtspr	SPRN_IBAT5L,r4
+	mtspr	SPRN_IBAT6U,r4
+	mtspr	SPRN_IBAT6L,r4
+	mtspr	SPRN_IBAT7U,r4
+	mtspr	SPRN_IBAT7L,r4
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+
+	/* Flush all TLBs */
+	lis	r4,0x1000
+1:	addic.	r4,r4,-0x1000
+	tlbie	r4
+	blt	1b
+	sync
+
+	/* restore the MSR and turn on the MMU */
+	lwz	r3,SL_MSR(r11)
+	bl	turn_on_mmu
+	tovirt(r11,r11)
+
+	/* Restore TB */
+	li	r3,0
+	mttbl	r3
+	lwz	r3,SL_TB(r11)
+	lwz	r4,SL_TB+4(r11)
+	mttbu	r3
+	mttbl	r4
+
+	/* Kick decrementer */
+	li	r0,1
+	mtdec	r0
+
+	/* Restore the callee-saved registers and return */
+	lwz	r0,SL_CR(r11)
+	mtcr	r0
+	lwz	r2,SL_R2(r11)
+	lmw	r12,SL_R12(r11)
+	lwz	r1,SL_SP(r11)
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	// XXX Note: we don't really need to call pmdisk_resume
+
+	li	r3,0
+	blr
+
+/* FIXME:This construct is actually not useful since we don't shut
+ * down the instruction MMU, we could just flip back MSR-DR on.
+ */
+turn_on_mmu:
+	mflr	r4
+	mtsrr0	r4
+	mtsrr1	r3
+	sync
+	isync
+	rfi
+
diff -ub -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/vmlinux.lds.S linux-2.6.7-rc2/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/vmlinux.lds.S	2004-05-09 23:33:22.000000000 -0300
+++ linux-2.6.7-rc2/arch/ppc/kernel/vmlinux.lds.S	2004-05-30 11:43:50.000000000 -0300
@@ -73,6 +73,12 @@
     CONSTRUCTORS
   }

+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }

diff -ub -Naur linux-2.6.7-rc2.orig/arch/ppc/platforms/pmac_setup.c linux-2.6.7-rc2/arch/ppc/platforms/pmac_setup.c
--- linux-2.6.7-rc2.orig/arch/ppc/platforms/pmac_setup.c	2004-05-30 11:39:26.000000000 -0300
+++ linux-2.6.7-rc2/arch/ppc/platforms/pmac_setup.c	2004-05-30 11:43:52.000000000 -0300
@@ -51,6 +51,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/suspend.h>

 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -70,6 +71,8 @@
 #include <asm/pmac_feature.h>
 #include <asm/time.h>
 #include <asm/of_device.h>
+#include <asm/mmu_context.h>
+
 #include "pmac_pic.h"
 #include "mem_pieces.h"

@@ -425,11 +428,67 @@
 #endif
 }

+/* TODO: Merge the suspend-to-ram with the common code !!!
+ * currently, this is a stub implementation for suspend-to-disk
+ * only
+ */
+
+#ifdef CONFIG_PM_DISK
+
+extern void enable_kernel_altivec(void);
+
+static int pmac_pm_prepare(u32 state)
+{
+	printk(KERN_DEBUG "pmac_pm_prepare(%d)\n", state);
+
+	return 0;
+}
+
+static int pmac_pm_enter(u32 state)
+{
+	printk(KERN_DEBUG "pmac_pm_enter(%d)\n", state);
+
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+
+	return 0;
+}
+
+static int pmac_pm_finish(u32 state)
+{
+	printk(KERN_DEBUG "pmac_pm_finish(%d)\n", state);
+
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context, current->active_mm->pgd);
+
+	return 0;
+}
+
+static struct pm_ops pmac_pm_ops = {
+	.pm_disk_mode	= PM_DISK_SHUTDOWN,
+	.prepare	= pmac_pm_prepare,
+	.enter		= pmac_pm_enter,
+	.finish		= pmac_pm_finish,
+};
+
+#endif /* CONFIG_PM_DISK */
+
 static int initializing = 1;

 static int pmac_late_init(void)
 {
 	initializing = 0;
+
+#ifdef CONFIG_PM_DISK
+	pm_set_ops(&pmac_pm_ops);
+#endif /* CONFIG_PM_DISK */
 	return 0;
 }

diff -ub -Naur linux-2.6.7-rc2.orig/include/asm-ppc/suspend.h linux-2.6.7-rc2/include/asm-ppc/suspend.h
--- linux-2.6.7-rc2.orig/include/asm-ppc/suspend.h	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6.7-rc2/include/asm-ppc/suspend.h	2004-05-30 11:43:52.000000000 -0300
@@ -0,0 +1,12 @@
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+static inline void save_processor_state(void)
+{
+}
+
+static inline void restore_processor_state(void)
+{
+}
diff -ub -Naur linux-2.6.7-rc2.orig/include/linux/suspend.h linux-2.6.7-rc2/include/linux/suspend.h
--- linux-2.6.7-rc2.orig/include/linux/suspend.h	2004-05-09 23:32:26.000000000 -0300
+++ linux-2.6.7-rc2/include/linux/suspend.h	2004-05-30 11:43:52.000000000 -0300
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H

-#ifdef CONFIG_X86
+#if (defined  CONFIG_X86) || (defined CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
diff -ub -Naur linux-2.6.7-rc2.orig/kernel/power/Kconfig linux-2.6.7-rc2/kernel/power/Kconfig
--- linux-2.6.7-rc2.orig/kernel/power/Kconfig	2004-05-09 23:33:13.000000000 -0300
+++ linux-2.6.7-rc2/kernel/power/Kconfig	2004-05-30 11:43:52.000000000 -0300
@@ -20,7 +20,7 @@

 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	depends on EXPERIMENTAL && PM && SWAP && !PPC
 	---help---
 	  Enable the possibilty of suspendig machine. It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
@@ -44,7 +44,7 @@

 config PM_DISK
 	bool "Suspend-to-Disk Support"
-	depends on PM && SWAP && X86 && !X86_64
+	depends on PM && SWAP && ((X86 && !X86_64) || PPC_PMAC)
 	---help---
 	  Suspend-to-disk is a power management state in which the contents
 	  of memory are stored on disk and the entire system is shut down or

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
