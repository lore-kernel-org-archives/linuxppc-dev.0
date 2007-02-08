Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 08 Feb 2007 18:33:55 +1100
Subject: [PATCH 3/4] Cleanup pseries kexec code
In-Reply-To: <1170920031.184014.219881150011.qpush@cradle>
Message-Id: <20070208073403.3C54FDDF0F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move all the pseries kexec code into one file, platforms/pseries/kexec.c
Provide helpers for setting up ppc_md.kexec_cpu_down, so that we don't
have to have #ifdef CONFIG_KEXEC in setup.c

Move the initialisation of the ppc_md kexec callbacks into an init routine.
This is well and truly early enough to cause no change in behaviour, we
can't kexec until userspace has given us a kernel to kexec into.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/Makefile  |    1 
 arch/powerpc/platforms/pseries/kexec.c   |   72 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    8 +++
 arch/powerpc/platforms/pseries/setup.c   |   50 ---------------------
 4 files changed, 83 insertions(+), 48 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/Makefile
+++ powerpc/arch/powerpc/platforms/pseries/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o
+obj-$(CONFIG_KEXEC)	+= kexec.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
 
Index: powerpc/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/platforms/pseries/kexec.c
@@ -0,0 +1,72 @@
+/*
+ *  Copyright 2006 Michael Ellerman, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/firmware.h>
+#include <asm/kexec.h>
+#include <asm/mpic.h>
+
+#include "pseries.h"
+#include "xics.h"
+#include "plpar_wrappers.h"
+
+static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
+{
+	/* Don't risk a hypervisor call if we're crashing */
+	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
+		unsigned long addr;
+
+		addr = __pa(get_slb_shadow());
+		if (unregister_slb_shadow(hard_smp_processor_id(), addr))
+			printk("SLB shadow buffer deregistration of "
+			       "cpu %u (hw_cpu_id %d) failed\n",
+			       smp_processor_id(),
+			       hard_smp_processor_id());
+
+		addr = __pa(get_lppaca());
+		if (unregister_vpa(hard_smp_processor_id(), addr)) {
+			printk("VPA deregistration of cpu %u (hw_cpu_id %d) "
+					"failed\n", smp_processor_id(),
+					hard_smp_processor_id());
+		}
+	}
+}
+
+static void pseries_kexec_cpu_down_mpic(int crash_shutdown, int secondary)
+{
+	pseries_kexec_cpu_down(crash_shutdown, secondary);
+	mpic_teardown_this_cpu(secondary);
+}
+
+void __init setup_kexec_cpu_down_mpic(void)
+{
+	ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_mpic;
+}
+
+static void pseries_kexec_cpu_down_xics(int crash_shutdown, int secondary)
+{
+	pseries_kexec_cpu_down(crash_shutdown, secondary);
+	xics_teardown_cpu(secondary);
+}
+
+void __init setup_kexec_cpu_down_xics(void)
+{
+	ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
+}
+
+static int __init pseries_kexec_setup(void)
+{
+	ppc_md.machine_kexec = default_machine_kexec;
+	ppc_md.machine_kexec_prepare = default_machine_kexec_prepare;
+	ppc_md.machine_crash_shutdown = default_machine_crash_shutdown;
+
+	return 0;
+}
+__initcall(pseries_kexec_setup);
Index: powerpc/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/pseries.h
+++ powerpc/arch/powerpc/platforms/pseries/pseries.h
@@ -25,4 +25,12 @@ static inline smp_init_pseries_mpic(void
 static inline smp_init_pseries_xics(void) { };
 #endif
 
+#ifdef CONFIG_KEXEC
+extern void setup_kexec_cpu_down_xics(void);
+extern void setup_kexec_cpu_down_mpic(void);
+#else
+static inline setup_kexec_cpu_down_xics(void) { };
+static inline setup_kexec_cpu_down_mpic(void) { };
+#endif
+
 #endif /* _PSERIES_PSERIES_H */
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
+++ powerpc/arch/powerpc/platforms/pseries/setup.c
@@ -55,7 +55,6 @@
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
-#include <asm/kexec.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
 #include "xics.h"
@@ -219,42 +218,6 @@ static void pseries_lpar_enable_pmcs(voi
 		get_lppaca()->pmcregs_in_use = 1;
 }
 
-#ifdef CONFIG_KEXEC
-static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
-{
-	/* Don't risk a hypervisor call if we're crashing */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
-		unsigned long addr;
-
-		addr = __pa(get_slb_shadow());
-		if (unregister_slb_shadow(hard_smp_processor_id(), addr))
-			printk("SLB shadow buffer deregistration of "
-			       "cpu %u (hw_cpu_id %d) failed\n",
-			       smp_processor_id(),
-			       hard_smp_processor_id());
-
-		addr = __pa(get_lppaca());
-		if (unregister_vpa(hard_smp_processor_id(), addr)) {
-			printk("VPA deregistration of cpu %u (hw_cpu_id %d) "
-					"failed\n", smp_processor_id(),
-					hard_smp_processor_id());
-		}
-	}
-}
-
-static void pseries_kexec_cpu_down_mpic(int crash_shutdown, int secondary)
-{
-	pseries_kexec_cpu_down(crash_shutdown, secondary);
-	mpic_teardown_this_cpu(secondary);
-}
-
-static void pseries_kexec_cpu_down_xics(int crash_shutdown, int secondary)
-{
-	pseries_kexec_cpu_down(crash_shutdown, secondary);
-	xics_teardown_cpu(secondary);
-}
-#endif /* CONFIG_KEXEC */
-
 static void __init pseries_discover_pic(void)
 {
 	struct device_node *np;
@@ -267,16 +230,12 @@ static void __init pseries_discover_pic(
 			pSeries_mpic_node = of_node_get(np);
 			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
 			ppc_md.get_irq        = mpic_get_irq;
-#ifdef CONFIG_KEXEC
-			ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_mpic;
-#endif
+			setup_kexec_cpu_down_mpic();
 			smp_init_pseries_mpic();
 			return;
 		} else if (strstr(typep, "ppc-xicp")) {
 			ppc_md.init_IRQ       = xics_init_IRQ;
-#ifdef CONFIG_KEXEC
-			ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
-#endif
+			setup_kexec_cpu_down_xics();
 			smp_init_pseries_xics();
 			return;
 		}
@@ -548,9 +507,4 @@ define_machine(pseries) {
 	.check_legacy_ioport	= pSeries_check_legacy_ioport,
 	.system_reset_exception = pSeries_system_reset_exception,
 	.machine_check_exception = pSeries_machine_check_exception,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 };
