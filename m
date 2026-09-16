Return-Path: <linuxppc-dev+bounces-27514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DD7C982CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:09:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZMz2QYDz2ypW;
	Thu, 17 Sep 2026 09:09:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600175;
	cv=none; b=CNi2wQjZIDBNOeqPQNRzTve3eOcs1xaIeyv88c3p3y6Hx0REavoCJAeyzy7COKsh005ccnQwKp/h6fukwdo/l/Lk30pskh9b4NZhC58E05Eucm6qgTxfYROnD7GjBPuTSEbmR8d+eKlyZDOgoCtC293pXbPzAcZfNDi2w8M8oeGBSweXOYCGcatxqbNYPZnEXxYgQRxSSf8lRdh4iVCZv0mi7tSAtzMzfrqOhp5Od89Tq1EPhTnNyeeVzBH/mU6XFKWdFZep9w0WQcayWsnBYsYHFcYPRLXv3cLpAxZrB8/3dK/7wfQu7u71RX+Rue5mgU2xBe9ihw2vWdxkgUpInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600175; c=relaxed/relaxed;
	bh=ClrGPMR2eCl1PGakK33NKTydd8/M9xCYys0xvOiUDi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ4nw7MGHRhhFQYZTx5PN5j8XK0EwCDHXkOogWsVKu4X05xekcxF/Njm0qfHKHWJyc8fn3Q+ZpafF1Gphyu4dG7f6YKITUdWhfpvh1vazlzlBxrGpltBo7l5rBP/ii5YmvZF1lclTmUYvlxY5Vw/qB77Z45D+Pu/76LZpxYgUq1C1mBlDh1k6YMTe/9WRoZSQcuD7QtihtW8mbfY5xcqkUGncyv8ndR9Cnd9b5WqRVlxE8VFCaIHIqkfRIpMxLcAiFkt5D1ypZxqu4lsi0d3tu0QocHenr55QWj1/8VRsylZHbNb0lYkiKJAgqG00CHVvhtFYlGNIzniRWZ8J0gQWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OFhRkpOB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OFhRkpOB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZMx64r8z2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:33 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1m86018184;
	Wed, 16 Sep 2026 23:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ClrGPMR2eCl1PGakK
	33NKTydd8/M9xCYys0xvOiUDi8=; b=OFhRkpOBPfgJsJbxJWy67Aa92Frhw3uoE
	uXr0HoA6qMxsbLYBgcBSM+ekV2Qi2cJ5ZdzW9/sllmR1SvWdJBC3Lv8Awx9D5EI/
	C/MuUaEpcz+aMiDQVsq/lGfCC1JRtKhPJyEQjrMXy93SRVuveNwjM7MICILlzbz8
	biauDN9Wv7upWw4tYGwbwZF2Er140GzsapyHwobFc74IG21X3XOyMm9wQedIAc1V
	dA7i550bEvWNG8D13pWMIz6JsIcp+Rz9mJ+djguBNZV4EV8OY195ko+/rDolbX3M
	CXWnUKsF7440pwEz0k9MW0DXSBKArI+4Gn18Tn+mCflt8VzQUXg0Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf57dwv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMxnNW1649291;
	Wed, 16 Sep 2026 23:09:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03c0une-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9SGU59965792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DCC45804E;
	Wed, 16 Sep 2026 23:09:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696E158056;
	Wed, 16 Sep 2026 23:09:27 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:27 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 01/20] scsi: ibmvfc: initialize evt->tgt for NVMe FCP commands
Date: Wed, 16 Sep 2026 16:09:02 -0700
Message-ID: <20260916230921.2204729-2-tyreld@linux.ibm.com>
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
X-Proofpoint-GUID: _P-5uaKXzyGQGrPy7hqE-hW_xa2qQV9f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX9pBpqj6SOcAd
 qFjI1h8NCr/IMSJzeZ/pjvbuQkVhdO5frGSOKRC1J6X2xPDWnH5+560eSfTV72+BvTIfNy5OHO+
 xN+Q31bbfIBa0f5P9gFCxgdnyUwwVFk=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aab21aa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=24aaq1eNYdOIN5PvXmkA:9
X-Proofpoint-ORIG-GUID: _P-5uaKXzyGQGrPy7hqE-hW_xa2qQV9f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX/cGUYNrN42bH
 t67rMcVJL/uWbsR6A0IB73P5sJYqz/Iv9jmj2DlhoicinHg7YqLKGvEZC+ASOkR6uhhOFkrMJD3
 uX4wUbXpXLqzPd7DkoVm22IfyLelrHGgzXgQp7uOW7omCbNS1BIYF9Dvc350Y/ecyAXs8W2OAa0
 u3BPYQRNx3dDbac0ZbKI6KF6iit7wHbcYY6owqFrAim5Uc2eldRHV/K4nCm1hmRa6wrqtfrSST7
 3bRevoYv4tkW6zpItJhllzO+0cgBzJib9p0tZKVO6GL5sZUj6fb5dAEsXbs0VVJzsIumE/nQjpK
 uCUcua2VgXqktIMe0X4RvJGXMp5iML4Zd4ki3ifO/R14Wx6N/TRWOuya1/fVDo7V8GpIRt66IJ9
 M4DZ/AnfQSMxVjrCElRyPIlmyrCwLauvNXGE3TVEPJ96OorHvIvM3rp1gvHr35Ur9o7IyNBUpcf
 /ZWtp14olIVLKuEOWWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322

ibmvfc_nvme_fcp_io() submits NVMe FCP requests without setting evt->tgt
on the allocated event. ibmvfc_init_event() does not initialize this
field, so it retains whatever value was left in the pool-allocated event
structure.

When an FCP request times out the NVMe-FC transport calls
ibmvfc_nvme_fcp_abort(), which in turn calls ibmvfc_init_fcp_abort() to
build the cancel MAD. That function derives the target pointer from
abt_evt->tgt:

  struct ibmvfc_target *tgt = abt_evt->tgt;
  ...
  tmf->target_wwpn = cpu_to_be64(tgt->wwpn);
  tmf->assoc_id    = cpu_to_be64(tgt->assoc_id);

Because abt_evt->tgt was never initialized this is a guaranteed NULL or
stale-pointer dereference on the first NVMe I/O timeout, resulting in a
kernel panic.

Fix this by assigning evt->tgt = rport->private immediately after
ibmvfc_init_event(), consistent with how ibmvfc_nvme_ls_req() already
sets evt->tgt for LS requests. This also has the benefit of making the
associated remote port target visible on in-flight FCP events, which is
useful for live debugging (e.g. reading tgt->wwpn from a hung command
in a crash/kdump context).

Fixes: 4e70b8795ee3 ("scsi: ibmvfc: implement nvme-fc FCP abort callback")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
index 9ac2671a3567..9ed6522c2e9e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
@@ -359,6 +359,7 @@ static int ibmvfc_nvme_fcp_io(struct nvme_fc_local_port *lport,
 	ibmvfc_dbg(vhost, "vfc-nvme-mq-%d\n", evt->hwq);
 
 	ibmvfc_init_event(evt, ibmvfc_nvme_done, IBMVFC_CMD_FORMAT);
+	evt->tgt = rport->private;
 	evt->fcp_req = fcp_req;
 	fcp_req->private = evt;
 
-- 
2.55.0


