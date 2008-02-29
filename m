Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6FB8DDE46
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 11:24:52 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1T0OmAW024756
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:24:48 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1T0Omm3193318
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:24:48 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1T0OmGx015154
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:24:48 -0500
Message-ID: <47C750CE.7050202@austin.ibm.com>
Date: Thu, 28 Feb 2008 18:24:46 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
References: <47B90F55.2080606@austin.ibm.com>	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com>
In-Reply-To: <47C74A66.1060105@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Initial patch for reserving memory in early boot, and freeing it later.
If the previous boot had ended with a crash, the reserved memory would contain
a copy of the crashed kernel data.

Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

----
 arch/powerpc/kernel/prom.c                 |   49 +++++++++++++
 arch/powerpc/platforms/pseries/Makefile    |    1 
 arch/powerpc/platforms/pseries/phyp_dump.c |  105 +++++++++++++++++++++++++++++
 include/asm-powerpc/phyp_dump.h            |   44 ++++++++++++
 4 files changed, 199 insertions(+)

Index: 2.6.25-rc1/include/asm-powerpc/phyp_dump.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.25-rc1/include/asm-powerpc/phyp_dump.h	2008-02-28 22:05:25.000000000 -0600
@@ -0,0 +1,44 @@
+/*
+ * Hypervisor-assisted dump
+ *
+ * Linas Vepstas, Manish Ahuja 2008
+ * Copyright 2008 IBM Corp.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _PPC64_PHYP_DUMP_H
+#define _PPC64_PHYP_DUMP_H
+
+#ifdef CONFIG_PHYP_DUMP
+
+/* The RMR region will be saved for later dumping
+ * whenever the kernel crashes. Set this to 256MB. */
+#define PHYP_DUMP_RMR_START 0x0
+#define PHYP_DUMP_RMR_END   (1UL<<28)
+
+struct phyp_dump {
+	/* Memory that is reserved during very early boot. */
+	unsigned long init_reserve_start;
+	unsigned long init_reserve_size;
+	/* Check status during boot if dump supported, active & present*/
+	unsigned long phyp_dump_configured;
+	unsigned long phyp_dump_is_active;
+	/* store cpu & hpte size */
+	unsigned long cpu_state_size;
+	unsigned long hpte_region_size;
+};
+
+extern struct phyp_dump *phyp_dump_info;
+
+int early_init_dt_scan_phyp_dump(unsigned long node,
+		const char *uname, int depth, void *data);
+#else /* CONFIG_PHYP_DUMP */
+int early_init_dt_scan_phyp_dump(unsigned long node,
+		const char *uname, int depth, void *data) { return 0; }
+
+#endif /* CONFIG_PHYP_DUMP */
+#endif /* _PPC64_PHYP_DUMP_H */
Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-28 21:57:52.000000000 -0600
@@ -0,0 +1,105 @@
+/*
+ * Hypervisor-assisted dump
+ *
+ * Linas Vepstas, Manish Ahuja 2008
+ * Copyright 2008 IBM Corp.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/pfn.h>
+#include <linux/swap.h>
+
+#include <asm/page.h>
+#include <asm/phyp_dump.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+
+/* Global, used to communicate data between early boot and late boot */
+static struct phyp_dump phyp_dump_global;
+struct phyp_dump *phyp_dump_info = &phyp_dump_global;
+
+/**
+ * release_memory_range -- release memory previously lmb_reserved
+ * @start_pfn: starting physical frame number
+ * @nr_pages: number of pages to free.
+ *
+ * This routine will release memory that had been previously
+ * lmb_reserved in early boot. The released memory becomes
+ * available for genreal use.
+ */
+static void
+release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
+{
+	struct page *rpage;
+	unsigned long end_pfn;
+	long i;
+
+	end_pfn = start_pfn + nr_pages;
+
+	for (i = start_pfn; i <= end_pfn; i++) {
+		rpage = pfn_to_page(i);
+		if (PageReserved(rpage)) {
+			ClearPageReserved(rpage);
+			init_page_count(rpage);
+			__free_page(rpage);
+			totalram_pages++;
+		}
+	}
+}
+
+static int __init phyp_dump_setup(void)
+{
+	unsigned long start_pfn, nr_pages;
+
+	/* If no memory was reserved in early boot, there is nothing to do */
+	if (phyp_dump_info->init_reserve_size == 0)
+		return 0;
+
+	/* Release memory that was reserved in early boot */
+	start_pfn = PFN_DOWN(phyp_dump_info->init_reserve_start);
+	nr_pages = PFN_DOWN(phyp_dump_info->init_reserve_size);
+	release_memory_range(start_pfn, nr_pages);
+
+	return 0;
+}
+machine_subsys_initcall(pseries, phyp_dump_setup);
+
+int __init early_init_dt_scan_phyp_dump(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+#ifdef CONFIG_PHYP_DUMP
+	const unsigned int *sizes;
+
+	phyp_dump_info->phyp_dump_configured = 0;
+	phyp_dump_info->phyp_dump_is_active = 0;
+
+	if (depth != 1 || strcmp(uname, "rtas") != 0)
+		return 0;
+
+	if (of_get_flat_dt_prop(node, "ibm,configure-kernel-dump", NULL))
+		phyp_dump_info->phyp_dump_configured++;
+
+	if (of_get_flat_dt_prop(node, "ibm,dump-kernel", NULL))
+		phyp_dump_info->phyp_dump_is_active++;
+
+	sizes = of_get_flat_dt_prop(node, "ibm,configure-kernel-dump-sizes",
+									NULL);
+	if (!sizes)
+		return 0;
+
+	if (sizes[0] == 1)
+		phyp_dump_info->cpu_state_size = *((unsigned long *)&sizes[1]);
+
+	if (sizes[3] == 2)
+		phyp_dump_info->hpte_region_size =
+						*((unsigned long *)&sizes[4]);
+#endif
+	return 1;
+}
Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/Makefile	2008-02-28 21:54:57.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/Makefile	2008-02-28 21:55:27.000000000 -0600
@@ -18,3 +18,4 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
+obj-$(CONFIG_PHYP_DUMP)	+= phyp_dump.o
Index: 2.6.25-rc1/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/kernel/prom.c	2008-02-28 21:54:57.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/kernel/prom.c	2008-02-28 21:55:27.000000000 -0600
@@ -51,6 +51,7 @@
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
+#include <asm/phyp_dump.h>
 #include <asm/kexec.h>
 
 #ifdef DEBUG
