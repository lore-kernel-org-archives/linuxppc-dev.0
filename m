Return-Path: <linuxppc-dev+bounces-25852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B2C5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLvH756Y3z2ysb;
	Fri, 14 Aug 2026 17:38:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786693123;
	cv=none; b=fEbXsrjTNHSMPtQ/C/JgszFmSwCcNhE0g4zQcRFTyB9z61qZqNZLKIX5xYXr1v7eC15Wf4xjwN1CrXNEcd5pNyb5PO2X/1Qq0nIoleSDJGlLUvPDO7vb4yxYhWwF96KT36q1bfcyM3tgi0Huut2yZMpl1qF3npqQx1eIdvIWwebJhsgqgOhJ3Zc+HWA/KDJequAOKt6H0qMKZ3YWJEyuVjb5eENutfRTGJEvKiMqvQ6OjpG0DRdBOUu/NGPg4ulYoSOMLz/qjHCEJeveOkL9nyJjd4G8Ow234lNXDPgmRuoam8dS0l5+7ELoin1C/k00CLbg8n/KLLLQ9hlQlh27Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786693123; c=relaxed/relaxed;
	bh=ApXzzvtC6do/rNpyFseDCbjUgbZ5//MXN9qYFBTfsxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+eIdHrfZVmzzlftt/UYc5GsR7zENmrygbGhpG1ojCiQlT8ycRDoTRw+OINOMjod9BZ+FZnwtqMT9+0JPpZX3yA2l3x7PVq95+6khpo0rA6GDzlIEepFSkx218oopU3Fy4nk7OFLCUZRvmiGQ+uY/iVIyUrxRJUUle5lXBBN9c4pGIqAlNf7wK48yBGuQP1f5LhRFF1/nnS8pIL6e500hUkB4It242YCcJECBEOEx42EQtUDT7XCTpzKw1mXA2VLOtLUbW+NZjj3PARfa/dLeuM8BKAfidbbr0BWxQf3K8hrX15iw24119kKRzHpI6saKJIVbES4MCbM2a/DceEc5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G8jUDimK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G8jUDimK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvH627Zmz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:38:42 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VVmk154626;
	Fri, 14 Aug 2026 07:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ApXzzv
	tC6do/rNpyFseDCbjUgbZ5//MXN9qYFBTfsxU=; b=G8jUDimK5B/af0Cz7h1j6Y
	q0lukn94ji1eM1D2nq7jaZJVQVN2fVl7jzdJyg5SlXnSip6B7x8cGOXUfrx6TK8S
	YykIDlopGlXXon70ebSaYb3QDJrh1TMsjKDWGa06r83pZwcdjxkIwcqZWCOXnylq
	RYNf9illWVLp0praIYF27Nv9kruC2+zEELtc4WemO8TFSm5dlkIa42tsc6ZPRG1n
	rqs8/BHCyl2pkWVql3DboNlhNrLW9I19i1g6NyEmvLfHSKnFAjGonK1co6WpzczP
	Si9alr+N5VCQjboM4H7n+BYP7OhmPe2IPv0JqgrorxHwxLopA3xS3gdl6o69bGhA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma3tu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QHVZ016926;
	Fri, 14 Aug 2026 07:38:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gp9ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cRQw3277478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACA3F5805D;
	Fri, 14 Aug 2026 07:38:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D9858057;
	Fri, 14 Aug 2026 07:38:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:25 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 14/15] ibmveth: Implement incremental MQ RX queue resize
Date: Fri, 14 Aug 2026 00:36:41 -0700
Message-Id: <20260814073642.24630-15-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXzqvNZp7KjVR7
 0LAk8amjyZRk5+vff1wTySz0FkZyvBBhvxVMbb0Naex3/x8DPNTtsOQm1jGHDUZNn7Gid6tHN9P
 /Xv0iR8el3MHlgtNXIihDHvUy+U68i05fzZ6hEsBdSxNtzUBcZ+DVMJ07rqxAMtmKI6CV/YkQWj
 NhL0qt9ZyYJTrLch4Tmsy0GfewKTGF5R5GnrGDixP8mSgcaaT5xQTPHSeYdpBzq6PoivjsBKlzB
 jY8/DkCoGsFViIG+Y1uIVKH5NormXL4JWjngZnRRb21Z3F/+Re8jZV+UXYftB7MjRPdCbaM2L+5
 4bdzvJ/g86XBLmgShfdtr9ORfC/2skWFF6bsKlzghcDEKDFl3AnztjQeKcd6v+seRt5gZxVMzk0
 RRWN8Jpykl1XijiABS8chQzyj5Z6AMnuTjWLjtJzEHDIRkWrBRhWPQdHNApCERvxSkYkc3kalA1
 /81j7Pp5iHGMoGvTvNA==
