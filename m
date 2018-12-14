Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ADC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 21:01:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FEE2086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 21:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FEE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GjdV0DtRzDrC8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 08:01:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GjQ25MgCzDrPN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 07:51:22 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBEKmvgp145655
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 15:51:21 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pcj6u41sy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 15:51:20 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 14 Dec 2018 20:51:20 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Dec 2018 20:51:16 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBEKpFmP24051918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 20:51:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBE776E04C;
 Fri, 14 Dec 2018 20:51:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6CA16E053;
 Fri, 14 Dec 2018 20:51:15 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 14 Dec 2018 20:51:15 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 4A89E40E516A;
 Fri, 14 Dec 2018 14:51:15 -0600 (CST)
Subject: [RFC 4/6] powerpc/pseries: Use common drcinfo parsing
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Rob Herring <robh@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 14 Dec 2018 14:51:15 -0600
In-Reply-To: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121420-0004-0000-0000-000014C26383
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131804; UDB=6.00588226; IPR=6.00911936; 
 MB=3.00024694; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 20:51:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121420-0005-0000-0000-000089DB7A23
Message-Id: <20181214205105.16435.65395.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140176
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The implementation of the pseries-specific drc info properties
is currently implemented in pseries-specific and non-pseries-specific
files.  This patch set uses a new implementation of the device-tree
parsing code for the properties.

This patch refactors parsing of the drc-info properties out of
pseries_energy.c and hotplug-cpu.c to use the common parser.
Changes include creating appropriate callback functions and
passing callback-specific data blocks into arch_find_drc_match.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   83 +++++++-----
 arch/powerpc/platforms/pseries/pseries_energy.c |  157 ++++++++---------------
 2 files changed, 107 insertions(+), 133 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 2f8e621..ee3028c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -411,23 +411,29 @@ static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
-static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
+struct cpu_drc_index_struct {
+	u32 drc_index;
+};
+
+bool cpu_drc_index_cb(struct device_node *dn,
+			u32 drc_index, char *drc_name,
+			char *drc_type, u32 drc_power_domain,
+			void *data)
 {
-	bool found = false;
-	int rc, index;
+	struct cpu_drc_index_struct *cdata = data;
 
-	index = 0;
-	while (!found) {
-		u32 drc;
+	if (drc_index == cdata->drc_index)
+		return true;
+	return false;
+}
 
-		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
-						index++, &drc);
-		if (rc)
-			break;
+static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
+{
+	struct cpu_drc_index_struct cdata = { drc_index };
+	bool found = false;
 
-		if (drc == drc_index)
-			found = true;
-	}
+	found = arch_find_drc_match(parent, cpu_drc_index_cb,
+			"CPU", NULL, false, false, &cdata);
 
 	return found;
 }
@@ -721,11 +727,34 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	return rc;
 }
 
