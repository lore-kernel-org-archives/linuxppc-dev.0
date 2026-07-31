Return-Path: <linuxppc-dev+bounces-25160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFA3C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:49:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6r66jsQz30VH;
	Fri, 31 Jul 2026 10:48:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458902;
	cv=none; b=n7EFvebETAsYrHVoKbcTLtPp6qz9ejFP2jyiq9eEDDbsdmSCIrQ5P/AuR0uv2jp4Zdk/+C9rhJR/NAIsh8bJMSCOykdSsx8U0ABw9IlHHnosnUYzLr8fqhu+ZK/L9HXnLJPX+KWVeWx+XEHY99ZrKza27OLnSX6yHy+9+yn2GGaovoVEao30nTAzb0Hz0OVD4F/2X9sezVxtHHnPC2FkL+/vMckvb+dOroOzopY/GFNQzC2LzLWz+IddoBF17wpWr87r1Gy4Lz0xUYG77QEjG0m4b55zpZWbHDYR2qM2i57ZkvZH7dhskPAoY7qpGygi/hcD4TqPjaRXOKM36YGNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458902; c=relaxed/relaxed;
	bh=ge7rZiWWoZbHU9wtWw4QxK7o4NqJsD2vgflM3pSXiuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTqLbC4ZnrlrIerjeR4LyhGpvFkJsF0JnXBIkhuK4V73odze3++qg8iDsDHrr06ZhkYhMm3s+ywMtvfmMe2XY7HmYcNcIcCBnWD0U2qDHPiLATFtMZozH1vGY9bDDD8eBs3QPGppf4Q9vmLts+lrA7wAHYQiU7SZNO91p3INLdGJGczhhcM7z2tdwajW+c2KIg/DMaIQLsV9//0jne9bXTHfwE5e05KC7afeBXmeETP3LD1KEr6+NWfMXZhXgtWFmMgdSDGQHh8XFxauRMe1nFWgfhbQvuMVSIQUhvUyUG127hxdOUh2sWYeyDsJVboHgAiNmTqrYqSYSwBlpI9zpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QaRaWmFc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QaRaWmFc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6r44qV3z30Cd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:20 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHowx118167;
	Fri, 31 Jul 2026 00:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ge7rZiWWoZbHU9wtW
	w4QxK7o4NqJsD2vgflM3pSXiuI=; b=QaRaWmFcMveE9Mm5I9Z8B6MQGvLXWx5fR
	rPL5RooZOiuiyRVqJcGj6Ygo8glsroh7eMgsNdLTAxrt9FwIS/pkoPJL/XjropF/
	3WxrNpdunElMsb75vbsLWY91FCpf666IunYmfciq6qEk+bFCqgsQppkuAyxJedAv
	Dvw5IXNzRkV9BdSK9XCPMreJpzqzJNRnJH5LNGiMGrwSLQjA0E3i4BSAp9Kkuvfn
	nIDSlyCwzXPnvejl3LtWYiTgG0vwpn7j3a8NI4F30CfWzZrVCSTJfk0sguFBh9BZ
	AsMA+OMDT0jIlDPFmaMW+W8LYbOZmXeagsrNES2aeCX5qFoAOmGUg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p1mj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fLuH018179;
	Fri, 31 Jul 2026 00:48:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwe05y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0m59c29295164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:48:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A985558063;
	Fri, 31 Jul 2026 00:48:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57D358057;
	Fri, 31 Jul 2026 00:48:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:48:04 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 12/14] ibmveth: Implement incremental MQ RX queue resize