X-Proofpoint-ORIG-GUID: f59tsOkKwXyM0El2x7wbyB6MTan-stah
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX2w4gg8NHY+4X
 ebem9qajnoEUBKDqGkH8ekpZ9lY56oEzEGIIpFZIa8I9jNe7fOIpKieBTrpty6f4c1mjqrbzH31
 bB7ueRkLJSxkGUq/kGK9BvaurhPKhoo=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ec5f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=9GrW9DZCARAA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=QwGy5dlU2FbJ-0SXaZwA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
X-Proofpoint-GUID: fw-v_ShKYMYzHxCrB8ztZHsNYbXoVOSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Teardown first on ethtool -L scale-down: drain and deregister/destroy
queues being removed before unmapping their buffer pools. Freeing pool
state while stale correlators can still complete was the hang root
cause; poll-path skip helpers alone cannot paper over that ownership
hole.

Strengthen correlator liveness (active pool + non-NULL backing arrays)
and clear freed pool metadata so torn-down pools no longer look
in-range. Restore schedule_work escalation for truly impossible
correlators.

Also implement incremental scale-up/down helpers, WRITE_ONCE
num_rx_queues publication, rollback/CMO updates, and related resize
error paths.

After enable_irq on scale-up (and scale-down rollback unmask), kick
NAPI if the RXQ already has pending work. After successful scale-down
destroy, restart remaining queues so Q0 cannot stay masked with NAPI
idle.

On scale-up, raise CMO desired for the target RX queue count via
ibmveth_desired_dma_for_rxqs() before dma_map / alloc / replenish.

ibmveth_resize_rx_channels() rejects rx > 1 without MQ firmware
(-EOPNOTSUPP) and validates rx_count within 1..IBMVETH_MAX_RX_QUEUES
(-EINVAL). The set_channels wiring patch consumes this helper.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- resize / get_desired_dma read live count via get_num_rx_queues()
- Scale-down / scale-up-fail: remask+sync after napi_disable (poll may
  re-arm while disable waits)
- Series renumber: mailed v4 12/14 resize -> tip P14 (14->15)
- Absorb kitchen-sink resize ownership: teardown-first scale-down
  (drain/deregister before unmap) + live-pool correlator_valid /
  schedule_work (cover has peel map)
- Ordered num_rx_queues publish + publish-before-destroy
- After unmask: kick if pending; enable_irq errno + rollback check;
  raise CMO before scale-up allocs
- Scale-up enable_irq-fail: publish-down / napi_disable / drain / destroy
- After scale-down destroy, restart remaining RX queues so Q0 cannot stay
  masked with NAPI idle
