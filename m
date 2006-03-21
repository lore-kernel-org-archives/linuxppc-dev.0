Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46B86679F5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:47:35 +1100 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0eedk003049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:40 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0eRfg003752
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:27 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0eG7U189268
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:16 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L0eGQS020860
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:16 -0500
Subject: [PATCH 5/7] powerpc numa: Consolidate handling of Power4 special case
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:36:15 -0600
Message-Id: <11429013752643-git-send-email-nathanl@austin.ibm.com>
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

Code to handle Power4's invalid node id (0xffff) is duplicated for cpu
and memory.  Better to handle this case in one place --
of_node_to_nid.  Overall behavior should be unchanged.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

d9dd3889e58eeb34d1130d2514fea905ca2cab6a
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e511ca1..4a6cbb0 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -207,6 +207,11 @@ static int of_node_to_nid(struct device_
 		    device->full_name);
 		nid = 0;
 	}
+
+	/* POWER4 LPAR uses 0xffff as invalid node */
+	if (nid == 0xffff)
+		nid = 0;
+
 	return nid;
 }
 
@@ -297,14 +302,9 @@ static int __cpuinit numa_setup_cpu(unsi
 	nid = of_node_to_nid(cpu);
 
 	if (nid >= num_online_nodes()) {
-		/*
-		 * POWER4 LPAR uses 0xffff as invalid node,
-		 * dont warn in this case.
-		 */
-		if (nid != 0xffff)
-			printk(KERN_ERR "WARNING: cpu %ld "
-			       "maps to invalid NUMA node %d\n",
-			       lcpu, nid);
+		printk(KERN_ERR "WARNING: cpu %ld "
+		       "maps to invalid NUMA node %d\n",
+		       lcpu, nid);
 		nid = 0;
 	}
 out:
@@ -442,10 +442,9 @@ new_range:
 		nid = of_node_to_nid(memory);
 
 		if (nid >= MAX_NUMNODES) {
-			if (nid != 0xffff)
-				printk(KERN_ERR "WARNING: memory at %lx maps "
-				       "to invalid NUMA node %d\n", start,
-				       nid);
+			printk(KERN_ERR "WARNING: memory at %lx maps "
+			       "to invalid NUMA node %d\n", start,
+			       nid);
 			nid = 0;
 		}
 
-- 
1.2.4
