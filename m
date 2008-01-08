Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 157AEDDEB9
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:25:39 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080PXp6020709
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:25:33 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080PXuQ122746
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:25:33 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080PWtm005963
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:25:32 -0500
Message-ID: <4782C2FB.7020105@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:25:31 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
References: <4782B985.2090508@austin.ibm.com>
In-Reply-To: <4782B985.2090508@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com, lkessler@us.ibm.com,
	strosake@us.ibm.com
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
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/kernel/prom.c                 |   33 +++++++++++++
 arch/powerpc/platforms/pseries/Makefile    |    1 
 arch/powerpc/platforms/pseries/phyp_dump.c |   71 +++++++++++++++++++++++++++++
 include/asm-powerpc/phyp_dump.h            |   32 +++++++++++++
 4 files changed, 137 insertions(+)

Index: linux-2.6.24-rc2-git4/include/asm-powerpc/phyp_dump.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.24-rc2-git4/include/asm-powerpc/phyp_dump.h	2007-11-19 17:44:21.000000000 -0600
@@ -0,0 +1,32 @@
+/*
+ * Hypervisor-assisted dump
+ *
+ * Linas Vepstas, Manish Ahuja 2007
+ * Copyright (c) 2007 IBM Corp.
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
+};
+
+extern struct phyp_dump *phyp_dump_info;
+
+#endif /* CONFIG_PHYP_DUMP */
+#endif /* _PPC64_PHYP_DUMP_H */
Index: linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/phyp_dump.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/phyp_dump.c	2007-11-19 19:07:49.000000000 -0600
@@ -0,0 +1,71 @@
+/*
+ * Hypervisor-assisted dump
+ *
+ * Linas Vepstas, Manish Ahuja 2007
+ * Copyrhgit (c) 2007 IBM Corp.
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
+	for (i=start_pfn; i <= end_pfn; i++) {
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
+
+subsys_initcall(phyp_dump_setup);
Index: linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- linux-2.6.24-rc2-git4.orig/arch/powerpc/platforms/pseries/Makefile	2007-11-19 17:43:52.000000000 -0600
+++ linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/Makefile	2007-11-19 17:44:21.000000000 -0600
@@ -18,3 +18,4 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
+obj-$(CONFIG_PHYP_DUMP)	+= phyp_dump.o
Index: linux-2.6.24-rc2-git4/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.24-rc2-git4.orig/arch/powerpc/kernel/prom.c	2007-11-19 17:43:52.000000000 -0600
+++ linux-2.6.24-rc2-git4/arch/powerpc/kernel/prom.c	2007-11-19 17:44:21.000000000 -0600
@@ -51,6 +51,7 @@
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
+#include <asm/phyp_dump.h>
 #include <asm/kexec.h>
 
 #ifdef DEBUG
@@ -1011,6 +1012,37 @@ static void __init early_reserve_mem(voi
 #endif
 }
 
+#ifdef CONFIG_PHYP_DUMP
+
+/**
+ * reserve_crashed_mem() - reserve all not-yet-dumped mmemory
+ *
+ * This routine will reserve almost all of the memory in the
+ * system, except for a few hundred megabytes used to boot the
+ * new kernel. As the reserved memory is dumped to the dump
+ * device (by userland tools), it will be freed and made available.
+ */
+static void __init reserve_crashed_mem(void)
+{
+	unsigned long crashed_base, crashed_size;
+
+	/* Reserve *everything* above the RMR. We'll free this real soon. */
+	crashed_base = PHYP_DUMP_RMR_END;
+	crashed_size = lmb_end_of_DRAM() - crashed_base;
+
+	/* XXX crashed_ram_end is wrong, since it may be beyond
+	 * the memory_limit, it will need to be adjusted. */
+	lmb_reserve(crashed_base, crashed_size);
+
+	phyp_dump_info->init_reserve_start = crashed_base;
+	phyp_dump_info->init_reserve_size = crashed_size;
+}
+
+#else
+static inline void __init reserve_crashed_mem(void) {}
+#endif /* CONFIG_PHYP_DUMP */
+
+
 void __init early_init_devtree(void *params)
 {
 	DBG(" -> early_init_devtree(%p)\n", params);
@@ -1043,6 +1075,7 @@ void __init early_init_devtree(void *par
 	reserve_kdump_trampoline();
 	reserve_crashkernel();
 	early_reserve_mem();
+	reserve_crashed_mem();
 
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
