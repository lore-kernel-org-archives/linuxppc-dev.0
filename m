Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D507B6FB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 17:58:05 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p2H6vxQF010446
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2011 01:58:00 -0500
Subject: [RFC/PATCH] powerpc: Rewrite XICS driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 17:57:58 +1100
Message-ID: <1300345078.22236.1204.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Folks !

This is for comments at this stage. There are various reasons why I wanted
to rewrite (more than just refactor) the XICS driver. The main one is that
I want a better split between the various ICP (presentation) and ICS (source)
backends, especially with various new ones coming up soon.

Now one could argue that it would be generally easier to review if the
patch had been instead a long series of incremental move code / change
code, but that isn't how I did it as I basically wrote a new one from
scratch picking up code left & right and modifying it, and at this stage
I do not have the bandwidth to recreate the patch completely along this
process.

On the flip side, this is mostly for comments at this stage, and either
I may get to do the above patch splitting, or at least I will get it
thoroughly tested. This is eased by the fact that at this point, this
is only used on pSeries. (and yes, I did test old Power4 bare metal :-)

After that, I plan to drop in eventually new backends for native ICS
and at least one other variant not released yet, and bring in on some
code (reworked from our internal BML tree) that can configure the links
in the ICPs v2 and use them appropriately for interrupt distribution
when not using pHyp.

Not-signed-off-yet-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xics.h                 |  139 ++++
 arch/powerpc/platforms/pseries/Kconfig          |    5 +-
 arch/powerpc/platforms/pseries/Makefile         |    1 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    3 +-
 arch/powerpc/platforms/pseries/kexec.c          |    5 +-
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   27 -
 arch/powerpc/platforms/pseries/setup.c          |    8 +-
 arch/powerpc/platforms/pseries/smp.c            |   17 +-
 arch/powerpc/platforms/pseries/xics.c           |  943 -----------------------
 arch/powerpc/platforms/pseries/xics.h           |   23 -
 arch/powerpc/sysdev/Kconfig                     |    3 +
 arch/powerpc/sysdev/Makefile                    |    4 +
 arch/powerpc/sysdev/xics/Kconfig                |   12 +
 arch/powerpc/sysdev/xics/Makefile               |    6 +
 arch/powerpc/sysdev/xics/icp-hv.c               |  183 +++++
 arch/powerpc/sysdev/xics/icp-native.c           |  312 ++++++++
 arch/powerpc/sysdev/xics/ics-rtas.c             |  231 ++++++
 arch/powerpc/sysdev/xics/xics-common.c          |  458 +++++++++++
 18 files changed, 1369 insertions(+), 1011 deletions(-)
 create mode 100644 arch/powerpc/include/asm/xics.h
 delete mode 100644 arch/powerpc/platforms/pseries/xics.c
 delete mode 100644 arch/powerpc/platforms/pseries/xics.h
 create mode 100644 arch/powerpc/sysdev/xics/Kconfig
 create mode 100644 arch/powerpc/sysdev/xics/Makefile
 create mode 100644 arch/powerpc/sysdev/xics/icp-hv.c
 create mode 100644 arch/powerpc/sysdev/xics/icp-native.c
 create mode 100644 arch/powerpc/sysdev/xics/ics-rtas.c
 create mode 100644 arch/powerpc/sysdev/xics/xics-common.c

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
new file mode 100644
index 0000000..faa0c60
--- /dev/null
+++ b/arch/powerpc/include/asm/xics.h
@@ -0,0 +1,139 @@
+/*
+ * Common definitions accross all variants of ICP and ICS interrupt
+ * controllers.
+ */
+
+#ifndef _XICS_H
+#define _XICS_H
+
+#define XICS_IPI		2
+#define XICS_IRQ_SPURIOUS	0
+
+/* Want a priority other than 0.  Various HW issues require this. */
+#define	DEFAULT_PRIORITY	5
+
+/*
+ * Mark IPIs as higher priority so we can take them inside interrupts that
+ * arent marked IRQF_DISABLED
+ */
+#define IPI_PRIORITY		4
+
+/* The least favored priority */
+#define LOWEST_PRIORITY		0xFF
+
+/* The number of priorities defined above */
+#define MAX_NUM_PRIORITIES	3
+
+/* Native ICP */
+extern int icp_native_init(void);
+
+/* PAPR ICP */
+extern int icp_hv_init(void);
+
+/* ICP ops */
+struct icp_ops {
+	unsigned int (*get_irq)(void);
+	void (*eoi)(unsigned int virq);
+	void (*set_priority)(unsigned char prio);
+	void (*teardown_cpu)(void);
+	void (*flush_ipi)(void);
+#ifdef CONFIG_SMP
+	void (*message_pass)(int target, int msg);
+	irq_handler_t ipi_action;
+#endif
+};
+
+extern const struct icp_ops *icp_ops;
+
+/* Native ICS */
+extern int ics_native_init(void);
+
+/* RTAS ICS */
+extern int ics_rtas_init(void);
+
+/* ICS instance, hooked up to chip_data of an irq */
+struct ics {
+	struct list_head link;
+	int (*map)(struct ics *ics, unsigned int virq);
+	void (*mask_unknown)(struct ics *ics, unsigned long vec);
+	long (*get_server)(struct ics *ics, unsigned long vec);
+	char data[];
+};
+
+/* Commons */
+extern unsigned int xics_default_server;
+extern unsigned int xics_default_distrib_server;
+extern unsigned int xics_interrupt_server_size;
+extern struct irq_host *xics_host;
+
+struct xics_cppr {
+	unsigned char stack[MAX_NUM_PRIORITIES];
+	int index;
+};
+
+DECLARE_PER_CPU(struct xics_cppr, xics_cppr);
+
+static inline void xics_push_cppr(unsigned int vec)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+
+	if (WARN_ON(os_cppr->index >= MAX_NUM_PRIORITIES - 1))
+		return;
+
+	if (vec == XICS_IPI)
+		os_cppr->stack[++os_cppr->index] = IPI_PRIORITY;
+	else
+		os_cppr->stack[++os_cppr->index] = DEFAULT_PRIORITY;
+}
+
+static inline unsigned char xics_pop_cppr(void)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+
+	if (WARN_ON(os_cppr->index < 1))
+		return LOWEST_PRIORITY;
+
+	return os_cppr->stack[--os_cppr->index];
+}
+
+static inline void xics_set_base_cppr(unsigned char cppr)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+
+	/* we only really want to set the priority when there's
+	 * just one cppr value on the stack
+	 */
+	WARN_ON(os_cppr->index != 0);
+
+	os_cppr->stack[0] = cppr;
+}
+
+static inline unsigned char xics_cppr_top(void)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+	
+	return os_cppr->stack[os_cppr->index];
+}
+
+DECLARE_PER_CPU_SHARED_ALIGNED(unsigned long, xics_ipi_message);
+
+extern void xics_init(void);
+extern void xics_setup_cpu(void);
+extern void xics_update_irq_servers(void);
+extern void xics_set_cpu_giq(unsigned int gserver, unsigned int join);
+extern void xics_mask_unknown_vec(unsigned int vec);
+extern irqreturn_t xics_ipi_dispatch(int cpu);
+extern int xics_smp_probe(void);
+extern void xics_register_ics(struct ics *ics);
+extern void xics_teardown_cpu(void);
+extern void xics_kexec_teardown_cpu(int secondary);
+extern void xics_migrate_irqs_away(void);
+#ifdef CONFIG_SMP
+extern int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
+			       unsigned int strict_check);
+#else
+#define xics_get_irq_server(virq, cpumask, strict_check) (xics_default_server)
+#endif
+
+
+#endif /* _XICS_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5b3da4b..b044922 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -3,7 +3,10 @@ config PPC_PSERIES
 	bool "IBM pSeries & new (POWER5-based) iSeries"
 	select MPIC
 	select PCI_MSI
-	select XICS
+	select PPC_XICS
+	select PPC_ICP_NATIVE
+	select PPC_ICP_HV
+	select PPC_ICS_RTAS
 	select PPC_I8259
 	select PPC_RTAS
 	select PPC_RTAS_DAEMON
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fc52378..4cfefba 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -5,7 +5,6 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index fd50ccd..b9b72f7 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <asm/system.h>
@@ -28,7 +29,7 @@
 #include <asm/machdep.h>
 #include <asm/vdso_datapage.h>
 #include <asm/pSeries_reconfig.h>
-#include "xics.h"
+#include <asm/xics.h>
 #include "plpar_wrappers.h"
 #include "offline_states.h"
 
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 77d38a5..54cf3a4 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -7,15 +7,18 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+
 #include <asm/machdep.h>
 #include <asm/page.h>
 #include <asm/firmware.h>
 #include <asm/kexec.h>
 #include <asm/mpic.h>
+#include <asm/xics.h>
 #include <asm/smp.h>
 
 #include "pseries.h"
-#include "xics.h"
 #include "plpar_wrappers.h"
 
 static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index d980111..4bf2120 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -270,31 +270,4 @@ static inline long plpar_put_term_char(unsigned long termno, unsigned long len,
 			lbuf[1]);
 }
 
