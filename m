Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
 by ozlabs.org (Postfix) with ESMTP id 67CD92C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 06:25:01 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] cpufreq: pmac64: re-estimate G5 cpufreq transition latency
Date: Tue, 23 Jul 2013 23:24:38 +0300
Message-Id: <1374611079-28091-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The latency is in milliseconds scale rather than microseconds based on
measurements on iMac G5 and Xscale G5. The patch also enables to use
ondemand governor on the latter.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/cpufreq/pmac64-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 674807d..f9e399b 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -85,7 +85,8 @@ static int (*g5_query_freq)(void);
 
 static DEFINE_MUTEX(g5_switch_mutex);
 
-static unsigned long transition_latency;
+/* A conservative estimate, based on Xserve G5 and iMac G5 (iSight). */
+static const unsigned long transition_latency = 10 * NSEC_PER_MSEC;
 
 #ifdef CONFIG_PMAC_SMU
 
@@ -499,7 +500,6 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	g5_cpu_freqs[1].frequency = max_freq/2;
 
 	/* Set callbacks */
-	transition_latency = 12000;
 	g5_switch_freq = g5_scom_switch_freq;
 	g5_query_freq = g5_scom_query_freq;
 	freq_method = "SCOM";
@@ -675,7 +675,6 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	g5_cpu_freqs[1].frequency = min_freq;
 
 	/* Set callbacks */
-	transition_latency = CPUFREQ_ETERNAL;
 	g5_switch_volt = g5_pfunc_switch_volt;
 	g5_switch_freq = g5_pfunc_switch_freq;
 	g5_query_freq = g5_pfunc_query_freq;
-- 
1.8.3.2
