Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBF4E1A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 04:28:35 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Sun, 27 Sep 2015 12:28:33 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1062C3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 12:28:31 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8RIRasR57344190
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 11:27:36 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8RISU59015621
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 12:28:30 -0600
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Cc: <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <cl@linux.com>,
 <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <khandual@linux.vnet.ibm.com>
Subject: [PATCH RFC 3/5] powerpc:numa create 1:1 mappaing between chipid and
 nid
Date: Sun, 27 Sep 2015 23:59:11 +0530
Message-Id: <1443378553-2146-4-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
In-Reply-To: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once we have made the distinction between nid and chipid
create a 1:1 mapping between them. This makes compacting the
nids easy later.

No functionality change.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f84ed2f..dd2073b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -264,6 +264,17 @@ out:
 	return chipid;
 }
 
+
+ /* Return the nid from associativity */
+static int associativity_to_nid(const __be32 *associativity)
+{
+	int nid;
+
+	nid = associativity_to_chipid(associativity);
+	return nid;
+}
+
+
 /* Returns the chipid associated with the given device tree node,
  * or -1 if not found.
  */
@@ -278,6 +289,17 @@ static int of_node_to_chipid_single(struct device_node *device)
 	return chipid;
 }
 
+/*
+ * Returns nid from the chipid associated with given tree node
+ */
+static int of_node_to_nid_single(struct device_node *device)
+{
+	int nid;
+
+	nid = of_node_to_chipid_single(device);
+	return nid;
+}
+
 /* Walk the device tree upwards, looking for an associativity id */
 int of_node_to_nid(struct device_node *device)
 {
@@ -286,7 +308,7 @@ int of_node_to_nid(struct device_node *device)
 
 	of_node_get(device);
 	while (device) {
-		nid = of_node_to_chipid_single(device);
+		nid = of_node_to_nid_single(device);
 		if (nid != -1)
 			break;
 
@@ -498,7 +520,7 @@ static int of_get_assoc_arrays(struct device_node *memory,
 }
 
 /*
- * This is like of_node_to_chipid_single() for memory represented in the
+ * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
 static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
@@ -557,7 +579,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 			goto out;
 	}
 
-	nid = of_node_to_chipid_single(cpu);
+	nid = of_node_to_nid_single(cpu);
 
 out_present:
 	if (nid < 0 || !node_online(nid))
@@ -754,7 +776,7 @@ static int __init parse_numa_properties(void)
 
 		cpu = of_get_cpu_node(i, NULL);
 		BUG_ON(!cpu);
-		nid = of_node_to_chipid_single(cpu);
+		nid = of_node_to_nid_single(cpu);
 		of_node_put(cpu);
 
 		/*
@@ -796,7 +818,7 @@ new_range:
 		 * have associativity properties.  If none, then
 		 * everything goes to default_nid.
 		 */
-		nid = of_node_to_chipid_single(memory);
+		nid = of_node_to_nid_single(memory);
 		if (nid < 0)
 			nid = default_nid;
 
@@ -1119,7 +1141,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 			if ((scn_addr < start) || (scn_addr >= (start + size)))
 				continue;
 
-			nid = of_node_to_chipid_single(memory);
+			nid = of_node_to_nid_single(memory);
 			break;
 		}
 
@@ -1415,7 +1437,7 @@ int arch_update_cpu_topology(void)
 
 		/* Use associativity from first thread for all siblings */
 		vphn_get_associativity(cpu, associativity);
-		new_nid = associativity_to_chipid(associativity);
+		new_nid = associativity_to_nid(associativity);
 		if (new_nid < 0 || !node_online(new_nid))
 			new_nid = first_online_node;
 
-- 
1.7.11.7
