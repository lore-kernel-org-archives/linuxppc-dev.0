Return-Path: <linuxppc-dev+bounces-28153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEEDC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 04:48:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrdWJ6W4Nz30Vm;
	Fri, 25 Sep 2026 14:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790311708;
	cv=none; b=TX8xx3f1JOiQa7P9QuQ5+7Dlmpp2zlUULt01l3SrvsFtmlQqhgbCnTCpQ9etlktsTppJRKPQwdifeHvIvndcwU9TEo4TWVcN5/h2QyFdEJqAbcjTzQtrlKCV+zOqE9BKgczTMS4d4zLDqZTOX1uwVdEzvHUq+PjHjCjJYwY0E4268nT9lnwX28hcq2jWz5taz8susL+zJmqF7OfuGHsMB9mNdd/ZwpFbQJde9GZHazDIXU+358D8NVc6addJheTYMBxfF4ECEup0HRLCxkbGYoqmkEFflqAa40/8PJWsMF21mbkPBxeU+pRiLzRVMIdgE7naQFqptVPBRDjGgtfObw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790311708; c=relaxed/relaxed;
	bh=fR0+7jE6kMlV3eplYtArXSLtg09Ia45aSRhA6aj8evI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1tV+yffjc6IJBle3qiVIkb8PM2iTDLLLirvmMJ8QjSuTNUM2YDjBUrcflNv7OZCxMUvfMzdk7fv4UAf+fM4UEAGU6G+Ax/3jfgmdvXxyUMpCFiyekscoIN0BfIyYo7H6DFl26+KB5H1zASZdO8dhgFiOGKr59SerCYFnWCLw3sbiT2E14JKCT9fzTyjovU2iIur+4OAGgBoWc6mDk6AMhlC+LMEArp8TjkQ/XcmbNJk+YZ+DYIsbeCPosvbjAYe3mzPYcV2XRAgzAwb462GpqZXB/ZdU+UBKG7ZrX+QpRmybQW1WzQS0osxxLIFi4+yYmX+pwidk7KSfv7Pwo1u6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jzFMXd84; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jzFMXd84;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrdWH5fFZz30V1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 14:48:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aZbE3084274;
	Fri, 25 Sep 2026 04:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fR0+7jE6kMlV3eplY
	tArXSLtg09Ia45aSRhA6aj8evI=; b=jzFMXd84kVhSrogi0kzXSJu1rVfmYKkf7
	fuqJ5PFvJjNhRUFbtaRLHXeuJaSpv3jshYga45GyBDsEIdXJKmiIow5o9WAm8LZc
	onMTMxhnd1Y2JAaOFQ4yuCr8dYfCFGkJVnrko27BnrmkM7NmbBzTtN0Uq4bkDREN
	/5UBFUNJODCPRkr3TZSoOvCdh8p1YB8vzyjRlFoT2Tc5VEKzqcNPG1RFJ7IM1veb
	WewHUY5c/moZYVzd0LEuAm7VP7fsUxa1ylDFAIso+WODaKGlwRqU1HlNPadnftrF
	kJEWnXVb6akqcMQvbT2gxQ/I2/U8hbXlVUmPIR4l7g11oKsqnO4iA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqv81u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lYHl3288207;
	Fri, 25 Sep 2026 04:48:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe2125p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P4mMBs29295284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 04:48:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3251D5805C;
	Fri, 25 Sep 2026 04:48:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F7A58051;
	Fri, 25 Sep 2026 04:48:21 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.142.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 04:48:21 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v11 02/11] scsi: ibmvfc: fix potential clobbering of rc after failed irq setup
Date: Thu, 24 Sep 2026 21:48:51 -0700
Message-ID: <20260925044900.414340-3-tyreld@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab5fd17 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=MVjHE8Z1wCOhovhPjBEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfXwWVI9nSgrV3R
 ybKAy0VJX/jcdDMloxn+215SzgeBXO8KlYWcV9xxranCeZEIuaQfX3ShUstdSnGRmxHFt/jJfJ+
 5cUGO6F3Bidph7JfaViqmSwLHGdENXAsVYw9R0qldCHjAmdOTPRQBtp8TwfJwQRBxT6kEqe1qRn
 8jy3aEW12OnE8Zdrkti1S5Kys1/qB0MGWlWu+o1E78GY0FjdzJNGLhFuggGRraJ2AC0y/F05wmh
 nOOOm4PziIcr8xEjVtCg8T0rfk9Vc4Q531tJtUT3gNJou8s59vo/MuKV3KzWBlHk+OuHKLlCRKh
 Fs5Fdf+Stt+eleKo63XACnYL3xz2rvVzgsGbAQJO7u0jMbv/udyvaJG2goFB4ma6YSaT7c+t3P9
 HRhTmq+buq/+/24x/BNbQKd74WyQyxJdwmWHf+OqAJYL21onPWPvqKxmQjlWcgKbj72yD+Qn1Tg
 GQ9ZDbkk3Oih3k07ZMQ==
X-Proofpoint-ORIG-GUID: LVSMEdt15z1Tlt6eAMsZnh3JHMy4uIId
X-Proofpoint-GUID: LVSMEdt15z1Tlt6eAMsZnh3JHMy4uIId
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfX0fUEWCiLILzj
 dMZBfoY1FxjuZrwZKCjvkyuUwgyHbPDaJjSOAY1CQA7rvkePz2+59uks+cRD93/6WrOgl2fubqK
 5yWQypd2mcUSp0p/BHIEEPcD7gVGYEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250018

Fix a variable-shadowing bug in ibmvfc_register_channel() where the
irq_failed cleanup loop reused rc for the H_FREE_SUB_CRQ hcall result,
clobbering the error code returned to the caller.

Introduce hcall_rc for the cleanup loop instead.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index c4dc48ef1ec8..17c49a0ed4f4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6392,6 +6392,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	struct vio_dev *vdev = to_vio_dev(dev);
 	struct ibmvfc_queue *scrq = &channels->scrqs[index];
 	int rc = -ENOMEM;
+	int hcall_rc;
 
 	ENTER;
 
@@ -6447,8 +6448,8 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 
 irq_failed:
 	do {
-		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
-	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
+		hcall_rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
+	} while (hcall_rc == H_BUSY || H_IS_LONG_BUSY(hcall_rc));
 reg_failed:
 	LEAVE;
 	return rc;
-- 
2.55.0


