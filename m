Return-Path: <linuxppc-dev+bounces-23662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FFFC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:38:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvF4D0dbJz3brv;
	Tue, 07 Jul 2026 05:37:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783366636;
	cv=none; b=mpnhZBp8QOcEOmYWW5X3KhBws5nTvAXJscw+ZuJ7irmrdu9scyuZNwZKYn+6ptYSoLcIVvBwRMmRgab19zw9QsCNeL5r9HHS+yi0oIHWt3DgC4INFaL9MLmwUe9d838qCojga+kLYih1VV28GWVCbqqp5z4keeIDkVQVtlR3+A+ptkpQxCpsLOodmWQYt57zAClWAYhnX//MG3S5tRQDk8j12llOpm0jucpi5MWsJk/OFgOpGfIhRlnIgrPZ2MqT9ehwuANip0dRiJmb7dJ+GARTi1vAp7YzZiJF/I31fTS3UQsUccRDTBS63qo6VwcXgZ5nU79eFkoCJdTCsoh7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783366636; c=relaxed/relaxed;
	bh=zxTeHAu7CJl9EE90CV1wDO0BEY6issVH4xMbCABDzvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bq2Q0ThZ0F0FwyWdAd9xltBnthjC8RD02NGPGF7G6zdov56pTOnG9XbI+BO00qZnjzx3THOyKgEcki/yaHhaJnCOl3yO9ytHo5E3GRp6qIR0v02CpGcwRh3HpIH2i2IhPH3KP7yfMFiFz3uayO2GQVeqDZoMbf9si5e3WmZZEcFEDNPSZ5tfvNRobJ3lEYf/XYgdffCvnRtIqkr1B4tCIs/639aAfg5H+9Albxtg8zG+QCibuCrh3rvUHM0RwugvKRPW3WiwQIHbCN80m6cH7Io/dEGR2eavcd5rStm2rW+MncD+9Oz0PNM61Nlx9SViYZJNDaWelOkpCATulmbtNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVyrfjT8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVyrfjT8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvF4C28dFz3brc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:37:15 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIIhC4049887;
	Mon, 6 Jul 2026 19:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zxTeHAu7CJl9EE90C
	V1wDO0BEY6issVH4xMbCABDzvA=; b=OVyrfjT89X7xhqcLl8cz/7aFE02r9Y4kl
	0ilggy0A6U48Qy4Fc+lzyty0+NgV1FzjMcbzHA7LLs/VS4jLs6zuMb48Oj2rfLmu
	DoHV3Xa7weJLKqBGP0Lyj2cGOnpUnqMnqZ5YMRGyCgTLmUcuPd2zYXU2pvjhoCwj
	ZiAur+hVUZpsJablev1dND+N8EEcpNjDNUtWetSQzZKzragaPSqqz9Jv0i73mQc4
	ChFAmkS2tXqRxeR+L0RZ0rWWjmRbd4LIqNmaCLps0psAXNRlZzlNJ+lnaSY6JH1b
	zH3kVOxYADH6mvMBS9UkNTKMXC6+4K0T8VZw2A/uTDgrvRw4eFIXw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stskk0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZqS004294;
	Mon, 6 Jul 2026 19:37:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxr80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jb3mf66453870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:37:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC8545805C;
	Mon,  6 Jul 2026 19:37:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0D158051;
	Mon,  6 Jul 2026 19:37:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:37:02 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 14/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Mon,  6 Jul 2026 12:36:02 -0700
Message-Id: <20260706193603.8039-15-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PuoPs8r5rKUaAX0XdoL74Lch6N2uV9IB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXywqts3mkU43E
 HYEf/r5ZHinGv3Kc9DGFWa4bgk6cHOKGJKHmUZ5lTLgI/IXx5FEV1RJsgk2iQ807Zbcol5xebrM
 GAdhn0+RYpdLk/pFtQkKrCA30b2ix3E=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c03e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2fKdve7Y1yaNzeJZRasA:9
