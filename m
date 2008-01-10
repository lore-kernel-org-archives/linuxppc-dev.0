Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] Fix CPU hotplug when using the SLB shadow buffer
Date: Thu, 10 Jan 2008 17:49:03 +1100
Message-ID: <23336.1199947743@neuling.org>
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
paulus: This, or some variant of it, is probably 2.6.24 material.

 arch/powerpc/mm/slb.c                        |    2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
 arch/powerpc/platforms/pseries/lpar.c        |    6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -77,7 +77,7 @@ static inline void slb_shadow_update(uns
 	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, ssize, entry);
 }
 
-static inline void slb_shadow_clear(unsigned long entry)
+void slb_shadow_clear(unsigned long entry)
 {
 	get_slb_shadow()->save_area[entry].esid = 0;
 }
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
@@ -248,16 +248,22 @@ out:
 	of_node_put(stdout_node);
 }
 
+extern void slb_shadow_clear(unsigned long entry);
+
 void vpa_init(int cpu)
 {
 	int hwcpu = get_hard_smp_processor_id(cpu);
 	unsigned long addr;
 	long ret;
+	int i;
 
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		lppaca[cpu].vmxregs_in_use = 1;
 
 	addr = __pa(&lppaca[cpu]);
+	for (i = 0; i < SLB_NUM_BOLTED; i++){
+		slb_shadow_clear(i);
+	}
 	ret = register_vpa(hwcpu, addr);
 
 	if (ret) {
