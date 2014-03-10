Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 105332C0B9A
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:43:01 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:13:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E03A5394005B
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:12:57 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKh2Xi8913350
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:13:02 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKguVr008267
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:12:57 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 51/52] net/core/flow.c: Fix CPU hotplug callback
 registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:12:51 +0530
Message-ID: <20140310204250.10746.61946.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org,
 Li RongQing <roy.qing.li@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
 "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 Sasha Levin <sasha.levin@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com,
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


Fix the code in net/core/flow.c by using this latter form of callback
registration.

Cc: Li RongQing <roy.qing.li@gmail.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: netdev@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 net/core/flow.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/flow.c b/net/core/flow.c
index dfa602c..9a2151f 100644
--- a/net/core/flow.c
+++ b/net/core/flow.c
@@ -456,6 +456,8 @@ static int __init flow_cache_init(struct flow_cache *fc)
 	if (!fc->percpu)
 		return -ENOMEM;
 
+	cpu_notifier_register_begin();
+
 	for_each_online_cpu(i) {
 		if (flow_cache_cpu_prepare(fc, i))
 			goto err;
@@ -463,7 +465,9 @@ static int __init flow_cache_init(struct flow_cache *fc)
 	fc->hotcpu_notifier = (struct notifier_block){
 		.notifier_call = flow_cache_cpu,
 	};
-	register_hotcpu_notifier(&fc->hotcpu_notifier);
+	__register_hotcpu_notifier(&fc->hotcpu_notifier);
+
+	cpu_notifier_register_done();
 
 	setup_timer(&fc->rnd_timer, flow_cache_new_hashrnd,
 		    (unsigned long) fc);
@@ -479,6 +483,8 @@ err:
 		fcp->hash_table = NULL;
 	}
 
+	cpu_notifier_register_done();
+
 	free_percpu(fc->percpu);
 	fc->percpu = NULL;
 
