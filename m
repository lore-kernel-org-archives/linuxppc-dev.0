Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B00FE2C0610
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:41:14 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:41:14 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 417B32BB0057
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:41:11 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKL1qd12517702
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:21:02 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKf9Q6009917
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:41:10 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 43/52] thermal,
 x86-pkg-temp: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:10:54 +0530
Message-ID: <20140310204054.10746.57627.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eduardo Valentin <eduardo.valentin@ti.com>, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 Zhang Rui <rui.zhang@intel.com>, paulmck@linux.vnet.ibm.com,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


Fix the thermal x86-pkg-temp code by using this latter form of callback
registration.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/thermal/x86_pkg_temp_thermal.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 081fd7e..9ea3d9d 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -590,12 +590,12 @@ static int __init pkg_temp_thermal_init(void)
 	platform_thermal_package_rate_control =
 			pkg_temp_thermal_platform_thermal_rate_control;
 
-	get_online_cpus();
+	cpu_notifier_register_begin();
 	for_each_online_cpu(i)
 		if (get_core_online(i))
 			goto err_ret;
-	register_hotcpu_notifier(&pkg_temp_thermal_notifier);
-	put_online_cpus();
+	__register_hotcpu_notifier(&pkg_temp_thermal_notifier);
+	cpu_notifier_register_done();
 
 	pkg_temp_debugfs_init(); /* Don't care if fails */
 
@@ -604,7 +604,7 @@ static int __init pkg_temp_thermal_init(void)
 err_ret:
 	for_each_online_cpu(i)
 		put_core_offline(i);
-	put_online_cpus();
+	cpu_notifier_register_done();
 	kfree(pkg_work_scheduled);
 	platform_thermal_package_notify = NULL;
 	platform_thermal_package_rate_control = NULL;
@@ -617,8 +617,8 @@ static void __exit pkg_temp_thermal_exit(void)
 	struct phy_dev_entry *phdev, *n;
 	int i;
 
-	get_online_cpus();
-	unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
+	cpu_notifier_register_begin();
+	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	mutex_lock(&phy_dev_list_mutex);
 	list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
 		/* Retore old MSR value for package thermal interrupt */
@@ -636,7 +636,7 @@ static void __exit pkg_temp_thermal_exit(void)
 	for_each_online_cpu(i)
 		cancel_delayed_work_sync(
 			&per_cpu(pkg_temp_thermal_threshold_work, i));
-	put_online_cpus();
+	cpu_notifier_register_done();
 
 	kfree(pkg_work_scheduled);
 
