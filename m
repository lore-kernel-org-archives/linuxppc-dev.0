Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 64DDA100F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:47:13 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <0f031f5a6fe1028e5c4604eab0d16372ee8c0a07.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:37 -0500
Subject: [PATCH 02/37] powerpc: don't search for paca in freed memory
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Starting with 1426d5a3bd07589534286375998c0c8c6fdc5260 (powerpc:
Dynamically allocate pacas) we free the memory for pacas beyond
cpu_possible, but we failed to update the loop the secondary cpus use
to find their paca.  If the system has running cpu threads for which
the kernel did not allocate a paca for they will search the memory that
was freed.  For instance this could happen when the device tree for
a kdump kernel was not updated after a cpu hotplug, or the kernel is
running with more cpus than the kernel was configured.

Since c1854e00727f50f7ac99e98d26ece04c087ef785 (powerpc: Set nr_cpu_ids
early and use it to free PACAs) we set nr_cpu_ids before telling the
cpus to advance, so use that to limit the search.

We can't reference nr_cpu_ids without CONFIG_SMP because it is defined
as 1 instead of a memory location, but any extra threads should be sent
to kexec_wait in that case anyways, so make that explicit and remove
the search loop for UP.

Note to stable: The fix also requires
c1854e00727f50f7ac99e98d26ece04c087ef785 (powerpc: Set
nr_cpu_ids early and use it to free PACAs) to function.  Also
9d07bc841c9779b4d7902e417f4e509996ce805d (Properly handshake CPUs going
out of boot spin loop) affects the second chunk, specifically the branch
target was 3b before and is 4b after that patch, and there was a blank
line before the #ifdef CONFIG_SMP that was removed

Cc: <stable@kernel.org> # .34.x: c1854e0072 powerpc: Set nr_cpu_ids early
Cc: <stable@kernel.org> # .34.x
Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/kernel/head_64.S |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 73d6e9a..ba50409 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -218,13 +218,19 @@ generic_secondary_common_init:
 	 */
 	LOAD_REG_ADDR(r13, paca)	/* Load paca pointer		 */
 	ld	r13,0(r13)		/* Get base vaddr of paca array	 */
+#ifndef CONFIG_SMP
+	addi	r13,r13,PACA_SIZE	/* know r13 if used accidentally */
+	b	.kexec_wait		/* wait for next kernel if !SMP	 */
+#else
+	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
+	lwz	r7,0(r7)		/* also the max paca allocated 	 */
 	li	r5,0			/* logical cpu id                */
 1:	lhz	r6,PACAHWCPUID(r13)	/* Load HW procid from paca      */
 	cmpw	r6,r24			/* Compare to our id             */
 	beq	2f
 	addi	r13,r13,PACA_SIZE	/* Loop to next PACA on miss     */
 	addi	r5,r5,1
-	cmpwi	r5,NR_CPUS
+	cmpw	r5,r7			/* Check if more pacas exist     */
 	blt	1b
 
 	mr	r3,r24			/* not found, copy phys to r3	 */
@@ -259,9 +265,6 @@ generic_secondary_common_init:
 4:	HMT_LOW
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
 					/* start.			 */
-#ifndef CONFIG_SMP
-	b	4b			/* Never go on non-SMP		 */
-#else
 	cmpwi	0,r23,0
 	beq	4b			/* Loop until told to go	 */
 
@@ -273,7 +276,7 @@ generic_secondary_common_init:
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
 	b	__secondary_start
-#endif
+#endif /* SMP */
 
 /*
  * Turn the MMU off.
-- 
1.7.0.4
