Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsJLP4w8xzDrJd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 07:47:41 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8CLkHQi098708
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:47:39 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cxhmt2rg8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:47:38 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 12 Sep 2017 15:47:38 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Subject: [PATCH V3 2/4] pseries/drc-info: Search DRC properties for
 CPU indexes
In-Reply-To: <531bfd59-97ed-0ea9-0a93-dea7eb415b77@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2017 16:47:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9e435774-3ccf-83c3-70a1-5a6c6abbb024@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/drc-info: Provide parallel routines to convert between
drc_index and CPU numbers at runtime, using the older device-tree
properties ("ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
and "ibm,drc-power-domains"), or the new property "ibm,drc-info".

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V3:
  -- Some code compression and use of data structures for value passing.
---
 arch/powerpc/include/asm/prom.h                 |   15 ++
 arch/powerpc/platforms/pseries/of_helpers.c     |   60 ++++++++++
 arch/powerpc/platforms/pseries/pseries_energy.c |  139 ++++++++++++++++++-----
 3 files changed, 186 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 4fb02cc..967ce20 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -96,6 +96,21 @@ struct of_drconf_cell {
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
 
+struct of_drc_info {
+	char *drc_type;
+	char *drc_name_prefix;
+	u32 drc_index_start;
+	u32 drc_name_suffix_start;
+	u32 num_sequential_elems;
+	u32 sequential_inc;
+	u32 drc_power_domain;
+	u32 last_drc_index;
+};
+
+extern int of_one_drc_info(struct property **prop, void **curval,
+			struct of_drc_info *data);
+
+
 /*
  * There are two methods for telling firmware what our capabilities are.
  * Newer machines have an "ibm,client-architecture-support" method on the
diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 2798933..62dc8e9 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -2,6 +2,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
 #include <linux/of.h>
+#include <asm/prom.h>
 
 #include "of_helpers.h"
 
@@ -36,3 +37,62 @@ struct device_node *pseries_of_derive_parent(const char *path)
 		kfree(parent_path);
 	return parent ? parent : ERR_PTR(-EINVAL);
 }
+
+
+/* Helper Routines to convert between drc_index to cpu numbers */
+
+int of_one_drc_info(struct property **prop, void **curval,
+			struct of_drc_info *data)
+{
+	const char *p;
+	const __be32 *p2;
+
+	if (!data)
+		return -EINVAL;
+
+	/* Get drc-type:encode-string */
+	p = data->drc_type = (*curval);
+	p = of_prop_next_string(*prop, p);
+	if (!p)
+		return -EINVAL;
+
+	/* Get drc-name-prefix:encode-string */
+	data->drc_name_prefix = (char *)p;
+	p = of_prop_next_string(*prop, p);
+	if (!p)
+		return -EINVAL;
+
+	/* Get drc-index-start:encode-int */
+	p2 = (const __be32 *)p;
+	p2 = of_prop_next_u32(*prop, p2, &data->drc_index_start);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get/skip drc-name-suffix-start:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &data->drc_name_suffix_start);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get number-sequential-elements:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &data->num_sequential_elems);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get sequential-increment:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &data->sequential_inc);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get/skip drc-power-domain:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &data->drc_power_domain);
+	if (!p2)
+		return -EINVAL;
+
+	/* Should now know end of current entry */
+	(*curval) = (void *)p2;
+	data->last_drc_index = data->drc_index_start +
+		((data->num_sequential_elems-1)*data->sequential_inc);
+
+	return 0;
+}
+EXPORT_SYMBOL(of_one_drc_info);
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 164a13d..b233904 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -22,6 +22,7 @@
 #include <asm/page.h>
 #include <asm/hvcall.h>
 #include <asm/firmware.h>
+#include <asm/prom.h>
 
-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
 
 #define MODULE_VERS "1.0"