Date: Thu, 30 Jul 2026 17:47:15 -0700
Message-Id: <7d183a47b3649a98da8505eccbea3b0be3ef6eec.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX4nwUjY7scauj
 9aBSMKd0jxEWrjDbykoeFxOEqB79qZ78LdViMMXfW/kWkBsuO14LL+l3yVyR8pRWeQpxDMJUYoH
 NZ0mu3r4St3HeA6etRMONf8djrEyxRE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfXwPnnnTZk15zN
 r8AEQ4AC8hOPvqypeWHY8SUybHEwAC9Lig8C+OEjg/ZeJPF5DDdOGfs0JKWljkl5mjs2dQKXCRJ
 vWgATSkPLl3Z/xA0Etz/XE4l1f9e9suJcYsjV3HTNg7pMEOIiyl9jlL25VO3Quc/ZETp9/XT9Xk
 jqv1qcDlFgZteqCiSIWPTdPYfV7Zg/evAMTptptcaCo1NA/1hXYR9te0TqquWd/pJJL7CKtOXnw
 Ew5Ld7ynoMVxY0u28CNubUydxfarcVLJ+/cVzngGhImXwrpR76uTALvmhUR6bP4xHuVblaSuv3i
 j5lzTrR12s7lNOE34svC9v1GDAmD5D/8CFAjCcJPXTcFiPTtM5+7z5o9UHiepealZu0IIjDV5/6
 vipCKAhMZscWGUgAuIsi7H2dS547gLYO7JvL9Uu9XQ3slI9oOaXAuTrH1AFWD6n5ZXLBLLzNUh5
 M9uqMM9F+1aKfAMbZLg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6bf0c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=YWWu0AVbPi2wTfA6fGcA:9
X-Proofpoint-GUID: WKhP0JXG-TMPXypHKYzT4WRMy03VWFOB
X-Proofpoint-ORIG-GUID: uI-CIaMgi_4HsDG1VTPJsB74EKDziDUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

Add helpers to allocate, register, interrupt-setup, and free individual
RX queues, plus ibmveth_resize_rx_queues_incremental() to grow or shrink
the live RX queue count without tearing down surviving queues.
Surviving queues keep PHYP handles, buffer pools, and IRQ state across
resize.

Scale-up for each new queue:
  alloc -> register -> request_irq -> publish num_rx_queues ->
  replenish -> napi_enable -> enable_irq

so the queue is visible and buffered before PHYP delivery is unmasked.
On enable_irq failure after napi_enable, disable NAPI before teardown.
Scale-down:
  disable_irq+sync -> napi_disable -> drain -> deregister -> free

with PHYP mask before napi_disable/drain (same storm rule as close).

IRQ vs PHYP ownership for subordinates:
  - deregister_single is PHYP-only (H_FREE_LOGICAL_LAN_QUEUE + clear
    queue_handle)
  - Linux virq disposal lives in cleanup_single / dispose helpers
  - single-slot dispose is bounded by IBMVETH_MAX_RX_QUEUES (not
    num_rx_queues) so scale-down / fail paths can dispose queues that
    left the published live set but still own a mapping
  - dispose on request_irq failure where deregister no longer releases
    the mapping

Also add drain-path smp_rmb() before harvesting RX buffers so drain
matches poll's descriptor-ordering assumptions, and replenish before
re-enabling IRQ/NAPI on set_real_num_rx scale-down rollback.

Introduce ibmveth_resize_rx_channels() (validate + apply) and call it
from set_channels() when the interface is up so the resize helper is
not left unused. Full !IFF_UP RX stash ordering relative
to TX is completed in the next patch.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Copy pool->index when cloning buffer pools for incrementally added
  queues.
- Scale-up order: publish -> replenish -> napi_enable -> enable_irq
  (vs older enable-before-publish drafts); mirror NAPI-before-unmask on
  set_real_num_rx rollback.
- Linux-owned subordinate virq disposal; deregister is PHYP-only;
  dispose bound to MAX_RX_QUEUES; dispose on request_irq failure.
- Drain-path smp_rmb() before harvest.
- Mask PHYP before napi_disable/drain on scale-down and scale-up fail
  cleanup.
- Replenish before re-enabling IRQ/NAPI on set_real_num_rx scale-down
  rollback.
