Return-Path: <linuxppc-dev+bounces-25842-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6ADC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:38:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvGS3Gwhz300V;
	Fri, 14 Aug 2026 17:38:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693088;
	cv=none; b=Q86hXKnK6lSLy7smwNHavWl+0Y4DzoDmgTCotn9QvfEDFhgDGgwBzYn+Ar6FwuyVgQPAStM9+4LY/1STql+O9u9wsAOLygRQysqfCjvDJf3fhYtrW/wYBsUcDiFKB5jWZlwbUIteBYPSVW4ZIRwz9HWT8sCFH9IQ/cv4wKfDE/HH7qmBSde7g2D7XkN0BR8nNeOy8s+eK4rdsxJcU5XaABbJlL/d9Az+IM1dos4T8y1LlK6DhZ+zlKebk/4DB6rIJPomVrmta/uWWMsEFxbbXwIG0N/hNa/uXiUNUYRr0cX3GxA4gx4XzSoqEZUnrfGgXw+T1z//pwDE5q8rMAWdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693088; c=relaxed/relaxed;
	bh=ImSwt1WKAD87FoBMtL0UAjBtXJCkRTa99ZKqnYA4a0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DC3WcXUtV7Nuwsn5FSY93sMOsFRvRg2W+KNe8sn5egIkTBzQg13IzoR/hnxL+aDqpCx7/TnLRDEO0W6s4VdlXEVJoglOLkC+6s9IsxhkwQPAtBgg9A8Cnt1kWeb2lkgMkmpicFc3IhLl44wTD1y07gFLRra9GrFqh4giICzkWMJlNZa+IIdkj3xNr9QK+QJG3OFhfz8ba1xzZCC2oQAO8wWO60pXQgLxeHs/TOwhpGbq/+rAh/hn+z42/bQ955FRnjKbglmHMgIGzZ0ag7o/RcsFo1/YLTSbkf4DvT7YIn+xHWNnGL8IsXc3M497f+DdnHEvtIOSn0dOkzCnJTAAoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tgnavClZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tgnavClZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvGQ6yjRz2yqd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:06 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VojL058584;
	Fri, 14 Aug 2026 07:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ImSwt1WKAD87FoBMt
	L0UAjBtXJCkRTa99ZKqnYA4a0A=; b=tgnavClZmMffVf210BAsliDVK/3oTK/v7
	7IDqcTTtgZQFzUmgdnAr2wxXHSsPGB72jK3zz0zYgHTrr1mSujjJ5xXFqnAXW8F8
	pFzwH7I6BcVBakOloSK8XWerH7E1p4ZB1+3WhauEt3yYneqD2NjUfzQYOlQe0bpq
	A9txIBuS5hSprnBgdXxfl02f25B5nn/HBsCP6CKkjjOIdT4lP2XxAwJtmafsKGZI
	adGUsCe6vjkZmyHd9xxfFn7y1UckiFnaXMnk7rYEljtRG8H/KL2LxuWsCRz3rNd9
	phx93AiDlF3+nqWuwOHKdJ8aXmbn3btiaK0tPFAfbvDBSM7zXsskw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3amnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:37:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QSf7018422;
	Fri, 14 Aug 2026 07:37:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wega8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:37:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7bj5V25887444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:37:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6BB258059;
	Fri, 14 Aug 2026 07:37:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1EE758058;
	Fri, 14 Aug 2026 07:37:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:37:43 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 02/15] ibmveth: Prepare MQ RX adapter data structures
Date: Fri, 14 Aug 2026 00:36:29 -0700
Message-Id: <20260814073642.24630-3-mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ec5cd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=QKubB1TU-qDChGv6ESAA:9
X-Proofpoint-GUID: ZIM0gDm3gvCqYusEi_FSLHCbspgyRAvB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX2HobJBivbdco
 vtcTkg4vZxAUdFy1lbV9uQZVr3E6o6m1GmxcO3bb/9v3lhACNfPZo7gZbVEnkuWCWUx1Uql5aEY
 uDH5KkoglzBHpEeJqZHpAd1nF4sxbZHj/uO9snlqAT7ppITGr1ObDItmkJkIH5J/q/QyVzxq4em
 X/3oondbjY3+zjgDvIvECyL+VOI1l2JtUBd6oAh0xzUykaGiU/laDiBkA4/c4tTV4qXEIoAElYX
 0fDo8KDpjrwhtpiDjBl9qMMJGPp5XSxIo2YI+zZ/s00TljKtZOaZ8/gDtlUPVvFKDUdCMqYVa5x
 yEQcqBJD9AMcxb02K/JN8aAWTQa2yADigsWO1fcGHTyra/2WESrSPRiij+YN5zV+hsG86mCckIx
 xmZJH0GIpoq4igGOT8qP+AYOrbmTnGhG8BYZK7P/7enBhY7SFpv1E7jAV3daCb+s03+LLpbZ9Ul
 kPecNe+cVkhHTTKtrtw==
