Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCCXy3gFjzDrTS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 20:13:38 +1000 (AEST)
Received: by mail-pg0-x22f.google.com with SMTP id 125so5373320pgi.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 03:13:38 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux@dominikbrodowski.net, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V3 8/9] cpufreq: Add CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING cpufreq
 driver flag
Date: Wed, 19 Jul 2017 15:42:48 +0530
Message-Id: <af15ad23b687e819919eeea687ff44bb37b8e9df.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The policy->transition_latency field is used for multiple purposes
today and its not straight forward at all. This is how it is used:

A. Set the correct transition_latency value.

B. Set it to CPUFREQ_ETERNAL because:
   1. We don't want automatic dynamic switching (with
      ondemand/conservative) to happen at all.
   2. We don't know the transition latency.

This patch handles the B.1. case in a more readable way. A new flag for
the cpufreq drivers is added to disallow use of cpufreq governors which
have dynamic_switching flag set.

All the current cpufreq drivers which are setting transition_latency
unconditionally to CPUFREQ_ETERNAL are updated to use it. They don't
need to set transition_latency anymore.

There shouldn't be any functional change after this patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-nforce2.c  | 2 +-
 drivers/cpufreq/cpufreq.c          | 5 +++--
 drivers/cpufreq/elanfreq.c         | 4 +---
 drivers/cpufreq/gx-suspmod.c       | 2 +-
 drivers/cpufreq/pmac32-cpufreq.c   | 7 +++++--
 drivers/cpufreq/sa1100-cpufreq.c   | 5 +++--
 drivers/cpufreq/sa1110-cpufreq.c   | 5 +++--
 drivers/cpufreq/sh-cpufreq.c       | 3 +--
 drivers/cpufreq/speedstep-smi.c    | 2 +-
 drivers/cpufreq/unicore2-cpufreq.c | 3 +--
 include/linux/cpufreq.h            | 6 ++++++
 11 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index 5503d491b016..dbf82f36d270 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -357,7 +357,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	/* cpuinfo and default policy values */
 	policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
 	policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return 0;
 }
