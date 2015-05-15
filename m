Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8E4C1A1D0B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:15:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 15 May 2015 09:45:15 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 10B96125805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:47:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F4FC7Q57344222
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:45:12 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F3aFdF025523
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 09:06:16 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] perf/script: Script to display the ganged exits count
 on powerpc
Date: Fri, 15 May 2015 09:44:26 +0530
Message-Id: <1431663266-13954-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1431663266-13954-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1431663266-13954-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org,
 acme@kernel.org, warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc, when a thread running in the guest context needs to exit to
the hypervisor to serve interrupts like the external interrupt, or the
hcall interrupt, etc, all the threads running in that specific vcore
inside the guest exit. These events can be classified as gang exits
which mean that they are forced exits. Only if the other vcpus cede,
then it won't be counted as a ganged exit.

What this script does is, it post processes the perf.data file to look
for two events : kvm_hv:kvmppc_run_core and kvm_hv:kvm_guest_exit. For a
kvm_hv:kvmppc_run_core tracepoint event, it initializes :

- if its an 'Entry', it gets the tgid and for that tgid, it initializes
  gang-exit count and cedes count.
- if its an 'Exit', it gets the runnable thread count and subtracts it
  from the no of cedes to see (if) how many runnable threads were in
  that core and how many of them ceded. If the difference is more than
  1 (its 1 because, we have to exclude the running thread itself), then
  its a ganged exit.

For a kvm_hv:kvm_guest_exit event, it checks if the vcpu ceded. If it
ceded, then increment the counter for cedes.

Usage :
 # perf record -e kvm_hv:kvm_guest_exit -e kvm_hv:kvmppc_run_core -a sleep 10
[ perf record: Woken up 96 times to write data ]
[ perf record: Captured and wrote 26.198 MB perf.data (~1144590 samples)]

 # perf script -s gang-exits.py
Ganged exits summary

Ganged exits for process 14000 :                        535
Ganged exits for process 13988 :                      25314
=======================================

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 tools/perf/scripts/python/gang_exits.py | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/perf/scripts/python/gang_exits.py

diff --git a/tools/perf/scripts/python/gang_exits.py b/tools/perf/scripts/python/gang_exits.py
new file mode 100644
index 0000000..011aa56
--- /dev/null
+++ b/tools/perf/scripts/python/gang_exits.py
@@ -0,0 +1,65 @@
+# gang-exits.py: Count the ganged exits of a VM
+#
+# In case of powerpc, When a thread running inside a guest needs to exit to
+# the hypervisor to serve interrupts like the external interrupt, or the hcall
+# interrupts, etc., all the threads running in that specific vcore
+# inside the guest exit to the host. These events are called as ganged exits.
+# These exits are forced. Only if the vcpus cede, then it/they won't be counted
+# as ganged exit(s).
+#
+# Usage :
+# So, if in powerpc, first we do :
+# perf record -e kvm_hv:kvm_guest_exit -e kvm_hv:kvmppc_run_core -aR sleep <nsecs>
+# Using the perf.data, we have to do :
+# perf script -s gang-exits
+
+import os
+import sys
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+                '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+
+usage = "perf script -s gang_exits.py\n";
+
+stats = {}
+pid_tgid = {}
+
+def trace_begin():
+	print "Ganged exits summary"
+
+def trace_end():
+	print_ganged_exits()
+
+def kvm_hv__kvm_guest_exit(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	vcpu_id, reason, nip, msr, ceded):
+
+	if common_pid in pid_tgid:
+		if ceded:		# vcpu ceded ?
+			stats[pid_tgid[common_pid]]['nr_cedes'] += ceded
+
+def kvm_hv__kvmppc_run_core(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	n_runnable, runner_vcpu, where, tgid):
+
+	if (where):	# kvmppc_run_core: Exit
+		if tgid in stats:
+			forced = n_runnable - stats[tgid]['nr_cedes']
+			if (forced > 1):
+				stats[tgid]['gang-exits'] += 1
+	else: 		# kvmppc_run_core: Enter, init the counts
+		if tgid in stats:
+			stats[tgid]['nr_cedes'] = 0
+		else:
+			stats[tgid] = {'gang-exits': 0, 'nr_cedes': 0}
+		if common_pid not in pid_tgid:
+			pid_tgid[common_pid] = tgid
+
+def print_ganged_exits():
+	for i in stats.keys():
+		print "\nGanged exits for process %d : %20d" %(i, stats[i]['gang-exits'])
+
+	print "======================================="
-- 
1.9.3
