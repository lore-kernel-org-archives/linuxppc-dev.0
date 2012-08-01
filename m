Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 514DA2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 17:22:40 +1000 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jlarrew@linux.vnet.ibm.com>;
 Wed, 1 Aug 2012 03:22:36 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B4D13C90046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 03:22:16 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q717MGQA17301582
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 03:22:16 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q71Cr89M011092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 08:53:08 -0400
Message-ID: <5018D926.6010709@linux.vnet.ibm.com>
Date: Wed, 01 Aug 2012 02:22:14 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] vphn: fix arch_update_cpu_topology() return value
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 5dfd547532fca61462dc17fd0bb8e533002c4bc5 Mon Sep 17 00:00:00 2001
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2012 16:04:34 -0500

arch_update_cpu_topology() should only return 1 when the topology has
actually changed, and should return 0 otherwise.

This patch fixes a potential bug where rebuild_sched_domains() would
reinitialize the sched domains even when the topology hasn't changed.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 39b1597..59213cf 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1436,11 +1436,11 @@ static long vphn_get_associativity(unsigned long cpu,
 
 /*
  * Update the node maps and sysfs entries for each cpu whose home node
- * has changed.
+ * has changed. Returns 1 when the topology has changed, and 0 otherwise.
  */
 int arch_update_cpu_topology(void)
 {
-	int cpu, nid, old_nid;
+	int cpu, nid, old_nid, changed = 0;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	struct device *dev;
 
@@ -1466,9 +1466,10 @@ int arch_update_cpu_topology(void)
 		dev = get_cpu_device(cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+		changed = 1;
 	}
 
-	return 1;
+	return changed;
 }
 
 static void topology_work_fn(struct work_struct *work)
-- 
1.7.7.6


Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
