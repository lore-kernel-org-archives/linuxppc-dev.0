Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 17 May 2006 18:00:49 +1000
Subject: [PATCH 4/5] powerpc: Kdump header cleanup
In-Reply-To: <1147852841.148164.91320074069.qpush@concordia>
Message-Id: <20060517080050.0793067A5B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to know the base address of the kdump kernel even when we're not a
kdump kernel, so add a #define for it. Move the logic that sets the kdump
kernelbase into kdump.h instead of page.h.

Rename kdump_setup() to setup_kdump_trampoline() to make it clearer what it's
doing, and add an empty definition for the !CRASH_DUMP case to avoid a
#define in the C code. Similarly, add reserve_kdump_trampoline().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/crash_dump.c |   11 ++++++++---
 arch/powerpc/kernel/prom.c       |    4 +---
 arch/powerpc/kernel/setup_64.c   |    4 +---
 include/asm-powerpc/kdump.h      |   29 +++++++++++++++++++++++++++--
 include/asm-powerpc/page.h       |    8 +-------
 5 files changed, 38 insertions(+), 18 deletions(-)

Index: to-merge/arch/powerpc/kernel/crash_dump.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash_dump.c
+++ to-merge/arch/powerpc/kernel/crash_dump.c
@@ -25,6 +25,11 @@
 #define DBG(fmt...)
 #endif
 
+void reserve_kdump_trampoline(void)
+{
+	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
+}
+
 static void __init create_trampoline(unsigned long addr)
 {
 	/* The maximum range of a single instruction branch, is the current
@@ -39,11 +44,11 @@ static void __init create_trampoline(uns
 	create_branch(addr + 4, addr + PHYSICAL_START, 0);
 }
 
-void __init kdump_setup(void)
+void __init setup_kdump_trampoline(void)
 {
 	unsigned long i;
 
-	DBG(" -> kdump_setup()\n");
+	DBG(" -> setup_kdump_trampoline()\n");
 
 	for (i = KDUMP_TRAMPOLINE_START; i < KDUMP_TRAMPOLINE_END; i += 8) {
 		create_trampoline(i);
@@ -52,7 +57,7 @@ void __init kdump_setup(void)
 	create_trampoline(__pa(system_reset_fwnmi) - PHYSICAL_START);
 	create_trampoline(__pa(machine_check_fwnmi) - PHYSICAL_START);
 
-	DBG(" <- kdump_setup()\n");
+	DBG(" <- setup_kdump_trampoline()\n");
 }
 
 #ifdef CONFIG_PROC_VMCORE
Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -1326,9 +1326,7 @@ void __init early_init_devtree(void *par
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
 	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
-#ifdef CONFIG_CRASH_DUMP
-	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
-#endif
+	reserve_kdump_trampoline();
 	early_reserve_mem();
 
 	lmb_enforce_memory_limit(memory_limit);
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -199,9 +199,7 @@ void __init early_setup(unsigned long dt
 	/* Probe the machine type */
 	probe_machine();
 
-#ifdef CONFIG_CRASH_DUMP
-	kdump_setup();
-#endif
+	setup_kdump_trampoline();
 
 	DBG("Found, Initializing memory management...\n");
 
Index: to-merge/include/asm-powerpc/kdump.h
===================================================================
--- to-merge.orig/include/asm-powerpc/kdump.h
+++ to-merge/include/asm-powerpc/kdump.h
@@ -1,13 +1,38 @@
 #ifndef _PPC64_KDUMP_H
 #define _PPC64_KDUMP_H
 
+/* Kdump kernel runs at 32 MB, change at your peril. */
+#define KDUMP_KERNELBASE	0x2000000
+
 /* How many bytes to reserve at zero for kdump. The reserve limit should
- * be greater or equal to the trampoline's end address. */
+ * be greater or equal to the trampoline's end address.
+ * Reserve to the end of the FWNMI area, see head_64.S */
 #define KDUMP_RESERVE_LIMIT	0x8000
 
+#ifdef CONFIG_CRASH_DUMP
+
+#define PHYSICAL_START	KDUMP_KERNELBASE
 #define KDUMP_TRAMPOLINE_START	0x0100
 #define KDUMP_TRAMPOLINE_END	0x3000
 
-extern void kdump_setup(void);
+#else /* !CONFIG_CRASH_DUMP */
+
+#define PHYSICAL_START	0x0
+
+#endif /* CONFIG_CRASH_DUMP */
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_CRASH_DUMP
+
+extern void reserve_kdump_trampoline(void);
+extern void setup_kdump_trampoline(void);
+
+#else /* !CONFIG_CRASH_DUMP */
+
+static inline void reserve_kdump_trampoline(void) { ; }
+static inline void setup_kdump_trampoline(void) { ; }
+
+#endif /* CONFIG_CRASH_DUMP */
+#endif /* __ASSEMBLY__ */
 
 #endif /* __PPC64_KDUMP_H */
Index: to-merge/include/asm-powerpc/page.h
===================================================================
--- to-merge.orig/include/asm-powerpc/page.h
+++ to-merge/include/asm-powerpc/page.h
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 #include <linux/config.h>
 #include <asm/asm-compat.h>
+#include <asm/kdump.h>
 
 /*
  * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
@@ -52,13 +53,6 @@
  * If you want to test if something's a kernel address, use is_kernel_addr().
  */
 
-#ifdef CONFIG_CRASH_DUMP
-/* Kdump kernel runs at 32 MB, change at your peril. */
-#define PHYSICAL_START	0x2000000
-#else
-#define PHYSICAL_START	0x0
-#endif
-
 #define PAGE_OFFSET     ASM_CONST(CONFIG_KERNEL_START)
 #define KERNELBASE      (PAGE_OFFSET + PHYSICAL_START)
 
