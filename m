Return-Path: <linuxppc-dev+bounces-29429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E186CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 18:31:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j42vV3Cj5z3brv;
	Wed, 14 Oct 2026 05:30:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791916230;
	cv=none; b=eVgcLE/Dn9p7WbP1z36KFHto+986MUuBzzPsxf3UpoqJRjsloxJo6DOm9AbWDYBUT6I7iE7VjASu359eZVwFBpGHVLS5Qq4BnZBhLzlI+bPA9FjHydxa341uAXPBUQHPoEzQ9S4W4Ef9fajFcH6pqb6nMlcexG/jrVvEKWLiJVFHSUzC+r+e3UCRzYb2Jz6HErhIa9L81D1s3K1pUNGsTvqnayYG48tEc6MwIevmKYverF4/zv5l6ANpj5veESTYjq8W1jw5HJJ3J9m8RoH44/F6TwIoEp2xMyrTvl3PAMtAkwTnRfEFVwQKoaCvRW+kuWs1DHqVZN0prg3yZK0tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791916230; c=relaxed/relaxed;
	bh=axYEmYmwDIrBozcfM1sXe9OglkGMOlUXeh8e09yqNMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAxBp39SOJ/PRJnP/QqLnZm80WERv2FIZRClvSbpV1B8Bc7YN1yWN5udvTW9AHDmrIQmZlAg85qjDnSp2wEewJsy7ZicDcD4FHjL0Phwet1ZUwYCGDo7WtRiOem2Tzl5IrFY4pxKlGjHioScgUYE7b0fzKMqV75PX2YtVeDSMW/SKPnRvxfS9HZYwk0996BcgWew/sWE3pI21tRPdVFcxK61esg73cBJ7dV16KoAPWstf/0cinvMwW8OwaaeDWFL/En8EKc2qb9dOpGspkwR1csqnXnQ/ajAecRj8DjKaYtfcXOfA43Z0JV/DH1l5tlaW5/bb09x0DaV9DV/5DNlDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QdXpZq7b; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QdXpZq7b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j42vT3rY7z3bsR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 05:30:29 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DENUoh1932337;
	Tue, 13 Oct 2026 18:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=axYEmYmwDIrBozcfM
	1sXe9OglkGMOlUXeh8e09yqNMA=; b=QdXpZq7bKJL5Aujk88v4PnRepaivOveRw
	bQFj4XkFy0nKoOEY9Z4lYHU4ix2j/uUrnbNBVtFpLk0TAQb1pEh7mYcxQv+FWcj9
	OFPcCVqikKZpBevZlImJ8qIE2KaS0tlFyCxw32CEvBT//gnFSnqwjHWcznWsfxjQ
	rHVFVaXPPxuyNGmNQt6lDcuhyjt4IQFr6333AZp9DdkMuh/Dfdh8fnclC6vu4sb/
	FF5DmdEG5VKJyMoGnbI3mdemchXzd2WYRy5wLyMlOSiennPbqPiI/Sus5YFiYjTd
	I8TfHynKkHk1UH66+Tvkzeui7ae/WcBJZmLE7RUECda8BxgIpOhBQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w7p4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DI99bN2667556;
	Tue, 13 Oct 2026 18:30:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vuqtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DITU9X12124696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:29:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CD635805C;
	Tue, 13 Oct 2026 18:30:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A3F5805F;
	Tue, 13 Oct 2026 18:30:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:30:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v5 7/9] ibmveth: wait for in-flight transmits in ibmveth_close()
Date: Tue, 13 Oct 2026 11:29:24 -0700
Message-Id: <20261013182926.30417-8-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
References: <20261013182926.30417-1-mmc@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX4mHu7wrcDX5q
 NUdj+aik/o3/EW+luTQ+NpR5bf6FL8X5K1w6SwDP4fREPKTkiJL4A5ZXdUbRVOPPrEcZRqlh5Gg
 rGM/e1QKV49svFObRU0UDBaZwfNwLf4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfXzXvmx38QUKdV
 uuJyt8KRMAhSeX9TueS9Wfhd1f5kK8p7aG/1eUG9w8m+ZE9YAqnh7uNECQeij/bgmYGq5D0jCM1
 d9qDeYY8uq755OkuLY5OyxCdrj60HsaQlbbCZbqHDuJ+u2VQyyyJ+I3tQWtRoucU6Zx7+ZLPr35
 TbEigQ1JI5lNwc0BNJ8ah4VsoeQpDgPg8WWMiLIWMLii0CBlh5bwxjxYlhmdV1yM1AbTvH9Gcz4
 ig2LMhR2bMdjxh4xA0gjLxuwB4Sct6S4tmmOX50bsx17gcZX9leJgpMa96+TogZIYajhBe/Vs6l
 gNsXf0Od+2Ge+hT1o5h3Aa/whCT5BWWGIXqLMfdkp+rN2oOm9EOFPyZQrwzKCqqci6QPItdB6O+
 OrAl5ToF0u4YoI4AfKfV8X1oII0Stm9ygwEknRm8mZtSe2OevaYlqK7a5W6JAkEhYiqBHlrEy2G
 8co44a6VzdCqJ0rM/5w==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace78bb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4X-BtLuwBG46RJIdyTYA:9
X-Proofpoint-ORIG-GUID: 8MehsMA-8PUUvvkqeKXErheFPb7vgI78
X-Proofpoint-GUID: PMobUYRW2dhZWxrJYbHVcEBHMHKGKUO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130072

ibmveth_close() frees the TX buffers after netif_tx_stop_all_queues(),
which does not wait for an ibmveth_start_xmit() already running on
another CPU. That transmit can copy into a freed buffer and hand PHYP
a stale DMA address.

MTU, csum/TSO and buffer pool changes call ibmveth_close() directly
while traffic flows. ifdown and the reset work go through dev_close(),
which waits for running transmits only when the qdisc has an enqueue
function, so with noqueue they race the same way.

Use netif_tx_disable(), which waits for running transmits.

Found in review of the ibmveth multi-queue RX series and confirmed by
code inspection; the race was not reproduced. Tested on a POWER10 LPAR
with MTU changes during a ping flood, with no warnings. No kernel
selftests cover ibmveth.

Fixes: d6832ca48d8a ("ibmveth: Copy tx skbs into a premapped buffer")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- commit message: dev_close() waits for running transmits only when
  the qdisc has an enqueue function, so ifdown and the reset work race
  the same way with noqueue

 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 48bc4406396b..f2570d637301 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -835,7 +835,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	napi_disable(&adapter->napi);
 
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
-- 
2.50.1 (Apple Git-155)


