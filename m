Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rX0dwtzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:42:04 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t83so6059566pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:42:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/6] powerpc/watchdog: Fix marking of stuck CPUs
Date: Wed,  9 Aug 2017 22:41:25 +1000
Message-Id: <20170809124126.28907-6-npiggin@gmail.com>
In-Reply-To: <20170809124126.28907-1-npiggin@gmail.com>
References: <20170809124126.28907-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the SMP detector finds other CPUs stuck, it iterates over
them and marks them as stuck. This pulls them out of the pending
mask and allows the detector to continue with remaining good
CPUs (if nmi_watchdog=panic is not enabled).

The code to dothat was buggy because when setting a CPU stuck,
if the pending mask became empty, it resets it to keep the
watchdog running. However the iterator will continue to run
over the new pending mask and mark remaining good CPUs sas stuck.

Fix this by doing it with cpumask bitwise operations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 5a69654075c1..b84351f359ea 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -101,10 +101,10 @@ static void wd_lockup_ipi(struct pt_regs *regs)
 		nmi_panic(regs, "Hard LOCKUP");
 }
 
-static void set_cpu_stuck(int cpu, u64 tb)
+static void set_cpumask_stuck(const struct cpumask *cpumask, u64 tb)
 {
-	cpumask_set_cpu(cpu, &wd_smp_cpus_stuck);
-	cpumask_clear_cpu(cpu, &wd_smp_cpus_pending);
+	cpumask_or(&wd_smp_cpus_stuck, &wd_smp_cpus_stuck, cpumask);
+	cpumask_andnot(&wd_smp_cpus_pending, &wd_smp_cpus_pending, cpumask);
 	if (cpumask_empty(&wd_smp_cpus_pending)) {
 		wd_smp_last_reset_tb = tb;
 		cpumask_andnot(&wd_smp_cpus_pending,
@@ -112,6 +112,10 @@ static void set_cpu_stuck(int cpu, u64 tb)
 				&wd_smp_cpus_stuck);
 	}
 }
+static void set_cpu_stuck(int cpu, u64 tb)
+{
+	set_cpumask_stuck(cpumask_of(cpu), tb);
+}
 
 static void watchdog_smp_panic(int cpu, u64 tb)
 {
@@ -140,9 +144,8 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 	}
 	smp_flush_nmi_ipi(1000000);
 
-	/* Take the stuck CPU out of the watch group */
-	for_each_cpu(c, &wd_smp_cpus_pending)
-		set_cpu_stuck(c, tb);
+	/* Take the stuck CPUs out of the watch group */
+	set_cpumask_stuck(&wd_smp_cpus_pending, tb);
 
 	wd_smp_unlock(&flags);
 
-- 
2.13.3
