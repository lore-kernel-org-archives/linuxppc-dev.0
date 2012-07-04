Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 340F92C01F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 16:07:31 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 4 Jul 2012 11:37:26 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6467MlZ61931690
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2012 11:37:23 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q64BbvBS007024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2012 21:37:57 +1000
Message-ID: <4FF3DD9A.1060101@linux.vnet.ibm.com>
Date: Wed, 04 Jul 2012 11:37:22 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] cpuidle:(POWER) Fixes for pseries_idle hotplug notifier
References: <4FF29219.10608@linux.vnet.ibm.com>
 <4FF2AB40.6050701@linux.vnet.ibm.com> <1341351841.2346.11.camel@pasglop>
In-Reply-To: <1341351841.2346.11.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpuidle:(POWER) Fixes for pseries_idle hotplug notifier 

From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Currently the call to pseries_notify_cpuidle_add_cpu(), that takes
action on the cpuidle front when a cpu is added/removed
is being made from smp_xics_setup_cpu().
This caused lockdep issues as
reported https://lkml.org/lkml/2012/5/17/2
 
On addition of each cpu,
resources were cleared and re-allocated each time, all in critical
section as part of start_secondary() call were interrupts are disabled.
To resolve this issue, the pseries_notify_cpuidle_add_cpu() call is
is being replaced by a hotplug notifier which
would prevent cpuidle resources from being
released and allocated each time cpu is onlined in the critical code path.
It was fixed in https://lkml.org/lkml/2012/5/18/174.

Also it is essential to call cpuidle_enable/disable_device 
between  cpuidle_pause_and_lock()  and
cpuidle_resume_and_unlock()  when used externally 
to avoid race conditions. Add support for CPU_ONLINE_FROZEN
and CPU_DEAD_FROZEN as part of hotplug notify event for
pseries_idle  and unregister hotplug notifier
while exiting out. The above mentioned issues
are fixed as part of this patch.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
This applies on 3.5-rc5.

 arch/powerpc/platforms/pseries/processor_idle.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a97ef66..d2d2d85 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -194,13 +194,25 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 	struct cpuidle_device *dev =
 			per_cpu_ptr(pseries_cpuidle_devices, hotcpu);
 
-	switch (action & 0xf) {
-	case CPU_ONLINE:
-		if (dev && cpuidle_get_driver()) {
-			cpuidle_disable_device(dev);
+	if (dev && cpuidle_get_driver()) {
+		switch (action) {
+		case CPU_ONLINE:
+		case CPU_ONLINE_FROZEN:
+			cpuidle_pause_and_lock();
 			cpuidle_enable_device(dev);
+			cpuidle_resume_and_unlock();
+			break;
+
+		case CPU_DEAD:
+		case CPU_DEAD_FROZEN:
+			cpuidle_pause_and_lock();
+			cpuidle_disable_device(dev);
+			cpuidle_resume_and_unlock();
+			break;
+
+		default:
+			return NOTIFY_DONE;
 		}
-		break;
 	}
 	return NOTIFY_OK;
 }
@@ -342,6 +354,7 @@ static int __init pseries_processor_idle_init(void)
 static void __exit pseries_processor_idle_exit(void)
 {
 
+	unregister_cpu_notifier(&setup_hotplug_notifier);
 	pseries_idle_devices_uninit();
 	cpuidle_unregister_driver(&pseries_idle_driver);
 
Cheers,
Deepthi
