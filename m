Return-Path: <linuxppc-dev+bounces-23331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC72C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:26:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grF335d9wz2yvQ;
	Thu, 02 Jul 2026 08:25:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782944751;
	cv=none; b=T5W01VReQfh5fwNoRlk1sPGbbWi2keQpJ89jYEBD04hWjAuENcyYCrmmwXsrR3OJIqGxBNC+kDC/qlx+/glUyYLDNgS/fRz97wCauYnNVAWhQD02313QEEmcOOhXABel0+FpURHRiUSc19W9BPykKfiRnkWdd1CJBuKDZQFtliAZLJXtIS46N3DFIWSd5N31Pqza4TZX1PBtqP4g3PCjYzpfB4SUJ4uuFU0YOdpFlkSo9LrbArPbEdmjjLAG5CvJCfj2F63O3KX1lXERUY2EvPlrRsaGrI/rtqGbH4+brGiMuW8F9PpCh8w4cvkeM4XsLsiO3FflYF7LAT4v/fDedg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782944751; c=relaxed/relaxed;
	bh=hQDXhIF1ERdO/bmdRlPUquAsFrR1QA4Ovj8o07DNADc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrQVJjJQHYbs/8lUi6WjZRUKsjxTVRKOGR67hFYcA96RJ5H4QoGnC8iWizvZ4idhBlu/10mkQ+K1KaAOoaLP2l8+mxQYsHDJDCldv0FZDmGkKHQghVu9kcfQAOy2y8RFi2LNCcr31rYA3A7ygioFPxqP+56xXE5EgOGB+cW7TQvkBSq97xPeYSB6Arji9jaWEDHoCgQJKdipfTAdLqUO9iRDd4ZBZ6vOwxbHKZLwlL9h6CF2p6rWsmEIlrYWbznEZBAWELlEOyzdAtrxOqSSMKcQevp1IaSPTIjPhgh/kmjmMWPVBW6wv5JiENe7bk5/RqBOKe1Ov7uYnrFHSbqcxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ReyLjy7p; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ReyLjy7p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grF305JbMz2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:25:48 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LmQFa1925979;
	Wed, 1 Jul 2026 22:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hQDXhIF1ERdO/bmdR
	lPUquAsFrR1QA4Ovj8o07DNADc=; b=ReyLjy7pwIUVnZlEuTrDAf6w2PzTfdW8B
	oqfqvkxb54x+CoCg8U7MLxYCusbYAaHgSqPKDQPjwfKt3fvZ9mxECO3fJVWfzLGj
	SECN9i3XBiqB6TaJAjDTKv/vpAQ9iVtmmp+4+6wjTtHjefvxNcSqJtU4DSmmiJiC
	HKdClmkTql8KMPNRcU9bsy6AMoKV6L5bh4O/uHf9u/j0/5YbRYtt5/0+X53TTRMh
	VRpkrP60jnA9i19E1zJKAmh9gwv6nQeK88Cd0JePn5VJRFBNSesiKQYmaD0KDT+o
	F/vxALLSZnyfM7NiUkCMN8QOyKFdng9FLf2qlsrNCk7hI8Z5EH3Tw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjxm4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJbwD028849;
	Wed, 1 Jul 2026 22:25:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9fk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPb9J14549504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D322058065;
	Wed,  1 Jul 2026 22:25:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63CE75804B;
	Wed,  1 Jul 2026 22:25:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:35 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 08/15] ibmveth: Enable multi-queue RX receive path
Date: Wed,  1 Jul 2026 15:23:20 -0700
Message-Id: <20260701222327.61325-9-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX4TQeoqqUcZue
 ovW55giBn2TcyT+WRw/rfW2aAQ+nfhowAsdwzexSQqj7a+3ibyP8GNktIivQhj9xd/fQgIi8WRs
 SfrFe6SJ8vcbIZGTU76rk1gNzmQXY03NQFYpXQ8wprM4KxocwmU+qTy6oaxFmgonc+lYdyx8RXz
 JQag+kQeDFObNj/z1nYB8Xy8c9/2y7nG5D8G5f5Mk+tb2bSRPfdFdiJPoay+A4d6S4ayRqVdodf
 sglJI9XuwBAuMOA3NCoQ6q9uOIs2WnDXQuYdagwrc077VJ4FGOdgGzoP1mC3HQ9Ghwm5V5oWpvh
 flLDPdR1pYATMxLZBCdrRCYn4KTLaYxxP4dNQ0MSJKoS2WuLdsOP9rz/eZYcqlRXnkYTNbUkqOX
 YaV6syoE+Rr/PxkplyLOu6Rz4a45F7w0siF4pWqG9KXLZreq7EyBpnARKDb94ZIzJymw4yVWnuc
 GYFAI1vX7NtoIBb+gHw==
