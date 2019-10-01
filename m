Return-Path: <SRS0=t3e+=X2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8EBC388F3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Oct 2019 06:25:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C807F2054F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Oct 2019 06:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C807F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46j8R558KNzDqFK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Oct 2019 16:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46j87f68n1zDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2019 16:12:30 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9168Pvs097050; Tue, 1 Oct 2019 02:12:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjsb93n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 02:12:25 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9168hgS097611;
 Tue, 1 Oct 2019 02:12:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjsb937-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 02:12:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x916A3eh015654;
 Tue, 1 Oct 2019 06:12:24 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 2v9y57y3ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 06:12:24 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x916CNx951511754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 06:12:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80890112062;
 Tue,  1 Oct 2019 06:12:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A73A112061;
 Tue,  1 Oct 2019 06:12:23 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 06:12:22 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: mpe@ellerman.id.au, bhelgaas@google.com
Subject: [RFC PATCH 6/9] PCI: rpaphp: add drc-info support for hotplug slot
 registration
Date: Tue,  1 Oct 2019 01:12:11 -0500
Message-Id: <1569910334-5972-7-git-send-email-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com>
References: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010060
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
Cc: nathanl@linux.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Split physical PCI slot registration scanning into seperate routines
that support the old ibm,drc-* properties and one that supports the
new compressed ibm,drc-info property.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 89 ++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index e18e9a0..75d5771 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -328,23 +328,48 @@ static int is_php_dn(struct device_node *dn, const int **indexes,
 	return 1;
 }
 
-/**
- * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
- * @dn: device node of slot
- *
- * This subroutine will register a hotpluggable slot with the
- * PCI hotplug infrastructure. This routine is typically called
- * during boot time, if the hotplug slots are present at boot time,
- * or is called later, by the dlpar add code, if the slot is
- * being dynamically added during runtime.
- *
- * If the device node points at an embedded (built-in) slot, this
- * routine will just return without doing anything, since embedded
- * slots cannot be hotplugged.
- *
- * To remove a slot, it suffices to call rpaphp_deregister_slot().
- */
-int rpaphp_add_slot(struct device_node *dn)
+static int rpaphp_drc_info_add_slot(struct device_node *dn)
+{
+	struct slot *slot;
+	struct property *info;
+	struct of_drc_info drc;
+	char drc_name[MAX_DRC_NAME_LEN];
+	const __be32 *cur;
+	u32 count;
+	int retval = 0;
+
+	info = of_find_property(dn, "ibm,drc-info", NULL);
+	if (!info)
+		return 0;
+
+	cur = of_prop_next_u32(info, NULL, &count);
+	if (cur)
+		cur++;
+	else
+		return 0;
+
+	of_read_drc_info_cell(&info, &cur, &drc);
+	if (!is_php_type(drc.drc_type))
+		return 0;
+
+	sprintf(drc_name, "%s%d", drc.drc_name_prefix, drc.drc_name_suffix_start);
+
+	slot = alloc_slot_struct(dn, drc.drc_index_start, drc_name, drc.drc_power_domain);
+	if (!slot)
+		return -ENOMEM;
+
+	slot->type = simple_strtoul(drc.drc_type, NULL, 10);
+	retval = rpaphp_enable_slot(slot);
+	if (!retval)
+		retval = rpaphp_register_slot(slot);
+
+	if (retval)
+		dealloc_slot_struct(slot);
+
+	return retval;
+}
+
+static int rpaphp_drc_add_slot(struct device_node *dn)
 {
 	struct slot *slot;
 	int retval = 0;
@@ -352,9 +377,6 @@ int rpaphp_add_slot(struct device_node *dn)
 	const int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
-	if (!dn->name || strcmp(dn->name, "pci"))
-		return 0;
-
 	/* If this is not a hotplug slot, return without doing anything. */
 	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
 		return 0;
@@ -393,6 +415,33 @@ int rpaphp_add_slot(struct device_node *dn)
 	/* XXX FIXME: reports a failure only if last entry in loop failed */
 	return retval;
 }
+
+/**
+ * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
+ * @dn: device node of slot
+ *
+ * This subroutine will register a hotpluggable slot with the
+ * PCI hotplug infrastructure. This routine is typically called
+ * during boot time, if the hotplug slots are present at boot time,
+ * or is called later, by the dlpar add code, if the slot is
+ * being dynamically added during runtime.
+ *
+ * If the device node points at an embedded (built-in) slot, this
+ * routine will just return without doing anything, since embedded
+ * slots cannot be hotplugged.
+ *
+ * To remove a slot, it suffices to call rpaphp_deregister_slot().
+ */
+int rpaphp_add_slot(struct device_node *dn)
+{
+	if (!dn->name || strcmp(dn->name, "pci"))
+		return 0;
+
+	if (of_find_property(dn, "ibm,drc-info", NULL))
+		return rpaphp_drc_info_add_slot(dn);
+	else
+		return rpaphp_drc_add_slot(dn);
+}
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 
 static void __exit cleanup_slots(void)
-- 
2.7.4

