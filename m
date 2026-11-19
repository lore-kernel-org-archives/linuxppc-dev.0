Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5A606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qmhPS2+W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVJgt4WP2z2yd7;
	Thu, 19 Nov 2026 11:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046858;
	cv=none; b=ouWmooWP+QOm/i6nPmVWbilY62syrbq1Vf21gGYuDA6m+btUQ3VpDCD6NLqCpzZAGS9YOxx1i8/duxFNX4IE2C6YDgd4IeeqGNrMDsIvYekHYyPpIQmrfY7bsYTpi2/4eOT66L7F80aSGHUH+Ti8XaCAemNphm2hKeNtemqKFHxijLwMmJGMw6cZQ6Rrdhf5NTlYshPoa46p6pqQi6uZWsX03Veohfsnctxx7g+8FeOgCDy4h005LJwXv/JcQ7sw6k46AXj5nbRiVbDDaoe6LzPxKgLigoswqmzUeaAK63JI5hU/9XgUkiGsLmi4GyyO+wZvk+UuSDTMNV3f3o4VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046858; c=relaxed/relaxed;
	bh=KVd+O4nv43sMPr8jZ90f8rs9OBOtfbP9MEWLkP9rNnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuDkGhTpbp20VvEgm4vH4HjgWhHdAK0H3gdiKw4mck0uQNrQXUZTXe1uO7xnlfuF06R1hPTi+NfLFEFTod4gN4LpKxKDTKaRyiC4AR1axg0OOG0pAyPuR3hCHvBao4dIRaQSx0RjFpo6KED9oawJENuGjjMSksdT6tuQ/IiDVo6dCh1waRJzITKubEL9p+bf8Rh2fuMjI/i6Wjc4Yt8i5MfsDmjK2KPFT18mmdvFotvwtztGM1iniUhVRAzT3C24xpLz2MNHW1FtIL/rogunpJOEvNUM7ntTu5d6i+shws44+6RCKiVz6/nx4Xn5W4TyBD/iWKm7vJm9SQ2YjgKwfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qmhPS2+W; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qmhPS2+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJgs3xXcz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:37 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILQZsL2211934;
	Thu, 19 Nov 2026 00:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KVd+O4nv43sMPr8jZ
	90f8rs9OBOtfbP9MEWLkP9rNnc=; b=qmhPS2+WJnjpg5cZiDkEciyx3/nlAu4uy
	McOhZgJULaK2iPy4vEz9V5Eag2F93H00VlSt58crlHhedJdw5nCGPVtTEZEFvuqL
	GTnSz1FUQ9QnTK1ELJTdRCRvhjD6CdBnFc0oMSKEYZAfqW9VlnfMJPyFWrkNWGjk
	eWwRwWcr9cTjMXOnuYSXB0Fl1uP52OYAsZ8fpHORCOvMTT/qEuCFiqpB9apvmdF5
	OgfdbX68GHTI9at9BVvmOLoBVi9e9HjN1DJb8xXocvZQl0UdOr2R2TAI0VqPeBBG
	oSAiUCrybBDEl3+5FKAPh1Rjx6gc7q3rwYPe1r/0GUHvNPC36AiLQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t59n0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AILK4LW2586971;
	Thu, 19 Nov 2026 00:07:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4u35x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 00:07:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ07Oag42467830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 00:07:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE2158051;
	Thu, 19 Nov 2026 00:07:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE5915805C;
	Thu, 19 Nov 2026 00:07:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.93.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 00:07:21 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, horms@kernel.org,
        davemarq@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next 2/8] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Wed, 18 Nov 2026 16:07:05 -0800
