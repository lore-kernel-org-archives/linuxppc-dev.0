Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B58612C010E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:47 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 06:34:47 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CF5723578053
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:13 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKEDYV5767672
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:14:13 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKYCXx017131
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:13 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 01/52] CPU hotplug: Add lockdep annotations to
 get/put_online_cpus()
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:04:03 +0530
Message-ID: <20140310203402.10746.59486.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 walken@google.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org,
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

From: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Add lockdep annotations for get/put_online_cpus() and
cpu_hotplug_begin()/cpu_hotplug_end().

Cc: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/cpu.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index deff2e6..33caf5e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/gfp.h>
 #include <linux/suspend.h>
+#include <linux/lockdep.h>
 
 #include "smpboot.h"
 
@@ -57,17 +58,30 @@ static struct {
 	 * an ongoing cpu hotplug operation.
 	 */
 	int refcount;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
 } cpu_hotplug = {
 	.active_writer = NULL,
 	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
 	.refcount = 0,
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	.dep_map = {.name = "cpu_hotplug.lock" },
+#endif
 };
 
+/* Lockdep annotations for get/put_online_cpus() and cpu_hotplug_begin/end() */
+#define cpuhp_lock_acquire_read() lock_map_acquire_read(&cpu_hotplug.dep_map)
+#define cpuhp_lock_acquire()      lock_map_acquire(&cpu_hotplug.dep_map)
+#define cpuhp_lock_release()      lock_map_release(&cpu_hotplug.dep_map)
+
 void get_online_cpus(void)
 {
 	might_sleep();
 	if (cpu_hotplug.active_writer == current)
 		return;
+	cpuhp_lock_acquire_read();
 	mutex_lock(&cpu_hotplug.lock);
 	cpu_hotplug.refcount++;
 	mutex_unlock(&cpu_hotplug.lock);
@@ -87,6 +101,7 @@ void put_online_cpus(void)
 	if (!--cpu_hotplug.refcount && unlikely(cpu_hotplug.active_writer))
 		wake_up_process(cpu_hotplug.active_writer);
 	mutex_unlock(&cpu_hotplug.lock);
+	cpuhp_lock_release();
 
 }
 EXPORT_SYMBOL_GPL(put_online_cpus);
@@ -117,6 +132,7 @@ void cpu_hotplug_begin(void)
 {
 	cpu_hotplug.active_writer = current;
 
+	cpuhp_lock_acquire();
 	for (;;) {
 		mutex_lock(&cpu_hotplug.lock);
 		if (likely(!cpu_hotplug.refcount))
@@ -131,6 +147,7 @@ void cpu_hotplug_done(void)
 {
 	cpu_hotplug.active_writer = NULL;
 	mutex_unlock(&cpu_hotplug.lock);
+	cpuhp_lock_release();
 }
 
 /*
