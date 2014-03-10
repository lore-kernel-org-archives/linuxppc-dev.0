Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 096182C05C5
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:39:55 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:09:54 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E88ACE0053
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:13:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKdnhY27656268
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:09:49 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKdoaX000614
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:09:52 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 34/52] scsi, bnx2fc: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:09:45 +0530
Message-ID: <20140310203945.10746.2812.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 paulmck@linux.vnet.ibm.com, Eddie Wai <eddie.wai@broadcom.com>,
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


Fix the bnx2fc code in scsi by using this latter form of callback
registration.

Cc: Eddie Wai <eddie.wai@broadcom.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 9b94850..c4ec235 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2586,12 +2586,16 @@ static int __init bnx2fc_mod_init(void)
 		spin_lock_init(&p->fp_work_lock);
 	}
 
+	cpu_notifier_register_begin();
+
 	for_each_online_cpu(cpu) {
 		bnx2fc_percpu_thread_create(cpu);
 	}
 
 	/* Initialize per CPU interrupt thread */
-	register_hotcpu_notifier(&bnx2fc_cpu_notifier);
+	__register_hotcpu_notifier(&bnx2fc_cpu_notifier);
+
+	cpu_notifier_register_done();
 
 	cnic_register_driver(CNIC_ULP_FCOE, &bnx2fc_cnic_cb);
 
@@ -2656,13 +2660,17 @@ static void __exit bnx2fc_mod_exit(void)
 	if (l2_thread)
 		kthread_stop(l2_thread);
 
-	unregister_hotcpu_notifier(&bnx2fc_cpu_notifier);
+	cpu_notifier_register_begin();
 
 	/* Destroy per cpu threads */
 	for_each_online_cpu(cpu) {
 		bnx2fc_percpu_thread_destroy(cpu);
 	}
 
+	__unregister_hotcpu_notifier(&bnx2fc_cpu_notifier);
+
+	cpu_notifier_register_done();
+
 	destroy_workqueue(bnx2fc_wq);
 	/*
 	 * detach from scsi transport
