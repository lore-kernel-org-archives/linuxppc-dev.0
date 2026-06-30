Return-Path: <linuxppc-dev+bounces-23199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADC1C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:54:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR3x3HRQz2yjv;
	Wed, 01 Jul 2026 00:53:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831229;
	cv=none; b=Edn8CO7/Z8SlpjIlYeqplTgSfrZkA3zP3e1lM2HQc39k2wHSED6byY5z0Va78LGpeUm0tf98VESbdMfVUfL0u9XmTfTWb/fSH65pwYru/OeYB+lhIlx+mIJ6bGJEUa5oW27U5Cn7ZrRRFcpuTfshzsSr8Ug9G8eFSQNng6UF8vjhXDd/QctEs64ulnKFAmTAaEnLdwl3UynoDnf4j6Ws7u1tAhFQs4ka/ZeozE4vs+hheuS/m0lDYez4dGPZbVd0CZaWNTGYLPyf2w8fmmuBHQD0/A+waFoQB9U842UcI8chlNAW3VuD0zZd2JJZU4EPiXfxs0ps+nJ3cA0PoS9O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831229; c=relaxed/relaxed;
	bh=KCVcRvfR7XQzX3PcVtYudEmJrS699YSQ9nYwfyifue4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP7PMqNT6fXCwSBgfXn78TG/DW8dMEMrm7E9lBK3YFrzNIsbfPMsDbkODMJy1qE37aU/LIo0RaHZXqq7w2kXB7vKbVNiCGvAKsta8TGOKdw8yJlGmZp9TabXA5pvvKWvBTEi0BFyJs57BGHwuiMA0JPiuVdCkU/KXLPvjLUvxGIF4TjS9oebhRAnqCx+gtgXRQAJ3g4OVJRwKEY3kaWJVW4niOgQstEhiSsI0ausUNVa64L/klLfaRfJz/Gd8bAjsk5tN083naYYcTMjMV+O98pKfNALHeZGu/ybdhbHf2w1GmvATieNakSWEfJSSgpgqR7dBwqdMly12WOxwHbvVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jy23aCSL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jy23aCSL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR3v4RSjz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:53:47 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEISsK2233644;
	Tue, 30 Jun 2026 14:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KCVcRv
	fR7XQzX3PcVtYudEmJrS699YSQ9nYwfyifue4=; b=jy23aCSLhdtL4zajyo2eny
	a5IXB8p5p8MvZpGRcaK6utMD9AzNSehIZ8NOoktl5Tcd4NhdHwBUNSZ/Rh2LMMwA
	hVfoblfEm1qvY/iWWYj985SxWWiU6zXo4kn1HJc966tGgKuQ4BnEltsbEN+u3vsu
	0ZwswqiwJZRbUF0YsWMeuavg8aUR+woFLELeiHg0h2vypcVTyszpVwBrCqXdzP6x
	NUAEbGKyXhtqewsQga33W8ENykQOq2xxfl+6Cs0I/N4rLI9ZaomuRT8OKcFWjt/p
	mnICRiSGQ8CPvmJLmESeJ9wnbfsBABDXmdQAnz3M55RZVvScCSnRSWbk6r6G/g/w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5qdjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnilb018696;
	Tue, 30 Jun 2026 14:53:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqaxx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEraa813042214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:37 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B42FB58054;
	Tue, 30 Jun 2026 14:53:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6066158062;
	Tue, 30 Jun 2026 14:53:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:35 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 02/18] ibmveth: Prepare adapter data structures for MQ RX
