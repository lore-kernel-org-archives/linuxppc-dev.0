Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13860A2638
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QNc6ghHo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXyp96PWlz3bV5;
	Mon, 23 Nov 2026 18:52:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420337;
	cv=none; b=bBCJ5kreMAyDF1wBnwhvkaU1vkBmUvoDi774UCTYhj599//yXHopQg4JrT0ELp86rkz/+W7+4SsKQ4wqp9a9N9m5KR/Gd5gHXRkvul5GThD7kj6Jxq4wOm6p1nly4lCW6GFRRKNBCAueD8hmsXV22ZnbRozbBq6hYUr6Lh8WgapS1QyHItJHvlIJCCK73B/DmxGugB9eQ1S+F14aGac5hP6kFfIC5VODOeOdp/488Ojpe2H71atMsbJ+j7pTSPvJ26bzcGFmCtqmHKBO3DGGZqgSZULrwQmDzqbXCC1/zHO4X8Bn+JaHuY3wnZHOYsf6RIV7aCpKsAH/PjWZlMQtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420337; c=relaxed/relaxed;
	bh=cT+MlHWvuJL08KcOvFTn2ndQQ41yeO1U+j0X7W5doJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUQKLsDKnfkOzMIy7UfCOrLHXlOT8bVKs6JwZesP/Of8B9YxDwQUUmzGLyhKHcLcE/iIBnnVc93XpLV2DjeBNJuwPb/GATB820AYR4E/sKKdbVXOUzLksgZkLj+GYtBdzUP65JE67ORI1IEbSIFcZ3b57yCkXr+d6skdp8EB9JC/N3/H49/qMrDCKuVGblWhPT8gikmxqK0jxSkoxOQxj6+qnKsunp5/Kl3qZp0nEt3q4LVylVKFcKh6jCy+uhD4qu4a4QPDUFV4onYxRCpZ8FggYDBLgP/rDYmGTvobX1iHo0wr9OTgsa8QNvp9z9UTKbxhS2xeUSfrGjL/n87a3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QNc6ghHo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QNc6ghHo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXyp90pCmz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:52:16 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54p6J2633212;
	Mon, 23 Nov 2026 07:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cT+MlHWvuJL08KcOv
	FTn2ndQQ41yeO1U+j0X7W5doJo=; b=QNc6ghHohk5lWU3bgvgJDgUpHkWnEXTnm
	TtJvYPoZyeR/a+yuxp/9HkHYy/hR3YoZ2mBOvtUipJK2gf26rKiHs5Oj2LtlaylE
	hl3EApurgRrx6f8ulZioJZwueqRWBb4ELzgWtj5hpbMsa4QwCUbBUvUZF90UF2Qr
	TKOyUByrWXiWiwmNzwOnZNKmEPzrRwS498aRL8GZ9OiE9bK07pNVZGyYweQ+vcV1
	qKK3EScT5OzhxDdkF/+G59q1Au6Ernp1iVsyeBXPBSovfiU1nx0h93CRPcSXi8xI
	tKc2JJcqy3x/uvYHBaPw+GrUwlddlIQ8Z8TSY0wQDB8AhgJPciMjA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g11skk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54NIv1436581;
	Mon, 23 Nov 2026 07:51:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3raydgxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:51:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN7ppQC27394768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 07:51:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4BC05803F;
	Mon, 23 Nov 2026 07:51:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 626105805A;
	Mon, 23 Nov 2026 07:51:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.2.38])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 07:51:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v2 3/8] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Sun, 22 Nov 2026 23:51:31 -0800
Message-Id: <20261123075136.3278-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261123075136.3278-1-mmc@linux.ibm.com>
References: <20261123075136.3278-1-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Nx3pcnX1zjo5S8Hi6cN-VcPZCkumFdGX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfXzgVFLBV8R2DM
 ZrkVqMIzL5K2L27eAteruyuM39xx4Ag7ZVXA3U/0J8Emc/AOQ2HQuzWF4HptaRyz0DOLimWnVzQ
 QaVE0kwdrFt+mkEeJUEHiH5O9pHjbL0=
X-Proofpoint-GUID: ur1LBZRkwXuYomXp6pEGp1r08RzEKfS9
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b03f09b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=B-TeTARddAlAh3keUi8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMCBTYWx0ZWRfX2kDtuA9lwjhU
 QZh1RqhIm9k4ayASlIGMVRQ3vK4NsJrhzVgI41sGke7iZ6kv4zpnOKYrjcyo0MGkuYz+hpzSpHt
 dJ0fifhw7qnY5DMt71k6ta4KwW9U+4e/I1XhHV3m6/L57hgbfgap4xbLFIZkmie8sVT+GJwMdTK
 0iUHxlobSxXrkF4GCXLhz6vGtVOVY49gGZftcgT4BVwLEI8CzpWipW+E6Gaxz5gtljJwLmaFW5I
 LVsnEWvrboRL8XtK8BueBJvnz5HaZ+7bB8T80fn7L1QU7oD8aDF6Tb7VSh/0O4a1ATd5liwsnaI
 qI8v89PVF/ir91MQ9ULafW79w+PTgz3NOIvSpt7QFkFCF9/YIlyQAMwJLuTvZhykWDi8v6CcPIA
 72gGxrZlGEiKNvT5cWTYuOxcVvvGdRtBW1eC6dzOzSLAKXxCpjE//wYIR1+uQDzznOe0zPHZoW5
 Y3//UWSfu6kafWnuoRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230030
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
index 479f0099013c..fca741eb0291 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -660,6 +660,100 @@ static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
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
@@ -889,16 +983,9 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -932,11 +1019,7 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -987,14 +1070,10 @@ static int ibmveth_close(struct net_device *netdev)
 
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


