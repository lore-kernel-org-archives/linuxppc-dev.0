Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74265C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:27:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE27820850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE27820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449fc65dfmzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:27:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=shilpa.bhat@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449fZL2FbMzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 17:26:17 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x216N3PZ055203
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2019 01:26:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qxvcmxh5m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Mar 2019 01:26:14 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 1 Mar 2019 06:26:13 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 1 Mar 2019 06:25:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x216Pwb452363394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Mar 2019 06:25:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC7AD11C054;
 Fri,  1 Mar 2019 06:25:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9AA311C04C;
 Fri,  1 Mar 2019 06:25:56 +0000 (GMT)
Received: from oc4502181600.in.ibm.com (unknown [9.124.35.71])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  1 Mar 2019 06:25:56 +0000 (GMT)
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v2] powernv: powercap: Add hard minimum powercap
Date: Fri,  1 Mar 2019 11:55:54 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19030106-0016-0000-0000-0000025C5B97
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030106-0017-0000-0000-000032B6CD61
Message-Id: <1551421554-11655-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-01_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010043
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
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In POWER9, OCC(On-Chip-Controller) provides for hard and soft system
powercapping range. The hard powercap range is guaranteed while soft
powercap may or may not be enforced by OCC due to various power-thermal
reasons based on system configuration and workloads. This patch adds
a sysfs file to export the hard minimum powercap limit to allow the
user to set the appropriate powercap value that can be managed by the
system.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V1:
- s/asserted/enforced by OCC

 .../ABI/testing/sysfs-firmware-opal-powercap       | 10 ++++
 arch/powerpc/platforms/powernv/opal-powercap.c     | 66 +++++++++-------------
 2 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-powercap b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
index c9b66ec..e37d43e 100644
--- a/Documentation/ABI/testing/sysfs-firmware-opal-powercap
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-powercap
@@ -29,3 +29,13 @@ Description:	System powercap directory and attributes applicable for
 		  creates a request for setting a new-powercap. The
 		  powercap requested must be between powercap-min
 		  and powercap-max.
+
+What:		/sys/firmware/opal/powercap/system-powercap/powercap-hard-min
+Date:		March 2019
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Hard minimum powercap
+
+		This file provides the hard minimum powercap limit in Watts.
+		The powercap value above hard minimum limit is guaranteed to be
+		enforced by OCC and the powercap value below this limit may or
+		may not be guaranteed.
diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
index d90ee4f..38408e7 100644
--- a/arch/powerpc/platforms/powernv/opal-powercap.c
+++ b/arch/powerpc/platforms/powernv/opal-powercap.c
@@ -139,10 +139,24 @@ static void powercap_add_attr(int handle, const char *name,
 	attr->handle = handle;
 	sysfs_attr_init(&attr->attr.attr);
 	attr->attr.attr.name = name;
-	attr->attr.attr.mode = 0444;
+
+	if (!strncmp(name, "powercap-current", strlen(name))) {
+		attr->attr.attr.mode = 0664;
+		attr->attr.store = powercap_store;
+	} else {
+		attr->attr.attr.mode = 0444;
+	}
+
 	attr->attr.show = powercap_show;
 }
 
+static const char * const powercap_strs[] = {
+	"powercap-max",
+	"powercap-min",
+	"powercap-current",
+	"powercap-hard-min",
+};
+
 void __init opal_powercap_init(void)
 {
 	struct device_node *powercap, *node;
@@ -167,60 +181,34 @@ void __init opal_powercap_init(void)
 
 	i = 0;
 	for_each_child_of_node(powercap, node) {
-		u32 cur, min, max;
-		int j = 0;
-		bool has_cur = false, has_min = false, has_max = false;
+		u32 id;
+		int j, count = 0;
 
-		if (!of_property_read_u32(node, "powercap-min", &min)) {
-			j++;
-			has_min = true;
-		}
-
-		if (!of_property_read_u32(node, "powercap-max", &max)) {
-			j++;
-			has_max = true;
-		}
+		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++)
+			if (!of_property_read_u32(node, powercap_strs[j], &id))
+				count++;
 
-		if (!of_property_read_u32(node, "powercap-current", &cur)) {
-			j++;
-			has_cur = true;
-		}
-
-		pcaps[i].pattrs = kcalloc(j, sizeof(struct powercap_attr),
+		pcaps[i].pattrs = kcalloc(count, sizeof(struct powercap_attr),
 					  GFP_KERNEL);
 		if (!pcaps[i].pattrs)
 			goto out_pcaps_pattrs;
 
-		pcaps[i].pg.attrs = kcalloc(j + 1, sizeof(struct attribute *),
+		pcaps[i].pg.attrs = kcalloc(count + 1,
+					    sizeof(struct attribute *),
 					    GFP_KERNEL);
 		if (!pcaps[i].pg.attrs) {
 			kfree(pcaps[i].pattrs);
 			goto out_pcaps_pattrs;
 		}
 
-		j = 0;
 		pcaps[i].pg.name = kasprintf(GFP_KERNEL, "%pOFn", node);
-		if (has_min) {
-			powercap_add_attr(min, "powercap-min",
-					  &pcaps[i].pattrs[j]);
-			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
-			j++;
-		}
-
-		if (has_max) {
-			powercap_add_attr(max, "powercap-max",
-					  &pcaps[i].pattrs[j]);
-			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
-			j++;
-		}
+		for (j = 0; j < ARRAY_SIZE(powercap_strs); j++) {
+			if (of_property_read_u32(node, powercap_strs[j], &id))
+				continue;
 
-		if (has_cur) {
-			powercap_add_attr(cur, "powercap-current",
+			powercap_add_attr(id, powercap_strs[j],
 					  &pcaps[i].pattrs[j]);
-			pcaps[i].pattrs[j].attr.attr.mode |= 0220;
-			pcaps[i].pattrs[j].attr.store = powercap_store;
 			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
-			j++;
 		}
 
 		if (sysfs_create_group(powercap_kobj, &pcaps[i].pg)) {
-- 
1.8.3.1