X-Proofpoint-GUID: d1t-F07jPnYuuvagBrDh1mn2ncPwZjJo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX/XXSjHjFF60u
 VQk8nnqHqo8LRSeqCL5IINe9dQ/K4z72lXb1jWKm3t2ril06K0rNeDRGh4e6kCOHKClqUbB+MVT
 RHJNXGogVxd7J440AGeCQ+jynKUxQKFuxncNgO/Oi8dAWjTWfjcWXR/yl0ED2xck2T/LXqmDp89
 in3In/RAUlhHrJPKIlhCQOE254d9+zrucr+xrHFNu49dXOaLnqKpbRP3HIhQdqBhEBeEjNe5Lqs
 q9t+xfGWhxby6tHT/W9kdsxFmEmV+/v2brG72bMK2qJR0M1cqmGFoVYea1X/cUwQXDBBeoDwRyt
 fWVIzzTZmqmXDWl+Ezf9u2EPwM2Rk+CFOTcBMx74EGmRGpwtYIDPb07o/3UcD8XmfH4NhHfOPk7
 oCTJ0fCW8G1XoHpyLWsiWU5XB7XElIx+gvb7cO/AIbnrE+PN+VPRPBgOVWDBkwtsNpTr+3wZWCB
 qzaAdEC+3E9Aurz8a0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060195

Expose incremental RX resize through ethtool channel control.

get_channels() reports rx_count from adapter->num_rx_queues and max_rx
as IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1.

set_channels() validates rx_count is within 1..IBMVETH_MAX_RX_QUEUES.
When rx_count changes and the interface is up, call
ibmveth_resize_rx_queues_incremental(). When the interface is down,
store the requested rx_count in adapter->num_rx_queues so the next open
registers that many queues. Non-MQ firmware returns -EOPNOTSUPP for
rx > 1.

TX queue changes keep existing stop/wake behavior when tx_count changes.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 58 +++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index ac4d89a66a8d..50a332ab83fd 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2534,19 +2534,69 @@ static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned int old = netdev->real_num_tx_queues,
-		     goal = channels->tx_count;
+	unsigned int old_rx = adapter->num_rx_queues;
+	unsigned int goal_rx = channels->rx_count;
+	unsigned int old = netdev->real_num_tx_queues;
+	unsigned int goal = channels->tx_count;
+	int rxq_entries = adapter->rx_queue[0].num_slots;
 	int rc, i;
 
 	/* If ndo_open has not been called yet then don't allocate, just set
 	 * desired netdev_queue's and return
 	 */
-	if (!(netdev->flags & IFF_UP))
+	if (!(netdev->flags & IFF_UP)) {
+		if (goal_rx > 1 && !adapter->multi_queue) {
+			netdev_err(netdev,
+				   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
+				   goal_rx);
+			return -EOPNOTSUPP;
+		}
+
+		if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
+			netdev_err(netdev,
+				   "Invalid RX queue count %u (must be 1-%d)\n",
+				   goal_rx, IBMVETH_MAX_RX_QUEUES);
+			return -EINVAL;
+		}
+
+		/* Stash desired RX count; open() publishes it via
+		 * netif_set_real_num_rx_queues() after queue registration.
+		 */
+		if (goal_rx != adapter->num_rx_queues)
+			adapter->num_rx_queues = goal_rx;
+
 		return netif_set_real_num_tx_queues(netdev, goal);
+	}
+
+	if (goal_rx > 1 && !adapter->multi_queue) {
+		netdev_err(netdev,
+			   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
+			   goal_rx);
+		return -EOPNOTSUPP;
+	}
+
+	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev,
+			   "Invalid RX queue count %u (must be 1-%d)\n",
+			   goal_rx, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	if (goal_rx != old_rx) {
+		rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
+							  rxq_entries);
+		if (rc) {
+			netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
+			return rc;
+		}
+	}
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
+	if (goal == old)
+		return 0;
+
 	netif_tx_stop_all_queues(netdev);
 
 	/* Allocate any queue that we need */
@@ -2580,7 +2630,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 
 	netif_tx_wake_all_queues(netdev);
 
-	return rc;
+	return 0;
 }
 
 static const struct ethtool_ops netdev_ethtool_ops = {
-- 
2.39.3 (Apple Git-146)


