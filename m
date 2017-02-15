Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNpQZ6Vy4zDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:55:50 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FIrad9080964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:49 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9xqefm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:48 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 13:55:47 -0500
Subject: [PATCH v7 3/4] powerpc/pseries: Implement indexed-count hotplug
 memory add
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, sahilmehta17@gmail.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Date: Wed, 15 Feb 2017 13:45:56 -0500
In-Reply-To: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170215184536.11755.63813.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sahil Mehta <sahilmehta17@gmail.com>

Indexed-count add for memory hotplug guarantees that a contiguous block
of <count> lmbs beginning at a specified <drc index> will be assigned,
any LMBs in this range that are not already assigned will be DLPAR added.
Because of Qemu's per-DIMM memory management, the addition of a contiguous
block of memory currently requires a series of individual calls to add
each LMB in the block. Indexed-count add reduces this series of calls to
a single call for the entire block.

Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Updates from v6: Re-based to latest kernel

 arch/powerpc/include/asm/rtas.h                 |    2 
 arch/powerpc/platforms/pseries/dlpar.c          |   38 +++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |  118 +++++++++++++++++++++--
 3 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 076b892..ec9dd79 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -307,6 +307,7 @@ struct pseries_hp_errorlog {
 	union {
 		__be32	drc_index;
 		__be32	drc_count;
+		struct { __be32 count, index; } ic;
 		char	drc_name[1];
 	} _drc_u;
 };
@@ -323,6 +324,7 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_ID_DRC_NAME	1
 #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
 #define PSERIES_HP_ELOG_ID_DRC_COUNT	3
+#define PSERIES_HP_ELOG_ID_DRC_IC	4
 
 struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 					      uint16_t section_id);
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index d3a81e7..193e052 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -354,11 +354,17 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	switch (hp_elog->id_type) {
 	case PSERIES_HP_ELOG_ID_DRC_COUNT:
 		hp_elog->_drc_u.drc_count =
-					be32_to_cpu(hp_elog->_drc_u.drc_count);
+				be32_to_cpu(hp_elog->_drc_u.drc_count);
 		break;
 	case PSERIES_HP_ELOG_ID_DRC_INDEX:
 		hp_elog->_drc_u.drc_index =
-					be32_to_cpu(hp_elog->_drc_u.drc_index);
+				be32_to_cpu(hp_elog->_drc_u.drc_index);
+		break;
+	case PSERIES_HP_ELOG_ID_DRC_IC:
+		hp_elog->_drc_u.ic.count =
+				be32_to_cpu(hp_elog->_drc_u.ic.count);
+		hp_elog->_drc_u.ic.index =
+				be32_to_cpu(hp_elog->_drc_u.ic.index);
 	}
 
 	switch (hp_elog->resource) {
@@ -467,7 +473,33 @@ static int dlpar_parse_id_type(char **cmd, struct pseries_hp_errorlog *hp_elog)
 	if (!arg)
 		return -EINVAL;
 
-	if (sysfs_streq(arg, "index")) {
+	if (sysfs_streq(arg, "indexed-count")) {
+		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_IC;
+		arg = strsep(cmd, " ");
+		if (!arg) {
+			pr_err("No DRC count specified.\n");
+			return -EINVAL;
+		}
+
+		if (kstrtou32(arg, 0, &count)) {
+			pr_err("Invalid DRC count specified.\n");
+			return -EINVAL;
+		}
+
+		arg = strsep(cmd, " ");
+		if (!arg) {
+			pr_err("No DRC Index specified.\n");
+			return -EINVAL;
+		}
+
+		if (kstrtou32(arg, 0, &index)) {
+			pr_err("Invalid DRC Index specified.\n");
+			return -EINVAL;
+		}
+
+		hp_elog->_drc_u.ic.count = cpu_to_be32(count);
+		hp_elog->_drc_u.ic.index = cpu_to_be32(index);
+	} else if (sysfs_streq(arg, "index")) {
 		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
 		arg = strsep(cmd, " ");
 		if (!arg) {
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9609a72..0d1aa77 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -803,6 +803,97 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
 	return rc;
 }
 
+static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
+				  struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int i, rc, start_lmb_found;
+	int lmbs_available = 0, start_index = 0, end_index;
+
+	pr_info("Attempting to hot-add %u LMB(s) at index %x\n",
+		lmbs_to_add, drc_index);
+
+	if (lmbs_to_add == 0)
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
+	end_index = start_index + lmbs_to_add;
+
+	/* Validate that the LMBs in this range are not reserved */
+	for (i = start_index; i < end_index; i++) {
+		if (lmbs[i].flags & DRCONF_MEM_RESERVED)
+			break;
+
+		lmbs_available++;
+	}
+
+	if (lmbs_available < lmbs_to_add)
+		return -EINVAL;
+
+	for (i = start_index; i < end_index; i++) {
+		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+			continue;
+
+		rc = dlpar_acquire_drc(lmbs[i].drc_index);
+		if (rc)
+			break;
+
+		rc = dlpar_add_lmb(&lmbs[i]);
+		if (rc) {
+			dlpar_release_drc(lmbs[i].drc_index);
+			break;
+		}
+
+		lmbs[i].reserved = 1;
+	}
+
+	if (rc) {
+		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
+
+		for (i = start_index; i < end_index; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			rc = dlpar_remove_lmb(&lmbs[i]);
+			if (rc)
+				pr_err("Failed to remove LMB, drc index %x\n",
+				       be32_to_cpu(lmbs[i].drc_index));
+			else
+				dlpar_release_drc(lmbs[i].drc_index);
+		}
+		rc = -EINVAL;
+	} else {
+		for (i = start_index; i < end_index; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			pr_info("Memory at %llx (drc index %x) was hot-added\n",
+				lmbs[i].base_addr, lmbs[i].drc_index);
+			lmbs[i].reserved = 0;
+		}
+	}
+
+	return rc;
+}
+
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	struct device_node *dn;
@@ -810,9 +901,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	u32 count, drc_index;
 	int rc;
 
-	count = hp_elog->_drc_u.drc_count;
-	drc_index = hp_elog->_drc_u.drc_index;
-
 	lock_device_hotplug();
 
 	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
@@ -829,20 +917,32 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 
 	switch (hp_elog->action) {
 	case PSERIES_HP_ELOG_ACTION_ADD:
-		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
+			count = hp_elog->_drc_u.drc_count;
 			rc = dlpar_memory_add_by_count(count, prop);
-		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
+			drc_index = hp_elog->_drc_u.drc_index;
 			rc = dlpar_memory_add_by_index(drc_index, prop);
-		else
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
+			count = hp_elog->_drc_u.ic.count;
+			drc_index = hp_elog->_drc_u.ic.index;
+			rc = dlpar_memory_add_by_ic(count, drc_index, prop);
+		} else {
 			rc = -EINVAL;
+		}
+
 		break;
 	case PSERIES_HP_ELOG_ACTION_REMOVE:
-		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
+			count = hp_elog->_drc_u.drc_count;
 			rc = dlpar_memory_remove_by_count(count, prop);
-		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
+			drc_index = hp_elog->_drc_u.drc_index;
 			rc = dlpar_memory_remove_by_index(drc_index, prop);
-		else
+		} else {
 			rc = -EINVAL;
+		}
+
 		break;
 	case PSERIES_HP_ELOG_ACTION_READD:
 		rc = dlpar_memory_readd_by_index(drc_index, prop);
