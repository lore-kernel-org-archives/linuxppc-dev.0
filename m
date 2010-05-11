Return-Path: <anton@ozlabs.org>
Date: Tue, 11 May 2010 14:59:18 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, mikey@neuling.org, miltonm@bga.com
Subject: [PATCH] powerpc: Use more accurate limit for first segment memory
	allocations
Message-ID: <20100511045918.GA13509@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Author: Milton Miller <miltonm@bga.com>

On large machines we are running out of room below 256MB. In some cases we
only need to ensure the allocation is in the first segment, which may be
256MB or 1TB.

Add slb0_limit and use it to specify the upper limit for the irqstack and
emergency stacks.

On a large ppc64 box, this fixes a panic at boot when the crashkernel=
option is specified (previously we would run out of memory below 256MB).

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Some things we should add:

- Specify a more intelligent limit for BookE
- The allocation of the PACAs should use this limit too

Index: linux-2.6/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup_64.c	2010-04-22 17:23:42.000000000 +1000
+++ linux-2.6/arch/powerpc/kernel/setup_64.c	2010-04-30 09:46:15.000000000 +1000
@@ -424,9 +424,18 @@ void __init setup_system(void)
 	DBG(" <- setup_system()\n");
 }
 
+static u64 slb0_limit(void)
+{
+	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
+		return 1UL << SID_SHIFT_1T;
+	}
+	return 1UL << SID_SHIFT;
+}
+
 #ifdef CONFIG_IRQSTACKS
 static void __init irqstack_early_init(void)
 {
+	u64 limit = slb0_limit();
 	unsigned int i;
 
 	/*
@@ -436,10 +445,10 @@ static void __init irqstack_early_init(v
 	for_each_possible_cpu(i) {
 		softirq_ctx[i] = (struct thread_info *)
 			__va(lmb_alloc_base(THREAD_SIZE,
-					    THREAD_SIZE, 0x10000000));
+					    THREAD_SIZE, limit));
 		hardirq_ctx[i] = (struct thread_info *)
 			__va(lmb_alloc_base(THREAD_SIZE,
-					    THREAD_SIZE, 0x10000000));
+					    THREAD_SIZE, limit));
 	}
 }
 #else
@@ -470,7 +479,7 @@ static void __init exc_lvl_early_init(vo
  */
 static void __init emergency_stack_init(void)
 {
-	unsigned long limit;
+	u64 limit;
 	unsigned int i;
 
 	/*
@@ -482,7 +491,7 @@ static void __init emergency_stack_init(
 	 * bringup, we need to get at them in real mode. This means they
 	 * must also be within the RMO region.
 	 */
-	limit = min(0x10000000ULL, lmb.rmo_size);
+	limit = min(slb0_limit(), lmb.rmo_size);
 
 	for_each_possible_cpu(i) {
 		unsigned long sp;
