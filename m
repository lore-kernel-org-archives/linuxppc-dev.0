Return-Path: <linuxppc-dev+bounces-25148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99FDC55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6ql23PJz2ymg;
	Fri, 31 Jul 2026 10:48:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458883;
	cv=none; b=JZegqlMvcSDinZI4N82f8IMvfVMkZCz+4RR0uv8B+5F0fEs7dyXvlaqZHdBynKdbbRUl6olwcEGd5LvI931s4tem8s0wc8kgHcg+NHG7GJPmYbRDJCpub+p9ACDsVLZtPZQodZ/hTIif/YVJo6px4FpH7w9Zw47YhFZxR8a9Aa/kyXfLb5qcMPPCNFkdyH0DIEUHUPlBa3Q+7Va13P++NSniItuH9ZHPTJts627Ym/6U+it9PVdeR33F/OFKjxl3ZUdG/DLrqp93K/XK2hXJ5Bz5mm1Va7wgicSWu7qRLvCsesizmZE+EVjfovnddTeV97TASXsEWAIYxPDtTPS0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458883; c=relaxed/relaxed;
	bh=0jBU+/xgbIIC7YrVhCIKn3AHBukryXjnYaozHIKvmOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+kPm1dc9ow9qklFdRQ4uCBSzzHXsSJY3OLKUicP/4rXZjkFW/Ch9tetNFsHOa9xRW6k4mNa/GfR4L2NQ26s4EVtSBRgw6e/pvKAdcnTQsdCqSS0qixdsvh5zNKYw3oZ/PgCackK/CNoEWhk7NvAQ510IN0EA6osiqh2i+xB07cw8P48HqdIJsQV75IbwTVayxV3wsg0c08ueLHyfVg8jl9F0gEcFXyqXqCiA5DssUnrt8I0jU+6nDafROloQvYaSGvtqFGYsjvaCMkkf1zr33lNFLCAPkO/AlSdSPORoUoodYtlNsS5tHd7cLejqCiulZqAItlkzOfUpofYBPoYKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E5/DodhD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E5/DodhD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6qk2RnRz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:48:02 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHeu3184584;
	Fri, 31 Jul 2026 00:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0jBU+/xgbIIC7YrVh
	CIKn3AHBukryXjnYaozHIKvmOc=; b=E5/DodhDHxUVCa6SMlriTlemnw5ACBflr
	UoDBdJVw43/084RV2Qism4FwTQh50oWJlHNIzONcVDZHbR3mZVqE75FTGWn6c/07
	oBer8KqFId39j3/yz98nNyLv2rbHS5wADr38KwjZ71NeyvDbA3iz4dFOR9YPbwYP
	teDqaO/dRLFs4Dgy38n1Ka5EoNtSsxdWVhpucILlWwYo+OVknVxjdKNvsLdHd7jU
	oNaUC7n/TO8qfc+9sxiZhEy8OMPdVJDUCGLErbm9PI7NV+7Xw52z5FmCBTgdI+t5
	ODBbySyIqEBCJMD2RpPrx9OdgeOfMxuxq5B+w0tHdFIKM1ZStmmPQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7tkbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fLiK007461;
	Fri, 31 Jul 2026 00:47:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkdv03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lCYA1966688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CCF258058;
	Fri, 31 Jul 2026 00:47:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18ABC58057;
	Fri, 31 Jul 2026 00:47:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:48 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 03/14] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Thu, 30 Jul 2026 17:47:06 -0700
