Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16E502BDAB
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2004 21:49:31 +1000 (EST)
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id AC6862BC43
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2004 13:30:25 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19165-05 for <linuxppc-dev@ozlabs.org>;
	Mon, 4 Oct 2004 13:30:16 +0200 (CEST)
Received: from bogon.sigxcpu.org (unknown [62.157.100.134])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 14D6E2BC40
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2004 13:30:16 +0200 (CEST)
Date: Mon, 4 Oct 2004 13:21:05 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041004112105.GA5637@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [agx@sigxcpu.org: [PATCH]: swsusp on linux-2.6.9-rc3]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
attached is a forward port of Benjamin's pmdisk code to swsusp which got
finally merged with pmdisk in 2.6.9-rc3. This has only been very lightly
tested but survived a couple of suspend/resumes so far.
Have fun,
 -- Guido

diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/arch/ppc/Kconfig linux-2.6.9-rc3/arch/ppc/Kconfig
--- linux-2.6.9-rc3.orig/arch/ppc/Kconfig	2004-10-03 14:40:38.000000000 +0200
+++ linux-2.6.9-rc3/arch/ppc/Kconfig	2004-10-03 16:37:32.000000000 +0200
@@ -987,6 +987,8 @@
 
 source "drivers/zorro/Kconfig"
 
+source kernel/power/Kconfig
+
 endmenu
 
 menu "Bus options"
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/arch/ppc/kernel/Makefile linux-2.6.9-rc3/arch/ppc/kernel/Makefile
--- linux-2.6.9-rc3.orig/arch/ppc/kernel/Makefile	2004-10-03 14:40:40.000000000 +0200
+++ linux-2.6.9-rc3/arch/ppc/kernel/Makefile	2004-10-03 16:48:32.000000000 +0200
@@ -16,6 +16,7 @@
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/arch/ppc/kernel/signal.c linux-2.6.9-rc3/arch/ppc/kernel/signal.c
--- linux-2.6.9-rc3.orig/arch/ppc/kernel/signal.c	2004-10-03 14:40:40.000000000 +0200
+++ linux-2.6.9-rc3/arch/ppc/kernel/signal.c	2004-10-03 16:47:30.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -604,6 +605,14 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		signr = 0;
+		ret = regs->gpr[3];
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -626,6 +635,7 @@
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
+no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/arch/ppc/kernel/swsusp.S linux-2.6.9-rc3/arch/ppc/kernel/swsusp.S
--- linux-2.6.9-rc3.orig/arch/ppc/kernel/swsusp.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc3/arch/ppc/kernel/swsusp.S	2004-10-03 23:53:13.000000000 +0200
@@ -0,0 +1,356 @@
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
+_GLOBAL(swsusp_save_area)
+	.space	SL_SIZE
+
+
+	.section .text
+	.align	5
+
+_GLOBAL(swsusp_arch_suspend)
+
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
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
+	bl	swsusp_save
+
+	/* Restore LR from the save area */
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	blr
+
+
+/* Resume code */
+_GLOBAL(swsusp_arch_resume)
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
+	lis	r11,(pagedir_nosave - KERNELBASE)@h
+	ori	r11,r11,pagedir_nosave@l
+	lwz	r10,0(r11)
+	tophys(r3,r10)
+
+	/* Load the count of pages to copy in r4 */
+	lis	r11,(nr_copy_pages - KERNELBASE)@h
+	ori	r11,r11,nr_copy_pages@l
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
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
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
+	// XXX Note: we don't really need to call swsusp_resume
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
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/arch/ppc/kernel/vmlinux.lds.S linux-2.6.9-rc3/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.9-rc3.orig/arch/ppc/kernel/vmlinux.lds.S	2004-10-03 14:40:40.000000000 +0200
+++ linux-2.6.9-rc3/arch/ppc/kernel/vmlinux.lds.S	2004-10-03 16:47:30.000000000 +0200
@@ -74,6 +74,12 @@
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
 
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/arch/ppc/platforms/pmac_setup.c linux-2.6.9-rc3/arch/ppc/platforms/pmac_setup.c
--- linux-2.6.9-rc3.orig/arch/ppc/platforms/pmac_setup.c	2004-10-03 14:40:43.000000000 +0200
+++ linux-2.6.9-rc3/arch/ppc/platforms/pmac_setup.c	2004-10-03 16:47:30.000000000 +0200
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
 
@@ -420,11 +423,67 @@
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
 
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/drivers/ide/ppc/pmac.c linux-2.6.9-rc3/drivers/ide/ppc/pmac.c
--- linux-2.6.9-rc3.orig/drivers/ide/ppc/pmac.c	2004-10-03 14:41:11.000000000 +0200
+++ linux-2.6.9-rc3/drivers/ide/ppc/pmac.c	2004-10-03 16:47:30.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
 
