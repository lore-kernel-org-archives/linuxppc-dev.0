Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXYtl0nhdzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 08:59:42 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w11LsuiL022882
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Feb 2018 16:59:40 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fv9tmkfk0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 16:59:40 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 1 Feb 2018 16:59:39 -0500
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/hotplug/drcinfo: Fixes bug with hot-add of CPUs
Date: Thu, 1 Feb 2018 15:59:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <bd7f8d6d-3a60-9833-87f9-e7acccbf9354@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a bug matching drc-indexes of CPUs that are
being hot-added to a system either individually or by count.
This patch inserts a couple of missing checks and parsing code
for the new representation of device-tree information provided
by the property "ibm,drc-info".

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmwar
e feature" -- end of patch series applied to powerpc next)
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  117 +++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a7d14aa7..4cc6b70 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -413,19 +413,52 @@ static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
 	bool found = false;
 	int rc, index;
 
-	index = 0;
-	while (!found) {
-		u32 drc;
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
+		struct property *info = NULL;
+		struct of_drc_info drc;
+		int j;
+		u32 num_set_entries;
+		const __be32 *value;
+
+		info = of_find_property(parent, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto end_out;
+
+		value = of_prop_next_u32(info, NULL, &num_set_entries);
+		if (!value)
+			goto end_out;
+		value++;
+
+		for (j = 0; j < num_set_entries; j++) {
+
+			of_read_drc_info_cell(&info, &value, &drc);
+			if (strncmp(drc.drc_type, "CPU", 3))
+				goto end_out;
+
+			if ((drc.drc_index_start <= drc_index) &&
+				(drc_index <= drc.last_drc_index)) {
+				found = true;
+				break;
+			}
+		}
 
-		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
+	} else {
+		index = 0;
+		while (!found) {
+			u32 drc;
+
+			rc = of_property_read_u32_index(parent,
+						"ibm,drc-indexes",
 						index++, &drc);
-		if (rc)
-			break;
+			if (rc)
+				break;
 
-		if (drc == drc_index)
-			found = true;
+			if (drc == drc_index)
+				found = true;
+		}
 	}
 
+end_out:
 	return found;
 }
 
@@ -731,26 +764,68 @@ static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
 		return -1;
 	}
 
-	/* Search the ibm,drc-indexes array for possible CPU drcs to
-	 * add. Note that the format of the ibm,drc-indexes array is
-	 * the number of entries in the array followed by the array
-	 * of drc values so we start looking at index = 1.
+	/* Search the ibm,drc-indexes or ibm,drc-info array for
+	 * possible CPU drcs to add. Note that the format of the
+	 * ibm,drc-indexes array is the number of entries in the
+	 * array followed by the array of drc values so we start
+	 * looking at index = 1.  The ibm,drc-info array is a more
+	 * compact format for large numbers of CPUs, and the format
+	 * is correspondingly more complex.
 	 */
-	index = 1;
-	while (cpus_found < cpus_to_add) {
-		u32 drc;
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
+		struct property *info = NULL;
+		struct of_drc_info drc;
+		int j;
+		u32 num_set_entries;
+		const __be32 *value;
+
+		info = of_find_property(parent, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_out;
+
+		value = of_prop_next_u32(info, NULL, &num_set_entries);
+		if (!value)
+			goto err_out;
+		value++;
+
+		for (j = 0; j < num_set_entries; j++) {
+			int k;
+
+			of_read_drc_info_cell(&info, &value, &drc);
+			if (strncmp(drc.drc_type, "CPU", 3))
+				goto err_out;
+
+			for (k = 0; (k < drc.num_sequential_elems) &&
+					(cpus_found < cpus_to_add); k++) {
+				u32 idrc = drc.drc_index_start +
+					(k * drc.sequential_inc);
+
+				if (dlpar_cpu_exists(parent, idrc))
+					continue;
+
+				cpu_drcs[cpus_found++] = idrc;
+			}
+		}
+
+	} else {
+		index = 1;
+		while (cpus_found < cpus_to_add) {
+			u32 drc;
 
-		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
+			rc = of_property_read_u32_index(parent,
+						"ibm,drc-indexes",
 						index++, &drc);
-		if (rc)
-			break;
+			if (rc)
+				break;
 
-		if (dlpar_cpu_exists(parent, drc))
-			continue;
+			if (dlpar_cpu_exists(parent, drc))
+				continue;
 
-		cpu_drcs[cpus_found++] = drc;
+			cpu_drcs[cpus_found++] = drc;
+		}
 	}
 
+err_out:
 	of_node_put(parent);
 	return cpus_found;
 }
