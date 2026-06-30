Return-Path: <linuxppc-dev+bounces-23202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19AAC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:54:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4267fhz2yfS;
	Wed, 01 Jul 2026 00:53:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831234;
	cv=none; b=D8CpC0y9JCVwo+7AH08T3oagMR93GXvHuTDYVfTn/g10g7f9WWyEljHYclq3KsoB995fZ4d8sUDD3dNb5BLaja8HlNCHsLKwBFMbLdCfn+4SIF3numNXq+0wGrn35PL//3xMPj5cOWnlqTx395VuCvXneieg/FdAsgT8vYTARiUbkxG5iobcDcvObV6Rbgefao6yRyKDkLE8Hur4hm2wLEI2EK+gYswfYDhdeGM3P5xXxViYDuI+6uFYxFF3HbJYtEENspvc/YrNyHAkdEJVO4zw/eUB0haO/s9mlpSCK54uJ5i38DBNDyObcqvKQ98cHYVJaPMK44Hw4Hv3qCyGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831234; c=relaxed/relaxed;
	bh=+o5Amc5iulVU0PlsDiMVjtHS+X7NM4LvfgOvu9S3cmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbaU+E2EXkjjTWS5bNlo+bVlvWkGZ4aolV757T4i/auxKcQxD60W/B6Ewh/7WHShn7cSDZ7svKO/e/hYbbdfQfWzH27OFHSeaXlE1mDuBr9zjmCuZdPa0TQhEVOgOlhkxCMzgsu1bAqqfg/YZN/FTxwmnflU0fiafhbP2mATVU10mpx3UADPE+hAs1ZS7Pa2UphNTPaoRsn5dJp6bpxYA3gy2hvHiIs0mGNFIX6j0HaOeBAWs+44X4gfIZ3aRxXJV6sp29/NdTv1Y0GWbCLTzLfsmqfi/sMWuEfD2khPpdStfosyi2BvK99iVztxhug6D9pWeE7RnkJLwpCADpB+0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RsUATiw2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RsUATiw2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR420f8Hz2ynT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:53:53 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIGl62428579;
	Tue, 30 Jun 2026 14:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+o5Amc5iulVU0PlsD
	iMVjtHS+X7NM4LvfgOvu9S3cmc=; b=RsUATiw2WRiaVQ+7u7AOmNNcZ65osqjgs
	EiLWUEsR3776Xs52QM81ROoBncvy+T0LW1DQa6+7IgyJ3guStZRqwe+Wj8XbHncL
	ndrnOAbOD06PTb4h0fIJdQhhJCWRWoDo1Ygqi/7q11lHNo2mhZ+KvzLRw9Z8ZsF4
	kingZv32w2rEbvDxXv7gAb/zDcDFF2V+PBmqGwE7QUKAEl1sH7MMDjZ3a5QRQRmF
	IdRbxLnXgzDl/psxvIaoMV+rFY7wSau9NEk+oUcc/ifuqYnlhatBQZWxbh/5G8dJ
	I2OI6UuAlwhRd3HmYCNH1IyRDajqwtJ46vChGUv8mrQc5Q5x5h8Vg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfyc9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEncAH018145;
	Tue, 30 Jun 2026 14:53:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqaxxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErh4855312686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975D458054;
	Tue, 30 Jun 2026 14:53:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C4DF5805A;
	Tue, 30 Jun 2026 14:53:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:42 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 05/18] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Tue, 30 Jun 2026 07:53:12 -0700
Message-Id: <de1fa1e40388a2744e3ff40df9ea2233c5573cc4.1782758799.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43d87a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=EwAlCuxjz4Ba8aIfdx8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX+ctcdnzYGDAM
 Mnp6htp9kcDSqC/Rapg/mXV7jFlO7gtTviLZw0kR65POu8l5R1uWuC7qUf+oNT5hr0CqhETenpM
 6sO+GN/1ss1W8wb7z68kng1miFjFHtg=
X-Proofpoint-GUID: KZneo5r-eOp9PDpWQoTMeOUezejRpe5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX5WksfUuKv5VC
 7Oy3/AtJ+XrFOst8GONcvSnlFPjly19ag2zE0+3eUdd4E9nuRH8E4eXOlJ+p+AUcoJbUn4FmcNo
 Ad0JykNxQpAumXFYEq5lb/h2LhdPSNFLBkxY6iVlOt55JuTEdbvjoMmV5iD4lHtyhPhgR9AWbJi
 kiVwGDIHpsmk0r8qRb8FsHmgtWom1XM2162Vy3oYl1awJSk1Lc9k4DpBFGa3iFMgFvtWW576loT
 mQ7YXCILrGU9MrYTEAp2HihKTi+AcJWMMABi9OyWFP5Ut+GfpXBE5EAib/4bDmWRrtCiKjP3DQM
 c936b78z0SkT7AuKf4n1OVPhxRCvruSCMt6TfopkzX13Vs5oQmLZ1XrkQOdMtXdcaK1KgmVt0zV
 aP2LivHhgziocShD1dpKcz7+K2Z+h0UUDwqV/69VR+mQLSYiAHzKAx7hTuXECGpvpYN67l2baux
 AK2n+2RAANTOS4x4KWQ==
