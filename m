Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EB606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S78BghDn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJgy0YHxz2xkr;
	Thu, 19 Nov 2026 11:07:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046862;
	cv=none; b=UR5g6GOrsNC5Qi9rqll1F7Y8K1s6GKyMzTsh4L7ijMPAn5Rbe+TICYo54d2/048GT51m7xyAVJYXffxvBa3E2gmtrGT/4M/96Rl81tOYco4yuJIFKXbGH/hyUNmWIgwKl344t3L/kXpH20iGYlCmHRwdRf9x4hdm+6iTqTz8h5wiyJnbStLD0R7TfMFuUqQqVOE2FGkX9FcWS4buhDKb9dzktR8mIoWim0k3K5jIg+rHkPckyYce0hEbXxtZKemSyTX4KLCP3WbccaRvH/syniKG//E9gl6USM2PUEGrJDsbI0z8vgw0Yej37ynAAbCWgItI/AeY9ByF0++vpyWzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046862; c=relaxed/relaxed;
	bh=x3eKF68wPXRQM64TjaUlzJWD/D+4ifE8IGA9ToqKUIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIJMcKaLb7I3cFWfR5yPZxur9gjI43L/9Zr/yFhrYTcnyRn69CMhoDUeNwM5lRPPU8AlQSK3vN0xRrsggQzz9CNrQ/lN4kn1BEr861AxWxlTQngLCRDS7EtWWsCafzD4n8RCUla8QYbKKzxNG+ZdKlMz6YMTQwmnc/1Yo1dcLY84cGryAhyfamssGv5UkPtTHjh+yJYvBuUhdQdICWMO20YgZBsoYZPyopIyVtZ/6D1XnVLrIYPI358DnS1rSDlxQpfy7JLIddRHFkibmsgCXmXTclHermOUZw0vqIM2AoG9kTB2xl/RZKX+hlaqOVmlEIQxVYPf8zBQ/pK/qWcmPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S78BghDn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S78BghDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJgw6bsFz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:40 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQYXA2211917;
	Thu, 19 Nov 2026 00:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x3eKF68wPXRQM64Tj
	aUlzJWD/D+4ifE8IGA9ToqKUIc=; b=S78BghDnIiagzsLsZGLrLQpo7gVsdioJ+
	ujJ8XUdVK6aOjC/hcn7Jqr0q6h33YruFAkw+2ZiVHKiz9xO0cuxK5f9AfRic3ze8
	NbodSl9gX6Cw5IZ+e4SzZ9vnkxvqZtUAaDwlGq2mk1X6tAQPkhfbmK9IItwgozCx
	O4pg6BaZDECsUD1jmPGNDGZJNI8xJ7hjR44GHfYRphXyjzqTjA5Nm+FfR59NdpJU
	doX01DXqhcnXmT4SKmjz7aN/NjDrD9++PnHxotNsyM7LrPHVSTwXBMtGUBPPmPib
	kIrbJwbQGvO75Ll3Zi04YsvpsdUj7eIHSUbNEKx83jN9Ngcb0yzlA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t59n8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK4x43990085;
	Thu, 19 Nov 2026 00:07:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6s16b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07SPo27591320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D8375805C;
	Thu, 19 Nov 2026 00:07:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EDEF58051;
	Thu, 19 Nov 2026 00:07:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:25 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 3/8] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Wed, 18 Nov 2026 16:07:06 -0800
