Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGdtF56kqzF0fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 17:11:01 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: Don't preempt_disable() in show_cpuinfo()
Date: Wed, 10 Jan 2018 17:10:12 +1100
Message-Id: <20180110061014.29181-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This causes warnings from cpufreq mutex code. This is also
rather unnecessary and ineffective. If we really want to
prevent concurrent unplug, we could take the unplug read
lock but I don't see this being critical.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9d213542a48b..8fd3a70047f1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -242,14 +242,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned short maj;
 	unsigned short min;
 
-	/* We only show online cpus: disable preempt (overzealous, I
-	 * knew) to prevent cpu going down. */
-	preempt_disable();
-	if (!cpu_online(cpu_id)) {
-		preempt_enable();
-		return 0;
-	}
-
 #ifdef CONFIG_SMP
 	pvr = per_cpu(cpu_pvr, cpu_id);
 #else
@@ -358,9 +350,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
-
-	preempt_enable();
-
 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
 		show_cpuinfo_summary(m);
-- 
2.14.3
