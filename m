Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by ozlabs.org (Postfix) with ESMTP id 2AEB9140089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 20:04:07 +1000 (EST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by winston.telenet-ops.be (Postfix) with ESMTP id D247C1BDD4E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 11:53:33 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: ppc: Fix integer overflow in expression
Date: Thu, 17 Apr 2014 11:53:26 +0200
Message-Id: <1397728407-13909-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
References: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 32-bit, "12 * NSEC_PER_SEC" doesn't fit in "unsigned long"
(NSEC_PER_SEC is a "long" constant), causing an integer overflow:

drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init':
drivers/cpufreq/ppc-corenet-cpufreq.c:211:9: warning: integer overflow in expression [-Woverflow]

Force the intermediate to be 64-bit by adding an "ULL" suffix to the
constant multiplier to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index e78f9c806de4..53881d78a931 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -208,7 +208,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		per_cpu(cpu_data, i) = data;
 
 	policy->cpuinfo.transition_latency =
-				(12 * NSEC_PER_SEC) / fsl_get_sys_freq();
+				(12ULL * NSEC_PER_SEC) / fsl_get_sys_freq();
 	of_node_put(np);
 
 	return 0;
-- 
1.7.9.5
