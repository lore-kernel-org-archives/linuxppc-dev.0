Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A14A2C0168
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:44 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:04:41 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1931B3940060
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:04:39 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKYZ6343188452
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:04:35 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKYb1h001259
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:04:38 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 03/52] Doc/cpu-hotplug: Specify race-free way to register
 CPU hotplug callbacks
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:04:32 +0530
Message-ID: <20140310203432.10746.96084.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, Rob Landley <rob@landley.net>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
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

Recommend the usage of the new CPU hotplug callback registration APIs
(__register_cpu_notifier() etc), when subsystems need to also perform
initialization for already online CPUs. Provide examples of correct
and race-free ways of achieving this, and point out the kinds of code
that are error-prone.

Cc: Rob Landley <rob@landley.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 Documentation/cpu-hotplug.txt |   45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
index be675d2..a0b005d 100644
--- a/Documentation/cpu-hotplug.txt
+++ b/Documentation/cpu-hotplug.txt
@@ -312,12 +312,57 @@ things will happen if a notifier in path sent a BAD notify code.
 Q: I don't see my action being called for all CPUs already up and running?
 A: Yes, CPU notifiers are called only when new CPUs are on-lined or offlined.
    If you need to perform some action for each cpu already in the system, then
+   do this:
 
 	for_each_online_cpu(i) {
 		foobar_cpu_callback(&foobar_cpu_notifier, CPU_UP_PREPARE, i);
 		foobar_cpu_callback(&foobar_cpu_notifier, CPU_ONLINE, i);
 	}
 
+   However, if you want to register a hotplug callback, as well as perform
+   some initialization for CPUs that are already online, then do this:
+
+   Version 1: (Correct)
+   ---------
+
+   	cpu_notifier_register_begin();
+
+		for_each_online_cpu(i) {
+			foobar_cpu_callback(&foobar_cpu_notifier,
+					    CPU_UP_PREPARE, i);
+			foobar_cpu_callback(&foobar_cpu_notifier,
+					    CPU_ONLINE, i);
+		}
+
+	/* Note the use of the double underscored version of the API */
+	__register_cpu_notifier(&foobar_cpu_notifier);
+
+	cpu_notifier_register_done();
+
+   Note that the following code is *NOT* the right way to achieve this,
+   because it is prone to an ABBA deadlock between the cpu_add_remove_lock
+   and the cpu_hotplug.lock.
+
+   Version 2: (Wrong!)
+   ---------
+
+	get_online_cpus();
+
+		for_each_online_cpu(i) {
+			foobar_cpu_callback(&foobar_cpu_notifier,
+					    CPU_UP_PREPARE, i);
+			foobar_cpu_callback(&foobar_cpu_notifier,
+					    CPU_ONLINE, i);
+		}
+
+	register_cpu_notifier(&foobar_cpu_notifier);
+
+	put_online_cpus();
+
+    So always use the first version shown above when you want to register
+    callbacks as well as initialize the already online CPUs.
+
+
 Q: If i would like to develop cpu hotplug support for a new architecture,
    what do i need at a minimum?
 A: The following are what is required for CPU hotplug infrastructure to work
