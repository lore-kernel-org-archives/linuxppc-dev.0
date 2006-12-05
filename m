Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 05 Dec 2006 17:52:36 +1100
Subject: [PATCH 1/5] Move rtas_stop_self() into platforms/pseries/hotplug-cpu.c
Message-Id: <1165301556.843426.760217571714.qpush@cradle>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As the first step in consolidating the pseries hotplug cpu code,
create platforms/pseries/hotplug-cpu.c and move rtas_stop_self()
into it. Do the rtas token initialisation in a new initcall, rather
than rtas_initialize()

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/rtas.c                   |   29 -------------
 arch/powerpc/platforms/pseries/Makefile      |    2 
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   58 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 29 deletions(-)

Index: powerpc/arch/powerpc/kernel/rtas.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/rtas.c
+++ powerpc/arch/powerpc/kernel/rtas.c
@@ -810,32 +810,6 @@ asmlinkage int ppc_rtas(struct rtas_args
 	return 0;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-/* This version can't take the spinlock, because it never returns */
-static struct rtas_args rtas_stop_self_args = {
-	/* The token is initialized for real in setup_system() */
-	.token = RTAS_UNKNOWN_SERVICE,
-	.nargs = 0,
-	.nret = 1,
-	.rets = &rtas_stop_self_args.args[0],
-};
-
-void rtas_stop_self(void)
-{
-	struct rtas_args *rtas_args = &rtas_stop_self_args;
-
-	local_irq_disable();
-
-	BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
-
-	printk("cpu %u (hwid %u) Ready to die...\n",
-	       smp_processor_id(), hard_smp_processor_id());
-	enter_rtas(__pa(rtas_args));
-
-	panic("Alas, I survived.\n");
-}
-#endif
-
 /*
  * Call early during boot, before mem init or bootmem, to retrieve the RTAS
  * informations from the device-tree and allocate the RMO buffer for userland
@@ -880,9 +854,6 @@ void __init rtas_initialize(void)
 #endif
 	rtas_rmo_buf = lmb_alloc_base(RTAS_RMOBUF_MAX, PAGE_SIZE, rtas_region);
 
-#ifdef CONFIG_HOTPLUG_CPU
-	rtas_stop_self_args.token = rtas_token("stop-self");
-#endif /* CONFIG_HOTPLUG_CPU */
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
Index: powerpc/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/Makefile
+++ powerpc/arch/powerpc/platforms/pseries/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o
 
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
+
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
Index: powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -0,0 +1,58 @@
+/*
+ * pseries CPU Hotplug infrastructure.
+ *
+ * Split out from arch/powerpc/kernel/rtas.c
+ *
+ * Peter Bergner, IBM	March 2001.
+ * Copyright (C) 2001 IBM.
+ *
+ * Copyright (C) 2006 Michael Ellerman, IBM Corporation
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+#include <asm/system.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/firmware.h>
+#include <asm/machdep.h>
+#include <asm/vdso_datapage.h>
+#include <asm/pSeries_reconfig.h>
+#include "xics.h"
+
+/* This version can't take the spinlock, because it never returns */
+static struct rtas_args rtas_stop_self_args = {
+	.token = RTAS_UNKNOWN_SERVICE,
+	.nargs = 0,
+	.nret = 1,
+	.rets = &rtas_stop_self_args.args[0],
+};
+
+void rtas_stop_self(void)
+{
+	struct rtas_args *args = &rtas_stop_self_args;
+
+	local_irq_disable();
+
+	BUG_ON(args->token == RTAS_UNKNOWN_SERVICE);
+
+	printk("cpu %u (hwid %u) Ready to die...\n",
+	       smp_processor_id(), hard_smp_processor_id());
+	enter_rtas(__pa(args));
+
+	panic("Alas, I survived.\n");
+}
+
+static int __init pseries_cpu_hotplug_init(void)
+{
+	rtas_stop_self_args.token = rtas_token("stop-self");
+
+	return 0;
+}
+arch_initcall(pseries_cpu_hotplug_init);