@@ -1364,7 +1365,7 @@
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			mdev->ofdev.dev.power_state = state;
@@ -1472,7 +1473,7 @@
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state != pdev->dev.power_state && state >= 2) {
+	if (state != pdev->dev.power_state && state == PM_SUSPEND_MEM ) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			pdev->dev.power_state = state;
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/drivers/macintosh/Kconfig linux-2.6.9-rc3/drivers/macintosh/Kconfig
--- linux-2.6.9-rc3.orig/drivers/macintosh/Kconfig	2004-08-14 07:36:56.000000000 +0200
+++ linux-2.6.9-rc3/drivers/macintosh/Kconfig	2004-10-03 16:47:30.000000000 +0200
@@ -80,7 +80,7 @@
 
 config PMAC_PBOOK
 	bool "Power management support for PowerBooks"
-	depends on ADB_PMU
+	depends on PM && ADB_PMU
 	---help---
 	  This provides support for putting a PowerBook to sleep; it also
 	  enables media bay support.  Power management works on the
@@ -97,11 +97,6 @@
 	  have it autoloaded. The act of removing the module shuts down the
 	  sound hardware for more power savings.
 
-config PM
-	bool
-	depends on PPC_PMAC && ADB_PMU && PMAC_PBOOK
-	default y
-
 config PMAC_APM_EMU
 	tristate "APM emulation"
 	depends on PMAC_PBOOK
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/drivers/macintosh/mediabay.c linux-2.6.9-rc3/drivers/macintosh/mediabay.c
--- linux-2.6.9-rc3.orig/drivers/macintosh/mediabay.c	2004-08-14 07:36:32.000000000 +0200
+++ linux-2.6.9-rc3/drivers/macintosh/mediabay.c	2004-10-03 16:47:30.000000000 +0200
@@ -713,7 +713,7 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/drivers/macintosh/via-pmu.c linux-2.6.9-rc3/drivers/macintosh/via-pmu.c
--- linux-2.6.9-rc3.orig/drivers/macintosh/via-pmu.c	2004-10-03 14:41:31.000000000 +0200
+++ linux-2.6.9-rc3/drivers/macintosh/via-pmu.c	2004-10-03 16:47:30.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <asm/prom.h>
@@ -2326,7 +2327,7 @@
 	/* Sync the disks. */
 	/* XXX It would be nice to have some way to ensure that
 	 * nobody is dirtying any new buffers while we wait. That
-	 * could be acheived using the refrigerator for processes
+	 * could be achieved using the refrigerator for processes
 	 * that swsusp uses
 	 */
 	sys_sync();
@@ -2379,7 +2380,6 @@
 
 	/* Wait for completion of async backlight requests */
 	while (!bright_req_1.complete || !bright_req_2.complete ||
-
 			!batt_req.complete)
 		pmu_poll();
 
@@ -3048,6 +3048,88 @@
 }
 #endif /* DEBUG_SLEEP */
 
+
+/* FIXME: This is a temporary set of callbacks to enable us
+ * to do suspend-to-disk.
+ */
+
+#ifdef CONFIG_PM
+
+static int pmu_sys_suspended = 0;
+
+static int pmu_sys_suspend(struct sys_device *sysdev, u32 state)
+{
+	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
+		return 0;
+
+	/* Suspend PMU event interrupts */
+	pmu_suspend();
+
+	pmu_sys_suspended = 1;
+	return 0;
+}
+
+static int pmu_sys_resume(struct sys_device *sysdev)
+{
+	struct adb_request req;
+
+	if (!pmu_sys_suspended)
+		return 0;
+
+	/* Tell PMU we are ready */
+	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
+	pmu_wait_complete(&req);
+
+	/* Resume PMU event interrupts */
+	pmu_resume();
+
+	pmu_sys_suspended = 0;
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+static struct sysdev_class pmu_sysclass = {
+	set_kset_name("pmu"),
+};
+
+static struct sys_device device_pmu = {
+	.id		= 0,
+	.cls		= &pmu_sysclass,
+};
+
+static struct sysdev_driver driver_pmu = {
+#ifdef CONFIG_PM
+	.suspend	= &pmu_sys_suspend,
+	.resume		= &pmu_sys_resume,
+#endif /* CONFIG_PM */
+};
+
+static int __init init_pmu_sysfs(void)
+{
+	int rc;
+
+	rc = sysdev_class_register(&pmu_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_pmu);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys device\n");
+		return -ENODEV;
+	}
+	rc = sysdev_driver_register(&pmu_sysclass, &driver_pmu);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys driver\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_pmu_sysfs);
+
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
 EXPORT_SYMBOL(pmu_poll_adb);
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/drivers/video/aty/radeon_pm.c linux-2.6.9-rc3/drivers/video/aty/radeon_pm.c
--- linux-2.6.9-rc3.orig/drivers/video/aty/radeon_pm.c	2004-08-14 07:37:26.000000000 +0200
+++ linux-2.6.9-rc3/drivers/video/aty/radeon_pm.c	2004-10-03 16:47:36.000000000 +0200
@@ -859,6 +859,8 @@
 	 * know we'll be rebooted, ...
 	 */
 
