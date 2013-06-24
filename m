Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58CAF2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:14:28 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 00:00:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7E3723578045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:14:26 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OEEGJk1901030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:14:17 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OEEPKs021294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:14:25 +1000
Received: from [9.41.105.123] ([9.41.105.123])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r5OEEOYQ021275
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:14:24 +1000
Message-ID: <51C8543F.6080905@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 09:14:23 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Do not update sysfs cpu registration from invalid context
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
+++ powerpc/arch/powerpc/mm/numa.c	2013-06-24 06:56:30.000000000 -0500
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
+		unregister_cpu_under_node(update->cpu, update->old_nid);
+		register_cpu_under_node(update->cpu, update->new_nid);
+
 		dev = get_cpu_device(ud->cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
