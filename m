Return-Path: <linuxppc-dev+bounces-29222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319FFCA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 05:06:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j355r5JTHz3c1Q;
	Mon, 12 Oct 2026 16:06:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791781568;
	cv=none; b=LvAnacnX6UPv5wUwQ2Vqr8QsOjjhsDRngKAepmYB+w0bXkeOE4isVSU6btQdYw3uzAtX7W1oRC11Jv3GyQrNNVzWEiPDvmEmhd4M2C674ywCIDJaA9PWEWw5sJq1GysnKbsGIY4N3NbwwQv8OOHR2uQFL9uw9JjH4whRkU6w8PMOXRjYVan9RZkwCOBqlYq1sQGTYYatVaSrcqYQybPDqKiYAk65EylHZnQnmOQA4jg2NiIjGOBvew1fnwMN0ozCCGKTSfpr70GlXQ7KZ/Cygm09v8B20G1MquJWWx11sjwYrVlXvVZFhSmqfi9DE4DV9qVrOzks7g3eR+LcZseHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791781568; c=relaxed/relaxed;
	bh=Z6AQstE/WKAoeujPmqe9chR/F1xo9NjU7RSBpFeK3pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiGQOKpTw4IUUPiBQjwh1gk/lQ8bmStvHEz3Vf4Y/gmCGzvZXi3sFejuaMqlhnBf/im9GShZeC2BE79SFWb6CijXFLQzWx859jUrlyRDKllN+g30md05YiHwhEKcQ7rYlyVLSnz3i0vWf6qLzhOYlHvlE60FCEUc3/5zpptYBalQdbq6d/1v7zsDhNJwoyeAavziDP28Ze4IwHP2iPHrKJF/cv0E2FTMXyL4sATnmrC5UCjEOKxiRptJVr+ql9M0USEOwawLPgEPkR7ljSynBsVwy3s0FVxh+NdHXwcpHKQFhDBZ3yevxVKzH1z3OlpuRDx/u+pYP7WWx3lPe2v2Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o9NaADBb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o9NaADBb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j355q6hBkz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 16:06:07 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2F29m3073254;
	Mon, 12 Oct 2026 05:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z6AQstE/WKAoeujPm
	qe9chR/F1xo9NjU7RSBpFeK3pA=; b=o9NaADBbudqSf3CjVACQLRX/J9z0jiI/c
	UsunSHrcZRjdNNx2cVhOi9PR8uKyJU0xa4csQG875kOVe4wwQApWths/4NqsCZHQ
	Gt4U8mN2loiM3aG5dYeDq8q+dSFhVctcGa2nT+edkQXTAEXl+8KXp+O76svcszGn
	pgGz2RlNcDPlWH/kFu5vaz4kLlUW41LG/Yw+RLsAWPSLoOEVRRfyHpw3ZVNtEkQs
	9Y5cAcwLBogOfmnL2jdikLkrq4ZRiQX7FByaJxv7c1e5KBHzZDrZ3A7B2ejfN/SP
	PnW6QKE736xk8hAnALOevnvE8lic6d8BZG5b5EHNGcozhH2jNfPuQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vxx69-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C553Bm3726528;
	Mon, 12 Oct 2026 05:05:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfukpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55sx960031236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 753DD5811C;
	Mon, 12 Oct 2026 05:05:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DA505810F;
	Mon, 12 Oct 2026 05:05:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:51 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v4 7/9] ibmveth: wait for in-flight transmits in ibmveth_close()
Date: Sun, 11 Oct 2026 22:05:16 -0700
Message-Id: <20261012050518.88858-8-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261012050518.88858-1-mmc@linux.ibm.com>
References: <20261012050518.88858-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX93z0cMeJseh/
 JDC4z79GIeo6ZD6+JBjhpzmnx/d0fOr1jxwnfFmndu6kaxY8zVPuBy+5IJsKG0g7aVfSdv1qsP8
 e5D65dKYruBKmr4fnWw4Qw4Nsh0ckts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfXyIKGFAdatUT3
 2i7NzNTQexQ4a4eg9Rzavh5Y3w++HGPEGnFE53TFFvluCmjYMUb5EGVLI3LDMIYcnk/v9PpER+2
 n+e+MG+J/QVj988m6PswOwOV8u0af71MIUhK/lmldW7sIb4M+6CaVRamjiibXD2sjWfyaxb1Tyi
 EOKVRaejWZwOHDA1Wgypah5OR9s3YDEI3TLGsiQct5FEfIfcGa5JFa+n/gLS4xby59Gy0X8LjMC
 +muE6ew6fEjHdiIzqFuUbCm3KpBZpUprmRWPa8UYfQDIYMIXXq2x7nOftZMI/WAU0+nZhG90PHZ
 3tyKsyIxlgYWsG4IGDl5IE4orvGn7lt/x7JHGUc7jvNs0esICYlKiJfhF4OspVw9yBq3llxLO/8
 f1dhx8Cg9J4VkAiHuz+tdIWm+yYHQXyroKRAs+Z5t53aJD/5SwduYWVnsAcjRO7DhlgpwfkroDN
 okDWLSTn1TqCOxfJSdw==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc6ab5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4X-BtLuwBG46RJIdyTYA:9
X-Proofpoint-ORIG-GUID: qpEkcX4OpNnqHxeryL5dGN6EmnFAr9LK
X-Proofpoint-GUID: rozSoxRGEsBv2YLYBsM7wTfRHlgoEv4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120018

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


