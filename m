Return-Path: <linuxppc-dev+bounces-23337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C08C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:26:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF3J0t98z30T0;
	Thu, 02 Jul 2026 08:26:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944764;
	cv=none; b=bEC3UNbsDRnw+YeBxIhXLiTiYzWkZB4BRNnJxHFBPCzDzaQ3QIBmMsGQdYUv//ZS/3RFWCyRDxgOyfdTBSZ6H+lZ99tVjtmZnTJwHc5FPEcmBamQNIMqzfDZdYhvHLIjuCpMlPTPqQx3+z2X1vyEBOFd6fhNsIsObdnyBwXLb8aHNatMD9ahsuGMqTCMHCxGBvTTnB2DaRTvkxj+p99scgxbrT+3uhFtQy2qZvCBaqJeCw4Hr/jBmR+HmsRHPQMRUbpw+z2oTaRU5D7HfbdF9RPhHwOCNQMDwe8WSVrKzQVHIlPIt2Bn1rPibdhN4FhFOp12yHReL026DnGX1+YU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944764; c=relaxed/relaxed;
	bh=zxTeHAu7CJl9EE90CV1wDO0BEY6issVH4xMbCABDzvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9vHRvSgJmBPPnGWji6qjgQEKDSpi2pkrTrch3Ze/GuoC1FJJkosU6FHP5FoDdmJU22mxXP4QKUArADwyhhFR/kiDL7AUtRRz+tSwv8jR7/qrphA8f1e8efEBf5RdNxNe9dcGTrUrFahHKyH1ckEnB6mqX0p2YW/C8eVvGph1VOEyLQ42+Cu1LuRUwxIKLshApbaNI7iqp30qLmlimVdVNQgiDBdZ2sbBp89oaGLvAnGYbXQfJTuAkao3PVY2oEKAVryOvMZoWI2CyDS3of4N0vUOtofJnwpu9q4VUoPMDU0UpFhY+QDCYX0M8OWWBAqNwwN0G8Ub6hLKeCb7MsJ/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DBUTpquC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DBUTpquC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF3H29fPz30QJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:26:03 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmagW1971304;
	Wed, 1 Jul 2026 22:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zxTeHAu7CJl9EE90C
	V1wDO0BEY6issVH4xMbCABDzvA=; b=DBUTpquCYYGuYPBRPJrhYqwJ118NK1OZb
	dJbJVUiYbehQRtNett2IJP7suDqs0czA3tgaA7A9Q/XuLMuN70EcSKincTPfdutT
	OW0cxtdhokcoWS8NGs76dUgw8mZvRi4dPMPSXuRBUfYTEseQsR8wEI5j1jK8ltP/
	DZUsFIvDlxjYmBT4NpzoIxfv3sAvX9Jfyf64cF9wW3fjDghdCquZLeguDRvyBE0c
	iGUZzZk7/HWZc6uvJ6ITL6CoANi4rOQskg5onJGgfBrPeACT7x0yv2DZfZMprdg+
	aExlymNG+H/+nVwyqCHTKCuNXBydK8sgw0Q6W+8lDaLqUCy6wQNZg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf6g6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJhgL029047;
	Wed, 1 Jul 2026 22:25:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9fms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPpWo14025444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A1A15804B;
	Wed,  1 Jul 2026 22:25:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4B058059;
	Wed,  1 Jul 2026 22:25:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 14/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Wed,  1 Jul 2026 15:23:26 -0700
Message-Id: <20260701222327.61325-15-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4593f1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=2fKdve7Y1yaNzeJZRasA:9
X-Proofpoint-ORIG-GUID: czPz2pRU4l3macI0vyn9yGcwrqrW6-Nu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfXw6xB8NkUD3HD
 xTgnTRWpkha9HrBLVbamZhYZah6dksC0jCbWuJghxMbwjuWxTtW1g6/Rxhi8UWxmf8vyb6NmdFI
 +86bp+9UspA8uE9NiHu1ktLF3elxRQuZqwUWYVPoo5SOtflRADenduMO3CJpKOYKwHChRLcgivH
 PRwvpBLeT535oiSaQz3sutnvDj3GtKdTA4z2/l7PsLyf9A12BhdCqiAImR8K/Xn3pDD9YRQrmiR
 4XaOVb9le/46IXt3bg8GXpYvY3IXVGoGUx1KGp3BygIHaQtmx6hXNjrgznzLJjTqIL6oBhVRJKy
 TSmYMPovjIk3ZZZoMb7bM8IHqKd332wca1d6gbwNJ1msDcKMybLTQuN6+UOtXtKL2CGrlIXekL2
 lLmXk+cmmqiOuMzeBIkpchPI6g48Op4Xpc0JMJ26GcR34iSsb98fU2QZnN1j535VAzZpg6eUZ9m
 rQSXHzj691xPnNolFGg==
X-Proofpoint-GUID: GSS-mLPlb-3aOsWgR-xdo2jY9fq-sCtN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX6fm8H7RkCeaX
 phKkIGZDdJczSjA7K16HlzNGz2c7tYCv/anl/7HiuYA8mMWwdxMsi/mZYnAuyohGcUXwEx2MzmI
 hZfnogJuCXoakmbIY6vK/++jVoReETY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

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