+	if (state != PM_SUSPEND_MEM)
+		return 0;
 	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
 	
 	acquire_console_sem();
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/include/asm-ppc/suspend.h linux-2.6.9-rc3/include/asm-ppc/suspend.h
--- linux-2.6.9-rc3.orig/include/asm-ppc/suspend.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc3/include/asm-ppc/suspend.h	2004-10-03 16:47:36.000000000 +0200
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
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/include/linux/reboot.h linux-2.6.9-rc3/include/linux/reboot.h
--- linux-2.6.9-rc3.orig/include/linux/reboot.h	2004-08-14 07:38:11.000000000 +0200
+++ linux-2.6.9-rc3/include/linux/reboot.h	2004-10-03 16:47:36.000000000 +0200
@@ -42,6 +42,8 @@
 extern int register_reboot_notifier(struct notifier_block *);
 extern int unregister_reboot_notifier(struct notifier_block *);
 
+/* For use by swsusp only */
+extern struct notifier_block *reboot_notifier_list;
 
 /*
  * Architecture-specific implementations of sys_reboot commands.
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/include/linux/suspend.h linux-2.6.9-rc3/include/linux/suspend.h
--- linux-2.6.9-rc3.orig/include/linux/suspend.h	2004-10-03 14:42:18.000000000 +0200
+++ linux-2.6.9-rc3/include/linux/suspend.h	2004-10-03 16:47:36.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
+#if (defined  CONFIG_X86) || (defined CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/kernel/power/disk.c linux-2.6.9-rc3/kernel/power/disk.c
--- linux-2.6.9-rc3.orig/kernel/power/disk.c	2004-10-03 14:42:20.000000000 +0200
+++ linux-2.6.9-rc3/kernel/power/disk.c	2004-10-03 23:42:33.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/reboot.h>
 #include "power.h"
 
 
@@ -46,14 +47,15 @@
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		device_power_down(PM_SUSPEND_DISK);
+	    	local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
+		local_irq_restore(flags);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
+    		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		device_shutdown();
 		machine_power_off();
 		break;
@@ -171,6 +173,7 @@
 	in_suspend = 1;
 	if ((error = swsusp_suspend()))
 		goto Done;
+	pr_debug("PM: after memory snapshot.\n");
 
 	if (in_suspend) {
 		pr_debug("PM: writing image.\n");
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/kernel/power/main.c linux-2.6.9-rc3/kernel/power/main.c
--- linux-2.6.9-rc3.orig/kernel/power/main.c	2004-10-03 14:42:20.000000000 +0200
+++ linux-2.6.9-rc3/kernel/power/main.c	2004-10-03 16:47:36.000000000 +0200
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  * 
- * This file is release under the GPLv2
+ * This file is released under the GPLv2
  *
  */
 
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/kernel/power/swsusp.c linux-2.6.9-rc3/kernel/power/swsusp.c
--- linux-2.6.9-rc3.orig/kernel/power/swsusp.c	2004-10-03 14:42:20.000000000 +0200
+++ linux-2.6.9-rc3/kernel/power/swsusp.c	2004-10-03 23:29:34.000000000 +0200
@@ -854,14 +854,16 @@
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	device_power_down(PM_SUSPEND_DISK);
 	save_processor_state();
 	error = swsusp_arch_suspend();
 	restore_processor_state();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
 
-
+#if 0
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
@@ -871,15 +873,18 @@
 	__flush_tlb_global();
 	return 0;
 }
+#endif
 
 int swsusp_resume(void)
 {
 	int error;
 	local_irq_disable();
+	device_power_down(PM_SUSPEND_DISK);
 	save_processor_state();
 	error = swsusp_arch_resume();
 	restore_processor_state();
 	restore_highmem();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
@@ -1165,7 +1170,7 @@
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
 
-	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
+	pr_debug("swsusp: Reading pagedir (%d Pages)\n",n);
 
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
 		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
@@ -1195,7 +1200,7 @@
 }
 
 /**
- *	pmdisk_read - Read saved image from swap.
+ *	swsusp_read - Read saved image from swap.
  */
 
 int __init swsusp_read(void)
@@ -1219,6 +1224,6 @@
 	if (!error)
 		pr_debug("Reading resume file was successful\n");
 	else
-		pr_debug("pmdisk: Error %d resuming\n", error);
+		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }
diff -ubw --exclude='*.orig' --exclude='*.o' --exclude='*.ko' --exclude='*.cmd' --exclude='*.o' --exclude=CVS/ --exclude=.svn --exclude='*.mod' --exclude='.*' --exclude='*.rej' --exclude='*.orig' --exclude='*.symvers' --exclude=debian --exclude='*.a' --exclude='*.mod.c' --exclude=asm/ -Nur linux-2.6.9-rc3.orig/kernel/sys.c linux-2.6.9-rc3/kernel/sys.c
--- linux-2.6.9-rc3.orig/kernel/sys.c	2004-10-03 14:42:20.000000000 +0200
+++ linux-2.6.9-rc3/kernel/sys.c	2004-10-03 16:47:39.000000000 +0200
@@ -84,7 +84,7 @@
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
+struct notifier_block *reboot_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**


----- End forwarded message -----
