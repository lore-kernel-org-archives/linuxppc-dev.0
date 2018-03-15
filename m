Return-Path: <kernelfans@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401wt86KCyzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 15:42:08 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id u5so2400763pfh.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 21:42:08 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com,
 kexec@lists.infradead.org, paulus@ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Subject: [PATCHv5 1/3] powerpc,
 cpu: partially unbind the mapping between cpu logical id and its seq
 in dt
Date: Thu, 15 Mar 2018 12:41:50 +0800
Message-Id: <1521088912-31742-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
References: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For kexec -p, the boot cpu can be not the cpu0, this causes the problem
to alloc paca[]. In theory, there is no requirement to assign cpu's logical
id as its present seq by device tree. But we have something like
cpu_first_thread_sibling(), which makes assumption on the mapping inside
a core. Hence partially changing the mapping, i.e. unbind the mapping of
core while keep the mapping inside a core. After this patch, boot-cpu
will always be mapped into the range [0,threads_per_core).

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 arch/powerpc/include/asm/smp.h     |  2 ++
 arch/powerpc/kernel/prom.c         | 27 ++++++++++++++++-----------
 arch/powerpc/kernel/setup-common.c | 28 +++++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index fac963e..920a927 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -30,6 +30,8 @@
 #include <asm/percpu.h>
 
 extern int boot_cpuid;
+extern int boot_cpuhwid;
+extern int boot_dn_nthreads;
 extern int spinning_secondaries;
 
 extern void cpu_die(void);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index da67606..aca15c1 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -315,8 +315,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	const __be32 *intserv;
 	int i, nthreads;
 	int len;
-	int found = -1;
-	int found_thread = 0;
+	bool found = false;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -341,8 +340,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		if (fdt_version(initial_boot_params) >= 2) {
 			if (be32_to_cpu(intserv[i]) ==
 			    fdt_boot_cpuid_phys(initial_boot_params)) {
-				found = boot_cpu_count;
-				found_thread = i;
+				/* always map the boot-cpu logical id into the
+				 * the range of [0, thread_per_core)
+				 */
+				boot_cpuid = i;
+				boot_dn_nthreads = nthreads;
+				found = true;
 			}
 		} else {
 			/*
@@ -351,8 +354,11 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 			 * off secondary threads.
 			 */
 			if (of_get_flat_dt_prop(node,
-					"linux,boot-cpu", NULL) != NULL)
-				found = boot_cpu_count;
+					"linux,boot-cpu", NULL) != NULL) {
+				boot_cpuid = i;
+				boot_dn_nthreads = nthreads;
+				found = true;
+			}
 		}
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */
@@ -361,13 +367,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	}
 
 	/* Not the boot CPU */
-	if (found < 0)
+	if (!found)
 		return 0;
 
-	DBG("boot cpu: logical %d physical %d\n", found,
-	    be32_to_cpu(intserv[found_thread]));
-	boot_cpuid = found;
-	set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
+	boot_cpuhwid = be32_to_cpu(intserv[boot_cpuid]);
+	DBG("boot cpu: logical %d physical %d\n", boot_cpuid, boot_cpuhwid);
+	set_hard_smp_processor_id(boot_cpuid, boot_cpuhwid);
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 66f7cc6..a683ed1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -86,7 +86,11 @@ struct machdep_calls *machine_id;
 EXPORT_SYMBOL(machine_id);
 
 int boot_cpuid = -1;
+int boot_cpuhwid = -1;
+int boot_dn_nthreads = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
+EXPORT_SYMBOL_GPL(boot_cpuhwid);
+EXPORT_SYMBOL_GPL(boot_dn_nthreads);
 
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
@@ -461,6 +465,9 @@ void __init smp_setup_cpu_maps(void)
 	struct device_node *dn;
 	int cpu = 0;
 	int nthreads = 1;
+	int online_num = 0;
+	int next_cpu = boot_dn_nthreads;
+	bool btdn_handled = false;
 
 	DBG("smp_setup_cpu_maps()\n");
 
@@ -488,7 +495,21 @@ void __init smp_setup_cpu_maps(void)
 
 		nthreads = len / sizeof(int);
 
-		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
+		if (boot_cpuid < nthreads &&
+			be32_to_cpu(intserv[boot_cpuid]) == boot_cpuhwid) {
+			cpu = 0;
+			btdn_handled = true;
+		} else if ( !btdn_handled &&
+				nr_cpu_ids - online_num <= boot_dn_nthreads)
+			/* online threads in boot dn before using up quota */
+			continue;
+		else {
+			cpu = next_cpu;
+			next_cpu += nthreads;
+		}
+
+
+		for (j = 0; j < nthreads && online_num < nr_cpu_ids; j++) {
 			bool avail;
 
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
@@ -503,12 +524,13 @@ void __init smp_setup_cpu_maps(void)
 			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
 			cpu++;
+			online_num++;
 		}
-
-		if (cpu >= nr_cpu_ids) {
+		if (online_num >= nr_cpu_ids) {
 			of_node_put(dn);
 			break;
 		}
+
 	}
 
 	/* If no SMT supported, nthreads is forced to 1 */
-- 
2.7.4
