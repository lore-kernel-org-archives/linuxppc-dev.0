Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNpR13XnSzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:56:13 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FIrhma003864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:56:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mstf0741-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:56:10 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 13:56:10 -0500
Subject: [PATCH v7 4/4] powerpc/pseries: Implement indexed-count hotplug
 memory remove
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, sahilmehta17@gmail.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Date: Wed, 15 Feb 2017 13:46:18 -0500
In-Reply-To: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170215184601.11755.30823.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sahil Mehta <sahilmehta17@gmail.com>

Indexed-count remove for memory hotplug guarantees that a contiguous block
of <count> lmbs beginning at a specified <index> will be unassigned (NOT
that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
management, the removal of a contiguous block of memory currently
requires a series of individual calls. Indexed-count remove reduces
this series into a single call.

Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Updates for v7: Re-based to latest kernel

 arch/powerpc/platforms/pseries/hotplug-memory.c |   98 +++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 0d1aa77..efef10a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -601,6 +601,94 @@ static int dlpar_memory_readd_by_index(u32 drc_index, struct property *prop)
 
 	return rc;
 }
+
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
+	for (i = start_index; i < end_index; i++) {
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
+			dlpar_release_drc(lmbs[i].drc_index);
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
@@ -634,6 +722,12 @@ static int dlpar_memory_readd_by_index(u32 drc_index, struct property *prop)
 	return -EOPNOTSUPP;
 }
 
+static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
+				     struct property *prop)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static int dlpar_online_lmb(struct of_drconf_cell *lmb)
@@ -939,6 +1033,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
 			drc_index = hp_elog->_drc_u.drc_index;
 			rc = dlpar_memory_remove_by_index(drc_index, prop);
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
+			count = hp_elog->_drc_u.ic.count;
+			drc_index = hp_elog->_drc_u.ic.index;
+			rc = dlpar_memory_remove_by_ic(count, drc_index, prop);
 		} else {
 			rc = -EINVAL;
 		}