-static inline long plpar_eoi(unsigned long xirr)
-{
-	return plpar_hcall_norets(H_EOI, xirr);
-}
-
-static inline long plpar_cppr(unsigned long cppr)
-{
-	return plpar_hcall_norets(H_CPPR, cppr);
-}
-
-static inline long plpar_ipi(unsigned long servernum, unsigned long mfrr)
-{
-	return plpar_hcall_norets(H_IPI, servernum, mfrr);
-}
-
-static inline long plpar_xirr(unsigned long *xirr_ret, unsigned char cppr)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_XIRR, retbuf, cppr);
-
-	*xirr_ret = retbuf[0];
-
-	return rc;
-}
-
 #endif /* _PSERIES_PLPAR_WRAPPERS_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index d345bfd..82f632e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -53,9 +53,9 @@
 #include <asm/irq.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
-#include "xics.h"
 #include <asm/pmc.h>
 #include <asm/mpic.h>
+#include <asm/xics.h>
 #include <asm/ppc-pci.h>
 #include <asm/i8259.h>
 #include <asm/udbg.h>
@@ -202,6 +202,9 @@ static void __init pseries_mpic_init_IRQ(void)
 		mpic_assign_isu(mpic, n, isuaddr);
 	}
 
+	/* Setup top-level get_irq */
+	ppc_md.get_irq = mpic_get_irq;
+
 	/* All ISUs are setup, complete initialization */
 	mpic_init(mpic);
 
@@ -211,7 +214,7 @@ static void __init pseries_mpic_init_IRQ(void)
 
 static void __init pseries_xics_init_IRQ(void)
 {
-	xics_init_IRQ();
+	xics_init();
 	pseries_setup_i8259_cascade();
 }
 
@@ -235,7 +238,6 @@ static void __init pseries_discover_pic(void)
 		if (strstr(typep, "open-pic")) {
 			pSeries_mpic_node = of_node_get(np);
 			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
-			ppc_md.get_irq        = mpic_get_irq;
 			setup_kexec_cpu_down_mpic();
 			smp_init_pseries_mpic();
 			return;
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 5fe1ad6..dfc0789 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -44,10 +44,11 @@
 #include <asm/mpic.h>
 #include <asm/vdso_datapage.h>
 #include <asm/cputhreads.h>
+#include <asm/mpic.h>
+#include <asm/xics.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
-#include "xics.h"
 #include "offline_states.h"
 
 
@@ -136,7 +137,6 @@ out:
 	return 1;
 }
 
-#ifdef CONFIG_XICS
 static void __devinit smp_xics_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
@@ -151,7 +151,6 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 	set_default_offline_state(cpu);
 #endif
 }
-#endif /* CONFIG_XICS */
 
 static void __devinit smp_pSeries_kick_cpu(int nr)
 {
@@ -197,23 +196,21 @@ static int smp_pSeries_cpu_bootable(unsigned int nr)
 
 	return 1;
 }
-#ifdef CONFIG_MPIC
+
 static struct smp_ops_t pSeries_mpic_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_mpic_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_mpic_setup_cpu,
 };
-#endif
-#ifdef CONFIG_XICS
+
 static struct smp_ops_t pSeries_xics_smp_ops = {
-	.message_pass	= smp_xics_message_pass,
-	.probe		= smp_xics_probe,
+	.message_pass	= NULL,	/* Filled at runtime by xics_smp_probe() */
+	.probe		= xics_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
 	.cpu_bootable	= smp_pSeries_cpu_bootable,
 };
-#endif
 
 /* This is called very early */
 static void __init smp_init_pseries(void)
@@ -245,14 +242,12 @@ static void __init smp_init_pseries(void)
 	pr_debug(" <- smp_init_pSeries()\n");
 }
 
-#ifdef CONFIG_MPIC
 void __init smp_init_pseries_mpic(void)
 {
 	smp_ops = &pSeries_mpic_smp_ops;
 
 	smp_init_pseries();
 }
