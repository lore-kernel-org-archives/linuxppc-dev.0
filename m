Return-Path: <linuxppc-dev+bounces-27516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF15AC982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:09:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN13KkVz30V6;
	Thu, 17 Sep 2026 09:09:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600177;
	cv=none; b=ULNxp4DOKT9rObt9/2WMPqZtOM1ohOxPzpiddBMcvzb/u8X+KM52lkje4oOqmyAOXjv3f0C3BMNJsr1LToFLmObbCmuGs1ZvbAzzcLDa2sBGmJwjoNqWVpFu47r1LY8mYzDNGQFed4gatby2z8jmjo23YjOOJu6Z8/kJVcALOErGhTcGRTCrFjVEq25PWJBXHq2ArYRKeOuCvYlVWQ/7nneEvY5TeLBh8W/YUx3LtJazTk3fcz+yYvR7N8WypTRIHz/g203SofqvumPyJej2ubyD30NFfGJHvBhqVC6qj9rKVonQJpFUcXchYjX0oCf07JsOe/rpMjVEuBp5180KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600177; c=relaxed/relaxed;
	bh=Xb1t6UG59AexkF0FBCbVFa0p2vpQQ6dGGidUk5u8CfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQvTmTTK52dmiJde7nIUwnq1WKMLt6t715daX89mq83J8gSSNprouENeFOkI0hjCiUxtl+ILtXvQ3lC/+eTMCf9+h+PGV4VDTKp116IhBj9s8O4MyDp9tDTyy9TR3APFZ+gawiFbN3DakhHNLYnsh7vi1oZf7sR/HKZ2t2GKOFX5LWO7edWPn7pR2uzGMW0qgVJW3Tec4YcIANTDiIQ3Ll9W58RaQXek2K1CvbNdeaSMvVPdfWcigj0fzD09eYxE8hqRmFT6f0KoLwKB/DSybP9qECbHjVyBuHCVgx9BisR0RSYWrU5STSTU/WQFh4jqiIEFFmF6dpA1xP5le+ustA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5becn6m; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s5becn6m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZN03GLDz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:35 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1aj1045837;
	Wed, 16 Sep 2026 23:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xb1t6UG59AexkF0FB
	CbVFa0p2vpQQ6dGGidUk5u8CfA=; b=s5becn6mmZ9zLlhonXMWDvKlqBe+U5s/k
	bJSTx5L36h3lY9WuAAiGo+GsDkLXl6S1BZ/8Anha+UTJJwZZ2xNym4khpNlhIG0s
	wLXMaCW7ml8H3xOeXAjIuLfwOasbrmqxrhkh0Nj71vaASoFGEih/PV5PNlpWapnb
	i19SEVj3osQovVFGHBKg6+QyuivISpPQCl/HrZO3rxJ/d1ZTnxBuQjIAuynR9p94
	CAu4JFFHJX9thgrE/KpWWVKD0jEtxIL5KXAhRWrSO2nEN4d5MdoV8fhzYKkHUbJP
	jDJVKIDUWeIi7J7Yvak6+veRWxKgd146B97IuGDI1810ppMaUp5uA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6y0u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMl8Sx1699706;
	Wed, 16 Sep 2026 23:09:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vguf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9Uff28246642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A46258054;
	Wed, 16 Sep 2026 23:09:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A83C35804E;
	Wed, 16 Sep 2026 23:09:29 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:29 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 03/20] scsi: ibmvfc: complete NVMe FCP requests on H_CLOSED send failure
Date: Wed, 16 Sep 2026 16:09:04 -0700
Message-ID: <20260916230921.2204729-4-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916230921.2204729-1-tyreld@linux.ibm.com>
References: <20260916230921.2204729-1-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXxJeBNGdwgnPt
 LmZaMZXizFRsEDdatJgXKbDeTpImrd7IdjCOf2pGyArm23Y+s6JiZoCp0oLqoZiS6ye99XSItLM
 b9HsC1amDgeTYSDEbvv/OTVsAITkc2U=
X-Proofpoint-ORIG-GUID: 1or1IyOl_UzzAxE-ZeuXr5TjGiyrH_dY
X-Proofpoint-GUID: 1or1IyOl_UzzAxE-ZeuXr5TjGiyrH_dY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX1rRFGjQJS4ki
 fFMH+0YwllavOlr4L/L4WgkPS+qXXIA/2Rs0yIPjQJOF5eP5ej3yUxXz5zv7SiLzlljHT4XkrNY
 50ysXwKPdtElIypngIzkNX7viSHnBAzIn9zWPuDwJ+AKi98VFPXuZ4CwF6OUVlcS6Uf1wsSkeNl
 YdzDDqU5aNBKjN3LtJs4ELN66QBfUty0F86cTT5HkiUsLYsR2LP6yeYgDoUfeYQJKEAf7raJFs6
 xhFkwHDvDCpg2EN1LBQa4+EuI2GRGlZbJ94CWvouaonznMK/pzwjcjVkvNc6NjLgY6jH91tvdiL
 QCula2x+D6o7cYnwTo680fWROE+qRweipequhZNg8NUEX9Afx+YHh69ieOXjdE7uXEJaz1vLfHv
 B6AYu+uvfJdKNmHXTAf/UzimUuqofCh86abEr0gijkQwv9XhFg44ezhvuKKRihGu10op/qysPt4
 gz81gjFRc+J43bfiXsw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab21ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=t66Ke_tTvvCKYZqM8SYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322

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
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 6c243b2a84d7..26a73db66254 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1845,6 +1845,10 @@ int ibmvfc_send_event(struct ibmvfc_event *evt,
 				dev_warn(vhost->dev, "Send warning. Receive queue closed, will retry.\n");
 			if (evt->cmnd)
 				scsi_dma_unmap(evt->cmnd);
+			else if (evt->fcp_req) {
+				evt->fcp_req->status = -EBUSY;
+				evt->fcp_req->done(evt->fcp_req);
+			}
 			ibmvfc_free_event(evt);
 			return SCSI_MLQUEUE_HOST_BUSY;
 		}
-- 
2.55.0


