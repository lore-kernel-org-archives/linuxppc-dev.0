Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1CB2100944
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 10:57:16 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6M0vDVR031827
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 10:57:13 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6M0vGmo1646770
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 10:57:16 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6M0vFwa017045
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 10:57:16 +1000
Subject: [PATCH v4 1/2] powerpc: cleanup APIs for cpu/thread/core mappings
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Thu, 22 Jul 2010 06:27:07 +0530
Message-ID: <20100722005707.12905.83615.stgit@drishya.in.ibm.com>
In-Reply-To: <20100722005219.12905.49197.stgit@drishya.in.ibm.com>
References: <20100722005219.12905.49197.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These APIs take logical cpu number as input
Change cpu_first_thread_in_core() to cpu_leftmost_thread_sibling()
Change cpu_last_thread_in_core() to cpu_rightmost_thread_sibling()

These APIs convert core number (index) to logical cpu/thread numbers
Add cpu_first_thread_of_core(int core)
Changed cpu_thread_to_core() to cpu_core_of_thread(int cpu)

The goal is to make 'threads_per_core' accessible to the
pseries_energy module.  Instead of making an API to read
threads_per_core, this is a higher level wrapper function to
convert from logical cpu number to core number.

The current APIs cpu_first_thread_in_core() and
cpu_last_thread_in_core() returns logical CPU number while
cpu_thread_to_core() returns core number or index which is
not a logical CPU number.  The APIs are now clearly named to
distinguish 'core number' versus first and last 'logical cpu
number' in that core.

The new APIs cpu_{left,right}most_thread_sibling() work on
logical cpu numbers.  While cpu_first_thread_of_core() and
cpu_core_of_thread() work on core index.

Example usage:  (4 threads per core system)

cpu_leftmost_thread_sibling(5) = 4
cpu_rightmost_thread_sibling(5) = 7
cpu_core_of_thread(5) = 1
cpu_first_thread_of_core(1) = 4

cpu_core_of_thread() is used in cpu_to_drc_index() in the
module and cpu_first_thread_of_core() is used in
drc_index_to_cpu() in the module.

Made API changes to few callers.  Exported symbols for use
in modules.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputhreads.h |   15 +++++++++------
 arch/powerpc/kernel/smp.c             |   19 ++++++++++++++++---
 arch/powerpc/mm/mmu_context_nohash.c  |   12 ++++++------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index a8e1844..26dc6bd 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -61,22 +61,25 @@ static inline cpumask_t cpu_online_cores_map(void)
 	return cpu_thread_mask_to_cores(cpu_online_map);
 }
 
-static inline int cpu_thread_to_core(int cpu)
-{
-	return cpu >> threads_shift;
-}
+#ifdef CONFIG_SMP
+int cpu_core_of_thread(int cpu);
+int cpu_first_thread_of_core(int core);
+#else
+static inline int cpu_core_of_thread(int cpu) { return cpu; }
+static inline int cpu_first_thread_of_core(int core) { return core; }
+#endif
 
 static inline int cpu_thread_in_core(int cpu)
 {
 	return cpu & (threads_per_core - 1);
 }
 
-static inline int cpu_first_thread_in_core(int cpu)
+static inline int cpu_leftmost_thread_sibling(int cpu)
 {
 	return cpu & ~(threads_per_core - 1);
 }
 
-static inline int cpu_last_thread_in_core(int cpu)
+static inline int cpu_rightmost_thread_sibling(int cpu)
 {
 	return cpu | (threads_per_core - 1);
 }
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5c196d1..da4c2f8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -468,7 +468,20 @@ out:
 	return id;
 }
 
-/* Must be called when no change can occur to cpu_present_mask,
+/* Helper routines for cpu to core mapping */
+int cpu_core_of_thread(int cpu)
+{
+	return cpu >> threads_shift;
+}
+EXPORT_SYMBOL_GPL(cpu_core_of_thread);
+
+int cpu_first_thread_of_core(int core)
+{
+	return core << threads_shift;
+}
+EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
+
+/* Must be called when no change can occur to cpu_present_map,
  * i.e. during cpu online or offline.
  */
 static struct device_node *cpu_to_l2cache(int cpu)
@@ -527,7 +540,7 @@ int __devinit start_secondary(void *unused)
 	notify_cpu_starting(cpu);
 	set_cpu_online(cpu, true);
 	/* Update sibling maps */
-	base = cpu_first_thread_in_core(cpu);
+	base = cpu_leftmost_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core; i++) {
 		if (cpu_is_offline(base + i))
 			continue;
@@ -606,7 +619,7 @@ int __cpu_disable(void)
 		return err;
 
 	/* Update sibling maps */
-	base = cpu_first_thread_in_core(cpu);
+	base = cpu_leftmost_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core; i++) {
 		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
 		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index ddfd7ad..22f3bc5 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -111,8 +111,8 @@ static unsigned int steal_context_smp(unsigned int id)
 		 * a core map instead but this will do for now.
 		 */
 		for_each_cpu(cpu, mm_cpumask(mm)) {
-			for (i = cpu_first_thread_in_core(cpu);
-			     i <= cpu_last_thread_in_core(cpu); i++)
+			for (i = cpu_leftmost_thread_sibling(cpu);
+			     i <= cpu_rightmost_thread_sibling(cpu); i++)
 				__set_bit(id, stale_map[i]);
 			cpu = i - 1;
 		}
@@ -264,14 +264,14 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	 */
 	if (test_bit(id, stale_map[cpu])) {
 		pr_hardcont(" | stale flush %d [%d..%d]",
-			    id, cpu_first_thread_in_core(cpu),
-			    cpu_last_thread_in_core(cpu));
+			    id, cpu_leftmost_thread_sibling(cpu),
+			    cpu_rightmost_thread_sibling(cpu));
 
 		local_flush_tlb_mm(next);
 
 		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
-		for (i = cpu_first_thread_in_core(cpu);
-		     i <= cpu_last_thread_in_core(cpu); i++) {
+		for (i = cpu_leftmost_thread_sibling(cpu);
+		     i <= cpu_rightmost_thread_sibling(cpu); i++) {
 			__clear_bit(id, stale_map[i]);
 		}
 	}
