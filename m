Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF5C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 19:08:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CBD2080A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 19:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CBD2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kPJ82GSlzF0wj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 06:08:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kPFj4FlszF1HF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 06:06:01 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9TIwh5G089063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 15:05:59 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ne590fw9t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 15:05:58 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 29 Oct 2018 15:05:57 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 29 Oct 2018 15:05:55 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9TJ5s4R852234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Oct 2018 19:05:54 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11AF3112066;
 Mon, 29 Oct 2018 19:05:54 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAF12112062;
 Mon, 29 Oct 2018 19:05:53 +0000 (GMT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 29 Oct 2018 19:05:53 +0000 (GMT)
Subject: [PATCH] powerpc/pseries: Perform full re-add of CPU for topology
 update post-migration
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 Oct 2018 13:43:36 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102919-0060-0000-0000-000002C8AFE8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009949; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01109780; UDB=6.00574984; IPR=6.00889873; 
 MB=3.00023954; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-29 19:05:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102919-0061-0000-0000-000047039672
Message-Id: <154083861636.18916.18172276232185726281.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-29_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810290172
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
Cc: ldufour@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On pseries systems, performing a partition migration can result in
altering the nodes a CPU is assigned to on the destination system. For
exampl, pre-migration on the source system CPUs are in node 1 and 3,
post-migration on the destination system CPUs are in nodes 2 and 3.

Handling the node change for a CPU can cause corruption in the slab
cache if we hit a timing where a CPUs node is changed while cache_reap()
is invoked. The corruption occurs because the slab cache code appears
to rely on the CPU and slab cache pages being on the same node.

The current dynamic updating of a CPUs node done in arch/powerpc/mm/numa.c
does not prevent us from hitting this scenario.

Changing the device tree property update notification handler that
recognizes an affinity change for a CPU to do a full DLPAR remove and
add of the CPU instead of dynamically changing its node resolves this
issue.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h          |    2 ++
 arch/powerpc/mm/numa.c                       |    9 +--------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index a4a718dbfec6..f85e2b01c3df 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,8 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+
+int dlpar_cpu_readd(int cpu);
 #endif
 #endif
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 693ae1c1acba..bb6a7b56bef7 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1461,13 +1461,6 @@ static void reset_topology_timer(void)
 
 #ifdef CONFIG_SMP
 
-static void stage_topology_update(int core_id)
-{
-	cpumask_or(&cpu_associativity_changes_mask,
-		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
-	reset_topology_timer();
-}
-
 static int dt_update_callback(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
@@ -1480,7 +1473,7 @@ static int dt_update_callback(struct notifier_block *nb,
 		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
 			u32 core_id;
 			of_property_read_u32(update->dn, "reg", &core_id);
-			stage_topology_update(core_id);
+			rc = dlpar_cpu_readd(core_id);
 			rc = NOTIFY_OK;
 		}
 		break;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 2f8e62163602..97feb6e79f1a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -802,6 +802,25 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 	return rc;
 }
 
+int dlpar_cpu_readd(int cpu)
+{
+	struct device_node *dn;
+	struct device *dev;
+	u32 drc_index;
+	int rc;
+
+	dev = get_cpu_device(cpu);
+	dn = dev->of_node;
+
+	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
+
+	rc = dlpar_cpu_remove_by_index(drc_index);
+	if (!rc)
+		rc = dlpar_cpu_add(drc_index);
+
+	return rc;
+}
+
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	u32 count, drc_index;