X-Proofpoint-GUID: rgTgowxs6nBkHOeJZMWYuW9Bi9H1VX9R
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a4593e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3LB5ssWWY6YWvNRp39YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX5nylld/8IFAl
 u5zEfZVulCBuXwa1BtZmqlmcij20O5CIXtY1a3+g6OAdZkPB7XQDq78wA7zycsmsKc/JZaQ8GqF
 r1KjUh0otLt2KIC2168k9IoSWzp8YHw=
X-Proofpoint-ORIG-GUID: aC2JoQAVIqZJw9p35ig9svZh_PDpnxMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

This is the first patch that sets multi_queue from H_ILLAN_ATTRIBUTES
and switches registration, buffer posting, and receive to the MQ
hcall path. It also raises num_rx_queues and enables per-queue NAPI.

This is where MQ actually receives packets. If firmware sets
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES, probe sets
multi_queue and num_rx_queues to min(num_online_cpus(),
IBMVETH_DEFAULT_QUEUES), matching the existing TX default (cap 8).
Up to IBMVETH_MAX_RX_QUEUES (16) remains available via ethtool -L.
Otherwise we stay at one queue like today.

Raise IBMVETH_MAX_RX_QUEUES to 16 here so adapter arrays and NAPI state
can hold every queue before num_rx_queues is increased.

Register a NAPI struct per possible queue at probe, use
alloc_etherdev_mqs(), and call netif_set_real_num_rx_queues() after PHYP
registration on open.

With MQ enabled, open runs initial replenish on every active queue before
starting TX; legacy still kicks replenish via queue-0 interrupt/NAPI only.
PHYP can deliver to any registered queue immediately, so unprimed queues
see no-buffer drops until their NAPI path runs.

Datapath: derive queue_index from the NAPI instance, thread it through
harvest/replenish/pool access, and enable/disable IRQ per queue on NAPI
completion. Add per-queue replenish_lock around buffer posting (same-queue
NAPI vs netpoll/resize). poll_controller() and get_desired_dma() walk all
queues.

Update KUnit tests for the queue_index argument added to
ibmveth_remove_buffer_from_pool() and ibmveth_rxq_get_buffer().

Legacy firmware without the MQ bit is unchanged.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 257 ++++++++++++++++++-----------
 drivers/net/ethernet/ibm/ibmveth.h |  10 +-
 2 files changed, 171 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b3b3886c3eed..863e5c68b42c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -30,6 +30,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <asm/hvcall.h>
 #include <linux/atomic.h>
 #include <asm/vio.h>
@@ -101,45 +102,58 @@ static struct ibmveth_stat ibmveth_stats[] = {
 };
 
 /* simple methods of getting data from the current rxq entry */
-static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
+static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter,
+				    int queue_index)
 {
-	return be32_to_cpu(adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].flags_off);
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+
+	return be32_to_cpu(rxq->queue_addr[rxq->index].flags_off);
 }
 
-static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter,
+				     int queue_index)
 {
-	return (ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_TOGGLE) >>
-			IBMVETH_RXQ_TOGGLE_SHIFT;
+	return (ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_TOGGLE) >>
+		IBMVETH_RXQ_TOGGLE_SHIFT;
 }
 
-static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter,
+					     int queue_index)
 {
-	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue[0].toggle;
+	return ibmveth_rxq_toggle(adapter, queue_index) ==
+		adapter->rx_queue[queue_index].toggle;
 }
 
-static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_VALID;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_VALID;
 }
 
-static inline int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_frame_offset(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_OFF_MASK;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_OFF_MASK;
 }
 
-static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_LRG_PKT;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_LRG_PKT;
 }
 
-static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter,
+					   int queue_index)
 {
-	return be32_to_cpu(adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].length);
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+
+	return be32_to_cpu(rxq->queue_addr[rxq->index].length);
 }
 
-static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
+static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter,
+					int queue_index)
 {
-	return ibmveth_rxq_flags(adapter) & IBMVETH_RXQ_CSUM_GOOD;
+	return ibmveth_rxq_flags(adapter, queue_index) & IBMVETH_RXQ_CSUM_GOOD;
 }
 
 static unsigned int ibmveth_real_max_tx_queues(void)
