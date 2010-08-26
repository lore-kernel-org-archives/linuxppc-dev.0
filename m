Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: don't use kernel stack with translation off
Date: Thu, 26 Aug 2010 17:04:25 +1000
Message-ID: <6401.1282806265@neuling.org>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In f761622e59433130bc33ad086ce219feee9eb961 we changed
early_setup_secondary so it's called using the proper kernel stack
rather than the emergency one.

Unfortunately, this stack pointer can't be used when translation is off
on PHYP as this stack pointer might be outside the RMO.  This results in
the following on all non zero cpus:
  cpu 0x1: Vector: 300 (Data Access) at [c00000001639fd10]
      pc: 000000000001c50c
      lr: 000000000000821c
      sp: c00000001639ff90
     msr: 8000000000001000
     dar: c00000001639ffa0
   dsisr: 42000000
    current = 0xc000000016393540
    paca    = 0xc000000006e00200
      pid   = 0, comm = swapper

The original patch was only tested on bare metal system, so it never
caught this problem.

This changes __secondary_start so that we calculate the new stack
pointer but only start using it after we've called early_setup_secondary.

With this patch, the above problem goes away.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
benh: can you pick this up for 2.6.36 as we are bust currently in Linus' tree.

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4d6681d..c571cd3 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -575,13 +575,19 @@ __secondary_start:
 	/* Initialize the kernel stack.  Just a repeat for iSeries.	 */
 	LOAD_REG_ADDR(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
-	ldx	r1,r3,r28
-	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
-	std	r1,PACAKSAVE(r13)
+	ldx	r14,r3,r28
+	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
+	std	r14,PACAKSAVE(r13)
 
 	/* Do early setup for that CPU (stab, slb, hash table pointer) */
 	bl	.early_setup_secondary
 
+	/*
+	 * setup the new stack pointer, but *don't* use this until
+	 * translation is on.
+	 */
+	mr	r1, r14
+
 	/* Clear backchain so we get nice backtraces */
 	li	r7,0
 	mtlr	r7
