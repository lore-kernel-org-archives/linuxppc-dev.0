Return-Path: <linuxppc-dev+bounces-23201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20337C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:54:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR4109k0z2ynn;
	Wed, 01 Jul 2026 00:53:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831232;
	cv=none; b=Tt3yeuRfDJeOUL7sSrWf9NmGxr8QCVBkoaqyTMbeWGJhubKdqJRJtUHYr6t2mn4uIT9XnPrFix0PKNqEeN9yQ/TbHt9GhiAm7gx5C+wne7F1smaR+sbbgFQeJIA3D1zoqT8KxlPYK2OuJ3aiR0ZAlZ0ARBulhsUdyNGFUogVEfVgj3Q4CZI3P1+LAQBQc/BmCYtr9j3qt+qMjJnJtJgMeCtb06SspYc7wXkFCmZVX4d3jvoudFwVpQkopcjUvGUpcF8qC9mV8tRYsZSig2RKRkryH735L5Lj1Ou5nKabX+JrtvV6wyUu/EjUDd2Y/w4gxr7ajDQiZjukq1db2DQVog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831232; c=relaxed/relaxed;
	bh=OnqM6fNdRO65uIFoKph49sXombDNctxewWIey7krbuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SowID42metg5nKaPDk7JNC8U2+IRUMGcCdcr62p6Z1ox7kvgjU2sz+ANE37qEhIqAiQczr9KZGjSHzBveooU4OIKi9amDNqm/X9vsFtGP1aurK6Op4Hc8DyvyYRLq6HGCRTy07kPkqF3kCLRD/90Cpu7IQ2oZJcDGwEmcT7cjBKvBmJg3OdQQoo8yEUUKRsDwcYm9RII5Ql1vjkCOPlVLEUFUB+B0VIHMx65FcTL2soQBFC+wV6CCdjM/CPUjvjIPzb7BPEhH5L9xQZ55WsdB/4QDI7DG3WsUdo7q55qKQZT947EqXwWTr0tZz9CjJgo65ILK8BipVHsRHV4oXBJyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z0e8gPpk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z0e8gPpk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR3z73gpz2ynT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:53:51 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIHEJ2428600;
	Tue, 30 Jun 2026 14:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OnqM6f
	NdRO65uIFoKph49sXombDNctxewWIey7krbuc=; b=Z0e8gPpke5Kz4ctKoJvtm/
	rNWbxJwFi9mz4+nKhjJvmPfJeJYNR7HlObmmjmIGbawamU/EUOj1FXMXiQe9lTv2
	52tzPpg+JwFGCjpcIWa+6Y22aOl7keaEQBF65BneYVR8TAueMeCSAEegUSmqrB1s
	peJEvauU0LmjS34H3OFBjJi0hHNIXNWSNtJIIwNgX23Ra90N40T1nKFq259xbu8q
	1Jua901kJPcoNx0Gukm/t1i22lxMq87k39m3Mp/pZnX2tUlGRuILR3aqbap7qR6Q
	oQZtfd5F3VnuV8zwqDX/zlYHhimFKQJD7uKRWsQKAV8+wS8SfIX6QNbVa75YTNtQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfyc9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEne49000639;
	Tue, 30 Jun 2026 14:53:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhapg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErfoi29688358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3001E5805A;
	Tue, 30 Jun 2026 14:53:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2DAD58062;
	Tue, 30 Jun 2026 14:53:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:39 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 04/18] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Tue, 30 Jun 2026 07:53:11 -0700
Message-Id: <2872c352ebdb2123a700ec6b58b6e25aede33ef2.1782758799.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43d878 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VB3T6LR5Bl6OjwfYf1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX0WDRBf7TyvCk
 BtOUcyGPeSNQQAVTgdziJ7CvO4Xccr3ZTvBn0Bx8be2ca8EGGE4Ngr0C7uMIOPQsrLc+N+6bs/Z
 Li7kdOz2Glt6j9s6DJFi2WrIaTtycJ0=
X-Proofpoint-GUID: XXdFvJE6HJ8fbl1jp4ZVmng9PDgp7tiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX9Khkv9LX9tGL
 f78eOBPAkNIkyXDi0EPtw+mat0pcWCQAI0/6c/Z7KIPIud4PAVUymWfdcrdsm6Z7dZGHxoCh30w
 aqUn2J3rGKFEwzrtInKdDj7gzKNR9TnFqcfwooZW7mpk4JreQvVtpxgWfIrmGnW/ItH3khXDfP4
 cNrT7Od8Lvv4uNDBczOmGsTWa0bzpoajO86hY1Ykm3Ux5NJvxRl5q/nAyIBhk7Ra3QpBPOFUN9f
 wRTfFoU0ofynxtGqoI7IphcvT+OnzudGKJ93YApCa6/OE1UxEEtcB9YoaELMgVYZrJ9s42IoGVJ
 odXSJRfc6tc3PEda+Na36LQyX/KegbkYrwf2XrXqtPFQehwNhebk8Uk3ieVcnc0O8PQvK3kV/bX
 M0ZT3/QLYjDzsY6jpFS+F9xNDJ37Gv5t7GbdImjsvcSZASBK8MDGy/wrobTzY9vLP2Pfxi0RSIw
 mCJNlq4c0/PM4T6uMxw==
X-Proofpoint-ORIG-GUID: Tmsnz8ghW0lKzR7dFQMLo007cP_7Udw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

ibmveth_open() allocates the filter list and every RX queue inline.
That's already ~160 lines and would get ugly once we loop over
num_rx_queues, especially on error unwind.

Pull the RX bits into helpers:

  ibmveth_alloc_filter_list() / ibmveth_free_filter_list()
    — shared multicast filter list (one per adapter, not per queue)

  ibmveth_alloc_rx_queues() / ibmveth_cleanup_rx_resources()
    — per-queue buffer lists and RX rings, looping [0, num_rx_queues)