-#endif
 
 void __init smp_init_pseries_xics(void)
 {
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
deleted file mode 100644
index 7b96e5a..0000000
--- a/arch/powerpc/platforms/pseries/xics.c
+++ /dev/null
@@ -1,943 +0,0 @@
-/*
- * arch/powerpc/platforms/pseries/xics.c
- *
- * Copyright 2000 IBM Corporation.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/types.h>
-#include <linux/threads.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/radix-tree.h>
-#include <linux/cpu.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/percpu.h>
-
-#include <asm/firmware.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/smp.h>
-#include <asm/rtas.h>
-#include <asm/hvcall.h>
-#include <asm/machdep.h>
-
-#include "xics.h"
-#include "plpar_wrappers.h"
-
-static struct irq_host *xics_host;
-
-#define XICS_IPI		2
-#define XICS_IRQ_SPURIOUS	0
-
-/* Want a priority other than 0.  Various HW issues require this. */
-#define	DEFAULT_PRIORITY	5
-
-/*
- * Mark IPIs as higher priority so we can take them inside interrupts that
- * arent marked IRQF_DISABLED
- */
-#define IPI_PRIORITY		4
-
-/* The least favored priority */
-#define LOWEST_PRIORITY		0xFF
-
-/* The number of priorities defined above */
-#define MAX_NUM_PRIORITIES	3
-
-static unsigned int default_server = 0xFF;
-static unsigned int default_distrib_server = 0;
-static unsigned int interrupt_server_size = 8;
-
-/* RTAS service tokens */
-static int ibm_get_xive;
-static int ibm_set_xive;
-static int ibm_int_on;
-static int ibm_int_off;
-
-struct xics_cppr {
-	unsigned char stack[MAX_NUM_PRIORITIES];
-	int index;
-};
-
-static DEFINE_PER_CPU(struct xics_cppr, xics_cppr);
-
-/* Direct hardware low level accessors */
-
-/* The part of the interrupt presentation layer that we care about */
-struct xics_ipl {
-	union {
-		u32 word;
-		u8 bytes[4];
-	} xirr_poll;
-	union {
-		u32 word;
-		u8 bytes[4];
-	} xirr;
-	u32 dummy;
-	union {
-		u32 word;
-		u8 bytes[4];
-	} qirr;
-};
-
-static struct xics_ipl __iomem *xics_per_cpu[NR_CPUS];
-
-static inline unsigned int direct_xirr_info_get(void)
-{
-	int cpu = smp_processor_id();
-
-	return in_be32(&xics_per_cpu[cpu]->xirr.word);
-}
-
-static inline void direct_xirr_info_set(unsigned int value)
-{
-	int cpu = smp_processor_id();
-
-	out_be32(&xics_per_cpu[cpu]->xirr.word, value);
-}
-
-static inline void direct_cppr_info(u8 value)
-{
-	int cpu = smp_processor_id();
-
-	out_8(&xics_per_cpu[cpu]->xirr.bytes[0], value);
-}
-
-static inline void direct_qirr_info(int n_cpu, u8 value)
-{
-	out_8(&xics_per_cpu[n_cpu]->qirr.bytes[0], value);
-}
-
-
-/* LPAR low level accessors */
-
-static inline unsigned int lpar_xirr_info_get(unsigned char cppr)
-{
-	unsigned long lpar_rc;
-	unsigned long return_value;
-
-	lpar_rc = plpar_xirr(&return_value, cppr);
-	if (lpar_rc != H_SUCCESS)
-		panic(" bad return code xirr - rc = %lx\n", lpar_rc);
-	return (unsigned int)return_value;
-}
-
-static inline void lpar_xirr_info_set(unsigned int value)
-{
-	unsigned long lpar_rc;
-
-	lpar_rc = plpar_eoi(value);
-	if (lpar_rc != H_SUCCESS)
-		panic("bad return code EOI - rc = %ld, value=%x\n", lpar_rc,
-		      value);
-}
-
-static inline void lpar_cppr_info(u8 value)
-{
-	unsigned long lpar_rc;
-
-	lpar_rc = plpar_cppr(value);
-	if (lpar_rc != H_SUCCESS)
-		panic("bad return code cppr - rc = %lx\n", lpar_rc);
-}
-
-static inline void lpar_qirr_info(int n_cpu , u8 value)
-{
-	unsigned long lpar_rc;
-
-	lpar_rc = plpar_ipi(get_hard_smp_processor_id(n_cpu), value);
-	if (lpar_rc != H_SUCCESS)
-		panic("bad return code qirr - rc = %lx\n", lpar_rc);
-}
-
-
-/* Interface to generic irq subsystem */
-
-#ifdef CONFIG_SMP
-/*
- * For the moment we only implement delivery to all cpus or one cpu.
- *
- * If the requested affinity is cpu_all_mask, we set global affinity.
- * If not we set it to the first cpu in the mask, even if multiple cpus
- * are set. This is so things like irqbalance (which set core and package
- * wide affinities) do the right thing.
- */
-static int get_irq_server(unsigned int virq, const struct cpumask *cpumask,
-			  unsigned int strict_check)
-{
-
-	if (!distribute_irqs)
-		return default_server;
-
-	if (!cpumask_subset(cpu_possible_mask, cpumask)) {
-		int server = cpumask_first_and(cpu_online_mask, cpumask);
-
-		if (server < nr_cpu_ids)
-			return get_hard_smp_processor_id(server);
-
-		if (strict_check)
-			return -1;
-	}
-
-	/*
-	 * Workaround issue with some versions of JS20 firmware that
-	 * deliver interrupts to cpus which haven't been started. This
-	 * happens when using the maxcpus= boot option.
-	 */
-	if (cpumask_equal(cpu_online_mask, cpu_present_mask))
-		return default_distrib_server;
-
-	return default_server;
-}
-#else
-#define get_irq_server(virq, cpumask, strict_check) (default_server)
-#endif
-
-static void xics_unmask_irq(unsigned int virq)
-{
-	unsigned int irq;
-	int call_status;
-	int server;
-
-	pr_devel("xics: unmask virq %d\n", virq);
-
-	irq = (unsigned int)irq_map[virq].hwirq;
-	pr_devel(" -> map to hwirq 0x%x\n", irq);
-	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
-		return;
-
-	server = get_irq_server(virq, irq_to_desc(virq)->affinity, 0);
-
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
-				DEFAULT_PRIORITY);
-	if (call_status != 0) {
-		printk(KERN_ERR
-			"%s: ibm_set_xive irq %u server %x returned %d\n",
-			__func__, irq, server, call_status);
-		return;
-	}
-
-	/* Now unmask the interrupt (often a no-op) */
-	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
-	if (call_status != 0) {
-		printk(KERN_ERR "%s: ibm_int_on irq=%u returned %d\n",
-			__func__, irq, call_status);
-		return;
-	}
-}
-
-static unsigned int xics_startup(unsigned int virq)
-{
-	/*
-	 * The generic MSI code returns with the interrupt disabled on the
-	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
-	 * at that level, so we do it here by hand.
-	 */
-	if (irq_to_desc(virq)->msi_desc)
-		unmask_msi_irq(irq_get_irq_data(virq));
-
-	/* unmask it */
-	xics_unmask_irq(virq);
-	return 0;
-}
-
-static void xics_mask_real_irq(unsigned int irq)
-{
-	int call_status;
-
-	if (irq == XICS_IPI)
-		return;
-
-	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
-	if (call_status != 0) {
-		printk(KERN_ERR "%s: ibm_int_off irq=%u returned %d\n",
-			__func__, irq, call_status);
-		return;
-	}
-
-	/* Have to set XIVE to 0xff to be able to remove a slot */
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq,
-				default_server, 0xff);
-	if (call_status != 0) {
-		printk(KERN_ERR "%s: ibm_set_xive(0xff) irq=%u returned %d\n",
-			__func__, irq, call_status);
-		return;
-	}
-}
-
-static void xics_mask_irq(unsigned int virq)
-{
-	unsigned int irq;
-
-	pr_devel("xics: mask virq %d\n", virq);
-
-	irq = (unsigned int)irq_map[virq].hwirq;
-	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
-		return;
-	xics_mask_real_irq(irq);
-}
-
-static void xics_mask_unknown_vec(unsigned int vec)
-{
-	printk(KERN_ERR "Interrupt %u (real) is invalid, disabling it.\n", vec);
-	xics_mask_real_irq(vec);
-}
-
-static inline unsigned int xics_xirr_vector(unsigned int xirr)
-{
-	/*
-	 * The top byte is the old cppr, to be restored on EOI.
-	 * The remaining 24 bits are the vector.
-	 */
-	return xirr & 0x00ffffff;
-}
-
-static void push_cppr(unsigned int vec)
-{
-	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
-
-	if (WARN_ON(os_cppr->index >= MAX_NUM_PRIORITIES - 1))
-		return;
-
-	if (vec == XICS_IPI)
-		os_cppr->stack[++os_cppr->index] = IPI_PRIORITY;
-	else
-		os_cppr->stack[++os_cppr->index] = DEFAULT_PRIORITY;
-}
-
-static unsigned int xics_get_irq_direct(void)
-{
-	unsigned int xirr = direct_xirr_info_get();
-	unsigned int vec = xics_xirr_vector(xirr);
-	unsigned int irq;
-
-	if (vec == XICS_IRQ_SPURIOUS)
-		return NO_IRQ;
-
-	irq = irq_radix_revmap_lookup(xics_host, vec);
-	if (likely(irq != NO_IRQ)) {
-		push_cppr(vec);
-		return irq;
-	}
-
-	/* We don't have a linux mapping, so have rtas mask it. */
-	xics_mask_unknown_vec(vec);
-
-	/* We might learn about it later, so EOI it */
-	direct_xirr_info_set(xirr);
-	return NO_IRQ;
-}
-
-static unsigned int xics_get_irq_lpar(void)
-{
-	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
-	unsigned int xirr = lpar_xirr_info_get(os_cppr->stack[os_cppr->index]);
-	unsigned int vec = xics_xirr_vector(xirr);
-	unsigned int irq;
-
-	if (vec == XICS_IRQ_SPURIOUS)
-		return NO_IRQ;
-
-	irq = irq_radix_revmap_lookup(xics_host, vec);
-	if (likely(irq != NO_IRQ)) {
-		push_cppr(vec);
-		return irq;
-	}
-
-	/* We don't have a linux mapping, so have RTAS mask it. */
-	xics_mask_unknown_vec(vec);
-
-	/* We might learn about it later, so EOI it */
-	lpar_xirr_info_set(xirr);
-	return NO_IRQ;
-}
-
-static unsigned char pop_cppr(void)
-{
-	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
-
-	if (WARN_ON(os_cppr->index < 1))
-		return LOWEST_PRIORITY;
-
-	return os_cppr->stack[--os_cppr->index];
-}
-
-static void xics_eoi_direct(unsigned int virq)
-{
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
-
-	iosync();
-	direct_xirr_info_set((pop_cppr() << 24) | irq);
-}
-
-static void xics_eoi_lpar(unsigned int virq)
-{
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
-
-	iosync();
-	lpar_xirr_info_set((pop_cppr() << 24) | irq);
-}
-
-static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
-{
-	unsigned int irq;
-	int status;
-	int xics_status[2];
-	int irq_server;
-
-	irq = (unsigned int)irq_map[virq].hwirq;
-	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
-		return -1;
-
-	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
-
-	if (status) {
-		printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
-			__func__, irq, status);
-		return -1;
-	}
-
-	irq_server = get_irq_server(virq, cpumask, 1);
-	if (irq_server == -1) {
-		char cpulist[128];
-		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
-		printk(KERN_WARNING
-			"%s: No online cpus in the mask %s for irq %d\n",
-			__func__, cpulist, virq);
-		return -1;
-	}
-
-	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-				irq, irq_server, xics_status[1]);
-
-	if (status) {
-		printk(KERN_ERR "%s: ibm,set-xive irq=%u returns %d\n",
-			__func__, irq, status);
-		return -1;
-	}
-
-	return 0;
-}
-
-static struct irq_chip xics_pic_direct = {
-	.name = "XICS",
-	.startup = xics_startup,
-	.mask = xics_mask_irq,
-	.unmask = xics_unmask_irq,
-	.eoi = xics_eoi_direct,
-	.set_affinity = xics_set_affinity
-};
-
-static struct irq_chip xics_pic_lpar = {
-	.name = "XICS",
-	.startup = xics_startup,
-	.mask = xics_mask_irq,
-	.unmask = xics_unmask_irq,
-	.eoi = xics_eoi_lpar,
-	.set_affinity = xics_set_affinity
-};
-
-
-/* Interface to arch irq controller subsystem layer */
-
-/* Points to the irq_chip we're actually using */
-static struct irq_chip *xics_irq_chip;
-
-static int xics_host_match(struct irq_host *h, struct device_node *node)
-{
-	/* IBM machines have interrupt parents of various funky types for things
-	 * like vdevices, events, etc... The trick we use here is to match
-	 * everything here except the legacy 8259 which is compatible "chrp,iic"
-	 */
-	return !of_device_is_compatible(node, "chrp,iic");
-}
-
-static int xics_host_map(struct irq_host *h, unsigned int virq,
-			 irq_hw_number_t hw)
-{
-	pr_devel("xics: map virq %d, hwirq 0x%lx\n", virq, hw);
-
-	/* Insert the interrupt mapping into the radix tree for fast lookup */
-	irq_radix_revmap_insert(xics_host, virq, hw);
-
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
-	set_irq_chip_and_handler(virq, xics_irq_chip, handle_fasteoi_irq);
-	return 0;
-}
-
-static int xics_host_xlate(struct irq_host *h, struct device_node *ct,
-			   const u32 *intspec, unsigned int intsize,
-			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
-
-{
-	/* Current xics implementation translates everything
-	 * to level. It is not technically right for MSIs but this
-	 * is irrelevant at this point. We might get smarter in the future
-	 */
-	*out_hwirq = intspec[0];
-	*out_flags = IRQ_TYPE_LEVEL_LOW;
-
-	return 0;
-}
-
-static struct irq_host_ops xics_host_ops = {
-	.match = xics_host_match,
-	.map = xics_host_map,
-	.xlate = xics_host_xlate,
-};
-
-static void __init xics_init_host(void)
-{
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		xics_irq_chip = &xics_pic_lpar;
-	else
-		xics_irq_chip = &xics_pic_direct;
-
-	xics_host = irq_alloc_host(NULL, IRQ_HOST_MAP_TREE, 0, &xics_host_ops,
-				   XICS_IRQ_SPURIOUS);
-	BUG_ON(xics_host == NULL);
-	irq_set_default_host(xics_host);
-}
-
-
-/* Inter-processor interrupt support */
-
-#ifdef CONFIG_SMP
-/*
- * XICS only has a single IPI, so encode the messages per CPU
- */
-static DEFINE_PER_CPU_SHARED_ALIGNED(unsigned long, xics_ipi_message);
-
-static inline void smp_xics_do_message(int cpu, int msg)
-{
-	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
-
-	set_bit(msg, tgt);
-	mb();
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_qirr_info(cpu, IPI_PRIORITY);
-	else
-		direct_qirr_info(cpu, IPI_PRIORITY);
-}
-
-void smp_xics_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		smp_xics_do_message(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			smp_xics_do_message(i, msg);
-		}
-	}
-}
-
-static irqreturn_t xics_ipi_dispatch(int cpu)
-{
-	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
-
-	mb();	/* order mmio clearing qirr */
-	while (*tgt) {
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt)) {
-			smp_message_recv(PPC_MSG_CALL_FUNCTION);
-		}
-		if (test_and_clear_bit(PPC_MSG_RESCHEDULE, tgt)) {
-			smp_message_recv(PPC_MSG_RESCHEDULE);
-		}
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE, tgt)) {
-			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
-		}
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
-		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK, tgt)) {
-			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
-		}
-#endif
-	}
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t xics_ipi_action_direct(int irq, void *dev_id)
-{
-	int cpu = smp_processor_id();
-
-	direct_qirr_info(cpu, 0xff);
-
-	return xics_ipi_dispatch(cpu);
-}
-
-static irqreturn_t xics_ipi_action_lpar(int irq, void *dev_id)
-{
-	int cpu = smp_processor_id();
-
-	lpar_qirr_info(cpu, 0xff);
-
-	return xics_ipi_dispatch(cpu);
-}
-
-static void xics_request_ipi(void)
-{
-	unsigned int ipi;
-	int rc;
-
-	ipi = irq_create_mapping(xics_host, XICS_IPI);
-	BUG_ON(ipi == NO_IRQ);
-
-	/*
-	 * IPIs are marked IRQF_DISABLED as they must run with irqs
-	 * disabled
-	 */
-	set_irq_handler(ipi, handle_percpu_irq);
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		rc = request_irq(ipi, xics_ipi_action_lpar,
-				IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
-	else
-		rc = request_irq(ipi, xics_ipi_action_direct,
-				IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
-	BUG_ON(rc);
-}
-
-int __init smp_xics_probe(void)
-{
-	xics_request_ipi();
-
-	return cpumask_weight(cpu_possible_mask);
-}
-
-#endif /* CONFIG_SMP */
-
-
-/* Initialization */
-
-static void xics_update_irq_servers(void)
-{
-	int i, j;
-	struct device_node *np;
-	u32 ilen;
-	const u32 *ireg;
-	u32 hcpuid;
-
-	/* Find the server numbers for the boot cpu. */
-	np = of_get_cpu_node(boot_cpuid, NULL);
-	BUG_ON(!np);
-
-	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
-	if (!ireg) {
-		of_node_put(np);
-		return;
-	}
-
-	i = ilen / sizeof(int);
-	hcpuid = get_hard_smp_processor_id(boot_cpuid);
-
-	/* Global interrupt distribution server is specified in the last
-	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
-	 * entry fom this property for current boot cpu id and use it as
-	 * default distribution server
-	 */
-	for (j = 0; j < i; j += 2) {
-		if (ireg[j] == hcpuid) {
-			default_server = hcpuid;
-			default_distrib_server = ireg[j+1];
-		}
-	}
-
-	of_node_put(np);
-}
-
-static void __init xics_map_one_cpu(int hw_id, unsigned long addr,
-				     unsigned long size)
-{
-	int i;
-
-	/* This may look gross but it's good enough for now, we don't quite
-	 * have a hard -> linux processor id matching.
-	 */
-	for_each_possible_cpu(i) {
-		if (!cpu_present(i))
-			continue;
-		if (hw_id == get_hard_smp_processor_id(i)) {
-			xics_per_cpu[i] = ioremap(addr, size);
-			return;
-		}
-	}
-}
-
-static void __init xics_init_one_node(struct device_node *np,
-				      unsigned int *indx)
-{
-	unsigned int ilen;
-	const u32 *ireg;
-
-	/* This code does the theorically broken assumption that the interrupt
-	 * server numbers are the same as the hard CPU numbers.
-	 * This happens to be the case so far but we are playing with fire...
-	 * should be fixed one of these days. -BenH.
-	 */
-	ireg = of_get_property(np, "ibm,interrupt-server-ranges", NULL);
-
-	/* Do that ever happen ? we'll know soon enough... but even good'old
-	 * f80 does have that property ..
-	 */
-	WARN_ON(ireg == NULL);
-	if (ireg) {
-		/*
-		 * set node starting index for this node
-		 */
-		*indx = *ireg;
-	}
-	ireg = of_get_property(np, "reg", &ilen);
-	if (!ireg)
-		panic("xics_init_IRQ: can't find interrupt reg property");
-
-	while (ilen >= (4 * sizeof(u32))) {
-		unsigned long addr, size;
-
-		/* XXX Use proper OF parsing code here !!! */
-		addr = (unsigned long)*ireg++ << 32;
-		ilen -= sizeof(u32);
-		addr |= *ireg++;
-		ilen -= sizeof(u32);
-		size = (unsigned long)*ireg++ << 32;
-		ilen -= sizeof(u32);
-		size |= *ireg++;
-		ilen -= sizeof(u32);
-		xics_map_one_cpu(*indx, addr, size);
-		(*indx)++;
-	}
-}
-
-void __init xics_init_IRQ(void)
-{
-	struct device_node *np;
-	u32 indx = 0;
-	int found = 0;
-	const u32 *isize;
-
-	ppc64_boot_msg(0x20, "XICS Init");
-
-	ibm_get_xive = rtas_token("ibm,get-xive");
-	ibm_set_xive = rtas_token("ibm,set-xive");
-	ibm_int_on  = rtas_token("ibm,int-on");
-	ibm_int_off = rtas_token("ibm,int-off");
-
-	for_each_node_by_type(np, "PowerPC-External-Interrupt-Presentation") {
-		found = 1;
-		if (firmware_has_feature(FW_FEATURE_LPAR)) {
-			of_node_put(np);
-			break;
-			}
-		xics_init_one_node(np, &indx);
-	}
-	if (found == 0)
-		return;
-
-	/* get the bit size of server numbers */
-	found = 0;
-
-	for_each_compatible_node(np, NULL, "ibm,ppc-xics") {
-		isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
-
-		if (!isize)
-			continue;
-
-		if (!found) {
-			interrupt_server_size = *isize;
-			found = 1;
-		} else if (*isize != interrupt_server_size) {
-			printk(KERN_WARNING "XICS: "
-			       "mismatched ibm,interrupt-server#-size\n");
-			interrupt_server_size = max(*isize,
-						    interrupt_server_size);
-		}
-	}
-
-	xics_update_irq_servers();
-	xics_init_host();
-
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		ppc_md.get_irq = xics_get_irq_lpar;
-	else
-		ppc_md.get_irq = xics_get_irq_direct;
-
-	xics_setup_cpu();
-
-	ppc64_boot_msg(0x21, "XICS Done");
-}
-
-/* Cpu startup, shutdown, and hotplug */
-
-static void xics_set_cpu_priority(unsigned char cppr)
-{
-	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
-
-	/*
-	 * we only really want to set the priority when there's
-	 * just one cppr value on the stack
-	 */
-	WARN_ON(os_cppr->index != 0);
-
-	os_cppr->stack[0] = cppr;
-
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_cppr_info(cppr);
-	else
-		direct_cppr_info(cppr);
-	iosync();
-}
-
-/* Have the calling processor join or leave the specified global queue */
-static void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
-{
-	int index;
-	int status;
-
-	if (!rtas_indicator_present(GLOBAL_INTERRUPT_QUEUE, NULL))
-		return;
-
-	index = (1UL << interrupt_server_size) - 1 - gserver;
-
-	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE, index, join);
-
-	WARN(status < 0, "set-indicator(%d, %d, %u) returned %d\n",
-	     GLOBAL_INTERRUPT_QUEUE, index, join, status);
-}
-
-void xics_setup_cpu(void)
-{
-	xics_set_cpu_priority(LOWEST_PRIORITY);
-
-	xics_set_cpu_giq(default_distrib_server, 1);
-}
-
-void xics_teardown_cpu(void)
-{
-	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
-	int cpu = smp_processor_id();
-
-	/*
-	 * we have to reset the cppr index to 0 because we're
-	 * not going to return from the IPI
-	 */
-	os_cppr->index = 0;
-	xics_set_cpu_priority(0);
-
-	/* Clear any pending IPI request */
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_qirr_info(cpu, 0xff);
-	else
-		direct_qirr_info(cpu, 0xff);
-}
-
-void xics_kexec_teardown_cpu(int secondary)
-{
-	xics_teardown_cpu();
-
-	/*
-	 * we take the ipi irq but and never return so we
-	 * need to EOI the IPI, but want to leave our priority 0
-	 *
-	 * should we check all the other interrupts too?
-	 * should we be flagging idle loop instead?
-	 * or creating some task to be scheduled?
-	 */
-
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_xirr_info_set((0x00 << 24) | XICS_IPI);
-	else
-		direct_xirr_info_set((0x00 << 24) | XICS_IPI);
-
-	/*
-	 * Some machines need to have at least one cpu in the GIQ,
-	 * so leave the master cpu in the group.
-	 */
-	if (secondary)
-		xics_set_cpu_giq(default_distrib_server, 0);
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-/* Interrupts are disabled. */
-void xics_migrate_irqs_away(void)
-{
-	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
-	unsigned int irq, virq;
-
-	/* If we used to be the default server, move to the new "boot_cpuid" */
-	if (hw_cpu == default_server)
-		xics_update_irq_servers();
-
-	/* Reject any interrupt that was queued to us... */
-	xics_set_cpu_priority(0);
-
-	/* Remove ourselves from the global interrupt queue */
-	xics_set_cpu_giq(default_distrib_server, 0);
-
-	/* Allow IPIs again... */
-	xics_set_cpu_priority(DEFAULT_PRIORITY);
-
-	for_each_irq(virq) {
-		struct irq_desc *desc;
-		int xics_status[2];
-		int status;
-		unsigned long flags;
-
-		/* We cant set affinity on ISA interrupts */
-		if (virq < NUM_ISA_INTERRUPTS)
-			continue;
-		if (irq_map[virq].host != xics_host)
-			continue;
-		irq = (unsigned int)irq_map[virq].hwirq;
-		/* We need to get IPIs still. */
-		if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
-			continue;
-		desc = irq_to_desc(virq);
-
-		/* We only need to migrate enabled IRQS */
-		if (desc == NULL || desc->chip == NULL
-		    || desc->action == NULL
-		    || desc->chip->set_affinity == NULL)
-			continue;
-
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
-		status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
-		if (status) {
-			printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
-					__func__, irq, status);
-			goto unlock;
-		}
-
-		/*
-		 * We only support delivery to all cpus or to one cpu.
-		 * The irq has to be migrated only in the single cpu
-		 * case.
-		 */
-		if (xics_status[0] != hw_cpu)
-			goto unlock;
-
-		/* This is expected during cpu offline. */
-		if (cpu_online(cpu))
-			printk(KERN_WARNING "IRQ %u affinity broken off cpu %u\n",
-			       virq, cpu);
-
-		/* Reset affinity to all cpus */
-		cpumask_setall(irq_to_desc(virq)->affinity);
-		desc->chip->set_affinity(virq, cpu_all_mask);
-unlock:
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-	}
-}
-#endif
diff --git a/arch/powerpc/platforms/pseries/xics.h b/arch/powerpc/platforms/pseries/xics.h
deleted file mode 100644
index d1d5a83..0000000
--- a/arch/powerpc/platforms/pseries/xics.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/powerpc/platforms/pseries/xics.h
- *
- * Copyright 2000 IBM Corporation.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#ifndef _POWERPC_KERNEL_XICS_H
-#define _POWERPC_KERNEL_XICS_H
-
-extern void xics_init_IRQ(void);
-extern void xics_setup_cpu(void);
-extern void xics_teardown_cpu(void);
-extern void xics_kexec_teardown_cpu(int secondary);
-extern void xics_migrate_irqs_away(void);
-extern int smp_xics_probe(void);
-extern void smp_xics_message_pass(int target, int msg);
-
-#endif /* _POWERPC_KERNEL_XICS_H */
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 3965828..cfc1877 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -12,3 +12,6 @@ config PPC_MSI_BITMAP
 	depends on PCI_MSI
 	default y if MPIC
 	default y if FSL_PCI
+
+source "arch/powerpc/sysdev/xics/Kconfig"
+
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9c29734..2b82081 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -57,3 +57,7 @@ obj-$(CONFIG_PPC_MPC52xx)	+= mpc5xxx_clocks.o
 ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_6xx)		+= 6xx-suspend.o
 endif