Message-Id: <984697bdc91a3c37f5f24750d7f24fc2d97031fa.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: wBQWB2L4C2lVT0ObYHWpjcP3j_D7NONe
X-Proofpoint-ORIG-GUID: 3uc2ztXwLYfumOpYSiB8xKibJkzC3zka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX7I3qbANPUL5P
 Xpwb+4qS5Uh42apLtpn1jp+VAQjNz6s42CATDyc8FNrMI+F21lRsn8G8C7mJ4L/t5DB2yrPUGnl
 GGldcU7PqD7S1IHjBFYrmHG3zJ4haHPPAr6/ThG8GxjvvOoY/xlYT4NbZQTWAp9+H5ut7kkvROj
 7XIjJGBEXpHR9yH/DB5Gyge0ND9F8dY0IHVZ/MOsEnG8DY4j5oFgjOaIbBd3GW3zy11qwBxAG4I
 UhAfwZJ95a1LQ45PGgzbRxU73K7pcCBHxs6AjJ1qh5h3uzEiwz8HtnNB6rZk1tErr1ZHU5N2dLL
 Vr7LbyVaACPOgjD8T+bvF0/TU6i3D524sqvobBuTRtrFPwFjcJGBzZEuFFaS6t4XgqXJ6+rn1V+
 QUiA9NjrWX4sPr3yWVl43oDqqznTnBEYY5ZHfco08FBL6IwoOf6YZenwyP5E3rCUXqqE2Oy+h/L
 J4+TsAvOmMdQMJ/PRQw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bf0b8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KtG_EaNFNuEweZuq3VEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX6Tgse6vGDyrj
 nxBl7V+SnDZaBewA83MrqLhfwFXUspWkcTmQdYi5OY7t/n20oE4iNg5AG7IjIRuKTzUYNeSCgAF
 wkI2XlV21RS+c2W34nhga5na9ioP7jc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310003

ibmveth_open() allocates the filter list and every RX queue inline.
That is already a long sequence and would get uglier once we loop over
num_rx_queues, especially on error unwind.

Pull the RX bits into helpers and wire them into open()/close() in the
same patch:

  ibmveth_alloc_filter_list() / ibmveth_free_filter_list()
    - shared multicast filter list (one per adapter, not per queue)

  ibmveth_alloc_rx_queues() / ibmveth_cleanup_rx_resources()
    - per-queue buffer lists and RX rings, looping [0, num_rx_queues)

alloc_rx_queues() rolls back on failure so open() does not need nested
goto chains for every queue index. open-failure and close release the
same resources through the same helpers.

Runtime behavior stays single-queue (num_rx_queues is still 1). Buffer
pools, IRQ, TX LTB, and PHYP registration remain inline for later
helper patches.

Also set rc = -ENOMEM before the TX LTB allocation loop so a failed
ibmveth_allocate_tx_ltb() still returns a useful errno after the RX
allocation blocks move into helpers.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Introduce RX/filter allocation helpers in the same patch that wires
  their first open/close callers; v3 left unused statics ahead of the
  old open/close pipeline patch.
- Preserve correct -ENOMEM return on TX LTB allocation failure after
  the RX helper extract.
- Drop reliance on v3's separate "open/close pipeline" patch for this
  wiring.

 drivers/net/ethernet/ibm/ibmveth.c | 268 ++++++++++++++++++++---------
 1 file changed, 190 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 8e758362cb26..1007dd95cde0 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -151,6 +151,184 @@ static unsigned int ibmveth_real_max_tx_queues(void)
 	return min(n_cpu, IBMVETH_MAX_QUEUES);
 }
 