@@ -369,6 +368,7 @@ static int nforce2_cpu_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver nforce2_driver = {
 	.name = "nforce2",
+	.flags = CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify = nforce2_verify,
 	.target = nforce2_target,
 	.get = nforce2_get,
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2debfb5f9126..a4d9b47c4af4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2016,11 +2016,12 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 	/* Platform doesn't want dynamic frequency switching ? */
 	if (policy->governor->dynamic_switching &&
-	    policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL) {
+	    (cpufreq_driver->flags & CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING ||
+	    policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)) {
 		struct cpufreq_governor *gov = cpufreq_fallback_governor();
 
 		if (gov) {
-			pr_warn("Transition latency set to CPUFREQ_ETERNAL, can't use %s governor. Fallback to %s governor\n",
+			pr_warn("Can't use %s governor as dynamic switching is disallowed. Fallback to %s governor\n",
 				policy->governor->name, gov->name);
 			policy->governor = gov;
 		} else {
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index bfce11cba1df..45e2ca62515e 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -165,9 +165,6 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 		if (pos->frequency > max_freq)
 			pos->frequency = CPUFREQ_ENTRY_INVALID;
 
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-
 	return cpufreq_table_validate_and_show(policy, elanfreq_table);
 }
 
@@ -196,6 +193,7 @@ __setup("elanfreq=", elanfreq_setup);
 
 static struct cpufreq_driver elanfreq_driver = {
 	.get		= elanfreq_get_cpu_frequency,
+	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= elanfreq_target,
 	.init		= elanfreq_cpu_init,
diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 3488c9c175eb..8f52a06664e3 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -428,7 +428,6 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 	policy->max = maxfreq;
 	policy->cpuinfo.min_freq = maxfreq / max_duration;
 	policy->cpuinfo.max_freq = maxfreq;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return 0;
 }
@@ -438,6 +437,7 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
  *   MediaGX/Geode GX initialize cpufreq driver
  */
 static struct cpufreq_driver gx_suspmod_driver = {
+	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.get		= gx_get_cpuspeed,
 	.verify		= cpufreq_gx_verify,
 	.target		= cpufreq_gx_target,
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index ff44016ea031..61ae06ca008e 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -442,7 +442,8 @@ static struct cpufreq_driver pmac_cpufreq_driver = {
 	.init		= pmac_cpufreq_cpu_init,
 	.suspend	= pmac_cpufreq_suspend,
 	.resume		= pmac_cpufreq_resume,
-	.flags		= CPUFREQ_PM_NO_WARN,
+	.flags		= CPUFREQ_PM_NO_WARN |
+			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.attr		= cpufreq_generic_attr,
 	.name		= "powermac",
 };
@@ -626,14 +627,16 @@ static int __init pmac_cpufreq_setup(void)
 	if (!value)
 		goto out;
 	cur_freq = (*value) / 1000;
-	transition_latency = CPUFREQ_ETERNAL;
 
 	/*  Check for 7447A based MacRISC3 */
 	if (of_machine_is_compatible("MacRISC3") &&
 	    of_get_property(cpunode, "dynamic-power-step", NULL) &&
 	    PVR_VER(mfspr(SPRN_PVR)) == 0x8003) {
 		pmac_cpufreq_init_7447A(cpunode);
+
+		/* Allow dynamic switching */
 		transition_latency = 8000000;
+		pmac_cpufreq_driver.flags &= ~CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
 	/* Check for other MacRISC3 machines */
 	} else if (of_machine_is_compatible("PowerBook3,4") ||
 		   of_machine_is_compatible("PowerBook3,5") ||
diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index 728eab77e8e0..e2d8a77c36d5 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -197,11 +197,12 @@ static int sa1100_target(struct cpufreq_policy *policy, unsigned int ppcr)
 
 static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 {
-	return cpufreq_generic_init(policy, sa11x0_freq_table, CPUFREQ_ETERNAL);
+	return cpufreq_generic_init(policy, sa11x0_freq_table, 0);
 }
 
 static struct cpufreq_driver sa1100_driver __refdata = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= sa1100_target,
 	.get		= sa11x0_getspeed,
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index 2bac9b6cfeea..66e5fb088ecc 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -306,13 +306,14 @@ static int sa1110_target(struct cpufreq_policy *policy, unsigned int ppcr)
 
 static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 {
-	return cpufreq_generic_init(policy, sa11x0_freq_table, CPUFREQ_ETERNAL);
+	return cpufreq_generic_init(policy, sa11x0_freq_table, 0);
 }
 
 /* sa1110_driver needs __refdata because it must remain after init registers
  * it with cpufreq_register_driver() */
 static struct cpufreq_driver sa1110_driver __refdata = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= sa1110_target,
 	.get		= sa11x0_getspeed,
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 719c3d9f07fb..28893d435cf5 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -137,8 +137,6 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			(clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
 	}
 
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-
 	dev_info(dev, "CPU Frequencies - Minimum %u.%03u MHz, "
 	       "Maximum %u.%03u MHz.\n",
 	       policy->min / 1000, policy->min % 1000,
@@ -159,6 +157,7 @@ static int sh_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver sh_cpufreq_driver = {
 	.name		= "sh",
+	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.get		= sh_cpufreq_get,
 	.target		= sh_cpufreq_target,
 	.verify		= sh_cpufreq_verify,
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 37b30071c220..d23f24ccff38 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -266,7 +266,6 @@ static int speedstep_cpu_init(struct cpufreq_policy *policy)
 			pr_debug("workaround worked.\n");
 	}
 
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	return cpufreq_table_validate_and_show(policy, speedstep_freqs);
 }
 
@@ -290,6 +289,7 @@ static int speedstep_resume(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver speedstep_driver = {
 	.name		= "speedstep-smi",
+	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= speedstep_target,
 	.init		= speedstep_cpu_init,
diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 6f9dfa80563a..db62d9844751 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -58,13 +58,12 @@ static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
 
 	policy->min = policy->cpuinfo.min_freq = 250000;
 	policy->max = policy->cpuinfo.max_freq = 1000000;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->clk = clk_get(NULL, "MAIN_CLK");
 	return PTR_ERR_OR_ZERO(policy->clk);
 }
 
 static struct cpufreq_driver ucv2_driver = {
-	.flags		= CPUFREQ_STICKY,
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= ucv2_verify_speed,
 	.target		= ucv2_target,
 	.get		= cpufreq_generic_get,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e141dbbb9d1c..5f40522ec98c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -370,6 +370,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
 
+/*
+ * Set by drivers to disallow use of governors with "dynamic_switching" flag
+ * set.
+ */
+#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.13.0.71.gd7076ec9c9cb
