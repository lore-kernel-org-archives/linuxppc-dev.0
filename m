Return-Path: <linuxppc-dev+bounces-29157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C40CA601F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 18:34:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1b983JqMz3bps;
	Sat, 10 Oct 2026 05:33:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791570828;
	cv=none; b=dPx3GDb5QXYu9xNpGUcG0D4GCk0t93PBonTawsKk010+BUeaaMVOLaqzbHEqe9Q0i4+vdTYw4h88HaJDM8mgOVK7IFDs4OJulZfUZsFiP6VRB1J3LguJJvg3midx6OgLBmGMRCQ3/e95eG3xUYz/fOUOaZq1eQPy1qIkLYwZNpY6b/8ITrLEknSG/48nTqsedF0hraY8AGA/c/acIJXncAKUGRIweVwTh6Xm4v4YmM1NwdWyCOC7w2pkV7CElqQMw8O076HpeqZkfJS0WzUAbT07J2YaXtaflq20T0fal+Kj41bIINZpZHVOjvpSeiwIYQYqPjhvul58s+tfSU0Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791570828; c=relaxed/relaxed;
	bh=RSCr+T+GDaBV6ogpjmxaQdS8wqrdptG1TtxIxVUCskI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRYk9Zmo5iKTRHSkixAdusLVHxFaWyw7a/nyAK5ct3kEHVF12ElzE/nm25pD0LsQjcrwiJmqpDO0/v19QOBn797O3FE6x2nJtQW3DVZUnOkT/i0qohpY8bo35sfsA7ynKhdK3v20CStRnxi2G1TSQGyvTca9+C63h0QUMps9ZzRTFey7tMMqhAdtq2V9x6hng8I4ZG3yKI1P9i2akrh+wmsyrlRB+/tyBcv+bZLC5E/13svkUBNozSyew+yZQjtzdktYLzxVCd7l8xRMicAwg1I6B2Mdb+M3duHKbvaZMqPP0MKluCwsBer7q32p/k4CfD1dsEofY8pwZ6baHT79gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Va7PVlwV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Va7PVlwV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1b974Vg9z3bpH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:33:47 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Ha5wn736789;
	Fri, 9 Oct 2026 18:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RSCr+T+GDaBV6ogpj
	mxaQdS8wqrdptG1TtxIxVUCskI=; b=Va7PVlwVW4nTIa2YAQ3BCe+CikI2m8LnK
	ay2PN4zXwR2RFxnxeT6fIDrQW4CbQoAYQb3AZhi5B4gcCqUkCB3X+gmwj/bFjUX7
	aDcmYgbDu2K+zd7BpsUMa8+v3WIi/XVUvdychp/R0+ut13q7RbXol1xedAezdNBm
	lmdsKXiF8NAPTpQXggYfOtaZFCVSyJGLZfU4WoAhC4yFp/6EEV1RyH71QfBx8sCa
	xZjUPS2DMj05UoQUHhot71DyGO/q1+GHxsP1U/kyRT5t1jZh5vCzgxrGfaCG/qdA
	w7uVLvZJb2dY6kfM6Snr1SCkfmldeUzZCjIvwuxIBJr4DiaQHB9hQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdr914-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699HN8kT1169766;
	Fri, 9 Oct 2026 18:33:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s351xhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXXJK27984474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 960725805F;
	Fri,  9 Oct 2026 18:33:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E5F58051;
	Fri,  9 Oct 2026 18:33:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:31 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com
Subject: [PATCH net-next v3 7/8] ibmveth: wait for in-flight transmits in ibmveth_close()
Date: Fri,  9 Oct 2026 11:32:57 -0700
Message-Id: <20261009183258.18624-8-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=JL6uIMKb c=1 sm=1 tr=0 ts=6ac93380 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4X-BtLuwBG46RJIdyTYA:9
X-Proofpoint-ORIG-GUID: ilQ6vN9oyP4AAcnwgN_LKj5Y5tcjOZHe
X-Proofpoint-GUID: -xZRZCmJq8Q_GcIzhmA2KxCdPL1iRx3w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXwQOViEUm+u+A
 PUVzr+FGLN2Erg3v+cIq5HISFa6hOiFGFu+GvlPyZCGINHiJpLOFqSQoHZgyfDG1VrKDiUD0osK
 LNeQgL3UBdbHP5/XJIPHfBmVqBccRd8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX8VHWxfTqEyMI
 V9a3cgNYUNJcQoqPYnOEHloYp4+SpRRW73NpNfdbjOqgUZgfVbjnb1P1VOjogDDKuJNn1/32imE
 NIUwK51XEHHmApfRN0jQ6lcVmFPRUnD8MRsyG5P+MiIMJkkwxHno8Zr7EVpqu+51BvVGRtgD+kS
 HjLD6rMoxdfpABzokmbS5gmijSSpNji5/hYbq23lO52jxN7q5LfwZ3b8HBBZBYkZ+bd1kq5WM0N
 ZaZFNs77HMfABfdbnKeVzcIQoP5FmYbZ8gh0w6q5Q4VpxAx7c/CFM2/cTUuXOKPC6AaUv1Y/mOE
 qviBrGuH/lM0JQpgWzsI7OHkabl7GsRCrvD7+ZSSBeFK0gFl5lbT/4J9t0a5KAKZrWuxh5xjH7P
 nP+mGM56iJgbjRlPTiixGV2H8WguD8MPM8SNvyJmWi/VFAq99sQTZLQWHhOz1622UCjlT68Ro8I
 eanlvHkXqodEUyQn2Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090072

ibmveth_close() frees the TX buffers after netif_tx_stop_all_queues(),
which does not wait for an ibmveth_start_xmit() already running on
another CPU. That transmit can copy into a freed buffer and hand PHYP
a stale DMA address.

MTU, csum/TSO and buffer pool changes call ibmveth_close() directly
while traffic flows. ifdown and the reset work go through dev_close(),
which waits for running transmits only when the qdisc has an enqueue
function, so with noqueue they race the same way.

Use netif_tx_disable(), which waits for running transmits.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; the race was not reproduced. Tested on a
POWER10 LPAR with MTU changes during a ping flood, with no warnings. No
kernel selftests cover ibmveth.

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
index 18eb0f27512e..7dec7ca9753b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -836,7 +836,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	napi_disable(&adapter->napi);
 
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
-- 
2.50.1 (Apple Git-155)


