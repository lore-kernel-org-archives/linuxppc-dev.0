Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 514D1B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 14:49:53 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 21 May 2012 04:26:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4L4RQA626607856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 14:27:27 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4L4YWRP007386
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 14:34:32 +1000
Message-ID: <4FB9C5D3.5070606@linux.vnet.ibm.com>
Date: Mon, 21 May 2012 10:04:27 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RESEND] cpuidle: (POWER) Replace pseries_notify_cpuidle_add
 call with a elegant notifier to fix lockdep problem in start_secondary
References: <4FB64E9A.3060100@linux.vnet.ibm.com>
 <1337561221.2458.1.camel@pasglop> <1337561378.2458.3.camel@pasglop>
In-Reply-To: <1337561378.2458.3.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The following patch is to remove the pseries_notify_add_cpu() call
and replace it by a hot plug notifier.
This would prevent cpuidle resources being
released and allocated each time cpu comes online on pseries.
The earlier design was causing a lockdep problem
in start_secondary as reported on this thread
	-https://lkml.org/lkml/2012/5/17/2

This applies on 3.4-rc7

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h            |    2 --
 arch/powerpc/platforms/pseries/processor_idle.c |   25 +++++++++++++++++------
 arch/powerpc/platforms/pseries/smp.c            |    1 -
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 8e2d037..c6bc22b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -390,10 +390,8 @@ void cpu_idle_wait(void);
 
 #ifdef CONFIG_PSERIES_IDLE
 extern void update_smt_snooze_delay(int snooze);
-extern int pseries_notify_cpuidle_add_cpu(int cpu);
 #else
 static inline void update_smt_snooze_delay(int snooze) {}
-static inline int pseries_notify_cpuidle_add_cpu(int cpu) { return 0; }
 #endif
 
 extern void flush_instruction_cache(void);
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 41a34bc..d1a7dc0 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/paca.h>
 #include <asm/reg.h>
@@ -186,17 +187,28 @@ static struct cpuidle_state shared_states[MAX_IDLE_STATE_COUNT] = {
 		.enter = &shared_cede_loop },
 };
 
-int pseries_notify_cpuidle_add_cpu(int cpu)
+static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
+			unsigned long action, void *hcpu)
 {
+	int hotcpu = (unsigned long)hcpu;
 	struct cpuidle_device *dev =
-			per_cpu_ptr(pseries_cpuidle_devices, cpu);
-	if (dev && cpuidle_get_driver()) {
-		cpuidle_disable_device(dev);
-		cpuidle_enable_device(dev);
+			per_cpu_ptr(pseries_cpuidle_devices, hotcpu);
+
+	switch (action & 0xf) {
+	case CPU_ONLINE:
+		if (dev && cpuidle_get_driver()) {
+			cpuidle_disable_device(dev);
+			cpuidle_enable_device(dev);
+		}
+		break;
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
+static struct notifier_block setup_hotplug_notifier = {
+	.notifier_call = pseries_cpuidle_add_cpu_notifier,
+};
+
 /*
  * pseries_cpuidle_driver_init()
  */
@@ -321,6 +333,7 @@ static int __init pseries_processor_idle_init(void)
 		return retval;
 	}
 
+	register_cpu_notifier(&setup_hotplug_notifier);
 	printk(KERN_DEBUG "pseries_idle_driver registered\n");
 
 	return 0;
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index e16bb8d..71706bc 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -147,7 +147,6 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 	set_cpu_current_state(cpu, CPU_STATE_ONLINE);
 	set_default_offline_state(cpu);
 #endif
-	pseries_notify_cpuidle_add_cpu(cpu);
 }
 
 static int __devinit smp_pSeries_kick_cpu(int nr)
