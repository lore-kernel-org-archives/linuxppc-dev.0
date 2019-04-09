Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5A8C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:54:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01C12084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01C12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dtff3wPSzDqD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:54:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hegdevasant@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dtcp4p8rzDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 02:52:26 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x39Gne2L117440
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Apr 2019 12:52:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rrwqyn32n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 12:52:23 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 9 Apr 2019 17:52:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 17:52:18 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x39GqH4F53280872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 16:52:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A572A4051;
 Tue,  9 Apr 2019 16:52:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE3F6A4059;
 Tue,  9 Apr 2019 16:52:15 +0000 (GMT)
Received: from hegdevasant.in.ibm.com (unknown [9.102.1.232])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2019 16:52:15 +0000 (GMT)
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/powernv: Enhance opal message read interface
Date: Tue,  9 Apr 2019 22:22:01 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 19040916-0028-0000-0000-0000035EFEF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040916-0029-0000-0000-0000241E1E3B
Message-Id: <20190409165202.30187-1-hegdevasant@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-09_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090107
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
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use "opal-msg-size" device tree property to allocate memory for "opal_msg".

Also replace `reserved` field in "struct opal_msg" with `size`. So that
opal_get_msg() user can get actual message size.

Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h   |  2 +-
 arch/powerpc/platforms/powernv/opal.c | 30 ++++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b239ea..821ed4fa95ad 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -460,7 +460,7 @@ enum opal_msg_type {
 
 struct opal_msg {
 	__be32 msg_type;
-	__be32 reserved;
+	__be32 size;
 	__be64 params[8];
 };
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b0eca104f86..52fb52c2ca4b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -62,6 +62,8 @@ static DEFINE_SPINLOCK(opal_write_lock);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static uint32_t opal_heartbeat;
 static struct task_struct *kopald_tsk;
+static struct opal_msg *opal_msg;
+static uint64_t opal_msg_size;
 
 void opal_configure_cores(void)
 {
@@ -268,14 +270,9 @@ static void opal_message_do_notify(uint32_t msg_type, void *msg)
 static void opal_handle_message(void)
 {
 	s64 ret;
-	/*
-	 * TODO: pre-allocate a message buffer depending on opal-msg-size
-	 * value in /proc/device-tree.
-	 */
-	static struct opal_msg msg;
 	u32 type;
 
-	ret = opal_get_msg(__pa(&msg), sizeof(msg));
+	ret = opal_get_msg(__pa(opal_msg), opal_msg_size);
 	/* No opal message pending. */
 	if (ret == OPAL_RESOURCE)
 		return;
@@ -287,14 +284,14 @@ static void opal_handle_message(void)
 		return;
 	}
 
-	type = be32_to_cpu(msg.msg_type);
+	type = be32_to_cpu(opal_msg->msg_type);
 
 	/* Sanity check */
 	if (type >= OPAL_MSG_TYPE_MAX) {
 		pr_warn_once("%s: Unknown message type: %u\n", __func__, type);
 		return;
 	}
-	opal_message_do_notify(type, (void *)&msg);
+	opal_message_do_notify(type, (void *)opal_msg);
 }
 
 static irqreturn_t opal_message_notify(int irq, void *data)
@@ -303,9 +300,22 @@ static irqreturn_t opal_message_notify(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __init opal_message_init(void)
+static int __init opal_message_init(struct device_node *opal_node)
 {
 	int ret, i, irq;
+	const __be32 *val;
+
+	val = of_get_property(opal_node, "opal-msg-size", NULL);
+	if (val)
+		opal_msg_size = be32_to_cpup(val);
+
+	/* If opal-msg-size property is not available then use default size */
+	if (!opal_msg_size)
+		opal_msg_size = sizeof(struct opal_msg);
+
+	opal_msg = kmalloc(opal_msg_size, GFP_KERNEL);
+	if (!opal_msg)
+		return -ENOMEM;
 
 	for (i = 0; i < OPAL_MSG_TYPE_MAX; i++)
 		ATOMIC_INIT_NOTIFIER_HEAD(&opal_msg_notifier_head[i]);
@@ -886,7 +896,7 @@ static int __init opal_init(void)
 	}
 
 	/* Initialise OPAL messaging system */
-	opal_message_init();
+	opal_message_init(opal_node);
 
 	/* Initialise OPAL asynchronous completion interface */
 	opal_async_comp_init();
-- 
2.14.3

