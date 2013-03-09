Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5A772C03A4
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:07:12 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:07:10 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9A6CA6E801D
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 23:07:05 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r29477kr317746
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 23:07:07 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2949fZw013630
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:09:41 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2949eLn013558
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:09:41 -0700
Message-ID: <513AB569.1040106@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:07:05 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/11] Update numa cpu vdso info
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
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

http://patchwork.ozlabs.org/patch/169070/

This patch ensures that this information is also updated when the NUMA
affinity of a cpu changes.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-08 19:57:47.000000000 -0600
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-08 19:57:59.000000000 -0600
@@ -30,6 +30,7 @@
 #include <asm/paca.h>
 #include <asm/hvcall.h>
 #include <asm/setup.h>
+#include <asm/vdso.h>
 
 static int numa_enabled = 1;
 
@@ -1426,6 +1427,7 @@
 	unregister_cpu_under_node(update->cpu, update->old_nid);
 	unmap_cpu_from_node(update->cpu);
 	map_cpu_to_node(update->cpu, update->new_nid);
+	vdso_getcpu_init();
 	register_cpu_under_node(update->cpu, update->new_nid);
 
 	return 0;
@@ -1440,8 +1442,11 @@
 	int cpu, changed = 0;
 	struct topology_update_data update;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	cpumask_t updated_cpu;
 	struct device *dev;
 
+	cpumask_clear(&updated_cpu);
+
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
 		update.cpu = cpu;
 		vphn_get_associativity(cpu, associativity);
@@ -1451,7 +1456,8 @@
 			update.new_nid = first_online_node;
 
 		update.old_nid = numa_cpu_lookup_table[cpu];
-		stop_machine(update_cpu_topology, &update, cpu_online_mask);
+		cpumask_set_cpu(cpu, &updated_cpu);
+		stop_machine(update_cpu_topology, &update, &updated_cpu);
 		dev = get_cpu_device(cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
