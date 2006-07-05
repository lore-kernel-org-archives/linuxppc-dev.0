Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 05 Jul 2006 14:39:43 +1000
Subject: [RFC/PATCH 2/2] Make crash.c work on 32-bit and 64-bit
In-Reply-To: <1152074382.592260.383409859049.qpush@concordia>
Message-Id: <20060705043943.9037567B56@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To compile kexec on 32-bit we need a few more bits and pieces. Rather
than add empty definitions, we can make crash.c work on 32-bit, with
only a couple of kludges.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/Makefile           |    4 ++--
 arch/powerpc/kernel/crash.c            |   11 +++++++++++
 arch/powerpc/kernel/machine_kexec_64.c |    1 -
 arch/powerpc/kernel/traps.c            |    3 ---
 include/asm-powerpc/kexec.h            |    3 +--
 5 files changed, 14 insertions(+), 8 deletions(-)

Index: to-merge/arch/powerpc/kernel/Makefile
===================================================================
--- to-merge.orig/arch/powerpc/kernel/Makefile
+++ to-merge/arch/powerpc/kernel/Makefile
@@ -67,9 +67,9 @@ pci64-$(CONFIG_PPC64)		+= pci_64.o pci_d
 				   pci_direct_iommu.o iomap.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
-kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o crash.o
+kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
 kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o $(kexec-y)
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
 
 ifeq ($(CONFIG_PPC_ISERIES),y)
 $(obj)/head_64.o: $(obj)/lparmap.s
Index: to-merge/arch/powerpc/kernel/crash.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash.c
+++ to-merge/arch/powerpc/kernel/crash.c
@@ -44,6 +44,7 @@
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
+cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
 static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
@@ -139,7 +140,13 @@ void crash_ipi_callback(struct pt_regs *
 
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(1, 1);
+
+#ifdef CONFIG_PPC64
 	kexec_smp_wait();
+#else
+	for (;;);	/* FIXME */
+#endif
+
 	/* NOTREACHED */
 }
 
@@ -255,7 +262,11 @@ static void crash_kexec_prepare_cpus(int
 	 *
 	 * do this if kexec in setup.c ?
 	 */
+#ifdef CONFIG_PPC64
 	smp_release_cpus();
+#else
+	/* FIXME */
+#endif
 }
 
 void crash_kexec_secondary(struct pt_regs *regs)
Index: to-merge/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ to-merge/arch/powerpc/kernel/machine_kexec_64.c
@@ -10,7 +10,6 @@
  */
 
 
-#include <linux/cpumask.h>
 #include <linux/kexec.h>
 #include <linux/smp.h>
 #include <linux/thread_info.h>
Index: to-merge/arch/powerpc/kernel/traps.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/traps.c
+++ to-merge/arch/powerpc/kernel/traps.c
@@ -55,9 +55,6 @@
 
 #ifdef CONFIG_PPC64	/* XXX */
 #define _IO_BASE	pci_io_base
-#ifdef CONFIG_KEXEC
-cpumask_t cpus_in_sr = CPU_MASK_NONE;
-#endif
 #endif
 
 #ifdef CONFIG_DEBUGGER
Index: to-merge/include/asm-powerpc/kexec.h
===================================================================
--- to-merge.orig/include/asm-powerpc/kexec.h
+++ to-merge/include/asm-powerpc/kexec.h
@@ -32,6 +32,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
+#include <linux/cpumask.h>
 
 #ifdef CONFIG_KEXEC
 
@@ -109,7 +110,6 @@ static inline void crash_setup_regs(stru
 
 #define MAX_NOTE_BYTES 1024
 
-#ifdef __powerpc64__
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
 extern int crashing_cpu;
@@ -119,7 +119,6 @@ static inline int kexec_sr_activated(int
 {
 	return cpu_isset(cpu,cpus_in_sr);
 }
-#endif /* __powerpc64 __ */
 
 struct kimage;
 struct pt_regs;
