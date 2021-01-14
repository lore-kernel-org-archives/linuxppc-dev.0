Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA0FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 20:56:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A95238EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 20:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A95238EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGxRq0qlRzDqMh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 07:56:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=rzNZeacO; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGww14XgczDrQh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 07:32:01 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 10EK2oPB185766; Thu, 14 Jan 2021 15:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=93FWYEBzS1jw1+gJXU9Weiq+Fq0bioDeCgcTWeVwlFw=;
 b=rzNZeacOO2QFcCuPWh07MX2ASDgQIq80Vw7puFqF4awPTs7wgMmdfZo1PSfT7VKvq8q4
 X55sfiurg9HnN9Wy/J4PRBS/xECissBIXDpJGh2+8VX/26W3zKsH5WonvDyxkdmKRZwR
 xHnvcYs+XAfOvSxvjl0wdGNUoIWAThpzHFtXxMsZpjYtKvPrwPKXCOKIcLwNcw3YIXqX
 6Pd3L5h74h9QyIyq3JoNBihTh8ywpDiUKAVmO3R4AUFT5Fz9VxXvip0LwDaopvtoNOSk
 7Kht9XdJX7nUQeIVRMsWhQNhbAdmBgM7vBcjxxYUHUukt3Jzr6hg4+ZRA0qu9pd7n49h VA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 362vhhgv4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 15:31:57 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10EKHFxM004677;
 Thu, 14 Jan 2021 20:31:57 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02wdc.us.ibm.com with ESMTP id 35y449frye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 20:31:57 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 10EKVtcX4850102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jan 2021 20:31:55 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1F026E050;
 Thu, 14 Jan 2021 20:31:55 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F02A6E056;
 Thu, 14 Jan 2021 20:31:55 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 14 Jan 2021 20:31:55 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com
Subject: [PATCH v5 13/21] ibmvfc: advertise client support for using hardware
 channels
Date: Thu, 14 Jan 2021 14:31:40 -0600
Message-Id: <20210114203148.246656-14-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114203148.246656-1-tyreld@linux.ibm.com>
References: <20210114203148.246656-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_07:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140111
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brian King <brking@linux.vnet.ibm.com>, brking@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Previous patches have plumbed the necessary Sub-CRQ interface and
channel negotiation MADs to fully channelize via hardware backed queues.

Advertise client support via NPIV Login capability
IBMVFC_CAN_USE_CHANNELS when the client bits have MQ enabled via
vhost->mq_enabled, or when channels were already in use during a
subsequent NPIV Login. The later is required because channel support is
only renegotiated after a CRQ pair is broken. Simple NPIV Logout/Logins
require the client to continue to advertise the channel capability until
the CRQ pair between the client is broken.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index a00f38558613..0653d52d4ea0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1410,6 +1410,10 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 
 	login_info->max_cmds = cpu_to_be32(max_requests + IBMVFC_NUM_INTERNAL_REQ);
 	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
+
+	if (vhost->mq_enabled || vhost->using_channels)
+		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
+
 	login_info->async.va = cpu_to_be64(vhost->async_crq.msg_token);
 	login_info->async.len = cpu_to_be32(async_crq->size *
 					    sizeof(*async_crq->msgs.async));
-- 
2.27.0

