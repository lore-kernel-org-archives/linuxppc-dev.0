Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97BC02C0395
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 14:42:21 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 4 Oct 2012 10:12:19 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q944gHxV40960086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2012 10:12:17 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q94ABPpQ016989
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2012 20:11:25 +1000
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [PATCH v1 2/3] cpuidle: (POWER) Fix smt_snooze_delay functionality.
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Date: Thu, 04 Oct 2012 10:12:18 +0530
Message-ID: <20121004044215.15921.60142.stgit@deepthi.in.ibm.com>
In-Reply-To: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
References: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smt_snooze_delay was designed to  delay idle loop's nap entry
in the native idle code before it got  ported over to use as part of
the cpuidle framework.

A -ve value  assigned to smt_snooze_delay should result in
busy looping, in other words disabling the entry to nap state.

	- https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-May/082450.html

This particular functionality can be achieved currently by
echo 1 > /sys/devices/system/cpu/cpu*/state1/disable
but it is broken when one assigns -ve value to  the smt_snooze_delay
variable either via sysfs entry or ppc64_cpu util.

This patch aims to fix this, by disabling nap state when smt_snooze_delay
variable is set to -ve value.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/processor.h            |    4 ++--
 arch/powerpc/kernel/sysfs.c                     |    2 +-
 arch/powerpc/platforms/pseries/processor_idle.c |   24 ++++++++++++++++-------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 54b73a2..d0a5fb8 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -389,9 +389,9 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern void power7_nap(void);
 
 #ifdef CONFIG_PSERIES_IDLE
-extern void update_smt_snooze_delay(int snooze);
+extern void update_smt_snooze_delay(int cpu, int residency);
 #else
-static inline void update_smt_snooze_delay(int snooze) {}
+static inline void update_smt_snooze_delay(int cpu, int residency) {}
 #endif
 
 extern void flush_instruction_cache(void);
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 8302af6..cf357a0 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -50,7 +50,7 @@ static ssize_t store_smt_snooze_delay(struct device *dev,
 		return -EINVAL;
 
 	per_cpu(smt_snooze_delay, cpu->dev.id) = snooze;
-	update_smt_snooze_delay(snooze);
+	update_smt_snooze_delay(cpu->dev.id, snooze);
 
 	return count;
 }
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 02e425a..a32d56d 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -33,13 +33,6 @@ static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
 static struct cpuidle_device __percpu *pseries_cpuidle_devices;
 static struct cpuidle_state *cpuidle_state_table;
 
-void update_smt_snooze_delay(int snooze)
-{
-	struct cpuidle_driver *drv = cpuidle_get_driver();
-	if (drv)
-		drv->states[0].target_residency = snooze;
-}
-
 static inline void idle_loop_prolog(unsigned long *in_purr, ktime_t *kt_before)
 {
 
@@ -190,6 +183,23 @@ static struct cpuidle_state shared_states[MAX_IDLE_STATE_COUNT] = {
 		.enter = &shared_cede_loop },
 };
 
+void update_smt_snooze_delay(int cpu, int residency)
+{
+	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
+
+	if (cpuidle_state_table != dedicated_states)
+		return;
+
+	if (residency < 0) {
+		/* Disable the Nap state on that cpu */
+		if (dev)
+			dev->states_usage[1].disable = 1;
+	} else
+		if (drv)
+			drv->states[0].target_residency = residency;
+}
+
 static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 			unsigned long action, void *hcpu)
 {
