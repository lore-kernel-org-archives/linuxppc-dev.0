Return-Path: <linuxppc-dev+bounces-26305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E660C624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:08:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXSD4K5cz2y2J;
	Tue, 01 Sep 2026 01:08:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188908;
	cv=none; b=Ml4glIekNyqsZIazq+5woCwSxRM6QGpbxOA5cxtyMfcrGfPXNNVU3YvnCYSWJu6e0lkytcZxFKJBdjTpO2vz0BwLXeDkIS3tVaf/J9yjLmFybbeW6jxiUD23rDo38yoX5oOtL0x6uwFU6Mu6L1ajKarBVdgGXtz93FMkF7K+KIytOlvyozz6UoaqKNqvb5cIhbw+B0V6DfzuR3lcCWwEvNr+NesU3r4WZMbUTeTodgjQIUYI2V8fEGKeyx/YeyXgLEpDNChNgD5TDL7siL1/TbxzKlu7mF1FLv6PrvX1eVIrOKCXPhcFjS18wOgh3RUxim9VnU7DuyHRNH3Cu6uMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188908; c=relaxed/relaxed;
	bh=B8Hq5lQfg2XTXCrzq32reQb5l5RNP6KigTYlBZdYv/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWApPyH6gcJo/tDgZn5dInfLTTquTj2wn2LXunhRuP+d1RnMRwmyNf1QszYqzfwwEGxq8+cOoZfZlgrRcm0B8lscXR17lsYk7w2+i6OyCdvGLsFEy1Oz4bOUMngQMC2QE4WZIwKkNpwiknlfqcxQLvgOfhP33NATgGzrmfVC7lWZ606PL5j5ABHq+42ARh0Y5nZIN6pEgsacpT7W9QT+rzAam6Mgf7LVClTH8m3iTmRtHeN1cjhS8MTeegg7tJBkp3R6+Ds65hg+PL85GLv3iRxipd/Hg07Cy4FdUa8DmbYS9zNV/FWMFQ9qJP1itKWUxNF2aGcVB496QtcSVWJ1Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GiKOD+b6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GiKOD+b6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXSC4hb3z2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:27 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9V4652837;
	Mon, 31 Aug 2026 15:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B8Hq5lQfg2XTXCrzq
	32reQb5l5RNP6KigTYlBZdYv/Q=; b=GiKOD+b6pHfpTA1pRjOCAWfZaHrgECAGQ
	TgTMBNqJWo1GYpwR2P8uV+ZQunt5Dq+8e/bdh6LYxI6XEM57wISwrebYTHNcpqgA
	51z9SmYOBUZuAjgm+LrlFkA/ku82SN0uX6X9OpJqV3HJYINhkTAgovM8arUhe6vX
	RuSPRx9Toin8gvHDSdOTM2ocpcpV3uNIAAOWRjJfg6X91QS+nPzVfS8MstaXRVs6
	H1N0EL1mZ1ya9DkACkpLE7S7T8U8hZZwC/b7kaLj4ddPpOD2CO1ORJB7CQ5smTnB
	F8foZt45nR4SJtnShbvutonyPLUBGDWEgWmMad+dj5oKGsi2jcliw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r2357-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuRN9005724;
	Mon, 31 Aug 2026 15:08:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6g1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF8EG233620566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:08:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E755805F;
	Mon, 31 Aug 2026 15:08:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B627F5805A;
	Mon, 31 Aug 2026 15:08:10 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:08:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Mon, 31 Aug 2026 08:07:15 -0700
Message-Id: <8cec120af540e5e355dd6a1d3a6498dc0a7a98e4.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9598e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lp0D4TrqX67ggtpjc1wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX5vhuOq4SRkrH
 FolQnBl5yGtRVoEj5f7Fo9BOT/eS/p1EE9LwIhmZ8P0vEr8Ef0fWahkvytQhQVfPR5bx0ciu2Sx
 vsKB/QJaDbxDr5+CRSS6zMDpmf6ZxHUfmS7fzALynJPeXv/5TTuj+Qu4MVZtSVBdRCjCUGJuOqu
 U7qk4bcdCixnJLTo+eZd6XnC/lhBrwoLr5zKNziTukAMzxV1Jj0kKl34WcIKo8d0Dn1a1fW0vi3
 cbUsDfhVI3pVe/iTS8WzDCkuXuGF5/3Pyxk5yyhrnVBa1Q4rJV3tZo6hJCogO1eVGKLALkO9EWT
 aBR9rSmxvTFB9t7LIsqjOXZX/wVhXwak47X3iJOLR2Or9JCKYwnIEHRhKAbNI/UxVpew4sLB8aN
 n7TNnfJmEeMmUG78llpCqtwH04BtylK9JBo62fcYowGfjkJGvdCVOviUtEaB+Ctp5VKHcxz60g/
 KIrT/i0AJV8cpzYFDFw==
X-Proofpoint-GUID: xsbRCMsajrAVflcO-WJEzHV2lX0FLwZq
X-Proofpoint-ORIG-GUID: FXeFOLG7Qmc3GDSBlKy20Ysu_GvS6Vxc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX4FAD8DfxBf9p
 5sd7gS+RpVL3G5hENWQVnotIXOIk4ohGqHrLHlEehE4dErvW0+ENe/RYuy+GKcADUWFZ8RQzrij
 pqYVtm3jsGjBx7LILfh+y4YvAnhjd8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

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

Pulling the pool loop out has one side effect worth naming: it no
longer consumes open()'s loop index, so a pool failure reaches
out_free_tx_ltb with i still at real_num_tx_queues and the TX LTBs
actually get freed. The shared index that swallowed them was
pre-existing, so there is no standalone Fixes: tag; the TX side gets
its own unwind two patches later.

Error handling is queue-safe: allocation failure unwinds only what
that queue allocated (then prior queues in the caller).
alloc_buffer_pool() already undoes its own partials, so this open-fail
slot is empty. Free paths still release by real allocations
(free_map/dma_addr/skbuff), not only pool->active, which later resize
needs when a pool can hold memory after active was cleared.

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

Changes in v6:
- retarget the free-by-presence comment to the later resize paths;
  alloc_buffer_pool() already undoes its own partials, so this
  open-fail slot is empty
- use %u for the two num_rx_queues dbg prints
- noted: pool-fail after register without h_free_logical_lan predates
  this patch; the inline pool loop reached the same labels. P06
  issues h_free before the pool DMA; P07 moves pools ahead of
  register_rx_queues

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

 drivers/net/ethernet/ibm/ibmveth.c | 163 +++++++++++++++++++++++++----
 1 file changed, 143 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index d2dad9e6068e..37a6d13e603e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -634,6 +634,144 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
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
+			/* Free by allocation presence, not pool->active.
+			 * Needed on later resize paths (a pool can still
+			 * hold memory after active is cleared). This
+			 * open-fail slot is already empty:
+			 * alloc_buffer_pool() undoes its own partials.
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
+	netdev_dbg(netdev, "allocated buffer pools for %u queue(s)\n",
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
+	netdev_dbg(adapter->netdev, "freed buffer pools for %u queue(s)\n",
+		   adapter->num_rx_queues);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -858,16 +996,9 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -892,11 +1023,7 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -935,14 +1062,10 @@ static int ibmveth_close(struct net_device *netdev)
 
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


