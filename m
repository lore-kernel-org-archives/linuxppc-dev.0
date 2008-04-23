Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 44643DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 13:44:18 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <ace554946afc94d0b62634b3c5dedeaa5a49f0da.1208921988.git.tony@bakeyournoodle.com>
In-Reply-To: <d54206d25b690c9160401f65a583f586004dcd5d.1208921988.git.tony@bakeyournoodle.com>
References: <d54206d25b690c9160401f65a583f586004dcd5d.1208921988.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/2] Make iSeries spin on __secondary_hold_spinloop,
	like pSeries.
Date: Wed, 23 Apr 2008 13:44:16 +1000 (EST)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently all iSeries secondary CPU's spin directly on the cpu_start in thier
paca.  Make them spin on the global __secondary_hold_spinloop, until after the
pacas have been initialised.

As sfr points out this works because __secondary_hold_spinloop is being set
already, but iSeries isn't looking at it :)

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
Changes since v1:
 - Updated commit message.

 arch/powerpc/kernel/paca.c                 |   64 ++--------------------------
 arch/powerpc/platforms/iseries/exception.S |   27 +++++++++++-
 include/asm-powerpc/paca.h                 |   17 -------
 3 files changed, 30 insertions(+), 78 deletions(-)

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
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index c775cd4..8ff330d 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -59,8 +59,33 @@ system_reset_iSeries:
 	andc	r4,r4,r5
 	mtspr	SPRN_CTRLT,r4
 
+/* Spin on __secondary_hold_spinloop until it is updated by the boot cpu. */
+/* In the UP case we'll yeild() later, and we will not access the paca anyway */
+#ifdef CONFIG_SMP
 1:
 	HMT_LOW
+	LOAD_REG_IMMEDIATE(r23, __secondary_hold_spinloop)
+	ld	r23,0(r23)
+	sync
+	LOAD_REG_IMMEDIATE(r3,current_set)
+	sldi	r28,r24,3		/* get current_set[cpu#] */
+	ldx	r3,r3,r28
+	addi	r1,r3,THREAD_SIZE
+	subi	r1,r1,STACK_FRAME_OVERHEAD
+
+	cmpwi	0,r23,0			/* Keep poking the Hypervisor until */
+	bne	2f			/* we're released */
+	/* Let the Hypervisor know we are alive */
+	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
+	lis	r3,0x8002
+	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
+	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
+	sc				/* Invoke the hypervisor via a system call */
+	b	1b
+#endif
+
+2:
+	HMT_LOW
 #ifdef CONFIG_SMP
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
 					 * should start */
@@ -91,7 +116,7 @@ iSeries_secondary_smp_loop:
 	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
 	sc				/* Invoke the hypervisor via a system call */
 	mfspr	r13,SPRN_SPRG3		/* Put r13 back ???? */
-	b	1b			/* If SMP not configured, secondaries
+	b	2b			/* If SMP not configured, secondaries
 					 * loop forever */
 
 /***  ISeries-LPAR interrupt handlers ***/
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
