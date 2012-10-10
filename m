Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B3222C026E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:29:19 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 10 Oct 2012 17:26:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9A7JXJ242008680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:19:34 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9A7TE5H014475
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:29:14 +1100
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RESEND PATCH v1 2/3] cpuidle: (POWER) Fix smt_snooze_delay
 functionality.
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
Date: Wed, 10 Oct 2012 12:59:15 +0530
Message-ID: <20121010072913.29317.11117.stgit@deepthi.in.ibm.com>
In-Reply-To: <20121010072859.29317.71472.stgit@deepthi.in.ibm.com>
References: <20121010072859.29317.71472.stgit@deepthi.in.ibm.com>
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
index 9dc5cd1..7e44855 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -391,9 +391,9 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
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
