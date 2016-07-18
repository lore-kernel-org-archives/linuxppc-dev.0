Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtRQg2HL3zDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 01:08:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6IEx1Yh124592
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:08:57 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24827eva9k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:08:57 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Mon, 18 Jul 2016 09:08:56 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C04F119D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 09:08:28 -0600 (MDT)
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6IF8l4R47972542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 15:08:52 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E254AC046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:08:52 -0400 (EDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 2C9FBAC041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:08:52 -0400 (EDT)
Subject: [PATCH v2 2/2] powerpc/pseries: Implemented indexed-count hotplug
 memory remove
To: linuxppc-dev@lists.ozlabs.org
References: <f3a63611-ae4d-be48-64d7-88a7ac7c1091@linux.vnet.ibm.com>
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
Date: Mon, 18 Jul 2016 10:08:51 -0500
MIME-Version: 1.0
In-Reply-To: <f3a63611-ae4d-be48-64d7-88a7ac7c1091@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <43770dca-871a-8f6c-6dbf-cdf842b6b442@linux.vnet.ibm.com>
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

 arch/powerpc/platforms/pseries/hotplug-memory.c |   84 +++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index d7942ca..244e1a8 100644
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
@@ -821,6 +901,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
 			drc_index = hp_elog->_drc_u.drc_index;
 			rc = dlpar_memory_remove_by_index(drc_index, prop);
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_IC) {
+			count = hp_elog->_drc_u.indexed_count[0];
+			drc_index = hp_elog->_drc_u.indexed_count[1];
+			rc = dlpar_memory_remove_by_ic(count, drc_index, prop);
 		} else
 			rc = -EINVAL;
 		break;

On 07/18/2016 10:04 AM, Sahil Mehta wrote:
> Indexed-count memory management allows addition and removal of contiguous
> lmb blocks with a single command. When compared to the series of calls
> previously required to manage contiguous blocks, indexed-count decreases
> command frequency and reduces risk of buffer overflow.
> 
> Changes in v2:
> --------------
> -[PATCH 1/2]:	-remove potential memory leak when parsing command
> 		-use u32s drc_index and count instead of u32 ic[]
> 		 in dlpar_memory
> -[PATCH 2/2]:	-use u32s drc_index and count instead of u32 ic[]
> 		 in dlpar_memory
> 
> -Sahil Mehta
> ---
>  include/asm/rtas.h                 |    2
>  platforms/pseries/dlpar.c          |   34 ++++++
>  platforms/pseries/hotplug-memory.c |  184 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 208 insertions(+), 12 deletions(-)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
