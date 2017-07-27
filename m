Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJH4c51qLzDrKR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:10:08 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RG8SsE018491
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:10:06 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byk5cgwyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:10:06 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 10:10:05 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 2/4] pseries/drc-info: Search DRC properties for CPU indexes
In-Reply-To: <e884f428-c76d-112a-aa2f-f57a94de55fb@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 11:10:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <67551d00-5e79-8839-2040-81949f71ef3a@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/prom.h                 |    7 +
 arch/powerpc/platforms/pseries/of_helpers.c     |   79 ++++++++++++
 arch/powerpc/platforms/pseries/pseries_energy.c |  150 +++++++++++++++++++----
 3 files changed, 210 insertions(+), 26 deletions(-)
---
Changes in V2:
  -- Minor changes to integrate to latest 4.13 code

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 4fb02cc..d469d7c 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -96,6 +96,13 @@ struct of_drconf_cell {
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
 
+extern int of_one_drc_info(struct property **prop, void **curval,
+			char **dtype, char **dname,
+			u32 *drc_index_start_p,
+			u32 *num_sequential_elems_p,
+			u32 *sequential_inc_p,
+			u32 *last_drc_index_p);
+
 /*
  * There are two methods for telling firmware what our capabilities are.
  * Newer machines have an "ibm,client-architecture-support" method on the
diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 2798933..1d59939 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -36,3 +36,82 @@ struct device_node *pseries_of_derive_parent(const char *path)
 		kfree(parent_path);
 	return parent ? parent : ERR_PTR(-EINVAL);
 }
+
+
+/* Helper Routines to convert between drc_index to cpu numbers */
+
+int of_one_drc_info(struct property **prop, void **curval,
+			char **dtype, char **dname,
+			u32 *drc_index_start_p,
+			u32 *num_sequential_elems_p,
+			u32 *sequential_inc_p,
+			u32 *last_drc_index_p)
+{
+	char *drc_type, *drc_name_prefix;
+	u32 drc_index_start, num_sequential_elems, dummy;
+	u32 sequential_inc, last_drc_index;
+	const char *p;
+	const __be32 *p2;
+
+	drc_index_start = num_sequential_elems = 0;
+	sequential_inc = last_drc_index = 0;
+
+	/* Get drc-type:encode-string */
+	p = drc_type = (*curval);
+	p = of_prop_next_string(*prop, p);
+	if (!p)
+		return -EINVAL;
+
+	/* Get drc-name-prefix:encode-string */
+	drc_name_prefix = (char *)p;
+	p = of_prop_next_string(*prop, p);
+	if (!p)
+		return -EINVAL;
+
+	/* Get drc-index-start:encode-int */
+	p2 = (const __be32 *)p;
+	p2 = of_prop_next_u32(*prop, p2, &drc_index_start);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get/skip drc-name-suffix-start:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &dummy);
+	if (!p)
+		return -EINVAL;
+
+	/* Get number-sequential-elements:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &num_sequential_elems);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get sequential-increment:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &sequential_inc);
+	if (!p2)
+		return -EINVAL;
+
+	/* Get/skip drc-power-domain:encode-int */
+	p2 = of_prop_next_u32(*prop, p2, &dummy);
+	if (!p2)
+		return -EINVAL;
+
+	/* Should now know end of current entry */
+	(*curval) = (void *)p2;
+	last_drc_index = drc_index_start +
+			((num_sequential_elems-1)*sequential_inc);
+
+	if (dtype)
+		*dtype = drc_type;
+	if (dname)
+		*dname = drc_name_prefix;
+	if (drc_index_start_p)
+		*drc_index_start_p = drc_index_start;
+	if (num_sequential_elems_p)
+		*num_sequential_elems_p = num_sequential_elems;
+	if (sequential_inc_p)
+		*sequential_inc_p = sequential_inc;
+	if (last_drc_index_p)
+		*last_drc_index_p = last_drc_index;
+
+	return 0;
+}
+EXPORT_SYMBOL(of_one_drc_info);
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 164a13d..865c2af 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -22,6 +22,7 @@
 #include <asm/page.h>
 #include <asm/hvcall.h>
 #include <asm/firmware.h>
