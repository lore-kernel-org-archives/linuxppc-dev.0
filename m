Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43E612C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 05:59:57 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Mar 2013 14:59:54 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3E5A36E8070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:59:46 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2PIxDSx48103526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:59:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2PIxD1N025806
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 15:59:13 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2PIxBsh025704
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 15:59:12 -0300
Message-ID: <51509E7F.6020707@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2013 13:59:11 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 8/11] Update numa cpu vdso info
References: <51509AE8.8070803@linux.vnet.ibm.com>
In-Reply-To: <51509AE8.8070803@linux.vnet.ibm.com>
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
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-20 12:27:43.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-20 12:27:46.000000000 -0500
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
