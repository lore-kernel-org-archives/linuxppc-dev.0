Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AD606A332
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kj2ORjjV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsF5f2Xz2xQs;
	Tue, 10 Nov 2026 10:56:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268593;
	cv=none; b=TZc4bj2nihoAgAUYiMJGRmSV+4CxYQqtIIPiL1Mg/vQ6W1/dK5i89YPodwI7X/NriQc7NRGpFlwvvtsKpU6aV6FXub1TGEFtd26WkY3TfYTvnZQzGv0KiH2dE5BrAhioH5mVZs0AJskpSRzx1v4jhbgvPL1+vK3bP9W49jWrv2OAOEnRgIeAu+6T456OCaPv1V7NMDBZphVBMvMCh24exGrBXp3aZG7RgL3Ows3+xoi9I0d97z/EdI0fIZyjTpm2TXOuvUvBmdVk7eeNj73xcUMTBUxkrDTx0aM/IilT/RQGUrk+OeeqiZcNfd5pBeIaQEMtrT3iAbYpYzfiZ4Hlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268593; c=relaxed/relaxed;
	bh=hJG62Kh5EVSi7GGWmH/cpq2LEOwrRcM/WV9v9tdZ+j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDnSSWc5Gn1Ejbo5Rc1NbLcvgLPthEg5qZE8tFp2tlVjP1XRu2Y8kAzgVUpXTe7ueaTqgD8lDg9QptQpOP4o2YX7hPu+z4azm4Y+x8EARVf/KasqYKPPSU5qV+kBZuopi+V0qZkc5l/dcsMh657d2rkbLJ1fKplMOAaTTn6Xy6/uW5Yqri6xWNeLUq1viVS2QYdWteawR0EM6s5NHZBNMesh0NZEq8jb6RdcjrCw9wKRZ201uXPDeqartQkY3akBGk8H4h/Ly1crKmRqueJ2Xf0Jdf/YfPw+okszJFuuPk8XzE5uAvZe41NuPd4Fawm1wPrbcuXEjIotDdxQG5bQrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kj2ORjjV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kj2ORjjV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsC1pVzz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:30 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEM5r3484471;
	Mon, 9 Nov 2026 23:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hJG62Kh5EVSi7GGWm
	H/cpq2LEOwrRcM/WV9v9tdZ+j0=; b=Kj2ORjjVaeYocaxtGw9irTr0RErlWk9nw
	OrGbMsMd+2e3OZ5wqLb8zP0r5zqLPIjYYPmJVJCaIhiKQTjXvYZxqsU4oxfGDdFp
	4JChiy5eA2aF+E4gb1mTlvU+1DndqZrV7DK5V+/OxXdtf0cgL5RvdSk4c24NQWD8
	QrN6JM9NXsbT2OK9M64APWy5ZxPEc/VYxaPW0uRTG00WBR46IipuWxP1wsbeG3cx
	7r6PWN4D4SorMB4XLiJ+sUm3rDwaYluE4hLifNqc3KxjGsr0Vv5uBf5au0a483cK
	30jd8f1KQon4L3e38Ym99s4qGBW64HIjV9BY2/IBcQqIvQx3ZecVQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg216q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LJuJi756255;
	Mon, 9 Nov 2026 23:56:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq4kev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NuGMs64291302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2C4058059;
	Mon,  9 Nov 2026 23:56:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B891558017;
	Mon,  9 Nov 2026 23:56:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:12 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v8 02/15] ibmveth: Prepare MQ RX adapter data structures
Date: Mon,  9 Nov 2026 15:55:43 -0800
Message-Id: <20261109235556.60604-3-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af25da3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=oUC61_QNbMdbXie2rGwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX0fMM/CaoK0m/
 KyaKXudpWSkK7Bi9qfV+rF919DyzIa++1ztX6Ht2Oq7r283Lg9hCs6fhQNsf/Zs2r5wXNJwp1ip
 9LpFqP2HXpaRRkDrWIbQJBt5rAmCI4hgWk6bwHcgH2jMiZyUG+z6juTGgB+lx/b+1QKpaVZ0Q7s
 Ujv3flZYxpU8SBP5ctAlifRxgGXcWMMtPZfpM8wO0NCpMCZ1BRy89bxuMH6y/Xfi8msdac7v3KZ
 E/pHUvYhLGgzuovnwq2mvv4IlxDTJzgbHNfHuYKWriSkT+lO59ztMxw7kxecURMSrj6iqbpu4mR
 MBGYRP/MOKwTl/1VHhXoWMDlo32NKJDW8EKn1E77wfFOHCf3QsX0mt9tF2X2nLIJPtyTPleKgGw
 QhFB4uTiaAo30XBcPqeXwflAA8FBzdP2tM3pLSFvWYT8oMtrlv70gxq0Zc8W4rf9VU96+U2OyJd
 JuvUAvGirJbKp1erIww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfXw87P79mnTwp+
 g6gJQmbd+A/q0d3w2Xfdi37kRqqYqXyq0c+0mcGxp76N/JdjyFEls15lOkrb3MCaAk4kHqmdhYh
 X01tzM+n713IaN1Hnn7TK1HvMFUv7L0=
