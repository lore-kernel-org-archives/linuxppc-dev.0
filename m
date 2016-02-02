Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 650791A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 00:59:14 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BCE0140B93
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 00:59:14 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 2 Feb 2016 23:59:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E70D72CE8054
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 00:59:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12Dx0d661735004
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 00:59:08 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12DwZIL016065
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 00:58:36 +1100
Subject: [PATCH v2] ppc64 boot: Wait for boot cpu to show up if nr_cpus
 limit is about to hit.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Milton Miller <miltonm@us.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Date: Tue, 02 Feb 2016 19:28:17 +0530
Message-ID: <20160202135803.459.47606.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The kernel boot parameter 'nr_cpus=' allows one to specify number of
possible cpus in the system. In the normal scenario the first cpu (cpu0)
that shows up is the boot cpu and hence it gets covered under nr_cpus
limit.

But this assumption will be broken in kdump scenario where kdump kenrel
after a crash can boot up on an non-zero boot cpu. The paca structure
allocation depends on value of nr_cpus and is indexed using logical cpu
ids. This definetly will be an issue if boot cpu id > nr_cpus

This patch modifies allocate_pacas() and smp_setup_cpu_maps() to
accommodate boot cpu for the case where boot_cpuid > nr_cpu_ids.

This change would help to reduce the memory reservation requirement for
kdump on ppc64.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
Changes in V2:
- Fixed error reported by auto build test at
  https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-February/138620.html
---
 arch/powerpc/include/asm/paca.h    |    3 +++
 arch/powerpc/include/asm/smp.h     |    1 +
 arch/powerpc/kernel/paca.c         |   23 +++++++++++++++++----
 arch/powerpc/kernel/prom.c         |   39 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/setup-common.c |   25 +++++++++++++++++++++++
 5 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 70bd438..9be48b4 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -41,6 +41,9 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
+/* Maximum number of threads per core. */
+#define	MAX_SMT		8
+
 struct task_struct;
 
 /*
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 825663c..0a5b99f 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -30,6 +30,7 @@
 #include <asm/percpu.h>
 
 extern int boot_cpuid;
+extern int boot_hw_cpuid;
 extern int spinning_secondaries;
 
 extern void cpu_die(void);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 01ea0ed..96e5715 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -206,6 +206,7 @@ void __init allocate_pacas(void)
 {
 	u64 limit;
 	int cpu;
+	int nr_cpus;
 
 	limit = ppc64_rma_size;
 
@@ -218,20 +219,32 @@ void __init allocate_pacas(void)
 	limit = min(0x10000000ULL, limit);
 #endif
 
-	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
+	/*
+	 * Always align up the nr_cpu_ids to SMT threads and allocate
+	 * the paca. This will help us to prepare for a situation where
+	 * boot cpu id > nr_cpus_id. We will use the last nthreads
+	 * slots (nthreads == threads per core) to accommodate a core
+	 * that contains boot cpu thread.
+	 *
+	 * Do not change nr_cpu_ids value here. Let us do that in
+	 * early_init_dt_scan_cpus() where we know exact value
+	 * of threads per core.
+	 */
+	nr_cpus = _ALIGN_UP(nr_cpu_ids, MAX_SMT);
+	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpus);
 
 	paca = __va(memblock_alloc_base(paca_size, PAGE_SIZE, limit));
 	memset(paca, 0, paca_size);
 
 	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
-		paca_size, nr_cpu_ids, paca);
+		paca_size, nr_cpus, paca);
 
-	allocate_lppacas(nr_cpu_ids, limit);
+	allocate_lppacas(nr_cpus, limit);
 
-	allocate_slb_shadows(nr_cpu_ids, limit);
+	allocate_slb_shadows(nr_cpus, limit);
 
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+	for (cpu = 0; cpu < nr_cpus; cpu++)
 		initialise_paca(&paca[cpu], cpu);
 }
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7030b03..cbe7a7c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -291,6 +291,29 @@ static void __init check_cpu_feature_properties(unsigned long node)
 	}
 }
 
