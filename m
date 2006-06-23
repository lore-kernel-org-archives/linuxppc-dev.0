Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:10 +1000
Subject: [PATCH 2/8] Assume we're on cpu 0 in early boot
Message-Id: <20060623082007.34A9867A79@ozlabs.org>
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

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/head_64.S |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: to-merge/arch/powerpc/kernel/head_64.S
===================================================================
--- to-merge.orig/arch/powerpc/kernel/head_64.S
+++ to-merge/arch/powerpc/kernel/head_64.S
@@ -1583,9 +1583,6 @@ _GLOBAL(__start_initialization_multiplat
 	/* Setup some critical 970 SPRs before switching MMU off */
 	bl	.__970_cpu_preinit
 
-	/* cpu # */
-	li	r24,0
-
 	/* Switch off MMU if not already */
 	LOAD_REG_IMMEDIATE(r4, .__after_prom_start - KERNELBASE)
 	add	r4,r4,r30
@@ -1908,6 +1905,13 @@ _STATIC(start_here_multiplatform)
 	bl	.__save_cpu_setup
 	sync
 
+	/* Assume we're on cpu for now, we don't actually know yet.
+	 * The early setup code should not write to any paca fields until
+	 * after we've setup the correct paca. See early_setup() */
+	li	r24,0
+	li	r3,0
+	bl	.setup_paca
+
 	/* Do very early kernel initializations, including initial hash table,
 	 * stab and slb setup before we turn on relocation.	*/
 
