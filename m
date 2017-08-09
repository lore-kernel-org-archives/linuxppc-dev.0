Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rb3lm9zDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:42:07 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id t83so6059674pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:42:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6] powerpc/watchdog: add locking around init/exit functions
Date: Wed,  9 Aug 2017 22:41:26 +1000
Message-Id: <20170809124126.28907-7-npiggin@gmail.com>
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

When CPUs start and stop the watchdog, they manipulate shared data
that is normally protected by the lock. Other CPUs can be running
concurrently at this time, so it's a good idea to use locking here
to be on the safe side.

Remove the barrier which is undocumented and didn't do anything.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index b84351f359ea..2f6eadd9408d 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -300,6 +300,8 @@ static void stop_watchdog_timer_on(unsigned int cpu)
 
 static int start_wd_on_cpu(unsigned int cpu)
 {
+	unsigned long flags;
+
 	if (cpumask_test_cpu(cpu, &wd_cpus_enabled)) {
 		WARN_ON(1);
 		return 0;
@@ -314,12 +316,14 @@ static int start_wd_on_cpu(unsigned int cpu)
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return 0;
 
+	wd_smp_lock(&flags);
 	cpumask_set_cpu(cpu, &wd_cpus_enabled);
 	if (cpumask_weight(&wd_cpus_enabled) == 1) {
 		cpumask_set_cpu(cpu, &wd_smp_cpus_pending);
 		wd_smp_last_reset_tb = get_tb();
 	}
-	smp_wmb();
+	wd_smp_unlock(&flags);
+
 	start_watchdog_timer_on(cpu);
 
 	return 0;
@@ -327,12 +331,17 @@ static int start_wd_on_cpu(unsigned int cpu)
 
 static int stop_wd_on_cpu(unsigned int cpu)
 {
+	unsigned long flags;
+
 	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
 		return 0; /* Can happen in CPU unplug case */
 
 	stop_watchdog_timer_on(cpu);
 
+	wd_smp_lock(&flags);
 	cpumask_clear_cpu(cpu, &wd_cpus_enabled);
+	wd_smp_unlock(&flags);
+
 	wd_smp_clear_cpu_pending(cpu, get_tb());
 
 	return 0;
-- 
2.13.3
