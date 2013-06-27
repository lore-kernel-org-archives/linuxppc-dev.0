Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D20122C035B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:00:41 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 01:23:38 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 82703394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:30:36 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RK0s9h25362506
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:30:54 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RK0YqK014511
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:00:37 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 28/45] perf/x86: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:27:18 +0530
Message-ID: <20130627195718.29830.42774.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, x86@kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_DYING notifier modifies the per-cpu pointer pmu->box, and this can
race with functions such as uncore_pmu_to_box() and uncore_pci_remove() when
we remove stop_machine() from the CPU offline path. So protect them using
get/put_online_cpus_atomic().

Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/cpu/perf_event_intel_uncore.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_uncore.c b/arch/x86/kernel/cpu/perf_event_intel_uncore.c
index 9dd9975..7c2a064 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_uncore.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_uncore.c
@@ -1,3 +1,4 @@
+#include <linux/cpu.h>
 #include "perf_event_intel_uncore.h"
 
 static struct intel_uncore_type *empty_uncore[] = { NULL, };
@@ -2630,6 +2631,7 @@ uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
 	if (box)
 		return box;
 
+	get_online_cpus_atomic();
 	raw_spin_lock(&uncore_box_lock);
 	list_for_each_entry(box, &pmu->box_list, list) {
 		if (box->phys_id == topology_physical_package_id(cpu)) {
@@ -2639,6 +2641,7 @@ uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
 		}
 	}
 	raw_spin_unlock(&uncore_box_lock);
+	put_online_cpus_atomic();
 
 	return *per_cpu_ptr(pmu->box, cpu);
 }
@@ -3229,6 +3232,7 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	list_del(&box->list);
 	raw_spin_unlock(&uncore_box_lock);
 
+	get_online_cpus_atomic();
 	for_each_possible_cpu(cpu) {
 		if (*per_cpu_ptr(pmu->box, cpu) == box) {
 			*per_cpu_ptr(pmu->box, cpu) = NULL;
@@ -3237,6 +3241,8 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	}
 
 	WARN_ON_ONCE(atomic_read(&box->refcnt) != 1);
+	put_online_cpus_atomic();
+
 	kfree(box);
 }
 
