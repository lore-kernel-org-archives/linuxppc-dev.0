Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id B7BACDDF65
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:30:36 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 1/3] sched: support arch override of sched_group cpu power
Date: Wed, 18 Jun 2008 19:29:32 -0500
Message-Id: <1213835374-10868-2-git-send-email-ntl@pobox.com>
In-Reply-To: <1213835374-10868-1-git-send-email-ntl@pobox.com>
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new sched domain flag, SD_ASYM_CPU_POWER, which signifies that
the architecture may override the cpu power for a cpu via a hook in
init_sched_groups_power().  Add a dummy definition of arch_cpu_power()
which conforms with the existing behavior.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 include/linux/sched.h |    1 +
 kernel/sched.c        |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5d3f84..cfbefca 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -713,6 +713,7 @@ enum cpu_idle_type {
 #define SD_SHARE_PKG_RESOURCES	512	/* Domain members share cpu pkg resources */
 #define SD_SERIALIZE		1024	/* Only a single load balancing instance */
 #define SD_WAKE_IDLE_FAR	2048	/* Gain latency sacrificing cache hit */
+#define SD_ASYM_CPU_POWER	4096	/* Domain members of unequal power */
 
 #define BALANCE_FOR_MC_POWER	\
 	(sched_smt_power_savings ? SD_POWERSAVINGS_BALANCE : 0)
diff --git a/kernel/sched.c b/kernel/sched.c
index eaf6751..3fba083 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6761,6 +6761,13 @@ static void free_sched_groups(const cpumask_t *cpu_map, cpumask_t *nodemask)
 }
 #endif
 
+#ifndef arch_cpu_power
+static inline unsigned int arch_cpu_power(int cpu, unsigned int default_power)
+{
+	return default_power;
+}
+#endif
+
 /*
  * Initialize sched groups cpu_power.
  *
@@ -6789,6 +6796,13 @@ static void init_sched_groups_power(int cpu, struct sched_domain *sd)
 
 	sd->groups->__cpu_power = 0;
 
+	if (!child && (sd->flags & SD_ASYM_CPU_POWER)) {
+		unsigned int power = arch_cpu_power(cpu, SCHED_LOAD_SCALE);
+
+		sg_inc_cpu_power(sd->groups, power);
+		return;
+	}
+
 	/*
 	 * For perf policy, if the groups in child domain share resources
 	 * (for example cores sharing some portions of the cache hierarchy
-- 
1.5.5
