Return-Path: <linuxppc-dev+bounces-27065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B1AC88E40
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 02:09:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgydG4g9qz2yyx;
	Fri, 11 Sep 2026 12:08:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789092514;
	cv=none; b=IRLuFJytA40Z/1X4zPwHXSK08/LJdrW8QI4NbXfWfd/r2rKxxBmLV28PO9kAbQJaFabA2nC+zDp3Oo8L0Ns8Q3F59nwzvLBebgxEFO3MiVYzuJ1/n1USJfnSIxdtTouJ6PQ+HMy19D9rh9ZrFLBYvzlJVZSFE/Mgeia/b1LqshKj75203km5ZhzJApxSlL170FlHnvprkf58d6Q08aPKpfZCY/b7YHfIEiiLOVTo3QyPeIycfmzBxD8crtWRawdbBApKMR1/phNKCiMhC1VltKqwYj55/oa2LXwRUWuqW1Nsq4aN/V3Q83aPvaX9lCztIqYZyRQw2Erx3Trs5Qf3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789092514; c=relaxed/relaxed;
	bh=ksJLDki+gOxvjijRLZXeku5IUdICIJyG577Sdp4IWAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqRtQRmrVgOS3YbHbqmCOGVgE84BnL+yevJM1nRU6Hs3uB4o7BWtxC8exGZ5Cmai2QeYlg9iWJfds4kwntE10CHPvpn7TjuXrf4s09pRJg0zLW5Zb7VxmNjPvnAYF43PubCW/mgOsROuawBi2aMfdjjnXB9WcGeV65WpUKCZeMeKtrrfpKkOAxROTwenoV02GjPX48P6L7OSxfqVl7ltJh715NXkmL092LOsrmE8MBtZrvWqwTWGn37uWVKsB7Qqwg8MhWXX8TrfUwgBYWzaIaTlBMOy+bym/6bcYAlsGKzbr/Pf5KX3AViO+qiLieiNfu4un318UiEd+s4PVFcGqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GrvZisDh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GrvZisDh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgyd82H7mz2yrt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 12:08:27 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B13SwI179785;
	Fri, 11 Sep 2026 02:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ksJLDki+gOxvjijRL
	ZXeku5IUdICIJyG577Sdp4IWAU=; b=GrvZisDhr5bVSbd1fSbCJl+Fq6vn/t8AM
	lH1366k70zpSMCXNmN9RFRn78+gRmlu7L8IIYPRdsHt3MhL6SGr23riIWz43D+nS
	uTsUDzoUSbRrxp1m49KbkB3s8k6QfhiLe8c4C4kiFQv9hUNFeLjm+tBhBbxamQ0y
	cWhZ52m1JhjGybLCxGPCCCNN6PhFYZ/0Q7H0A79BvlqEZZ24ZyosDaCi1csyh17x
	to54FggoKpaHRO87J8b82KvW96/aU2wMPdiJkcGpR9HACwGsUT5BisSFVnHkUF6k
	BiiMKKV/F3WEuXX6pK66nGxBi464I85nGFW27X49MPiHydG6nFT9Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8s8nsu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:08:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B155KR855203;
	Fri, 11 Sep 2026 02:08:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrbsgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:08:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B28M5v25231914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 02:08:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E4BC58063;
	Fri, 11 Sep 2026 02:08:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A79FB58052;
	Fri, 11 Sep 2026 02:08:21 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.103.123])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 02:08:21 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v9 6/9] scsi: ibmvfc: extend channel reg/dereg helpers for async sub-CRQ
Date: Thu, 10 Sep 2026 19:08:12 -0700
Message-ID: <20260911020817.1033789-6-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
References: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: P11WDrrFea3CBXyPM80IUXnn8uVXvuc2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX7o647i/rNrRG
 NKJMHRsuCX4EHOxWbmGJTB39qsEOX9QU7Qkt19hmfM4tJRk2XbfOCpMeie8VXPd/84JGSWk25z4
 Jmllq/VMUEx9B8G8ro/mblVmkSTF9CEvu+RE+3I05uehUWndP2IKWByjK59KV1TrYxsZbicjeEj
 gjnAfdDOecaRO/UnPj7OqoL7A9NdJ4flxv3FyPPW1dX7D+BwbfLob4/gj+ZzgRU6T9EsatnlJ8A
 Gmoz1LTH/nSRFp4fK2/47s6PaTK3rvLg5OcVVqL7qTPGlL6PfDk1qM9TmLaOXKYhmaW9ekAL/Rq
 zg/LgNk20ti/DBiLy09LL+BLKoqqAwxvjGwur+bg8e1oqR0FQqP0B3imYbZn3+jHpkxtrJ26Qhm
 dQ0tN4Rpx3z/9YwQAE7cLFCK37fOkla9V+ZOszX9avHbaxMZFJ/p/4/yGoI4Hbo4tZFiv7ZnsGJ
 oU0Tt0/krp+R+98YaYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX120vfUIEYVJd
 USPaoHfFU6NbJWtFHeF8wHyq0T/stlsVQfSamTwrlpLQoUdsuXaCpUSG6beUjAnSKTRnIPFbZAi
 Gf2DHyNkNrR5jGRaP85Pp/+wIDb7NlA=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa36298 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=tu7rfeQ3xgwDIMifKtoA:9
X-Proofpoint-GUID: P11WDrrFea3CBXyPM80IUXnn8uVXvuc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
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


