Return-Path: <linuxppc-dev+bounces-27077-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9341DC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 02:20:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgyss1WFSz300M;
	Fri, 11 Sep 2026 12:19:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789093169;
	cv=none; b=n8qcHc5w1m7yJCAMtxFYSuU0Sv8x/fjUfWjnBjZQT4nRQC6mnHnR9CLynQRdUGMsb9LICSJ7Af4OipmODrbV+FitJD9RofyduB63R2zhQd+IWx4aXjNcGwyaosVfvU9TdlJ3HUzPcZNEqXKMtLu48xIL4GQFoWWQQkyLk6iMC2sqjXOdHYRJ6LMs9Wofm1r85JE13qKlzzx65JP9xCElpTG1aX+N7PYcCM7J70GEzpDHri/cYAoTJgXjhcIZqa/VY2/15Jl+LPFiLA8OCIev0gDveyy4PdxmuvCfsn69ZXimNStJVeQKgdiYVKQvVyO/9iq96c9vH3zzbEMgFbNf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789093169; c=relaxed/relaxed;
	bh=ksJLDki+gOxvjijRLZXeku5IUdICIJyG577Sdp4IWAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUDXysbBLr5hHSGcTlv0KimFXZBnjgMyHO7VfqLS6mO95dar5WrLygYxJnJnqyGHKxxhVdhwwJR0WZazfUgGOiJ0QCMsJqrOMrYBJq1tL94v5M9v9Edp/onwOH4viHAM4Ul+Tijr6thifl0N3rvh2VO/9dzxdDf3kqQPhnGUQ4eSJckLJIggAFepT9iYwWzfDMk3ouLaGJeOeVvvdSlsVZr0u8rVsrZeb/XlGdNTeWfvA7FFhWzGiC1N6gJFI/dBqswQgHLdOpCYi61ucN+BGNBP1ZfqW0ZKZeZccW6jl2CyAWhZlY+X3tgUme9PN8XmYEgrjcGF8G3coMuB4VmwQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HGRw3eMC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HGRw3eMC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgysm1lDpz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 12:19:23 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B12gQd348570;
	Fri, 11 Sep 2026 02:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ksJLDki+gOxvjijRL
	ZXeku5IUdICIJyG577Sdp4IWAU=; b=HGRw3eMC46TM1Ohs3FJpN9EeYVQKrNby6
	kcBSzI099JgWoP17W06kitPN5SH1WxxJ94nUuGHAQzUZQeMi871mq5Ik+9NAoSCf
	BRBlT1hwj2C3nrCdDqWuguQ+8YIrXjTmj2xZw8oTUJ4R9rGnZynJbVFi/2NwTixG
	u/FSLgMhFAsTQ6+oCjs/fsbTNxBY7s2K5EhtP2Rkl4/EIb7/Qq3o5OO8Tjz5uUJZ
	yViU0CrrIICTQ6lYUuGUOvHO9WHIyc6Ky5s2+Sb+vfbSKio0IcH+fdi+8NaEudRI
	pCF4PdEdaHeK4dCmUY6C0mdMthrM2JOAIogkG7YpugBrzJyIic7vw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8t0q5q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:19:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B159eL872154;
	Fri, 11 Sep 2026 02:19:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk3u38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:19:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B2JJJv6423192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 02:19:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2648F58055;
	Fri, 11 Sep 2026 02:19:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EDFF58059;
	Fri, 11 Sep 2026 02:19:18 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.103.123])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 02:19:18 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v9 6/9] scsi: ibmvfc: extend channel reg/dereg helpers for async sub-CRQ
Date: Thu, 10 Sep 2026 19:19:06 -0700
Message-ID: <20260911021910.1038128-7-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911021910.1038128-1-tyreld@linux.ibm.com>
References: <20260911021910.1038128-1-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfXyQixNceANK4Z
 j0wmaLh7tzI/eQHNLd7BYXfjmjO0b6KnA86ICXBos16DLDNoYOPqQ+1HYyyx5fwyPxkFFKiBPhS
 BbjUoKOpKdazFVzpCsKHvBSE7p/WlOA=
X-Proofpoint-ORIG-GUID: u5W2iSfyIuAOGOldxr47R09gbE3Nekqe
X-Proofpoint-GUID: u5W2iSfyIuAOGOldxr47R09gbE3Nekqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX0W4P6pYvXX+l
 HRCB8p4d6EsF0SJJ0hDHMq5x8lw0kwshFXyuCojnJQDdyAaHncG4nKbYRAo+/N7mUAt9MNuc7Uk
 Y41ANI3fb6LVOJytqTrGvX+7omDhz9lp91O/QyMd6acW+rp/A+20hvz6UfoKtIrlwzz2QCzfYoj
 GyAMu5CHXkN5RjymM9e8alIc8DQeQcAdHjwQKJIHOs0+TJA6acDL9LRmy0MLOet7idiIWvEnQEJ
 wQogYDdIcm/uli3AcMLNLiQGfs8zrH0SeKeYkPmQSJOC1OR3BxhTn6gjJs6NooTTYu5rga/9s+y
 5zlc4K9hfbl24avDB06sja6Dyl9gNT+/YBtmqD2OxORCJnGZGRg48Pnu8ECvFzyYtPAwEBobMMP
 17NXin+IOb9ygAwen+yJLfgexrHI9qK+tzvmLVT3sOinEll5/AhQdyxlXTAbe0pf6S1juOcJ1jL
 VZQJSrQrFYSz/JFZ8iA==
