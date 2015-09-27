Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B22C01A0510
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 04:28:44 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Sun, 27 Sep 2015 14:28:42 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5BE6BC90042
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:19:43 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8RISeti66388206
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 18:28:40 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8RISd5x025298
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:28:39 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Cc: <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <cl@linux.com>,
 <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <khandual@linux.vnet.ibm.com>
Subject: [PATCH RFC 5/5] powerpc:numa Use chipid to nid mapping to get serial
 numa node ids
Date: Sun, 27 Sep 2015 23:59:13 +0530
Message-Id: <1443378553-2146-6-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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

Also properly initialize numa distance table for serial nids.

Problem: Powerpc supports sparse nid numbering which could affect
1) memory footprint 2) virtualization use cases

Current solution:
The patch maps sprase chipid got fromn device tree to serail
nids.

Result before:
node   0   1  16  17
  0:  10  20  40  40
  1:  20  10  40  40
 16:  40  40  10  20
 17:  40  40  20  10

After:
node   0   1   2   3
  0:  10  20  40  40
  1:  20  10  40  40
  2:  40  40  10  20
  3:  40  40  20  10

Testing: Scenarios tested on  baremetal and KVM guest with 4 nodes
1) offlining and onlining memory and cpus
2) Running the tests from numactl source.
3) Creating 1000s of docker containers stressing the system

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f015cad..873ac8c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -304,7 +304,8 @@ static int associativity_to_chipid(const __be32 *associativity)
 		/*
 		 * Skip the length field and send start of associativity array
 		 */
-		initialize_distance_lookup_table(chipid, associativity + 1);
+		initialize_distance_lookup_table(chipid_to_nid(chipid),
+						 associativity + 1);
 	}
 
 out:
@@ -314,9 +315,10 @@ out:
  /* Return the nid from associativity */
 static int associativity_to_nid(const __be32 *associativity)
 {
-	int nid;
+	int chipid, nid;
 
-	nid = associativity_to_chipid(associativity);
+	chipid = associativity_to_chipid(associativity);
+	nid = map_chipid_to_nid(chipid);
 	return nid;
 }
 
@@ -340,9 +342,10 @@ static int of_node_to_chipid_single(struct device_node *device)
  */
 static int of_node_to_nid_single(struct device_node *device)
 {
-	int nid;
+	int chipid, nid;
 
-	nid = of_node_to_chipid_single(device);
+	chipid = of_node_to_chipid_single(device);
+	nid = map_chipid_to_nid(chipid);
 	return nid;
 }
 
-- 
1.7.11.7
