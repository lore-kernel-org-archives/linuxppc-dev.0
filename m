Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DDA31A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 11:05:48 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id eu11so968204pac.39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 18:05:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2] sched: Fix compiler warnings
Date: Tue, 24 Jun 2014 18:05:29 -0700
Message-Id: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 143e1e28cb (sched: Rework sched_domain topology definition)
introduced a number of functions with a return value of 'const int'.
gcc doesn't know what to do with that and, if the kernel is compiled
with W=1, complains with the following warnings whenever sched.h
is included.

include/linux/sched.h:875:25: warning:
	type qualifiers ignored on function return type
include/linux/sched.h:882:25: warning:
	type qualifiers ignored on function return type
include/linux/sched.h:889:25: warning:
	type qualifiers ignored on function return type
include/linux/sched.h:1002:21: warning:
	type qualifiers ignored on function return type

Commits fb2aa855 (sched, ARM: Create a dedicated scheduler topology table)
and 607b45e9a (sched, powerpc: Create a dedicated topology table) introduce
the same warning in the arm and powerpc code.

Drop 'const' from the function declarations to fix the problem.

The fix for all three patches has to be applied together to avoid
compilation failures for the affected architectures.

Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fix problem in all affected architectures with a single patch
    to avoid compilation errors.

 arch/arm/kernel/topology.c | 2 +-
 arch/powerpc/kernel/smp.c  | 2 +-
 include/linux/sched.h      | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 9d85318..e35d880 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
 		cpu_topology[cpuid].socket_id, mpidr);
 }
 
-static inline const int cpu_corepower_flags(void)
+static inline int cpu_corepower_flags(void)
 {
 	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
 }
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 51a3ff7..1007fb8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -747,7 +747,7 @@ int setup_profiling_timer(unsigned int multiplier)
 
 #ifdef CONFIG_SCHED_SMT
 /* cpumask of CPUs with asymetric SMT dependancy */
-static const int powerpc_smt_flags(void)
+static int powerpc_smt_flags(void)
 {
 	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 306f4f0..0376b05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -872,21 +872,21 @@ enum cpu_idle_type {
 #define SD_NUMA			0x4000	/* cross-node balancing */
 
 #ifdef CONFIG_SCHED_SMT
-static inline const int cpu_smt_flags(void)
+static inline int cpu_smt_flags(void)
 {
 	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
 }
 #endif
 
 #ifdef CONFIG_SCHED_MC
-static inline const int cpu_core_flags(void)
+static inline int cpu_core_flags(void)
 {
 	return SD_SHARE_PKG_RESOURCES;
 }
 #endif
 
 #ifdef CONFIG_NUMA
-static inline const int cpu_numa_flags(void)
+static inline int cpu_numa_flags(void)
 {
 	return SD_NUMA;
 }
@@ -999,7 +999,7 @@ void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
-typedef const int (*sched_domain_flags_f)(void);
+typedef int (*sched_domain_flags_f)(void);
 
 #define SDTL_OVERLAP	0x01
 
-- 
1.9.1