Date: Tue, 30 Jun 2026 07:53:09 -0700
Message-Id: <c23f8ba6a4af1cf760c525ac0a83192e56dc8839.1782758799.git.mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX6yzE2jegU0Fc
 lZJTM7wgcpYqCv3gNdqSl0fJ5Xjw9S+DNvEMTtl7zfOPUVCgefiefaGhwGO5Vv81L5cVW/wah7j
 tO4lnjNYdHe0Wpi6z2skfuxXSDN06M4th6Q7CC8UZHHAURpqkHGr99CRy07iayw6NSp9kL5gVQx
 /tMgdki6uUselFA9xQWLlBQSN/3ZOJMFNq5x258uYnqgFC+waXRBEwbGsZ7sKW6kzv6VeATw3hR
 +nan+6RLgr5vFHGOqxtv4AznfqvJifpX+La05wb30SNOxjffKwd2Mfgrhgrzh6rCyY4gNqLXfP9
 VsTUln5NB2BtFj3leqBvsg9P3G+3sKs5MoDiBqyS0CdWRy9P0Ijjd91D6NX1Mw9kc1r8aj0yVQW
 2raSIJ4+mqeP3kjcItjitWxJ73jONJM80+VmltjRwZSPQPvf4RkQPpncKqjwYqdUyJFNHm+QB8J
 +06Pms546QmDwptwEhw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43d873 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=AoCa9DvgGXN0wtrzdfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cbv8XlEfQ0-ktY6Hf5Xb3MALLEXEYfE5
X-Proofpoint-GUID: n0Iq-1RDAgtWviitbs5eHJZfaJPA0vrp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX7Y9NkF4XS4DI
 hMdHSYuxsQxmV2sb8zEF+A1pPEPTmKIXWAaxaQ/4ECPsUAQsQxRsLVoeUPcPRAzEwlft+jKL/MA
 bUNp7TpHPoBw5pU7XpIPqwNoxXCjZKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

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

and add num_rx_queues to track how many RX queues are active.

This patch keeps behavior unchanged by mechanically switching existing
references to index 0 — e.g. rx_queue[0], rx_buff_pool[0][pool], and
napi[0]. open/poll/close still drive a single RX queue only.

The goal is to make later helper and datapath patches queue-aware
without mixing structural churn and behavior changes in one commit.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 195 +++++++++++++++--------------
 drivers/net/ethernet/ibm/ibmveth.h |  16 ++-
 2 files changed, 112 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index af287eeafc0c..4f9dbee7477d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -101,7 +101,7 @@ static struct ibmveth_stat ibmveth_stats[] = {
 /* simple methods of getting data from the current rxq entry */
 static inline u32 ibmveth_rxq_flags(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].flags_off);
+	return be32_to_cpu(adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].flags_off);
 }
 
 static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
@@ -112,7 +112,7 @@ static inline int ibmveth_rxq_toggle(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)
 {
-	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue.toggle;
+	return ibmveth_rxq_toggle(adapter) == adapter->rx_queue[0].toggle;
 }
 
 static inline int ibmveth_rxq_buffer_valid(struct ibmveth_adapter *adapter)
@@ -132,7 +132,7 @@ static inline int ibmveth_rxq_large_packet(struct ibmveth_adapter *adapter)
 
 static inline int ibmveth_rxq_frame_length(struct ibmveth_adapter *adapter)
 {
-	return be32_to_cpu(adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
+	return be32_to_cpu(adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].length);
 }
 
 static inline int ibmveth_rxq_csum_good(struct ibmveth_adapter *adapter)
@@ -386,7 +386,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr + 4096 - 8;
+	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
 
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
@@ -399,7 +399,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
 	adapter->replenish_task_cycles++;
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
-		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[i];
+		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
 
 		if (pool->active &&
 		    (atomic_read(&pool->available) < pool->threshold))
@@ -463,12 +463,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
@@ -482,24 +482,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
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
@@ -507,17 +507,17 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 /* get the current buffer on the rx queue */
 static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
 {
-	u64 correlator = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	u64 correlator = adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].correlator;
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
@@ -538,14 +538,14 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	u64 cor;
 	int rc;
 
-	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	cor = adapter->rx_queue[0].queue_addr[adapter->rx_queue[0].index].correlator;
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
@@ -596,7 +596,7 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 */
 retry:
 	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma, rxq_desc.desc,
+				    adapter->buffer_list_dma[0], rxq_desc.desc,
 				    adapter->filter_list_dma, mac_address);
 
 	if (rc != H_SUCCESS && try_again) {
@@ -624,14 +624,14 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -644,17 +644,18 @@ static int ibmveth_open(struct net_device *netdev)
 
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
+	adapter->buffer_list_dma[0] = dma_map_single(dev,
+						     adapter->buffer_list_addr[0],
+						     4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
 		netdev_err(netdev, "unable to map buffer list pages\n");
 		goto out_free_queue_mem;
 	}
@@ -671,19 +672,19 @@ static int ibmveth_open(struct net_device *netdev)
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
+	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr[0]);
 	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
