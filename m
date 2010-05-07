Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4BE5B7DD0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 21:48:47 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o47BjQqu026730
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 21:45:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o47BfoXs1478904
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 21:41:50 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o47Bmj6L002861
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 21:48:45 +1000
Subject: [RFC PATCH v2 1/2] powerpc: cleanup APIs for cpu/thread/core mappings
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Fri, 07 May 2010 17:18:42 +0530
Message-ID: <20100507114842.5035.65177.stgit@drishya.in.ibm.com>
In-Reply-To: <20100507113907.5035.9794.stgit@drishya.in.ibm.com>
References: <20100507113907.5035.9794.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
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

Made API changes to few callers.  Exported symbols for use in modules.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputhreads.h |   15 +++++++++------
 arch/powerpc/kernel/smp.c             |   17 +++++++++++++++--
 arch/powerpc/mm/mmu_context_nohash.c  |   12 ++++++------
 3 files changed, 30 insertions(+), 14 deletions(-)

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
index c2ee144..02dedff 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -462,6 +462,19 @@ out:
 	return id;
 }
 
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
 /* Must be called when no change can occur to cpu_present_map,
  * i.e. during cpu online or offline.
  */
@@ -513,7 +526,7 @@ int __devinit start_secondary(void *unused)
 	notify_cpu_starting(cpu);
 	set_cpu_online(cpu, true);
 	/* Update sibling maps */
-	base = cpu_first_thread_in_core(cpu);
+	base = cpu_leftmost_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core; i++) {
 		if (cpu_is_offline(base + i))
 			continue;
@@ -589,7 +602,7 @@ int __cpu_disable(void)
 		return err;
 
 	/* Update sibling maps */
-	base = cpu_first_thread_in_core(cpu);
+	base = cpu_leftmost_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core; i++) {
 		cpu_clear(cpu, per_cpu(cpu_sibling_map, base + i));
 		cpu_clear(base + i, per_cpu(cpu_sibling_map, cpu));
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 1f2d9ff..7c66e82 100644
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
