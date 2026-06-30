Return-Path: <linuxppc-dev+bounces-23215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE0FC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:55:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4h1Glvz3cPN;
	Wed, 01 Jul 2026 00:54:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831268;
	cv=none; b=Vs9h/n4ArdEqxUgTxabCqC5Kxr/sktFkGRLePgxjCk+9hNI2sxJxC7CCr701gd/j4Fl9VgHUz0JQsaAeOegIPr4jWbnTciezfdaHirKdv3yCl/ntXHdf5GSwJOUrXBmqwS+rxT0RH4svnrb6cn+fTXsgQSVuO0IzpxRHp58LQ4too7mOaiuUo0vxWV4dr6Bz2YmYBZzxjioIomLmctRLjUBHD6kjIrNEYs0oN1YAGb9xgoBmk3uFFtz0j8xkyUyL7HCasMFcV2Gi3Sr6v37MPNSfFtLwerI73GBiOCozSnBCYg9bgOGjK1VY8u8Ksf64RShINK7E7iiWhl12UYJPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831268; c=relaxed/relaxed;
	bh=eth5XrNWWBh4tENkmfKvSNGeeLnYMF2x3/+7Xl0TsYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0ome5innKB+uvitslbj5H9p+x+tv8pE7va2mTXrpljz75JWXHGfqrL4NnjVVGwTgGD3XXGFNixUzjUCmImpd4cMKMYuALrMbDq8un1ucnW+OCFDeL1T4XzmFqWkjbajStncTyAp4Gf0bJN+b03hYl7tKih5zpEK9YI9Qw/udwvYtpfUykASGr0xZljEVKPAh8Nrnh5FzlTOWj3tOWNs95wUlW6cX1pl4kIAIKjIw+2kSlvOA1pUz5hZ3rH7Uf+qffSAGLOwMmnC5P7as24fJUV8Tshx0I1aRQSlZUShd/FuQbS7ev+kFkoyGrS2k82ooIAyFYgahlDP0bIi8JFAFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GFXfOUZu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GFXfOUZu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR4f6lSQz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:54:26 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIRb52171487;
	Tue, 30 Jun 2026 14:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eth5XrNWWBh4tENkm
	fKvSNGeeLnYMF2x3/+7Xl0TsYk=; b=GFXfOUZu/Hoy19eUmg1wq/TLe5igcwiJR
	wp0rlXVCxso7GcPFG+1mtdb4NvBu0u4dfEvl5YqutJuBXqM9zmymVhQMBBnH3oRu
	tkWICx3M2MqvO/JkkT089bHJoAs4Nl+rKIpsdUdTivAKrXB1EyApL/73Hz8Dmhzx
	ftc4V0hhCmnIT3j580Bf6mlNb6LwWz0EPdMZHf9zEpznHZbwikdz2MfM4taK7JEA
	MNBWECnr8hqqt1qYMHNZE6EoAnhpq0Fk7z8cqqENv6Lc05C85B7jmRWcoJi9vOS0
	HCOzLh6GJNokMBP9TBX82jwDIYml/t9yalOxOi/dWML89QUXHHkuQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9y5bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnqTG025898;
	Tue, 30 Jun 2026 14:54:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gaku5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:54:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UEsDw534079362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:54:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9D155805A;
	Tue, 30 Jun 2026 14:54:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E11E5805D;
	Tue, 30 Jun 2026 14:54:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:54:12 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 16/18] ibmveth: Implement incremental MQ RX queue resize
Date: Tue, 30 Jun 2026 07:53:23 -0700
Message-Id: <f2aa676604b63b7e2c4797da911e9bc8dc2e83ab.1782758799.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX/5mv07b53fb1
 lKtfoxOWdI6s8iI3otUtjFpMUVgy/Xo121SAmmzj8nBjFBQndqP+fAhpS/MqwfD/yNpfJRrSUU5
 QizwR7T2kGBJ9kQuzb2GZKwO860SYfgN0fDHkgj15f/qjyL+NdAE5muRZtUVIC0dE0p7ekF+9vW
 Z3+4XnnLpBcMs7tbr9ltUqea4LhjZ/ujLEOhj2n42oboN91xlYxRiyg6DI8sokuey3fiNw3yIpI
 QPCQXXl9O5+3E5ZTCaA5S6IDFz7Kwk9NvjjIZ/dSd2IO+I5w0sahftYMVEucfdhewQUubSjmGJa
 eb+XzAO4ByZ3zgfVK8xCS61DefARCT2bYUQ+hxqelYCnGmhD1PeqlDBy5yEa91H7wxdgsvXE8XW
 nvzSmrUe2aHSwRgt1mJ10UXPF4g3/DS99JHjQVr07RprxuXbTkVzjumA5fev+XZk0acErl30BHR
 th2oqHmk389r+iPHtlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX5SkQuhCfGZC1
 Aj9sDy638oXZrgIZfnwjgDwTk5/J+ciHdaZlph+Y+eDj5n34vfWK/jboYli2eZz+xCY6zJyvJ/c
 IrcXj5IJwvbXSixvZWM5GnIJRZAo+rg=
