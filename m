Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HW0L0xgCzF1nV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:04:49 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM4NZi115923
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:04:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwrwmsamb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:04:47 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:04:46 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v05 6/9] pmt/numa: Disable arch_update_cpu_topology during CPU
 readd
In-Reply-To: <e73c6076-34d9-d3fb-d1f0-ccef14dae093@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:04:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a752c24b-cfc3-4715-4e07-3e4f6e3d4050@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pmt/numa: Disable arch_update_cpu_topology during post migration
CPU readd updates when evaluating device-tree changes after LPM
to avoid thread deadlocks trying to update node assignments.
System timing between all of the threads and timers restarted in
a migrated system overlapped frequently allowing tasks to start
acquiring resources (get_online_cpus) needed by rebuild_sched_domains.
Defer the operation of that function until after the CPU readd has
completed.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 8f28160..6267b53 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -26,6 +26,7 @@
 #include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/sched/hotplug.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <asm/prom.h>
@@ -685,9 +686,15 @@ static int dlpar_cpu_readd_by_index(u32 drc_index)
 
 	pr_info("Attempting to re-add CPU, drc index %x\n", drc_index);
 
+	arch_update_cpu_topology_suspend();
 	rc = dlpar_cpu_remove_by_index(drc_index, false);
-	if (!rc)
+	arch_update_cpu_topology_resume();
+
+	if (!rc) {
+		arch_update_cpu_topology_suspend();
 		rc = dlpar_cpu_add(drc_index, false);
+		arch_update_cpu_topology_resume();
+	}
 
 	if (rc)
 		pr_info("Failed to update cpu at drc_index %lx\n",
