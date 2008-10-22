Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1d56ae3c139a991d06db40345969ffd918199db9.1224646671.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Support for relocatable kdump kernel
Date: Wed, 22 Oct 2008 14:38:10 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mohan Kumar M <mohan@in.ibm.com>

This adds relocatable kernel support for kdump. With this one can
use the same regular kernel to capture the kdump. A signature (0xfeed1234)
is passed in r6 from panic code to the next kernel through kexec_sequence
and purgatory code. The signature is used to differentiate between
kdump kernel and non-kdump kernels.

The purgatory code compares the signature and sets the __kdump_flag in
head_64.S.  During the boot up, kernel code checks __kdump_flag and if it
is set, the kernel will behave as relocatable kdump kernel. This kernel
will boot at the address where it was loaded by kexec-tools ie. at the
address reserved through crashkernel boot parameter.

CONFIG_CRASH_DUMP depends on CONFIG_RELOCATABLE option to build kdump
kernel as relocatable. So the same kernel can be used as production and
kdump kernel.

This patch incorporates the changes suggested by Paul Mackerras to avoid
GOT use and to avoid two copies of the code.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 Documentation/kdump/kdump.txt          |   14 +++++-
 arch/powerpc/Kconfig                   |   10 +---
 arch/powerpc/include/asm/kdump.h       |   17 ++++++--
 arch/powerpc/kernel/crash_dump.c       |    2 +
 arch/powerpc/kernel/head_64.S          |   39 +++++++++++++++---
 arch/powerpc/kernel/iommu.c            |   69 +++++++++++++++++---------------
 arch/powerpc/kernel/machine_kexec.c    |    2 +
 arch/powerpc/kernel/machine_kexec_64.c |   13 ++++--
 arch/powerpc/kernel/misc_64.S          |    9 +++-
 arch/powerpc/platforms/cell/ras.c      |    6 +-
 arch/powerpc/platforms/pseries/iommu.c |    6 +-
 11 files changed, 121 insertions(+), 66 deletions(-)

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
index 369d93e..5b15278 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -323,13 +323,11 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC_MULTIPLATFORM && PPC64 && RELOCATABLE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
-	  The kernel will be linked at a different address than normal, and
-	  so can only be used for Kdump.
-
-	  Don't change this unless you know what you are doing.
+	  The same kernel binary can be used as production kernel and dump
+	  capture kernel.
 
 config PHYP_DUMP
 	bool "Hypervisor-assisted dump (EXPERIMENTAL)"
@@ -829,11 +827,9 @@ config PAGE_OFFSET
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
index f6c93c7..a503da9 100644
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
@@ -19,17 +25,18 @@
 #endif /* CONFIG_CRASH_DUMP */
 
 #ifndef __ASSEMBLY__
-#ifdef CONFIG_CRASH_DUMP
 
+extern unsigned long __kdump_flag;
+
+#if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_RELOCATABLE)
 extern void reserve_kdump_trampoline(void);
 extern void setup_kdump_trampoline(void);
-
-#else /* !CONFIG_CRASH_DUMP */
-
+#else
+/* !CRASH_DUMP || RELOCATABLE */
 static inline void reserve_kdump_trampoline(void) { ; }
 static inline void setup_kdump_trampoline(void) { ; }
+#endif
 
-#endif /* CONFIG_CRASH_DUMP */
 #endif /* __ASSEMBLY__ */
 
 #endif /* __PPC64_KDUMP_H */
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 97e0563..19671ac 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -30,6 +30,7 @@
 /* Stores the physical address of elf header of crash image. */
 unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
 
+#ifndef CONFIG_RELOCATABLE
 void __init reserve_kdump_trampoline(void)
 {
 	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
@@ -68,6 +69,7 @@ void __init setup_kdump_trampoline(void)
 
 	DBG(" <- setup_kdump_trampoline()\n");
 }
+#endif /* CONFIG_RELOCATABLE */
 
 /*
  * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 84856be..69489bd 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -97,6 +97,12 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
+	/* This flag is set by purgatory if we should be a kdump kernel. */
+	/* Do not move this variable as purgatory knows about it. */
+	.globl	__kdump_flag
+__kdump_flag:
+	.llong	0x0
+
 #ifdef CONFIG_PPC_ISERIES
 	/*
 	 * At offset 0x20, there is a pointer to iSeries LPAR data.
@@ -1384,7 +1390,13 @@ _STATIC(__after_prom_start)
 	/* process relocations for the final address of the kernel */
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
-	mr	r3,r25
+#ifdef CONFIG_CRASH_DUMP
+	ld	r7,__kdump_flag-_stext(r26)
+	cmpldi	cr0,r7,1	/* kdump kernel ? - stay where we are */
+	bne	1f
+	add	r25,r25,r26
+#endif
+1:	mr	r3,r25
 	bl	.relocate
 #endif
 
