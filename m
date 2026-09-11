Return-Path: <linuxppc-dev+bounces-27108-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB374C79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:49:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh3WQ2rydz2ywh;
	Fri, 11 Sep 2026 15:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789105730;
	cv=none; b=FxMFIRcn2GN5pXmSySlekWiM3rhaHzgb6XDvug1rmv66yV9e6RZyc1tm0+UVUa1nmxFtbg3HoOuxwJcGP9p0BN6afyO2qqp8qruF71+upwEvxd2Cghg20uDAnTi0iQv6rusrXsg1uHwao1EqDolDJYFSN7D6Jr9YVQoGmRKEvAzp2W1k45UkWWft5gBY216lo7UH7xvOZv+e7JF26cFJrss5ZTul5t9MUrAIve1Zx0738DbiD6RYEo83Zellb/nnl5EVHakAd9zVgUmN97f4kYVw4/cjyV1ZZUx+Yz1NNE3+jr4PjTuVoFTQyLqutYQxihklSL2ark6lmrcu/G2gRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789105730; c=relaxed/relaxed;
	bh=gQjnOVWar+06FhskkFF16z5SSEaTQAHdxSv6WMoTh7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORbxJJh8wi8rRGnG48LZ6pTemFVjPOCSUhAdvENZk/J8d1qlaP4d9QpiqR1t+m0sZ3NN6NBuf66lwyMaTbEyz39YlERjxAyjFLMegqzR7JiOz3gKxEF3X7pRRFKywWtchHWIdgiEJAYMmr6ginqSuEyz0WDBDRLzXfnrs1xN/At/6xKPpv/OFOAh5wD+BhM+PVnUR0Dgo3ZptY0DHo0HRfOzOdR0uDd/pHBlwvxJQha0ZVoWTjt/Fh7PRdNFdlHQL9KT4DxyjVzmJdxeYgHZxTm7Gf7Ad4KcWC3qMhjmbvmCA4sOzhcE9NYISwxmfX3EtQn+1jNtioTa5UszAemZZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K7Hvvlhj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K7Hvvlhj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh3WL6SPNz2yrH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:48:46 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B4VoNe3840229;
	Fri, 11 Sep 2026 05:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gQjnOVWar+06Fhskk
	FF16z5SSEaTQAHdxSv6WMoTh7w=; b=K7HvvlhjbPidot/cWLYBsE0ND8lW5avpm
	Ixfc+zyrzLGyYGF+0IU+1G6zZb6Rr9JKFKuQudFZWxMpCKK+RdU219Gg9PCuOx3A
	7PseqiZo/u8Buvue/EQspVVKA38IPb8UoeaibZArrkMEQTX8QwH6Ysr4GGJ4eGPu
	2REMV7APWKE7tVOcY4fEmvSyfQppTV1iJjvggcOQJciXZJgYYtJKw+A5rVk3VtQ2
	qJGnqbEwSx8CWk9oDS2t4Se2eNcMfFFUqtoIOoRUYoHoDrgDqhRD3ypZqVz0uB76
	GUKFsJOOsIIVyNrhumf7u6BZ0nPEEa0aOWzvFszQGrBOgPkP/QIhw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8q9g6h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 05:48:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B4K2H21076021;
	Fri, 11 Sep 2026 05:48:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk4j7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 05:48:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B5mfPU33096314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 05:48:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A9858051;
	Fri, 11 Sep 2026 05:48:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F1E5805F;
	Fri, 11 Sep 2026 05:48:41 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.103.123])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 05:48:41 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v10 7/9] scsi: ibmvfc: fix IRQ leak and guard deregister on channel reg failure
Date: Thu, 10 Sep 2026 22:48:30 -0700
Message-ID: <20260911054832.1311668-8-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911054832.1311668-1-tyreld@linux.ibm.com>
References: <20260911054832.1311668-1-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bCGSt3HNmsDIotuNP2T3OA9BvyHUOo9I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA3NCBTYWx0ZWRfX8QHSmrNpSJ6m
 kkdOGdV2L9WRikEAV+BHiO84KGDyVdaKv0cJHkEeL9ZZoy+fklZc6Wcn0MxVF7TZ1le/lqs7H5c
 Hm7TJjkTu5JVZNycwT258XZ2aPw28qY=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa3963b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=acainBHvso6FeXtkDgYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA3NCBTYWx0ZWRfX7y6sPU2x3hPc
 bOEKw4Opx/UjfTXYu0MwbkP7LhNIvDvDARs1ErK/eQU6UhjnUyA7g3i9dJTrIS3c7Cxpsb3bN4m
 gyeAcDlh/mnd9/GArf3CD3rBnbZtRFzDRtgshZtZFUgK7E8pQjGscgwjzlWN6CNbnSrFazRDNuj
 oHHNpiyVpFowp5Oxee7zKf4ValQa1Hg9YEy8H3Nhj+3xIb2d7xW6cPxwfyqHmkvhl4KDCPzPNmm
 OO8mSUwHqCZRnUJau1TJWWAMwnrvfW7LTwn8f6/6/2rHmnjVNoW/0+pka5K3WMCgx5mQzuNI1F8
 4L16Yq1naqss6AAOGRdAcH61+b7NibXXYZadAe4UdlJFoM+OmbPkVkOzG3FZwyd2sl90Xi5jTbY
 KwJS6PM7uwctAbXw17n3/RxXmMgKIASaGjtn7NQqKm5zKrxKFAUkWSzlUS333rJudBIazOsm69a
 ImvWtuAvg/WKf0tALUA==
X-Proofpoint-GUID: bCGSt3HNmsDIotuNP2T3OA9BvyHUOo9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110074

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
index a9cf1096e755..c78e221f182a 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6890,6 +6890,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 		else
 			dev_err(dev, "Couldn't register async sub-crq irq\n");
 		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
 		goto irq_failed;
 	}
 
@@ -6932,9 +6933,11 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 
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


