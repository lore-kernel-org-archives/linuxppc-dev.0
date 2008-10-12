Return-Path: <mohan@in.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7DD9DDDE0
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 10:34:28 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9CNYNLr001841
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 19:34:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9CNYNHP165320
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 17:34:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9CNXri4022534
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 17:33:54 -0600
Date: Mon, 13 Oct 2008 05:04:20 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: paulus@samba.org
Subject: [PATCH] Support for relocatable kdump kernel
Message-ID: <20081012233420.GA6240@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for relocatable kdump kernel

This patch adds relocatable kernel support for kdump. With this one can
use the same regular kernel to capture the kdump. A signature (0xfeed1234)
is passed in r8 from panic code to the next kernel through kexec_sequence
and purgatory code. The signature is used to differentiate between
relocatable kdump kernel and non-kdump kernels.

The purgatory code compares the signature and sets the __kdump_flag in
head_64.S.  During the boot up, kernel code checks __kdump_flag and if it
is set, the kernel will behave as relocatable kdump kernel. This kernel
will boot at the address where it was loaded by kexec-tools ie at the
address reserved through crashkernel boot parameter

CONFIG_CRASH_DUMP depends on CONFIG_RELOCATABLE option to build kdump
kernel as relocatable. So the same kernel can be used as production and
kdump kernel.

This patch incorporates the changes suggested by Paul Mackerrass to avoid
GOT use and to avoid two copies of the code.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 Documentation/kdump/kdump.txt          |   14 ++++++++++---
 arch/powerpc/Kconfig                   |    8 ++-----
 arch/powerpc/include/asm/kdump.h       |   16 +++++++++++++++
 arch/powerpc/kernel/crash_dump.c       |    2 +
 arch/powerpc/kernel/head_64.S          |   34 ++++++++++++++++++++++++++++-----
 arch/powerpc/kernel/iommu.c            |    2 -
 arch/powerpc/kernel/machine_kexec.c    |    2 +
 arch/powerpc/kernel/machine_kexec_64.c |   12 +++++++----
 arch/powerpc/kernel/misc_64.S          |   10 ++++++---
 9 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 0705040..3f4bc84 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -109,7 +109,8 @@ There are two possible methods of using Kdump.
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architecutres which support a relocatable kernel. As
-   of today, i386, x86_64 and ia64 architectures support relocatable kernel.
+   of today, i386, x86_64, ppc64 and ia64 architectures support relocatable
+   kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
 one does not have to build a second kernel for capturing the dump. But
@@ -207,8 +208,15 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
 Dump-capture kernel config options (Arch Dependent, ppc64)
 ----------------------------------------------------------
 
-*  Make and install the kernel and its modules. DO NOT add this kernel
-   to the boot loader configuration files.
+1) Enable "Build a kdump crash kernel" support under "Kernel" options:
+
+   CONFIG_CRASH_DUMP=y
+
+2)   Enable "Build a relocatable kernel" support
+
+   CONFIG_RELOCATABLE=y
+
+   Make and install the kernel and its modules.
 
 Dump-capture kernel config options (Arch Dependent, ia64)
 ----------------------------------------------------------
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 17c988b..6b3e840 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -321,11 +321,11 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC_MULTIPLATFORM && PPC64 && RELOCATABLE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
-	  The kernel will be linked at a different address than normal, and
-	  so can only be used for Kdump.
+	  The same kernel binary can be used as production kernel and dump capture
+	  kernel
 
 	  Don't change this unless you know what you are doing.
 
@@ -824,11 +824,9 @@ config PAGE_OFFSET
 	default "0xc000000000000000"
 config KERNEL_START
 	hex
-	default "0xc000000002000000" if CRASH_DUMP
 	default "0xc000000000000000"
 config PHYSICAL_START
 	hex
-	default "0x02000000" if CRASH_DUMP
 	default "0x00000000"
 endif
 
diff --git a/arch/powerpc/include/asm/kdump.h b/arch/powerpc/include/asm/kdump.h
index f6c93c7..5308754 100644
--- a/arch/powerpc/include/asm/kdump.h
+++ b/arch/powerpc/include/asm/kdump.h
@@ -9,6 +9,12 @@
  * Reserve to the end of the FWNMI area, see head_64.S */
 #define KDUMP_RESERVE_LIMIT	0x10000 /* 64K */
 
+/*
+ * Used to differentiate between relocatable kdump kernel and other
+ * kernels
+ */
+#define KDUMP_SIGNATURE	0xfeed1234
+
 #ifdef CONFIG_CRASH_DUMP
 
 #define KDUMP_TRAMPOLINE_START	0x0100
@@ -19,11 +25,21 @@
 #endif /* CONFIG_CRASH_DUMP */
 
 #ifndef __ASSEMBLY__
+
+extern unsigned long long __kdump_flag;
+
 #ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_RELOCATABLE
+
+static inline void reserve_kdump_trampoline(void) { ; }
+static inline void setup_kdump_trampoline(void) { ; }
+
+#else
 
 extern void reserve_kdump_trampoline(void);
 extern void setup_kdump_trampoline(void);
 
+#endif /* CONFIG_RELOCATABLE */
 #else /* !CONFIG_CRASH_DUMP */
 
 static inline void reserve_kdump_trampoline(void) { ; }
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index a323c9b..eaf9d6d 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -27,6 +27,7 @@
 #define DBG(fmt...)
 #endif
 
+#ifndef CONFIG_RELOCATABLE
 void __init reserve_kdump_trampoline(void)
 {
 	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
@@ -65,6 +66,7 @@ void __init setup_kdump_trampoline(void)
 
 	DBG(" <- setup_kdump_trampoline()\n");
 }