X-Proofpoint-ORIG-GUID: F9fyJPy2YmypOq1h1URC2Wgi8mjRRlmt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXwxEXJBBECDOI
 KwALR5C6yGIhJzFldcbRd7vYrmkF0DDYcCLbpb6BVMjxg/n35hA9HGY2QB2e/b3tjVQlGolvAi3
 vrRYOFaZxDaFIktxLKS8iCDkJ4hhIVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

MQ RX needs per-queue state for NAPI, queue handles/IRQs, RX rings,
buffer-list DMA mappings, and buffer pools. The current driver stores
most of this as single instances tied to queue 0.

Convert those fields to queue-indexed layouts sized by
IBMVETH_MAX_RX_QUEUES:

  rx_queue[]
  napi[]
  queue_handle[] / queue_irq[]
  buffer_list_addr[] / buffer_list_dma[]
  rx_buff_pool[queue][pool]

and add multi_queue / num_rx_queues to track MQ capability and how
many RX queues are active. Keep IBMVETH_MAX_RX_QUEUES at 1 for now so
this remains a structural preparation patch; later enablement raises
the limit when multi-queue RX is actually turned on.

This patch keeps behavior unchanged by mechanically switching existing
references to index 0 (for example rx_queue -> rx_queue[0],
rx_buff_pool[pool] -> rx_buff_pool[0][pool], napi -> napi[0]).
open/poll/close still drive a single RX queue only.

Queue-0 pool sysfs (poolN/) remains the shared geometry template for
all RX queues: later patches clone that metadata per queue. Per-queue
runtime visibility is added via debugfs later, not per-queue sysfs.

Per-queue statistics structs and hcall_stats are introduced later with
their first use (register helpers / statistics collection).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- Drop unrelated style nits that v4 mixed into the index-0 conversion
  (extra atomic_dec parentheses, ibmveth_rxq_get_buffer() prototype
  reflow, get_desired_dma "Return:" kdoc, blank line after
  rx_large_packets) - this tip patch keeps only the mechanical [0]
  retargeting
- Document queue-0 poolN/ sysfs as the shared geometry/template for all
  RX queues (buff_size/size/active); queues 1..N get no separate pool
  sysfs in this series
- Decision: keep full ibmveth_buff_pool per queue for this series
  (unused embedded kobjects on rows 1..N); defer config-vs-runtime
  layout split to a cover follow-up

Changes in v4:
- Keep IBMVETH_MAX_RX_QUEUES at 1 until MQ enablement (same idea as v3,
  but v3 also planted unused stats types here).
- Layout-only: queue-indexed adapter fields only. Do not introduce
  hcall_stats / rx_qstats here (first-use).
- Defer hcall_stats to patch 7 (register helpers) and rx/tx qstats +
  NUM macros to patch 10 (statistics collection).
- Subject: "Prepare MQ RX adapter data structures" (was "...and
  statistics structures" in earlier drafts).

 drivers/net/ethernet/ibm/ibmveth.c | 206 ++++++++++++++++-------------
 drivers/net/ethernet/ibm/ibmveth.h |  17 ++-
 2 files changed, 124 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..7cb828b476c1 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -101,7 +101,9 @@ static struct ibmveth_stat ibmveth_stats[] = {
 /* simple methods of getting data from the current rxq entry */
 static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].flags_off);
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+
+	return be32_to_cpu(rxq->queue_addr[rxq->index].flags_off);
 }
 
 static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
@@ -112,7 +114,7 @@ static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)
 {
-	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue.toggle;
+	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue[0].toggle;
 }
 
 static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter)
@@ -132,7 +134,9 @@ static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+
+	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
@@ -386,7 +390,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr + 4096 - 8;
+	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
 
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
@@ -399,7 +403,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[i];
+		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
@@ -463,12 +467,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	struct sk_buff *skb;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
 		schedule_work(&adapter->work);
 		return -EINVAL;
 	}
 