@@ -274,6 +288,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
 		adapter->rx_queue[i].index = 0;
 		adapter->rx_queue[i].num_slots = rxq_entries;
 		adapter->rx_queue[i].toggle = 1;
+		spin_lock_init(&adapter->rx_queue[i].replenish_lock);
 
 		netdev_dbg(netdev, "queue %d: buffer_list @ 0x%p (DMA: 0x%llx), rx_queue @ 0x%p (DMA: 0x%llx), %llu entries\n",
 			   i, adapter->buffer_list_addr[i],
@@ -826,15 +841,23 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
+		u64 drops = be64_to_cpup(p);
 
-	adapter->rx_no_buffer = be64_to_cpup(p);
+		if (i == 0)
+			adapter->rx_no_buffer = drops;
+	}
 }
 
 /* replenish routine */
 static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 				   int queue_index)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	unsigned long flags;
 	int i;
 
 	if (queue_index >= adapter->num_rx_queues)
@@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 
 	adapter->replenish_task_cycles++;
 
+	spin_lock_irqsave(&rxq->replenish_lock, flags);
+
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
 		struct ibmveth_buff_pool *pool =
 			&adapter->rx_buff_pool[queue_index][i];
@@ -853,6 +878,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	}
 
 	ibmveth_update_rx_no_buffer(adapter);
+
+	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
 }
 
 /* empty and free ana buffer pool - also used to do cleanup in error paths */
@@ -1028,7 +1055,8 @@ static void ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
  * * %-EFAULT - pool and index map to null skb
  */
 static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
-					   u64 correlator, bool reuse)
+					   u64 correlator, int queue_index,
+					   bool reuse)
 {
 	unsigned int pool  = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
@@ -1036,12 +1064,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	struct sk_buff *skb;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
 		schedule_work(&adapter->work);
 		return -EINVAL;
 	}
 
-	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
+	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 	if (WARN_ON(!skb)) {
 		schedule_work(&adapter->work);
 		return -EFAULT;
@@ -1055,42 +1083,44 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 		/* remove the skb pointer to mark free. actual freeing is done
 		 * by upper level networking after gro_receive
 		 */
-		adapter->rx_buff_pool[0][pool].skbuff[index] = NULL;
+		adapter->rx_buff_pool[queue_index][pool].skbuff[index] = NULL;
 
 		dma_unmap_single(&adapter->vdev->dev,
-				 adapter->rx_buff_pool[0][pool].dma_addr[index],
-				 adapter->rx_buff_pool[0][pool].buff_size,
+				 adapter->rx_buff_pool[queue_index][pool].dma_addr[index],
+				 adapter->rx_buff_pool[queue_index][pool].buff_size,
 				 DMA_FROM_DEVICE);
 	}
 
-	free_index = adapter->rx_buff_pool[0][pool].producer_index;
-	adapter->rx_buff_pool[0][pool].producer_index++;
-	if (adapter->rx_buff_pool[0][pool].producer_index >=
-	    adapter->rx_buff_pool[0][pool].size)
-		adapter->rx_buff_pool[0][pool].producer_index = 0;
-	adapter->rx_buff_pool[0][pool].free_map[free_index] = index;
+	free_index = adapter->rx_buff_pool[queue_index][pool].producer_index;
+	adapter->rx_buff_pool[queue_index][pool].producer_index++;
+	if (adapter->rx_buff_pool[queue_index][pool].producer_index >=
+	    adapter->rx_buff_pool[queue_index][pool].size)
+		adapter->rx_buff_pool[queue_index][pool].producer_index = 0;
+	adapter->rx_buff_pool[queue_index][pool].free_map[free_index] = index;
 
 	mb();
 
-	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
+	atomic_dec(&adapter->rx_buff_pool[queue_index][pool].available);
 
 	return 0;
 }
 
 /* get the current buffer on the rx queue */
-static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
+static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
+						     int queue_index)
 {
-	u64 correlator = adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].correlator;
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
+	u64 correlator = rxq->queue_addr[rxq->index].correlator;
 	unsigned int pool = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
 
 	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
-	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
+	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
 		schedule_work(&adapter->work);
 		return NULL;
 	}
 
-	return adapter->rx_buff_pool[0][pool].skbuff[index];
+	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
 }
 
 /**
@@ -1106,19 +1136,20 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
  * * other - non-zero return from ibmveth_remove_buffer_from_pool
  */
 static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