-	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue.queue_addr);
+	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue[0].queue_addr);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
@@ -694,7 +695,7 @@ static int ibmveth_open(struct net_device *netdev)
 			   lpar_rc);
 		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
 			   "desc:0x%llx MAC:0x%llx\n",
-				     adapter->buffer_list_dma,
+				     adapter->buffer_list_dma[0],
 				     adapter->filter_list_dma,
 				     rxq_desc.desc,
 				     mac_address);
@@ -703,11 +704,11 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -739,9 +740,9 @@ static int ibmveth_open(struct net_device *netdev)
 
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
@@ -753,18 +754,18 @@ static int ibmveth_open(struct net_device *netdev)
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
 
@@ -777,7 +778,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	netdev_dbg(netdev, "close starting\n");
 
-	napi_disable(&adapter->napi);
+	napi_disable(&adapter->napi[0]);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -796,22 +797,22 @@ static int ibmveth_close(struct net_device *netdev)
 
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
@@ -1449,7 +1450,7 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 static int ibmveth_poll(struct napi_struct *napi, int budget)
 {
 	struct ibmveth_adapter *adapter =
-			container_of(napi, struct ibmveth_adapter, napi);
+			container_of(napi, struct ibmveth_adapter, napi[0]);
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
 	unsigned long lpar_rc;
@@ -1574,11 +1575,11 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
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
@@ -1646,7 +1647,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	int need_restart = 0;
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size)
 			break;
 
 	if (i == IBMVETH_NUM_BUFF_POOLS)
@@ -1661,9 +1662,9 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 
 	/* Look for an active buffer pool that can hold the new MTU */
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		adapter->rx_buff_pool[i].active = 1;
+		adapter->rx_buff_pool[0][i].active = 1;
 
-		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
+		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size) {
 			WRITE_ONCE(dev->mtu, new_mtu);
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
@@ -1721,12 +1722,12 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
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
@@ -1845,7 +1846,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	ibmveth_init_link_settings(netdev);
 
-	netif_napi_add_weight(netdev, &adapter->napi, ibmveth_poll, 16);
+	netif_napi_add_weight(netdev, &adapter->napi[0], ibmveth_poll, 16);
 
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
@@ -1877,6 +1878,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
+	/* Initialize queue count - always 1 for now */
+	adapter->multi_queue = 0;
+	adapter->num_rx_queues = 1;
+
 	if (ret == H_SUCCESS &&
 	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
 		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
@@ -1899,10 +1904,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
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
@@ -1950,7 +1955,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	cancel_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[i].kobj);
+		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
 	unregister_netdev(netdev);
 
@@ -2036,11 +2041,11 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
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
+				if (mtu <= adapter->rx_buff_pool[0][i].buff_size)
 					break;
 			}
 
@@ -2214,11 +2219,11 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 
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
 
@@ -2226,7 +2231,7 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
-	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0].size;
+	correlator = ((u64)0 << 32) | adapter->rx_buff_pool[0][0].size;
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, false));
 	KUNIT_EXPECT_EQ(test, -EINVAL, ibmveth_remove_buffer_from_pool(adapter, correlator, true));
 
@@ -2259,30 +2264,32 @@ static void ibmveth_rxq_get_buffer_test(struct kunit *test)
 
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
+	adapter->rx_queue[0].queue_addr[0].correlator = (u64)IBMVETH_NUM_BUFF_POOLS << 32 | 0;
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
index 45cfb0d054e3..b17894695c2e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -279,6 +279,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
 #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
 #define IBMVETH_MAX_QUEUES 16U
 #define IBMVETH_DEFAULT_QUEUES 8U
+#define IBMVETH_MAX_RX_QUEUES 1U
+#define IBMVETH_DEFAULT_RX_QUEUES 1U
 #define IBMVETH_MAX_RX_PER_HCALL 8U
 
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
@@ -315,18 +317,22 @@ struct ibmveth_rx_q {
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
+	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
+	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
+	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
+	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
+	int multi_queue;
+	unsigned int num_rx_queues;
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
-- 
2.39.3 (Apple Git-146)


