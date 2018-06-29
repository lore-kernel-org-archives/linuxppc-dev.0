Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HW024LxczF1xl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:04:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM4Lj1062712
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:04:32 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwt6ppapf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:04:31 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:04:30 -0400
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v05 4/9] mobility/numa: Ensure numa update does not overlap
In-Reply-To: <e73c6076-34d9-d3fb-d1f0-ccef14dae093@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:04:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <e0486d4a-96e1-5c24-e484-f6e0dd73af7b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mobility/numa: Ensure that numa_update_cpu_topology() can not be
entered multiple times concurrently.  It may be accessed through
many different paths / concurrent work functions, and the lock
ordering may be difficult to ensure otherwise.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index a789d57..b22e27a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1079,6 +1079,7 @@ struct topology_update_data {
 static int topology_timer_secs = 1;
 static int topology_inited;
 static int topology_update_needed;
+static struct mutex topology_update_lock;
 
 /*
  * Change polling interval for associativity changes.
@@ -1320,6 +1321,11 @@ int numa_update_cpu_topology(bool cpus_locked)
 	if (!updates)
 		return 0;
 
+	if (!mutex_trylock(&topology_update_lock)) {
+		kfree(updates);
+		return 0;
+	}
+
 	cpumask_clear(&updated_cpus);
 
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
@@ -1424,6 +1430,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 out:
 	kfree(updates);
 	topology_update_needed = 0;
+	mutex_unlock(&topology_update_lock);
 	return changed;
 }
 
@@ -1598,6 +1605,8 @@ static ssize_t topology_write(struct file *file, const char __user *buf,
 
 static int topology_update_init(void)
 {
+	mutex_init(&topology_update_lock);
+
 	/* Do not poll for changes if disabled at boot */
 	if (topology_updates_enabled)
 		start_topology_update();
