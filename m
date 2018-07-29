Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41djwT1V5KzF18k
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:19:37 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6TDIhIN035281
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:35 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kh5qk3y2r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:34 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 29 Jul 2018 07:19:33 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v08 4/5] mobility/numa: Ensure numa update does not overlap
In-Reply-To: <9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>
Date: Sun, 29 Jul 2018 08:19:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <59915ae4-0524-7896-7bed-8b64005f8da3@linux.vnet.ibm.com>
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
many different paths through the code.  Without some protection
against multiple entry, the code may acquire and update associativity
information from the PHYP in multiple threads, and apply changes
separately in each thread.  Applying the changes concurrently may
perform considerable work multiple times, but more importantly,
may acquire locks in other modules concurrently and end up blocking
each of the competing threads.  This patch allows only the first
entrant to the code to execute the operation and to recognize any
CPU topology changes.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in patch:
  -- Added information to description.
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
