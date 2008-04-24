Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 80345DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 13:43:51 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <6bbf4d3637c9b72f9f0a4cf8a6f2c322c0784d7e.1209008469.git.tony@bakeyournoodle.com>
In-Reply-To: <b863aa7fba7b2b00cb72d327fdd7a04b6cb81106.1209008469.git.tony@bakeyournoodle.com>
References: <b863aa7fba7b2b00cb72d327fdd7a04b6cb81106.1209008469.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/2] Raise the upper limit of NR_CPUS and move the pacas into
	the BSS.
Date: Thu, 24 Apr 2008 13:43:49 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the required functionality to fill in all pacas at runtime.

With NR_CPUS=1024
text    data     bss     dec     hex filename
 137 1704032       0 1704169  1a00e9 arch/powerpc/kernel/paca.o :Before
 121 1179744  524288 1704153  1a00d9 arch/powerpc/kernel/paca.o :After

Also remove unneeded #includes from arch/powerpc/kernel/paca.c

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Now merged, with patch 1 fomr previous series.

 arch/powerpc/kernel/paca.c             |   87 +++++++++----------------------
 arch/powerpc/kernel/setup_64.c         |    3 +
 arch/powerpc/platforms/Kconfig.cputype |    4 +-
 include/asm-powerpc/paca.h             |    1 +
 4 files changed, 31 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index ac163bd..c9bf17e 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -7,17 +7,11 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <linux/types.h>
 #include <linux/threads.h>
 #include <linux/module.h>
 
-#include <asm/processor.h>
-#include <asm/ptrace.h>
-#include <asm/page.h>
 #include <asm/lppaca.h>
 #include <asm/paca.h>
-#include <asm/mmu.h>
-
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
@@ -65,60 +59,29 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
  * processors.  The processor VPD array needs one entry per physical
  * processor (not thread).
  */
