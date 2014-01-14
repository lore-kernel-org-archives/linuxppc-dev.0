Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BBF3E2C04D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:56:34 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 20:56:33 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ECDE92BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:56:29 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EAbaAf6553916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:37:36 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EAuSmd003727
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:56:29 +1100
Subject: [PATCH v1 6/6] pseries/cpuidle: smt-snooze-delay cleanup.
To: linux-pm@vger.kernel.org, benh@kernel.crashing.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 16:26:38 +0530
Message-ID: <20140114105633.3064.32212.stgit@deepthi.in.ibm.com>
In-Reply-To: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
References: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
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

smt-snooze-delay was designed to disable NAP state or delay the entry
to the NAP state prior to adoption of cpuidle framework. This
is per-cpu variable. With the coming of CPUIDLE framework,
states can be disabled on per-cpu basis using the cpuidle/enable
sysfs entry.

Also, with the coming of cpuidle driver each state's target residency
is per-driver unlike earlier which was per-device. Therefore,
the per-cpu sysfs smt-snooze-delay which decides the target residency
of the idle state on a particular cpu causes more confusion to the user
as we cannot have different smt-snooze-delay (target residency)
values for each cpu.

In the current code, smt-snooze-delay functionality is completely broken.
It makes sense to remove smt-snooze-delay from idle driver with the
coming of cpuidle framework.
However, sysfs files are retained as ppc64_util currently
utilises it. Once we fix ppc64_util, propose to clean
up the kernel code.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h |    7 -------
 arch/powerpc/kernel/sysfs.c          |    2 --
 drivers/cpuidle/cpuidle-pseries.c    |   17 -----------------
 3 files changed, 26 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index fa98fdf..027fefd 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -444,13 +444,6 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern void power7_nap(void);
-
-#ifdef CONFIG_PSERIES_CPUIDLE
-extern void update_smt_snooze_delay(int cpu, int residency);
-#else
-static inline void update_smt_snooze_delay(int cpu, int residency) {}
-#endif
-
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index b4e6676..7f9e130 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -51,8 +51,6 @@ static ssize_t store_smt_snooze_delay(struct device *dev,
 		return -EINVAL;
 
 	per_cpu(smt_snooze_delay, cpu->dev.id) = snooze;
-	update_smt_snooze_delay(cpu->dev.id, snooze);
-
 	return count;
 }
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index bb56091..7ab564a 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -162,23 +162,6 @@ static struct cpuidle_state shared_states[] = {
 		.enter = &shared_cede_loop },
 };
 
-void update_smt_snooze_delay(int cpu, int residency)
-{
-	struct cpuidle_driver *drv = cpuidle_get_driver();
-	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
-
-	if (cpuidle_state_table != dedicated_states)
-		return;
-
-	if (residency < 0) {
-		/* Disable the Nap state on that cpu */
-		if (dev)
-			dev->states_usage[1].disable = 1;
-	} else
-		if (drv)
-			drv->states[1].target_residency = residency;
-}
-
 static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 			unsigned long action, void *hcpu)
 {
