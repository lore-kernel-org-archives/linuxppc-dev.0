Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 581202C0846
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:39:03 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:39:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F2AB32CE8051
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:39:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKclcq7799116
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:38:47 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKcxK4021474
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:39:00 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 28/52] x86, oprofile,
 nmi: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:08:49 +0530
Message-ID: <20140310203849.10746.36718.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, tj@kernel.org,
 Robert Richter <rric@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>
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


Fix the oprofile code in x86 by using this latter form of callback
registration. But retain the calls to get/put_online_cpus(), since they are
used in other places as well, to protect the variables 'nmi_enabled' and
'ctr_running'. Strictly speaking, this is not necessary since
cpu_notifier_register_begin/done() provide a stronger synchronization
with CPU hotplug than get/put_online_cpus(). However, let's retain the
calls to get/put_online_cpus() to be consistent with the other call-sites.

By nesting get/put_online_cpus() *inside* cpu_notifier_register_begin/done(),
we avoid the ABBA deadlock possibility mentioned above.

Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/oprofile/nmi_int.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 6890d84..379e8bd 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -494,14 +494,19 @@ static int nmi_setup(void)
 	if (err)
 		goto fail;
 
+	cpu_notifier_register_begin();
+
+	/* Use get/put_online_cpus() to protect 'nmi_enabled' */
 	get_online_cpus();
-	register_cpu_notifier(&oprofile_cpu_nb);
 	nmi_enabled = 1;
 	/* make nmi_enabled visible to the nmi handler: */
 	smp_mb();
 	on_each_cpu(nmi_cpu_setup, NULL, 1);
+	__register_cpu_notifier(&oprofile_cpu_nb);
 	put_online_cpus();
 
+	cpu_notifier_register_done();
+
 	return 0;
 fail:
 	free_msrs();
@@ -512,12 +517,18 @@ static void nmi_shutdown(void)
 {
 	struct op_msrs *msrs;
 
+	cpu_notifier_register_begin();
+
+	/* Use get/put_online_cpus() to protect 'nmi_enabled' & 'ctr_running' */
 	get_online_cpus();
-	unregister_cpu_notifier(&oprofile_cpu_nb);
 	on_each_cpu(nmi_cpu_shutdown, NULL, 1);
 	nmi_enabled = 0;
 	ctr_running = 0;
+	__unregister_cpu_notifier(&oprofile_cpu_nb);
 	put_online_cpus();
+
+	cpu_notifier_register_done();
+
 	/* make variables visible to the nmi handler: */
 	smp_mb();
 	unregister_nmi_handler(NMI_LOCAL, "oprofile");
