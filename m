Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405yvD3k67zDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 05:27:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LIOtih045236
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:27:02 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gurdsvnng-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:27:01 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 14:27:00 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [RFC v2 3/4] powerpc/hotplug/drcinfo: Fix hot-add CPU issues
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9ed45428-fdad-a945-55df-3d47959204fb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 13:26:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <e5dca6d1-12df-d3b1-2f41-0e6011682cd8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch applies a common parse function for the ibm,drc-info
property that can be modified by a callback function to the
hot-add CPU code.  Candidate code is replaced by a call to the
parser including a pointer to a local context-specific functions,
and local data.

In addition, a bug in the release of the previous patch set may
break things in some of the CPU DLPAR operations.  For instance,
when attempting to hot-add a new CPU or set of CPUs, the original
patch failed to always properly calculate the available resources,
and aborted the operation.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmwar
e feature" -- end of patch series applied to powerpc next)
---
Changes in V2:
  -- Update code to account for v4.16 kernel checkins.
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |  129 +++++++++++++++++------
 arch/powerpc/platforms/pseries/pseries_energy.c |  112 ++++++++++----------
 2 files changed, 154 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 652d3e96..0811fb0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -411,25 +411,67 @@ static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
-static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
+static bool check_cpu_drc_index(struct device_node *parent,
+				int (*checkRun)(struct of_drc_info *drc,
+						void *data,
+						void *not_used,
+						int *ret_code),
+				void *cdata)
 {
-	bool found = false;
-	int rc, index;
+	int found = 0;
+
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
+		found = drc_info_parser(parent, checkRun, "CPU", cdata);
+	} else {
+		int rc, index = 0;
 
-	index = 0;
-	while (!found) {
-		u32 drc;
+		while (!found) {
+			u32 drc;
 
-		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
+			rc = of_property_read_u32_index(parent,
+						"ibm,drc-indexes",
 						index++, &drc);
-		if (rc)
-			break;
+			if (rc)
+				break;
+			found = checkRun(NULL, cdata, &drc, NULL);
+		}
+	}
 
-		if (drc == drc_index)
-			found = true;
+	return (bool)found;
+}
+
+struct valid_cpu_drc_index_struct {
+	u32 targ_drc_index;
+};
+
+static int valid_cpu_drc_index_checkRun(struct of_drc_info *drc,
+					void *idata,
+					void *drc_index,
+					int *ret_code)
+{
+	struct valid_cpu_drc_index_struct *cdata = idata;
+
+	if (drc) {
+		if ((drc->drc_index_start <= cdata->targ_drc_index) &&
+			(cdata->targ_drc_index <= drc->last_drc_index)) {
+			(*ret_code) = 1;
+			return 1;
+		}
+	} else {
+		if (*((u32*)drc_index) == cdata->targ_drc_index) {
+			(*ret_code) = 1;
+			return 1;
+		}
 	}
+	return 0;
+}
 
-	return found;
+static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
+{
+	struct valid_cpu_drc_index_struct cdata = { drc_index };
+
+	return check_cpu_drc_index(parent, valid_cpu_drc_index_checkRun,
+				&cdata);
 }
 
 static ssize_t dlpar_cpu_add(u32 drc_index)
@@ -721,11 +763,45 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	return rc;
 }
 
+struct find_dlpar_cpus_to_add_struct {
+	struct device_node *parent;
+	u32 *cpu_drcs;
+	u32 cpus_to_add;
+	u32 cpus_found;
+};
+
+static int find_dlpar_cpus_to_add_checkRun(struct of_drc_info *drc,
+					void *idata,
+					void *drc_index,
+					int *ret_code)
+{
+	struct find_dlpar_cpus_to_add_struct *cdata = idata;
+
+	if (drc) {
+		int k;
+
+		for (k = 0; (k < drc->num_sequential_elems) &&
+			(cdata->cpus_found < cdata->cpus_to_add); k++) {
+			u32 idrc = drc->drc_index_start +
+				(k * drc->sequential_inc);
+
+			if (dlpar_cpu_exists(cdata->parent, idrc))
+				continue;
+			cdata->cpu_drcs[cdata->cpus_found++] = idrc;
+		}
+	} else {
+		if (!dlpar_cpu_exists(cdata->parent, *((u32*)drc_index)))
+			cdata->cpu_drcs[cdata->cpus_found++] =
+				*((u32*)drc_index);
+	}
+	return 0;
+}
+
 static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
 {
 	struct device_node *parent;
-	int cpus_found = 0;
-	int index, rc;
+	struct find_dlpar_cpus_to_add_struct cdata = {
+		NULL, cpu_drcs, cpus_to_add, 0 };
 
 	parent = of_find_node_by_path("/cpus");
 	if (!parent) {
@@ -734,28 +810,15 @@ static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
 		return -1;
 	}
 
-	/* Search the ibm,drc-indexes array for possible CPU drcs to
-	 * add. Note that the format of the ibm,drc-indexes array is
-	 * the number of entries in the array followed by the array
-	 * of drc values so we start looking at index = 1.
+	/* Search the appropriate property for possible CPU drcs to
+	 * add.
 	 */
-	index = 1;
-	while (cpus_found < cpus_to_add) {
-		u32 drc;
-
-		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
-						index++, &drc);
-		if (rc)
-			break;
-
-		if (dlpar_cpu_exists(parent, drc))
-			continue;
-
-		cpu_drcs[cpus_found++] = drc;
-	}
+	cdata.parent = parent;
+	check_cpu_drc_index(parent, find_dlpar_cpus_to_add_checkRun,
+				&cdata);
 
 	of_node_put(parent);