+/**
+ * ibmveth_alloc_filter_list - Allocate and map filter list
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
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
+static void
+ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
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
+static int
+ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
+{
+	struct device *dev = &adapter->vdev->dev;
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		adapter->buffer_list_addr[i] =
+			(void *)get_zeroed_page(GFP_KERNEL);
+		if (!adapter->buffer_list_addr[i]) {
+			netdev_err(netdev,
+				   "unable to allocate buffer list for queue %d\n",
+				   i);
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
+			netdev_err(netdev,
+				   "unable to allocate RX queue for queue %d\n",
+				   i);
+			goto err_cleanup;
+		}
+
+		adapter->buffer_list_dma[i] =
+			dma_map_single(dev, adapter->buffer_list_addr[i],
+				       4096, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
+			netdev_err(netdev,
+				   "unable to map buffer list for queue %d\n",
+				   i);
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
+static void
+ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
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
@@ -627,74 +805,34 @@ static int ibmveth_open(struct net_device *netdev)
 	int rc;
 	union ibmveth_buf_desc rxq_desc;
 	int i;
-	struct device *dev;
 
 	netdev_dbg(netdev, "open starting\n");
 
 	napi_enable(&adapter->napi[0]);
 
-	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[0][i].size;
 
-	rc = -ENOMEM;
-	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!adapter->buffer_list_addr[0]) {
-		netdev_err(netdev, "unable to allocate list pages\n");
+	rc = ibmveth_alloc_filter_list(adapter);
+	if (rc)
 		goto out;
-	}
 
-	adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
-	if (!adapter->filter_list_addr) {
-		netdev_err(netdev, "unable to allocate filter pages\n");
-		goto out_free_buffer_list;
-	}
-
-	dev = &adapter->vdev->dev;
-
-	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
-						rxq_entries;
-	adapter->rx_queue[0].queue_addr =
-		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
-				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
-	if (!adapter->rx_queue[0].queue_addr)
+	rc = ibmveth_alloc_rx_queues(adapter, rxq_entries);
+	if (rc)
 		goto out_free_filter_list;
 
-	adapter->buffer_list_dma[0] =
-		dma_map_single(dev, adapter->buffer_list_addr[0],
-			       4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
-		netdev_err(netdev, "unable to map buffer list pages\n");
-		goto out_free_queue_mem;
-	}
-
-	adapter->filter_list_dma = dma_map_single(dev,
-			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
-		netdev_err(netdev, "unable to map filter list pages\n");
-		goto out_unmap_buffer_list;
-	}
-
+	rc = -ENOMEM;
 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		if (ibmveth_allocate_tx_ltb(adapter, i))
 			goto out_free_tx_ltb;
 	}
 
-	adapter->rx_queue[0].index = 0;
-	adapter->rx_queue[0].num_slots = rxq_entries;
-	adapter->rx_queue[0].toggle = 1;
-
 	mac_address = ether_addr_to_u64(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 					adapter->rx_queue[0].queue_len;
 	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
 
-	netdev_dbg(netdev, "buffer list @ 0x%p\n",
-		   adapter->buffer_list_addr[0]);
-	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
-	netdev_dbg(netdev, "receive q   @ 0x%p\n",
-		   adapter->rx_queue[0].queue_addr);
-
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
 	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
@@ -709,7 +847,7 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_unmap_filter_list;
+		goto out_free_tx_ltb;
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
@@ -736,8 +874,6 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_buffer_pools;
 	}
 
-	rc = -ENOMEM;
-
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_interrupt(netdev->irq, netdev);
 
@@ -753,26 +889,12 @@ static int ibmveth_open(struct net_device *netdev)
 			ibmveth_free_buffer_pool(adapter,
 						 &adapter->rx_buff_pool[0][i]);
 	}
-out_unmap_filter_list:
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-
 out_free_tx_ltb:
-	while (--i >= 0) {
+	while (--i >= 0)
 		ibmveth_free_tx_ltb(adapter, i);
-	}
-
-out_unmap_buffer_list:
-	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
-			 DMA_BIDIRECTIONAL);
-out_free_queue_mem:
-	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
-			  adapter->rx_queue[0].queue_addr,
-			  adapter->rx_queue[0].queue_dma);
+	ibmveth_cleanup_rx_resources(adapter);
 out_free_filter_list:
-	free_page((unsigned long)adapter->filter_list_addr);
-out_free_buffer_list:
-	free_page((unsigned long)adapter->buffer_list_addr[0]);
+	ibmveth_free_filter_list(adapter);
 out:
 	napi_disable(&adapter->napi[0]);
 	return rc;
@@ -781,7 +903,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	struct device *dev = &adapter->vdev->dev;
 	long lpar_rc;
 	int i;
 
@@ -806,17 +927,8 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
-	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
-			 DMA_BIDIRECTIONAL);
-	free_page((unsigned long)adapter->buffer_list_addr[0]);
-
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-	free_page((unsigned long)adapter->filter_list_addr);
-
-	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
-			  adapter->rx_queue[0].queue_addr,
-			  adapter->rx_queue[0].queue_dma);
+	ibmveth_cleanup_rx_resources(adapter);
+	ibmveth_free_filter_list(adapter);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		if (adapter->rx_buff_pool[0][i].active)
-- 
2.50.1 (Apple Git-155)