- resize_rx_channels: reject rx>1 without MQ / validate 1..MAX; call
  before !opened early return (stash still tip P15)

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

 drivers/net/ethernet/ibm/ibmveth.c | 682 +++++++++++++++++++++++++++--
 1 file changed, 646 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 1b58a3c6ce77..84f4a0deb0c5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -696,6 +696,58 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
 	adapter->rx_irq_setup = false;
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
@@ -1380,6 +1432,141 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
 		   ibmveth_get_num_rx_queues(adapter));
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
 static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
 					 int queue_index, u64 correlator)
 {
@@ -1542,6 +1729,56 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
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
+			/* -EINVAL/-EFAULT already advanced past the slot. */
+			if (rc == -EINVAL || rc == -EFAULT) {
+				drained++;
+				continue;
+			}
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
@@ -1797,6 +2034,356 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
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
+ * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
+ * @adapter: ibmveth adapter structure
+ * @queue_idx: Queue index to destroy (1..N)
+ *
+ * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
+ * ownership is released while queue metadata is still valid.
+ */
+static void
+ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
+				     int queue_idx)
+{
+	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
+	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
+	ibmveth_free_single_rx_queue(adapter, queue_idx);
+}
+
+/**
+ * ibmveth_desired_dma_for_rxqs - CMO entitlement for a given RX queue count
+ * @adapter: ibmveth adapter
+ * @rxqs: number of RX queues to size for
+ *
+ * Same math as ibmveth_get_desired_dma(), but uses @rxqs instead of the
+ * live adapter->num_rx_queues. Scale-up raises desired for the *target*
+ * count before allocating so vio_cmo_alloc cannot fail mid-resize.
+ *
+ * Return: bytes of IO memory desired for @rxqs RX queues
+ */
+static unsigned long
+ibmveth_desired_dma_for_rxqs(struct ibmveth_adapter *adapter,
+			     unsigned int rxqs)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct iommu_table *tbl;
+	unsigned long ret;
+	int i, q;
+
+	tbl = get_iommu_table_base(&adapter->vdev->dev);
+
+	ret = IBMVETH_BUFF_LIST_SIZE * rxqs + IBMVETH_FILT_LIST_SIZE;
+	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
+	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
+
+	/*
+	 * Pool metadata for queues 1+ is copied from queue 0 at open.
+	 * Always size from pool 0 x @rxqs (valid at probe before that copy).
+	 */
+	for (q = 0; q < rxqs; q++) {
+		int rxqentries = 1;
+
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *bpool =
+				&adapter->rx_buff_pool[0][i];
+
+			if (bpool->active)
+				ret += bpool->size *
+					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
+			rxqentries += bpool->size;
+		}
+
+		ret += IOMMU_PAGE_ALIGN(rxqentries *
+					sizeof(struct ibmveth_rx_q_entry), tbl);
+	}
+
+	return ret;
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
+	int old_count = ibmveth_get_num_rx_queues(adapter);
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
+		/*
+		 * Raise CMO desired for the target count before dma_map /
+		 * dma_alloc_coherent / replenish (same order as change_mtu).
+		 * Do not bump live num_rx_queues here — only entitlement.
+		 */
+		if (firmware_has_feature(FW_FEATURE_CMO)) {
+			unsigned long dma;
+
+			dma = ibmveth_desired_dma_for_rxqs(adapter, new_count);
+			vio_cmo_set_dev_desired(adapter->vdev, dma);
+		}
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
+			rc = ibmveth_register_single_rx_queue(adapter, i);
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
+			ibmveth_publish_num_rx_queues(adapter, i + 1);
+			ibmveth_replenish_task(adapter, i);
+			napi_enable(&adapter->napi[i]);
+
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d: %d\n",
+					   i, rc);
+				/*
+				 * Published, replenished, and NAPI-enabled,
+				 * but PHYP never unmasked. Match scale-down /
+				 * shared cleanup: drain posted buffers, then
+				 * deregister before unmap via
+				 * destroy_subordinate.
+				 */
+				ibmveth_publish_num_rx_queues(adapter, i);
+				napi_disable(&adapter->napi[i]);
+				ibmveth_drain_rx_queue(adapter, i);
+				synchronize_net();
+				ibmveth_destroy_subordinate_rx_queue(adapter,
+								     i);
+				/* enable_irq returns errno; keep -EIO. */
+				rc = -EIO;
+				goto cleanup_new_queues;
+			}
+			ibmveth_kick_rx_queue_if_pending(adapter, i);
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
+		 * Mask PHYP before napi_disable so the handler cannot miss
+		 * a mask while NAPI is already dead. An in-flight poll can
+		 * still re-arm PHYP while napi_disable() waits, so remask
+		 * and sync again after NAPI is stopped. Then drain and drop
+		 * the live count before freeing so netpoll cannot walk dying
+		 * queues (handler may still be registered until destroy).
+		 */
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		for (i = new_count; i < old_count; i++)
+			napi_disable(&adapter->napi[i]);
+
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
+		}
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_drain_rx_queue(adapter, i);
+
+		synchronize_net();
+
+		ibmveth_publish_num_rx_queues(adapter, new_count);
+
+		rc = netif_set_real_num_rx_queues(netdev, new_count);
+		if (rc) {
+			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
+				   new_count, rc);
+			ibmveth_publish_num_rx_queues(adapter, old_count);
+			for (i = new_count; i < old_count; i++) {
+				int irq_rc;
+
+				ibmveth_replenish_task(adapter, i);
+				/* START: NAPI before PHYP unmask. */
+				napi_enable(&adapter->napi[i]);
+				irq_rc = ibmveth_enable_irq(adapter, i);
+				if (irq_rc) {
+					netdev_err(netdev,
+						   "Failed to re-enable IRQ for queue %d during scale-down rollback (rc=%d), scheduling reset\n",
+						   i, irq_rc);
+					schedule_work(&adapter->work);
+					continue;
+				}
+				ibmveth_kick_rx_queue_if_pending(adapter, i);
+			}
+			return rc;
+		}
+
+		for (i = new_count; i < old_count; i++)
+			ibmveth_destroy_subordinate_rx_queue(adapter, i);
+
+		/* Q0 (and any still-live queues) were not in the teardown
+		 * loop. Scale-down can leave Q0 masked with NAPI idle — kick
+		 * so ARP/RX does not die until rmmod (lab: -L rx 1).
+		 */
+		for (i = 0; i < new_count; i++)
+			ibmveth_restart_rx_queue(adapter, i);
+	}
+
+	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
+		    ibmveth_get_num_rx_queues(adapter));
+
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+
+	return 0;
+
+cleanup_new_queues:
+	failed_queue = i;
+	if (failed_queue > old_count)
+		netdev_err(netdev,
+			   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
+			   failed_queue, old_count, failed_queue - 1);
+	else
+		netdev_err(netdev,
+			   "Scale-up failed at queue %d, nothing to clean up\n",
+			   failed_queue);
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++)
+		napi_disable(&adapter->napi[i]);
+
+	/* Same remask as scale-down: poll may have re-armed during disable. */
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	synchronize_net();
+
+	/* Drop the live count before freeing the half-added queues. */
+	ibmveth_publish_num_rx_queues(adapter, old_count);
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_destroy_subordinate_rx_queue(adapter, i);
+
+	/* Roll CMO desired back to the surviving queue count. */
+	if (firmware_has_feature(FW_FEATURE_CMO))
+		vio_cmo_set_dev_desired(adapter->vdev,
+					ibmveth_get_desired_dma(adapter->vdev));
+
+	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
+		    old_count);
+	return rc;
+}
+
 /**
  * ibmveth_free_all_queues - Free all RX queues at once
  * @adapter: ibmveth adapter structure
@@ -2535,6 +3122,55 @@ static void ibmveth_get_channels(struct net_device *netdev,
 	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
 }
 
+/**
+ * ibmveth_resize_rx_channels - Validate and apply a new RX queue count
+ * @adapter: ibmveth adapter
+ * @goal_rx: requested RX queue count
+ *
+ * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
+ * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). When RX resources are not live
+ * (!opened), only validate — the caller stashes the desired count.
+ * When up, apply via ibmveth_resize_rx_queues_incremental().
+ *
+ * Return: 0 or negative errno
+ */
+static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
+				      unsigned int goal_rx)
+{
+	struct net_device *netdev = adapter->netdev;
+	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
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
+	/* Down / failed-open: caller stashes. Do not allocate here. */
+	if (!adapter->opened)
+		return 0;
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
@@ -2543,10 +3179,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;
 
-	/* If ndo_open has not been called yet then don't allocate, just set
-	 * desired netdev_queue's and return
+	/* Validate RX (and resize when opened) before the down-path early
+	 * return so MQ/range errors are not deferred to the wiring patch.
+	 * RX stash + CMO while down still lands with that patch.
 	 */
-	if (!(netdev->flags & IFF_UP))
+	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	if (rc)
+		return rc;
+
+	if (!adapter->opened)
 		return netif_set_real_num_tx_queues(netdev, goal);
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
@@ -3281,8 +3922,6 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 	struct net_device *netdev = dev_get_drvdata(&vdev->dev);
 	struct ibmveth_adapter *adapter;
 	struct iommu_table *tbl;
-	unsigned long ret;
-	int i, q;
 
 	tbl = get_iommu_table_base(&vdev->dev);
 
@@ -3291,38 +3930,9 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 		return IOMMU_PAGE_ALIGN(IBMVETH_IO_ENTITLEMENT_DEFAULT, tbl);
 
 	adapter = netdev_priv(netdev);
+	return ibmveth_desired_dma_for_rxqs(adapter,
+					    ibmveth_get_num_rx_queues(adapter));
 
-	/* One buffer list page per RX queue; filter list is shared. */
-	ret = IBMVETH_BUFF_LIST_SIZE * ibmveth_get_num_rx_queues(adapter) +
-	      IBMVETH_FILT_LIST_SIZE;
-	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
-	/* add size of mapped tx buffers */
-	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
-
-	/*
-	 * Pool metadata for queues 1+ is copied from queue 0 at open.
-	 * Always size from pool 0 x num_rx_queues (valid at probe before that
-	 * copy).
-	 */
-	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
-		int rxqentries = 1;
-
-		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-			struct ibmveth_buff_pool *bpool =
-				&adapter->rx_buff_pool[0][i];
-
-			if (bpool->active)
-				ret += bpool->size *
-					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
-			rxqentries += bpool->size;
-		}
-
-		/* add the size of the receive queue entries */
-		ret += IOMMU_PAGE_ALIGN(rxqentries *
-					sizeof(struct ibmveth_rx_q_entry), tbl);
-	}
-
-	return ret;
 }
 
 static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
-- 
2.50.1 (Apple Git-155)


