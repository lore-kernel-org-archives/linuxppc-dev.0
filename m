Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C3CC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:53:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6451F206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6451F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bm8T1V0GzDqsX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:45 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bm5v0T44zDqrq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 01:51:29 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0BEnYHB093788
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 09:51:26 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pxut7mv7d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 09:51:25 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 11 Jan 2019 14:51:25 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 11 Jan 2019 14:51:23 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0BEpMwD22020330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Jan 2019 14:51:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1823D6E04C;
 Fri, 11 Jan 2019 14:51:22 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E826B6E053;
 Fri, 11 Jan 2019 14:51:21 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jan 2019 14:51:21 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 77E1D4124A41;
 Fri, 11 Jan 2019 08:51:21 -0600 (CST)
Subject: [PATCH] powerpc/pseries: Split CPU readd for single CPU systems
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 11 Jan 2019 08:51:21 -0600
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011114-0036-0000-0000-00000A79352B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010385; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144959; UDB=6.00596202; IPR=6.00925229; 
 MB=3.00025083; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-11 14:51:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011114-0037-0000-0000-00004A4DFFCB
Message-Id: <20190111145053.100598.45322.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-11_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=788 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110122
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
Cc: mwb@linux.vnet.ibm.com, minkim@us.ibm.com, tlfalcon@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We have encountered cases where DLPAR CPU 'readd' fails on single
CPU platforms, because the system needs a minimum amount of resources
to keep operating.  The current implementation attempts to add, and
remove all of the threads of a specified core at once, and will fail
if there is a problem removing any of the thread cpus.  In single CPU
platforms, the system must hold onto at least some resources to keep
operating i.e. at least one thread of a CPU.  So in such environments,
attempting to remove and add the single core and all of its CPU threads
in order to reset and flush system structures and/or caches fails.

This problem has been observed on PowerVM and qemu environments.

This change attempts to resolve such situations by breaking up the
DLPAR CPU 'readd' operation into multiple steps, performing the
remove+readd of the CPU threads until an error occurs, and then
continuing the 'readd' operation for the threads that could not be
removed during the first phase of the operation.

Requires: ("powerpc/pseries: Perform full re-add of CPU for topology update post-migration")
Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  187 ++++++++++++++++----------
 1 file changed, 117 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 97feb6e..b33e066 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -342,7 +342,8 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
-static int dlpar_online_cpu(struct device_node *dn)
+static int dlpar_online_cpu(struct device_node *dn, cpumask_t *whichcpus,
+				int partial)
 {
 	int rc = 0;
 	unsigned int cpu;
@@ -359,6 +360,8 @@ static int dlpar_online_cpu(struct device_node *dn)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
+		if (partial && !cpumask_test_cpu(thread, whichcpus))
+			continue;
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
@@ -371,7 +374,6 @@ static int dlpar_online_cpu(struct device_node *dn)
 			if (rc)
 				goto out;
 			cpu_maps_update_begin();
-
 			break;
 		}
 		if (cpu == num_possible_cpus())
@@ -432,7 +434,10 @@ static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
-static ssize_t dlpar_cpu_add(u32 drc_index)
+static struct device_node *cpu_drc_index_to_dn(u32 drc_index);
+
+static ssize_t dlpar_cpu_add(u32 drc_index, cpumask_t *whichcpus,
+				bool partial)
 {
 	struct device_node *dn, *parent;
 	int rc, saved_rc;
@@ -445,10 +450,12 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		return -ENODEV;
 	}
 
-	if (dlpar_cpu_exists(parent, drc_index)) {
-		of_node_put(parent);
-		pr_warn("CPU with drc index %x already exists\n", drc_index);
-		return -EINVAL;
+	if (!parent) {
+		if (dlpar_cpu_exists(parent, drc_index)) {
+			of_node_put(parent);
+			pr_warn("CPU with drc index %x already exists\n", drc_index);
+			return -EINVAL;
+		}
 	}
 
 	if (!valid_cpu_drc_index(parent, drc_index)) {
@@ -457,49 +464,59 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		return -EINVAL;
 	}
 
-	rc = dlpar_acquire_drc(drc_index);
-	if (rc) {
-		pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
-			rc, drc_index);
-		of_node_put(parent);
-		return -EINVAL;
-	}
+	if (!partial) {
+		rc = dlpar_acquire_drc(drc_index);
+		if (rc) {
+			pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
+				rc, drc_index);
+			of_node_put(parent);
+			return -EINVAL;
+		}
 
