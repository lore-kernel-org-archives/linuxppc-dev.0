Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id D96BC2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Sep 2013 03:26:13 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] cpufreq: pmac64: provide cpufreq transition latency
 for older G5 models
Date: Sat, 31 Aug 2013 20:23:51 +0300
Message-Id: <1377969832-27699-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
References: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently cpufreq ondemand governor cannot used on older G5 models,
because the transition latency is set to CPUFREQ_ETERNAL. Provide a
value based on a measurement on Xserve G5, which happens to be also the
highest allowed latency.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/cpufreq/pmac64-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 674807d..d3d1995 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -674,8 +674,10 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	g5_cpu_freqs[0].frequency = max_freq;
 	g5_cpu_freqs[1].frequency = min_freq;
 
+	/* Based on a measurement on Xserve G5, rounded up. */
+	transition_latency = 10 * NSEC_PER_MSEC;
+
 	/* Set callbacks */
-	transition_latency = CPUFREQ_ETERNAL;
 	g5_switch_volt = g5_pfunc_switch_volt;
 	g5_switch_freq = g5_pfunc_switch_freq;
 	g5_query_freq = g5_pfunc_query_freq;
-- 
1.8.3.2
