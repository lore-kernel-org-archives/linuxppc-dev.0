Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB54B2C07E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:48:00 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 17:42:43 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 125D43578023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:47:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7aAaN53346430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:36:10 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7lrQm010175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:47:55 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 45/45] Documentation/cpu-hotplug: Remove references to
 stop_machine()
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:15:48 +0530
Message-ID: <20130122074543.13822.44724.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since stop_machine() is no longer used in the CPU offline path, we cannot
disable CPU hotplug using preempt_disable()/local_irq_disable() etc. We
need to use the newly introduced get/put_online_cpus_atomic() APIs.
Reflect this in the documentation.

Cc: Rob Landley <rob@landley.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 Documentation/cpu-hotplug.txt |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
index 9f40135..7f907ec 100644
--- a/Documentation/cpu-hotplug.txt
+++ b/Documentation/cpu-hotplug.txt
@@ -113,13 +113,15 @@ Never use anything other than cpumask_t to represent bitmap of CPUs.
 	#include <linux/cpu.h>
 	get_online_cpus() and put_online_cpus():
 
-The above calls are used to inhibit cpu hotplug operations. While the
+The above calls are used to inhibit cpu hotplug operations, when invoked from
+non-atomic context (because the above functions can sleep). While the
 cpu_hotplug.refcount is non zero, the cpu_online_mask will not change.
-If you merely need to avoid cpus going away, you could also use
-preempt_disable() and preempt_enable() for those sections.
-Just remember the critical section cannot call any
-function that can sleep or schedule this process away. The preempt_disable()
-will work as long as stop_machine_run() is used to take a cpu down.
+
+However, if you are executing in atomic context (ie., you can't afford to
+sleep), and you merely need to avoid cpus going offline, you can use
+get_online_cpus_atomic() and put_online_cpus_atomic() for those sections.
+Just remember the critical section cannot call any function that can sleep or
+schedule this process away.
 
 CPU Hotplug - Frequently Asked Questions.
 
@@ -360,6 +362,9 @@ A: There are two ways.  If your code can be run in interrupt context, use
 		return err;
 	}
 
+   If my_func_on_cpu() itself cannot block, use get/put_online_cpus_atomic()
+   instead of get/put_online_cpus() to prevent CPUs from going offline.
+
 Q: How do we determine how many CPUs are available for hotplug.
 A: There is no clear spec defined way from ACPI that can give us that
    information today. Based on some input from Natalie of Unisys,
