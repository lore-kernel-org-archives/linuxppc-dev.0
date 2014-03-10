Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 06F092C0917
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:40:11 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:10:10 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 79147394003E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:10:07 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKe3RJ54853678
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:10:03 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKe48o014346
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:10:06 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 36/52] zsmalloc: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:09:59 +0530
Message-ID: <20140310203959.10746.61303.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>
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


Fix the zsmalloc code by using this latter form of callback registration.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-mm@kvack.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/zsmalloc.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c03ca5e..36b4591 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -814,21 +814,32 @@ static void zs_exit(void)
 {
 	int cpu;
 
+	cpu_notifier_register_begin();
+
 	for_each_online_cpu(cpu)
 		zs_cpu_notifier(NULL, CPU_DEAD, (void *)(long)cpu);
-	unregister_cpu_notifier(&zs_cpu_nb);
+	__unregister_cpu_notifier(&zs_cpu_nb);
+
+	cpu_notifier_register_done();
 }
 
 static int zs_init(void)
 {
 	int cpu, ret;
 
-	register_cpu_notifier(&zs_cpu_nb);
+	cpu_notifier_register_begin();
+
+	__register_cpu_notifier(&zs_cpu_nb);
 	for_each_online_cpu(cpu) {
 		ret = zs_cpu_notifier(NULL, CPU_UP_PREPARE, (void *)(long)cpu);
-		if (notifier_to_errno(ret))
+		if (notifier_to_errno(ret)) {
+			cpu_notifier_register_done();
 			goto fail;
+		}
 	}
+
+	cpu_notifier_register_done();
+
 	return 0;
 fail:
 	zs_exit();
