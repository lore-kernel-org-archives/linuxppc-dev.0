Return-Path: <linuxppc-dev+bounces-27519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4448AC982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:10:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN36HRpz3bQq;
	Thu, 17 Sep 2026 09:09:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600179;
	cv=none; b=WP3tkT9Uec6Sf671VLdCvRjemBxOazrW5ieOoenwci8FvhwzujNzk3cczV+R3SMWzptDtIRsiPvIUvQGJ9TKXdx8GwH8SUvBr1Nr5zHGAsIUGoUmNfJQkQiShYEGEwUFEDYreC6v0NWCZpWBI3aoh/8ZYUusLp9EodIakX07QwUncpttDuUjRGBIQijecTWj5E3THuHNCxCRSPMtvtmPcfw/2MhRT0gxfJ6nV3MZoCYgFQ0cNNnyoBocVByEOS7tdAHacKwzKz3l4wM45ClgtpR8QthkOwHNiWf4KC1swjpIRR+fPpXi9zYGDB4q2HC/kYW9/aV4zA+f/rDxajmkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600179; c=relaxed/relaxed;
	bh=o1CfTnt7tCAhaHJI/WnTpzZU6etw47JbmZnc24rhFcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGv5yM81rdQ4t+ury0wa1oC19mlqVr0J9XuXrsixuAaW/ftjEEOZOvk5DvHOzjCCLElBe0BDtvO2EaiAj8PumEXEuh+gWl8bioKZ5SfDvpzVa8DpL8YsFAdv1bcGYzp9ieAUiE5tT2fNYzrj/m7QHje0X8N0keSEuPqh285jFBLZc8qZyX2zWkdB5RZFspIGlvDkC/9qGbAUaOnHscZ0ItfjqrA6BqSw1d78iXPClRa8AUZVjL3dc/ZwJp4H90pFYVmNUrVryHdknP6H6I1GJ+BYeabgBvVYJ8mXNPeOSXSrwywPhPdqdbJnfDE5KVerDaLpGhAaUbzPXLFmhHFM5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MNgYltOo; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MNgYltOo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZN30VBHz30Wh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:38 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1lfO018176;
	Wed, 16 Sep 2026 23:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o1CfTnt7tCAhaHJI/
	WnTpzZU6etw47JbmZnc24rhFcw=; b=MNgYltOowVX3/aRo/gl3ZZ3w+UI8btlse
	ncJZozvCyZAW3DmD50f8nPrDL13VRwcjX58qKyZdmet4EIHym5ffFBFBQ+WQcwS6
	+N5G6+GmUZTIZPCvrq80v9n0U6/PIm27i1Fn1q5tILdqz+h6SuoGExpQUeom1NTP
	spVtNDvu4+0doyWRswFUddD2xvkH0gsBic9LtG0aGt2aNKQdXGHorCni6wgY6pfb
	m7PHo5OQUuTnWBlQOCyMxRT35zNHaiOr/fP0LnaGSlK+wdkj08uCs0QRYrmYnpxk
	eqf26BtTOhrdnpMZpUbBa97rH2wS4BxuXt0YtAT9Rea8XcIqpTSvg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf57dx6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMrtML2599742;
	Wed, 16 Sep 2026 23:09:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d9e8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9Yq928770900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86FE5804E;
	Wed, 16 Sep 2026 23:09:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0847C58054;
	Wed, 16 Sep 2026 23:09:33 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:32 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 06/20] scsi: ibmvfc: fix uninitialized shwqs in ibmvfc_purge_requests()
Date: Wed, 16 Sep 2026 16:09:07 -0700
Message-ID: <20260916230921.2204729-7-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: vKMv2fcnSYksN2dgCdN3-agYadtpturC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXyloi5lHjgfKV
 MopVwh3ipNupzrRAovmS+ott71L9q1l8v3/nPbSgDFJb+tEwhn49D1jp+6KbmW5rdB6RcG2JFUV
 gmNTXz7uOWuMt1BlkhVXOWdDyomyusc=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aab21b0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=6DixLaR-r_zTwfx8U4UA:9
X-Proofpoint-ORIG-GUID: vKMv2fcnSYksN2dgCdN3-agYadtpturC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX6S3SHj0UMynf
 aWoSWgFBY4eyF/kT3/xqpq1//JIhLKWNBRZAr+N7RT4IP1Qp26Ue69NfEPsdZP50ce+CS+aFSSB
 YZFQwp/m4sOeouTjMcJQWXgxBSOC/db0xAkOBV1IfzVJg2TiQm5KpClGgo8RTU1j9n3HZ9E7JdN
 p01WV4tIwzWxz+ElZxxu0ZkzWwqD4I35JAJhpFWwwhDsnu1DP6EYuhoWLsnYnzsBL7DO8IltwQh
 wni5ZgGWyMSZe1xPTAy4L+8o0xevyLmASCJxblYcaRJ2wKlG98gu4fNlvad5nVap6mln10cyqJ2
 L0AKIJzL6X6M4gEUXbSpyz1YH47szthQl544vVqm2szDP2UrlLlZEvyljfNFZSCjbBZayhJLylj
 qI8UkYM4FxLgyFnm3CqhI6J8V6q4T58BqydWo7dgyMSaoAkgkIR8eW0H5LW0BsXwJjWjycGL9Zl
 vPUGGssDVqTwSHzRPGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322

In ibmvfc_purge_requests() the variables shwqs and nhwqs are declared as:

    int shwqs, nhwqs = 0;

This initialises only nhwqs to zero; shwqs is left uninitialised. Both
are assigned inside the 'if (vhost->using_channels)' block, so when
using_channels is false the block is skipped and shwqs retains its
garbage stack value. The subsequent loop

    for (i = 0; i < shwqs; i++)

then iterates an arbitrary number of times over scsi_scrqs.scrqs[], which
may be NULL on the non-channel path, resulting in out-of-bounds heap
accesses and a kernel crash during any adapter reset or shutdown that
occurs before channels are established.

Fix by initialising shwqs to 0 in the declaration so that both loop
bounds are zero when using_channels is false and neither sub-queue loop
executes.

Fixes: ffc022564293 ("ibmvfc: fail nvme-fc fcp-io and ls requests during transport reset")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 89d271adccd0..18e7a462e32d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1188,7 +1188,7 @@ static void ibmvfc_purge_requests(struct ibmvfc_host *vhost, int error_code)
 	struct ibmvfc_queue *scsi_q = vhost->scsi_scrqs.scrqs;
 	struct ibmvfc_queue *nvme_q = vhost->nvme_scrqs.scrqs;
 	unsigned long flags;
-	int shwqs, nhwqs = 0;
+	int shwqs = 0, nhwqs = 0;
 	int i;
 
 	if (vhost->using_channels) {
-- 
2.55.0


