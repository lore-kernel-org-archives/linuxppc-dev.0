Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B0242C05D0
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:40:03 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:10:02 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 644E2E0057
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:13:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKduM627656296
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:09:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKdwTX012284
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:09:59 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 35/52] scsi, fcoe: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:09:52 +0530
Message-ID: <20140310203952.10746.35946.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-scsi@vger.kernel.org,
 Robert Love <robert.w.love@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>, fcoe-devel@open-fcoe.org,
 linuxppc-dev@ozlabs.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 tj@kernel.org, paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>
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


Fix the fcoe code in scsi by using this latter form of callback registration.

Cc: Robert Love <robert.w.love@intel.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: fcoe-devel@open-fcoe.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/scsi/fcoe/fcoe.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f317000..d5e105b 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -2633,14 +2633,18 @@ static int __init fcoe_init(void)
 		skb_queue_head_init(&p->fcoe_rx_list);
 	}
 
+	cpu_notifier_register_begin();
+
 	for_each_online_cpu(cpu)
 		fcoe_percpu_thread_create(cpu);
 
 	/* Initialize per CPU interrupt thread */
-	rc = register_hotcpu_notifier(&fcoe_cpu_notifier);
+	rc = __register_hotcpu_notifier(&fcoe_cpu_notifier);
 	if (rc)
 		goto out_free;
 
+	cpu_notifier_register_done();
+
 	/* Setup link change notification */
 	fcoe_dev_setup();
 
@@ -2655,6 +2659,9 @@ out_free:
 	for_each_online_cpu(cpu) {
 		fcoe_percpu_thread_destroy(cpu);
 	}
+
+	cpu_notifier_register_done();
+
 	mutex_unlock(&fcoe_config_mutex);
 	destroy_workqueue(fcoe_wq);
 	return rc;
@@ -2687,11 +2694,15 @@ static void __exit fcoe_exit(void)
 	}
 	rtnl_unlock();
 
-	unregister_hotcpu_notifier(&fcoe_cpu_notifier);
+	cpu_notifier_register_begin();
 
 	for_each_online_cpu(cpu)
 		fcoe_percpu_thread_destroy(cpu);
 
+	__unregister_hotcpu_notifier(&fcoe_cpu_notifier);
+
+	cpu_notifier_register_done();
+
 	mutex_unlock(&fcoe_config_mutex);
 
 	/*