+
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
+obj-$(CONFIG_PPC_XICS)		+= xics/
diff --git a/arch/powerpc/sysdev/xics/Kconfig b/arch/powerpc/sysdev/xics/Kconfig
new file mode 100644
index 0000000..123b8dd
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/Kconfig
@@ -0,0 +1,12 @@
+config PPC_XICS
+       def_bool n
+
+config PPC_ICP_NATIVE
+       def_bool n
+
+config PPC_ICP_HV
+       def_bool n
+
+config PPC_ICS_RTAS
+       def_bool n
+
diff --git a/arch/powerpc/sysdev/xics/Makefile b/arch/powerpc/sysdev/xics/Makefile
new file mode 100644
index 0000000..b75a605
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/Makefile
@@ -0,0 +1,6 @@
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
+obj-y				+= xics-common.o
+obj-$(CONFIG_PPC_ICP_NATIVE)	+= icp-native.o
+obj-$(CONFIG_PPC_ICP_HV)	+= icp-hv.o
+obj-$(CONFIG_PPC_ICS_RTAS)	+= ics-rtas.o
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
new file mode 100644
index 0000000..8633fa1
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright 2011 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+
+#include <asm/smp.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+#include <asm/xics.h>
+#include <asm/io.h>
+
+static inline unsigned int icp_hv_get_xirr(unsigned char cppr)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall(H_XIRR, retbuf, cppr);
+	if (rc != H_SUCCESS)
+		panic(" bad return code xirr - rc = %lx\n", rc);
+	return (unsigned int)retbuf[0];
+}
+
+static inline void icp_hv_set_xirr(unsigned int value)
+{
+	long rc = plpar_hcall_norets(H_EOI, value);
+	if (rc != H_SUCCESS)
+		panic("bad return code EOI - rc = %ld, value=%x\n", rc, value);
+}
+
+static inline void icp_hv_set_cppr(u8 value)
+{
+	long rc = plpar_hcall_norets(H_CPPR, value);
+	if (rc != H_SUCCESS)
+		panic("bad return code cppr - rc = %lx\n", rc);
+}
+
+static inline void icp_hv_set_qirr(int n_cpu , u8 value)
+{
+	long rc = plpar_hcall_norets(H_IPI, get_hard_smp_processor_id(n_cpu),
+				     value);
+	if (rc != H_SUCCESS)
+		panic("bad return code qirr - rc = %lx\n", rc);
+}
+
+static void icp_hv_eoi(unsigned int virq)
+{
+	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+
+	iosync();
+	icp_hv_set_xirr((xics_pop_cppr() << 24) | irq);
+}
+
+static void icp_hv_teardown_cpu(void)
+{
+	int cpu = smp_processor_id();
+
+	/* Clear any pending IPI */
+	icp_hv_set_qirr(cpu, 0xff);
+}
+
+static void icp_hv_flush_ipi(void)
+{
+	/* We take the ipi irq but and never return so we
+	 * need to EOI the IPI, but want to leave our priority 0
+	 *
+	 * should we check all the other interrupts too?
+	 * should we be flagging idle loop instead?
+	 * or creating some task to be scheduled?
+	 */
+
+	icp_hv_set_xirr((0x00 << 24) | XICS_IPI);
+}
+
+static unsigned int icp_hv_get_irq(void)
+{
+	unsigned int xirr = icp_hv_get_xirr(xics_cppr_top());
+	unsigned int vec = xirr & 0x00ffffff;
+	unsigned int irq;
+
+	if (vec == XICS_IRQ_SPURIOUS)
+		return NO_IRQ;
+
+	irq = irq_radix_revmap_lookup(xics_host, vec);
+	if (likely(irq != NO_IRQ)) {
+		xics_push_cppr(vec);
+		return irq;
+	}
+
+	/* We don't have a linux mapping, so have rtas mask it. */
+	xics_mask_unknown_vec(vec);
+
+	/* We might learn about it later, so EOI it */
+	icp_hv_set_xirr(xirr);
+
+	return NO_IRQ;
+}
+
+static void icp_hv_set_cpu_priority(unsigned char cppr)
+{
+	xics_set_base_cppr(cppr);
+	icp_hv_set_cppr(cppr);
+	iosync();
+}
+
+#ifdef CONFIG_SMP
+
+static inline void icp_hv_do_message(int cpu, int msg)
+{
+	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
+
+	set_bit(msg, tgt);
+	mb();
+	icp_hv_set_qirr(cpu, IPI_PRIORITY);
+}
+
+static void icp_hv_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		icp_hv_do_message(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			icp_hv_do_message(i, msg);
+		}
+	}
+}
+
+static irqreturn_t icp_hv_ipi_action(int irq, void *dev_id)
+{
+	int cpu = smp_processor_id();
+
+	icp_hv_set_qirr(cpu, 0xff);
+
+	return xics_ipi_dispatch(cpu);
+}
+
+#endif /* CONFIG_SMP */
+
+static const struct icp_ops icp_hv_ops = {
+	.get_irq	= icp_hv_get_irq,
+	.eoi		= icp_hv_eoi,
+	.set_priority	= icp_hv_set_cpu_priority,
+	.teardown_cpu	= icp_hv_teardown_cpu,
+	.flush_ipi	= icp_hv_flush_ipi,
+#ifdef CONFIG_SMP
+	.ipi_action	= icp_hv_ipi_action,
+	.message_pass	= icp_hv_message_pass,
+#endif
+};
+
+int icp_hv_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "ibm,ppc-xicp");
+	if (!np)
+		np = of_find_node_by_type(NULL,
+				    "PowerPC-External-Interrupt-Presentation");
+	if (!np)
+		return -ENODEV;
+	
+	icp_ops = &icp_hv_ops;	
+
+	return 0;
+}
+
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
new file mode 100644
index 0000000..a27239f
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -0,0 +1,312 @@
+/*
+ * Copyright 2011 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+
+#include <asm/prom.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+#include <asm/xics.h>
+
+struct icp_ipl {
+	union {
+		u32 word;
+		u8 bytes[4];
+	} xirr_poll;
+	union {
+		u32 word;
+		u8 bytes[4];
+	} xirr;
+	u32 dummy;
+	union {
+		u32 word;
+		u8 bytes[4];
+	} qirr;
+	u32 link_a;
+	u32 link_b;
+	u32 link_c;
+};
+
+static struct icp_ipl __iomem *icp_native_regs[NR_CPUS];
+
+static inline unsigned int icp_native_get_xirr(void)
+{
+	int cpu = smp_processor_id();
+
+	return in_be32(&icp_native_regs[cpu]->xirr.word);
+}
+
+static inline void icp_native_set_xirr(unsigned int value)
+{
+	int cpu = smp_processor_id();
+
+	out_be32(&icp_native_regs[cpu]->xirr.word, value);
+}
+
+static inline void icp_native_set_cppr(u8 value)
+{
+	int cpu = smp_processor_id();
+
+	out_8(&icp_native_regs[cpu]->xirr.bytes[0], value);
+}
+
+static inline void icp_native_set_qirr(int n_cpu, u8 value)
+{
+	out_8(&icp_native_regs[n_cpu]->qirr.bytes[0], value);
+}
+
+static void icp_native_set_cpu_priority(unsigned char cppr)
+{
+	xics_set_base_cppr(cppr);
+	icp_native_set_cppr(cppr);
+	iosync();
+}
+
+static void icp_native_eoi(unsigned int virq)
+{
+	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+
+	iosync();
+	icp_native_set_xirr((xics_pop_cppr() << 24) | irq);
+}
+
+static void icp_native_teardown_cpu(void)
+{
+	int cpu = smp_processor_id();
+
+	/* Clear any pending IPI */
+	icp_native_set_qirr(cpu, 0xff);
+}
+
+static void icp_native_flush_ipi(void)
+{
+	/* We take the ipi irq but and never return so we
+	 * need to EOI the IPI, but want to leave our priority 0
+	 *
+	 * should we check all the other interrupts too?
+	 * should we be flagging idle loop instead?
+	 * or creating some task to be scheduled?
+	 */
+
+	icp_native_set_xirr((0x00 << 24) | XICS_IPI);
+}
+
+static unsigned int icp_native_get_irq(void)
+{
+	unsigned int xirr = icp_native_get_xirr();
+	unsigned int vec = xirr & 0x00ffffff;
+	unsigned int irq;
+
+	if (vec == XICS_IRQ_SPURIOUS)
+		return NO_IRQ;
+
+	irq = irq_radix_revmap_lookup(xics_host, vec);
+	if (likely(irq != NO_IRQ)) {
+		xics_push_cppr(vec);
+		return irq;
+	}
+
+	/* We don't have a linux mapping, so have rtas mask it. */
+	xics_mask_unknown_vec(vec);
+
+	/* We might learn about it later, so EOI it */
+	icp_native_set_xirr(xirr);
+
+	return NO_IRQ;
+}
+
+#ifdef CONFIG_SMP
+
+static inline void icp_native_do_message(int cpu, int msg)
+{
+	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
+
+	set_bit(msg, tgt);
+	mb();
+	icp_native_set_qirr(cpu, IPI_PRIORITY);
+}
+
+static void icp_native_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		icp_native_do_message(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			icp_native_do_message(i, msg);
+		}
+	}
+}
+
+static irqreturn_t icp_native_ipi_action(int irq, void *dev_id)
+{
+	int cpu = smp_processor_id();
+
+	icp_native_set_qirr(cpu, 0xff);
+
+	return xics_ipi_dispatch(cpu);
+}
+
+#endif /* CONFIG_SMP */
+
+static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
+					 unsigned long size)
+{
+	char *rname;
+	int i, cpu = -1;
+
+	/* This may look gross but it's good enough for now, we don't quite
+	 * have a hard -> linux processor id matching.
+	 */
+	for_each_possible_cpu(i) {
+		if (!cpu_present(i))
+			continue;
+		if (hw_id == get_hard_smp_processor_id(i)) {
+			cpu = i;
+			break;
+		}
+	}
+
+	/* Fail, skip that CPU. Don't print, it's normal, some XICS come up
+	 * with way more entries in there than you have CPUs
+	 */
+	if (cpu == -1)
+		return 0;
+
+	rname = kasprintf(GFP_KERNEL, "CPU %d [0x%x] Interrupt Presentation",
+			  cpu, hw_id);
+
+	if (!request_mem_region(addr, size, rname)) {
+		pr_warning("icp_native: Could not reserve ICP MMIO"
+			   " for CPU %d, interrupt server #0x%x\n",
+			   cpu, hw_id);
+		return -EBUSY;
+	}
+
+	icp_native_regs[cpu] = ioremap(addr, size);
+	if (!icp_native_regs[cpu]) {
+		pr_warning("icp_native: Failed ioremap for CPU %d, "
+			   "interrupt server #0x%x, addr %#lx\n",
+			   cpu, hw_id, addr);
+		release_mem_region(addr, size);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int __init icp_native_init_one_node(struct device_node *np,
+					   unsigned int *indx)
+{
+	unsigned int ilen;
+	const u32 *ireg;
+	int i;
+	int reg_tuple_size;
+	int num_servers = 0;
+
+	/* This code does the theorically broken assumption that the interrupt
+	 * server numbers are the same as the hard CPU numbers.
+	 * This happens to be the case so far but we are playing with fire...
+	 * should be fixed one of these days. -BenH.
+	 */
+	ireg = of_get_property(np, "ibm,interrupt-server-ranges", &ilen);
+
+	/* Do that ever happen ? we'll know soon enough... but even good'old
+	 * f80 does have that property ..
+	 */
+	WARN_ON((ireg == NULL) || (ilen != 2*sizeof(u32)));
+
+	if (ireg) {
+		*indx = of_read_number(ireg, 1);
+		if (ilen >= 2*sizeof(u32))
+			num_servers = of_read_number(ireg + 1, 1);
+	}
+
+	ireg = of_get_property(np, "reg", &ilen);
+	if (!ireg) {
+		pr_err("icp_native: Can't find interrupt reg property");
+		return -1;
+	}
+
+	reg_tuple_size = (of_n_addr_cells(np) + of_n_size_cells(np)) * 4;
+	if (((ilen % reg_tuple_size) != 0)
+	    || (num_servers && (num_servers != (ilen / reg_tuple_size)))) {
+		pr_err("icp_native: ICP reg len (%d) != num servers (%d)",
+		       ilen / reg_tuple_size, num_servers);
+		return -1;
+	}
+
+	for (i = 0; i < (ilen / reg_tuple_size); i++) {
+		struct resource r;
+		int err;
+
+		err = of_address_to_resource(np, i, &r);
+		if (err) {
+			pr_err("icp_native: Could not translate ICP MMIO"
+			       " for interrupt server 0x%x (%d)\n", *indx, err);
+			return -1;
+		}
+
+		if (icp_native_map_one_cpu(*indx, r.start, r.end - r.start))
+			return -1;
+
+		(*indx)++;
+	}
+	return 0;
+}
+
+static const struct icp_ops icp_native_ops = {
+	.get_irq	= icp_native_get_irq,
+	.eoi		= icp_native_eoi,
+	.set_priority	= icp_native_set_cpu_priority,
+	.teardown_cpu	= icp_native_teardown_cpu,
+	.flush_ipi	= icp_native_flush_ipi,
+#ifdef CONFIG_SMP
+	.ipi_action	= icp_native_ipi_action,
+	.message_pass	= icp_native_message_pass,
+#endif
+};
+
+int icp_native_init(void)
+{
+	struct device_node *np;
+	u32 indx = 0;
+	int found = 0;
+
+	for_each_compatible_node(np, NULL, "ibm,ppc-xicp")
+		if (icp_native_init_one_node(np, &indx) == 0)
+			found = 1;
+	if (!found) {
+		for_each_node_by_type(np,
+			"PowerPC-External-Interrupt-Presentation") {
+				if (icp_native_init_one_node(np, &indx) == 0)
+					found = 1;
+		}
+	}
+
+	if (found == 0)
+		return -ENODEV;
+
+	icp_ops = &icp_native_ops;
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
new file mode 100644
index 0000000..192d794
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -0,0 +1,231 @@
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <linux/msi.h>
+
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+#include <asm/xics.h>
+#include <asm/rtas.h>
+
+/* RTAS service tokens */
+static int ibm_get_xive;
+static int ibm_set_xive;
+static int ibm_int_on;
+static int ibm_int_off;
+
+static int ics_rtas_map(struct ics *ics, unsigned int virq);
+static void ics_rtas_mask_unknown(struct ics *ics, unsigned long vec);
+static long ics_rtas_get_server(struct ics *ics, unsigned long vec);
+
+/* Only one global & state struct ics */
+static struct ics ics_rtas = {
+	.map		= ics_rtas_map,
+	.mask_unknown	= ics_rtas_mask_unknown,
+	.get_server	= ics_rtas_get_server,
+};
+
+static void ics_rtas_unmask_irq(unsigned int virq)
+{
+	unsigned int irq;
+	int call_status;
+	int server;
+
+	pr_devel("xics: unmask virq %d\n", virq);
+
+	irq = (unsigned int)irq_map[virq].hwirq;
+	pr_devel(" -> map to hwirq 0x%x\n", irq);
+	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		return;
+
+	server = xics_get_irq_server(virq, irq_to_desc(virq)->affinity, 0);
+
+	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
+				DEFAULT_PRIORITY);
+	if (call_status != 0) {
+		printk(KERN_ERR
+			"%s: ibm_set_xive irq %u server %x returned %d\n",
+			__func__, irq, server, call_status);
+		return;
+	}
+
+	/* Now unmask the interrupt (often a no-op) */
+	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
+	if (call_status != 0) {
+		printk(KERN_ERR "%s: ibm_int_on irq=%u returned %d\n",
+			__func__, irq, call_status);
+		return;
+	}
+}
+
+static unsigned int ics_rtas_startup(unsigned int virq)
+{
+	/*
+	 * The generic MSI code returns with the interrupt disabled on the
+	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
+	 * at that level, so we do it here by hand.
+	 */
+	if (irq_to_desc(virq)->msi_desc)
+		unmask_msi_irq(irq_get_irq_data(virq));
+
+	/* unmask it */
+	ics_rtas_unmask_irq(virq);
+	return 0;
+}
+
+static void ics_rtas_mask_real_irq(unsigned int irq)
+{
+	int call_status;
+
+	if (irq == XICS_IPI)
+		return;
+
+	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
+	if (call_status != 0) {
+		printk(KERN_ERR "%s: ibm_int_off irq=%u returned %d\n",
+			__func__, irq, call_status);
+		return;
+	}
+
+	/* Have to set XIVE to 0xff to be able to remove a slot */
+	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq,
+				xics_default_server, 0xff);
+	if (call_status != 0) {
+		printk(KERN_ERR "%s: ibm_set_xive(0xff) irq=%u returned %d\n",
+			__func__, irq, call_status);
+		return;
+	}
+}
+
+static void ics_rtas_mask_irq(unsigned int virq)
+{
+	unsigned int irq;
+
+	pr_devel("xics: mask virq %d\n", virq);
+
+	irq = (unsigned int)irq_map[virq].hwirq;
+	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		return;
+	ics_rtas_mask_real_irq(irq);
+}
+
+static int ics_rtas_set_affinity(unsigned int virq,
+				 const struct cpumask *cpumask)
+{
+	unsigned int irq;
+	int status;
+	int xics_status[2];
+	int irq_server;
+
+	irq = (unsigned int)irq_map[virq].hwirq;
+	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		return -1;
+
+	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
+
+	if (status) {
+		printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
+			__func__, irq, status);
+		return -1;
+	}
+
+	irq_server = xics_get_irq_server(virq, cpumask, 1);
+	if (irq_server == -1) {
+		char cpulist[128];
+		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
+		printk(KERN_WARNING
+			"%s: No online cpus in the mask %s for irq %d\n",
+			__func__, cpulist, virq);
+		return -1;
+	}
+
+	status = rtas_call(ibm_set_xive, 3, 1, NULL,
+				irq, irq_server, xics_status[1]);
+
+	if (status) {
+		printk(KERN_ERR "%s: ibm,set-xive irq=%u returns %d\n",
+			__func__, irq, status);
+		return -1;
+	}
+
+	return 0;
+}
+
+static struct irq_chip ics_rtas_irq_chip = {
+	.name = "XICS",
+	.startup = ics_rtas_startup,
+	.mask = ics_rtas_mask_irq,
+	.unmask = ics_rtas_unmask_irq,
+	.eoi = NULL, /* Patched at init time */
+	.set_affinity = ics_rtas_set_affinity
+};
+
+static int ics_rtas_map(struct ics *ics, unsigned int virq)
+{
+	unsigned int hw_irq = (unsigned int)irq_map[virq].hwirq;
+	int status[2];
+	int rc;
+
+	if (WARN_ON(hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS))
+		return -EINVAL;
+
+	/* Check if RTAS knows about this interrupt */
+	rc = rtas_call(ibm_get_xive, 1, 3, status, hw_irq);
+	if (rc)
+		return -ENXIO;
+	
+	set_irq_chip_and_handler(virq, &ics_rtas_irq_chip, handle_fasteoi_irq);
+	set_irq_chip_data(virq, &ics_rtas);
+
+	return 0;
+}
+
+static void ics_rtas_mask_unknown(struct ics *ics, unsigned long vec)
+{
+	ics_rtas_mask_real_irq(vec);
+}
+
+static long ics_rtas_get_server(struct ics *ics, unsigned long vec)
+{
+	int rc, status[2];
+	
+	rc = rtas_call(ibm_get_xive, 1, 3, status, vec);
+	if (rc)
+		return -1;
+	return status[0];
+}
+
+int ics_rtas_init(void)
+{
+	ibm_get_xive = rtas_token("ibm,get-xive");
+	ibm_set_xive = rtas_token("ibm,set-xive");
+	ibm_int_on  = rtas_token("ibm,int-on");
+	ibm_int_off = rtas_token("ibm,int-off");
+
+	/* We enable the RTAS "ICS" if RTAS is present with the
+	 * appropriate tokens
+	 */
+	if (ibm_get_xive == RTAS_UNKNOWN_SERVICE ||
+	    ibm_set_xive == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	/* We need to patch our irq chip's EOI to point to the
+	 * right ICP
+	 */
+	ics_rtas_irq_chip.eoi = icp_ops->eoi;
+
+	/* Register ourselves */
+	xics_register_ics(&ics_rtas);
+
+	return 0;
+}
+
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
new file mode 100644
index 0000000..fdf43c0
--- /dev/null
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -0,0 +1,458 @@
+/*
+ * Copyright 2011 IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/types.h>
+#include <linux/threads.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/debugfs.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <asm/prom.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/errno.h>
+#include <asm/rtas.h>
+#include <asm/xics.h>
+#include <asm/firmware.h>
+
+/* Globals common to all ICP/ICS implementations */
+const struct icp_ops	*icp_ops;
+
+unsigned int xics_default_server		= 0xff;
+unsigned int xics_default_distrib_server	= 0;
+unsigned int xics_interrupt_server_size		= 8;
+
+DEFINE_PER_CPU(struct xics_cppr, xics_cppr);
+
+struct irq_host *xics_host;
+
+static LIST_HEAD(ics_list);
+
+void xics_update_irq_servers(void)
+{
+	int i, j;
+	struct device_node *np;
+	u32 ilen;
+	const u32 *ireg;
+	u32 hcpuid;
+
+	/* Find the server numbers for the boot cpu. */
+	np = of_get_cpu_node(boot_cpuid, NULL);
+	BUG_ON(!np);
+
+	hcpuid = get_hard_smp_processor_id(boot_cpuid);
+	xics_default_server = hcpuid;
+
+	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+	if (!ireg) {
+		of_node_put(np);
+		return;
+	}
+
+	i = ilen / sizeof(int);
+
+	/* Global interrupt distribution server is specified in the last
+	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
+	 * entry fom this property for current boot cpu id and use it as
+	 * default distribution server
+	 */
+	for (j = 0; j < i; j += 2) {
+		if (ireg[j] == hcpuid) {
+			xics_default_distrib_server = ireg[j+1];
+		}
+	}
+
+	of_node_put(np);
+}
+
+/* GIQ stuff, currently only supported on RTAS setups, will have
+ * to be sorted properly for bare metal
+ */
+void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
+{
+#ifdef CONFIG_PPC_RTAS
+	int index;
+	int status;
+
+	if (!rtas_indicator_present(GLOBAL_INTERRUPT_QUEUE, NULL))
+		return;
+
+	index = (1UL << xics_interrupt_server_size) - 1 - gserver;
+
+	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE, index, join);
+
+	WARN(status < 0, "set-indicator(%d, %d, %u) returned %d\n",
+	     GLOBAL_INTERRUPT_QUEUE, index, join, status);
+#endif
+}
+
+void xics_setup_cpu(void)
+{
+	icp_ops->set_priority(LOWEST_PRIORITY);
+
+	xics_set_cpu_giq(xics_default_distrib_server, 1);
+}
+
+void xics_mask_unknown_vec(unsigned int vec)
+{
+	struct ics *ics;
+
+	pr_err("Interrupt %u (real) is invalid, disabling it.\n", vec);
+
+	list_for_each_entry(ics, &ics_list, link)
+		ics->mask_unknown(ics, vec);
+}
+
+
+#ifdef CONFIG_SMP
+
+DEFINE_PER_CPU_SHARED_ALIGNED(unsigned long, xics_ipi_message);
+
+irqreturn_t xics_ipi_dispatch(int cpu)
+{
+	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
+
+	mb();	/* order mmio clearing qirr */
+	while (*tgt) {
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt)) {
+			smp_message_recv(PPC_MSG_CALL_FUNCTION);
+		}
+		if (test_and_clear_bit(PPC_MSG_RESCHEDULE, tgt)) {
+			smp_message_recv(PPC_MSG_RESCHEDULE);
+		}
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE, tgt)) {
+			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
+		}
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK, tgt)) {
+			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
+		}
+#endif
+	}
+	return IRQ_HANDLED;
+}
+
+static void xics_request_ipi(void)
+{
+	unsigned int ipi;
+
+	ipi = irq_create_mapping(xics_host, XICS_IPI);
+	BUG_ON(ipi == NO_IRQ);
+
+	/*
+	 * IPIs are marked IRQF_DISABLED as they must run with irqs
+	 * disabled
+	 */
+	set_irq_handler(ipi, handle_percpu_irq);
+	BUG_ON(request_irq(ipi, icp_ops->ipi_action,
+			   IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL));
+}
+
+int __init xics_smp_probe(void)
+{
+	/* Setup message_pass callback  based on which ICP is used */
+	smp_ops->message_pass = icp_ops->message_pass;
+
+	/* Register all the IPIs */
+	xics_request_ipi();
+
+	return cpumask_weight(cpu_possible_mask);
+}
+
+#endif /* CONFIG_SMP */
+
+void xics_teardown_cpu(void)
+{
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+
+	/*
+	 * we have to reset the cppr index to 0 because we're
+	 * not going to return from the IPI
+	 */
+	os_cppr->index = 0;
+	icp_ops->set_priority(0);
+	icp_ops->teardown_cpu();
+}
+
+void xics_kexec_teardown_cpu(int secondary)
+{
+	xics_teardown_cpu();
+
+	icp_ops->flush_ipi();
+
+	/*
+	 * Some machines need to have at least one cpu in the GIQ,
+	 * so leave the master cpu in the group.
+	 */
+	if (secondary)
+		xics_set_cpu_giq(xics_default_distrib_server, 0);
+}
+
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* Interrupts are disabled. */
+void xics_migrate_irqs_away(void)
+{
+	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
+	unsigned int irq, virq;
+
+	/* If we used to be the default server, move to the new "boot_cpuid" */
+	if (hw_cpu == xics_default_server)
+		xics_update_irq_servers();
+
+	/* Reject any interrupt that was queued to us... */
+	icp_ops->set_priority(0);
+
+	/* Remove ourselves from the global interrupt queue */
+	xics_set_cpu_giq(xics_default_distrib_server, 0);
+
+	/* Allow IPIs again... */
+	icp_ops->set_priority(DEFAULT_PRIORITY);
+
+	for_each_irq(virq) {
+		struct irq_desc *desc;
+		long server;
+		unsigned long flags;
+		struct ics *ics;
+
+		/* We cant set affinity on ISA interrupts */
+		if (virq < NUM_ISA_INTERRUPTS)
+			continue;
+		if (irq_map[virq].host != xics_host)
+			continue;
+		irq = (unsigned int)irq_map[virq].hwirq;
+		/* We need to get IPIs still. */
+		if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+			continue;
+		desc = irq_to_desc(virq);
+
+		/* We only need to migrate enabled IRQS */
+		if (desc == NULL || desc->chip == NULL
+		    || desc->action == NULL
+		    || desc->chip->set_affinity == NULL)
+			continue;
+
+		raw_spin_lock_irqsave(&desc->lock, flags);
+
+		/* Locate interrupt server */
+		server = -1;
+		ics = get_irq_chip_data(virq);
+		if (ics)
+			server = ics->get_server(ics, irq);
+		if (server < 0) {
+			printk(KERN_ERR "%s: Can't find server for irq %d\n",
+			       __func__, irq);
+			goto unlock;
+		}
+
+		/* We only support delivery to all cpus or to one cpu.
+		 * The irq has to be migrated only in the single cpu
+		 * case.
+		 */
+		if (server != hw_cpu)
+			goto unlock;
+
+		/* This is expected during cpu offline. */
+		if (cpu_online(cpu))
+			printk(KERN_WARNING "IRQ %u affinity broken off cpu %u\n",
+			       virq, cpu);
+
+		/* Reset affinity to all cpus */
+		cpumask_setall(irq_to_desc(virq)->affinity);
+		desc->chip->set_affinity(virq, cpu_all_mask);
+unlock:
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+	}
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#ifdef CONFIG_SMP
+/*
+ * For the moment we only implement delivery to all cpus or one cpu.
+ *
+ * If the requested affinity is cpu_all_mask, we set global affinity.
+ * If not we set it to the first cpu in the mask, even if multiple cpus
+ * are set. This is so things like irqbalance (which set core and package
+ * wide affinities) do the right thing.
+ */
+int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
+			unsigned int strict_check)
+{
+
+	if (!distribute_irqs)
+		return xics_default_server;
+
+	if (!cpumask_subset(cpu_possible_mask, cpumask)) {
+		int server = cpumask_first_and(cpu_online_mask, cpumask);
+
+		if (server < nr_cpu_ids)
+			return get_hard_smp_processor_id(server);
+
+		if (strict_check)
+			return -1;
+	}
+
+	/*
+	 * Workaround issue with some versions of JS20 firmware that
+	 * deliver interrupts to cpus which haven't been started. This
+	 * happens when using the maxcpus= boot option.
+	 */
+	if (cpumask_equal(cpu_online_mask, cpu_present_mask))
+		return xics_default_distrib_server;
+
+	return xics_default_server;
+}
+#endif /* CONFIG_SMP */
+
+static int xics_host_match(struct irq_host *h, struct device_node *node)
+{
+	/* IBM machines have interrupt parents of various funky types for things
+	 * like vdevices, events, etc... The trick we use here is to match
+	 * everything here except the legacy 8259 which is compatible "chrp,iic"
+	 */
+	return !of_device_is_compatible(node, "chrp,iic");
+}
+
+/* Dummies */
+static void xics_ipi_unmask(unsigned int virq) { }
+static void xics_ipi_mask(unsigned int virq) { }
+
+static struct irq_chip xics_ipi_chip = {	
+	.name = "XICS",
+	.eoi = NULL, /* Patched at init time */
+	.mask = xics_ipi_mask,
+	.unmask = xics_ipi_unmask,
+};
+
+static int xics_host_map(struct irq_host *h, unsigned int virq,
+			 irq_hw_number_t hw)
+{
+	struct ics *ics;
+
+	pr_devel("xics: map virq %d, hwirq 0x%lx\n", virq, hw);
+
+	/* Insert the interrupt mapping into the radix tree for fast lookup */
+	irq_radix_revmap_insert(xics_host, virq, hw);
+
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
+
+	/* Don't call into ICS for IPIs */
+	if (hw == XICS_IPI) {
+		set_irq_chip_and_handler(virq, &xics_ipi_chip,
+					 handle_fasteoi_irq);
+		return 0;
+	}
+
+	/* Let the ICS setup the chip data */
+	list_for_each_entry(ics, &ics_list, link)
+		if (ics->map(ics, virq) == 0)
+			break;
+	return 0;
+}
+
+static int xics_host_xlate(struct irq_host *h, struct device_node *ct,
+			   const u32 *intspec, unsigned int intsize,
+			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+
+{
+	/* Current xics implementation translates everything
+	 * to level. It is not technically right for MSIs but this
+	 * is irrelevant at this point. We might get smarter in the future
+	 */
+	*out_hwirq = intspec[0];
+	*out_flags = IRQ_TYPE_LEVEL_LOW;
+
+	return 0;
+}
+
+static struct irq_host_ops xics_host_ops = {
+	.match = xics_host_match,
+	.map = xics_host_map,
+	.xlate = xics_host_xlate,
+};
+
+static void __init xics_init_host(void)
+{
+	xics_host = irq_alloc_host(NULL, IRQ_HOST_MAP_TREE, 0, &xics_host_ops,
+				   XICS_IRQ_SPURIOUS);
+	BUG_ON(xics_host == NULL);
+	irq_set_default_host(xics_host);
+}
+
+void __init xics_register_ics(struct ics *ics)
+{
+	list_add(&ics->link, &ics_list);
+}
+
+static void __init xics_get_server_size(void)
+{
+	struct device_node *np;
+	const u32 *isize;
+
+	/* We fetch the interrupt server size from the first ICS node
+	 * we find if any
+	 */
+	np = of_find_compatible_node(NULL, NULL, "ibm,ppc-xics");
+	if (!np)
+		return;
+	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
+	if (!isize)
+		return;
+	xics_interrupt_server_size = *isize;
+	of_node_put(np);
+}
+
+void __init xics_init(void)
+{
+	int rc = -1;
+
+	/* Fist locate ICP */
+#ifdef CONFIG_PPC_ICP_HV
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		rc = icp_hv_init();
+#endif
+#ifdef CONFIG_PPC_ICP_NATIVE
+	if (rc < 0)
+		rc = icp_native_init();
+#endif
+	if (rc < 0) {
+		pr_warning("XICS: Cannot find a Presentation Controller !\n");
+		return;
+	}
+
+	/* Copy get_irq callback over to ppc_md */
+	ppc_md.get_irq = icp_ops->get_irq;
+
+	/* Patch up IPI chip EOI */
+	xics_ipi_chip.eoi = icp_ops->eoi;
+
+	/* Now locate ICS */
+#ifdef CONFIG_PPC_ICS_RTAS
+	rc = ics_rtas_init();
+#endif
+	if (rc < 0)
+		pr_warning("XICS: Cannot find a Source Controller !\n");
+
+	/* Initialize common bits */
+	xics_get_server_size();
+	xics_update_irq_servers();
+	xics_init_host();
+	xics_setup_cpu();
+}
-- 
1.7.2.3
