Return-Path: <linuxppc-dev+bounces-27761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8270C982DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 01:33:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmsSw6xNsz3cLH;
	Sat, 19 Sep 2026 11:33:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789781600;
	cv=none; b=NKIhZFJ9prRGBwvwK0fC3OuhBm/9g5fOrhJDrQVI+eqrx3BgT5FcGLpLd70sDbA+pyHS3CbKan3FBYPREHSMANhbrQQxd+zt5jJiIh6TF++FtQ9tYwUXP/o0vWoL2YnesIHZTCN1QR2mYriIkWb49rrA1zP9tyhJenutnMVznrkbwzkOgiPiLDRXFlfaw690MyHw9VaovhgHCb69Q+v+BQc/rnkZPJ8DPRz1hP7WA13bJLIKFRAi5L+Vx3sHFZPyofrmDm+mGSGLjgVivLm2WhrJzkh9T4KadpWyVNgItpmwM8dLh7c12t4AimKzoWvAL2l0WugFVAXnuubUne2ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789781600; c=relaxed/relaxed;
	bh=8QENcYT+uY2y/J7aduxzfKAjqXBVUFJpBRX5/9wMenY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0qkLjnkkVfKYpXsZEyp72c+1d3tm2pXL2x2FfP7Bsj+rZNIbKw93BD4UjFptylNyKNmbHGKuiq0Xy1FXaXY+RHRaeo/HvPj/X5UrquL5A4FyLQyAfcxIMaDt8CL0FBhs3uAVG0skEDDauCOMGuAW5pz668QdWa+u5VOdq0yFsVgLAODJLCVBx2YXu/F+zmYd5Qw+OAgbL4DPUTKchVGSt3BOQCFCAaJkg/3PuAxZJo4+nHQomwouoHRbESlfcR0DBXNTCQM6dTt4+DSJyDpmQ14CHML8qtgXcilV2g1sP5KEBIMbOrC7YzO40tqMn9HST6VNaxxCnXOabNNdim2pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n6zzwntB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n6zzwntB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmsSs73FNz3bqx
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 11:33:17 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J01eaj2680782;
	Sat, 19 Sep 2026 01:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8QENcYT+uY2y/J7ad
	uxzfKAjqXBVUFJpBRX5/9wMenY=; b=n6zzwntBiD6pXj6GUU2+VqSEsxJhod2BQ
	KeiDrNY/L3qN8trwt8TmaQABBK9+8dDXlO0qwmNF21CMReBD1nn9UtVvoTpr20wC
	La1G8WDT+0iwovNxIXB24By0luRA96Vdm8lGDbW9G5ABdJ/Vjn2oj/JwmQAr9ZHF
	25HoxLAiqbWRYO8hc41350rTtcSerN57quALNa/RDGPMGwAKCGc+ArJCZmaun1AF
	5r2vGqYmICBZGxLhXkhGeiBk298634TJn78231vvSnIbH2refjt0JK5G+eeyeQjh
	XUNsPF2umlVuQ8D/mqRr7TSMoiqXOgePEtssYoiyCf4ZFJsGvCVCg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5k1tt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J1UJoP2574292;
	Sat, 19 Sep 2026 01:33:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gsgssg069-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 01:33:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J1XDc415139554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 01:33:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E1FD58051;
	Sat, 19 Sep 2026 01:33:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB7B5805A;
	Sat, 19 Sep 2026 01:33:12 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.101.145])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Sep 2026 01:33:12 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 03/20] scsi: ibmvfc: complete NVMe FCP requests on H_CLOSED send failure
Date: Fri, 18 Sep 2026 18:32:49 -0700
Message-ID: <20260919013306.2948028-4-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919013306.2948028-1-tyreld@linux.ibm.com>
References: <20260919013306.2948028-1-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: yprec2gKLBpzQl3BGWbMC07fqHoIGzVF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX+Ex4CL9w4Sxn
 5yeWMRFuaPyA51pFoWmCchGSB2wltWDlmGRz7swg0ikl0DsrEuR8NowSAfkVTFPLsHUCVD72ndX
 /k90Xc9zAvgbR8y4QhwWXMfOdku8xt0=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aade65a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=FURy-cA78QglurSbi6AA:9
X-Proofpoint-ORIG-GUID: yprec2gKLBpzQl3BGWbMC07fqHoIGzVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAxOCBTYWx0ZWRfX69AvVsZNMzxc
 zqIq4wpa8keVzxUjGCMlM39U8Epl4Pgjn4cxHR46LQ7Vrv/MDks31028MgYqlI1HrNcs20m4Sb1
 o0x0qVRH75lyVT4R8Bx2fAVMXeI5OVQ4FiY+oz4zO6eZRs9XW5sqAuOIZGwDEXcmjwbQRj5gl9f
 vibyqmAXxIuoMa14yFewA/cP3/iNYHUSQ1xz/ExWWfOC+YyddMie2stQLqUPE9CQR2LRkajs1d6
 xqkNsmBKQsZ6PhopaJGG7R05335qyFlYu/D31t+ccrFZfP1RaUh60gHR/kdTHsyi7iuEhoQaew2
 5kmbUgoAt79GsegLLXdHuB4lEW1qihsqpoSwhvbxjIngoOMEQQ5ikuLXz3qI9nio6U1VTfxqtc/
 luQV/Az1WJWylxQS4kINbAX/V6OkfH3ruN2aNFa+a5TwRyWQufCTKqK9CsU2z3bo/DzAvYXnXvC
 yJYFTa6bjb6RgUrfBYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190018

When ibmvfc_send_event() returns H_CLOSED the event is freed without
notifying the NVMe-FC transport. The caller ibmvfc_nvme_fcp_io() returns
SCSI_MLQUEUE_HOST_BUSY back to the transport, which is a SCSI midlayer
concept the NVMe-FC transport does not interpret. The result is that the
NVMe-FC transport is left waiting on a request that was silently dropped,
causing the I/O to hang permanently.

Fix this by calling fcp_req->done() with a -EBUSY status before freeing
the event in the H_CLOSED path, consistent with how other FC-NVMe LLDDs
(e.g. lpfc) signal a retryable transport-level failure to the NVMe-FC
transport.

Fixes: 73c13e30c56f ("scsi: ibmvfc: implement nvme-fc IO command submission callback")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 9ed6522c2e9e..08dd897b8e64 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -367,8 +367,12 @@ static int ibmvfc_nvme_fcp_io(struct nvme_fc_local_port *lport,
 
 	vfc_cmd->correlation = cpu_to_be64((u64)evt);
 
-	if (likely(!(rc = ibmvfc_nvme_map_sg_data(fcp_req, evt, vfc_cmd))))
-		return ibmvfc_send_event(evt, vhost, 0);
+	if (likely(!(rc = ibmvfc_nvme_map_sg_data(fcp_req, evt, vfc_cmd)))) {
+		rc = ibmvfc_send_event(evt, vhost, 0);
+		if (rc)
+			return -EBUSY;
+		return 0;
+	}
 
 	ibmvfc_free_event(evt);
 
-- 
2.55.0


