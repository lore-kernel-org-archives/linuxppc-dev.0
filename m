Return-Path: <linuxppc-dev+bounces-25843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B236C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:38:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGT4Hkhz304h;
	Fri, 14 Aug 2026 17:38:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693089;
	cv=none; b=atZMgu5JhkQO8hfxqmJWRdKOCO+UWF8z+uR6h07sLwm5qdM1FODY8rMaozDx9eX1QHYGmGER155CXH1e6AQBvkIacvNYBvHfJ6xsrJ1hYtOtK8j/vDnagcdi3CKcm5N9EsupIsxGkwDXK6HPMSjGK+3Z0sO3QcwZeEtzYUy7ynfHJbkTZwcOLEScwsHGDAJG7b10YGX3Xqutg1qri0f68DAD9oT57QNVzo9vsjePlR9NQUXb/2QT7Ym/dkLRuQa1E0vcwWL8WHp5We+LSVf9C3wqg2gfHH5Nfha01UULO/BbyGuWG7rjope13MECsYRGRbADsZ5OKeYhll8ORpNvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693089; c=relaxed/relaxed;
	bh=YLdiN8XyKhv+vJU2+H7T83vVz5qrz7q6z8a+NnCbXyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZZGsQvcO9ISX/1inBrlANC+nn2xl2KMWR8lysQeFgm4n5oA7m5NaNmEv+fafoWl46Kac3UzZz2f2k/sCiWk3AOnw0jXpWUdyA1KqgeV7oxoJ58rJ7rlF3gBwx9ABP8AjUMkCwfET52MxrrIfLv26vre8+dOtrGGoC91j1zdygjTkxIyT7M7vPjOiI/tRe4HTsAcLaedRsHWfJZG72P8bk2ngnHIk30MFe2Xv3fo2wxKUEFKkUnYw2mr2gydj5ctvMMwvjol/7g6X0g8cvokTA5KuiuKKquObsGHAQz+jIuTCDsKhmB5bE02NZ/i6Xu5W4Mh+eH3qu6qgPxjvAna0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q38n//ft; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q38n//ft;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGS3dDJz300g
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:08 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4W5Tl059502;
	Fri, 14 Aug 2026 07:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YLdiN8
	XyKhv+vJU2+H7T83vVz5qrz7q6z8a+NnCbXyc=; b=q38n//ft4AYVlRYtvn+Upp
	RFkrCPt0f/urrK+FWdxrbBqfmiDq8zgIchb8W1a569Rj5Lr1W7Z43tceIZEoaesH
	NXCRvIw0zP+ja6HxVetZPZoD9FZA/GPTJMQPox0UaV3Xl5SjAgnyPXvgRCQ3Dxyl
	mp4VjAUwNNPrOtyt0laVH47GYDBlANTkUyNDaqX/siJGWgCs+b26j9EDym/vVMGs
	yjQn68GvRsImR0KxA2S3TunnPB6rIIHoTLpOlHtvLdKTuNh97Umi7DQLRO1CP/rY
	zc98qowpMKzohhHKQTOvYCKB/rQa0d6CDIavJOK+XsCeVcbNK7TrX2yWWdr/h7kA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3amns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:37:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7U6x9012468;
	Fri, 14 Aug 2026 07:37:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk6cxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:37:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7brwH66454006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:37:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F64358063;
	Fri, 14 Aug 2026 07:37:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF1E58057;
	Fri, 14 Aug 2026 07:37:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:37:51 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Fri, 14 Aug 2026 00:36:31 -0700
Message-Id: <20260814073642.24630-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260814073642.24630-1-mmc@linux.ibm.com>
References: <20260814073642.24630-1-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ec5d5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=9GrW9DZCARAA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1yVryQJCmEMRGJo516gA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
X-Proofpoint-GUID: tvK_HLV63eu9sveFsUnzqjE-Xm-go_Is
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXy0gwxiKZX2Mj
 U6MgKtUUGg7caQF8QXZzgumHsQtn2ZNLs1Ceaj5BFeylix4nvyfTWud2cdIXSKM5S7QleKZD0Us
 aGMCVIYeAVTlZpgWx8Iv9WQ1z+/u3cvqNyzDlU2yCLhFUkBotxGIBGkk9/OGR8kawlqX6mBZVI3
 1PwGI7y4tfZGkN9FvNhDHXhjK0XahBO3OCFtpdANuijdZ+stCAlDI1+aRDw4eF+SZefiVpIa72u
 YsdB3Eq5l0UO208+Y8EtDTc8jaZHDCu/Vum1y5a/PAFQoIR0VdzCvbOxlw8Q3/LtRqHFzZnGqA6
 dG2OogEWau24efK6BvE8szI7JApGBQtRVM7UoUwp0mDH0tR9uMrnxgK/VS5DNIUqUykLmoTPvHz
 jPrGt+TxHW97NCMsJ4CB5VZpy3Gqu51wwdpzLwnnHYzurHSX1PG/s/f2DWGYvL65w7GCohhJsH6
 niG34RTmSf85szPW0ew==
X-Proofpoint-ORIG-GUID: g5uRVFDDs9vTQULT87Vgz-CKKKT8eEeL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX638kgC5l6Fti
 TNQc0lQ0MxOODVNd65KGQZzYBBswFRIER4x19LQK7F6guRuiRbRF8xdDRmDv7011h4X31r9SK7Z
 iWbI+VVPLOxUJP9OPTLg4g3OSjIFaq4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

