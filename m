Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CFFB2C09D9
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:41:27 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:41:27 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFD5C2CE8046
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:40:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKKr4a48627844
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:20:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKeq5J022577
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:40:53 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 42/52] octeon,
 watchdog: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:10:43 +0530
Message-ID: <20140310204042.10746.60098.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
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


Fix the watchdog code in octeon by using this latter form of callback
registration.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/watchdog/octeon-wdt-main.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 4612088..4baf2d7 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -708,10 +708,13 @@ static int __init octeon_wdt_init(void)
 
 	cpumask_clear(&irq_enabled_cpus);
 
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu)
 		octeon_wdt_setup_interrupt(cpu);
 
-	register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
+	__register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
+	cpu_notifier_register_done();
+
 out:
 	return ret;
 }
@@ -725,7 +728,8 @@ static void __exit octeon_wdt_cleanup(void)
 
 	misc_deregister(&octeon_wdt_miscdev);
 
-	unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
+	cpu_notifier_register_begin();
+	__unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
 
 	for_each_online_cpu(cpu) {
 		int core = cpu2core(cpu);
@@ -734,6 +738,9 @@ static void __exit octeon_wdt_cleanup(void)
 		/* Free the interrupt handler */
 		free_irq(OCTEON_IRQ_WDOG0 + core, octeon_wdt_poke_irq);
 	}
+
+	cpu_notifier_register_done();
+
 	/*
 	 * Disable the boot-bus memory, the code it points to is soon
 	 * to go missing.
