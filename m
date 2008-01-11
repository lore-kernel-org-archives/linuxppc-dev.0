Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
Subject: [PATCH] Fix CPU hotplug when using the SLB shadow buffer 
In-reply-to: <26792.1199949114@neuling.org> 
References: <23336.1199947743@neuling.org> <26792.1199949114@neuling.org>
Date: Fri, 11 Jan 2008 11:47:07 +1100
Message-ID: <28640.1200012427@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Before we register the SLB shadow buffer, we need to invalidate the
entries in the buffer otherwise we can end up stale entries from when we
offlined the CPU.

This patch does this invalidate as well as unregistering the buffer with
PHYP before we offline the cpu.  Tested and fixes crashes seen on 970MP
(thanks to tonyb) and POWER5.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Updates for offline comments from paulus

 arch/powerpc/mm/slb.c                        |    8 ++++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
 arch/powerpc/platforms/pseries/lpar.c        |    1 +
 include/asm-powerpc/mmu-hash64.h             |    1 +
 4 files changed, 12 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -82,6 +82,14 @@ static inline void slb_shadow_clear(unsi
 	get_slb_shadow()->save_area[entry].esid = 0;
 }
 
+void slb_shadow_clear_all(void)
+{
+	int i;
+
+	for (i = 0; i < SLB_NUM_BOLTED; i++)
+		slb_shadow_clear(i);
+}
+
 static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 					unsigned long flags,
 					unsigned long entry)
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -29,6 +29,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/pSeries_reconfig.h>
 #include "xics.h"
+#include "plpar_wrappers.h"
 
 /* This version can't take the spinlock, because it never returns */
 static struct rtas_args rtas_stop_self_args = {
@@ -58,6 +59,7 @@ static void pseries_mach_cpu_die(void)
 	local_irq_disable();
 	idle_task_exit();
 	xics_teardown_cpu(0);
+	unregister_slb_shadow(smp_processor_id(), __pa(get_slb_shadow()));
 	rtas_stop_self();
 	/* Should never get here... */
 	BUG();
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/lpar.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
@@ -272,6 +272,7 @@ void vpa_init(int cpu)
 	 */
 	addr = __pa(&slb_shadow[cpu]);
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+		slb_shadow_clear_all();
 		ret = register_slb_shadow(hwcpu, addr);
 		if (ret)
 			printk(KERN_ERR
Index: linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/mmu-hash64.h
+++ linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
@@ -286,6 +286,7 @@ extern void hpte_init_iSeries(void);
 extern void hpte_init_beat(void);
 extern void hpte_init_beat_v3(void);
 
+extern void slb_shadow_clear_all(void);
 extern void stabs_alloc(void);
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
