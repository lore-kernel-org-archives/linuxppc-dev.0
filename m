Return-Path: <linuxppc-dev+bounces-27076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CB7C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 02:19:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgysr3Z2Zz2yxP;
	Fri, 11 Sep 2026 12:19:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789093168;
	cv=none; b=DTN6LdyrE4S5EztqI2GlJaTpujuAdlZVEwaL8VjDjCqWJIDzs9jutDMgBIMkwLnCSDNl9DNBOKloyffFZfntUTGmzWZqmidqCGNabmPJvxE3TeK9kweTND4X2DeHomJL/IF6SYdlE5QC0KV/VBRBgdYF9L+BClriikcg4SmUJzY/B8k9dl/i8mKDBYVZ9oRNl0CK29R8uRjssIwgV0FhaJxZq5meUwRId1rO6byPp7+rYBciNbZATaqi5acIDsuTCtGmHteyypCmxZRPPs3HEEU1k1bTNukG0CTReLYV3OdjvoLx2vDz4K9J6pxpoCB6JEDWHs0wtYauobuYF8VJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789093168; c=relaxed/relaxed;
	bh=S0CHDiBfIIn8Lz/9ul9S7S1oBS76OTnFD8iyF+QdJDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3Ay4UioxlvSgCVj/sv4x4xyCFc3U8ePcgKD2+A22YM3Kelm+ja7Vh1vS43uH7bbwzhrESgoE3P8akmvfkxTYyPNYxH9f/mc8R8qbMJMFfFztTqLYB3XqLsV83KxI8PqmXdMIhebF7y/8OakU4wEJAgdpHL7OtzhzT7jRyW0aMYIQOwkwLE8vTSaixPaljg9hRGAr4uX+8oX/Jxeg0fJwS+pTIyKPlqtNBM2YNt1vDNUFL5b+l4ix00I54f6YotdVVKcr/O9nfmncLc/w4nd/IDVTTcLN0s9qIhgKIkJou1G/EIoLUHwE38N78br9ppLuUsUPpm1r/3TbJCJ9rNiMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W829eATP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W829eATP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgysn3B3rz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 12:19:25 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B12JKi311148;
	Fri, 11 Sep 2026 02:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S0CHDiBfIIn8Lz/9u
	l9S7S1oBS76OTnFD8iyF+QdJDU=; b=W829eATP3xR4KffzF+ZuvgaPnPBZc9Qrz
	R0bJDCA9hKdJWkf5o7GTIA/UFUcUcEFheToXp3C8mwxb6jhsudLo16VNJuDE0SKN
	/doLOk4P+bL96P/Ocmnb/lP3ARu0HlwcqBQUs5JSi6+/FZE9l/HiZKx/rme4i4Ot
	8nxxAinERyZ4qOAOsoWeZNnuN0EX8vtUPqaAX7869DnBulQ+cntWNe7bCsh8ip+Z
	LKtl1CMhT1mXvp0X/aegdANQTKVn07tQex3uQ3GAzuXM4O0kSZtJRPk91fMpgEO5
	oQoTTJMXivWZ0zYCOp1X9JbRtTuEwE9MHIpMy75r/vGXokOW7buMA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8prtbt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:19:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B15LLD872408;
	Fri, 11 Sep 2026 02:19:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk3u3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 02:19:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B2JK9c60948922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 02:19:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5523858065;
	Fri, 11 Sep 2026 02:19:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51A7158059;
	Fri, 11 Sep 2026 02:19:19 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.103.123])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 02:19:19 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v9 7/9] scsi: ibmvfc: fix IRQ leak and guard deregister on channel reg failure
Date: Thu, 10 Sep 2026 19:19:07 -0700
Message-ID: <20260911021910.1038128-8-tyreld@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa3652a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=acainBHvso6FeXtkDgYA:9
X-Proofpoint-ORIG-GUID: EbBCu-IQjTh674Hirg-pcEkU3xbQTUOa
X-Proofpoint-GUID: EbBCu-IQjTh674Hirg-pcEkU3xbQTUOa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX3KIkdqhrwPMF
 ONptEwc0zWFvVUK3Sjc2Ib4UOESSQAxS0ktuTPPJYk8kyRdqwVc1XOrEN9xPzkzucsMts6vUYU1
 fCzWRR6Hi6SALhYQsXBpef+vNG8oru4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAyNCBTYWx0ZWRfX1NnCzC8uH1fs
 RegbpEVXKEy3x1opRJrFT45T2xukgTVtGbLn99Q5AlkyuhL7vUKvIoQtBeWHydoGtmA6euV7oI3
 W0mgjurc2Iohtz+/ih915jbG8dtBGQ0HgIkYP2QdCGq1T7PYWjY7+7oLQaV8SyRuT2+y52kjyaQ
 88r9tQ19hN7NqLaEbcmmDQ+nRpP9q9MRmx/iUxVoJwCSh2kSBg2/A4XBpgZciZh9z7gjopu3Bnx
 tTjL2oBXm+6B6snUunyqkjBuKE5NWa5dBFs4sjlN/V60Q9IKLZDbaQM3nPN85D92GXyAkEelnoZ
 wnkLmqdi8aYS1RoHpDnNHWARe9RRY3DAdCUgUtXh1DgUxb7kdYNM9M9Vw1TNzDXYJi640wxwC9u
 q18lQ1HCxL1kbui1rKM+C2B5dWLRdBPfjDYdSRoHQKtsvgU5r2VHSdvTYaGmhuHcF/OOGrS2Wo3
 7TmeoR3bS7W2CDdb6WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110024

From: Dave Marquardt <davemarq@linux.ibm.com>

If request_irq() fails during ibmvfc_register_channel(), the error path
disposes of the IRQ mapping via irq_dispose_mapping() but leaves scrq->irq
populated with the stale virq number. A subsequent call to
ibmvfc_deregister_channel() during teardown or reset cleanup then
unconditionally invokes free_irq() and irq_dispose_mapping() on the stale
IRQ descriptor, triggering kernel warnings.

Fix this by:
1. Explicitly setting scrq->irq to 0 after irq_dispose_mapping() in the
   ibmvfc_register_channel() error path.
2. Guarding free_irq() and irq_dispose_mapping() with a check for scrq->irq
   in ibmvfc_deregister_channel() so unmapped or unregistered queues are
   safely skipped.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index fa312a58471f..8eeb125ee13b 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6891,6 +6891,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 		else
 			dev_err(dev, "Couldn't register async sub-crq irq\n");
 		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
 		goto irq_failed;
 	}
 
@@ -6933,9 +6934,11 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 
 	ENTER;
 
-	free_irq(scrq->irq, scrq);
-	irq_dispose_mapping(scrq->irq);
-	scrq->irq = 0;
+	if (scrq->irq) {
+		free_irq(scrq->irq, scrq);
+		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
+	}
 
 	do {
 		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address,
-- 
2.55.0


