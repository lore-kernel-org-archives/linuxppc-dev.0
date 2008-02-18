Return-Path: <ahuja@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9E8BDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 16:36:12 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1I5Zx4f004278
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:35:59 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1I5a92F141842
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 22:36:09 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1I5a9tf014467
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 22:36:09 -0700
Message-ID: <47B91947.9030604@austin.ibm.com>
Date: Sun, 17 Feb 2008 23:36:07 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
References: <47B90F55.2080606@austin.ibm.com>
In-Reply-To: <47B90F55.2080606@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com
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
 arch/powerpc/kernel/prom.c                 |   49 ++++++++++++++++++++
 arch/powerpc/kernel/rtas.c                 |   34 +++++++++++++
 arch/powerpc/platforms/pseries/Makefile    |    1 
 arch/powerpc/platforms/pseries/phyp_dump.c |   71 +++++++++++++++++++++++++++++
 include/asm-powerpc/phyp_dump.h            |   38 +++++++++++++++
 include/asm-powerpc/rtas.h                 |    3 +
 6 files changed, 196 insertions(+)

Index: 2.6.25-rc1/include/asm-powerpc/phyp_dump.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.25-rc1/include/asm-powerpc/phyp_dump.h	2008-02-18 04:30:28.000000000 -0600
@@ -0,0 +1,38 @@
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
+#endif /* CONFIG_PHYP_DUMP */
+#endif /* _PPC64_PHYP_DUMP_H */
Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-18 04:32:17.000000000 -0600
@@ -0,0 +1,71 @@
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
Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/platforms/pseries/Makefile	2008-02-18 03:22:06.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/platforms/pseries/Makefile	2008-02-18 03:23:47.000000000 -0600
@@ -18,3 +18,4 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
+obj-$(CONFIG_PHYP_DUMP)	+= phyp_dump.o
Index: 2.6.25-rc1/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/kernel/prom.c	2008-02-18 03:22:06.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/kernel/prom.c	2008-02-18 03:23:47.000000000 -0600
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
+#endif /* CONFIG_PHYP_DUMP */
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
Index: 2.6.25-rc1/arch/powerpc/kernel/rtas.c
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/kernel/rtas.c	2008-02-18 03:22:06.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/kernel/rtas.c	2008-02-18 03:23:47.000000000 -0600
@@ -39,6 +39,7 @@
 #include <asm/syscalls.h>
 #include <asm/smp.h>
 #include <asm/atomic.h>
+#include <asm/phyp_dump.h>
 
 struct rtas_t rtas = {
 	.lock = SPIN_LOCK_UNLOCKED
@@ -883,6 +884,39 @@ void __init rtas_initialize(void)
 #endif
 }
 
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
+
 int __init early_init_dt_scan_rtas(unsigned long node,
 		const char *uname, int depth, void *data)
 {
Index: 2.6.25-rc1/include/asm-powerpc/rtas.h
===================================================================
--- 2.6.25-rc1.orig/include/asm-powerpc/rtas.h	2008-02-18 03:22:06.000000000 -0600
+++ 2.6.25-rc1/include/asm-powerpc/rtas.h	2008-02-18 03:23:47.000000000 -0600
@@ -183,6 +183,9 @@ extern unsigned int rtas_busy_delay(int 
 
 extern int early_init_dt_scan_rtas(unsigned long node,
 		const char *uname, int depth, void *data);
+int early_init_dt_scan_phyp_dump(unsigned long node,
+		const char *uname, int depth, void *data);
+
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
