Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA8C56202
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 02:09:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD462075A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 02:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e48RrKYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD462075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChLmR3SLMzDrL9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:09:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=e48RrKYl; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChLJR59PGzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 12:48:39 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AQ1YHgW028905; Wed, 25 Nov 2020 20:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YRnEkuEqjDj++scde+YVqMCEf0sHVTKqiYA1bhvEC9g=;
 b=e48RrKYlIV0O59qjm1+43YBuV6jmLpRJgt0moL/yMiX2S63Oi1g5GKpwdK4VUH9BNaP7
 hO2hcKUTU7HC+GgkTVOus7PgoQnACqTXsheFp8N43zDHrGMgIUdroHUAdny5zTIn1/39
 2wxtdSSdm5rEtE/CyWh3NG9Lo/jz4U0IYDCMhzL5s3DMFKFdq0pF4u0dPzVogzHaMTir
 NGWnCPPEL+4k2LNss/qbf4vsz2EQMDlB7MiaEFrtq7skcFlPQ4URCn8aCX1NinVs9eT+
 JyESbihTQweQN2qftmY1ortIQ1kpnv6LcN7SSSObrpf59U/zRoT4Kd6axhOqhDPbQ+ib XA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3521cht09x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2020 20:48:36 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ1m40V001795;
 Thu, 26 Nov 2020 01:48:35 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 351uh83cng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 01:48:35 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0AQ1mYHE7143954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2020 01:48:34 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C4006E050;
 Thu, 26 Nov 2020 01:48:34 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D95446E052;
 Thu, 26 Nov 2020 01:48:33 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 26 Nov 2020 01:48:33 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com
Subject: [PATCH 12/13] ibmvfc: send commands down HW Sub-CRQ when channelized
Date: Wed, 25 Nov 2020 19:48:23 -0600
Message-Id: <20201126014824.123831-13-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201126014824.123831-1-tyreld@linux.ibm.com>
References: <20201126014824.123831-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-25_14:2020-11-25,
 2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=1 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260005
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
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, brking@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the client has negotiated the use of channels all vfcFrames are
required to go down a Sub-CRQ channel or it is a protocoal violation. If
the adapter state is channelized submit vfcFrames to the appropriate
Sub-CRQ via the h_send_sub_crq() helper.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index f686c2cb0de2..897e3236534d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -701,6 +701,15 @@ static int ibmvfc_send_crq(struct ibmvfc_host *vhost, u64 word1, u64 word2)
 	return plpar_hcall_norets(H_SEND_CRQ, vdev->unit_address, word1, word2);
 }
 
+static int ibmvfc_send_sub_crq(struct ibmvfc_host *vhost, u64 cookie, u64 word1,
+			       u64 word2, u64 word3, u64 word4)
+{
+	struct vio_dev *vdev = to_vio_dev(vhost->dev);
+
+	return plpar_hcall_norets(H_SEND_SUB_CRQ, vdev->unit_address, cookie,
+				  word1, word2, word3, word4);
+}
+
 /**
  * ibmvfc_send_crq_init - Send a CRQ init message
  * @vhost:	ibmvfc host struct
@@ -1524,8 +1533,17 @@ static int ibmvfc_send_event(struct ibmvfc_event *evt,
 
 	mb();
 
-	if ((rc = ibmvfc_send_crq(vhost, be64_to_cpu(crq_as_u64[0]),
-				  be64_to_cpu(crq_as_u64[1])))) {
+	if (vhost->using_channels && evt->crq.format == IBMVFC_CMD_FORMAT)
+		rc = ibmvfc_send_sub_crq(vhost,
+					 vhost->scsi_scrqs.scrqs[evt->hwq].vios_cookie,
+					 be64_to_cpu(crq_as_u64[0]),
+					 be64_to_cpu(crq_as_u64[1]),
+					 0, 0);
+	else
+		rc = ibmvfc_send_crq(vhost, be64_to_cpu(crq_as_u64[0]),
+				     be64_to_cpu(crq_as_u64[1]));
+
+	if (rc) {
 		list_del(&evt->queue);
 		del_timer(&evt->timer);
 
-- 
2.27.0