X-Authority-Analysis: v=2.4 cv=PIGaavqC c=1 sm=1 tr=0 ts=6aa36529 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=tu7rfeQ3xgwDIMifKtoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110024

From: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc_register_channel() and ibmvfc_deregister_channel() previously only
handled indexed sub-CRQ channels drawn from the channels->scrqs[] array.
The async sub-CRQ (vhost->async_sub_crq) had no registration path through
these helpers, requiring separate handling.

Extend both functions to accept a negative index as a sentinel value
signalling that the async sub-CRQ should be operated on instead of an
indexed scrq entry. When index < 0, the queue pointer is set to
&vhost->async_sub_crq, the IRQ is named "ibmvfc-<addr>-async", and the
handler is set to ibmvfc_interrupt_async_subq rather than the per-protocol
ibmvfc_interrupt_mq handler. hwq_id assignment is skipped for the async
queue since it has no meaningful hardware queue index.

Stopped marking ibmvfc_interrupt_async_subq as __maybe_unused.

Error messages in both paths are updated to distinguish async sub-CRQ
failures from indexed sub-CRQ failures. Kernel-doc headers are added to
both functions documenting the negative-index convention.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 93 ++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 553fca31cb3a..fa312a58471f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4420,7 +4420,7 @@ static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
  * @scrq_instance: async subq
  *
  **/
-static irqreturn_t __maybe_unused ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
+static irqreturn_t ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
 {
 	struct ibmvfc_queue *scrq = (struct ibmvfc_queue *)scrq_instance;
 
@@ -6811,13 +6811,29 @@ static int ibmvfc_init_crq(struct ibmvfc_host *vhost)
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
 {
 	struct device *dev = vhost->dev;
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct ibmvfc_queue *scrq = &channels->scrqs[index];
+	bool is_async = index < 0;
+	struct ibmvfc_queue *scrq = !is_async ? &channels->scrqs[index] : &vhost->async_sub_crq;
 	int rc = -ENOMEM;
 
 	ENTER;
@@ -6837,36 +6853,49 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 
 	if (!scrq->irq) {
 		rc = -EINVAL;
-		dev_err(dev, "Error mapping sub-crq[%d] irq\n", index);
+		if (!is_async)
+			dev_err(dev, "Error mapping sub-crq[%d] irq\n", index);
+		else
+			dev_err(dev, "Error mapping async sub-crq irq\n");
 		goto irq_failed;
 	}
 
-	switch (channels->protocol) {
-	case IBMVFC_PROTO_SCSI:
-		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-scsi%d",
-			 vdev->unit_address, index);
-		scrq->handler = ibmvfc_interrupt_mq;
-		break;
-	case IBMVFC_PROTO_NVME:
-		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-nvmf%d",
-			 vdev->unit_address, index);
-		scrq->handler = ibmvfc_interrupt_mq;
-		break;
-	default:
-		dev_err(dev, "Unknown channel protocol (%d)\n",
-			channels->protocol);
-		goto irq_failed;
+	if (!is_async) {
+		switch (channels->protocol) {
+		case IBMVFC_PROTO_SCSI:
+			snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-scsi%d",
+				 vdev->unit_address, index);
+			scrq->handler = ibmvfc_interrupt_mq;
+			break;
+		case IBMVFC_PROTO_NVME:
+			snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-nvmf%d",
+				 vdev->unit_address, index);
+			scrq->handler = ibmvfc_interrupt_mq;
+			break;
+		default:
+			dev_err(dev, "Unknown channel protocol (%d)\n",
+				channels->protocol);
+			goto irq_failed;
+		}
+	} else {
+		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-async",
+			 vdev->unit_address);
+		scrq->handler = ibmvfc_interrupt_async_subq;
 	}
 
 	rc = request_irq(scrq->irq, scrq->handler, 0, scrq->name, scrq);
 
 	if (rc) {
-		dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
+		if (!is_async)
+			dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
+		else
+			dev_err(dev, "Couldn't register async sub-crq irq\n");
 		irq_dispose_mapping(scrq->irq);
 		goto irq_failed;
 	}
 
-	scrq->hwq_id = index;
+	if (!is_async)
+		scrq->hwq_id = index;
 
 	LEAVE;
 	return 0;
@@ -6880,13 +6909,26 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
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
 {
 	struct device *dev = vhost->dev;
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct ibmvfc_queue *scrq = &channels->scrqs[index];
+	bool is_async = index < 0;
+	struct ibmvfc_queue *scrq = !is_async ? &channels->scrqs[index] : &vhost->async_sub_crq;
 	long rc;
 
 	ENTER;
@@ -6900,8 +6942,13 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 					scrq->cookie);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
 
-	if (rc)
-		dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n", index, rc);
+	if (rc) {
+		if (!is_async)
+			dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n",
+				index, rc);
+		else
+			dev_err(dev, "Failed to free async sub-crq: rc=%ld\n", rc);
+	}
 
 	/* Clean out the queue */
 	memset(scrq->msgs.crq, 0, PAGE_SIZE);
-- 
2.55.0


