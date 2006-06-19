Return-Path: <arnd@arndb.de>
Message-Id: <20060619183406.169490000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:30 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 15/20] spufs: fix spu irq affinity setting
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>

This changes the hypervisor abstraction of setting cpu affinity to a
higher level to avoid platform dependent interrupt controller
routines.  I replaced spu_priv1_ops:spu_int_route_set() with a
new routine spu_priv1_ops:spu_cpu_affinity_set().

As a by-product, this change eliminated what looked like an
existing bug in the set affinity code where spu_int_route_set()
mistakenly called int_stat_get().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -522,14 +522,6 @@ int spu_irq_class_1_bottom(struct spu *s
 	return ret;
 }
 
-void spu_irq_setaffinity(struct spu *spu, int cpu)
-{
-	u64 target = iic_get_target_id(cpu);
-	u64 route = target << 48 | target << 32 | target << 16;
-	spu_int_route_set(spu, route);
-}
-EXPORT_SYMBOL_GPL(spu_irq_setaffinity);
-
 static int __init find_spu_node_id(struct device_node *spe)
 {
 	unsigned int *id;
Index: powerpc.git/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -24,6 +24,8 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 
+#include "interrupt.h"
+
 static void int_mask_and(struct spu *spu, int class, u64 mask)
 {
 	u64 old_mask;
@@ -60,8 +62,10 @@ static u64 int_stat_get(struct spu *spu,
 	return in_be64(&spu->priv1->int_stat_RW[class]);
 }
 
-static void int_route_set(struct spu *spu, u64 route)
+static void cpu_affinity_set(struct spu *spu, int cpu)
 {
+	u64 target = iic_get_target_id(cpu);
+	u64 route = target << 48 | target << 32 | target << 16;
 	out_be64(&spu->priv1->int_route_RW, route);
 }
 
@@ -138,7 +142,7 @@ const struct spu_priv1_ops spu_priv1_mmi
 	.int_mask_get = int_mask_get,
 	.int_stat_clear = int_stat_clear,
 	.int_stat_get = int_stat_get,
-	.int_route_set = int_route_set,
+	.cpu_affinity_set = cpu_affinity_set,
 	.mfc_dar_get = mfc_dar_get,
 	.mfc_dsisr_get = mfc_dsisr_get,
 	.mfc_dsisr_set = mfc_dsisr_set,
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/sched.c
@@ -43,6 +43,7 @@
 #include <asm/mmu_context.h>
 #include <asm/spu.h>
 #include <asm/spu_csa.h>
+#include <asm/spu_priv1.h>
 #include "spufs.h"
 
 #define SPU_MIN_TIMESLICE 	(100 * HZ / 1000)
@@ -363,7 +364,7 @@ int spu_activate(struct spu_context *ctx
 	 * We're likely to wait for interrupts on the same
 	 * CPU that we are now on, so send them here.
 	 */
-	spu_irq_setaffinity(spu, raw_smp_processor_id());
+	spu_cpu_affinity_set(spu, raw_smp_processor_id());
 	put_active_spu(spu);
 	return 0;
 }
Index: powerpc.git/include/asm-powerpc/spu_priv1.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/spu_priv1.h
+++ powerpc.git/include/asm-powerpc/spu_priv1.h
@@ -33,7 +33,7 @@ struct spu_priv1_ops
 	u64 (*int_mask_get) (struct spu *spu, int class);
 	void (*int_stat_clear) (struct spu *spu, int class, u64 stat);
 	u64 (*int_stat_get) (struct spu *spu, int class);
-	void (*int_route_set) (struct spu *spu, u64 route);
+	void (*cpu_affinity_set) (struct spu *spu, int cpu);
 	u64 (*mfc_dar_get) (struct spu *spu);
 	u64 (*mfc_dsisr_get) (struct spu *spu);
 	void (*mfc_dsisr_set) (struct spu *spu, u64 dsisr);
@@ -88,9 +88,9 @@ spu_int_stat_get (struct spu *spu, int c
 }
 
 static inline void
-spu_int_route_set (struct spu *spu, u64 route)
+spu_cpu_affinity_set (struct spu *spu, int cpu)
 {
-	spu_priv1_ops->int_stat_get(spu, route);
+	spu_priv1_ops->cpu_affinity_set(spu, cpu);
 }
 
 static inline u64

--
