Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C83C2C0AF3
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:42:43 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:42:42 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0EC2E3578057
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:42:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKgQdR8847718
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:42:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKgchc008543
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:42:39 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 49/52] mm, vmstat: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:12:27 +0530
Message-ID: <20140310204226.10746.64059.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com,
 Christoph Lameter <cl@linux.com>, walken@google.com, linux@arm.linux.org.uk,
 linux-pm@vger.kernel.org, Rik van Riel <riel@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org,
 Dave Hansen <dave@sr71.net>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, tj@kernel.org,
 Toshi Kani <toshi.kani@hp.com>, Andrew Morton <akpm@linux-foundation.org>,
 paulmck@linux.vnet.ibm.com, Cody P Schafer <cody@linux.vnet.ibm.com>,
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


Fix the vmstat code in the MM subsystem by using this latter form of callback
registration.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Dave Hansen <dave@sr71.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-mm@kvack.org
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Rik van Riel <riel@redhat.com>
Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/vmstat.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index def5dd2..58c6f3d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1292,14 +1292,14 @@ static int __init setup_vmstat(void)
 #ifdef CONFIG_SMP
 	int cpu;
 
-	register_cpu_notifier(&vmstat_notifier);
+	cpu_notifier_register_begin();
+	__register_cpu_notifier(&vmstat_notifier);
 
-	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		start_cpu_timer(cpu);
 		node_set_state(cpu_to_node(cpu), N_CPU);
 	}
-	put_online_cpus();
+	cpu_notifier_register_done();
 #endif
 #ifdef CONFIG_PROC_FS
 	proc_create("buddyinfo", S_IRUGO, NULL, &fragmentation_file_operations);