-	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
-	if (!dn) {
-		pr_warn("Failed call to configure-connector, drc index: %x\n",
-			drc_index);
-		dlpar_release_drc(drc_index);
-		of_node_put(parent);
-		return -EINVAL;
-	}
+		dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
+		if (!dn) {
+			pr_warn("Failed call to configure-connector, drc index: %x\n",
+				drc_index);
+			dlpar_release_drc(drc_index);
+			of_node_put(parent);
+			return -EINVAL;
+		}
 
-	rc = dlpar_attach_node(dn, parent);
+		rc = dlpar_attach_node(dn, parent);
 
-	/* Regardless we are done with parent now */
-	of_node_put(parent);
+		/* Regardless we are done with parent now */
+		of_node_put(parent);
 
-	if (rc) {
-		saved_rc = rc;
-		pr_warn("Failed to attach node %pOFn, rc: %d, drc index: %x\n",
-			dn, rc, drc_index);
+		if (rc) {
+			saved_rc = rc;
+			pr_warn("Failed to attach node %pOFn, rc: %d, drc index: %x\n",
+				dn, rc, drc_index);
 
-		rc = dlpar_release_drc(drc_index);
-		if (!rc)
-			dlpar_free_cc_nodes(dn);
+			rc = dlpar_release_drc(drc_index);
+			if (!rc)
+				dlpar_free_cc_nodes(dn);
 
-		return saved_rc;
+			return saved_rc;
+		}
+	} else {
+		dn = cpu_drc_index_to_dn(drc_index);
+		if (!dn) {
+			pr_warn("Cannot find CPU (drc index %x) to add.\n", drc_index);
+			return -EINVAL;
+		}
 	}
 
-	rc = dlpar_online_cpu(dn);
+	rc = dlpar_online_cpu(dn, whichcpus, partial);
 	if (rc) {
 		saved_rc = rc;
 		pr_warn("Failed to online cpu %pOFn, rc: %d, drc index: %x\n",
 			dn, rc, drc_index);
 
-		rc = dlpar_detach_node(dn);
-		if (!rc)
-			dlpar_release_drc(drc_index);
+		if (!partial || (cpumask_weight(whichcpus) == 0)) {
+			rc = dlpar_detach_node(dn);
+			if (!rc)
+				dlpar_release_drc(drc_index);
+		}
 
 		return saved_rc;
 	}
@@ -509,7 +526,8 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 	return rc;
 }
 
