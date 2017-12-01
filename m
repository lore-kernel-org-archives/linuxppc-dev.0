Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLDG0Pz7zDsQ3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:02:21 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1H13QD072566
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:02:19 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ek7seuwfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:02:19 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:02:17 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H2GK449938530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:02:16 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D447AC03F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:03:14 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id EA695AC043
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:03:13 -0500 (EST)
Subject: [PATCH V3 3/9] powerpc/numa: Look up associativity array in
 of_drconf_to_nid_single
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:46:53 -0600
In-Reply-To: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214680997.64022.11558560567274075939.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Look up the associativity arrays in of_drconf_to_nid_single when
deriving the nid for a LMB instead of having it passed in as a
parameter.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index baba6403488b..d25278adaead 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -509,26 +509,30 @@ static int of_get_assoc_arrays(struct assoc_arrays *aa)
  * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
-				   struct assoc_arrays *aa)
+static int of_drconf_to_nid_single(struct of_drconf_cell *drmem)
 {
+	struct assoc_arrays aa = { .arrays = NULL };
 	int default_nid = 0;
 	int nid = default_nid;
-	int index;
+	int rc, index;
+
+	rc = of_get_assoc_arrays(&aa);
+	if (rc)
+		return default_nid;
 
-	if (min_common_depth > 0 && min_common_depth <= aa->array_sz &&
+	if (min_common_depth > 0 && min_common_depth <= aa.array_sz &&
 	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
-	    drmem->aa_index < aa->n_arrays) {
-		index = drmem->aa_index * aa->array_sz + min_common_depth - 1;
-		nid = of_read_number(&aa->arrays[index], 1);
+	    drmem->aa_index < aa.n_arrays) {
+		index = drmem->aa_index * aa.array_sz + min_common_depth - 1;
+		nid = of_read_number(&aa.arrays[index], 1);
 
 		if (nid == 0xffff || nid >= MAX_NUMNODES)
 			nid = default_nid;
 
 		if (nid > 0) {
-			index = drmem->aa_index * aa->array_sz;
+			index = drmem->aa_index * aa.array_sz;
 			initialize_distance_lookup_table(nid,
-							&aa->arrays[index]);
+							&aa.arrays[index]);
 		}
 	}
 
@@ -664,10 +668,9 @@ static inline int __init read_usm_ranges(const __be32 **usm)
 static void __init parse_drconf_memory(struct device_node *memory)
 {
 	const __be32 *uninitialized_var(dm), *usm;
-	unsigned int n, rc, ranges, is_kexec_kdump = 0;
+	unsigned int n, ranges, is_kexec_kdump = 0;
 	unsigned long lmb_size, base, size, sz;
 	int nid;
-	struct assoc_arrays aa = { .arrays = NULL };
 
 	n = of_get_drconf_memory(memory, &dm);
 	if (!n)
@@ -677,10 +680,6 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	if (!lmb_size)
 		return;
 
-	rc = of_get_assoc_arrays(&aa);
-	if (rc)
-		return;
-
 	/* check if this is a kexec/kdump kernel */
 	usm = of_get_usable_memory();
 	if (usm != NULL)
@@ -711,7 +710,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 				base = read_n_cells(n_mem_addr_cells, &usm);
 				size = read_n_cells(n_mem_size_cells, &usm);
 			}
-			nid = of_drconf_to_nid_single(&drmem, &aa);
+			nid = of_drconf_to_nid_single(&drmem);
 			fake_numa_create_new_node(
 				((base + size) >> PAGE_SHIFT),
 					   &nid);
@@ -999,9 +998,8 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 				     unsigned long scn_addr)
 {
 	const __be32 *dm;
-	unsigned int drconf_cell_cnt, rc;
+	unsigned int drconf_cell_cnt;
 	unsigned long lmb_size;
-	struct assoc_arrays aa;
 	int nid = -1;
 
 	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
@@ -1012,10 +1010,6 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 	if (!lmb_size)
 		return -1;
 
-	rc = of_get_assoc_arrays(&aa);
-	if (rc)
-		return -1;
-
 	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
 		struct of_drconf_cell drmem;
 
@@ -1031,7 +1025,7 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 		    || (scn_addr >= (drmem.base_addr + lmb_size)))
 			continue;
 
-		nid = of_drconf_to_nid_single(&drmem, &aa);
+		nid = of_drconf_to_nid_single(&drmem);
 		break;
 	}
 