-	skb = adapter->rx_buff_pool[pool].skbuff[index];
+	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
 	if (WARN_ON(!skb)) {
 		schedule_work(&adapter->work);
 		return -EFAULT;
@@ -482,24 +486,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 		/* remove the skb pointer to mark free. actual freeing is done
 		 * by upper level networking after gro_receive
 		 */
-		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
+		adapter->rx_buff_pool[0][pool].skbuff[index] = NULL;
 
 		dma_unmap_single(&adapter->vdev->dev,
-				 adapter->rx_buff_pool[pool].dma_addr[index],
-				 adapter->rx_buff_pool[pool].buff_size,
+				 adapter->rx_buff_pool[0][pool].dma_addr[index],
+				 adapter->rx_buff_pool[0][pool].buff_size,
 				 DMA_FROM_DEVICE);
 	}
 
-	free_index = adapter->rx_buff_pool[pool].producer_index;
-	adapter->rx_buff_pool[pool].producer_index++;
-	if (adapter->rx_buff_pool[pool].producer_index >=
-	    adapter->rx_buff_pool[pool].size)
-		adapter->rx_buff_pool[pool].producer_index = 0;
-	adapter->rx_buff_pool[pool].free_map[free_index] = index;
+	free_index = adapter->rx_buff_pool[0][pool].producer_index;
+	adapter->rx_buff_pool[0][pool].producer_index++;
+	if (adapter->rx_buff_pool[0][pool].producer_index >=
+	    adapter->rx_buff_pool[0][pool].size)
+		adapter->rx_buff_pool[0][pool].producer_index = 0;
+	adapter->rx_buff_pool[0][pool].free_map[free_index] = index;
 
 	mb();
 
-	atomic_dec(&(adapter->rx_buff_pool[pool].available));
+	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
 
 	return 0;
 }
@@ -507,17 +511,18 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 /* get the current buffer on the rx queue */
 static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
 {
-	u64 correlator = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	u64 correlator = rxq->queue_addr[rxq->index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
 		schedule_work(&adapter->work);
 		return NULL;
 	}
 
-	return adapter->rx_buff_pool[pool].skbuff[index];
+	return adapter->rx_buff_pool[0][pool].skbuff[index];
 }
 
 /**
@@ -538,14 +543,16 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	u64 cor;
 	int rc;
 
-	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+
+	cor = rxq->queue_addr[rxq->index].correlator;
 	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
 	if (unlikely(rc))
 		return rc;
 
-	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
-		adapter->rx_queue.index = 0;
-		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
+	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
+		adapter->rx_queue[0].index = 0;
+		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
 	}
 
 	return 0;
@@ -595,7 +602,7 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 */
 retry:
 	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma, rxq_desc.desc,
+				    adapter->buffer_list_dma[0], rxq_desc.desc,
 				    adapter->filter_list_dma, mac_address);
 
 	if (rc != H_SUCCESS && try_again) {
@@ -623,14 +630,14 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi);
+	napi_enable(&adapter->napi[0]);
 
 	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		rxq_entries += adapter->rx_buff_pool[i].size;
+		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
 	rc = -ENOMEM;
-	adapter->buffer_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
-	if (!adapter->buffer_list_addr) {
+	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->buffer_list_addr[0]) {
 		netdev_err(netdev, "unable to allocate list pages\n");
 		goto out;
 	}
@@ -643,17 +650,18 @@ static int ibmveth_open(struct net_device *netdev)
 
 	dev = &adapter->vdev->dev;
 
-	adapter->rx_queue.queue_len = sizeof(struct ibmveth_rx_q_entry) *
+	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
 						rxq_entries;
-	adapter->rx_queue.queue_addr =
-		dma_alloc_coherent(dev, adapter->rx_queue.queue_len,
-				   &adapter->rx_queue.queue_dma, GFP_KERNEL);
-	if (!adapter->rx_queue.queue_addr)
+	adapter->rx_queue[0].queue_addr =
+		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
+				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
+	if (!adapter->rx_queue[0].queue_addr)
 		goto out_free_filter_list;
 
-	adapter->buffer_list_dma = dma_map_single(dev,
-			adapter->buffer_list_addr, 4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->buffer_list_dma)) {
+	adapter->buffer_list_dma[0] =
+		dma_map_single(dev, adapter->buffer_list_addr[0],
+			       4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
 		netdev_err(netdev, "unable to map buffer list pages\n");
 		goto out_free_queue_mem;
 	}
@@ -670,19 +678,21 @@ static int ibmveth_open(struct net_device *netdev)
 			goto out_free_tx_ltb;
 	}
 
