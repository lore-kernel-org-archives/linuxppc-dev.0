Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C3C42C0227
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:36:48 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:06:46 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 99C4F1258054
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:08:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKalh81180092
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:06:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKag1S031680
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:06:43 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 15/52] x86, msr: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:06:37 +0530
Message-ID: <20140310203637.10746.41491.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, tj@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
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


Fix the msr code in x86 by using this latter form of callback registration.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/msr.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 05266b5..c9603ac 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -259,14 +259,15 @@ static int __init msr_init(void)
 		goto out_chrdev;
 	}
 	msr_class->devnode = msr_devnode;
-	get_online_cpus();
+
+	cpu_notifier_register_begin();
 	for_each_online_cpu(i) {
 		err = msr_device_create(i);
 		if (err != 0)
 			goto out_class;
 	}
-	register_hotcpu_notifier(&msr_class_cpu_notifier);
-	put_online_cpus();
+	__register_hotcpu_notifier(&msr_class_cpu_notifier);
+	cpu_notifier_register_done();
 
 	err = 0;
 	goto out;
@@ -275,7 +276,7 @@ out_class:
 	i = 0;
 	for_each_online_cpu(i)
 		msr_device_destroy(i);
-	put_online_cpus();
+	cpu_notifier_register_done();
 	class_destroy(msr_class);
 out_chrdev:
 	__unregister_chrdev(MSR_MAJOR, 0, NR_CPUS, "cpu/msr");
@@ -286,13 +287,14 @@ out:
 static void __exit msr_exit(void)
 {
 	int cpu = 0;
-	get_online_cpus();
+
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu)
 		msr_device_destroy(cpu);
 	class_destroy(msr_class);
 	__unregister_chrdev(MSR_MAJOR, 0, NR_CPUS, "cpu/msr");
-	unregister_hotcpu_notifier(&msr_class_cpu_notifier);
-	put_online_cpus();
+	__unregister_hotcpu_notifier(&msr_class_cpu_notifier);
+	cpu_notifier_register_done();
 }
 
 module_init(msr_init);
