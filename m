Return-Path: <mohan@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D707DDEE7
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 22:49:03 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8UCmxNf017362
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 08:48:59 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8UCmxSE219708
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:48:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8UCmTdq014071
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:48:30 -0600
Date: Tue, 30 Sep 2008 18:18:28 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: paulus@samba.org
Subject: [PATCH] Remove legacy kdump kernel build support
Message-ID: <20080930124828.GA1945@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Remove legacy kdump kernel build support

This patch removes legacy kdump kernel build support(i.e compiling  a
kdump kernel at a fixed hardcoded address 32MB). With the relocatable
kernel support its now possible to use the regular kernel binary for
capturing the dump also. Relocatable kdump kernel does not require
trampoline code for exception handlers. It removes kdump.h as most of the
macros defined in kdump.h are not used any more. Also the relocatable
kdump kernel allows us to load kdump kernel any where as specified by
crashkernel parameter instead of hardcoded address 32MB.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/Kconfig                |    2 -
 arch/powerpc/include/asm/iommu.h    |    5 ++++
 arch/powerpc/include/asm/kdump.h    |   35 ------------------------------
 arch/powerpc/include/asm/page.h     |    1 -
 arch/powerpc/kernel/crash.c         |    1 -
 arch/powerpc/kernel/crash_dump.c    |   40 -----------------------------------
 arch/powerpc/kernel/iommu.c         |    1 -
 arch/powerpc/kernel/machine_kexec.c |    5 ----
 arch/powerpc/kernel/prom.c          |    2 -
 arch/powerpc/kernel/setup_64.c      |    3 --
 10 files changed, 5 insertions(+), 90 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/kdump.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 17c988b..cad6035 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
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
 
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 51ecfef..1ee9b12 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -35,6 +35,11 @@
 #define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
 #define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
 
+#ifdef CONFIG_CRASH_DUMP
+#define KDUMP_MIN_TCE_ENTRIES	2048
+extern unsigned long long __kdump_flag;
+#endif
+
 /* Boot time flags */
 extern int iommu_is_off;
 extern int iommu_force_on;
diff --git a/arch/powerpc/include/asm/kdump.h b/arch/powerpc/include/asm/kdump.h
deleted file mode 100644
index f6c93c7..0000000
--- a/arch/powerpc/include/asm/kdump.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef _PPC64_KDUMP_H
-#define _PPC64_KDUMP_H
-
-/* Kdump kernel runs at 32 MB, change at your peril. */
-#define KDUMP_KERNELBASE	0x2000000
-
-/* How many bytes to reserve at zero for kdump. The reserve limit should
- * be greater or equal to the trampoline's end address.
- * Reserve to the end of the FWNMI area, see head_64.S */
-#define KDUMP_RESERVE_LIMIT	0x10000 /* 64K */
-
-#ifdef CONFIG_CRASH_DUMP
-
-#define KDUMP_TRAMPOLINE_START	0x0100
-#define KDUMP_TRAMPOLINE_END	0x3000
-
-#define KDUMP_MIN_TCE_ENTRIES	2048
-
-#endif /* CONFIG_CRASH_DUMP */
-
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_CRASH_DUMP
-
-extern void reserve_kdump_trampoline(void);
-extern void setup_kdump_trampoline(void);
-
-#else /* !CONFIG_CRASH_DUMP */
-
-static inline void reserve_kdump_trampoline(void) { ; }
-static inline void setup_kdump_trampoline(void) { ; }
-
-#endif /* CONFIG_CRASH_DUMP */
-#endif /* __ASSEMBLY__ */
-
-#endif /* __PPC64_KDUMP_H */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 64e1445..00dedf1 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -11,7 +11,6 @@
  */
 
 #include <asm/asm-compat.h>
-#include <asm/kdump.h>
 #include <asm/types.h>
 
 /*
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 0a8439a..4a89934 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -29,7 +29,6 @@
 #include <asm/processor.h>
 #include <asm/machdep.h>
 #include <asm/kexec.h>
-#include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/firmware.h>
 #include <asm/smp.h>
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index a323c9b..7d3134c 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -15,7 +15,6 @@
 #include <linux/bootmem.h>
 #include <linux/lmb.h>
 #include <asm/code-patching.h>
-#include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/firmware.h>
 #include <asm/uaccess.h>
@@ -27,45 +26,6 @@
 #define DBG(fmt...)
 #endif
 
-void __init reserve_kdump_trampoline(void)
-{
-	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
-}
-
-static void __init create_trampoline(unsigned long addr)
-{
-	unsigned int *p = (unsigned int *)addr;
-
-	/* The maximum range of a single instruction branch, is the current
-	 * instruction's address + (32 MB - 4) bytes. For the trampoline we
-	 * need to branch to current address + 32 MB. So we insert a nop at
-	 * the trampoline address, then the next instruction (+ 4 bytes)
-	 * does a branch to (32 MB - 4). The net effect is that when we
-	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
-	 * two instructions it doesn't require any registers.
-	 */
-	patch_instruction(p, PPC_NOP_INSTR);
-	patch_branch(++p, addr + PHYSICAL_START, 0);
-}
-
-void __init setup_kdump_trampoline(void)
-{
-	unsigned long i;
-
-	DBG(" -> setup_kdump_trampoline()\n");
-
-	for (i = KDUMP_TRAMPOLINE_START; i < KDUMP_TRAMPOLINE_END; i += 8) {
-		create_trampoline(i);
-	}
-
-#ifdef CONFIG_PPC_PSERIES
-	create_trampoline(__pa(system_reset_fwnmi) - PHYSICAL_START);
-	create_trampoline(__pa(machine_check_fwnmi) - PHYSICAL_START);
-#endif /* CONFIG_PPC_PSERIES */
-
-	DBG(" <- setup_kdump_trampoline()\n");
-}
-
 #ifdef CONFIG_PROC_VMCORE
 static int __init parse_elfcorehdr(char *p)
 {
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 550a193..6724820 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -37,7 +37,6 @@
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
-#include <asm/kdump.h>
 
 #define DBG(...)
 
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index aab7688..8b303fd 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -88,11 +88,6 @@ void __init reserve_crashkernel(void)
 
 	crash_size = crashk_res.end - crashk_res.start + 1;
 
-	if (crashk_res.start != KDUMP_KERNELBASE)
-		printk("Crash kernel location must be 0x%x\n",
-				KDUMP_KERNELBASE);
-
-	crashk_res.start = KDUMP_KERNELBASE;
 	crash_size = PAGE_ALIGN(crash_size);
 	crashk_res.end = crashk_res.start + crash_size - 1;
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 3a2dc7e..014a6d5 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -39,7 +39,6 @@
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/kdump.h>
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/mmu.h>
@@ -1195,7 +1194,6 @@ void __init early_init_devtree(void *params)
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
 	if (PHYSICAL_START > MEMORY_START)
 		lmb_reserve(MEMORY_START, 0x8000);
-	reserve_kdump_trampoline();
 	reserve_crashkernel();
 	early_reserve_mem();
 	phyp_dump_reserve_mem();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 843c0af..5ea4fe5 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -36,7 +36,6 @@
 #include <linux/lockdep.h>
 #include <linux/lmb.h>
 #include <asm/io.h>
-#include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
 #include <asm/pgtable.h>
@@ -209,8 +208,6 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Probe the machine type */
 	probe_machine();
 
-	setup_kdump_trampoline();
-
 	DBG("Found, Initializing memory management...\n");
 
 	/*
-- 
1.5.5.1