Message-Id: <20261119000711.18093-3-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119000711.18093-1-mmc@linux.ibm.com>
References: <20261119000711.18093-1-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afe3dc0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZYrRbp3Ve24Jq68nBkUA:9
X-Proofpoint-ORIG-GUID: HHPvqNQjqN60e6y_DK_lFBr2RZ8kro3U
X-Proofpoint-GUID: ACP_IUl4xUce7CVEUvRoNaKUP2KnmeWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX26uZWyXibcz/
 DQAPONJctFVil8i0OMLViu8XRzj3SuN6juRQQWH75BF9gjfB763UHdmZtIBexdMeqXR/moKc5hZ
 ly2TqMtH9k9mX44r3n8c9aVOu9syUj9YcR1iXxIzvJMUaoFMgD9uAt4TdYTJnxPcTcgt2occIHy
 xJ4ldMQp+2gGdrdft418OjiM8X9wYlwSpEV9OsUFSonNCjry9WcbyF6FPh/WjRwVnPIkxqgQYCZ
 3xlukkf8j/YaFnXIWRGFYVM9wO44Jc/VVCytRTH1JezqnRYqAltkh0rcsVn74Z9x+yV+moxDMoj
 P8qFIJEPKYlgPqUPrzNB0XHt1tOcUWc0Sn3ewJphO10XApdznHgJ1PGh4Uw7pU96BZ1V/cTVjb8
 35ctvlirPmnB7vWXrGbGtUaz3A4qdM9MaAby9QyXwmUmC0fXZzSvpID5t9MvLas1AqCOuQqcCwG
 c3CPyPxMzJIcHranCPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA4OCBTYWx0ZWRfX+xuZH5Id+R0q
 FKXLjJKi1OZGM/EaMm+KXzz1U7ADcB2dxTgMUTFXE+cQB0n+M3WNW39bw2nNLA3BGX93L1g1poL
 hgULweOy+ZTQaavtrVo44GaZoBKTy28=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180088
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move filter list and RX queue allocation out of ibmveth_open() into
helpers that loop over num_rx_queues and undo their own partial
failures, so open() does not need an unwind label per queue. close()
and the open() error path free through the same helpers.

open() now allocates the filter list first and sets up the RX ring
before the TX LTBs.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 264 ++++++++++++++++++++---------
 1 file changed, 186 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index fc50036d5d26..559c4d2d957b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -159,6 +159,177 @@ static unsigned int ibmveth_real_max_tx_queues(void)
 	return min(n_cpu, IBMVETH_MAX_QUEUES);
 }
 
+/**
+ * ibmveth_alloc_filter_list - Allocate and map filter list
+ * @adapter: ibmveth adapter structure
+ *
+ * Return: 0 on success, -ENOMEM on failure
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
+		/* Do not leave DMA_MAPPING_ERROR in the adapter. */
+		adapter->filter_list_dma = 0;
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
+	/* Unmap by CPU pointer: SPAPR can return DMA address 0. */
+	if (adapter->filter_list_addr) {
+		dma_unmap_single(dev, adapter->filter_list_dma, 4096,
+				 DMA_BIDIRECTIONAL);
+		adapter->filter_list_dma = 0;
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
+ * Return: 0 on success, -ENOMEM on failure
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
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
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
+			free_page((unsigned long)adapter->buffer_list_addr[i]);
+			adapter->buffer_list_addr[i] = NULL;
+			adapter->buffer_list_dma[i] = 0;
+			goto err_cleanup;
+		}
+
+		adapter->rx_queue[i].index = 0;
+		adapter->rx_queue[i].num_slots = rxq_entries;
+		adapter->rx_queue[i].toggle = 1;
+	}
+
+	return 0;
+
+err_cleanup:
+	/* Queue i may be partly set up: queue_addr can be live without
+	 * a buffer list.
+	 */
+	for (; i >= 0; i--) {
+		if (adapter->buffer_list_addr[i]) {
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
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->buffer_list_addr[i]) {
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
@@ -398,8 +569,9 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
  */
 static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 {
-	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
+	__be64 *p;
 
+	p = adapter->buffer_list_addr[0] + 4096 - 8;
 	adapter->rx_no_buffer = be64_to_cpup(p);
 }
 
@@ -672,72 +844,32 @@ static int ibmveth_open(struct net_device *netdev)
 	int rc;
 	union ibmveth_buf_desc rxq_desc;
 	int i;
-	struct device *dev;
 
 	netdev_dbg(netdev, "open starting\n");
 
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
-			goto out_unmap_filter_list;
+			goto out_free_tx_ltb;
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
@@ -752,7 +884,7 @@ static int ibmveth_open(struct net_device *netdev)
 				     rxq_desc.desc,
 				     mac_address);
 		rc = -ENONET;
-		goto out_unmap_filter_list;
+		goto out_free_tx_ltb;
 	}
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
@@ -784,8 +916,6 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_buffer_pools;
 	}
 
-	rc = -ENOMEM;
-
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_interrupt(netdev->irq, netdev);
 
@@ -805,24 +935,12 @@ static int ibmveth_open(struct net_device *netdev)
 			ibmveth_free_buffer_pool(adapter,
 						 &adapter->rx_buff_pool[0][i]);
 	}
-out_unmap_filter_list:
-	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
-			 DMA_BIDIRECTIONAL);
-
+out_free_tx_ltb:
 	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
 		ibmveth_free_tx_ltb(adapter, i);
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
 	return rc;
 }
@@ -830,7 +948,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	struct device *dev = &adapter->vdev->dev;
 	long lpar_rc;
 	int i;
 
@@ -868,17 +985,8 @@ static int ibmveth_close(struct net_device *netdev)
 
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


