Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgTxg3Y2szDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 05:24:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UJOEFG058622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:24:21 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23w76nvw82-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:24:20 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 13:24:19 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B3B3C1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:23:56 -0600 (MDT)
Received: from b01ledav03.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UJOBuG57278522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 19:24:12 GMT
Received: from b01ledav03.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F4BB205D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:24:12 -0400 (EDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b01ledav03.gho.pok.ibm.com (Postfix) with ESMTP id 7BA51B2060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:24:12 -0400 (EDT)
Subject: [PATCH 2/2] powerpc/pseries: Implemented indexed-count hotplug memory
 remove
To: linuxppc-dev@lists.ozlabs.org
References: <19ab11fc-9771-1ad4-95d7-d26dd8f18184@linux.vnet.ibm.com>
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
Date: Thu, 30 Jun 2016 14:24:12 -0500
MIME-Version: 1.0
In-Reply-To: <19ab11fc-9771-1ad4-95d7-d26dd8f18184@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <71ca109d-052f-484e-29d5-763e836695f4@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/hotplug-memory.c |   85 +++++++++++++++++++++++
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index cf359bf..4d81810 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -503,6 +503,86 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 	return rc;
 }

+static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
+				     struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int i, rc;
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
+
+	/* Navigate to drc_index */
+	while (start_index < num_lmbs) {
+		if (lmbs[start_index].drc_index == drc_index)
+			break;
+
+		start_index++;
+	}
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
@@ -770,7 +850,6 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,

 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
 				lmbs[i].base_addr, lmbs[i].drc_index);
-			lmbs[i].reserved = 0;
 		}
 	}

@@ -820,6 +899,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
 			drc_index = hp_elog->_drc_u.drc_index;
 			rc = dlpar_memory_remove_by_index(drc_index, prop);
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_IC) {
+			ic[0] = hp_elog->_drc_u.indexed_count[0];
+			ic[1] = hp_elog->_drc_u.indexed_count[1];
+			rc = dlpar_memory_remove_by_ic(ic[0], ic[1], prop);
 		} else
 			rc = -EINVAL;
 		break;