-				      bool reuse)
+				      int queue_index, bool reuse)
 {
+	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
 	u64 cor;
 	int rc;
 
-	cor = adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].correlator;
-	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
+	cor = rxq->queue_addr[rxq->index].correlator;
+	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
 	if (unlikely(rc))
 		return rc;
 
-	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
-		adapter->rx_queue[0].index = 0;
-		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
+	if (++rxq->index == rxq->num_slots) {
+		rxq->index = 0;
+		rxq->toggle = !rxq->toggle;
 	}
 
 	return 0;
@@ -2268,34 +2299,40 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
-	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi[0]);
-	struct net_device *netdev = adapter->netdev;
+	struct net_device *netdev = napi->dev;
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int frames_processed = 0;
 	unsigned long lpar_rc;
+	int queue_index, rc;
 	u16 mss = 0;
 
+	queue_index = napi - adapter->napi;
+
+	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
+		return 0;
+
 restart_poll:
 	while (frames_processed < budget) {
-		if (!ibmveth_rxq_pending_buffer(adapter))
+		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
 			break;
 
 		smp_rmb();
-		if (!ibmveth_rxq_buffer_valid(adapter)) {
+		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+			if (unlikely(rc))
 				break;
 		} else {
 			struct sk_buff *skb, *new_skb;
-			int length = ibmveth_rxq_frame_length(adapter);
-			int offset = ibmveth_rxq_frame_offset(adapter);
-			int csum_good = ibmveth_rxq_csum_good(adapter);
-			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
+			int length = ibmveth_rxq_frame_length(adapter, queue_index);
+			int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
+			int csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
+			int lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
 			__sum16 iph_check = 0;
 
-			skb = ibmveth_rxq_get_buffer(adapter);
+			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
 			if (unlikely(!skb))
 				break;
 
@@ -2320,12 +2357,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 							length);
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
-						length + offset);
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
+							     length + offset);
+				rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+				if (unlikely(rc))
 					break;
 				skb = new_skb;
 			} else {
-				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
+				rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
+				if (unlikely(rc))
 					break;
 				skb_reserve(skb, offset);
 			}
@@ -2361,7 +2400,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter, 0);
+	ibmveth_replenish_task(adapter, queue_index);
 
 	if (frames_processed == budget)
 		goto out;
@@ -2372,15 +2411,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	/* We think we are done - reenable interrupts,
 	 * then check once more to make sure we are done.
 	 */
-	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
-	if (WARN_ON(lpar_rc != H_SUCCESS)) {
+	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev,
+			   "Failed to enable IRQ for queue %d (rc=0x%lx), scheduling reset\n",
+			   queue_index, lpar_rc);
 		schedule_work(&adapter->work);
 		goto out;
 	}
 
-	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_DISABLE);
+	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
+	    napi_schedule(napi)) {
+		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
+		WARN_ON(lpar_rc != H_SUCCESS);
 		goto restart_poll;
 	}
 
@@ -2511,9 +2554,13 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i;
 
-	ibmveth_replenish_task(adapter, 0);
-	ibmveth_interrupt(dev->irq, &adapter->napi[0]);
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		ibmveth_replenish_task(adapter, i);
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		ibmveth_interrupt(adapter->queue_irq[i], &adapter->napi[i]);
 }
 #endif
 
@@ -2531,8 +2578,7 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
 	unsigned long ret;
-	int i;
-	int rxqentries = 1;
+	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -2547,18 +2593,22 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	/* add size of mapped tx buffers */
 	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		/* add the size of the active receive buffers */
-		if (adapter->rx_buff_pool[0][i].active)
-			ret +=
-			    adapter->rx_buff_pool[0][i].size *
-			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
-					     buff_size, tbl);
-		rxqentries += adapter->rx_buff_pool[0][i].size;
-	}
-	/* add the size of the receive queue entries */
-	ret += IOMMU_PAGE_ALIGN(
-		rxqentries * sizeof(struct ibmveth_rx_q_entry), tbl);
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		int rxqentries = 1;
+
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			/* add the size of the active receive buffers */
+			if (adapter->rx_buff_pool[q][i].active)
+				ret += adapter->rx_buff_pool[q][i].size *
+					IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[q][i].buff_size,
+							 tbl);
+			rxqentries += adapter->rx_buff_pool[q][i].size;
+		}
+
+		/* add the size of the receive queue entries */
+		ret += IOMMU_PAGE_ALIGN(rxqentries *
+					sizeof(struct ibmveth_rx_q_entry), tbl);
+	}
 
 	return ret;
 }
