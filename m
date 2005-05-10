Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D04B679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 May 2005 15:27:20 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 10 May 2005 15:23:46 +1000
Message-Id: <1115702626.6157.28.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: small cpufreq update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch adds a missing attribute to pmac cpufreq so that
"scaling_available_frequencies" works. It also cleans up the duplicate
definitions for low and high speed constants.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: John Clemens <clemej@alum.rpi.edu>

Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2005-05-10 10:10:44.000000000 +1000
@@ -85,14 +85,11 @@
 static int has_cpu_l2lve;
 
 
-#define PMAC_CPU_LOW_SPEED	1
-#define PMAC_CPU_HIGH_SPEED	0
-
 /* There are only two frequency states for each processor. Values
  * are in kHz for the time being.
  */
-#define CPUFREQ_HIGH                  PMAC_CPU_HIGH_SPEED
-#define CPUFREQ_LOW                   PMAC_CPU_LOW_SPEED
+#define CPUFREQ_HIGH                  0
+#define CPUFREQ_LOW                   1
 
 static struct cpufreq_frequency_table pmac_cpu_freqs[] = {
 	{CPUFREQ_HIGH, 		0},
@@ -100,6 +97,11 @@
 	{0,			CPUFREQ_TABLE_END},
 };
 
+static struct freq_attr* pmac_cpu_freqs_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
 static inline void local_delay(unsigned long ms)
 {
 	if (no_schedule)
@@ -355,7 +357,7 @@
 	static unsigned long prev_l3cr;
 
 	freqs.old = cur_freq;
-	freqs.new = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
+	freqs.new = (speed_mode == CPUFREQ_HIGH) ? hi_freq : low_freq;
 	freqs.cpu = smp_processor_id();
 
 	if (freqs.old == freqs.new)
@@ -363,7 +365,7 @@
 
 	if (notify)
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	if (speed_mode == PMAC_CPU_LOW_SPEED &&
+	if (speed_mode == CPUFREQ_LOW &&
 	    cpu_has_feature(CPU_FTR_L3CR)) {
 		l3cr = _get_L3CR();
 		if (l3cr & L3CR_L3E) {
@@ -371,8 +373,8 @@
 			_set_L3CR(0);
 		}
 	}
-	set_speed_proc(speed_mode == PMAC_CPU_LOW_SPEED);
-	if (speed_mode == PMAC_CPU_HIGH_SPEED &&
+	set_speed_proc(speed_mode == CPUFREQ_LOW);
+	if (speed_mode == CPUFREQ_HIGH &&
 	    cpu_has_feature(CPU_FTR_L3CR)) {
 		l3cr = _get_L3CR();
 		if ((prev_l3cr & L3CR_L3E) && l3cr != prev_l3cr)
@@ -380,7 +382,7 @@
 	}
 	if (notify)
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	cur_freq = (speed_mode == PMAC_CPU_HIGH_SPEED) ? hi_freq : low_freq;
+	cur_freq = (speed_mode == CPUFREQ_HIGH) ? hi_freq : low_freq;
 
 	return 0;
 }
@@ -423,7 +425,8 @@
 	policy->cpuinfo.transition_latency	= CPUFREQ_ETERNAL;
 	policy->cur = cur_freq;
 
-	return cpufreq_frequency_table_cpuinfo(policy, &pmac_cpu_freqs[0]);
+	cpufreq_frequency_table_get_attr(pmac_cpu_freqs, policy->cpu);
+	return cpufreq_frequency_table_cpuinfo(policy, pmac_cpu_freqs);
 }
 
 static u32 __pmac read_gpio(struct device_node *np)
@@ -457,7 +460,7 @@
 	no_schedule = 1;
 	sleep_freq = cur_freq;
 	if (cur_freq == low_freq)
-		do_set_cpu_speed(PMAC_CPU_HIGH_SPEED, 0);
+		do_set_cpu_speed(CPUFREQ_HIGH, 0);
 	return 0;
 }
 
@@ -473,8 +476,8 @@
 	 * is that we force a switch to whatever it was, which is
 	 * probably high speed due to our suspend() routine
 	 */
-	do_set_cpu_speed(sleep_freq == low_freq ? PMAC_CPU_LOW_SPEED
-			 : PMAC_CPU_HIGH_SPEED, 0);
+	do_set_cpu_speed(sleep_freq == low_freq ?
+			 CPUFREQ_LOW : CPUFREQ_HIGH, 0);
 
 	no_schedule = 0;
 	return 0;
@@ -488,6 +491,7 @@
 	.suspend	= pmac_cpufreq_suspend,
 	.resume		= pmac_cpufreq_resume,
 	.flags		= CPUFREQ_PM_NO_WARN,
+	.attr		= pmac_cpu_freqs_attr,
 	.name		= "powermac",
 	.owner		= THIS_MODULE,
 };
