Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9AEB2C0964
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:40:47 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:10:45 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 88D39125803E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:12:56 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKekup3473800
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:10:46 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKefbP016290
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:10:42 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 41/52] oprofile,
 nmi-timer: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:10:36 +0530
Message-ID: <20140310204036.10746.10550.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 tj@kernel.org, Robert Richter <rric@kernel.org>, paulmck@linux.vnet.ibm.com,
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


Fix the nmi-timer code in oprofile by using this latter form of callback
registration.

Cc: Robert Richter <rric@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/oprofile/nmi_timer_int.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/oprofile/nmi_timer_int.c b/drivers/oprofile/nmi_timer_int.c
index 76f1c93..9559829 100644
--- a/drivers/oprofile/nmi_timer_int.c
+++ b/drivers/oprofile/nmi_timer_int.c
@@ -108,8 +108,8 @@ static void nmi_timer_shutdown(void)
 	struct perf_event *event;
 	int cpu;
 
-	get_online_cpus();
-	unregister_cpu_notifier(&nmi_timer_cpu_nb);
+	cpu_notifier_register_begin();
+	__unregister_cpu_notifier(&nmi_timer_cpu_nb);
 	for_each_possible_cpu(cpu) {
 		event = per_cpu(nmi_timer_events, cpu);
 		if (!event)
@@ -119,7 +119,7 @@ static void nmi_timer_shutdown(void)
 		perf_event_release_kernel(event);
 	}
 
-	put_online_cpus();
+	cpu_notifier_register_done();
 }
 
 static int nmi_timer_setup(void)
@@ -132,20 +132,23 @@ static int nmi_timer_setup(void)
 	do_div(period, HZ);
 	nmi_timer_attr.sample_period = period;
 
-	get_online_cpus();
-	err = register_cpu_notifier(&nmi_timer_cpu_nb);
+	cpu_notifier_register_begin();
+	err = __register_cpu_notifier(&nmi_timer_cpu_nb);
 	if (err)
 		goto out;
+
 	/* can't attach events to offline cpus: */
 	for_each_online_cpu(cpu) {
 		err = nmi_timer_start_cpu(cpu);
-		if (err)
-			break;
+		if (err) {
+			cpu_notifier_register_done();
+			nmi_timer_shutdown();
+			return err;
+		}
 	}
-	if (err)
-		nmi_timer_shutdown();
+
 out:
-	put_online_cpus();
+	cpu_notifier_register_done();
 	return err;
 }
 