-static int dlpar_offline_cpu(struct device_node *dn)
+static int dlpar_offline_cpu(struct device_node *dn, cpumask_t *whichcpus,
+				int partial)
 {
 	int rc = 0;
 	unsigned int cpu;
@@ -526,6 +544,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
+		if (partial && cpumask_test_cpu(thread, whichcpus))
+			continue;
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
@@ -542,8 +562,9 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				if (rc)
 					goto out;
 				cpu_maps_update_begin();
+				if (whichcpus)
+					cpumask_set_cpu(cpu, whichcpus);
 				break;
-
 			}
 
 			/*
@@ -566,41 +587,45 @@ static int dlpar_offline_cpu(struct device_node *dn)
 
 }
 
-static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
+static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index,
+				cpumask_t *whichcpus, bool partial)
 {
 	int rc;
 
 	pr_debug("Attempting to remove CPU %pOFn, drc index: %x\n",
 		 dn, drc_index);
 
-	rc = dlpar_offline_cpu(dn);
+	rc = dlpar_offline_cpu(dn, whichcpus, partial);
 	if (rc) {
 		pr_warn("Failed to offline CPU %pOFn, rc: %d\n", dn, rc);
 		return -EINVAL;
 	}
 
-	rc = dlpar_release_drc(drc_index);
-	if (rc) {
-		pr_warn("Failed to release drc (%x) for CPU %pOFn, rc: %d\n",
-			drc_index, dn, rc);
-		dlpar_online_cpu(dn);
-		return rc;
-	}
+	if (!partial) {
+		rc = dlpar_release_drc(drc_index);
+		if (rc) {
+			pr_warn("Failed to release drc (%x) for CPU %pOFn, rc: %d\n",
+				drc_index, dn, rc);
+			dlpar_online_cpu(dn, whichcpus, partial);
+			return rc;
+		}
 
-	rc = dlpar_detach_node(dn);
-	if (rc) {
-		int saved_rc = rc;
+		rc = dlpar_detach_node(dn);
+		if (rc) {
+			int saved_rc = rc;
 
-		pr_warn("Failed to detach CPU %pOFn, rc: %d", dn, rc);
+			pr_warn("Failed to detach CPU %pOFn, rc: %d", dn, rc);
 
-		rc = dlpar_acquire_drc(drc_index);
-		if (!rc)
-			dlpar_online_cpu(dn);
+			rc = dlpar_acquire_drc(drc_index);
+			if (!rc)
+				dlpar_online_cpu(dn, whichcpus, partial);
 
-		return saved_rc;
+			return saved_rc;
+		}
+
+		pr_debug("Successfully removed CPU, drc index: %x\n", drc_index);
 	}
 
-	pr_debug("Successfully removed CPU, drc index: %x\n", drc_index);
 	return 0;
 }
 
@@ -622,7 +647,8 @@ static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
 	return dn;
 }
 
-static int dlpar_cpu_remove_by_index(u32 drc_index)
+static int dlpar_cpu_remove_by_index(u32 drc_index, cpumask_t *whichcpus,
+					bool partial)
 {
 	struct device_node *dn;
 	int rc;
@@ -634,7 +660,7 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
 		return -ENODEV;
 	}
 
-	rc = dlpar_cpu_remove(dn, drc_index);
+	rc = dlpar_cpu_remove(dn, drc_index, whichcpus, partial);
 	of_node_put(dn);
 	return rc;
 }
@@ -699,7 +725,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	}
 
 	for (i = 0; i < cpus_to_remove; i++) {
-		rc = dlpar_cpu_remove_by_index(cpu_drcs[i]);
+		rc = dlpar_cpu_remove_by_index(cpu_drcs[i], NULL, false);
 		if (rc)
 			break;
 
@@ -710,7 +736,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
 
 		for (i = 0; i < cpus_removed; i++)
-			dlpar_cpu_add(cpu_drcs[i]);
+			dlpar_cpu_add(cpu_drcs[i], NULL, false);
 
 		rc = -EINVAL;
 	} else {
@@ -780,7 +806,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 	}
 
 	for (i = 0; i < cpus_to_add; i++) {
-		rc = dlpar_cpu_add(cpu_drcs[i]);
+		rc = dlpar_cpu_add(cpu_drcs[i], NULL, false);
 		if (rc)
 			break;
 
@@ -791,7 +817,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 		pr_warn("CPU hot-add failed, removing any added CPUs\n");
 
 		for (i = 0; i < cpus_added; i++)
-			dlpar_cpu_remove_by_index(cpu_drcs[i]);
+			dlpar_cpu_remove_by_index(cpu_drcs[i], NULL, false);
 
 		rc = -EINVAL;
 	} else {
@@ -807,16 +833,36 @@ int dlpar_cpu_readd(int cpu)
 	struct device_node *dn;
 	struct device *dev;
 	u32 drc_index;
-	int rc;
+	const __be32 *intserv;
+	cpumask_t whichcpus;
+	int rc, len, nthreads;
 
 	dev = get_cpu_device(cpu);
 	dn = dev->of_node;
 
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+	nthreads = len / sizeof(u32);
+	cpumask_clear(&whichcpus);
+
 	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
 
-	rc = dlpar_cpu_remove_by_index(drc_index);
+	rc = dlpar_cpu_remove_by_index(drc_index, &whichcpus, false);
 	if (!rc)
-		rc = dlpar_cpu_add(drc_index);
+		rc = dlpar_cpu_add(drc_index, &whichcpus, false);
+
+	if (cpumask_weight(&whichcpus) < nthreads) {
+		cpumask_t whichcpus2;
+
+		rc = dlpar_cpu_add(drc_index, &whichcpus, false);
+
+		cpumask_copy(&whichcpus2, &whichcpus);
+		dlpar_cpu_remove_by_index(drc_index, &whichcpus2, true);
+
+		cpumask_andnot(&whichcpus2, &whichcpus2, &whichcpus);
+		dlpar_cpu_add(drc_index, &whichcpus2, true);
+	}
 
 	return rc;
 }
@@ -836,7 +882,8 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
 			rc = dlpar_cpu_remove_by_count(count);
 		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
-			rc = dlpar_cpu_remove_by_index(drc_index);
+			rc = dlpar_cpu_remove_by_index(drc_index,
+					NULL, false);
 		else
 			rc = -EINVAL;
 		break;
@@ -844,7 +891,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
 			rc = dlpar_cpu_add_by_count(count);
 		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
-			rc = dlpar_cpu_add(drc_index);
+			rc = dlpar_cpu_add(drc_index, NULL, false);
 		else
 			rc = -EINVAL;
 		break;
@@ -869,7 +916,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	if (rc)
 		return -EINVAL;
 
-	rc = dlpar_cpu_add(drc_index);
+	rc = dlpar_cpu_add(drc_index, NULL, false);
 
 	return rc ? rc : count;
 }
@@ -890,7 +937,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
-	rc = dlpar_cpu_remove(dn, drc_index);
+	rc = dlpar_cpu_remove(dn, drc_index, NULL, false);
 	of_node_put(dn);
 
 	return rc ? rc : count;