@@ -1398,11 +1410,26 @@ _STATIC(__after_prom_start)
 	li	r3,0			/* target addr */
 	mr.	r4,r26			/* In some cases the loader may  */
 	beq	9f			/* have already put us at zero */
-	lis	r5,(copy_to_here - _stext)@ha
-	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Check if the kernel has to be running as relocatable kernel based on the
+ * variable __kdump_flag, if it is set the kernel is treated as relocatable
+ * kernel, otherwise it will be moved to PHYSICAL_START
+ */
+	ld	r7,__kdump_flag-_stext(r26)
+	cmpldi	cr0,r7,1
+	bne	3f
+
+	li	r5,__end_interrupts - _stext	/* just copy interrupts */
+	b	5f
+3:
+#endif
+	lis	r5,(copy_to_here - _stext)@ha
+	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
+
 	bl	.copy_and_flush		/* copy the first n bytes	 */
 					/* this includes the code being	 */
 					/* executed here.		 */
@@ -1411,15 +1438,15 @@ _STATIC(__after_prom_start)
 	mtctr	r8
 	bctr
 
+p_end:	.llong	_end - _stext
+
 4:	/* Now copy the rest of the kernel up to _end */
 	addis	r5,r26,(p_end - _stext)@ha
 	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
-	bl	.copy_and_flush		/* copy the rest */
+5:	bl	.copy_and_flush		/* copy the rest */
 
 9:	b	.start_here_multiplatform
 
-p_end:	.llong	_end - _stext
-
 /*
  * Copy routine used to copy the kernel to start at physical address 0
  * and flush and invalidate the caches as needed.
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ea1ba89..3857d7e 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -458,6 +458,42 @@ void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 }
 
+static void iommu_table_clear(struct iommu_table *tbl)
+{
+	if (!__kdump_flag) {
+		/* Clear the table in case firmware left allocations in it */
+		ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
+		return;
+	}
+
+#ifdef CONFIG_CRASH_DUMP
+	if (ppc_md.tce_get) {
+		unsigned long index, tceval, tcecount = 0;
+
+		/* Reserve the existing mappings left by the first kernel. */
+		for (index = 0; index < tbl->it_size; index++) {
+			tceval = ppc_md.tce_get(tbl, index + tbl->it_offset);
+			/*
+			 * Freed TCE entry contains 0x7fffffffffffffff on JS20
+			 */
+			if (tceval && (tceval != 0x7fffffffffffffffUL)) {
+				__set_bit(index, tbl->it_map);
+				tcecount++;
+			}
+		}
+
+		if ((tbl->it_size - tcecount) < KDUMP_MIN_TCE_ENTRIES) {
+			printk(KERN_WARNING "TCE table is full; freeing ");
+			printk(KERN_WARNING "%d entries for the kdump boot\n",
+				KDUMP_MIN_TCE_ENTRIES);
+			for (index = tbl->it_size - KDUMP_MIN_TCE_ENTRIES;
+				index < tbl->it_size; index++)
+				__clear_bit(index, tbl->it_map);
+		}
+	}
+#endif
+}
+
 /*
  * Build a iommu_table structure.  This contains a bit map which
  * is used to manage allocation of the tce space.
@@ -484,38 +520,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	tbl->it_largehint = tbl->it_halfpoint;
 	spin_lock_init(&tbl->it_lock);
 
-#ifdef CONFIG_CRASH_DUMP
-	if (ppc_md.tce_get) {
-		unsigned long index;
-		unsigned long tceval;
-		unsigned long tcecount = 0;
-
-		/*
-		 * Reserve the existing mappings left by the first kernel.
-		 */
-		for (index = 0; index < tbl->it_size; index++) {
-			tceval = ppc_md.tce_get(tbl, index + tbl->it_offset);
-			/*
-			 * Freed TCE entry contains 0x7fffffffffffffff on JS20
-			 */
-			if (tceval && (tceval != 0x7fffffffffffffffUL)) {
-				__set_bit(index, tbl->it_map);
-				tcecount++;
-			}
-		}
-		if ((tbl->it_size - tcecount) < KDUMP_MIN_TCE_ENTRIES) {
-			printk(KERN_WARNING "TCE table is full; ");
-			printk(KERN_WARNING "freeing %d entries for the kdump boot\n",
-				KDUMP_MIN_TCE_ENTRIES);
-			for (index = tbl->it_size - KDUMP_MIN_TCE_ENTRIES;
-				index < tbl->it_size; index++)
-				__clear_bit(index, tbl->it_map);
-		}
-	}
-#else
-	/* Clear the hardware table in case firmware left allocations in it */
-	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
-#endif
+	iommu_table_clear(tbl);
 
 	if (!welcomed) {
 		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
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
index 4bd8b4f..e6efec7 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -255,11 +255,14 @@ static union thread_union kexec_stack
 /* Our assembly helper, in kexec_stub.S */
 extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long start,
 					void *image, void *control,
-					void (*clear_all)(void)) ATTRIB_NORET;
+					void (*clear_all)(void),
+					unsigned long kdump_flag) ATTRIB_NORET;
 
 /* too late to fail here */
 void default_machine_kexec(struct kimage *image)
 {
+	unsigned long kdump_flag = 0;
+
 	/* prepare control code if any */
 
 	/*
@@ -270,8 +273,10 @@ void default_machine_kexec(struct kimage *image)
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
@@ -284,7 +289,7 @@ void default_machine_kexec(struct kimage *image)
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 			page_address(image->control_code_page),
-			ppc_md.hpte_clear_all);
+			ppc_md.hpte_clear_all, kdump_flag);
 	/* NOTREACHED */
 }
 
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 3053fe5..a243fd0 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -611,10 +611,12 @@ real_mode:	/* assume normal blr return */
 
 
 /*
- * kexec_sequence(newstack, start, image, control, clear_all())
+ * kexec_sequence(newstack, start, image, control, clear_all(), kdump_flag)
  *
  * does the grungy work with stack switching and real mode switches
  * also does simple calls to other code
+ *
+ * kdump_flag says whether the next kernel should be a kdump kernel.
  */
 
 _GLOBAL(kexec_sequence)