X-Proofpoint-ORIG-GUID: zTxhGzpSu3It9oQraOo0dwtz9JKxo8tU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

This is the key memory-model change for MQ RX.

Legacy ibmveth uses five adapter-level RX buffer pools (512 B
through 64 KiB slots). pool_active[] enables the standard-MTU pools by
default; larger pools activate when MTU requires them. With single-queue
RX that set is shared on one completion path.

MQ requires the same pool model per queue: buffers post with
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against a queue handle and completions
return on that queue. Sharing pools across queues would mix ownership and
break queue-local replenish/drain/teardown.

Refactor around queue-local pools with static geometry (still defined at
probe on queue 0, copied to queues 1..N at alloc time):

  rx_buff_pool[queue][pool]
  ibmveth_alloc_queue_buffer_pools()
  ibmveth_free_queue_buffer_pools()
  ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools()

Queue 0 remains the template for pool geometry (size, buff_size,
threshold, active). For queues 1..N we copy metadata from queue 0, then
allocate actual backing arrays/skbs per queue.

At the default 1500-byte MTU, pool 4 (64 KiB buffers) is not needed and
costs guest memory when allocated per queue in MQ mode. Clear
pool_active[4] so open() skips it; ibmveth_change_mtu() still enables
larger pools when MTU warrants jumbo frames.

Error handling is also made queue-safe:

  - if allocation fails in one pool, unwind only what was allocated for
    that queue, then unwind prior queues in the caller
  - free paths release pools based on real allocations
    (free_map/dma_addr/skbuff), not only pool->active

That allocation-based free check is intentional: later resize and failure
paths can leave memory allocated even when active was already cleared.
Freeing by allocation state avoids leaks and double-free corner cases.

This split keeps the per-queue pool design isolated and reviewable ahead
of the MQ datapath enable commit later in the series.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 127 +++++++++++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |   2 +-
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b8adc9935471..95068fb20dba 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -611,6 +611,133 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates all active buffer pools for the specified queue.
+ * Pool metadata must be initialized before calling this function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		if (!adapter->rx_buff_pool[queue][i].active)
+			continue;
+
+		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[queue][i])) {
+			netdev_err(netdev,
+				   "unable to allocate buffer pool %d for queue %d (size=%u, count=%u)\n",
+				   i, queue,
+				   adapter->rx_buff_pool[queue][i].buff_size,
+				   adapter->rx_buff_pool[queue][i].size);
+			adapter->rx_buff_pool[queue][i].active = 0;
+
+			/* Free pools allocated so far for this queue */
+			while (--i >= 0) {
+				if (adapter->rx_buff_pool[queue][i].active)
+					ibmveth_free_buffer_pool(adapter,
+								 &adapter->rx_buff_pool[queue][i]);
+			}
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees all active buffer pools for the specified queue.
+ */
+static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[queue][i];
+
+		/* Free pool if it has allocated memory, regardless of active flag.
+		 * Pools may have memory allocated but not marked active during
+		 * queue scale-up, so we must check for actual allocations.
+		 */
+		if (pool->free_map || pool->dma_addr || pool->skbuff)
+			ibmveth_free_buffer_pool(adapter, pool);
+	}
+}
+
+/**
+ * ibmveth_alloc_buffer_pools - Allocate buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Initializes pool metadata for queues 1-N from queue 0 settings,
+ * then allocates buffer pools for all queues using the helper function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, q, rc;
+
+	/* Initialize pool metadata for queues 1-15 from queue 0 settings */
+	for (q = 1; q < adapter->num_rx_queues; q++) {
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *src = &adapter->rx_buff_pool[0][i];
+			struct ibmveth_buff_pool *dst = &adapter->rx_buff_pool[q][i];
+
+			dst->size = src->size;
+			dst->index = src->index;
+			dst->buff_size = src->buff_size;
+			dst->threshold = src->threshold;
+			dst->active = src->active;
+		}
+	}
+
+	/* Allocate actual buffers for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
+		if (rc) {
+			/* Free pools for all previous queues */
+			while (--q >= 0)
+				ibmveth_free_queue_buffer_pools(adapter, q);
+			return rc;
+		}
+	}
+
+	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
+		   adapter->num_rx_queues);
+	return 0;
+}
+
+/**
+ * ibmveth_free_buffer_pools - Free buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees buffer pools for all queues using the helper function.
+ */
+static void __maybe_unused ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	int q;
+
+	/* Free buffer pools for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++)
+		ibmveth_free_queue_buffer_pools(adapter, q);
+
+	netdev_dbg(adapter->netdev, "freed buffer pools for %d queue(s)\n",
+		   adapter->num_rx_queues);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index f0dffe42e8fe..d2ceeccd5fbd 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -286,7 +286,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
 static int pool_count_cmo[] = { 256, 512, 256, 256, 64 };
-static int pool_active[] = { 1, 1, 0, 0, 1};
+static int pool_active[] = { 1, 1, 0, 0, 0};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
-- 
2.39.3 (Apple Git-146)


