Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 28 Jun 2006 13:18:53 +1000
Subject: [PATCH] Assume we're on cpu 0 in early boot
In-Reply-To: <17569.56937.308576.848377@cargo.ozlabs.ibm.com>
Message-Id: <20060628031852.5CC1967A65@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a small period early in boot where we don't know which cpu we're
running on. That's ok, except that it means we have no paca, or more
correctly that our paca pointer points somewhere random.

So that we can safely call things like smp_processor_id(), we need a paca,
so just assume we're on cpu 0. No code should _write_ to the paca before
we've set the correct one up.

We setup the proper paca after we've scanned the flat device tree in
early_setup(), so there's no need to do it again in start_here_common.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/head_64.S  |   11 -----------
 arch/powerpc/kernel/setup_64.c |    3 +++
 2 files changed, 3 insertions(+), 11 deletions(-)

Index: to-merge/arch/powerpc/kernel/head_64.S
===================================================================
--- to-merge.orig/arch/powerpc/kernel/head_64.S
+++ to-merge/arch/powerpc/kernel/head_64.S
@@ -1602,9 +1602,6 @@ _GLOBAL(__start_initialization_multiplat
 	/* Setup some critical 970 SPRs before switching MMU off */
 	bl	.__970_cpu_preinit
 
-	/* cpu # */
-	li	r24,0
-
 	/* Switch off MMU if not already */
 	LOAD_REG_IMMEDIATE(r4, .__after_prom_start - KERNELBASE)
 	add	r4,r4,r30
@@ -1962,14 +1959,6 @@ _STATIC(start_here_common)
 	li	r3,0
 	bl	.do_cpu_ftr_fixups
 
-	LOAD_REG_IMMEDIATE(r26, boot_cpuid)
-	lwz	r26,0(r26)
-
-	LOAD_REG_IMMEDIATE(r24, paca)	/* Get base vaddr of paca array  */
-	mulli	r13,r26,PACA_SIZE	/* Calculate vaddr of right paca */
-	add	r13,r13,r24		/* for this processor.		 */
-	mtspr	SPRN_SPRG3,r13
-
 	/* ptr to current */
 	LOAD_REG_IMMEDIATE(r4, init_task)
 	std	r4,PACACURRENT(r13)
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -177,6 +177,9 @@ void __init setup_paca(int cpu)
 
 void __init early_setup(unsigned long dt_ptr)
 {
+	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
+	setup_paca(0);
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