X-Proofpoint-GUID: wdc9jUQtGC7JllJ2Nx6HLW4yJdVOmB8K
X-Proofpoint-ORIG-GUID: 0W-_yMeoOLXsBzpo90knaxsjte7PdJRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MQ RX needs per-queue state for NAPI, queue handles/IRQs, RX rings,
buffer-list DMA mappings, and buffer pools. The current driver stores
most of this as single instances tied to queue 0.

Convert those fields to queue-indexed layouts sized by
IBMVETH_MAX_RX_QUEUES, adding queue_handle[] / queue_irq[]:

  rx_queue[]
  napi[]
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

First use of the new fields: queue_irq[] and multi_queue in the IRQ
control patch; queue_handle[] in the register-helpers patch, which
captures queue 0's handle from H_REGISTER_LOGICAL_LAN; num_rx_queues
in the RX resource-allocation patch. multi_queue only begins
selecting between code paths once enablement raises
IBMVETH_MAX_RX_QUEUES above 1.

Queue-0 pool sysfs (poolN/) remains the shared geometry template for
all RX queues: later patches clone that metadata per queue. Per-queue
runtime visibility is added via debugfs later, not per-queue sysfs.

Per-queue statistics structs are introduced later with their first use
(statistics collection); the replenish_* counters stay adapter-wide
plain u64 here and move into them at that point.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- poll oversize check uses rx_buff_pool[0][pool], so patches 2-7 build
- rebased onto net-next: the merged synchronize_net() after
  napi_disable() and correlator accessors stay on queue 0 until the
  queue-aware patches

Changes in v7:
- no P02 code change

Changes in v5:
- Drop unrelated style nits that v4 mixed into the index-0 conversion
  (ibmveth_rxq_get_buffer() prototype reflow, get_desired_dma
  "Return:" kdoc, blank line after rx_large_packets)
- Document queue-0 poolN/ sysfs as the shared geometry/template for all
  RX queues (buff_size/size/active); queues 1..N get no separate pool
  sysfs in this series
- Decision: keep full ibmveth_buff_pool per queue for this series
  (unused embedded kobjects on rows 1..N); a config-vs-runtime layout
  split is out of scope here

Changes in v4:
- Keep IBMVETH_MAX_RX_QUEUES at 1 until MQ enablement (same idea as v3,
  but v3 also planted unused stats types here).
- Layout-only: queue-indexed adapter fields only. Do not introduce
  the rx/tx qstats here (first-use); they land with the per-queue
  statistics patch.
- Subject: "Prepare MQ RX adapter data structures" (was "...and
  statistics structures" in earlier drafts).

 drivers/net/ethernet/ibm/ibmveth.c | 240 ++++++++++++++++-------------
 drivers/net/ethernet/ibm/ibmveth.h |  17 +-
 2 files changed, 141 insertions(+), 116 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index e9874dfedf37..ecfa7f737dbb 100644
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
@@ -132,14 +134,17 @@ static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+
+	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
 static u64 ibmveth_rxq_correlator(struct ibmveth_adapter *adapter)
 {
-	unsigned int idx = adapter->rx_queue.index;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+	unsigned int idx = rxq->index;
 
-	return READ_ONCE(adapter->rx_queue.queue_addr[idx].correlator);
+	return READ_ONCE(rxq->queue_addr[idx].correlator);
 }
 
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
@@ -393,7 +398,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr + 4096 - 8;
+	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
 
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
@@ -406,7 +411,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[i];
+		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
@@ -459,8 +464,8 @@ static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
 
 	/* An inactive pool keeps its size but has no skbuff array. */
 	if (pool < IBMVETH_NUM_BUFF_POOLS &&
-	    index < adapter->rx_buff_pool[pool].size &&
-	    adapter->rx_buff_pool[pool].skbuff)
+	    index < adapter->rx_buff_pool[0][pool].size &&
+	    adapter->rx_buff_pool[0][pool].skbuff)
 		return true;
 
 	if (net_ratelimit())
