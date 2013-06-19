Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96E242C03B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:21:16 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc: make the kernel bootable from non 0 address for
 6xx
Date: Wed, 19 Jun 2013 17:20:04 +0800
Message-ID: <1371633604-4491-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
References: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the support to boot the kernel from a non 0 address for 6xx.
Setup the exception trampoline if the physical start address is
not 0.

For a kdump kernel, enable the relocatable support implicitly.
Since the memstart_adddr of the kdump is not 0, we definitely
should regard this when setting up the BAT map.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig                            |  2 +-
 arch/powerpc/include/asm/exception_trampoline.h |  4 ++--
 arch/powerpc/kernel/Makefile                    |  3 ++-
 arch/powerpc/kernel/exception_trampoline.c      | 18 +++++++++++++++---
 arch/powerpc/mm/ppc_mmu_32.c                    |  7 +------
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8fe2792..6e03028 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -382,7 +382,7 @@ config KEXEC
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
-	select RELOCATABLE if PPC64 || 44x
+	select RELOCATABLE if PPC64 || 44x || 6xx
 	select DYNAMIC_MEMSTART if FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
diff --git a/arch/powerpc/include/asm/exception_trampoline.h b/arch/powerpc/include/asm/exception_trampoline.h
index 88281c9..df4af6a 100644
--- a/arch/powerpc/include/asm/exception_trampoline.h
+++ b/arch/powerpc/include/asm/exception_trampoline.h
@@ -22,11 +22,11 @@
 
 #ifndef __ASSEMBLY__
 
-#if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_NONSTATIC_KERNEL)
+#if  defined(CONFIG_RELOCATABLE) && defined(CONFIG_6xx)
 extern void reserve_exception_trampoline(void);
 extern void setup_exception_trampoline(void);
 #else
-/* !CRASH_DUMP || !NONSTATIC_KERNEL */
+/* !CONFIG_RELOCATABLE || !CONFIG_6xx */
 static inline void reserve_exception_trampoline(void) { ; }
 static inline void setup_exception_trampoline(void) { ; }
 #endif
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c73a0e3..c722156 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -59,7 +59,8 @@ obj-$(CONFIG_LPARCFG)		+= lparcfg.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
-obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o exception_trampoline.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+obj-$(CONFIG_RELOCATABLE)	+= exception_trampoline.o
 obj-$(CONFIG_FA_DUMP)		+= fadump.o
 ifeq ($(CONFIG_PPC32),y)
 obj-$(CONFIG_E500)		+= idle_e500.o
diff --git a/arch/powerpc/kernel/exception_trampoline.c b/arch/powerpc/kernel/exception_trampoline.c
index b725116..68aed9e 100644
--- a/arch/powerpc/kernel/exception_trampoline.c
+++ b/arch/powerpc/kernel/exception_trampoline.c
@@ -28,10 +28,16 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_NONSTATIC_KERNEL
+#ifdef CONFIG_6xx
 void __init reserve_exception_trampoline(void)
 {
-	memblock_reserve(0, EXCEPTION_RESERVE_LIMIT);
+	/*
+	 * We don't need to reserve this memory region for a kdump kernel
+	 * since this is not included in the memory regions of kdump kernel.
+	 */
+
+	if (!memstart_addr && PHYSICAL_START)
+		memblock_reserve(0, EXCEPTION_RESERVE_LIMIT);
 }
 
 static void __init create_trampoline(unsigned long addr)
@@ -54,6 +60,12 @@ void __init setup_exception_trampoline(void)
 {
 	unsigned long i;
 
+	if (!PHYSICAL_START)
+		return;
+
+	if (PHYSICAL_START > 0x2000000)
+		panic("Don't support to load a kernel above 32M address");
+
 	DBG(" -> setup_exception_trampoline()\n");
 
 	for (i = EXCEPTION_TRAMPOLINE_START; i < EXCEPTION_TRAMPOLINE_END; i += 8) {
@@ -67,4 +79,4 @@ void __init setup_exception_trampoline(void)
 
 	DBG(" <- setup_exception_trampoline()\n");
 }
-#endif /* CONFIG_NONSTATIC_KERNEL */
+#endif /* CONFIG_6xx */
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 11571e1..99ce477 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -86,7 +86,7 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 
 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
-	tot = top;
+	tot = top + memstart_addr;
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > tot)
 			break;
@@ -275,11 +275,6 @@ void __init MMU_init_hw(void)
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
-	/* We don't currently support the first MEMBLOCK not mapping 0
-	 * physical on those processors
-	 */
-	BUG_ON(first_memblock_base != 0);
-
 	/* 601 can only access 16MB at the moment */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
 		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01000000));
-- 
1.8.1.4
