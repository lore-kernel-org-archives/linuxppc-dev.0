Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DCB7D679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:05:16 +1100 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0cseL002836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:55 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0ckg4016585
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:38:46 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0ZlCO263324
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 17:35:47 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2L0ckvZ022292
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 17:38:46 -0700
Subject: [PATCH 2/7] powerpc numa: Minor debugging code changes
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:34:45 -0600
Message-Id: <11429012851755-git-send-email-nathanl@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add debug statement for map_cpu_to_node; it's useful for cpu hotplug.

Clarify debug statement about not finding the numa reference points
property.

Don't print a meaningless associativity depth (-1) on non-numa systems.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

3b4f550f0a92badbec6e5784eee4da7524a75938
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b813bad..de99e47 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -133,6 +133,8 @@ static inline void map_cpu_to_node(int c
 {
 	numa_cpu_lookup_table[cpu] = node;
 
+	dbg("adding cpu %d to node %d\n", cpu, node);
+
 	if (!(cpu_isset(cpu, numa_cpumask_lookup_table[node])))
 		cpu_set(cpu, numa_cpumask_lookup_table[node]);
 }
@@ -246,8 +248,7 @@ static int __init find_min_common_depth(
 	if ((len >= 1) && ref_points) {
 		depth = ref_points[1];
 	} else {
-		dbg("WARNING: could not find NUMA "
-		    "associativity reference point\n");
+		dbg("NUMA: ibm,associativity-reference-points not found.\n");
 		depth = -1;
 	}
 	of_node_put(rtas_root);
@@ -385,10 +386,11 @@ static int __init parse_numa_properties(
 
 	min_common_depth = find_min_common_depth();
 
-	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
 	if (min_common_depth < 0)
 		return min_common_depth;
 
+	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
+
 	/*
 	 * Even though we connect cpus to numa domains later in SMP init,
 	 * we need to know the maximum node id now. This is because each
-- 
1.2.4
