Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 779AE2C0885
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:39:29 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:09:27 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2FCA1E0053
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:13:11 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKdUMM5505388
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:09:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKdPZc004400
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:09:26 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 31/52] arm64,
 debug-monitors: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:09:20 +0530
Message-ID: <20140310203919.10746.1234.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 Russell King <rmk+kernel@arm.linux.org.uk>, paulmck@linux.vnet.ibm.com,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
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


Fix the debug-monitors code in arm64 by using this latter form of callback
registration.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm64/kernel/debug-monitors.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 636ba8b..c985531 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -155,12 +155,16 @@ static struct notifier_block os_lock_nb = {
 
 static int debug_monitors_init(void)
 {
+	cpu_notifier_register_begin();
+
 	/* Clear the OS lock. */
 	smp_call_function(clear_os_lock, NULL, 1);
 	clear_os_lock(NULL);
 
 	/* Register hotplug handler. */
-	register_cpu_notifier(&os_lock_nb);
+	__register_cpu_notifier(&os_lock_nb);
+
+	cpu_notifier_register_done();
 	return 0;
 }
 postcore_initcall(debug_monitors_init);
