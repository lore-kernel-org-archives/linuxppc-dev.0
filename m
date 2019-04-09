Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E7DC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:56:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE712084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE712084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dthx0HLCzDqLC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:56:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hegdevasant@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dtcq3XbszDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 02:52:27 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x39GniTh039083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Apr 2019 12:52:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rrx313r28-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 12:52:24 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 9 Apr 2019 17:52:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 17:52:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x39GqJJT61472954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 16:52:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A263BA4053;
 Tue,  9 Apr 2019 16:52:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C1EFA4040;
 Tue,  9 Apr 2019 16:52:18 +0000 (GMT)
Received: from hegdevasant.in.ibm.com (unknown [9.102.1.232])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2019 16:52:18 +0000 (GMT)
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Add new opal message type
Date: Tue,  9 Apr 2019 22:22:02 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190409165202.30187-1-hegdevasant@linux.vnet.ibm.com>
References: <20190409165202.30187-1-hegdevasant@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040916-4275-0000-0000-000003260254
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040916-4276-0000-0000-000038351C4E
Message-Id: <20190409165202.30187-2-hegdevasant@linux.vnet.ibm.com>
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
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We have OPAL_MSG_PRD message type to pass prd related messages from OPAL
to `opal-prd`. It can handle messages upto 64 bytes. We have a requirement
to send bigger than 64 bytes of data from OPAL to `opal-prd`. Lets add new
message type (OPAL_MSG_PRD2) to pass bigger data.

Cc: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h       | 1 +
 arch/powerpc/platforms/powernv/opal-prd.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 821ed4fa95ad..79272e145281 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -455,6 +455,7 @@ enum opal_msg_type {
 	OPAL_MSG_DPO		= 5,
 	OPAL_MSG_PRD		= 6,
 	OPAL_MSG_OCC		= 7,
+	OPAL_MSG_PRD2		= 8,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 4070bb4e9da4..ef9a19de7cca 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -350,7 +350,7 @@ static int opal_prd_msg_notifier(struct notifier_block *nb,
 	int msg_size, item_size;
 	unsigned long flags;
 
-	if (msg_type != OPAL_MSG_PRD)
+	if (msg_type != OPAL_MSG_PRD && msg_type != OPAL_MSG_PRD2)
 		return 0;
 
 	/* Calculate total size of the message and item we need to store. The
@@ -401,6 +401,13 @@ static int opal_prd_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	rc = opal_message_notifier_register(OPAL_MSG_PRD2, &opal_prd_event_nb);
+	if (rc) {
+		pr_err("%s: Couldn't register event notifier (%d)\n",
+		       __func__, OPAL_MSG_PRD2);
+		return rc;
+	}
+
 	rc = misc_register(&opal_prd_dev);
 	if (rc) {
 		pr_err("failed to register miscdev\n");
-- 
2.14.3

