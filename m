Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2fC5wztzF0wy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:30:11 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0SqB3049767
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:30:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jr15b0j14-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:30:09 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:30:08 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v04 6/9] pmt/numa: Disable arch_update_cpu_topology during CPU
 readd
In-Reply-To: <0425b353-54b0-6ccd-fbb6-3d26d9448bb5@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 19:30:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <899b26ca-48fc-387d-3dd5-fa85550d4c93@linux.vnet.ibm.com>
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