- Keep set_channels wiring as the following patch (same split as v3)
  but call resize_rx_channels() here when IFF_UP so the helper is not
  an unused static.

 drivers/net/ethernet/ibm/ibmveth.c | 512 ++++++++++++++++++++++++++++-
 1 file changed, 510 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index db1374746602..b57c7df92853 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -651,6 +651,58 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
 }
 
+/**
+ * ibmveth_setup_single_rx_interrupt - Setup interrupt for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to setup
+ *
+ * Registers the IRQ handler for one queue. Used during incremental
+ * scale-up when adding new RX queues. The caller publishes the queue,
+ * replenishes buffers, enables NAPI, then unmasks PHYP delivery.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_setup_single_rx_interrupt(struct ibmveth_adapter *adapter,
+				  int queue_idx)
+{
+	struct net_device *netdev = adapter->netdev;
+	int rc;
+
+	rc = request_irq(adapter->queue_irq[queue_idx], ibmveth_interrupt,
+			 0, netdev->name, &adapter->napi[queue_idx]);
+	if (rc) {
+		netdev_err(netdev, "request_irq() failed for queue %d: %d\n",
+			   queue_idx, rc);
+		return rc;
+	}
+
+	netdev_dbg(netdev, "Setup IRQ %d for queue %d\n",
+		   adapter->queue_irq[queue_idx], queue_idx);
+	return 0;
+}
+
+/**
+ * ibmveth_cleanup_single_rx_interrupt - Cleanup interrupt for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to cleanup
+ *
+ * Frees the IRQ handler for one queue and releases the subordinate virq
+ * mapping. Used during incremental scale-down.
+ */
+static void
+ibmveth_cleanup_single_rx_interrupt(struct ibmveth_adapter *adapter,
+				    int queue_idx)
+{
+	if (adapter->queue_irq[queue_idx]) {
+		free_irq(adapter->queue_irq[queue_idx],
+			 &adapter->napi[queue_idx]);
+		ibmveth_dispose_subordinate_irq_mapping(adapter, queue_idx);
+		netdev_dbg(adapter->netdev,
+			   "Freed IRQ for queue %d\n", queue_idx);
+	}
+}
+
 /**
  * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
  * @adapter: ibmveth adapter structure
@@ -1189,6 +1241,141 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   adapter->num_rx_queues);
 }
 
+/**
+ * ibmveth_alloc_single_rx_queue - Allocate resources for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to allocate
+ * @rxq_entries: Number of RX queue entries
+ *
+ * Allocates buffer list, RX queue, and per-queue buffer pools for one queue.
+ * Used during incremental scale-up without affecting existing queues.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx,
+			      int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i, rc = -ENOMEM;
+
+	adapter->buffer_list_addr[queue_idx] =
+		(void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->buffer_list_addr[queue_idx]) {
+		netdev_err(netdev, "unable to allocate buffer list for queue %d\n",
+			   queue_idx);
+		return -ENOMEM;
+	}
+
+	adapter->rx_queue[queue_idx].queue_len =
+		sizeof(struct ibmveth_rx_q_entry) * rxq_entries;
+	adapter->rx_queue[queue_idx].queue_addr =
+		dma_alloc_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+				   &adapter->rx_queue[queue_idx].queue_dma,
+				   GFP_KERNEL);
+	if (!adapter->rx_queue[queue_idx].queue_addr) {
+		netdev_err(netdev, "unable to allocate RX queue for queue %d\n",
+			   queue_idx);
+		goto out_free_buflist;
+	}
+
+	adapter->buffer_list_dma[queue_idx] =
+		dma_map_single(dev, adapter->buffer_list_addr[queue_idx],
+			       4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->buffer_list_dma[queue_idx])) {
+		netdev_err(netdev, "unable to map buffer list for queue %d\n",
+			   queue_idx);
+		goto out_free_rxq;
+	}
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *src =
+			&adapter->rx_buff_pool[0][i];
+		struct ibmveth_buff_pool *dst =
+			&adapter->rx_buff_pool[queue_idx][i];
+
+		dst->size = src->size;
+		dst->index = src->index;
+		dst->buff_size = src->buff_size;
+		dst->threshold = src->threshold;
+		dst->active = src->active;
+	}
+
+	rc = ibmveth_alloc_queue_buffer_pools(adapter, queue_idx);
+	if (rc) {
+		netdev_err(netdev,
+			   "Failed to allocate buffer pools for queue %d\n",
+			   queue_idx);
+		goto out_unmap_buflist;
+	}
+
+	adapter->rx_queue[queue_idx].index = 0;
+	adapter->rx_queue[queue_idx].num_slots = rxq_entries;
+	adapter->rx_queue[queue_idx].toggle = 1;
+	spin_lock_init(&adapter->rx_queue[queue_idx].replenish_lock);
+
+	netdev_dbg(netdev,
+		   "Allocated queue %d: buffer_list @ %p (DMA: 0x%llx), rx_queue @ %p (DMA: 0x%llx), %d entries\n",
+		   queue_idx, adapter->buffer_list_addr[queue_idx],
+		   (unsigned long long)adapter->buffer_list_dma[queue_idx],
+		   adapter->rx_queue[queue_idx].queue_addr,
+		   (unsigned long long)adapter->rx_queue[queue_idx].queue_dma,
+		   rxq_entries);
+
+	return 0;
+
+out_unmap_buflist:
+	dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
+			 4096, DMA_BIDIRECTIONAL);
+	adapter->buffer_list_dma[queue_idx] = 0;
+out_free_rxq:
+	dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+			  adapter->rx_queue[queue_idx].queue_addr,
+			  adapter->rx_queue[queue_idx].queue_dma);
+	adapter->rx_queue[queue_idx].queue_addr = NULL;
+out_free_buflist:
+	free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
+	adapter->buffer_list_addr[queue_idx] = NULL;
+	return rc;
+}
+
+/**
+ * ibmveth_free_single_rx_queue - Free resources for a single RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to free
+ *
+ * Frees buffer list, RX queue, and per-queue buffer pools for one queue.
+ * Used during incremental scale-down without affecting remaining queues.
+ */
+static void
+ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	ibmveth_free_queue_buffer_pools(adapter, queue_idx);
+
+	if (adapter->buffer_list_dma[queue_idx]) {
+		dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
+				 4096, DMA_BIDIRECTIONAL);
+		adapter->buffer_list_dma[queue_idx] = 0;
+	}
+
+	if (adapter->rx_queue[queue_idx].queue_addr) {
+		dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
+				  adapter->rx_queue[queue_idx].queue_addr,
+				  adapter->rx_queue[queue_idx].queue_dma);
+		adapter->rx_queue[queue_idx].queue_addr = NULL;
+	}
+
+	if (adapter->buffer_list_addr[queue_idx]) {
+		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
+		adapter->buffer_list_addr[queue_idx] = NULL;
+	}
+
+	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -1307,6 +1494,51 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ibmveth_drain_rx_queue - Drain pending buffers from an RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_index: Queue index to drain
+ *
+ * Recycles all pending buffers back to the per-queue buffer pools.
+ * Must be called with NAPI disabled for this queue.
+ *
+ * Return: Number of buffers drained
+ */
+static int
+ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
+{
+	struct net_device *netdev = adapter->netdev;
+	int drained = 0;
+	int limit = adapter->rx_queue[queue_index].num_slots;
+	int rc;
+
+	netdev_dbg(netdev, "Draining RX queue %d (limit: %d slots)\n",
+		   queue_index, limit);
+
+	while (drained < limit &&
+	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
+		/* Match poll-side order before harvesting completion state. */
+		smp_rmb();
+		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
+		if (rc) {
+			netdev_err(netdev,
+				   "Failed to harvest buffer from queue %d during drain: %d\n",
+				   queue_index, rc);
+			break;
+		}
+		drained++;
+	}
+
+	if (drained > 0)
+		netdev_dbg(netdev, "Drained %d buffer(s) from RX queue %d\n",
+			   drained, queue_index);
+	else
+		netdev_dbg(netdev, "No buffers to drain from RX queue %d\n",
+			   queue_index);
+
+	return drained;
+}
+
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
 	if (!adapter->tx_ltb_ptr[idx])