-#define PACA_INIT(number)						    \
-{									    \
-	.lppaca_ptr = &lppaca[number],					    \
-	.lock_token = 0x8000,						    \
-	.paca_index = (number),		/* Paca Index */		    \
-	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
-	.hw_cpu_id = 0xffff,						    \
-	.slb_shadow_ptr = &slb_shadow[number],				    \
-	.__current = &init_task,					    \
-}
-
-struct paca_struct paca[] = {
-	PACA_INIT(0),
-#if NR_CPUS > 1
-	PACA_INIT(  1), PACA_INIT(  2), PACA_INIT(  3),
-#if NR_CPUS > 4
-	PACA_INIT(  4), PACA_INIT(  5), PACA_INIT(  6), PACA_INIT(  7),
-#if NR_CPUS > 8
-	PACA_INIT(  8), PACA_INIT(  9), PACA_INIT( 10), PACA_INIT( 11),
-	PACA_INIT( 12), PACA_INIT( 13), PACA_INIT( 14), PACA_INIT( 15),
-	PACA_INIT( 16), PACA_INIT( 17), PACA_INIT( 18), PACA_INIT( 19),
-	PACA_INIT( 20), PACA_INIT( 21), PACA_INIT( 22), PACA_INIT( 23),
-	PACA_INIT( 24), PACA_INIT( 25), PACA_INIT( 26), PACA_INIT( 27),
-	PACA_INIT( 28), PACA_INIT( 29), PACA_INIT( 30), PACA_INIT( 31),
-#if NR_CPUS > 32
-	PACA_INIT( 32), PACA_INIT( 33), PACA_INIT( 34), PACA_INIT( 35),
-	PACA_INIT( 36), PACA_INIT( 37), PACA_INIT( 38), PACA_INIT( 39),
-	PACA_INIT( 40), PACA_INIT( 41), PACA_INIT( 42), PACA_INIT( 43),
-	PACA_INIT( 44), PACA_INIT( 45), PACA_INIT( 46), PACA_INIT( 47),
-	PACA_INIT( 48), PACA_INIT( 49), PACA_INIT( 50), PACA_INIT( 51),
-	PACA_INIT( 52), PACA_INIT( 53), PACA_INIT( 54), PACA_INIT( 55),
-	PACA_INIT( 56), PACA_INIT( 57), PACA_INIT( 58), PACA_INIT( 59),
-	PACA_INIT( 60), PACA_INIT( 61), PACA_INIT( 62), PACA_INIT( 63),
-#if NR_CPUS > 64
-	PACA_INIT( 64), PACA_INIT( 65), PACA_INIT( 66), PACA_INIT( 67),
-	PACA_INIT( 68), PACA_INIT( 69), PACA_INIT( 70), PACA_INIT( 71),
-	PACA_INIT( 72), PACA_INIT( 73), PACA_INIT( 74), PACA_INIT( 75),
-	PACA_INIT( 76), PACA_INIT( 77), PACA_INIT( 78), PACA_INIT( 79),
-	PACA_INIT( 80), PACA_INIT( 81), PACA_INIT( 82), PACA_INIT( 83),
-	PACA_INIT( 84), PACA_INIT( 85), PACA_INIT( 86), PACA_INIT( 87),
-	PACA_INIT( 88), PACA_INIT( 89), PACA_INIT( 90), PACA_INIT( 91),
-	PACA_INIT( 92), PACA_INIT( 93), PACA_INIT( 94), PACA_INIT( 95),
-	PACA_INIT( 96), PACA_INIT( 97), PACA_INIT( 98), PACA_INIT( 99),
-	PACA_INIT(100), PACA_INIT(101), PACA_INIT(102), PACA_INIT(103),
-	PACA_INIT(104), PACA_INIT(105), PACA_INIT(106), PACA_INIT(107),
-	PACA_INIT(108), PACA_INIT(109), PACA_INIT(110), PACA_INIT(111),
-	PACA_INIT(112), PACA_INIT(113), PACA_INIT(114), PACA_INIT(115),
-	PACA_INIT(116), PACA_INIT(117), PACA_INIT(118), PACA_INIT(119),
-	PACA_INIT(120), PACA_INIT(121), PACA_INIT(122), PACA_INIT(123),
-	PACA_INIT(124), PACA_INIT(125), PACA_INIT(126), PACA_INIT(127),
-#endif
-#endif
-#endif
-#endif
-#endif
-};
+struct paca_struct paca[NR_CPUS];
 EXPORT_SYMBOL(paca);
+
+void __init initialise_pacas(void)
+{
+	int cpu;
+
+	/* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
+	 * of the TOC can be addressed using a single machine instruction.
+	 */
+	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
+
+	/* Can't use for_each_*_cpu, as they aren't functional yet */
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		struct paca_struct *new_paca = &paca[cpu];
+
+		new_paca->lppaca_ptr = &lppaca[cpu];
+		new_paca->lock_token = 0x8000;
+		new_paca->paca_index = cpu;
+		new_paca->kernel_toc = kernel_toc;
+		new_paca->hw_cpu_id = 0xffff;
+		new_paca->slb_shadow_ptr = &slb_shadow[cpu];
+		new_paca->__current = &init_task;
+
+	}
+}
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 31ada9f..5e382ac 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -170,6 +170,9 @@ void __init setup_paca(int cpu)
 
 void __init early_setup(unsigned long dt_ptr)
 {
+	/* Fill in any unititialised pacas */
+	initialise_pacas();
+
 	/* Identify CPU type */
 	identify_cpu(0, mfspr(SPRN_PVR));
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5fc7fac..f7efaa9 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -220,8 +220,8 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-128)"
-	range 2 128
+	int "Maximum number of CPUs (2-1024)"
+	range 2 1024
 	depends on SMP
 	default "32" if PPC64
 	default "4"
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index eb61b9c..7b56444 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -108,6 +108,7 @@ struct paca_struct {
 };
 
 extern struct paca_struct paca[];
+extern void initialise_pacas(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PACA_H */
-- 
1.5.5.1
