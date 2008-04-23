Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id A574ADDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 14:06:15 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <f3edd0f54afbbc66213d825fb0f88765aaa7c450.1208923391.git.tony@bakeyournoodle.com>
In-Reply-To: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
References: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 3/3 v3] Move the paca array into the BSS.
Date: Wed, 23 Apr 2008 14:06:14 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With NR_CPUS=1024
text    data     bss     dec     hex filename
 137 1704032       0 1704169  1a00e9 arch/powerpc/kernel/paca.o :Before
 121 1179744  524288 1704153  1a00d9 arch/powerpc/kernel/paca.o :After

Now that we're not statically allocating the paca, we don't need the
NR_STATIC_PACAS #define anymore.

Also remove unneeded #includes.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Changes since v1:
 - none
Changes since v2:
 - none

 arch/powerpc/kernel/paca.c |   64 +++-----------------------------------------
 include/asm-powerpc/paca.h |   17 -----------
 2 files changed, 4 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 4c7db2e..c9bf17e 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -7,26 +7,11 @@
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
-/*
- * In order to handle "strange" values of NR_CPUS, Make sure we use
- * max(NR_CPUS, NR_STATIC_PACAS) for array sizes below
- */
-#if NR_CPUS > NR_STATIC_PACAS
-#define MAX_CPUS	NR_CPUS
-#else
-#define MAX_CPUS	NR_STATIC_PACAS
-#endif
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
@@ -42,7 +27,7 @@ extern unsigned long __toc_start;
  * will suffice to ensure that it doesn't cross a page boundary.
  */
 struct lppaca lppaca[] = {
-	[0 ... (MAX_CPUS-1)] = {
+	[0 ... (NR_CPUS-1)] = {
 		.desc = 0xd397d781,	/* "LpPa" */
 		.size = sizeof(struct lppaca),
 		.dyn_proc_status = 2,
@@ -59,7 +44,7 @@ struct lppaca lppaca[] = {
  * initially, hence will all be invaild until we actually write them.
  */
 struct slb_shadow slb_shadow[] __cacheline_aligned = {
-	[0 ... (MAX_CPUS-1)] = {
+	[0 ... (NR_CPUS-1)] = {
 		.persistent = SLB_NUM_BOLTED,
 		.buffer_length = sizeof(struct slb_shadow),
 	},
@@ -74,50 +59,9 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
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
-struct paca_struct paca[MAX_CPUS] = {
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
-#endif
-#endif
-#endif
-#endif
-};
+struct paca_struct paca[NR_CPUS];
 EXPORT_SYMBOL(paca);
 
-/*
- * The first few (NR_STATIC_PACAS) paca entires are initiialised
- * statically. populate the rest.
- */
 void __init initialise_pacas(void)
 {
 	int cpu;
@@ -128,7 +72,7 @@ void __init initialise_pacas(void)
 	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
 
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = NR_STATIC_PACAS; cpu < NR_CPUS; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		struct paca_struct *new_paca = &paca[cpu];
 
 		new_paca->lppaca_ptr = &lppaca[cpu];
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 2a05cc0..0bfc180 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -22,23 +22,6 @@
 #include	<asm/lppaca.h>
 #include	<asm/mmu.h>
 
-/*
- * iSeries needs the paca to be statically allocated and initialised.
- * We will allocated this many, based on NR_CPUS.
- */
-#if   NR_CPUS > 32
-#define NR_STATIC_PACAS	64
-#elif NR_CPUS > 8
-#define NR_STATIC_PACAS	32
-#elif NR_CPUS > 4
-#define NR_STATIC_PACAS	8
-#elif NR_CPUS > 1
-#define NR_STATIC_PACAS	4
-#else
-#define NR_STATIC_PACAS	1
-#endif
-
-
 register struct paca_struct *local_paca asm("r13");
 
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
-- 
1.5.5.1
