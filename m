Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYVBg4FfczDw2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 18:15:23 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB77DcMh146701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 02:15:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 276dpegdh1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 02:15:21 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 7 Dec 2016 00:15:19 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7EB3E19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:14:36 -0700 (MST)
Subject: [PATCH V9 5/8] pseries/drc-info: Search new DRC properties for CPU
 indexes
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Date: Wed, 07 Dec 2016 01:15:15 -0600
In-Reply-To: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148109490324.193207.10527500975481096079.stgit@powerkvm6.aus.stglabs.ibm.com>
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
Changes in V9:
  -- Correct cpu-to-thread calculation for drc-info structs in function
     drc_index_to_cpu
  -- Change OR operators in WARN_ON test
---
 arch/powerpc/platforms/pseries/pseries_energy.c |  202 ++++++++++++++++++++---
 1 file changed, 176 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 164a13d..549efdb 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -35,10 +35,73 @@
 
 /* Helper Routines to convert between drc_index to cpu numbers */
 
+void read_one_drc_info(int **info, char **dtype, char **dname,
+			unsigned long int *drc_index_start_p,
+			unsigned long int *num_sequential_elems_p,
+			unsigned long int *sequential_inc_p,
+			unsigned long int *last_drc_index_p)
+{
+	char *drc_type, *drc_name_prefix, *pc;
+	u32 drc_index_start, num_sequential_elems;
+	u32 sequential_inc, last_drc_index;
+
+	drc_index_start = num_sequential_elems = 0;
+	sequential_inc = last_drc_index = 0;
+
+	/* Get drc-type:encode-string */
+	pc = (char *)info;
+	drc_type = pc;
+	pc += (strlen(drc_type) + 1);
+
+	/* Get drc-name-prefix:encode-string */
+	drc_name_prefix = (char *)pc;
+	pc += (strlen(drc_name_prefix) + 1);
+
+	/* Get drc-index-start:encode-int */
+	memcpy(&drc_index_start, pc, 4);
+	drc_index_start = be32_to_cpu(drc_index_start);
+	pc += 4;
+
+	/* Get/skip drc-name-suffix-start:encode-int */
+	pc += 4;
+
+	/* Get number-sequential-elements:encode-int */
+	memcpy(&num_sequential_elems, pc, 4);
+	num_sequential_elems = be32_to_cpu(num_sequential_elems);
+	pc += 4;
+
+	/* Get sequential-increment:encode-int */
+	memcpy(&sequential_inc, pc, 4);
+	sequential_inc = be32_to_cpu(sequential_inc);
+	pc += 4;
+
+	/* Get/skip drc-power-domain:encode-int */
+	pc += 4;
+
+	/* Should now know end of current entry */
+	last_drc_index = drc_index_start +
+			((num_sequential_elems-1)*sequential_inc);
+
+	(*info) = (int *)pc;
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
+}
+EXPORT_SYMBOL(read_one_drc_info);
+
 static u32 cpu_to_drc_index(int cpu)
 {
 	struct device_node *dn = NULL;
-	const int *indexes;
 	int i;
 	int rc = 1;
 	u32 ret = 0;
@@ -46,18 +109,60 @@ static u32 cpu_to_drc_index(int cpu)
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
+		int *info = (int *)4;
+		unsigned long int num_set_entries, j, check_val = i;
+		unsigned long int drc_index_start = 0;
+		unsigned long int last_drc_index = 0;
+		unsigned long int num_sequential_elems = 0;
+		unsigned long int sequential_inc = 0;
+		char *dtype;
+		char *dname;
+
+		info = (int *)of_get_property(dn, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_of_node_put;
+
+		num_set_entries = be32_to_cpu(*info++);
+
+		for (j = 0; j < num_set_entries; j++) {
+
+			read_one_drc_info(&info, &dtype, &dname,
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
+		const int *indexes;
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
@@ -72,34 +177,79 @@ static int drc_index_to_cpu(u32 drc_index)
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
+		int *info = (int *)dn;
+		unsigned long int num_set_entries, j;
+		unsigned long int drc_index_start = 0;
+		unsigned long int last_drc_index = 0;
+		unsigned long int num_sequential_elems = 0;
+		unsigned long int sequential_inc = 0;
+		char *dtype, *dname;
+
+		info = (int *)of_get_property(dn, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_of_node_put;
+
+		num_set_entries = be32_to_cpu(*info++);
+
+		for (j = 0; j < num_set_entries; j++) {
+			read_one_drc_info(&info, &dtype, &dname,
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
