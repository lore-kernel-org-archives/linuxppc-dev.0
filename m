Return-Path: <linuxppc-dev+bounces-23325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72BCC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:25:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF2h4qqwz2xd2;
	Thu, 02 Jul 2026 08:25:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944732;
	cv=none; b=WS/MpzpPcGz9qeE5aXpuKnvkMVckCA7kR+pkLXlV7qDr4OBlgaH54E1tue62JxdtBdhal4wHQ1jSNs1ZhernTyJoyxu3WPv7LbKOjCWeBBLSR4r4/XVpnjLObQhS+J0td5Bjsyxzll22YL+aqw973li39w+f3ZAqCJzsAg0ipg/SZh76uZ7Qh/kgRPEBjzSxLrZpJUUwsX/lUwO7zJUNl0COowV3KcV4nQ6Cr2XTp0WrwQbtu/rhwmvIHwUSuJ48Ylz9x7U/EIdLTcYlaxxJ+Z2dSe56SljrnYWMLxJnumN6GJNy1Xu+kI5r7YmXDhrWRxuCNQo5TMXpU1HJfO+qGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944732; c=relaxed/relaxed;
	bh=+o5Amc5iulVU0PlsDiMVjtHS+X7NM4LvfgOvu9S3cmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGwr6Uk92zNHyDOmn0TrW8WuDXC9r/u2AG8A8FP7TzMpmCl9arzukj3NtZXwijqmpvJStKx8hFK/mDX5g+CCfqxprTgaroDpqbNQf7CR/sDX1obsCBwjAcPq6ZgaXBANf9DMIsvawQldZ2pKyNWtnJcvREzZUnAerc2HVcwbkUsgBQJtxAIPKy8nNJTedLSLBH1g48ycRI9m06C1A2Q0qrmpkLMG57tY1JH2Aa4BKWASD+1Kt/il30BhyPsxmHpJSXS8kjkA84aXUTgQR26S8a76uQsLJdq/wONtSya0Zw1bbI9FXRLFMxwu/xStBzqqF4GrRFaHwM3FNt6gdPTJEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G2Uh1u5D; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G2Uh1u5D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF2g3Z28z2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmSjr1925992;
	Wed, 1 Jul 2026 22:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+o5Amc5iulVU0PlsD
	iMVjtHS+X7NM4LvfgOvu9S3cmc=; b=G2Uh1u5DTyTJ2UULLmr9HNlPwIG2b5hw/
	nSYv3EjaNsK/z0toiya1s3m8Wub7Hy19+ROlNOoGl5XiEwE3MQ6GYqgno/qr5emC
	2GIjE+eqz0a3nwSWWnpx9viWwu0XEbhdaMnixHwtx95hWSRKH+mrAHuZ83ZAjJxH
	+oHNcwL40yLyqC7y5XRUV1u07LbGiCXOIkeTEgLSuksTIPnlIvKFGnLCoGihHGjs
	Hy/kjpjhpV+c+flL3ZMtBWPf6ie8p8THJjyI5XKh7dieo6ghCeAayhRLIXtiobiK
	nTojcGoPoy7fETI/oBzUJfBhyBdIxj3/KpLW2nc7jQ78A+KWfc0eg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjxm2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJbpJ028852;
	Wed, 1 Jul 2026 22:25:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9fhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPIuC57540934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3591B58059;
	Wed,  1 Jul 2026 22:25:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EBC858055;
	Wed,  1 Jul 2026 22:25:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:16 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 02/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Wed,  1 Jul 2026 15:23:14 -0700
Message-Id: <20260701222327.61325-3-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX3jtBJWVyAgaF
 va5Ez2VwrDC33QhLF2jE5TF2/rQxmGiyrYPHcSblJjTQ//mmfUQ651AVqjCIzgXWE2TtxZuyM8V
 zs9kJ19ru3edhypOiu0ZqgI9xJQ9qRThlQSHkGKBW7pJqzn57+PFlrVNpss9CejUf0qyJRDq9LQ
 jBAdcbTD+NOTMxPdTmEqTbrJLu7CCxGfebdmoln7TZAKKlKbFlD5wQuvWGc3z23IZAN45yyugLj
 emBswIJayY9wEgjymFxBDZpVBzz4azZVNHEq15gUWNxa2ewHYfDu9BpT7INsjf4JOVIHZon7FJE
 QBSOUvi220x1Q8utwXyPvHNzan3QRLbwPvKZwzLf3hn/LgOEeKUdi80Xvtw2Yv5UgR/smgL+T03
 y8eVcLroS5vtdwbRfnSBFruGUO7r1nmReEqhidb8VwYaUrJZuTc61xInVTj458j+UOjIwF0xD9E
 yJBBSxdSYNe9gNnmoIQ==
X-Proofpoint-GUID: BOY7eBq546nO_vOgJqmU_ZNrI2af1MET
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a4593d0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EwAlCuxjz4Ba8aIfdx8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX6ERu8sB/7V7g
 y6HpRkxCEpz5s1JICUksxb41gGuGqNFM6MKEOjU750WUkisXcJTQOUlNuWGcGOS2uIAxV0AGA/i
 3IkepvTJnG3UiwlDnYo9yi08YCbPkW8=
X-Proofpoint-ORIG-GUID: UyRrTnfz8CpAFDy_AgmckaV0uXdC-qNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

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