+struct cpus_to_add_cb_struct {
+	struct device_node *parent;
+	u32 *cpu_drcs;
+	u32 cpus_to_add;
+	u32 cpus_found;
+};
+
+static bool cpus_to_add_cb(struct device_node *dn,
+			u32 drc_index, char *drc_name,
+			char *drc_type, u32 drc_power_domain,
+			void *data)
+{
+	struct cpus_to_add_cb_struct *cdata = data;
+
+	if (cdata->cpus_found < cdata->cpus_to_add) {
+		if (!dlpar_cpu_exists(cdata->parent, drc_index))
+			cdata->cpu_drcs[cdata->cpus_found++] = drc_index;
+	}
+
+	return !(cdata->cpus_found < cdata->cpus_to_add);
+}
+
 static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
 {
 	struct device_node *parent;
-	int cpus_found = 0;
-	int index, rc;
+	struct cpus_to_add_cb_struct cdata = {
+		NULL, cpu_drcs, cpus_to_add, 0 };
+	int cpus_found;
 
 	parent = of_find_node_by_path("/cpus");
 	if (!parent) {
@@ -734,25 +763,13 @@ static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
 		return -1;
 	}
 
-	/* Search the ibm,drc-indexes array for possible CPU drcs to
-	 * add. Note that the format of the ibm,drc-indexes array is
-	 * the number of entries in the array followed by the array
-	 * of drc values so we start looking at index = 1.
+	/* Search the appropriate property for possible CPU drcs
+	 * to add.
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
+	arch_find_drc_match(parent, cpus_to_add_cb, "CPU",
+			NULL, false, false, &cdata);
+	cpus_found = cdata.cpus_found;
 
 	of_node_put(parent);
 	return cpus_found;
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 6ed2212..f7b9d86 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -23,6 +23,7 @@
 #include <asm/hvcall.h>
 #include <asm/firmware.h>
 #include <asm/prom.h>
+#include <asm/topology.h>
 
 
 #define MODULE_VERS "1.0"
@@ -36,60 +37,43 @@
 
 /* Helper Routines to convert between drc_index to cpu numbers */
 
+struct cpu_to_drc_index_struct {
+	u32	thread_index;
+	u32	drc_index;
+	int	counter;
+};
+
+static bool cpu_to_drc_index_cb(struct device_node *dn,
+				u32 drc_index, char *drc_name,
+				char *drc_type, u32 drc_power_domain,
+				void *data)
+{
+	struct cpu_to_drc_index_struct *cdata = data;
+
+	if (cdata->thread_index == cdata->counter++) {
+		cdata->drc_index = drc_index;
+		return true;
+	}
+	return false;
+}
+
 static u32 cpu_to_drc_index(int cpu)
 {
 	struct device_node *dn = NULL;
-	int thread_index;
+	struct cpu_to_drc_index_struct cdata = { 0, 0, 0 };
 	int rc = 1;
-	u32 ret = 0;
 
 	dn = of_find_node_by_path("/cpus");
 	if (dn == NULL)
 		goto err;
 
 	/* Convert logical cpu number to core number */
-	thread_index = cpu_core_index_of_thread(cpu);
-
-	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
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
-
-		for (j = 0; j < num_set_entries; j++) {
-
-			of_read_drc_info_cell(&info, &value, &drc);
-			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
-
-			if (thread_index < drc.last_drc_index)
-				break;
-		}
-
-		ret = drc.drc_index_start + (thread_index * drc.sequential_inc);
-	} else {
-		const __be32 *indexes;
-
-		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-		if (indexes == NULL)
-			goto err_of_node_put;
-
-		/*
-		 * The first element indexes[0] is the number of drc_indexes
-		 * returned in the list.  Hence thread_index+1 will get the
-		 * drc_index corresponding to core number thread_index.
-		 */
-		ret = indexes[thread_index + 1];
-	}
+	cdata.thread_index = cpu_core_index_of_thread(cpu);
+
+	rc = arch_find_drc_match(dn, cpu_to_drc_index_cb,
+			"CPU", NULL, false, false, &cdata);
+	if (rc < 0)
+		goto err_of_node_put;
 
 	rc = 0;
 
@@ -98,78 +82,51 @@ static u32 cpu_to_drc_index(int cpu)
 err:
 	if (rc)
 		printk(KERN_WARNING "cpu_to_drc_index(%d) failed", cpu);
-	return ret;
+	return cdata.drc_index;
+}
+
+struct drc_index_to_cpu_struct {
+	u32	drc_index;
+	u32	thread_index;
+	int	counter;
+};
+
+static bool drc_index_to_cpu_cb(struct device_node *dn,
+				u32 drc_index, char *drc_name,
+				char *drc_type, u32 drc_power_domain,
+				void *data)
+{
+	struct drc_index_to_cpu_struct *cdata = data;
+
+	if (cdata->drc_index == drc_index) {
+		cdata->thread_index = cpu_first_thread_of_core(cdata->counter);
+		return true;
+	}
+	cdata->counter++;
+
+	return false;
 }
 
 static int drc_index_to_cpu(u32 drc_index)
 {
 	struct device_node *dn = NULL;
-	const int *indexes;
-	int thread_index = 0, cpu = 0;
+	struct drc_index_to_cpu_struct cdata = {
+			drc_index, 0, 0 };
 	int rc = 1;
 
 	dn = of_find_node_by_path("/cpus");
 	if (dn == NULL)
 		goto err;
 
-	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
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
-
-		for (j = 0; j < num_set_entries; j++) {
-
-			of_read_drc_info_cell(&info, &value, &drc);
-			if (strncmp(drc.drc_type, "CPU", 3))
-				goto err;
+	rc = arch_find_drc_match(dn, drc_index_to_cpu_cb,
+		   "CPU", NULL, false, false, &cdata);
 
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
-	} else {
-		unsigned long int i;
-
-		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-		if (indexes == NULL)
-			goto err_of_node_put;
-		/*
-		 * First element in the array is the number of drc_indexes
-		 * returned.  Search through the list to find the matching
-		 * drc_index and get the core number
-		 */
-		for (i = 0; i < indexes[0]; i++) {
-			if (indexes[i + 1] == drc_index)
-				break;
-		}
-		/* Convert core number to logical cpu number */
-		thread_index = cpu_first_thread_of_core(i);
-		rc = 0;
-	}
-
-err_of_node_put:
 	of_node_put(dn);
+
 err:
 	if (rc)
 		printk(KERN_WARNING "drc_index_to_cpu(%d) failed", drc_index);
-	return thread_index;
+	return cdata.thread_index;
 }
 
 /*