@@ -504,7 +509,7 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
 		return -EINVAL;
 
-	skb = adapter->rx_buff_pool[pool].skbuff[index];
+	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
 	if (!skb) {
 		ibmveth_rxq_no_skb(adapter, correlator);
 		return -EFAULT;
@@ -518,24 +523,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
@@ -551,7 +556,7 @@ static struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 	if (!ibmveth_rxq_correlator_valid(adapter, correlator))
 		return NULL;
 
-	skb = adapter->rx_buff_pool[pool].skbuff[index];
+	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
 	if (!skb)
 		ibmveth_rxq_no_skb(adapter, correlator);
 	return skb;
@@ -559,9 +564,11 @@ static struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
 
 static void ibmveth_rxq_advance(struct ibmveth_adapter *adapter)
 {
-	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
-		adapter->rx_queue.index = 0;
-		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
+
+	if (++rxq->index == rxq->num_slots) {
+		rxq->index = 0;
+		rxq->toggle = !rxq->toggle;
 	}
 }
 
@@ -641,7 +648,7 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 */
 retry:
 	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma, rxq_desc.desc,
+				    adapter->buffer_list_dma[0], rxq_desc.desc,
 				    adapter->filter_list_dma, mac_address);
 
 	if (rc != H_SUCCESS && try_again) {
@@ -670,11 +677,11 @@ static int ibmveth_open(struct net_device *netdev)
 	netdev_dbg(netdev, "open starting\n");
 
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
@@ -687,17 +694,18 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -714,19 +722,21 @@ static int ibmveth_open(struct net_device *netdev)
 			goto out_unmap_filter_list;
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
 
@@ -737,7 +747,7 @@ static int ibmveth_open(struct net_device *netdev)
 			   lpar_rc);
 		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
 			   "desc:0x%llx MAC:0x%llx\n",
-				     adapter->buffer_list_dma,
+				     adapter->buffer_list_dma[0],
 				     adapter->filter_list_dma,
 				     rxq_desc.desc,
 				     mac_address);
@@ -746,11 +756,11 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -761,13 +771,13 @@ static int ibmveth_open(struct net_device *netdev)
 	 * call, so enable it only once everything ibmveth_poll() touches
 	 * exists.
 	 */
-	napi_enable(&adapter->napi);
+	napi_enable(&adapter->napi[0]);
 
 	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
 	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
 			 netdev);
 	if (rc != 0) {
-		napi_disable(&adapter->napi);
+		napi_disable(&adapter->napi[0]);
 		synchronize_net();
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
@@ -791,9 +801,9 @@ static int ibmveth_open(struct net_device *netdev)
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
 	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	while (--i >= 0) {
-		if (adapter->rx_buff_pool[i].active)
+		if (adapter->rx_buff_pool[0][i].active)
 			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[i]);
+						 &adapter->rx_buff_pool[0][i]);
 	}
 out_unmap_filter_list:
 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
@@ -803,16 +813,16 @@ static int ibmveth_open(struct net_device *netdev)
 		ibmveth_free_tx_ltb(adapter, i);
 
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
 	return rc;
 }
@@ -834,7 +844,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi);
+	napi_disable(&adapter->napi[0]);
 	/* napi_disable() returns once ibmveth_poll() has called
 	 * napi_complete_done(), but the poll still re-enables the
 	 * interrupt and reads the RX queue after that.
@@ -858,22 +868,22 @@ static int ibmveth_close(struct net_device *netdev)
 
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
@@ -1554,7 +1564,7 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi);
+			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
 	unsigned long lpar_rc;
@@ -1597,7 +1607,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			pool = correlator >> 32;
 			room = min_t(unsigned int, skb_tailroom(skb),
-				     adapter->rx_buff_pool[pool].buff_size);
+				     adapter->rx_buff_pool[0][pool].buff_size);
 			off = offset;
 			len = length;
 			if (unlikely(len < ETH_HLEN || off >= room ||
@@ -1730,11 +1740,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
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
@@ -1802,7 +1812,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	int need_restart = 0;
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size)
 			break;
 
 	if (i == IBMVETH_NUM_BUFF_POOLS)
@@ -1817,9 +1827,9 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 
 	/* Look for an active buffer pool that can hold the new MTU */
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		adapter->rx_buff_pool[i].active = 1;
+		adapter->rx_buff_pool[0][i].active = 1;
 
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size) {
 			WRITE_ONCE(dev->mtu, new_mtu);
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
@@ -1869,12 +1879,12 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
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
@@ -1969,9 +1979,9 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter)
 	int i;
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[i].kobj);
+		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		wait_for_completion(&adapter->rx_buff_pool[i].released);
+		wait_for_completion(&adapter->rx_buff_pool[0][i].released);
 }
 
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
@@ -2024,7 +2034,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi, ibmveth_poll, 16);
+	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -2056,6 +2066,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
+	/* Initialize queue count - always 1 for now */
+	adapter->multi_queue = 0;
+	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
+
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
 		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