+/*
+ * Adjust the logical id of a boot cpu to fall under nr_cpu_ids. Map it to
+ * last core slot in the allocated paca array.
+ *
+ * e.g. on SMT=8 system, kernel booted with nr_cpus=1 and boot cpu = 33,
+ * align nr_cpu_ids to MAX_SMT value 8. Allocate paca array to hold up-to
+ * MAX_SMT=8 cpus. Since boot cpu 33 is greater than nr_cpus (8), adjust
+ * its logical id so that new id becomes less than nr_cpu_ids. Make sure
+ * that boot cpu's new logical id is aligned to its thread id and falls
+ * under last nthreads slots available in paca array. In this case the
+ * boot cpu 33 is adjusted to new boot cpu id 1.
+ *
+ */
+static inline void adjust_boot_cpuid(int nthreads, int phys_id)
+{
+	boot_hw_cpuid = phys_id;
+	if (boot_cpuid >= nr_cpu_ids) {
+		boot_cpuid = (boot_cpuid % nthreads) + (nr_cpu_ids - nthreads);
+		pr_info("Adjusted logical boot cpu id: logical %d physical %d\n",
+			boot_cpuid, phys_id);
+	}
+}
+
 static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -314,6 +337,18 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 
 	nthreads = len / sizeof(int);
 
+#ifdef CONFIG_SMP
+	/*
+	 * Now that we know threads per core lets align nr_cpu_ids to
+	 * correct SMT value.
+	 */
+	if (nr_cpu_ids % nthreads) {
+		nr_cpu_ids = _ALIGN_UP(nr_cpu_ids, nthreads);
+		pr_info("Aligned nr_cpus to SMT=%d, nr_cpu_ids = %d\n",
+				 nthreads, nr_cpu_ids);
+	}
+#endif
+
 	/*
 	 * Now see if any of these threads match our boot cpu.
 	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
@@ -352,7 +387,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	DBG("boot cpu: logical %d physical %d\n", found,
 	    be32_to_cpu(intserv[found_thread]));
 	boot_cpuid = found;
-	set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
+	adjust_boot_cpuid(nthreads, be32_to_cpu(intserv[found_thread]));
+	set_hard_smp_processor_id(boot_cpuid,
+					be32_to_cpu(intserv[found_thread]));
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 44c8d03..93c7e5f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -77,6 +77,7 @@ struct machdep_calls *machine_id;
 EXPORT_SYMBOL(machine_id);
 
 int boot_cpuid = -1;
+int boot_hw_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
 
 unsigned long klimit = (unsigned long) _end;
@@ -444,6 +445,7 @@ void __init smp_setup_cpu_maps(void)
 	struct device_node *dn = NULL;
 	int cpu = 0;
 	int nthreads = 1;
+	bool boot_cpu_added = false;
 
 	DBG("smp_setup_cpu_maps()\n");
 
@@ -470,6 +472,24 @@ void __init smp_setup_cpu_maps(void)
 		}
 
 		nthreads = len / sizeof(int);
+		/*
+		 * If boot cpu hasn't been added to paca and there are only
+		 * last nthreads slots available in paca array then wait
+		 * for boot cpu to show up.
+		 */
+		if (!boot_cpu_added && (cpu + nthreads) >= nr_cpu_ids) {
+			int found = 0;
+
+			DBG("Holding last nthreads paca slots for boot cpu\n");
+			for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
+				if (boot_hw_cpuid == be32_to_cpu(intserv[j])) {
+					found = 1;
+					break;
+				}
+			}
+			if (!found)
+				continue;
+		}
 
 		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			bool avail;
@@ -485,6 +505,11 @@ void __init smp_setup_cpu_maps(void)
 			set_cpu_present(cpu, avail);
 			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
+			if (boot_hw_cpuid == be32_to_cpu(intserv[j])) {
+				DBG("Boot cpu %d (hard id %d) added to paca\n",
+				    cpu, be32_to_cpu(intserv[j]));
+				boot_cpu_added = true;
+			}
 			cpu++;
 		}
 	}
