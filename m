Return-Path: <linuxppc-dev+bounces-27521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8FFC982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:10:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN55GJMz3bcy;
	Thu, 17 Sep 2026 09:09:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600181;
	cv=none; b=dnHUAy//Mjz7TK4iBL7o8K2q18bAQH5X5nxjhHpKXX8onK3kqEK7AyVpbyw4f/KmDBpA7U5xEA7cbRm/B0h+fD690Qy1SnlU2Q/GIuCAioM+eKtW5dyJZl0vz5kR+v2j1OTpGwTwN8eSnbT9c2N1UpvuIbV0YqRPR4HM6/d3jL+U3Jqv2mg4V5PCUqHB2E6mPxBALMmkeYZzD0DZPtIpANwHTfoo9wsstnnhzy6bPMUfijqeys41sGL7yze/+r90mUmtpzbS5VqZ+7GL02BTg+xfaTc4zpbV56dOFyTPtNNMI0zHGWRabmEMKMX86of3v9QPMthl7KibITXaiodpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600181; c=relaxed/relaxed;
	bh=C5onI7nGbbEzwmDVsNCVJsX5ON7EKqRDjrSLCbBoHVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brGkIqkUkWaQq/ythYKDJaQNCDbhD7rwswxxbZvn3OhM1YIU8ouMdPmkHXE+y+N+9sNtiSbgvKJWElZm+2F2xjj0Ik6MzUJmjTNWQTRAgt02nppdB77GONrYSMJSb6zkmiBcZHkHuxyFW2sUjgot6Y7lR7yZvng9mVudagCfN34KazylPxU/Cq8QmBmHZo5VF/bXv3q4vilXqJDOCKDwIOjC/kil/A8+ozLttt6aN80iXoYzZzoqF0sKiU3kvwHJVSexYBF0AtxeE/zNjXMafqIz1rdyboUUPQKV25ixZb+r79m5EL7s+H1d0DtjDP1jZbKcVtY/oists66Rdf/muA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AqldeH+T; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AqldeH+T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZN46618z3bbf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:40 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1Wdg045787;
	Wed, 16 Sep 2026 23:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C5onI7nGbbEzwmDVs
	NCVJsX5ON7EKqRDjrSLCbBoHVE=; b=AqldeH+TqBQoagZVYHvllwJoyYVqYWQRJ
	YuoIV9Uq9UKR/K1MK3tPosldQqRtCWEOaeHe1UNEexZbG05yy8f5vdYrpDDiK9dc
	bhhFCb+gL+8qKOxiatktKi7SIfD5XmhMxSIu7pq+1ihVTyijscwR0skGimXeTjQU
	FmSxyXaOMwe1aiyfNb7L0Jbe6eaVBDO1a1D/sywFXbpOTCkcZxoqjDaEqN+ZbDGO
	crvAxySdUfp/JanLCuyuB63LBhEVU3KjwcxxO6Jwkj20XQdSwWeQXW0uomg1Qhha
	FRyAViM2E5tw4g8+LDIee0d4GVCh1SNsTBeaDKtiTiFYHY1FiLpZg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6y11-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMtCeS1663520;
	Wed, 16 Sep 2026 23:09:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089rtj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9akm13501100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322D258056;
	Wed, 16 Sep 2026 23:09:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422F15804E;
	Wed, 16 Sep 2026 23:09:35 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:35 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 08/20] scsi: ibmvfc: fix inverted suppress-ABTS capability check in NVMe TMF path
Date: Wed, 16 Sep 2026 16:09:09 -0700
Message-ID: <20260916230921.2204729-9-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX3rYvCwDhSr65
 eP617f1qG7jUrikn0k6oVyxiZ8NyvOMrxfvqyDjN9S4qV+S111wOxlQzzaBmpY6IYCdNRXhYeL+
 UWuglgHcTOQwUbmgXJRM48aQKDWlQlY=
X-Proofpoint-ORIG-GUID: 4He5hSmTRCKvs3TusQyk7piSPT8JTVaD
X-Proofpoint-GUID: 4He5hSmTRCKvs3TusQyk7piSPT8JTVaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX7OVXFU60PpL7
 knRst2cwWrnba2LBw/nEPfuIUVvRzCiDMhKqXTkKLE7uCYAEjdfgL+2SrewKkIniXuI+AszwTqC
 idN+5FXAOqowOs4fcC9KHx8yhfHt8p47lgVNh4Hhh9micXwZfi/SKAMdJ0Ooi2Sl263AKZCPdbq
 3YY+z2Ng9w0QHJ+unuiEtBMUiEnml9Efl5Z/2Yoy1UIPwPlK28qDZGWp6bzPb8bNiSYBhIFOdxI
 CqbrOl+bmWKCDIW/0EfCs7OiyLAJDCiAH1KpTGvV4wsyeP9K7LfZE62Lj2leGwSfDEHPYZK/20O
 da1niZvDendo8Nu5hHhkjfLIS758OhqMpFcBHCnT1/yQ53NE6F9HAuwrkB389Yxauo9Rgv+3Nv2
 K3LOO+XZtBqPKe5l3tEO+9wTBymidKn5aw8+3CaTQ0YFLZgxRrHoOcGL4t23dJJGosvRoNTiXdB
 mqro/oQdsMHnMLtEc3Q==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab21b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4DjNXy2qQgjy61e-tjkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322

ibmvfc_nvme_setup_fcp_abort() sets the IBMVFC_TMF_SUPPRESS_ABTS flag
only when the adapter does NOT have the IBMVFC_CAN_SUPPRESS_ABTS
capability, which is the exact opposite of the intended behaviour.

Remove the erroneous '!' negation so the flag is set when the adapter
actually reports the capability, consistent with how the SCSI TMF path
in ibmvfc_cancel_all() handles the same check.

Fixes: 508e0371279894 ("ibmvfc: implement nvme-fc LS abort handling callback")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index ddd750f1cf33..7fdf27fbe7e7 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -184,7 +184,7 @@ static void ibmvfc_init_ls_abort(struct ibmvfc_event *evt, struct nvmefc_ls_req
 	tmf->common.opcode = cpu_to_be32(IBMVFC_NVMF_TMF_MAD);
 	tmf->common.length = cpu_to_be16(sizeof(*tmf));
 	if (vhost->state != IBMVFC_ACTIVE)
-		if (!ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPRESS_ABTS))
+		if (ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPRESS_ABTS))
 			tmf->flags = cpu_to_be32(IBMVFC_TMF_SUPPRESS_ABTS);
 	tmf->cancel_key = cpu_to_be32((u64)abt_evt);
 	tmf->my_cancel_key = cpu_to_be32((u64)evt);
-- 
2.55.0


