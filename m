Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLr1W3011zDsRq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 06:01:19 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VJx1gl089125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c27csudn3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:16 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 16:01:15 -0400
Subject: [RFC PATCH 1/3] powerpc/numa: Get device node whenn retreiving
 associativity arrays
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com
Date: Mon, 31 Jul 2017 15:48:15 -0400
In-Reply-To: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170731194815.8956.88849.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we move to using the kernel lmb structs instead of accessing
the device tree directly for LMB information we will no longer have
a pointer to the device node for memory to pass to of_get_assoc_arrays().

This patch updates of_get_assoc_arrays() to no longer take a device node
pointer and does the lookup of the memory device node itself.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 371792e..9c21953 100644
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
 
