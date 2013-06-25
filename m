Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 884E42C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 13:08:15 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 08:32:11 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AA5CFE004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:37:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P383Kn23134376
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:38:03 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P387PK009346
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 13:08:07 +1000
Received: from [9.65.228.184] (sig-9-65-228-184.mts.ibm.com [9.65.228.184])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r5P385dg009268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 13:08:06 +1000
Message-ID: <51C90995.1020401@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 22:08:05 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] Do not update sysfs cpu registration from invalid context
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The topology update code that updates the cpu node registration in sysfs
should not be called while in stop_machine(). The register/unregister
calls take a lock and may sleep.

This patch moves these calls outside of the call to stop_machine().

Signed-off-by:Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-06-24 06:53:31.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-06-24 14:28:14.000000000 -0500
@@ -1433,11 +1433,9 @@
 		if (cpu != update->cpu)
 			continue;
 
-		unregister_cpu_under_node(update->cpu, update->old_nid);
 		unmap_cpu_from_node(update->cpu);
 		map_cpu_to_node(update->cpu, update->new_nid);
 		vdso_getcpu_init();
-		register_cpu_under_node(update->cpu, update->new_nid);
 	}
 
 	return 0;
@@ -1485,6 +1483,9 @@
 	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
 
 	for (ud = &updates[0]; ud; ud = ud->next) {
+		unregister_cpu_under_node(ud->cpu, ud->old_nid);
+		register_cpu_under_node(ud->cpu, ud->new_nid);
+
 		dev = get_cpu_device(ud->cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
