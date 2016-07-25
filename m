Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rypTW4jVGzDrJd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 03:41:35 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PHd6J3019528
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:41:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4nrdpmn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:41:33 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 11:41:32 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 818D43E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:41:19 -0600 (MDT)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PHfJ1N49479864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 17:41:19 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 150FC2803D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:41:19 -0400 (EDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id DC07C2803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:41:18 -0400 (EDT)
Subject: [PATCH v3 2/2] powerpc/pseries: Implement indexed-count hotplug
 memory remove
To: linuxppc-dev@lists.ozlabs.org
References: <ef1e34d9-376c-1418-2862-f2543452298e@linux.vnet.ibm.com>
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
Date: Mon, 25 Jul 2016 12:41:18 -0500
MIME-Version: 1.0
In-Reply-To: <ef1e34d9-376c-1418-2862-f2543452298e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <af2a02d5-8ca3-ef2f-c1ac-c467c197ad12@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Indexed-count remove for memory hotplug guarantees that a contiguous block
of <count> lmbs beginning at a specified <index> will be unassigned (NOT
that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
management, the removal of a contiguous block of memory currently
requires a series of individual calls. Indexed-count remove reduces
this series into a single call.

Signed-off-by: Sahil Mehta <smehta@linux.vnet.ibm.com>
---
v2:	-use u32s drc_index and count instead of u32 ic[]
	 in dlpar_memory
v3:	-add logic to handle invalid drc_index input

 arch/powerpc/platforms/pseries/hotplug-memory.c |   90 +++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2d4ceb3..dd5eb38 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -503,6 +503,92 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 	return rc;
 }

+static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
+				     struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int i, rc, start_lmb_found;
+	int lmbs_available = 0, start_index = 0, end_index;
+
+	pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
+		lmbs_to_remove, drc_index);
+
+	if (lmbs_to_remove == 0)
+		return -EINVAL;
+
+	p = prop->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+	start_lmb_found = 0;
+
+	/* Navigate to drc_index */
+	while (start_index < num_lmbs) {
+		if (lmbs[start_index].drc_index == drc_index) {
+			start_lmb_found = 1;
+			break;
+		}
+
+		start_index++;
+	}
+
+	if (!start_lmb_found)
+		return -EINVAL;
+
+	end_index = start_index + lmbs_to_remove;
+
+	/* Validate that there are enough LMBs to satisfy the request */
+	for (i = start_index; i < end_index; i++) {
+		if (lmbs[i].flags & DRCONF_MEM_RESERVED)
+			break;
+
+		lmbs_available++;
+	}
+
+	if (lmbs_available < lmbs_to_remove)
+		return -EINVAL;
+
+	for (i = 0; i < end_index; i++) {
+		if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
+			continue;
+
+		rc = dlpar_remove_lmb(&lmbs[i]);
+		if (rc)
+			break;
+
+		lmbs[i].reserved = 1;
+	}
+
+	if (rc) {
+		pr_err("Memory indexed-count-remove failed, adding any removed LMBs\n");
+
+		for (i = start_index; i < end_index; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			rc = dlpar_add_lmb(&lmbs[i]);
+			if (rc)
+				pr_err("Failed to add LMB, drc index %x\n",
+				       be32_to_cpu(lmbs[i].drc_index));
+
+			lmbs[i].reserved = 0;
+		}
+		rc = -EINVAL;
+	} else {
+		for (i = start_index; i < end_index; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			pr_info("Memory at %llx (drc index %x) was hot-removed\n",
+				lmbs[i].base_addr, lmbs[i].drc_index);
+
+			lmbs[i].reserved = 0;
+		}
+	}
+
+	return rc;
+}
+
 #else
 static inline int pseries_remove_memblock(unsigned long base,
 					  unsigned int memblock_size)
@@ -829,6 +915,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
 			drc_index = hp_elog->_drc_u.drc_index;
 			rc = dlpar_memory_remove_by_index(drc_index, prop);
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
+			count = hp_elog->_drc_u.indexed_count[0];
+			drc_index = hp_elog->_drc_u.indexed_count[1];
+			rc = dlpar_memory_remove_by_ic(count, drc_index, prop);
 		} else {
 			rc = -EINVAL;
 		}
