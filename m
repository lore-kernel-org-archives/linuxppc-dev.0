Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2f22Sv0zF145
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:30:02 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0SsN5105707
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:29:59 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jr01jtnw8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:29:59 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:29:58 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v04 4/9] mobility/numa: Ensure numa update does not overlap
In-Reply-To: <0425b353-54b0-6ccd-fbb6-3d26d9448bb5@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 19:29:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <3afa2079-7a00-34cb-8bc0-6e6dff25d8a8@linux.vnet.ibm.com>
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
index 8802e7d..d4543b3 100644
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
