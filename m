Return-Path: <ed.swarthout@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 346081A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 07:07:35 +1000 (EST)
From: Ed Swarthout <Ed.Swarthout@freescale.com>
To: <tim.gardner@canonical.com>, <scottwood@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: ppc-corenet-cpu-freq: do_div use quotient
Date: Wed, 4 Jun 2014 15:32:53 -0500
Message-ID: <1401913973-22536-1-git-send-email-Ed.Swarthout@freescale.com>
In-Reply-To: <1398701898-68201-1-git-send-email-tim.gardner@canonical.com>
References: <1398701898-68201-1-git-send-email-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

6712d2931933ada259b82f06c03a855b19937074 (cpufreq:
ppc-corenet-cpufreq: Fix __udivdi3 modpost error) used the remainder
from do_div instead of the quotient. Fix that and add one to ensure
minimum is met.

Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 0af618a..3607070 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -138,7 +138,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *table;
 	struct cpu_data *data;
 	unsigned int cpu = policy->cpu;
-	u64 transition_latency_hz;
+	u64 u64temp;
 
 	np = of_get_cpu_node(cpu, NULL);
 	if (!np)
@@ -206,9 +206,10 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	for_each_cpu(i, per_cpu(cpu_mask, cpu))
 		per_cpu(cpu_data, i) = data;
 
-	transition_latency_hz = 12ULL * NSEC_PER_SEC;
-	policy->cpuinfo.transition_latency =
-		do_div(transition_latency_hz, fsl_get_sys_freq());
+	/* Minimum transition latency is 12 platform clocks */
+	u64temp = 12ULL * NSEC_PER_SEC;
+	do_div(u64temp, fsl_get_sys_freq());
+	policy->cpuinfo.transition_latency = u64temp + 1;
 
 	of_node_put(np);
 
-- 
1.9.1
