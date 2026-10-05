Return-Path: <linuxppc-dev+bounces-28913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D71DCA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:09:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyprP5VXTz3bsP;
	Mon, 05 Oct 2026 17:09:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791180581;
	cv=none; b=JH7Uavs6sT+VAh16UPFPfwHX7M+gTz+p1jqTMTNdPzxnimstL9oOV7NJnRAMj10CulSAlXNe6eqDwd0TcKy5uQk9RwW8J375Cxdc9FFhpZ+NaDwjjZncRD0fqpqD/ppEExWcxUzK+DSqae1Ugyn5TUv9+VE+7wOXynUd6lK99UKt7LkEMarfIfi8vkVuA2hSHCn5YKpU4ZVhBPw181UIYhMA+0RsMhKonkJBGiuui+DOpxkNwDf9tFt5VKQYwB2Qh/hwqwyk8paoryWmwEcnJBX3rrRti8c3+513kTT2LvwZuq2s/zb+Lvb62mJMrj+ra4phflvxCtNk4TMzx5ZfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791180581; c=relaxed/relaxed;
	bh=ZYPoh6it/oNB57OFQPCnHjd8sUELLNdL6f5uuCEoML0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnfnSd5XecaP5/qPzMJb/BHGCq4DXqlSfcERPhipLdnE3SJIFWa3Y/j15ZCuox2w4VkURcBWn2xF8UjGhlfq0uITqkMhypQuF6Mw1TJGIzZIp9BgIw+Nz9Qs+ZeF/uAxrrKIB5hy5arcpdkincaMRn3/Xe//PjOo62GaF3aseoGJ0WW2ye42BNYQXGcnXpnFekpHOpYZezdcjghoXTw/6nzN2Ppej8fWGWXx9WlzlYm18ossvDkSa33WkuCzgxAKOihNBvn0zI3MmlEWWo66bVWZx6sHCThVkPih3MluTIO/JjFvoAPgHFtyzEdG+OTWLYfEuFPw3p1+OH+VOzwhnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BpCQ0gJ+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BpCQ0gJ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyprN5fjCz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:09:40 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515vRO2066516;
	Mon, 5 Oct 2026 06:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZYPoh6it/oNB57OFQ
	PCnHjd8sUELLNdL6f5uuCEoML0=; b=BpCQ0gJ+6bChsf52BCBQ+yuLhahOhs+jI
	pWT7Q0uelKKrpfRXuZc4FU7RoDnr6CuBrFGiItxzB2YS454rK2kF1yPEyTDwYm29
	AsdmoJgGfg0gqIwW3JYAmtwOYpy+sfab+yOB27PCmdibkbP2I2lgIdjFbrLW015F
	EzYbArxirznHmgF+H39pJB5Q3TbdQ7Gm4IwUIJIavQU5fjqxT6IdNPdRzst8RIBG
	JI7z5366lE/1DWrfDPRJ6Kk6JElBWXUM39yLt5kqqf1ppFJeq7aAb11uTQzwOsrt
	dy3rvw8QEeiPsN2jAfaKCX5nL8+ljgRzb4Uo3lh0B92mmRv/6paig==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3mt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6951HVEM2163522;
	Mon, 5 Oct 2026 06:09:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvm9tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69569RM062259460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:09:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05AD05805B;
	Mon,  5 Oct 2026 06:09:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C150158058;
	Mon,  5 Oct 2026 06:09:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:09:23 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/8] ibmveth: wait for in-flight transmits in ibmveth_close()
Date: Sun,  4 Oct 2026 23:06:08 -0700
Message-Id: <64ed5d98164f9a57b2dc9b6c61982d94ea92be96.1791178212.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1791178212.git.mmc@linux.ibm.com>
References: <cover.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33f1a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4X-BtLuwBG46RJIdyTYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX0a2U5V11TjCT
 8eFXqXDNtuyorgIobcexBirBMN2rzvYwq7zo3I2C1ychM48FBWiCEDLYza7J9QxLDAHNk3y/s+X
 i82WCl2e1i9Z4tWaE8Ab2S9atpeBzFphVzNY03bTY+XVYxiLZCMI6oazvy/nBl28hJe10sjgNeA
 QulTUgPusxYrPON43N5dkUYPLi4BtYSrdsxKsRKnaltKUts2E11zg7h2V9O+NiaY705+8BNr83b
 8HBBNol3MlKyddhxEBQZ4YEXGvebW+mZzuAnupt4k7cVLKG2V9WKM+Rff5h664+cigGakRBGauz
 mWeaHDTMOhB/17ee+L5i24WGPV0m8NgKN2x/pnZVJWg/7EsMa+RSiGDmTWr2dQrz7jaj+zyz/Pi
 nLmKSbUCWIhkk4+qXhBFLXSv2oRpzEwZ/F8OhrbUk26m/jWd6gthf5a20R1Wfgl7G0Jcg2PYpKb
 WT4KfbcToxGiPaKuZ8g==
X-Proofpoint-GUID: GLMf8NRTyrZdLrNajisY205jfMJtY60w
X-Proofpoint-ORIG-GUID: dzOfU4ZE_-YUMjlSufzn7kqNkpFs2i1s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXwQqP8FN2nHys
 6MPXgJRRTOWkrx/D+sxs+x5oqSuGPHG0Uz625DwoZDSmwpmk1vHeJGuSpv0+sKSnd4KpMJLcHTS
 XyoV/nJ3Mbk6X1qwf3MTkSzMZpVDbG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

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
index e242417ed8da..db6188cefffe 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -827,7 +827,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	napi_disable(&adapter->napi);
 
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
-- 
2.39.3 (Apple Git-146)