@@ -38,26 +39,65 @@
 static u32 cpu_to_drc_index(int cpu)
 {
 	struct device_node *dn = NULL;
-	const int *indexes;
-	int i;
+	int thread_index;
 	int rc = 1;
 	u32 ret = 0;
 
 	dn = of_find_node_by_path("/cpus");
 	if (dn == NULL)
 		goto err;
-	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-	if (indexes == NULL)
-		goto err_of_node_put;
+
 	/* Convert logical cpu number to core number */
-	i = cpu_core_index_of_thread(cpu);
-	/*
-	 * The first element indexes[0] is the number of drc_indexes
-	 * returned in the list.  Hence i+1 will get the drc_index
-	 * corresponding to core number i.
-	 */
-	WARN_ON(i > indexes[0]);
-	ret = indexes[i + 1];
+	thread_index = cpu_core_index_of_thread(cpu);
+
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
+		struct property *info = NULL;
+		struct of_drc_info drc;
+		int j;
+		u32 num_set_entries;
+		void *value;
+
+		info = of_find_property(dn, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_of_node_put;
+
+		value = info->value;
+		value = (void *)of_prop_next_u32(info, value, &num_set_entries);
+		if (!value)
+			goto err_of_node_put;
+
+		for (j = 0; j < num_set_entries; j++) {
+
+			of_one_drc_info(&info, &value, &drc);
+			if (strncmp(drc.drc_type, "CPU", 3))
+				goto err;
+
+			if (thread_index < drc.last_drc_index)
+				break;
+
+			WARN_ON(((thread_index-drc.drc_index_start)%
+					drc.sequential_inc) != 0);
+		}
+		WARN_ON((drc.num_sequential_elems == 0) ||
+			(drc.sequential_inc == 0));
+
+		ret = drc.drc_index_start + (thread_index*drc.sequential_inc);
+	} else {
+		const __be32 *indexes;
+
+		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+		if (indexes == NULL)
+			goto err_of_node_put;
+
+		/*
+		 * The first element indexes[0] is the number of drc_indexes
+		 * returned in the list.  Hence thread_index+1 will get the
+		 * drc_index corresponding to core number thread_index.
+		 */
+		WARN_ON(thread_index > indexes[0]);
+		ret = indexes[thread_index + 1];
+	}
+
 	rc = 0;
 
 err_of_node_put:
@@ -72,34 +112,77 @@ static int drc_index_to_cpu(u32 drc_index)
 {
 	struct device_node *dn = NULL;
 	const int *indexes;
-	int i, cpu = 0;
+	int thread_index = 0, cpu = 0;
 	int rc = 1;
 
 	dn = of_find_node_by_path("/cpus");
 	if (dn == NULL)
 		goto err;
-	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-	if (indexes == NULL)
-		goto err_of_node_put;
-	/*
-	 * First element in the array is the number of drc_indexes
-	 * returned.  Search through the list to find the matching
-	 * drc_index and get the core number
-	 */
-	for (i = 0; i < indexes[0]; i++) {
-		if (indexes[i + 1] == drc_index)
+
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
+		struct property *info = NULL;
+		struct of_drc_info drc;
+		int j;
+		u32 num_set_entries;
+		void *value;
+
+		info = of_find_property(dn, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_of_node_put;
+
+		value = info->value;
+		value = (void *)of_prop_next_u32(info, value, &num_set_entries);
+		if (!value)
+			goto err_of_node_put;
+
+		for (j = 0; j < num_set_entries; j++) {
+
+			of_one_drc_info(&info, &value, &drc);
+			if (strncmp(drc.drc_type, "CPU", 3))
+				goto err;
+
+			WARN_ON(drc_index < drc.drc_index_start);
+			WARN_ON(((drc_index-drc.drc_index_start)%
+					drc.sequential_inc) != 0);
+
+			if (drc_index > drc.last_drc_index) {
+				cpu += drc.num_sequential_elems;
+				continue;
+			} else {
+				cpu += ((drc_index-drc.drc_index_start)/
+					drc.sequential_inc);
+			}
+
+			thread_index = cpu_first_thread_of_core(cpu);
+			rc = 0;
 			break;
+		}
+	} else {
+		unsigned long int i;
+
+		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+		if (indexes == NULL)
+			goto err_of_node_put;
+		/*
+		 * First element in the array is the number of drc_indexes
+		 * returned.  Search through the list to find the matching
+		 * drc_index and get the core number
+		 */
+		for (i = 0; i < indexes[0]; i++) {
+			if (indexes[i + 1] == drc_index)
+				break;
+		}
+		/* Convert core number to logical cpu number */
+		thread_index = cpu_first_thread_of_core(i);
+		rc = 0;
 	}
-	/* Convert core number to logical cpu number */
-	cpu = cpu_first_thread_of_core(i);
-	rc = 0;
 
 err_of_node_put:
 	of_node_put(dn);
 err:
 	if (rc)
 		printk(KERN_WARNING "drc_index_to_cpu(%d) failed", drc_index);
-	return cpu;
+	return thread_index;
 }
 
 /*
