Return-Path: <linuxppc-dev+bounces-23214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27BCC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:55:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4g4Zp7z2yhP;
	Wed, 01 Jul 2026 00:54:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831267;
	cv=none; b=S1b/MZEWfF0Ob6dWEV+xmjW2eaPwGduWjN95pDJmJ/ATK+3I4HpS3ASDaAKBDyiLn9PmFZIjPGV700VsuyJJ8vdOav1gWF6cGt+HoErkfuWM/nzd902jnRpr0tYQFqJGt3/PqUORRwQPi+rCHNy19/MWJenLY5wrcsl+tovVTOpVQaDXBjy5a0cebc5brrC7kJoAChkpM8gDyYGAGkOGYeH6l3Gqz+MLgHC4I+PlmdSCfOPWuUJ+hUNgmqc9G3WH5WLu7/5T6WfLO6aEXViYg6pJzLy3jn6ZTvex5ukrd7DFVP3UwFf+7V40iYNswt8V1I1kvHMxYqeFX1EU8r6ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831267; c=relaxed/relaxed;
	bh=zxTeHAu7CJl9EE90CV1wDO0BEY6issVH4xMbCABDzvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+ZhYs4jZz22EvwcHEEoYEokw9JPFoYMJJAKfaHYdBu50aL5MC+tclWh4QSRSLid5SynGiFYECglREtftHt5HrxELjRTUQcdap4MFKhoVuzobwMXiKBbFsFa6pUu1DFP+WzStNMxReho+zwCb1cih8C29JaVzAVMgibNFE6FSXUKA4GteadgA8S5pkG81KUQO0lU1+sKUkDfHPjPMCt4Z5yUiFaPaJbeH4g+3X9EqS6iyIp1nM2n+QQcEJMLa2rhuB7Q+0Uqvo6vUztuZwFqOwZidI3HHGmqLw20fbntAiMFrioJqQGilCyuMtZhAWkFeEdSNECmJGkZInwrXSpUIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GgNap/rj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GgNap/rj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR4f6NvDz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:54:26 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIULb2429237;
	Tue, 30 Jun 2026 14:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zxTeHAu7CJl9EE90C
	V1wDO0BEY6issVH4xMbCABDzvA=; b=GgNap/rjBde8c+//y5u1qj7rpoly9y1fq
	AygkqtIIGm6NEroXlZISkFLCWJWfUc0kxXKvrgVKrzafAmxe4S52/i2/jtHWAeO7
	2RjaBN/cB4mkecuVw6UlA6qmW9CRJuxAz5R9gbEjsgMQ8nGxOUP0AUc4pz6wzt5O
	OkLx+IPINnC/L5JOUuGB1INFelm+qdbbM7akhdTpyVmIf/UgpPyhvWn6Mc9MbrmK
	as4OPqqf/EZUYjJ6o+l4llK5teJiYqKPxs9Tr8aspgCm1n30p3KLQZ8husq0sHeT
	xkNSSzbYP3SPrsyPpeQa8hNwVm3G2/xL7slLz42WlDIr+osXHIaDQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfycfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnkhc025257;
	Tue, 30 Jun 2026 14:54:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk2s56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEsGXT27394740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D605805D;
	Tue, 30 Jun 2026 14:54:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9047A5805F;
	Tue, 30 Jun 2026 14:54:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:54:14 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 17/18] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Tue, 30 Jun 2026 07:53:24 -0700
Message-Id: <ccbd3b3bbee2004da411bf76fdc8187908524c69.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43d89b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=2fKdve7Y1yaNzeJZRasA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX/Ruxp4vHFMnO
 AzUgJhbPMG5YUuY1xr9AjhLyNAFDBeB4XMMN6H7DUmVxh83DnTZyMCXvoDxVIPwEjE0b5MsWHui
 Rn0z9vQAQLix/lKa0vEjJCM0obAJOPk=
X-Proofpoint-GUID: tUqCDJRKp6_vU9R66CY-H7SCzGop4CEI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX/Mx+VYarjhHz
 7AIJtGk0x16GEkz/NywXxY3nqvf4OkUvhNUxcEZnwhYJbgop9RklEehw+uQzKRUy8zgUFcCKKZv
 2H4tlu3WS9VgwDGdcQkg4wswzJWVBlln5tadGQJTJP8MFZkB5ZJThjyBXERx6Uh8T/dmxko/+gG
 0H7ggNUhuSM+5vDm422hGUEQBUnsEhO5SgGQM0mVa8sf4BttI9r0Ps3I86bl/SQJGq/iknaTDhj
 PasBuQgw5YUaUF3ij0zr38Op5+D3hJiHIwyzYuzvVMTxXmIP7jtJuHp6qB3yxg6msWP/4cChFy9
 sp+W9JlhOJ3dndbPuOFyMjGckOxHHB9XQoCHdImG/WTv0ckBHAVogSl81jeiXzfv0uf8yngkezU
 QbnRVl1EDyTKuxSmPFjGSVCvh+tybL4ydsmtMTFoHLI6D30CdI7gO5mH6OCA1frsc68vNUevH1Z
 EUkjiO1oR+Pm+O95cdg==
X-Proofpoint-ORIG-GUID: _-syxO7KT0csP5xDM0Vkhn5wO8E_LrQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

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


