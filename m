Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJRf973FdzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 00:36:33 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9KDYhVN059397
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dqe5q4c7q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:31 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 20 Oct 2017 09:36:29 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9KDaR5J41418874
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 13:36:27 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F291428048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:19 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id D31C628046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:19 -0400 (EDT)
Subject: [PATCH v2 1/8] powerpc/numa: Look up device node in
 of_get_assoc_arrays()
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 20 Oct 2017 08:21:55 -0500
In-Reply-To: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150850571486.9118.2388881157853276144.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Look up the device node for the associativity array property instead
of having it passed in as a parameter. This changes precedes an update
in which the calling routines for of_get_assoc_arrays() will not have
the device node pointer to pass in.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b95c584ce19d..ca5cc1d4d387 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -466,19 +466,27 @@ struct assoc_arrays {
  * indicating the size of each associativity array, followed by a list
  * of N associativity arrays.
  */
-static int of_get_assoc_arrays(struct device_node *memory,
-			       struct assoc_arrays *aa)
+static int of_get_assoc_arrays(struct assoc_arrays *aa)
 {
+	struct device_node *memory;
 	const __be32 *prop;
 	u32 len;
 
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!memory)
+		return -1;
+
 	prop = of_get_property(memory, "ibm,associativity-lookup-arrays", &len);
-	if (!prop || len < 2 * sizeof(unsigned int))
+	if (!prop || len < 2 * sizeof(unsigned int)) {
+		of_node_put(memory);
 		return -1;
+	}
 
 	aa->n_arrays = of_read_number(prop++, 1);
 	aa->array_sz = of_read_number(prop++, 1);
 
+	of_node_put(memory);
+
 	/* Now that we know the number of arrays and size of each array,
 	 * revalidate the size of the property read in.
 	 */
@@ -661,7 +669,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	if (!lmb_size)
 		return;
 
-	rc = of_get_assoc_arrays(memory, &aa);
+	rc = of_get_assoc_arrays(&aa);
 	if (rc)
 		return;
 
@@ -996,7 +1004,7 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 	if (!lmb_size)
 		return -1;
 
-	rc = of_get_assoc_arrays(memory, &aa);
+	rc = of_get_assoc_arrays(&aa);
 	if (rc)
 		return -1;
 