alloc_rx_queues() rolls back on failure so open() does not need nested
goto chains for every queue index.

This is the first of several helper-only patches (pools, IRQ, TX, PHYP
registration, open/close wiring, buffer submit) that reshape bring-up
ahead of MQ datapath commit later in the series.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 168 +++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 8f9f927bff23..b8adc9935471 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -147,6 +147,174 @@ static unsigned int ibmveth_real_max_tx_queues(void)
 	return min(n_cpu, IBMVETH_MAX_QUEUES);
 }
 
+/**
+ * ibmveth_alloc_filter_list - Allocate and map filter list
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+
+	adapter->filter_list_addr = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!adapter->filter_list_addr) {
+		netdev_err(netdev, "unable to allocate filter pages\n");
+		return -ENOMEM;
+	}
+
+	adapter->filter_list_dma = dma_map_single(dev,
+						  adapter->filter_list_addr,
+						  4096, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
+		netdev_err(netdev, "unable to map filter list pages\n");
+		free_page((unsigned long)adapter->filter_list_addr);
+		adapter->filter_list_addr = NULL;
+		return -ENOMEM;
+	}
+
+	netdev_dbg(netdev, "filter list @ 0x%p (DMA: 0x%llx)\n",
+		   adapter->filter_list_addr,
+		   (unsigned long long)adapter->filter_list_dma);
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_filter_list - Free filter list resources
+ * @adapter: ibmveth adapter structure
+ */
+static void __maybe_unused ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	if (adapter->filter_list_dma) {
+		dma_unmap_single(dev, adapter->filter_list_dma, 4096,
+				 DMA_BIDIRECTIONAL);
+		adapter->filter_list_dma = 0;
+	}
+
+	if (adapter->filter_list_addr) {
+		free_page((unsigned long)adapter->filter_list_addr);
+		adapter->filter_list_addr = NULL;
+	}
+}
+
+/**
+ * ibmveth_alloc_rx_queues - Allocate per-queue RX resources
+ * @adapter: ibmveth adapter structure
+ * @rxq_entries: Number of entries per RX queue
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __maybe_unused
+ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		adapter->buffer_list_addr[i] = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!adapter->buffer_list_addr[i]) {
+			netdev_err(netdev, "unable to allocate buffer list for queue %d\n", i);
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].queue_len =
+			sizeof(struct ibmveth_rx_q_entry) * rxq_entries;
+		adapter->rx_queue[i].queue_addr =
+			dma_alloc_coherent(dev, adapter->rx_queue[i].queue_len,
+					   &adapter->rx_queue[i].queue_dma,
+					   GFP_KERNEL);
+		if (!adapter->rx_queue[i].queue_addr) {
+			netdev_err(netdev, "unable to allocate RX queue for queue %d\n", i);
+			goto err_cleanup;
+		}
+
+		adapter->buffer_list_dma[i] = dma_map_single(dev,
+							     adapter->buffer_list_addr[i],
+							     4096, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
+			netdev_err(netdev, "unable to map buffer list for queue %d\n", i);
+			adapter->buffer_list_dma[i] = 0;
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].index = 0;
+		adapter->rx_queue[i].num_slots = rxq_entries;
+		adapter->rx_queue[i].toggle = 1;
+
+		netdev_dbg(netdev, "queue %d: buffer_list @ 0x%p (DMA: 0x%llx), rx_queue @ 0x%p (DMA: 0x%llx), %llu entries\n",
+			   i, adapter->buffer_list_addr[i],
+			   (unsigned long long)adapter->buffer_list_dma[i],
+			   adapter->rx_queue[i].queue_addr,
+			   (unsigned long long)adapter->rx_queue[i].queue_dma,
+			   (unsigned long long)rxq_entries);
+	}
+
+	netdev_dbg(netdev, "allocated %d RX queue(s) with %d entries each\n",
+		   adapter->num_rx_queues, rxq_entries);
+
+	return 0;
+
+err_cleanup:
+	/* Clean up previously allocated queues */
+	for (; i >= 0; i--) {
+		if (adapter->buffer_list_dma[i]) {
+			dma_unmap_single(dev, adapter->buffer_list_dma[i],
+					 4096, DMA_BIDIRECTIONAL);
+			adapter->buffer_list_dma[i] = 0;
+		}
+		if (adapter->rx_queue[i].queue_addr) {
+			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
+					  adapter->rx_queue[i].queue_addr,
+					  adapter->rx_queue[i].queue_dma);
+			adapter->rx_queue[i].queue_addr = NULL;
+		}
+		if (adapter->buffer_list_addr[i]) {
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+		}
+	}
+
+	return -ENOMEM;
+}
+
+/**
+ * ibmveth_cleanup_rx_resources - Free all RX queue resources
+ * @adapter: ibmveth adapter structure
+ */
+static void __maybe_unused ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	int i;
+
+	netdev_dbg(adapter->netdev, "cleaning up %d RX queue(s)\n",
+		   adapter->num_rx_queues);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->buffer_list_dma[i]) {
+			dma_unmap_single(dev, adapter->buffer_list_dma[i],
+					 4096, DMA_BIDIRECTIONAL);
+			adapter->buffer_list_dma[i] = 0;
+		}
+
+		if (adapter->rx_queue[i].queue_addr) {
+			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
+					  adapter->rx_queue[i].queue_addr,
+					  adapter->rx_queue[i].queue_dma);
+			adapter->rx_queue[i].queue_addr = NULL;
+		}
+
+		if (adapter->buffer_list_addr[i]) {
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+		}
+	}
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
 				     u32 pool_index, u32 pool_size,
-- 
2.39.3 (Apple Git-146)


