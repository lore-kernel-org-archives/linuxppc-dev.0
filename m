Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C1C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D0220C0A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D0220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P3QS4HXDzF36q
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:43:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P2r02SyxzF35X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 23:17:04 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91DD1vj042722
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 09:17:02 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2muhmcq60q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 09:17:00 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 1 Oct 2018 09:16:58 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 09:16:54 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91DGr2s25821356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 13:16:53 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAB4728060;
 Mon,  1 Oct 2018 09:14:33 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A08682805A;
 Mon,  1 Oct 2018 09:14:33 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.106])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 09:14:33 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id CE07F2E4141; Mon,  1 Oct 2018 18:46:49 +0530 (IST)
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH v9 3/3] powerpc/sysfs: Add
 topology/smallcore_thread_siblings[_list]
Date: Mon,  1 Oct 2018 18:46:42 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100113-0052-0000-0000-0000033A73D3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009802; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096315; UDB=6.00566874; IPR=6.00876357; 
 MB=3.00023575; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 13:16:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100113-0053-0000-0000-00005E424CBA
Message-Id: <1538399802-23582-4-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010131
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

This patch adds two sysfs attributes named smallcore_thread_siblings
and smallcore_thread_siblings_list to the "topology" attribute group
for each CPU device.

The read-only attributes
/sys/device/system/cpu/cpuN/topology/smallcore_thread_siblings and
/sys/device/system/cpu/cpuN/topology/smallcore_thread_siblings_list
will the online siblings of CPU N that share the L1 cache with it on
big-core configurations in cpumask format and cpu-list format
respectively.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 14 ++++
 arch/powerpc/kernel/sysfs.c                        | 91 ++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 7331822..2a80dc2 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -511,3 +511,17 @@ Description:	Control Symetric Multi Threading (SMT)
 
 			 If control status is "forceoff" or "notsupported" writes
 			 are rejected.
+
+What:		/sys/devices/system/cpu/cpu#/topology/smallcore_thread_siblings
+		/sys/devices/system/cpu/cpu#/topology/smallcore_thread_siblings_list
+Date:		Sept 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description: 	CPU topology files that describe the thread siblings of a
+		logical CPU that share the L1-cache with it on POWER9
+		big-core configurations.
+
+		smallcore_thread_siblings: internal kernel map of
+		cpu#'s hardware threads that share L1-cache with cpu#.
+
+		smallcore_thread_siblings_list: human-readable list of
+		cpu#'s hardware threads that share L1-cache with cpu#.
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98..3049511 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/cputhreads.h>
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -1060,3 +1061,93 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
+
+#ifdef CONFIG_SMP
+static ssize_t smallcore_thread_siblings_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	int cpu = dev->id;
+
+	return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
+}
+static DEVICE_ATTR_RO(smallcore_thread_siblings);
+
+static ssize_t
+	smallcore_thread_siblings_list_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	int cpu = dev->id;
+
+	return cpumap_print_to_pagebuf(true, buf, cpu_smallcore_mask(cpu));
+}
+static DEVICE_ATTR_RO(smallcore_thread_siblings_list);
+
+static struct attribute *smallcore_attrs[] = {
+	&dev_attr_smallcore_thread_siblings.attr,
+	&dev_attr_smallcore_thread_siblings_list.attr,
+	NULL
+};
+
+static const struct attribute_group smallcore_attr_group = {
+	.name = "topology",
+	.attrs = smallcore_attrs
+};
+
+static int smallcore_register_cpu_online(unsigned int cpu)
+{
+	int err;
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!has_big_cores)
+		return 0;
+
+	err = sysfs_merge_group(&cpu_dev->kobj, &smallcore_attr_group);
+
+	return err;
+}
+
+static int smallcore_unregister_cpu_online(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!has_big_cores)
+		return 0;
+
+	sysfs_unmerge_group(&cpu_dev->kobj, &smallcore_attr_group);
+
+	return 0;
+}
+
+/*
+ * NOTE: The smallcore_register_cpu_online
+ *       (resp. smallcore_unregister_cpu_online) callback will merge
+ *       (resp. unmerge) a couple of additional attributes to the
+ *       "topology" attribute group of a CPU device when the CPU comes
+ *       online (resp. goes offline).
+ *
+ *       Hence, the registration of these callbacks must happen after
+ *       topology_sysfs_init() is called so that the topology
+ *       attribute group is created before these additional attributes
+ *       can be merged/unmerged. We cannot register these callbacks in
+ *       topology_init() since this function is called before
+ *       topology_sysfs_init(). Hence we define the following
+ *       late_initcall for this purpose.
+ */
+static int __init smallcore_topology_init(void)
+{
+	int r;
+
+	if (!has_big_cores)
+		return 0;
+
+	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			      "powerpc/topology/smallcore:online",
+			      smallcore_register_cpu_online,
+			      smallcore_unregister_cpu_online);
+	WARN_ON(r < 0);
+	return 0;
+}
+late_initcall(smallcore_topology_init);
+#endif /* CONFIG_SMP */
-- 
1.9.4