@@ -647,7 +649,7 @@ _GLOBAL(kexec_sequence)
 	mr	r29,r5			/* image (virt) */
 	mr	r28,r6			/* control, unused */
 	mr	r27,r7			/* clear_all() fn desc */
-	mr	r26,r8			/* spare */
+	mr	r26,r8			/* kdump flag */
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
@@ -709,5 +711,6 @@ _GLOBAL(kexec_sequence)
 	mr	r4,r30	# start, aka phys mem offset
 	mtlr	4
 	li	r5,0
-	blr	/* image->start(physid, image->start, 0); */
+	mr	r6,r26			/* kdump_flag */
+	blr	/* image->start(physid, image->start, 0, kdump_flag); */
 #endif /* CONFIG_KEXEC */
diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 2a14b05..665af1c 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -21,6 +21,7 @@
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/cell-regs.h>
+#include <asm/kdump.h>
 
 #include "ras.h"
 
@@ -111,9 +112,8 @@ static int __init cbe_ptcal_enable_on_node(int nid, int order)
 	int ret = -ENOMEM;
 	unsigned long addr;
 
-#ifdef CONFIG_CRASH_DUMP
-	rtas_call(ptcal_stop_tok, 1, 1, NULL, nid);
-#endif
+	if (__kdump_flag)
+		rtas_call(ptcal_stop_tok, 1, 1, NULL, nid);
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (!area)
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a8c4466..d56491d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -44,6 +44,7 @@
 #include <asm/tce.h>
 #include <asm/ppc-pci.h>
 #include <asm/udbg.h>
+#include <asm/kdump.h>
 
 #include "plpar_wrappers.h"
 
@@ -291,9 +292,8 @@ static void iommu_table_setparms(struct pci_controller *phb,
 
 	tbl->it_base = (unsigned long)__va(*basep);
 
-#ifndef CONFIG_CRASH_DUMP
-	memset((void *)tbl->it_base, 0, *sizep);
-#endif
+	if (!__kdump_flag)
+		memset((void *)tbl->it_base, 0, *sizep);
 
 	tbl->it_busno = phb->bus->number;
 
-- 
1.5.5
