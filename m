Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXtls40ylzDsNk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:38:17 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8CGY9CO103974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 12:38:15 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ceq9b233-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 12:38:15 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Sep 2016 12:38:13 -0400
Subject: [PATCH v5 1/2] powerpc/pseries: Implement indexed-count hotplug
 memory add
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: sahilmehta17@gmail.com
Date: Mon, 12 Sep 2016 12:31:00 -0400
In-Reply-To: <20160912163009.56321.70346.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20160912163009.56321.70346.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160912163054.56321.27548.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
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
of <count> lmbs beginning at a specified <index> will be assigned (NOT
that <count> lmbs will be added). Because of Qemu's per-DIMM memory
management, the addition of a contiguous block of memory currently
requires a series of individual calls. Indexed-count add reduces
this series into a single call.

Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
v2:	-remove potential memory leak when parsing command
	-use u32s drc_index and count instead of u32 ic[]
	 in dlpar_memory
v3:	-add logic to handle invalid drc_index input
	-update indexed-count trigger to follow naming convention
	-update dlpar_memory to follow kernel if-else style
v4: 	-add logic to handle kstrdup failure
	-add logic to handle invalid command format
v5:     -none

 arch/powerpc/include/asm/rtas.h                 |    2 
 arch/powerpc/platforms/pseries/dlpar.c          |   46 +++++++++-
 arch/powerpc/platforms/pseries/hotplug-memory.c |  110 +++++++++++++++++++++--
 3 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 9c23baa..5d65de7 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -307,6 +307,7 @@ struct pseries_hp_errorlog {
 	union {
 		__be32	drc_index;
 		__be32	drc_count;
+		__be32	indexed_count[2];
 		char	drc_name[1];
 	} _drc_u;
 };
@@ -322,6 +323,7 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_ID_DRC_NAME	1
 #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
 #define PSERIES_HP_ELOG_ID_DRC_COUNT	3
+#define PSERIES_HP_ELOG_ID_DRC_IC	4
 
 struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 					      uint16_t section_id);
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 4748124..ad9c770 100644
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
+		hp_elog->_drc_u.indexed_count[0] =
+				be32_to_cpu(hp_elog->_drc_u.indexed_count[0]);
+		hp_elog->_drc_u.indexed_count[1] =
+				be32_to_cpu(hp_elog->_drc_u.indexed_count[1]);
 	}
 
 	switch (hp_elog->resource) {
@@ -459,7 +465,41 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 		goto dlpar_store_out;
 	}
 
-	if (!strncmp(arg, "index", 5)) {
+	if (!strncmp(arg, "indexed-count", 13)) {
+		u32 index, count;
+		char *cstr, *istr;
+
+		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_IC;
+		arg += strlen("indexed-count ");
+
+		cstr = kstrdup(arg, GFP_KERNEL);
+		if (!cstr) {
+			rc = -EINVAL;
+			pr_err("kstrudup failed before parse : \"%s\"\n", buf);
+			goto dlpar_store_out;
+		}
+
+		istr = strchr(cstr, ' ');
+		if (!istr) {
+			rc = -EINVAL;
+			pr_err("Invalid indexed-count command : \"%s\"\n", buf);
+			goto dlpar_store_out;
+		}
+
+		*istr++ = '\0';
+
+		if (kstrtou32(cstr, 0, &count) || kstrtou32(istr, 0, &index)) {
+			rc = -EINVAL;
+			pr_err("Invalid index or count : \"%s\"\n", buf);
+			kfree(cstr);
+			goto dlpar_store_out;
+		}
+
+		kfree(cstr);
+
+		hp_elog->_drc_u.indexed_count[0] = cpu_to_be32(count);
+		hp_elog->_drc_u.indexed_count[1] = cpu_to_be32(index);
+	} else if (!strncmp(arg, "index", 5)) {
 		u32 index;
 
 		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 76ec104..badc66d 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -725,6 +725,89 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
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
+	/* Validate that there are enough LMBs to satisfy the request */
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
+		rc = dlpar_add_lmb(&lmbs[i]);
+		if (rc)
+			break;
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
@@ -732,9 +815,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	u32 count, drc_index;
 	int rc;
 
-	count = hp_elog->_drc_u.drc_count;
-	drc_index = hp_elog->_drc_u.drc_index;
-
 	lock_device_hotplug();
 
 	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
@@ -751,20 +831,32 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 
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
+			count = hp_elog->_drc_u.indexed_count[0];
+			drc_index = hp_elog->_drc_u.indexed_count[1];
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
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