@@ -1562,6 +1794,227 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
 	return 0;
 }
 
+/**
+ * ibmveth_deregister_single_rx_queue - Deregister one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to deregister (1..N)
+ *
+ * Deregisters a single queue via H_FREE_LOGICAL_LAN_QUEUE. Linux IRQ handler
+ * teardown and subordinate virq mapping disposal are owned by interrupt
+ * cleanup helpers; queue 0 is freed only through ibmveth_free_all_queues()
+ * (H_FREE_LOGICAL_LAN).
+ */
+static void
+ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
+				   int queue_idx)
+{
+	unsigned long lpar_rc;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long qh = adapter->queue_handle[queue_idx];
+
+	if (!qh)
+		return;
+
+	do {
+		lpar_rc = h_free_logical_lan_queue(ua, qh);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	adapter->hcall_stats.free_lan_queue++;
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
+			   queue_idx, lpar_rc);
+	}
+
+	adapter->queue_handle[queue_idx] = 0;
+
+	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
+}
+
+/**
+ * ibmveth_resize_rx_queues_incremental - Resize RX queue count incrementally
+ * @adapter: ibmveth adapter structure
+ * @new_count: Target number of RX queues
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Adds or removes RX queues without tearing down the entire adapter.
+ * Active queues continue receiving during scale-up; scale-down drains
+ * excess queues before deregistering them with the hypervisor.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
+				     int new_count, int rxq_entries)
+{
+	struct net_device *netdev = adapter->netdev;
+	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
+	int old_count = adapter->num_rx_queues;
+	int failed_queue;
+	int rc, i;
+
+	if (old_count == new_count) {
+		netdev_dbg(netdev, "RX queue count unchanged (%d), nothing to do\n",
+			   old_count);
+		return 0;
+	}
+
+	if (new_count < 1 || new_count > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev, "Invalid RX queue count %d (must be 1-%d)\n",
+			   new_count, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	netdev_info(netdev, "Incrementally resizing RX queues: %d to %d\n",
+		    old_count, new_count);
+
+	if (new_count > old_count) {
+		netdev_dbg(netdev, "Scale-up: adding queues %d-%d\n",
+			   old_count, new_count - 1);
+
+		for (i = old_count; i < new_count; i++) {
+			rc = ibmveth_alloc_single_rx_queue(adapter, i,
+							   rxq_entries);
+			if (rc) {
+				netdev_err(netdev, "Failed to allocate queue %d: %d\n",
+					   i, rc);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_register_single_rx_queue(adapter, i,
+							      mac_address);
+			if (rc) {
+				netdev_err(netdev, "Failed to register queue %d: %d\n",
+					   i, rc);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_setup_single_rx_interrupt(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to setup IRQ for queue %d: %d\n",
+					   i, rc);
+				/* request_irq failed: mapped but no handler */
+				ibmveth_dispose_subordinate_irq_mapping(adapter,
+									i);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			/*
+			 * Fully ready before PHYP delivery, matching open():
+			 * publish -> replenish -> napi_enable -> enable_irq.
+			 * That way ibmveth_interrupt() cannot run on an
+			 * unpublished, empty, or NAPI-disabled queue.
+			 */
+			adapter->num_rx_queues = i + 1;
+			ibmveth_replenish_task(adapter, i);
+			napi_enable(&adapter->napi[i]);
+
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d: %d\n",
+					   i, rc);
+				adapter->num_rx_queues = i;
+				napi_disable(&adapter->napi[i]);
+				ibmveth_cleanup_single_rx_interrupt(adapter, i);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+		}
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			goto cleanup_new_queues;
+		}
+	} else {
+		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
+			   new_count, old_count - 1);
+
+		/*
+		 * Mask PHYP delivery before napi_disable/drain. Otherwise
+		 * ibmveth_interrupt returns IRQ_HANDLED without masking when
+		 * NAPI is disabled, and the HV can storm during drain.
+		 */
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		for (i = new_count; i < old_count; i++)
+			napi_disable(&adapter->napi[i]);
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_drain_rx_queue(adapter, i);
+
+		synchronize_net();
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			for (i = new_count; i < old_count; i++) {
+				ibmveth_replenish_task(adapter, i);
+				napi_enable(&adapter->napi[i]);
+				ibmveth_enable_irq(adapter, i);
+			}
+			return rc;
+		}
+
+		adapter->num_rx_queues = new_count;
+
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_cleanup_single_rx_interrupt(adapter, i);
+			ibmveth_deregister_single_rx_queue(adapter, i);
+			ibmveth_free_single_rx_queue(adapter, i);
+		}
+	}
+
+	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
+		    adapter->num_rx_queues);
+
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+
+	return 0;
+
+cleanup_new_queues:
+	failed_queue = i;
+	netdev_err(netdev,
+		   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
+		   failed_queue, old_count, failed_queue - 1);
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	synchronize_net();
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_cleanup_single_rx_interrupt(adapter, i);
+		ibmveth_deregister_single_rx_queue(adapter, i);
+		ibmveth_free_single_rx_queue(adapter, i);
+	}
+	adapter->num_rx_queues = old_count;
+	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
+		    old_count);
+	return rc;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -2217,12 +2670,62 @@ static void ibmveth_get_channels(struct net_device *netdev,
 	channels->rx_count = adapter->num_rx_queues;
 }
 
