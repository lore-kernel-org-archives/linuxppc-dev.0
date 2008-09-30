Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EA97DDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 22:53:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8UCrWr1031477
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 08:53:32 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8UCrVss187012
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:53:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8UCr1pB030867
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:53:02 -0600
Date: Tue, 30 Sep 2008 18:23:27 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: paulus@samba.org
Subject: [PATCH 2/2] Support for relocatable kdump kernel
Message-ID: <20080930125327.GB1945@in.ibm.com>
References: <20080930124828.GA1945@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080930124828.GA1945@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
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
address reserved through crashkernel boot parameter.

Now for kdump, both CONFIG_RELOCATABLE and CONFIG_CRASH_DUMP should be
enabled and the same kernel can be used as production and kdump kernel.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 Documentation/kdump/kdump.txt          |   17 +++++++--
 arch/powerpc/include/asm/kexec.h       |    6 +++
 arch/powerpc/kernel/head_64.S          |   60 +++++++++++++++++++++++++++++---
 arch/powerpc/kernel/iommu.c            |    2 +-
 arch/powerpc/kernel/machine_kexec_64.c |   12 ++++--
 arch/powerpc/kernel/misc_64.S          |   10 ++++--
 6 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 0705040..95a9c95 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -104,12 +104,14 @@ Build the system and dump-capture kernels
 There are two possible methods of using Kdump.
 
 1) Build a separate custom dump-capture kernel for capturing the
-   kernel core dump.
+   kernel core dump. Legacy kdump kernel build support(i.e separate kdump
+   kernel) for ppc64 is not available.
 
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architecutres which support a relocatable kernel. As
-   of today, i386, x86_64 and ia64 architectures support relocatable kernel.
+   of today, i386, x86_64, ppc64 and ia64 architectures support relocatable
+   kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
 one does not have to build a second kernel for capturing the dump. But
@@ -207,8 +209,15 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
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
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 3736d9b..765b318 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -24,6 +24,12 @@
 
 #define KEXEC_CONTROL_PAGE_SIZE 4096
 
+/*
+ * Used to differentiate between relocatable kdump kernel and other
+ * kernels
+ */
+#define KDUMP_SIGNATURE	0xfeed1234
+
 /* The native architecture */
 #ifdef __powerpc64__
 #define KEXEC_ARCH KEXEC_ARCH_PPC64
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 84856be..bbe1617 100644
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
@@ -1384,7 +1392,15 @@ _STATIC(__after_prom_start)
 	/* process relocations for the final address of the kernel */
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
-	mr	r3,r25
+#ifdef CONFIG_CRASH_DUMP
+	ld	r7,__kdump_flag@got(r2)
+	add	r7,r7,r26
+	ld	r7,0(r7)
+	cmpldi	cr0,r7,1	/* relocatable kernel ? */
+	bne	1f
+	add	r25,r25,r26
+#endif
+1:	mr	r3,r25
 	bl	.relocate
 #endif
 
@@ -1398,10 +1414,26 @@ _STATIC(__after_prom_start)
 	li	r3,0			/* target addr */
 	mr.	r4,r26			/* In some cases the loader may  */
 	beq	9f			/* have already put us at zero */
-	lis	r5,(copy_to_here - _stext)@ha
-	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
+#ifdef CONFIG_RELOCATABLE
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Check if the kernel has to be running as relocatable kernel based on the
+ * variable __kdump_flag, if it is set the kernel is treated as relocatble
+ * kernel, otherwise it will be moved to PHYSICAL_START
+ */
+	ld	r7,__kdump_flag@got(r2)
+	ld	r7,0(r7)
+	cmpldi	cr0,r7,1
+	bne	regular
+
+	li	r5,__end_interrupts - _stext	/* just copy interrupts */
+	b	5f
+regular:
+#endif
+	lis	r5,(copy_to_here - _stext)@ha
+	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
 
 	bl	.copy_and_flush		/* copy the first n bytes	 */
 					/* this includes the code being	 */
@@ -1411,15 +1443,33 @@ _STATIC(__after_prom_start)
 	mtctr	r8
 	bctr
 
+p_end:	.llong	_end - _stext
+
 4:	/* Now copy the rest of the kernel up to _end */
 	addis	r5,r26,(p_end - _stext)@ha
 	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
-	bl	.copy_and_flush		/* copy the rest */
+#else
+	lis	r5,(copy_to_here - _stext)@ha
+	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
 
-9:	b	.start_here_multiplatform
+	bl	.copy_and_flush		/* copy the first n bytes	 */
+					/* this includes the code being	 */
+					/* executed here.		 */
+	addis	r8,r3,(4f - _stext)@ha	/* Jump to the copy of this code */
+	addi	r8,r8,(4f - _stext)@l	/* that we just made */
+	mtctr	r8
+	bctr
 
 p_end:	.llong	_end - _stext
 
+4:	/* Now copy the rest of the kernel up to _end */
+	addis	r5,r26,(p_end - _stext)@ha
+	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
+#endif
+5:	bl	.copy_and_flush		/* copy the rest */
+
+9:	b	.start_here_multiplatform
+
 /*
  * Copy routine used to copy the kernel to start at physical address 0
  * and flush and invalidate the caches as needed.
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 6724820..251f5c2 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -493,7 +493,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	spin_lock_init(&tbl->it_lock);
 
 #ifdef CONFIG_CRASH_DUMP
-	if (ppc_md.tce_get) {
+	if (ppc_md.tce_get && __kdump_flag) {
 		unsigned long index;
 		unsigned long tceval;
 		unsigned long tcecount = 0;
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
-- 
1.5.5.1
