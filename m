Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFC5A2C02E8
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:35:41 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:35:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 84D5A2CE8047
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:35:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKFTdo58523744
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:15:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKZano001802
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:35:38 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 09/52] arm,
 hw-breakpoint: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:05:21 +0530
Message-ID: <20140310203521.10746.47464.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 tj@kernel.org, paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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


Fix the hw-breakpoint code in arm by using this latter form of callback
registration.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm/kernel/hw_breakpoint.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 3d44660..3702de8 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1072,6 +1072,8 @@ static int __init arch_hw_breakpoint_init(void)
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
+	cpu_notifier_register_begin();
+
 	/*
 	 * We need to tread carefully here because DBGSWENABLE may be
 	 * driven low on this core and there isn't an architected way to
@@ -1088,6 +1090,7 @@ static int __init arch_hw_breakpoint_init(void)
 	if (!cpumask_empty(&debug_err_mask)) {
 		core_num_brps = 0;
 		core_num_wrps = 0;
+		cpu_notifier_register_done();
 		return 0;
 	}
 
@@ -1107,7 +1110,10 @@ static int __init arch_hw_breakpoint_init(void)
 			TRAP_HWBKPT, "breakpoint debug exception");
 
 	/* Register hotplug and PM notifiers. */
-	register_cpu_notifier(&dbg_reset_nb);
+	__register_cpu_notifier(&dbg_reset_nb);
+
+	cpu_notifier_register_done();
+
 	pm_init();
 	return 0;
 }