+/**
+ * ibmveth_resize_rx_channels - Validate and apply a new RX queue count
+ * @adapter: ibmveth adapter structure
+ * @goal_rx: desired RX queue count
+ *
+ * When the interface is up, resize live queues via
+ * ibmveth_resize_rx_queues_incremental(). When down, only stash
+ * adapter->num_rx_queues for the next open().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
+				      unsigned int goal_rx)
+{
+	struct net_device *netdev = adapter->netdev;
+	unsigned int old_rx = adapter->num_rx_queues;
+	int rxq_entries;
+	int rc;
+
+	if (goal_rx > 1 && !adapter->multi_queue) {
+		netdev_err(netdev,
+			   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
+			   goal_rx);
+		return -EOPNOTSUPP;
+	}
+
+	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
+		netdev_err(netdev,
+			   "Invalid RX queue count %u (must be 1-%d)\n",
+			   goal_rx, IBMVETH_MAX_RX_QUEUES);
+		return -EINVAL;
+	}
+
+	if (goal_rx == old_rx)
+		return 0;
+
+	if (!(netdev->flags & IFF_UP)) {
+		adapter->num_rx_queues = goal_rx;
+		return 0;
+	}
+
+	rxq_entries = adapter->rx_queue[0].num_slots;
+	rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
+						  rxq_entries);
+	if (rc)
+		netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
+	return rc;
+}
+
 static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
+	unsigned int goal_rx = channels->rx_count;
 	int rc, i;
 
 	/* If ndo_open has not been called yet then don't allocate, just set
@@ -2231,6 +2734,13 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	if (!(netdev->flags & IFF_UP))
 		return netif_set_real_num_tx_queues(netdev, goal);
 
+	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
+	 * in this patch. !IFF_UP RX stash ordering lands next.
+	 */
+	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
+	if (rc)
+		return rc;
+
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
@@ -2245,7 +2755,6 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		if (!rc)
 			continue;
 
-		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
 		goal = old;
@@ -2259,7 +2768,6 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		goal = old;
 		old = i;
 	}
-	/* Free any that are no longer needed */
 	for (i = old; i > goal; i--) {
 		if (adapter->tx_ltb_ptr[i - 1])
 			ibmveth_free_tx_ltb(adapter, i - 1);
-- 
2.50.1 (Apple Git-155)


