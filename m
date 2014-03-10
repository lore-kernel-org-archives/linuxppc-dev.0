Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5535C2C064E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:42:29 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:42:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7543C2CE8051
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:41:56 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKLuH542270724
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:21:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKfsv2023953
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:41:56 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 46/52] xen, balloon: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:11:45 +0530
Message-ID: <20140310204144.10746.62444.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, David Vrabel <david.vrabel@citrix.com>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com,
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

The xen balloon driver doesn't take get/put_online_cpus() around this code,
but that is also buggy, since it can miss CPU hotplug events in between the
initialization and callback registration:

	for_each_online_cpu(cpu)
		init_cpu(cpu);
		   ^
		   |  Race window; Can miss CPU hotplug events here.
		   v
	register_cpu_notifier(&foobar_cpu_notifier);

Interestingly, the balloon code in xen can simply be reorganized as shown
below, to have a race-free method to register hotplug callbacks, without even
taking get/put_online_cpus(). This is because the initialization performed for
already online CPUs is exactly the same as that performed for CPUs that come
online later. Moreover, the code has checks in place to avoid double
initialization.

	register_cpu_notifier(&foobar_cpu_notifier);

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	put_online_cpus();

A hotplug operation that occurs between registering the notifier and calling
get_online_cpus(), won't disrupt anything, because the code takes care to
perform the memory allocations only once.

So reorganize the balloon code in xen this way to fix the issues with CPU
hotplug callback registration.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: xen-devel@lists.xenproject.org
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/xen/balloon.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 37d06ea..dd79549 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -592,19 +592,29 @@ static void __init balloon_add_region(unsigned long start_pfn,
 	}
 }
 
+static int alloc_balloon_scratch_page(int cpu)
+{
+	if (per_cpu(balloon_scratch_page, cpu) != NULL)
+		return 0;
+
+	per_cpu(balloon_scratch_page, cpu) = alloc_page(GFP_KERNEL);
+	if (per_cpu(balloon_scratch_page, cpu) == NULL) {
+		pr_warn("Failed to allocate balloon_scratch_page for cpu %d\n", cpu);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+
 static int balloon_cpu_notify(struct notifier_block *self,
 				    unsigned long action, void *hcpu)
 {
 	int cpu = (long)hcpu;
 	switch (action) {
 	case CPU_UP_PREPARE:
-		if (per_cpu(balloon_scratch_page, cpu) != NULL)
-			break;
-		per_cpu(balloon_scratch_page, cpu) = alloc_page(GFP_KERNEL);
-		if (per_cpu(balloon_scratch_page, cpu) == NULL) {
-			pr_warn("Failed to allocate balloon_scratch_page for cpu %d\n", cpu);
+		if (alloc_balloon_scratch_page(cpu))
 			return NOTIFY_BAD;
-		}
 		break;
 	default:
 		break;
@@ -624,15 +634,17 @@ static int __init balloon_init(void)
 		return -ENODEV;
 
 	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
-		for_each_online_cpu(cpu)
-		{
-			per_cpu(balloon_scratch_page, cpu) = alloc_page(GFP_KERNEL);
-			if (per_cpu(balloon_scratch_page, cpu) == NULL) {
-				pr_warn("Failed to allocate balloon_scratch_page for cpu %d\n", cpu);
+		register_cpu_notifier(&balloon_cpu_notifier);
+
+		get_online_cpus();
+		for_each_online_cpu(cpu) {
+			if (alloc_balloon_scratch_page(cpu)) {
+				put_online_cpus();
+				unregister_cpu_notifier(&balloon_cpu_notifier);
 				return -ENOMEM;
 			}
 		}
-		register_cpu_notifier(&balloon_cpu_notifier);
+		put_online_cpus();
 	}
 
 	pr_info("Initialising balloon driver\n");
