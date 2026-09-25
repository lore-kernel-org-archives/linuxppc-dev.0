Return-Path: <linuxppc-dev+bounces-28159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C15AC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 04:49:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrdWT1gWlz3bc6;
	Fri, 25 Sep 2026 14:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790311717;
	cv=none; b=NBjnJJBgknmH9DW060ezE6pYhD0drPWYk84U4oJZetSDSMCJIIVp6FwwVHDL1uX8LChgu0toIj1tKp1k4+CWRMsjW0zRta00sZDGRDoPaNkxsevVlUttd/6kRyTqY8FXyFOAK5pz0gTNIz0luy0y3D35QIETxHNp9QrYkYfhBcIy1WP5dw0f0OYDHbCwwlNam7NmyYQLfh40VRWUy14KVUH97tVk4tjouLFdYzZJPz3H4gHoG5SmqdL+XFwav8F4V6Ld36m4spMArf1zIoVr8SmAjJFF1UFXUbqOMMI2Rmt0qQP8Hi1ZDlFmIzpr1Z3laqlYCyoxnyE0Xlatyb9fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790311717; c=relaxed/relaxed;
	bh=lHva3qHyfiorkR5slQhUiG5gLBTSsam5DbS2KoBYTBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxAFcx3Mn96tE2kG7F1Bvt7JsIMGhzO35sm59ptyY/3ERC9R5FhBoiokvvq+aFURNgxxMiJT2x2HOUBB8aVG4887M2Jol2sj2ikbU2y5x2jTnnX7OWZQ8xa5tejIYzj/wnBIsbR6Hi9Yc+M68K7vvA6hEgpIJn+yNiuj9OJS1ZCALtlHqmvqpiS6doW+n+z7eWpec+qr7Swc53YNxXJJNofnsquXrE3Vri3I8QxC5DEdwTc+HNJwWuSUwM0rNQDdl5/W1QpfObJtju5fvELrxdO7Z5pzUlW6cWGOvzN7tfpqH8WOCoPIbmsoZdgO+C0qU2NxTah/DR0GiIl5ObTTeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kAPXQaLy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kAPXQaLy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrdWR17wkz3bgl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 14:48:35 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4bCMo076861;
	Fri, 25 Sep 2026 04:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lHva3qHyfiorkR5sl
	QhUiG5gLBTSsam5DbS2KoBYTBQ=; b=kAPXQaLy0zVchWTKuvhB2ZhDQw8amICX9
	mhRRvzohSkGNdynOHlga8zLbeJIktptdfFPKgAbvd7A6TXUPPJoHBgw0qB3mZdEE
	irNWpTgW/j0e2gA6ShPEVifAjlEQ+t/8gH7msZdopOE1ePqtsUE7uuIuky7fbXTp
	TybDfceSEBKWAZLXbpW+nv30cc8LSgFM7jADK4MBolYIrlfWd6Blc/C7NiHG4cSf
	B3ZIIg6HijsZutttXBTnXEmfx+UvMrVUdZGJzFa3fWn32T+11hp5FKF5U8n12aD9
	E3vnXIO2IcyXqpSAfIX8zHA5OZYgQuHSMEKDJ2KDJUGUNcc5SmoKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2w99a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lY4n3248902;
	Fri, 25 Sep 2026 04:48:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt30y23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P4lkl030737130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 04:47:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64115805E;
	Fri, 25 Sep 2026 04:48:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCD605805C;
	Fri, 25 Sep 2026 04:48:28 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.142.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 04:48:28 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v11 09/11] scsi: ibmvfc: extend channel reg/dereg helpers for async sub-CRQ
Date: Thu, 24 Sep 2026 21:48:58 -0700
Message-ID: <20260925044900.414340-10-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925044900.414340-1-tyreld@linux.ibm.com>
References: <20260925044900.414340-1-tyreld@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f3y3407mbuzHLIPBdVtScFPhtXuh8OqU
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab5fd20 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-ETtxkXC2bfW1udaLu8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfX8gGkaDLsV0rK
 ck96TzGE/g9qcNmG50uJZ1EsQJdET3ILCQ1scY/S04bIrDjZ5qejr2M/uCL+WNJwQ3RgJFFzo9k
 /fpGpojGS89ghyg33/XfXOfsNUoIAoaA49z1d/VUaxK+rbKt6GNog8WbdVGh8pL1hHY10xHfOll
 2XGBzyzgKWub5y49RIbYI/CzidNocFen4SoR00g8oG7vbMZZX2VpcLzwa3ji9ujlyRozjhenkqb
 1t/2AwvbvNHU/hRO0vfJMc+AQyAK01V9RC672TtAjGg5VAIUz0MgaOqdcr+cjV4HkVk3nxtHx5N
 7M7LeNt4sYd6t2WwRQHG3aYaWv67Jr6GwmT2M8L1eh4XXODRjHIMT6IqBSwqc3yaS6rA+F+QUq4
 bxVHdY9hzarS29g99M4ND6tthgE6K2H2HzIadbKWlTjIL4b/y4mzAWpz2dtIRyAY7wC1Yhci+Co
 6+Uefp2x7ULNKN1ftkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfX/iAY/FqP74SK
 ooVxiFN8lBPUP20jsIamwWyIQvRN7Few5FaERfSeENZhUxmrDtJZuHebxDjyjoSvI+DOkWyxkuQ
 YTIlb956Qk0/KtZU9+V5VJBwZrIuM7w=