-	adapter->rx_queue.index = 0;
-	adapter->rx_queue.num_slots = rxq_entries;
-	adapter->rx_queue.toggle = 1;
+	adapter->rx_queue[0].index = 0;
+	adapter->rx_queue[0].num_slots = rxq_entries;
+	adapter->rx_queue[0].toggle = 1;
 
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
-					adapter->rx_queue.queue_len;
-	rxq_desc.fields.address = adapter->rx_queue.queue_dma;
+					adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr);
+	netdev_dbg(netdev, "buffer list @ 0x%p\n",
+		   adapter->buffer_list_addr[0]);
 	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
-	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue.queue_addr);
+	netdev_dbg(netdev, "receive q   @ 0x%p\n",
+		   adapter->rx_queue[0].queue_addr);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
@@ -693,7 +703,7 @@ static int ibmveth_open(struct net_device *netdev)
 			   lpar_rc);
 		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
 			   "desc:0x%llx MAC:0x%llx\n",
-				     adapter->buffer_list_dma,
+				     adapter->buffer_list_dma[0],
 				     adapter->filter_list_dma,
 				     rxq_desc.desc,
 				     mac_address);
@@ -702,11 +712,11 @@ static int ibmveth_open(struct net_device *netdev)
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		if (!adapter->rx_buff_pool[i].active)
+		if (!adapter->rx_buff_pool[0][i].active)
 			continue;
-		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[i])) {
+		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
 			netdev_err(netdev, "unable to alloc pool\n");
-			adapter->rx_buff_pool[i].active = 0;
+			adapter->rx_buff_pool[0][i].active = 0;
 			rc = -ENOMEM;
 			goto out_free_buffer_pools;
 		}
@@ -738,9 +748,9 @@ static int ibmveth_open(struct net_device *netdev)
 
 out_free_buffer_pools:
 	while (--i >= 0) {
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[i]);
+						 &adapter->rx_buff_pool[0][i]);
 	}
 out_unmap_filter_list:
 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
@@ -752,18 +762,18 @@ static int ibmveth_open(struct net_device *netdev)
 	}
 
 out_unmap_buffer_list:
-	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
+	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
 			 DMA_BIDIRECTIONAL);
 out_free_queue_mem:
-	dma_free_coherent(dev, adapter->rx_queue.queue_len,
-			  adapter->rx_queue.queue_addr,
-			  adapter->rx_queue.queue_dma);
+	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
+			  adapter->rx_queue[0].queue_addr,
+			  adapter->rx_queue[0].queue_dma);
 out_free_filter_list:
 	free_page((unsigned long)adapter->filter_list_addr);
 out_free_buffer_list:
-	free_page((unsigned long)adapter->buffer_list_addr);
+	free_page((unsigned long)adapter->buffer_list_addr[0]);
 out:
-	napi_disable(&adapter->napi);
+	napi_disable(&adapter->napi[0]);
 	return rc;
 }
 
@@ -776,7 +786,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi);
+	napi_disable(&adapter->napi[0]);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -795,22 +805,22 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
-	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
+	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
 			 DMA_BIDIRECTIONAL);
-	free_page((unsigned long)adapter->buffer_list_addr);
+	free_page((unsigned long)adapter->buffer_list_addr[0]);
 
 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
 			 DMA_BIDIRECTIONAL);
 	free_page((unsigned long)adapter->filter_list_addr);
 
-	dma_free_coherent(dev, adapter->rx_queue.queue_len,
-			  adapter->rx_queue.queue_addr,
-			  adapter->rx_queue.queue_dma);
+	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
+			  adapter->rx_queue[0].queue_addr,
+			  adapter->rx_queue[0].queue_dma);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[i]);
+						 &adapter->rx_buff_pool[0][i]);
 
 	for (i = 0; i < netdev->real_num_tx_queues; i++)
 		ibmveth_free_tx_ltb(adapter, i);
@@ -1448,7 +1458,7 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi);
+			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
 	unsigned long lpar_rc;
@@ -1573,11 +1583,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned long lpar_rc;
 
-	if (napi_schedule_prep(&adapter->napi)) {
+	if (napi_schedule_prep(&adapter->napi[0])) {
 		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 				       VIO_IRQ_DISABLE);
 		WARN_ON(lpar_rc != H_SUCCESS);
-		__napi_schedule(&adapter->napi);
+		__napi_schedule(&adapter->napi[0]);
 	}
 	return IRQ_HANDLED;
 }
@@ -1645,7 +1655,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	int need_restart = 0;
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size)
 			break;
 
 	if (i == IBMVETH_NUM_BUFF_POOLS)