@@ -2078,13 +2092,13 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
+		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
 		int error;
 
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
-		init_completion(&adapter->rx_buff_pool[i].released);
+		init_completion(&adapter->rx_buff_pool[0][i].released);
 		error = kobject_init_and_add(kobj, &ktype_veth_pool,
 					     &dev->dev.kobj, "pool%d", i);
 		if (!error)
@@ -2217,11 +2231,12 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
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
 
@@ -2395,11 +2410,11 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
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
 
@@ -2407,7 +2422,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
-	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0].size;
+	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0][0].size;
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
@@ -2447,40 +2462,43 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
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
 	cor = ibmveth_rxq_correlator(adapter);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
 			    ibmveth_rxq_get_buffer(adapter, cor));
 
-	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | adapter->rx_buff_pool[0].size;
+	adapter->rx_queue[0].queue_addr[0].correlator =
+		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
 	cor = ibmveth_rxq_correlator(adapter);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
 			    ibmveth_rxq_get_buffer(adapter, cor));
 
 	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
-	adapter->rx_queue.queue_addr[0].correlator = (u64)2 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = (u64)2 << 32 | 0;
 	cor = ibmveth_rxq_correlator(adapter);
 	KUNIT_EXPECT_PTR_EQ(test, NULL,
 			    ibmveth_rxq_get_buffer(adapter, cor));
 
 	pool->skbuff[0] = skb;
-	adapter->rx_queue.queue_addr[0].correlator = (u64)0 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
 	cor = ibmveth_rxq_correlator(adapter);
 	KUNIT_EXPECT_PTR_EQ(test, skb,
 			    ibmveth_rxq_get_buffer(adapter, cor));
@@ -2510,41 +2528,41 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
 
 	INIT_WORK(&adapter->work, ibmveth_reset_kunit);
 
-	adapter->rx_queue.num_slots = 2;
-	adapter->rx_queue.index = 0;
-	adapter->rx_queue.toggle = 1;
-	adapter->rx_queue.queue_addr =
+	adapter->rx_queue[0].num_slots = 2;
+	adapter->rx_queue[0].index = 0;
+	adapter->rx_queue[0].toggle = 1;
+	adapter->rx_queue[0].queue_addr =
 		kunit_kcalloc(test, 2, sizeof(struct ibmveth_rx_q_entry),
 			      GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue.queue_addr);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adapter->rx_queue[0].queue_addr);
 
 	/* Set sane values for buffer pools */
 	for (int i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
+		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
 
-	pool = &adapter->rx_buff_pool[0];
+	pool = &adapter->rx_buff_pool[0][0];
 	pool->skbuff = kunit_kcalloc(test, pool->size, sizeof(void *),
 				     GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
 	/* Slot 0: pool out of range. Slot 1: valid, but no skb. */
-	adapter->rx_queue.queue_addr[0].correlator =
+	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	adapter->rx_queue.queue_addr[1].correlator = (u64)0 << 32 | 0;
+	adapter->rx_queue[0].queue_addr[1].correlator = (u64)0 << 32 | 0;
 
 	cor = ibmveth_rxq_correlator(adapter);
 	ret = ibmveth_rxq_harvest_buffer(adapter, cor, true);
 	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
-	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue.index);
-	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue.toggle);
+	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].index);
+	KUNIT_EXPECT_EQ(test, 1ULL, adapter->rx_queue[0].toggle);
 
 	cor = ibmveth_rxq_correlator(adapter);
 	ret = ibmveth_rxq_harvest_buffer(adapter, cor, true);
 	KUNIT_EXPECT_EQ(test, -EFAULT, ret);
-	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue.index);
-	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue.toggle);
+	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].index);
+	KUNIT_EXPECT_EQ(test, 0ULL, adapter->rx_queue[0].toggle);
 
 	flush_work(&adapter->work);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 82f22de16394..df5a3b69a157 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -269,6 +269,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
+#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_PER_HCALL 8U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
@@ -306,18 +308,23 @@ struct ibmveth_rx_q {
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