@@ -2660,7 +2710,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		return -EINVAL;
 	}
 
-	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter), IBMVETH_MAX_QUEUES, 1);
+	netdev = alloc_etherdev_mqs(sizeof(struct ibmveth_adapter),
+				    IBMVETH_MAX_QUEUES, IBMVETH_MAX_RX_QUEUES);
 	if (!netdev)
 		return -ENOMEM;
 
@@ -2673,7 +2724,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
+	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++)
+		netif_napi_add_weight(netdev, &adapter->napi[i], ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -2705,16 +2757,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
-	/* Initialize queue count - always 1 for now */
-	adapter->multi_queue = 0;
-	adapter->num_rx_queues = 1;
+	if (ret == H_SUCCESS &&
+	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
+		adapter->multi_queue = 1;
+		adapter->num_rx_queues = min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES);
+		netdev_dbg(netdev, "RX multi queue mode enabled: %d queues\n",
+			   adapter->num_rx_queues);
+	} else {
+		adapter->multi_queue = 0;
+		adapter->num_rx_queues = 1;
+	}
 
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
-		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
+		if (adapter->multi_queue)
+			adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_QUEUE;
+		else
+			adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
+
 		netdev_dbg(netdev,
 			   "RX Multi-buffer hcall supported by FW, batch set to %u\n",
-			    adapter->rx_buffers_per_hcall);
+			   adapter->rx_buffers_per_hcall);
 	} else {
 		adapter->rx_buffers_per_hcall = 1;
 		netdev_dbg(netdev,
@@ -3057,17 +3120,23 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
 	correlator = ((u64)IBMVETH_NUM_BUFF_POOLS << 32) | 0;
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, true));
 
 	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0][0].size;
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
-	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false));
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, true));
 
 	correlator = (u64)0 | 0;
 	pool->skbuff[0] = NULL;
-	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
-	KUNIT_EXPECT_EQ(test, -EFAULT, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
+	KUNIT_EXPECT_EQ(test, -EFAULT,
+			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false));
+	KUNIT_EXPECT_EQ(test, -EFAULT,
+			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, true));
 
 	flush_work(&adapter->work);
 }
@@ -3111,15 +3180,15 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pool->skbuff);
 
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter, 0));
 
 	adapter->rx_queue[0].queue_addr[0].correlator =
 		(u64)0 << 32 | adapter->rx_buff_pool[0][0].size;
-	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, ibmveth_rxq_get_buffer(adapter, 0));
 
 	pool->skbuff[0] = skb;
 	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
-	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter));
+	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter, 0));
 
 	flush_work(&adapter->work);
 }
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d2ceeccd5fbd..f7b20fd01acb 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -14,6 +14,8 @@
 #ifndef _IBMVETH_H
 #define _IBMVETH_H
 
+#include <linux/spinlock_types.h>
+
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
 #define IbmVethMcastReceptionEnableBit     0x20000UL
@@ -28,6 +30,7 @@
 #define IbmVethMcastRemoveFilter     0x2UL
 #define IbmVethMcastClearFilterTable 0x3UL
 
+#define IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT	0x0000000000080000UL
 #define IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT	0x0000000000040000UL
 #define IBMVETH_ILLAN_LRG_SR_ENABLED	0x0000000000010000UL
 #define IBMVETH_ILLAN_LRG_SND_SUPPORT	0x0000000000008000UL
@@ -279,9 +282,11 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
-#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_MAX_RX_QUEUES 16U
 #define IBMVETH_DEFAULT_RX_QUEUES 1U
-#define IBMVETH_MAX_RX_PER_HCALL 8U
+#define IBMVETH_MAX_RX_REGULAR 8U
+#define IBMVETH_MAX_RX_QUEUE 12U
+#define IBMVETH_MAX_RX_PER_HCALL 12U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
@@ -336,6 +341,7 @@ struct ibmveth_rx_q {
     dma_addr_t queue_dma;
     u32        queue_len;
     struct ibmveth_rx_q_entry *queue_addr;
+	spinlock_t	replenish_lock;	/* serializes per-queue buffer replenish */
 };
 
 struct ibmveth_adapter {
-- 
2.39.3 (Apple Git-146)


