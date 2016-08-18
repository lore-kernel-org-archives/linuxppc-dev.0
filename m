Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFR3v4rJPzDr5P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 22:58:35 +1000 (AEST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/16] powerpc: powermac: Convert to hotplug state machine
Date: Thu, 18 Aug 2016 14:57:30 +0200
Message-Id: <20160818125731.27256-16-bigeasy@linutronix.de>
In-Reply-To: <20160818125731.27256-1-bigeasy@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Install the callbacks via the state machine.
I assume here that the powermac has two CPUs and so only one can go up
or down at a time. The variable smp_core99_host_open is here to ensure
that we do not try to open or close the i2c host twice if something goes
wrong and we invoke the prepare or online callback twice due to
rollback.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/platforms/powermac/smp.c | 50 +++++++++++++++++------------------
 include/linux/cpuhotplug.h            |  1 +
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 834868b9fdc9..4a853323f906 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -852,37 +852,33 @@ static void smp_core99_setup_cpu(int cpu_nr)
 
 #ifdef CONFIG_PPC64
 #ifdef CONFIG_HOTPLUG_CPU
-static int smp_core99_cpu_notify(struct notifier_block *self,
-				 unsigned long action, void *hcpu)
+static unsigned int smp_core99_host_open;
+
+static int smp_core99_cpu_prepare(unsigned int cpu)
 {
 	int rc;
 
-	switch(action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-		/* Open i2c bus if it was used for tb sync */
-		if (pmac_tb_clock_chip_host) {
-			rc = pmac_i2c_open(pmac_tb_clock_chip_host, 1);
-			if (rc) {
-				pr_err("Failed to open i2c bus for time sync\n");
-				return notifier_from_errno(rc);
-			}
+	/* Open i2c bus if it was used for tb sync */
+	if (pmac_tb_clock_chip_host && !smp_core99_host_open) {
+		rc = pmac_i2c_open(pmac_tb_clock_chip_host, 1);
+		if (rc) {
+			pr_err("Failed to open i2c bus for time sync\n");
+			return notifier_from_errno(rc);
 		}
-		break;
-	case CPU_ONLINE:
-	case CPU_UP_CANCELED:
-		/* Close i2c bus if it was used for tb sync */
-		if (pmac_tb_clock_chip_host)
-			pmac_i2c_close(pmac_tb_clock_chip_host);
-		break;
-	default:
-		break;
+		smp_core99_host_open = 1;
 	}
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block smp_core99_cpu_nb = {
-	.notifier_call	= smp_core99_cpu_notify,
-};
+static int smp_core99_cpu_online(unsigned int cpu)
+{
+	/* Close i2c bus if it was used for tb sync */
+	if (pmac_tb_clock_chip_host && smp_core99_host_open) {
+		pmac_i2c_close(pmac_tb_clock_chip_host);
+		smp_core99_host_open = 0;
+	}
+	return 0;
+}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 static void __init smp_core99_bringup_done(void)
@@ -902,7 +898,11 @@ static void __init smp_core99_bringup_done(void)
 		g5_phy_disable_cpu1();
 	}
 #ifdef CONFIG_HOTPLUG_CPU
-	register_cpu_notifier(&smp_core99_cpu_nb);
+	cpuhp_setup_state_nocalls(CPUHP_POWER_PMAC_PREPARE,
+				  "POWER_PMAC_PREPARE", smp_core99_cpu_prepare,
+				  NULL);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "AP_POWER_PMAC_ONLINE",
+				  smp_core99_cpu_online, NULL);
 #endif
 
 	if (ppc_md.progress)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 9e50a7b3bbcd..4974c9fdbf9a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -32,6 +32,7 @@ enum cpuhp_state {
 	CPUHP_RCUTREE_PREP,
 	CPUHP_MD_RAID5_PREPARE,
 	CPUHP_CPUIDLE_COUPLED_PREPARE,
+	CPUHP_POWER_PMAC_PREPARE,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
-- 
2.9.3
