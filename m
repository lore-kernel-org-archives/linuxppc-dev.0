Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id EEED71008C1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:36 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <e23e5e19f8eade7cfa0957c2636cea1fd40aecb3.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:48 -0500
Subject: [PATCH 05/37] powerpc: Respect nr_cpu_ids when calling
	set_cpu_possible and set_cpu_present
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should not set cpus above nr_cpu_ids to possible.  While we
will trigger a warning with CONFIG_CPUMASK_DEBUG, even then the mask
initializers will set the bits beyond what the iterators check and cause
nr_cpu_ids to increase.

Respecting nr_cpu_ids during setup will allow us to use it in our initial
paca allocation.  It can be reduced from NR_CPUS by the existing early param
nr_cpus=, which was added in 2b633e3fac5efada088b57d31e65401f22bcc18f (smp:
Use nr_cpus= to set nr_cpu_ids early).  We already call parse_early_parms
between finding the command line and allocating the pacas.

Signed-off-by: Milton Miller <miltonm@bga.com>

---

Probably-not-worth-Cc: stable (2.6.34 and up)
---
 arch/powerpc/kernel/setup-common.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1475df6..fce759b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -404,7 +404,7 @@ static void __init cpu_init_thread_core_maps(int tpc)
  *                  cpu_present_mask
  *
  * Having the possible map set up early allows us to restrict allocations
- * of things like irqstacks to num_possible_cpus() rather than NR_CPUS.
+ * of things like irqstacks to nr_cpu_ids rather than NR_CPUS.
  *
  * We do not initialize the online map here; cpus set their own bits in
  * cpu_online_mask as they come up.
@@ -424,7 +424,7 @@ void __init smp_setup_cpu_maps(void)
 
 	DBG("smp_setup_cpu_maps()\n");
 
-	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < NR_CPUS) {
+	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < nr_cpu_ids) {
 		const int *intserv;
 		int j, len;
 
@@ -443,7 +443,7 @@ void __init smp_setup_cpu_maps(void)
 				intserv = &cpu;	/* assume logical == phys */
 		}
 
-		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
+		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
 			    j, cpu, intserv[j]);
 			set_cpu_present(cpu, true);
@@ -483,12 +483,12 @@ void __init smp_setup_cpu_maps(void)
 		if (cpu_has_feature(CPU_FTR_SMT))
 			maxcpus *= nthreads;
 
-		if (maxcpus > NR_CPUS) {
+		if (maxcpus > nr_cpu_ids) {
 			printk(KERN_WARNING
 			       "Partition configured for %d cpus, "
 			       "operating system maximum is %d.\n",
-			       maxcpus, NR_CPUS);
-			maxcpus = NR_CPUS;
+			       maxcpus, nr_cpu_ids);
+			maxcpus = nr_cpu_ids;
 		} else
 			printk(KERN_INFO "Partition configured for %d cpus.\n",
 			       maxcpus);
-- 
1.7.0.4