X-Proofpoint-GUID: f3y3407mbuzHLIPBdVtScFPhtXuh8OqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250018

From: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc_register_channel() and ibmvfc_deregister_channel() previously only
handled SCSI and NVMe sub-CRQ channels identified by the channel protocol
(IBMVFC_PROTO_SCSI, IBMVFC_PROTO_NVME). The async sub-CRQ had no
registration path through these helpers, requiring separate handling.

Add a new IBMVFC_PROTO_ASYNC protocol value to enum ibmvfc_protocol.
Extend both functions to handle IBMVFC_PROTO_ASYNC channels: the IRQ is
named "ibmvfc-<addr>-async<index>" and the handler is set to
ibmvfc_interrupt_async_subq rather than the per-protocol
ibmvfc_interrupt_mq handler.

Remove the __maybe_unused annotation from ibmvfc_interrupt_async_subq
now that it is referenced in ibmvfc_register_channel().

Error messages in both paths are updated to include the channel protocol
to distinguish async sub-CRQ failures from SCSI/NVMe sub-CRQ failures.
Kernel-doc headers are added to both functions.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 46 +++++++++++++++++++++++++----
 drivers/scsi/ibmvscsi/ibmvfc.h      |  1 +
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index b354bfb1a9b6..b967c82e9943 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4421,7 +4421,7 @@ static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
  * @scrq_instance: async subq
  *
  **/
-static irqreturn_t __maybe_unused ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
+static irqreturn_t ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
 {
 	struct ibmvfc_queue *scrq = (struct ibmvfc_queue *)scrq_instance;
 
@@ -6812,6 +6812,21 @@ static int ibmvfc_init_crq(struct ibmvfc_host *vhost)
 	return retrc;
 }
 
+/**
+ * ibmvfc_register_channel - Register a sub-CRQ channel with the hypervisor
+ * @vhost:	ibmvfc host struct
+ * @channels:	ibmvfc channels struct containing the channel array and protocol
+ * @index:	index into the channels array for the queue to register, or
+ *		a negative value to register the async sub-CRQ
+ *
+ * Register a sub-CRQ with the hypervisor via h_reg_sub_crq, map its hardware
+ * IRQ to a Linux IRQ, and bind an interrupt handler to it. The handler is
+ * selected based on the channel protocol (SCSI or NVMe) for normal queues, or
+ * set to the async sub-CRQ handler when @index is negative.
+ *
+ * Return value:
+ *	0 on success / non-zero on failure
+ **/
 static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 				   struct ibmvfc_channels *channels,
 				   int index)
@@ -6839,7 +6854,8 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 
 	if (!scrq->irq) {
 		rc = -EINVAL;
-		dev_err(dev, "Error mapping sub-crq[%d] irq\n", index);
+		dev_err(dev, "Error mapping protocol (%d) sub-crq[%d] irq\n",
+			channels->protocol, index);
 		goto irq_failed;
 	}
 
@@ -6854,6 +6870,11 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 			 vdev->unit_address, index);
 		scrq->handler = ibmvfc_interrupt_mq;
 		break;
+	case IBMVFC_PROTO_ASYNC:
+		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-async%d",
+			 vdev->unit_address, index);
+		scrq->handler = ibmvfc_interrupt_async_subq;
+		break;
 	default:
 		dev_err(dev, "Unknown channel protocol (%d)\n",
 			channels->protocol);
@@ -6863,7 +6884,8 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	rc = request_irq(scrq->irq, scrq->handler, 0, scrq->name, scrq);
 
 	if (rc) {
-		dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
+		dev_err(dev, "Couldn't register protocol (%d) sub-crq[%d] irq\n",
+			channels->protocol, index);
 		irq_dispose_mapping(scrq->irq);
 		scrq->irq = 0;
 		goto irq_failed;
@@ -6883,6 +6905,18 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	return rc;
 }
 
+/**
+ * ibmvfc_deregister_channel - Deregister a sub-CRQ channel with the hypervisor
+ * @vhost:	ibmvfc host struct
+ * @channels:	ibmvfc channels struct containing the sub-CRQ array
+ * @index:	index into the sub-CRQ array, or -1 to deregister the
+ *		asynchronous sub-CRQ
+ *
+ * Frees the IRQ, disposes of the IRQ mapping, and calls H_FREE_SUB_CRQ to
+ * release the sub-CRQ with the hypervisor. On success the queue message
+ * buffer is zeroed and the current index is reset. If H_FREE_SUB_CRQ fails,
+ * an error is logged but the channel resources are cleaned up regardless.
+ */
 static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 				      struct ibmvfc_channels *channels,
 				      int index)
@@ -6905,8 +6939,10 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 					scrq->cookie);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
 
-	if (rc)
-		dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n", index, rc);
+	if (rc) {
+		dev_err(dev, "Failed to free protocol (%d) sub-crq[%d]: rc=%ld\n",
+			channels->protocol, index, rc);
+	}
 
 	/* Clean out the queue */
 	if (scrq->msgs.handle) {
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index ebbcb911f639..1cb6f20b0626 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -839,6 +839,7 @@ enum ibmvfc_target_action {
 enum ibmvfc_protocol {
 	IBMVFC_PROTO_SCSI = 0,
 	IBMVFC_PROTO_NVME = 1,
+	IBMVFC_PROTO_ASYNC = 2,
 };
 
 struct ibmvfc_target {
-- 
2.55.0