Legacy ibmveth uses five adapter-level RX buffer pools (512 B through
64 KiB). pool_active[] enables the standard-MTU pools by default;
larger pools activate when MTU requires them. With single-queue RX
that set is shared on one completion path.

MQ requires the same pool model per queue: buffers post with
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against a queue handle and completions
return on that queue. Sharing pools across queues would mix ownership
and break queue-local replenish/drain/teardown.

Refactor around queue-local pools:

  rx_buff_pool[queue][pool]
  ibmveth_alloc_queue_buffer_pools()
  ibmveth_free_queue_buffer_pools()
  ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools()

Queue 0 remains the template for pool geometry and activation policy
(size, buff_size, threshold, index, active). Queues 1..N copy that
metadata from queue 0, then allocate backing arrays/skbs per queue.
The existing poolN/ sysfs knobs stay adapter-wide on queue 0: writing
a pool size multiplies real memory by num_rx_queues (still 1 here).
Per-queue runtime state is exposed later via debugfs, not separate
per-queue pool sysfs nodes.

Wire the helpers into open()/close() in the same patch. Runtime
remains single-queue (num_rx_queues is still 1).

Error handling is queue-safe: allocation failure unwinds only what
that queue allocated (then prior queues in the caller), and free paths
release by real allocations (free_map/dma_addr/skbuff), not only
pool->active. Later resize/failure paths can leave memory allocated
after active was cleared.

close() also reorders pool teardown ahead of cleanup_rx_resources()
and filter-list free. That is safe here because h_free_logical_lan(),
napi_disable(), and free_irq() have already run, so neither PHYP nor
NAPI still reference the pool buffers or RX completion queue.

Keep the legacy 64 KiB pool enabled by default at standard MTU (same
as single-queue policy).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- vs mailed v4: keep pool_active[] = {1,1,0,0,1} (v4 set the 64 KiB
  pool inactive). No code delta vs prior patches here; SQ large-receive /
  CMO stay at the historical baseline. change_mtu does not re-enable
  pool4 at MTU 1500; MQ memory pressure belongs at scale-up, not SQ
  default
- Unwind / free pools by real allocations (free_map/dma_addr/skbuff),
  not only pool->active, so open-fail cannot leak partially allocated
  pools (v4 fail path freed by active and skipped the failing pool)
- Clarify kdoc: free paths use allocation presence (not "all active");
  queue 1..N metadata copy from queue 0 (v4 said "queues 1-15" while
  MAX is still 1 here)
- Document poolN sysfs size multiplies by num_rx_queues (queue 0 is the
  shared template; no per-queue pool sysfs in this series)
- Call out close() pool-free before cleanup_rx_resources, after LAN/
  NAPI/IRQ teardown (order already in v4; spell it for later drain)

Changes in v4:
- Introduce the pool helpers in the same patch that wires their first
  open/close callers, instead of leaving unused statics.
- Copy pool->index when cloning queue-0 geometry to later queues
  (needed for correlators; also required by incremental resize).

 drivers/net/ethernet/ibm/ibmveth.c | 161 +++++++++++++++++++++++++----
 1 file changed, 141 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 168940bfa109..1a428ee60d58 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -627,6 +627,142 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees buffer pools that still hold allocations for the specified
+ * queue (by free_map / dma_addr / skbuff presence), regardless of the
+ * active flag.
+ */
+static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue][i];
+
+		/* Free pool if it has allocated memory, regardless of
+		 * active flag. Allocation and active can diverge on failure
+		 * paths, so check for actual allocations.
+		 */
+		if (pool->free_map || pool->dma_addr || pool->skbuff)
+			ibmveth_free_buffer_pool(adapter, pool);
+	}
+}
+
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates backing storage for each active pool on @queue.
+ * Inactive pools (!active) are skipped. Pool metadata must be
+ * initialized before calling this function.
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
+			/* Free by allocation presence, not active — the
+			 * failing pool cleared active first and would be
+			 * skipped by an active-only unwind.
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
+ * Initializes pool metadata for queues 1-N from queue 0 settings,
+ * then allocates buffer pools for all queues using the helper function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, q, rc;
+
+	/* Initialize pool metadata for queues 1..N from queue 0 settings */
+	for (q = 1; q < adapter->num_rx_queues; q++) {
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *src =
+				&adapter->rx_buff_pool[0][i];
+			struct ibmveth_buff_pool *dst =
+				&adapter->rx_buff_pool[q][i];
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
+static void
+ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
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
@@ -851,16 +987,9 @@ static int ibmveth_open(struct net_device *netdev)
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
+		goto out_free_tx_ltb;
 
 	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
 	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
@@ -885,11 +1014,7 @@ static int ibmveth_open(struct net_device *netdev)
 	return 0;
 
 out_free_buffer_pools:
-	while (--i >= 0) {
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-	}
+	ibmveth_free_buffer_pools(adapter);
 out_free_tx_ltb:
 	while (--i >= 0)
 		ibmveth_free_tx_ltb(adapter, i);
@@ -928,14 +1053,10 @@ static int ibmveth_close(struct net_device *netdev)
 
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