-	return cpus_found;
+	return cdata.cpus_found;
 }
 
 static int dlpar_cpu_add_by_count(u32 cpus_to_add)
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index c7d84aa..332f3ce 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -36,6 +36,26 @@
 
 /* Helper Routines to convert between drc_index to cpu numbers */
 
+struct cpu_to_drc_index_struct {
+	u32	thread_index;
+	u32	ret;
+};
+
+static int cpu_to_drc_index_checkRun(struct of_drc_info *drc,
+				void *idata, void *not_used, int *ret_code)
+{
+        struct cpu_to_drc_index_struct *cdata = idata;
+
+	if (cdata->thread_index < drc->last_drc_index) {
+		cdata->ret = drc->drc_index_start +
+			(cdata->thread_index * drc->sequential_inc);
+		(*ret_code) = 1;
+		return 1;
+	}
+	(*ret_code) = 0;
+        return 0;
+}
+
 static u32 cpu_to_drc_index(int cpu)
 {
 	struct device_node *dn = NULL;
@@ -51,32 +71,16 @@ static u32 cpu_to_drc_index(int cpu)
 	thread_index = cpu_core_index_of_thread(cpu);
 
 	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
-		struct property *info = NULL;
-		struct of_drc_info drc;
-		int j;
-		u32 num_set_entries;
-		const __be32 *value;
-
-		info = of_find_property(dn, "ibm,drc-info", NULL);
-		if (info == NULL)
-			goto err_of_node_put;
+		struct cpu_to_drc_index_struct cdata = {
+			thread_index, 0 };
 
-		value = of_prop_next_u32(info, NULL, &num_set_entries);
-		if (!value)
-			goto err_of_node_put;
-		value++;
-
-		for (j = 0; j < num_set_entries; j++) {
+		rc = drc_info_parser(dn, &cpu_to_drc_index_checkRun,
+				"CPU", &cdata);
 
-			of_read_drc_info_cell(&info, &value, &drc);
-			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
-
-			if (thread_index < drc.last_drc_index)
-				break;
-		}
+		if (rc < 0)
+			goto err_of_node_put;
 
-		ret = drc.drc_index_start + (thread_index * drc.sequential_inc);
+		ret = cdata.ret;
 	} else {
 		const __be32 *indexes;
 
@@ -102,11 +106,36 @@ static u32 cpu_to_drc_index(int cpu)
 	return ret;
 }
 
+struct drc_index_to_cpu_struct {
+	u32	drc_index;
+	u32	thread_index;
+	u32	cpu;
+};
+
+static int drc_index_to_cpu_checkRun(struct of_drc_info *drc,
+				void *idata, void *not_used, int *ret_code)
+{
+        struct drc_index_to_cpu_struct *cdata = idata;
+
+	if (cdata->drc_index > drc->last_drc_index) {
+		cdata->cpu += drc->num_sequential_elems;
+		(*ret_code) = 0;
+		return 0;
+	} else {
+		cdata->cpu += ((cdata->drc_index - drc->drc_index_start) /
+				drc->sequential_inc);
+
+		cdata->thread_index = cpu_first_thread_of_core(cdata->cpu);
+		(*ret_code) = 0;
+		return 0;
+	}
+}
+
 static int drc_index_to_cpu(u32 drc_index)
 {
 	struct device_node *dn = NULL;
 	const int *indexes;
-	int thread_index = 0, cpu = 0;
+	int thread_index = 0;
 	int rc = 1;
 
 	dn = of_find_node_by_path("/cpus");
@@ -114,38 +143,13 @@ static int drc_index_to_cpu(u32 drc_index)
 		goto err;
 
 	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
-		struct property *info = NULL;
-		struct of_drc_info drc;
-		int j;
-		u32 num_set_entries;
-		const __be32 *value;
-
-		info = of_find_property(dn, "ibm,drc-info", NULL);
-		if (info == NULL)
-			goto err_of_node_put;
-
-		value = of_prop_next_u32(info, NULL, &num_set_entries);
-		if (!value)
-			goto err_of_node_put;
-		value++;
-
-		for (j = 0; j < num_set_entries; j++) {
+		struct drc_index_to_cpu_struct cdata = {
+			drc_index, 0, 0 };
 
-			of_read_drc_info_cell(&info, &value, &drc);
-			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
+		rc = drc_info_parser(dn, &drc_index_to_cpu_checkRun,
+					"CPU", &cdata);
+		thread_index = cdata.thread_index;
 
-			if (drc_index > drc.last_drc_index) {
-				cpu += drc.num_sequential_elems;
-				continue;
-			}
-			cpu += ((drc_index - drc.drc_index_start) /
-				drc.sequential_inc);
-
-			thread_index = cpu_first_thread_of_core(cpu);
-			rc = 0;
-			break;
-		}
 	} else {
 		unsigned long int i;
 