@@ -1039,6 +1040,51 @@ static void __init early_reserve_mem(voi
 #endif
 }
 
+#ifdef CONFIG_PHYP_DUMP
+/**
+ * reserve_crashed_mem() - reserve all not-yet-dumped mmemory
+ *
+ * This routine may reserve memory regions in the kernel only
+ * if the system is supported and a dump was taken in last
+ * boot instance or if the hardware is supported and the
+ * scratch area needs to be setup. In other instances it returns
+ * without reserving anything. The memory in case of dump being
+ * active is freed when the dump is collected (by userland tools).
+ */
+static void __init reserve_crashed_mem(void)
+{
+	unsigned long base, size;
+	if (!phyp_dump_info->phyp_dump_configured) {
+		printk(KERN_ERR "Phyp-dump not supported on this hardware\n");
+		return;
+	}
+
+	if (phyp_dump_info->phyp_dump_is_active) {
+		/* Reserve *everything* above RMR.Area freed by userland tools*/
+		base = PHYP_DUMP_RMR_END;
+		size = lmb_end_of_DRAM() - base;
+
+		/* XXX crashed_ram_end is wrong, since it may be beyond
+		 * the memory_limit, it will need to be adjusted. */
+		lmb_reserve(base, size);
+
+		phyp_dump_info->init_reserve_start = base;
+		phyp_dump_info->init_reserve_size = size;
+	} else {
+		size = phyp_dump_info->cpu_state_size +
+			phyp_dump_info->hpte_region_size +
+			PHYP_DUMP_RMR_END;
+		base = lmb_end_of_DRAM() - size;
+		lmb_reserve(base, size);
+		phyp_dump_info->init_reserve_start = base;
+		phyp_dump_info->init_reserve_size = size;
+	}
+}
+#else
+static inline void __init reserve_crashed_mem(void) {}
+#endif /* CONFIG_PHYP_DUMP  && CONFIG_PPC_RTAS */
+
+
 void __init early_init_devtree(void *params)
 {
 	DBG(" -> early_init_devtree(%p)\n", params);
@@ -1050,6 +1096,8 @@ void __init early_init_devtree(void *par
 	/* Some machines might need RTAS info for debugging, grab it now. */
 	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
 #endif
+	/* scan tree to see if dump occured during last boot */
+	of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
 
 	/* Retrieve various informations from the /chosen node of the
 	 * device-tree, including the platform type, initrd location and
@@ -1071,6 +1119,7 @@ void __init early_init_devtree(void *par
 	reserve_kdump_trampoline();
 	reserve_crashkernel();
 	early_reserve_mem();
+	reserve_crashed_mem();
 
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