Message-Id: <20261119000711.18093-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afe3dc3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=B-TeTARddAlAh3keUi8A:9
X-Proofpoint-ORIG-GUID: 4SDTeeI0ekTiJxKlNWw972CfoWX1Jt7O
X-Proofpoint-GUID: Rn3ntHV9_gKLhHylL1Cxk_2setPN4nXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX0kLqyeKbPk10
 KAy1bMywUTsHsqw5QcbYj5UU7FU7Rd2ZzABbtQNUlVYy1LBM6MirKLpFlzUqTKTmXNuWTT2cOFY
 NNXZc+d3LfEBw4ksO6zvEJrbEkkvHwT98Cz4yFFZaGeTiVW6eES2qqCYAWLvNjFRxJ+pibrlHIj
 e5jO1/CLh0/b0n1FARvWQ3AC/4eQ4MQe2R6PP8UIq74+CY2so0D2Vn41Tsa/hJpt6U9BwzN6RGa
 Nk658+PXRrD+LMuzTH8wKuEKVk2+7+jgBMaVJTMQz068n1VV5dwWlBSxyIsiC5t500fD177a1pU
 3NSrDcBFywaXzwbEunWqhiC1/CrVyq+NOxuB63AwS0eIAe0AWTM2Dv7EuKv418wElcgiLZc04Kj
 yMAAyBwSz2DkI6rruPevw3ey/169tSPiGqJgDksPqXKw0034jYBxUcM3iZn1YTnBAtXiylVbGEQ
 P4/4GAYxCPXZ6ptfMjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfXxt5lwZKMBIjh
 LS2J8vYZGtglfRL8AW1XrgKVSkgMBFLbU9VsSvymTYX26+CGpCUWFn4qOe7PlKaI4Fo0sVymKuo
 hQtncnHLuMq01ByoNcz8erWtp+dqMss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180088
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PHYP returns an RX buffer on the queue it was posted to, so each RX
queue needs its own buffer pools. Allocate and free the pools per
queue through ibmveth_alloc_buffer_pools() and
ibmveth_free_buffer_pools().

The free path now releases what was allocated rather than what is
marked active. close() frees the pools before the RX queues and the
filter list; the IRQ and NAPI are gone by then.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 119 ++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 559c4d2d957b..20273240d8fe 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -658,6 +658,100 @@ static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
 	schedule_work(&adapter->work);
 }
 
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees every pool on @queue regardless of the active flag;
+ * ibmveth_free_buffer_pool() skips what was never allocated.
+ */
+static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		ibmveth_free_buffer_pool(adapter,
+					 &adapter->rx_buff_pool[queue][i]);
+}
+
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates backing storage for each active pool on @queue.
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *bpool =
+			&adapter->rx_buff_pool[queue][i];
+
+		if (!bpool->active)
+			continue;
+
+		if (ibmveth_alloc_buffer_pool(bpool)) {
+			netdev_err(netdev,
+				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
+				   queue, i,
+				   bpool->buff_size,
+				   bpool->size);
+			bpool->active = 0;
+			/* Undo the pools this queue already allocated; the
+			 * failed one freed its own partial allocation.
+			 */
+			ibmveth_free_queue_buffer_pools(adapter, queue);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_alloc_buffer_pools - Allocate buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int
+ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	int q, rc;
+
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
+		if (rc) {
+			while (--q >= 0)
+				ibmveth_free_queue_buffer_pools(adapter, q);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_buffer_pools - Free buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ */
+static void
+ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	int q;
+
+	for (q = 0; q < adapter->num_rx_queues; q++)
+		ibmveth_free_queue_buffer_pools(adapter, q);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -887,16 +981,9 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_tx_ltb;
 	}
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		if (!adapter->rx_buff_pool[0][i].active)
-			continue;
-		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
-			netdev_err(netdev, "unable to alloc pool\n");
-			adapter->rx_buff_pool[0][i].active = 0;
-			rc = -ENOMEM;
-			goto out_free_buffer_pools;
-		}
-	}
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc)
+		goto out_free_buffer_pools;
 
 	/* NAPI can run as soon as it is enabled, from netpoll during the
 	 * direct close()/open() pairs or from a direct ibmveth_interrupt()
@@ -930,11 +1017,7 @@ static int ibmveth_open(struct net_device *netdev)
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-	while (--i >= 0) {
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-	}
+	ibmveth_free_buffer_pools(adapter);
 out_free_tx_ltb:
 	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
 		ibmveth_free_tx_ltb(adapter, i);
@@ -985,14 +1068,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
+	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-
 	for (i = 0; i < netdev->real_num_tx_queues; i++)
 		ibmveth_free_tx_ltb(adapter, i);
 
-- 
2.50.1 (Apple Git-155)


