Return-Path: <linuxppc-dev+bounces-24678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D06C4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBd1Cqrz3013;
	Thu, 23 Jul 2026 10:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764936;
	cv=none; b=KLIU0/r1Oc/CxtNQCYEsvVtsn63WmiDpoPLpt0iK6etauAFS4hldYfFEsU95huXxfvNi+BQMAwjcer8JrCILRLMIa9JeuPiVnMuEHkLH9UtLyAjpNwxKOI/nUtqittBu/pjg/aVJ1Y3alvy/11tPl2i1T7Eg1eBkUIUq9OZDlw+o5QaFTzkGQMK8q8QFA6evPsXUpLOKZ3TXq+IOk/WtQaOs+wCqqBYsdvcHU48DQVW6ynbijdjpfFfmscFxiq1BNRnQCpa9JpmcT0LV8h/qAw4mJICKEJjE77453r67sx+I120nh6BX0R0sTv690rjvpMBe6HaZZ9jqzm+b8R4TrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764936; c=relaxed/relaxed;
	bh=LU8iUAZRNHYghpMlBjgOCU4nmEYRCejYOKDMT+BakN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsl0GYzUflZox8Oc0eCM9QO/oSurypS1Sq83MTRf7XNgmkSt6hHe5/hAWwqb+BW6In01vpHVp33DvE2gIcVwzCqs6ntG+Pk432ZOZCVGtPFhALlR5COkCmD2irskZMSFE3+0ulseYUH3Upet/8TrkFc5rrVjKLx1S9fmFN607R9GyNPko8UzvKg7u3DFeQqyO0nrMZjag+t65sBmGNMaT4FgWXU3eqoKPi8BqLyou3Uh3M34zAg9J46rwqYYuY1tJ128tF6wms0h9AEACUHiQYBrbQnWOQt4yhVZ8KdRLNHYI1wWMB84AD/SHGwKt2mUzNiKDYXwp8vvm17opPDZ8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ly3YWDUQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ly3YWDUQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBT0ZlHz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:08 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MICSqM714590;
	Thu, 23 Jul 2026 00:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LU8iUAZRNHYghpMlB
	jgOCU4nmEYRCejYOKDMT+BakN4=; b=Ly3YWDUQsRnGee8KeCVsXCT2xZ/kH7rOw
	Dyarl04VAivZT0GpMdUczteTSQdZRWJzQ9/pGFjoHOcNGS7ojTnxELjd3vY06bYo
	naYoa7tlGIhI6REK+YJ595cn+LIBKxbSOG/ZjIRVmJivEGCAe+EOxsw1ljr9xDFK
	u5l7d/rJ/EXG/qqANaXVPRDsKMS1iBrJ02DabsVO46+KkhewXWycQ/IXw68JjXmL
	J2OacIYV/rHykoLJbI7VLxkEG+7nhPZgI063kwuzhSTjKCPwLKRuU8S/7X9Xew8X
	C1nBI89IE/8/m5QJ2JMm3Ab44lkqr7Y9P06p4Xeqs1uIHbUDK8cMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahcct6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnuoF026514;
	Thu, 23 Jul 2026 00:02:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq9x2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:02:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N023ao19464800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:02:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F305805A;
	Thu, 23 Jul 2026 00:02:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9C858063;
	Thu, 23 Jul 2026 00:02:03 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:02:03 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 14/33] ibmvfc: allocate and free NVMe channel group discover buffer
Date: Wed, 22 Jul 2026 17:01:30 -0700
Message-ID: <20260723000149.969416-15-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723000149.969416-1-tyreld@linux.ibm.com>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DD9qkgwYUMEwGKjFOPlWTa3EJmqOu9ZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX4i0Q5kIrqTK8
 d1F+tbSr+CmxBd19r3UhTYrmYorbpZB0obqQQqJfG1NQ+8G2bPJI8oZp83Lc/VTcMJrITknCFoe
 fFhWiqTs48xXWBe4szapRxHxvjK0JhXMwnoOflEqt+YisXHebuKdjdE/9Tqax5zFWrmDMRcK2d+
 nTQKo3prf/8U8DLmCdbjcOs7XI02mMvWHmL8ikKZGjpwnmcQ+Vd6wvhEVceaaPexWJji+4pmWyi
 eDqz2XXUgmm8xKjydwOPiZNl9td+2uRpMil9Ut11pXbo+58QXwXZyXYSvR7sAjN5msNPypVSGL9
 A2X91Z6YZJw2D9HZU5yDYkw6kB6Q5EkmU4z9NLyg9vJHJ+PmozUz02jPEY40IDbgfjvEvJ9stqj
 2Ihen3+SM71rsmb0jc0YqMzXZae1uqjB0wIooWKOZSngTwM9gJfrWcClUzbQf5q84h1kY5vZsWt
 zXJzdIExS/63L/HBQfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX+SSHhF8yEo5z
 Lbfj02bOzxK69JJM0QaJIHPiTJQMUGoRp8UwBSRabNadZu+iD8UOZN6tKfpynOJ73MZjll0bUnT
 4ulkLV9xIl6zMeB1pfDdVPtoOMPz9VE=
X-Proofpoint-GUID: DD9qkgwYUMEwGKjFOPlWTa3EJmqOu9ZY
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6159fd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FxNEJgEJPZLGpAZHG_oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

Allocate a discovery buffer for the NVMe channel group and free it on
all teardown and error paths.

The existing discovery-buffer allocation only covered the SCSI channel
group. This patch is prepratory for sending NVMe/FC target discovery
MAD.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 088167ec04ff..a700e2554e69 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6375,6 +6375,7 @@ static void ibmvfc_free_mem(struct ibmvfc_host *vhost)
 	mempool_destroy(vhost->tgt_pool);
 	kfree(vhost->trace);
 	ibmvfc_free_disc_buf(vhost->dev, &vhost->scsi_scrqs);
+	ibmvfc_free_disc_buf(vhost->dev, &vhost->nvme_scrqs);
 	dma_free_coherent(vhost->dev, sizeof(*vhost->login_buf),
 			  vhost->login_buf, vhost->login_buf_dma);
 	dma_free_coherent(vhost->dev, sizeof(*vhost->channel_setup_buf),
@@ -6437,12 +6438,15 @@ static int ibmvfc_alloc_mem(struct ibmvfc_host *vhost)
 	if (ibmvfc_alloc_disc_buf(dev, &vhost->scsi_scrqs))
 		goto free_login_buffer;
 
+	if (ibmvfc_alloc_disc_buf(dev, &vhost->nvme_scrqs))
+		goto free_scsi_disc_buffer;
+
 	vhost->trace = kzalloc_objs(struct ibmvfc_trace_entry,
 				    IBMVFC_NUM_TRACE_ENTRIES);
 	atomic_set(&vhost->trace_index, -1);
 
 	if (!vhost->trace)
-		goto free_scsi_disc_buffer;
+		goto free_nvme_disc_buffer;
 
 	vhost->tgt_pool = mempool_create_kmalloc_pool(IBMVFC_TGT_MEMPOOL_SZ,
 						      sizeof(struct ibmvfc_target));
@@ -6468,6 +6472,8 @@ static int ibmvfc_alloc_mem(struct ibmvfc_host *vhost)
 	mempool_destroy(vhost->tgt_pool);
 free_trace:
 	kfree(vhost->trace);
+free_nvme_disc_buffer:
+	ibmvfc_free_disc_buf(dev, &vhost->nvme_scrqs);
 free_scsi_disc_buffer:
 	ibmvfc_free_disc_buf(dev, &vhost->scsi_scrqs);
 free_login_buffer:
-- 
2.55.0