X-Proofpoint-GUID: QvBD2HiIMFNXtVuMOQPXz5jBBI5CrObc
X-Proofpoint-ORIG-GUID: ih4IrxeHx9hx8a3AWX_mRaavV7LeOBSg
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a43d898 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=l_etWYYMc1M-NAxKRdsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300139

Add ibmveth_resize_rx_queues_incremental() to grow or shrink
adapter->num_rx_queues while the netdev stays up.

Scale-up, per new queue index:
  alloc RX resources and per-queue pools
  register subordinate queue with PHYP
  request_irq(), then ibmveth_enable_irq(), then napi_enable
  update num_rx_queues, replenish new queues
  netif_set_real_num_rx_queues()

Scale-down disables NAPI on excess queues, drains pending buffers,
disables PHYP IRQ delivery and waits for in-flight handlers with
synchronize_irq() before lowering num_rx_queues, then tears down
IRQ/PHYP/memory.

Reject out-of-range new_count. On scale-down netif failure, re-enable
NAPI on queues not yet torn down. Refresh VIO CMO entitlement after a
successful resize when FW_FEATURE_CMO is enabled.

Scale-up rollback mirrors scale-down: drain posted buffers and wait for
in-flight handlers before deregistering with PHYP.

In replenish_task(), skip queues with queue_index >= num_rx_queues and
require pool->free_map before replenishing so in-flight handlers avoid
queues being torn down without clearing probe-time pool->active on free.

Queue 0 is never removed here. Scale-up failure unwinds only queues
added in this call. ethtool -L wiring is next.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 183 ++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cd0acd1715da..ac4d89a66a8d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -945,18 +945,22 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
 	unsigned long flags;
 	int i;
 
-	if (queue_index >= adapter->num_rx_queues)
-		return;
-
 	adapter->replenish_task_cycles++;
 
+	if (queue_index >= adapter->num_rx_queues) {
+		netdev_dbg(adapter->netdev,
+			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
+			   queue_index, adapter->num_rx_queues);
+		return;
+	}
+
 	spin_lock_irqsave(&rxq->replenish_lock, flags);
 
 	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
 		struct ibmveth_buff_pool *pool =
 			&adapter->rx_buff_pool[queue_index][i];
 
-		if (pool->active &&
+		if (pool->active && pool->free_map &&
 		    (atomic_read(&pool->available) < pool->threshold))
 			ibmveth_replenish_buffer_pool(adapter, pool,
 						      queue_index);
@@ -1682,7 +1686,7 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
  * the IRQ mapping for subordinate queues. Queue 0 is freed only through
  * ibmveth_free_all_queues() (H_FREE_LOGICAL_LAN).
  */
-static void __maybe_unused
+static void
 ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
 				   int queue_idx)
 {
@@ -1714,6 +1718,175 @@ ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
 	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
 }
 
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
+			rc = ibmveth_alloc_single_rx_queue(adapter, i, rxq_entries);
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
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			rc = ibmveth_enable_irq(adapter, i);
+			if (rc) {
+				netdev_err(netdev,
+					   "Failed to enable IRQ for queue %d: %d\n",
+					   i, rc);
+				ibmveth_cleanup_single_rx_interrupt(adapter, i);
+				ibmveth_deregister_single_rx_queue(adapter, i);
+				ibmveth_free_single_rx_queue(adapter, i);
+				goto cleanup_new_queues;
+			}
+
+			napi_enable(&adapter->napi[i]);
+		}
+
+		adapter->num_rx_queues = new_count;
+
+		for (i = old_count; i < new_count; i++)
+			ibmveth_replenish_task(adapter, i);
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
+			for (i = new_count; i < old_count; i++)
+				napi_enable(&adapter->napi[i]);
+			return rc;
+		}
+
+		/* Disable hypervisor interrupts and wait for handlers to complete
+		 * before updating num_rx_queues.
+		 */
+		for (i = new_count; i < old_count; i++) {
+			ibmveth_disable_irq(adapter, i);
+			synchronize_irq(adapter->queue_irq[i]);
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
+	for (i = old_count; i < failed_queue; i++)
+		napi_disable(&adapter->napi[i]);
+
+	for (i = old_count; i < failed_queue; i++)
+		ibmveth_drain_rx_queue(adapter, i);
+
+	synchronize_net();
+
+	for (i = old_count; i < failed_queue; i++) {
+		ibmveth_disable_irq(adapter, i);
+		synchronize_irq(adapter->queue_irq[i]);
+	}
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
-- 
2.39.3 (Apple Git-146)