+#include <asm/prom.h>
 
 
 #define MODULE_VERS "1.0"
@@ -38,7 +39,6 @@
 static u32 cpu_to_drc_index(int cpu)
 {
 	struct device_node *dn = NULL;
-	const int *indexes;
 	int i;
 	int rc = 1;
 	u32 ret = 0;
@@ -46,18 +46,65 @@ static u32 cpu_to_drc_index(int cpu)
 	dn = of_find_node_by_path("/cpus");
 	if (dn == NULL)
 		goto err;
-	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-	if (indexes == NULL)
-		goto err_of_node_put;
+
 	/* Convert logical cpu number to core number */
 	i = cpu_core_index_of_thread(cpu);
-	/*
-	 * The first element indexes[0] is the number of drc_indexes
-	 * returned in the list.  Hence i+1 will get the drc_index
-	 * corresponding to core number i.
-	 */
-	WARN_ON(i > indexes[0]);
-	ret = indexes[i + 1];
+
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
+		struct property *info = NULL;
+		int j, check_val = i;
+		u32 num_set_entries;
+		u32 drc_index_start = 0;
+		u32 last_drc_index = 0;
+		u32 num_sequential_elems = 0;
+		u32 sequential_inc = 0;
+		char *dtype;
+		char *dname;
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
+			of_one_drc_info(&info, &value, &dtype, &dname,
+					&drc_index_start,
+					&num_sequential_elems,
+					&sequential_inc, &last_drc_index);
+			if (strcmp(dtype, "CPU"))
+				goto err;
+
+			if (check_val < last_drc_index)
+				break;
+
+			WARN_ON(((check_val-drc_index_start)%
+					sequential_inc) != 0);
+		}
+		WARN_ON((num_sequential_elems == 0) || (sequential_inc == 0));
+
+		ret = last_drc_index + (check_val*sequential_inc);
+	} else {
+		const __be32 *indexes;
+
+		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+		if (indexes == NULL)
+			goto err_of_node_put;
+
+		/*
+		 * The first element indexes[0] is the number of drc_indexes
+		 * returned in the list.  Hence i+1 will get the drc_index
+		 * corresponding to core number i.
+		 */
+		WARN_ON(i > indexes[0]);
+		ret = indexes[i + 1];
+	}
+
 	rc = 0;
 
 err_of_node_put:
@@ -72,34 +119,85 @@ static int drc_index_to_cpu(u32 drc_index)
 {
 	struct device_node *dn = NULL;
 	const int *indexes;
-	int i, cpu = 0;
+	int thread = 0, cpu = 0;
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
+		int j;
+		u32 num_set_entries;
+		u32 drc_index_start = 0;
+		u32 last_drc_index = 0;
+		u32 num_sequential_elems = 0;
+		u32 sequential_inc = 0;
+		char *dtype, *dname;
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
+			of_one_drc_info(&info, &value, &dtype, &dname,
+					&drc_index_start,
+					&num_sequential_elems,
+					&sequential_inc, &last_drc_index);
+			if (strcmp(dtype, "CPU"))
+				goto err;
+
+			WARN_ON(drc_index < drc_index_start);
+			WARN_ON(((drc_index-drc_index_start)%
+					sequential_inc) != 0);
+
+			if (drc_index > last_drc_index) {
+				cpu += ((last_drc_index-drc_index_start)/
+					sequential_inc);
+				continue;
+			} else {
+				cpu += ((drc_index-drc_index_start)/
+					sequential_inc);
+			}
+
+			thread = cpu_first_thread_of_core(cpu);
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
+		thread = cpu_first_thread_of_core(i);
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
+	return thread;
 }
 
 /*
