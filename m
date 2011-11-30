Return-Path: <anton@samba.org>
Message-Id: <20111130102415.043782722@samba.org>
Date: Wed, 30 Nov 2011 21:23:12 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 4/9] powerpc: Cleanup crash/kexec code
References: <20111130102308.348262468@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove some unnecessary defines and fix some spelling mistakes.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/crash.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/crash.c	2011-11-25 16:42:11.554016696 +1100
+++ linux-build/arch/powerpc/kernel/crash.c	2011-11-25 16:42:37.110467611 +1100
@@ -10,41 +10,27 @@
  *
  */
 
-#undef DEBUG
-
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/reboot.h>
 #include <linux/kexec.h>
-#include <linux/bootmem.h>
 #include <linux/export.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
-#include <linux/elf.h>
-#include <linux/elfcore.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/types.h>
-#include <linux/memblock.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
 #include <asm/kexec.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
-#include <asm/firmware.h>
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/setjmp.h>
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-/* This keeps a track of which one is crashing cpu. */
+/* This keeps a track of which one is the crashing cpu. */
 int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
@@ -201,7 +187,7 @@ void crash_kexec_secondary(struct pt_reg
 static void crash_kexec_prepare_cpus(int cpu)
 {
 	/*
-	 * move the secondarys to us so that we can copy
+	 * move the secondaries to us so that we can copy
 	 * the new kernel 0-0x100 safely
 	 *
 	 * do this if kexec in setup.c ?
@@ -302,7 +288,6 @@ void default_machine_crash_shutdown(stru
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
-
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
@@ -328,7 +313,7 @@ void default_machine_crash_shutdown(stru
 	machine_kexec_mask_interrupts();
 
 	/*
-	 * Call registered shutdown routines savely.  Swap out
+	 * Call registered shutdown routines safely.  Swap out
 	 * __debugger_fault_handler, and replace on exit.
 	 */
 	old_handler = __debugger_fault_handler;
Index: linux-build/arch/powerpc/include/asm/kexec.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/kexec.h	2011-11-25 16:41:06.224864016 +1100
+++ linux-build/arch/powerpc/include/asm/kexec.h	2011-11-25 16:42:37.110467611 +1100
@@ -49,7 +49,6 @@
 #define KEXEC_STATE_REAL_MODE 2
 
 #ifndef __ASSEMBLY__
-#include <linux/cpumask.h>
 #include <asm/reg.h>
 
 typedef void (*crash_shutdown_t)(void);