@@ -1660,9 +1670,9 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 
 	/* Look for an active buffer pool that can hold the new MTU */
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		adapter->rx_buff_pool[i].active = 1;
+		adapter->rx_buff_pool[0][i].active = 1;
 
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size) {
 			WRITE_ONCE(dev->mtu, new_mtu);
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
@@ -1720,12 +1730,12 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		/* add the size of the active receive buffers */
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ret +=
-			    adapter->rx_buff_pool[i].size *
-			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[i].
+			    adapter->rx_buff_pool[0][i].size *
+			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
 					     buff_size, tbl);
-		rxqentries += adapter->rx_buff_pool[i].size;
+		rxqentries += adapter->rx_buff_pool[0][i].size;
 	}
 	/* add the size of the receive queue entries */
 	ret += IOMMU_PAGE_ALIGN(
@@ -1844,7 +1854,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi, ibmveth_poll, 16);
+	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -1876,6 +1886,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
+	/* Initialize queue count - always 1 for now */
+	adapter->multi_queue = 0;
+	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
+
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
 		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
@@ -1898,10 +1912,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
+		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
 		int error;
 
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 		error = kobject_init_and_add(kobj, &ktype_veth_pool,
@@ -1949,7 +1963,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	cancel_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[i].kobj);
+		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
 	unregister_netdev(netdev);
 
@@ -2035,11 +2049,12 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 			/* Make sure there is a buffer pool with buffers that
 			   can hold a packet of the size of the MTU */
 			for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-				if (pool == &adapter->rx_buff_pool[i])
+				if (pool == &adapter->rx_buff_pool[0][i])
 					continue;
-				if (!adapter->rx_buff_pool[i].active)
+				if (!adapter->rx_buff_pool[0][i].active)
 					continue;
-				if (mtu <= adapter->rx_buff_pool[i].buff_size)
+				if (mtu <=
+				    adapter->rx_buff_pool[0][i].buff_size)
 					break;
 			}
 
@@ -2213,11 +2228,11 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 
-	pool = &adapter->rx_buff_pool[0];
+	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
@@ -2225,7 +2240,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
-	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0].size;
+	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0][0].size;
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
@@ -2258,30 +2273,33 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
-	adapter->rx_queue.queue_len = 1;
-	adapter->rx_queue.index = 0;
-	adapter->rx_queue.queue_addr = kunit_kzalloc(test, sizeof(struct ibmveth_rx_q_entry),
-						     GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue.queue_addr);
+	adapter->rx_queue[0].queue_len = 1;
+	adapter->rx_queue[0].index = 0;
+	adapter->rx_queue[0].queue_addr =
+		kunit_kzalloc(test, sizeof(struct ibmveth_rx_q_entry),
+			      GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue[0].queue_addr);
 
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 
-	pool = &adapter->rx_buff_pool[0];
+	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
-	adapter->rx_queue.queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator =
+		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
 	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
 
-	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | adapter->rx_buff_pool[0].size;
+	adapter->rx_queue[0].queue_addr[0].correlator =
+		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
 	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
 
 	pool->skbuff[0] = skb;
-	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
 	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
 
 	flush_work(&adapter->work);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index c0ef03cad9b9..fc6a01e810c6 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -257,6 +257,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
+#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_PER_HCALL 8U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
@@ -293,18 +295,23 @@ struct ibmveth_rx_q {
 struct ibmveth_adapter {
 	struct vio_dev *vdev;
 	struct net_device *netdev;
-	struct napi_struct napi;
+	struct napi_struct napi[IBMVETH_MAX_RX_QUEUES];
 	struct work_struct work;
 	unsigned int mcastFilterSize;
-	void *buffer_list_addr;
+	void *buffer_list_addr[IBMVETH_MAX_RX_QUEUES];
 	void *filter_list_addr;
 	void *tx_ltb_ptr[IBMVETH_MAX_QUEUES];
 	unsigned int tx_ltb_size;
 	dma_addr_t tx_ltb_dma[IBMVETH_MAX_QUEUES];
-	dma_addr_t buffer_list_dma;
+	dma_addr_t buffer_list_dma[IBMVETH_MAX_RX_QUEUES];
 	dma_addr_t filter_list_dma;
-	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
-	struct ibmveth_rx_q rx_queue;
+	struct ibmveth_buff_pool
+		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
+	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
+	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
+	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
+	int multi_queue;
+	unsigned int num_rx_queues;
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
-- 
2.50.1 (Apple Git-155)


