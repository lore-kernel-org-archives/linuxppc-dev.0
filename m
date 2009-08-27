Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B982FB7BB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 21:54:06 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7RBqqux011168
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2009 21:52:52 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RBs4AY1335342
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2009 21:54:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7RBs3L5032611
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2009 21:54:04 +1000
Date: Thu, 27 Aug 2009 17:23:54 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
Message-ID: <20090827115354.GC24986@linux.vnet.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090827114908.GA24986@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-08-27 17:19:08]:

Cpuidle infrastructure assumes pm_idle as the default idle routine.
But, ppc_md.power_save is the default idle callback in case of pSeries.

So, create a more generic, architecture independent cpuidle_pm_idle
function pointer in driver/cpuidle/cpuidle.c and allow the idle routines
of architectures to be set to cpuidle_pm_idle.

Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle.c |   12 +++++++-----
 include/linux/cpuidle.h   |    7 +++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: linux.trees.git/drivers/cpuidle/cpuidle.c
===================================================================
--- linux.trees.git.orig/drivers/cpuidle/cpuidle.c
+++ linux.trees.git/drivers/cpuidle/cpuidle.c
@@ -25,6 +25,7 @@ DEFINE_PER_CPU(struct cpuidle_device *, 
 DEFINE_MUTEX(cpuidle_lock);
 LIST_HEAD(cpuidle_detected_devices);
 static void (*pm_idle_old)(void);
+void (*cpuidle_pm_idle)(void);
 
 static int enabled_devices;
 
@@ -98,10 +99,10 @@ static void cpuidle_idle_call(void)
  */
 void cpuidle_install_idle_handler(void)
 {
-	if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
+	if (enabled_devices && (cpuidle_pm_idle != cpuidle_idle_call)) {
 		/* Make sure all changes finished before we switch to new idle */
 		smp_wmb();
-		pm_idle = cpuidle_idle_call;
+		cpuidle_pm_idle = cpuidle_idle_call;
 	}
 }
 
@@ -110,8 +111,9 @@ void cpuidle_install_idle_handler(void)
  */
 void cpuidle_uninstall_idle_handler(void)
 {
-	if (enabled_devices && pm_idle_old && (pm_idle != pm_idle_old)) {
-		pm_idle = pm_idle_old;
+	if (enabled_devices && pm_idle_old &&
+			(cpuidle_pm_idle != pm_idle_old)) {
+		cpuidle_pm_idle = pm_idle_old;
 		cpuidle_kick_cpus();
 	}
 }
@@ -382,7 +384,7 @@ static int __init cpuidle_init(void)
 {
 	int ret;
 
-	pm_idle_old = pm_idle;
+	pm_idle_old = cpuidle_pm_idle;
 
 	ret = cpuidle_add_class_sysfs(&cpu_sysdev_class);
 	if (ret)
Index: linux.trees.git/include/linux/cpuidle.h
===================================================================
--- linux.trees.git.orig/include/linux/cpuidle.h
+++ linux.trees.git/include/linux/cpuidle.h
@@ -188,4 +188,11 @@ static inline void cpuidle_unregister_go
 #define CPUIDLE_DRIVER_STATE_START	0
 #endif
 
+/*
+ * Idle callback used by cpuidle to call the cpuidle_idle_call().
+ * Platform drivers can use this to register to cpuidle's idle loop.
+ */
+
+extern void (*cpuidle_pm_idle)(void);
+
 #endif /* _LINUX_CPUIDLE_H */
