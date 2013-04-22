Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71CBD2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:45:30 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:45:27 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C179138C801C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:45:23 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIjN2T307150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:45:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIjNZc006866
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:45:23 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIjKxI006719
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:45:21 -0300
Message-ID: <51758540.901@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:45:20 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 9/12] Update NUMA VDSO information
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

The following patch adds vdso_getcpu_init(), which stores the NUMA node for
a cpu in SPRG3:

Commit 18ad51dd34 ("powerpc: Add VDSO version of getcpu") adds
vdso_getcpu_init(), which stores the NUMA node for a cpu in SPRG3.

This patch ensures that this information is also updated when the NUMA
affinity of a cpu changes.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-04-18 09:10:11.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-04-22 09:39:02.000000000 -0500
@@ -30,6 +30,7 @@
 #include <asm/paca.h>
 #include <asm/hvcall.h>
 #include <asm/setup.h>
+#include <asm/vdso.h>
 
 static int numa_enabled = 1;
 
@@ -1434,6 +1435,7 @@
 		unregister_cpu_under_node(update->cpu, update->old_nid);
 		unmap_cpu_from_node(update->cpu);
 		map_cpu_to_node(update->cpu, update->new_nid);
+		vdso_getcpu_init();
 		register_cpu_under_node(update->cpu, update->new_nid);
 	}
 
@@ -1449,6 +1451,7 @@
 	unsigned int cpu, changed = 0;
 	struct topology_update_data *updates, *ud;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, i = 0;
 
@@ -1460,6 +1463,8 @@
 	if (!updates)
 		return 0;
 
+	cpumask_clear(&updated_cpus);
+
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
 		ud = &updates[i++];
 		ud->cpu = cpu;
@@ -1470,12 +1475,13 @@
 			ud->new_nid = first_online_node;
 
 		ud->old_nid = numa_cpu_lookup_table[cpu];
+		cpumask_set_cpu(cpu, &updated_cpus);
 
 		if (i < weight)
 			ud->next = &updates[i];
 	}
 
-	stop_machine(update_cpu_topology, &updates[0], cpu_online_mask);
+	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
 
 	for (ud = &updates[0]; ud; ud = ud->next) {
 		dev = get_cpu_device(ud->cpu);
