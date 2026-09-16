Return-Path: <linuxppc-dev+bounces-27532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA82C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:39:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlb2z0hQKz2yfD;
	Thu, 17 Sep 2026 09:39:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789601995;
	cv=none; b=M8i5nomNrOuhXPlUgUbCALJHh0NIU3ScbskZEEdLGenWPwS5scmSGWx/wQt+S8+ATHw72WjhYY8IZNOhBGU+YW1x5MGFwa/kEoUCngdqzZ5uD2ytHVWUBlszPhMX2HIkjQuB84w1M8XzYmZDcPIk2VE8vGmMZ2HOqsarJOo90IHdVyeEmxKA5skkZJmit4Y+xEr4yDRH7ul8n/ppRtdgH1vFVQ8OEtI6eKDqC3kcT9NIzoo33k0yq54h2DOXNlL/bt2ov6gx3NeiRA1+8Q+Y9OKEmB98kUzSES6EYWeKcNHbJ0HRRtrC98en0TKFLYy2xFqt3H7tgfb3WK4XqO3K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789601995; c=relaxed/relaxed;
	bh=9cxc677mE3uJ9eTKTbzk7cg4m0MicNMjE0fu7maRZvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeuPQVrlnpt35ZEEySqRK6OjaPvnv/TG3hJNk5uDZ6q7+O0+cfW8e7fj64xbJ+gYyhkbwGZuwkyeU4d47VocPO6SfjmU4EFMkxd9grHPsmZdUsP7Y9ccaPDGP8n9j6JQYR6T02cz3pHClN3Fmq6sdUxdKzNGjrnFNfm6Q+LVhH1JjkIIJt+K8O4mmrbQe+8gj9N0F+4cedY+zToo6MbB6PJKRqS1m34hfJQEkWQ43dy42AB7D2mWE4i4Eqg78WgLXtf/oYtBRt8Wdl6Fb6H353ZkcRdUnrua9yFh83AsUwZlVVbgG4Pm2PaHjHmrPK0Rq/0Gt4HNk1rip3buyl3M+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gEoL/lC/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gEoL/lC/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlb2x6ZlVz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:39:53 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1UEK006689;
	Wed, 16 Sep 2026 23:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9cxc677mE3uJ9eTKT
	bzk7cg4m0MicNMjE0fu7maRZvQ=; b=gEoL/lC/hCXVwSZ+XPy4rwSJNrU3OvASm
	ANzRcikv/pwpnIvRbqzbEzBRxD2LCkq5NP6Y7FxWDmb3OfsTC/PfOxWPKzuPoGjJ
	uQ5ndyiozsNSOZ7k0GoboSZXuvJefjD2qJDOFz0MVF/MBsNOCqcRUS0H18RnKa5V
	jMxKGlYd928fzLij+wlS0wUUZdw4WYRfEv53IAgsmRWMbNrzbZwkFi/Meq+s01YB
	CtrgVDGzMoV1/GjDhXPLaqDg7fFcdXhrKczNjSpV4II5DobTW8wvfOq9k/LxDGvu
	T5p4+dfyS6tKLwYqtJWvoeTb/KBr/DNuaMxgC57G7ZYSOpPKtUdtg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83ye06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMxnNc1649291;
	Wed, 16 Sep 2026 23:09:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03c0upc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9nUh25887388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F4D458054;
	Wed, 16 Sep 2026 23:09:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C575804E;
	Wed, 16 Sep 2026 23:09:48 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:48 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 20/20] scsi: ibmvfc: fix nr_nvme_hw_queues module parameter ignored for NVMe queue sizing
Date: Wed, 16 Sep 2026 16:09:21 -0700
Message-ID: <20260916230921.2204729-21-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX41zQYcEuAqPv
 SczMpImiZdSa0vg51sJQN32cDdzTLJvzgi4fr5DRXA2Qymc1+Fxtmt0IHgpE+opQmRPZeAi2xL6
 zRp0NrVW/6gfXD32YtOBZ06FFlVcYZMYgt6GwyGt8lrpYPFBTyWaPq+jQZbNpqQ/YEpivIVJbkb
 3mqQsciDp0qQFfouRUWsVKvYP9iVbmUYMlYDSPUe0WQKM0zTntnYRkzsVw8Q0T/chPIreaZeqo3
 ayEJdK6Je+YJC5GrVyf779t6x1FVRPTPkJOIawVs5bybYPropOLKOn6qBeMPxqYI6nvv6a18Xfm
 G0vkztWF5e3qBcjEBiEkof9DemPeZLd4uh0gUCZUA9IrKHALtv/NbYfUpKO5WcQovY1bEsVwWcd
 fyY0cNmtsfd2z7/JKqcbyGh67ai4z2CS4JckWKJi0taR7HWfRattc/CA4zZ0cQPzcPNKed6bYyQ
 FGzQI7tZ5huk9osx0Pw==
X-Proofpoint-ORIG-GUID: 83b0NWhM6F5nG_qVs5--cVVw4DuNyPGT
X-Proofpoint-GUID: 83b0NWhM6F5nG_qVs5--cVVw4DuNyPGT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX1rTnDP6+ZqFX
 8xw5OkbFFAVM5tGjyYKFzTr4ziTaU4cTpuXPJ8MEsTEHeOe+Uxupe0voGf7g53cLyB8Mkt+5FcY
 LY6/CXdrh0oI71C3IRKzje/1T+asdbc=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab21c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YHccNbNTKC1xL-9NveAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322

max_nvme_queues was computed as min(IBMVFC_MAX_NVME_QUEUES, online_cpus),
silently ignoring the nr_nvme_hw_queues module parameter.  The SCSI path
correctly caps shost->nr_hw_queues with nr_scsi_hw_queues, but the NVMe
equivalent was never applied, making the 'nvme_host_queues' parameter a
no-op.

Apply the same pattern as the SCSI side: incorporate nr_nvme_hw_queues
into the max_nvme_queues calculation at probe time so that
nvme_scrqs.max_queues and nvme_scrqs.desired_queues both respect the
administrator-provided limit.

Fixes: 99d71f6b2c78 ("scsi: ibmvfc: initialize NVMe channel configuration during driver probe")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index b0d9000b4a0d..df7976918f8f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6866,7 +6866,9 @@ static int ibmvfc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	int rc = -ENOMEM;
 	unsigned int online_cpus = num_online_cpus();
 	unsigned int max_scsi_queues = min_t(unsigned int, IBMVFC_MAX_SCSI_QUEUES, online_cpus);
-	unsigned int max_nvme_queues = min_t(unsigned int, IBMVFC_MAX_NVME_QUEUES, online_cpus);
+	unsigned int max_nvme_queues = min_t(unsigned int,
+					     min(IBMVFC_MAX_NVME_QUEUES, nr_nvme_hw_queues),
+					     online_cpus);
 
 	ENTER;
 	shost = scsi_host_alloc(&driver_template, sizeof(*vhost));
-- 
2.55.0


