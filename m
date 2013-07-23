Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id 6F7E32C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 06:25:01 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Date: Tue, 23 Jul 2013 23:24:37 +0300
Message-Id: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some functions on switch path use msleep() which is inaccurate, and
depends on HZ. With HZ=100 msleep(1) takes actually over ten times longer.
Using usleep_range() we get more accurate sleeps.

I measured the "pfunc_slewing_done" polling to take 300us at max (on
2.3GHz dual-processor Xserve G5), so using 500us sleep there should
be fine.

With the patch, g5_switch_freq() duration drops from ~50ms to ~10ms on
Xserve with HZ=100.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/cpufreq/pmac64-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 7ba4234..674807d 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -141,7 +141,7 @@ static void g5_vdnap_switch_volt(int speed_mode)
 		pmf_call_one(pfunc_vdnap0_complete, &args);
 		if (done)
 			break;
-		msleep(1);
+		usleep_range(1000, 1000);
 	}
 	if (done == 0)
 		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
@@ -240,7 +240,7 @@ static void g5_pfunc_switch_volt(int speed_mode)
 		if (pfunc_cpu1_volt_low)
 			pmf_call_one(pfunc_cpu1_volt_low, NULL);
 	}
-	msleep(10); /* should be faster , to fix */
+	usleep_range(10000, 10000); /* should be faster , to fix */
 }
 
 /*
@@ -285,7 +285,7 @@ static int g5_pfunc_switch_freq(int speed_mode)
 		pmf_call_one(pfunc_slewing_done, &args);
 		if (done)
 			break;
-		msleep(1);
+		usleep_range(500, 500);
 	}
 	if (done == 0)
 		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
-- 
1.8.3.2