+#endif /* CONFIG_RELOCATABLE */
 
 #ifdef CONFIG_PROC_VMCORE
 static int __init parse_elfcorehdr(char *p)
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index e409338..5b12b10 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -97,6 +97,14 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
+	/* This flag is set only for kdump kernels so that */
+	/* it will be relocatable. Purgatory code user space kexec-tools */
+	/* sets this flag. Do not move this variable as purgatory code */
+	/* relies on the position of this variables */
+	.globl	__kdump_flag
+__kdump_flag:
+	.llong	0x0
+
 #ifdef CONFIG_PPC_ISERIES
 	/*
 	 * At offset 0x20, there is a pointer to iSeries LPAR data.
@@ -1384,8 +1392,13 @@ _STATIC(__after_prom_start)
 	/* process relocations for the final address of the kernel */
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
+#ifdef CONFIG_CRASH_DUMP
+	ld	r7,__kdump_flag-_stext(r26)
+	cmpldi	cr0,r7,1	/* relocatable kernel ? */
+	bne	1f
 	add	r25,r25,r26
-	mr	r3,r25
+#endif
+1:	mr	r3,r25
 	bl	.relocate
 #endif
 
@@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
 	beq	9f			/* have already put us at zero */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
-#ifdef CONFIG_RELOCATABLE
+
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Check if the kernel has to be running as relocatable kernel based on the
+ * variable __kdump_flag, if it is set the kernel is treated as relocatble
+ * kernel, otherwise it will be moved to PHYSICAL_START
+ */
+	ld	r7,__kdump_flag-_stext(r26)
+	cmpldi	cr0,r7,1
+	bne	regular
+
 	li	r5,__end_interrupts - _stext	/* just copy interrupts */
-#else
+	b	5f
+regular:
+#endif
 	lis	r5,(copy_to_here - _stext)@ha
 	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
 
@@ -1420,8 +1445,7 @@ p_end:	.llong	_end - _stext
 4:	/* Now copy the rest of the kernel up to _end */
 	addis	r5,r26,(p_end - _stext)@ha
 	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
-#endif
-	bl	.copy_and_flush		/* copy the rest */
+5:	bl	.copy_and_flush		/* copy the rest */
 
 9:	b	.start_here_multiplatform
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 550a193..24f7797 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -494,7 +494,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	spin_lock_init(&tbl->it_lock);
 
 #ifdef CONFIG_CRASH_DUMP
-	if (ppc_md.tce_get) {
+	if (ppc_md.tce_get && __kdump_flag) {
 		unsigned long index;
 		unsigned long tceval;
 		unsigned long tcecount = 0;
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index aab7688..ac2a21f 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -88,11 +88,13 @@ void __init reserve_crashkernel(void)
 
 	crash_size = crashk_res.end - crashk_res.start + 1;
 
+#ifndef CONFIG_RELOCATABLE
 	if (crashk_res.start != KDUMP_KERNELBASE)
 		printk("Crash kernel location must be 0x%x\n",
 				KDUMP_KERNELBASE);
 
 	crashk_res.start = KDUMP_KERNELBASE;
+#endif
 	crash_size = PAGE_ALIGN(crash_size);
 	crashk_res.end = crashk_res.start + crash_size - 1;
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a168514..6a45a9e 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -255,11 +255,13 @@ static union thread_union kexec_stack
 /* Our assembly helper, in kexec_stub.S */
 extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long start,
 					void *image, void *control,
-					void (*clear_all)(void)) ATTRIB_NORET;
+					void (*clear_all)(void),
+				unsigned long long kdump_flag) ATTRIB_NORET;
 
 /* too late to fail here */
 void default_machine_kexec(struct kimage *image)
 {
+	unsigned long long kdump_flag = 0;
 	/* prepare control code if any */
 
 	/*
@@ -270,8 +272,10 @@ void default_machine_kexec(struct kimage *image)
         * using debugger IPI.
         */
 
-       if (crashing_cpu == -1)
-               kexec_prepare_cpus();
+	if (crashing_cpu == -1)
+		kexec_prepare_cpus();
+	else
+		kdump_flag = KDUMP_SIGNATURE;
 
 	/* switch to a staticly allocated stack.  Based on irq stack code.
 	 * XXX: the task struct will likely be invalid once we do the copy!
@@ -284,7 +288,7 @@ void default_machine_kexec(struct kimage *image)
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 			page_address(image->control_code_page),
-			ppc_md.hpte_clear_all);
+			ppc_md.hpte_clear_all, kdump_flag);
 	/* NOTREACHED */
 }
 
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 4dd70cf..c93e5f7 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -609,10 +609,13 @@ real_mode:	/* assume normal blr return */
 
 
 /*
- * kexec_sequence(newstack, start, image, control, clear_all())
+ * kexec_sequence(newstack, start, image, control, clear_all(), kdump_flag)
  *
  * does the grungy work with stack switching and real mode switches
  * also does simple calls to other code
+ *
+ * kdump_flag says whether the next kernel should be running at the reserved
+ * load address as needed for relocatable kdump kernel
  */
 
 _GLOBAL(kexec_sequence)
@@ -645,7 +648,7 @@ _GLOBAL(kexec_sequence)
 	mr	r29,r5			/* image (virt) */
 	mr	r28,r6			/* control, unused */
 	mr	r27,r7			/* clear_all() fn desc */
-	mr	r26,r8			/* spare */
+	mr	r26,r8			/* kdump flag */
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
@@ -707,5 +710,6 @@ _GLOBAL(kexec_sequence)
 	mr	r4,r30	# start, aka phys mem offset
 	mtlr	4
 	li	r5,0
-	blr	/* image->start(physid, image->start, 0); */
+	mr	r6,r26			/* kdump_flag */
+	blr	/* image->start(physid, image->start, 0, kdump_flag); */
 #endif /* CONFIG_KEXEC */
